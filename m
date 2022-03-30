Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4503D4EC7D4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348024AbiC3PJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347894AbiC3PIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE5C09BBB6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87B1823A;
        Wed, 30 Mar 2022 08:06:49 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 391FF3F73B;
        Wed, 30 Mar 2022 08:06:48 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 13/22] firmware: arm_scmi: Add iterators for multi-part commands
Date:   Wed, 30 Mar 2022 16:05:42 +0100
Message-Id: <20220330150551.2573938-14-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220330150551.2573938-1-cristian.marussi@arm.com>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI specification defines some commands as optionally issued over multiple
messages in order to overcome possible limitations in payload size enforced
by the configured underlyinng transport.

Introduce some common protocol helpers to provide a unified solution for
issuing such SCMI multi-part commands.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c    | 109 ++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |  54 +++++++++++++
 2 files changed, 163 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 44aa13f3cb76..454b8ff75100 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1147,8 +1147,117 @@ static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+/**
+ * struct scmi_iterator  - Iterator descriptor
+ * @msg: A reference to the message TX buffer; filled by @prepare_message with
+ *	 a proper custom command payload for each multi-part command request.
+ * @resp: A reference to the response RX buffer; used by @update_state and
+ *	  @process_response to parse the multi-part replies.
+ * @t: A reference to the underlying xfer initialized and used transparently by
+ *     the iterator internal routines.
+ * @ph: A reference to the associated protocol handle to be used.
+ * @ops: A reference to the custom provided iterator operations.
+ * @state: The current iterator state; used and updated in turn by the iterators
+ *	   internal routines and by the caller-provided @scmi_iterator_ops.
+ * @priv: A reference to optional private data as provided by the caller and
+ *	  passed back to the @@scmi_iterator_ops.
+ */
+struct scmi_iterator {
+	void *msg;
+	void *resp;
+	struct scmi_xfer *t;
+	const struct scmi_protocol_handle *ph;
+	struct scmi_iterator_ops *ops;
+	struct scmi_iterator_state state;
+	void *priv;
+};
+
+static void *scmi_iterator_init(const struct scmi_protocol_handle *ph,
+				struct scmi_iterator_ops *ops,
+				unsigned int max_resources, u8 msg_id,
+				size_t tx_size, void *priv)
+{
+	int ret;
+	struct scmi_iterator *i;
+
+	i = devm_kzalloc(ph->dev, sizeof(*i), GFP_KERNEL);
+	if (!i)
+		return ERR_PTR(-ENOMEM);
+
+	i->ph = ph;
+	i->ops = ops;
+	i->priv = priv;
+
+	ret = ph->xops->xfer_get_init(ph, msg_id, tx_size, 0, &i->t);
+	if (ret) {
+		devm_kfree(ph->dev, i);
+		return ERR_PTR(ret);
+	}
+
+	i->state.max_resources = max_resources;
+	i->msg = i->t->tx.buf;
+	i->resp = i->t->rx.buf;
+
+	return i;
+}
+
+static int scmi_iterator_run(void *iter)
+{
+	int ret = -EINVAL;
+	struct scmi_iterator *i = iter;
+	struct scmi_iterator_state *st = &i->state;
+	struct scmi_iterator_ops *iops = i->ops;
+	const struct scmi_protocol_handle *ph = i->ph;
+	const struct scmi_xfer_ops *xops = ph->xops;
+
+	if (!i)
+		return ret;
+
+	do {
+		iops->prepare_message(i->msg, st->desc_index, i->priv);
+		ret = xops->do_xfer(ph, i->t);
+		if (ret)
+			break;
+
+		ret = iops->update_state(st, i->resp, i->priv);
+		if (ret)
+			break;
+
+		if (st->num_returned > st->max_resources - st->desc_index) {
+			dev_err(ph->dev,
+				"No. of resources can't exceed %d\n",
+				st->max_resources);
+			ret = -EINVAL;
+			break;
+		}
+
+		for (st->loop_idx = 0; st->loop_idx < st->num_returned;
+		     st->loop_idx++) {
+			ret = iops->process_response(ph, i->resp, st, i->priv);
+			if (ret)
+				goto out;
+		}
+
+		st->desc_index += st->num_returned;
+		xops->reset_rx_to_maxsz(ph, i->t);
+		/*
+		 * check for both returned and remaining to avoid infinite
+		 * loop due to buggy firmware
+		 */
+	} while (st->num_returned && st->num_remaining);
+
+out:
+	/* Finalize and destroy iterator */
+	xops->xfer_put(ph, i->t);
+	devm_kfree(ph->dev, i);
+
+	return ret;
+}
+
 static const struct scmi_proto_helpers_ops helpers_ops = {
 	.extended_name_get = scmi_common_extended_name_get,
+	.iter_response_init = scmi_iterator_init,
+	.iter_response_run = scmi_iterator_run,
 };
 
 /**
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 60ea880b3855..73304af5ec4a 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -173,6 +173,47 @@ struct scmi_protocol_handle {
 	void *(*get_priv)(const struct scmi_protocol_handle *ph);
 };
 
+/**
+ * struct scmi_iterator_state  - Iterator current state descriptor
+ * @desc_index: Starting index for the current mulit-part request.
+ * @num_returned: Number of returned items in the last multi-part reply.
+ * @num_remaining: Number of remaining items in the multi-part message.
+ * @max_resources: Maximum acceptable number of items, configured by the caller
+ *		   depending on the underlying resources that it is querying.
+ * @loop_idx: The iterator loop index in the current multi-part reply.
+ * @priv: Optional pointer to some additional state-related private data setup
+ *	  by the caller during the iterations.
+ */
+struct scmi_iterator_state {
+	unsigned int desc_index;
+	unsigned int num_returned;
+	unsigned int num_remaining;
+	unsigned int max_resources;
+	unsigned int loop_idx;
+	void *priv;
+};
+
+/**
+ * struct scmi_iterator_ops  - Custom iterator operations
+ * @prepare_message: An operation to provide the custom logic to fill in the
+ *		     SCMI command request pointed by @message. @desc_index is
+ *		     a reference to the next index to use in the multi-part
+ *		     request.
+ * @update_state: An operation to provide the custom logic to update the
+ *		  iterator state from the actual message response.
+ * @process_response: An operation to provide the custom logic needed to process
+ *		      each chunk of the multi-part message.
+ */
+struct scmi_iterator_ops {
+	void (*prepare_message)(void *message, unsigned int desc_index,
+				const void *priv);
+	int (*update_state)(struct scmi_iterator_state *st,
+			    const void *response, void *priv);
+	int (*process_response)(const struct scmi_protocol_handle *ph,
+				const void *response,
+				struct scmi_iterator_state *st, void *priv);
+};
+
 /**
  * struct scmi_proto_helpers_ops  - References to common protocol helpers
  * @extended_name_get: A common helper function to retrieve extended naming
@@ -180,10 +221,23 @@ struct scmi_protocol_handle {
  *		       Result is returned as a NULL terminated string in the
  *		       pre-allocated area pointed to by @name with maximum
  *		       capacity of @len bytes.
+ * @iter_response_init: A common helper to initialize a generic iterator to
+ *			parse multi-message responses: when run the iterator
+ *			will take care to send the initial command request as
+ *			specified by @msg_id and @tx_size and then to parse the
+ *			multi-part responses using the custom operations
+ *			provided in @ops.
+ * @iter_response_run: A common helper to trigger the run of a previously
+ *		       initialized iterator.
  */
 struct scmi_proto_helpers_ops {
 	int (*extended_name_get)(const struct scmi_protocol_handle *ph,
 				 u8 cmd_id, u32 res_id, char *name, size_t len);
+	void *(*iter_response_init)(const struct scmi_protocol_handle *ph,
+				    struct scmi_iterator_ops *ops,
+				    unsigned int max_resources, u8 msg_id,
+				    size_t tx_size, void *priv);
+	int (*iter_response_run)(void *iter);
 };
 
 /**
-- 
2.32.0

