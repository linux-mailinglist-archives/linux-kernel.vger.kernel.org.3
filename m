Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D964EC7CA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347991AbiC3PI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347909AbiC3PId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 604AF9D4FD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFBA323A;
        Wed, 30 Mar 2022 08:06:44 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EB123F73B;
        Wed, 30 Mar 2022 08:06:43 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 10/22] firmware: arm_scmi: Introduce a common SCMIv3.1 .extended_name_get helper
Date:   Wed, 30 Mar 2022 16:05:39 +0100
Message-Id: <20220330150551.2573938-11-cristian.marussi@arm.com>
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

Introduce a new set of common protocol operations bound to the protocol
handle structure so that can be invoked by the protocol implementation code
even when protocols are built as distinct loadable kernel module without
the need of exporting new symbols, like already done with scmi_xfer_ops.

Add at first, as new common protocol helper, an .extended_name_get helper
which will ease implementation and will avoid code duplication when adding
new SCMIv3.1 per-protocol _NAME_GET commands.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c    | 50 +++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h | 15 ++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8e07bee16c8e..44aa13f3cb76 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1102,6 +1102,55 @@ static const struct scmi_xfer_ops xfer_ops = {
 	.xfer_put = xfer_put,
 };
 
+struct scmi_msg_resp_domain_name_get {
+	__le32 flags;
+	u8 name[SCMI_MAX_STR_SIZE];
+};
+
+/**
+ * scmi_common_extended_name_get  - Common helper to get extended resources name
+ * @ph: A protocol handle reference.
+ * @cmd_id: The specific command ID to use.
+ * @res_id: The specific resource ID to use.
+ * @name: A pointer to the preallocated area where the retrieved name will be
+ *	  stored as a NULL terminated string.
+ * @len: The len in bytes of the @name char array.
+ *
+ * Return: 0 on Succcess
+ */
+static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
+					 u8 cmd_id, u32 res_id, char *name,
+					 size_t len)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_resp_domain_name_get *resp;
+
+	ret = ph->xops->xfer_get_init(ph, cmd_id, sizeof(res_id),
+				      sizeof(*resp), &t);
+	if (ret)
+		goto out;
+
+	put_unaligned_le32(res_id, t->tx.buf);
+	resp = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		strscpy(name, resp->name, len);
+
+	ph->xops->xfer_put(ph, t);
+out:
+	if (ret)
+		dev_warn(ph->dev,
+			 "Failed to get extended name - id:%u (ret:%d). Using %s\n",
+			 res_id, ret, name);
+	return ret;
+}
+
+static const struct scmi_proto_helpers_ops helpers_ops = {
+	.extended_name_get = scmi_common_extended_name_get,
+};
+
 /**
  * scmi_revision_area_get  - Retrieve version memory area.
  *
@@ -1162,6 +1211,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 	pi->handle = handle;
 	pi->ph.dev = handle->dev;
 	pi->ph.xops = &xfer_ops;
+	pi->ph.hops = &helpers_ops;
 	pi->ph.set_priv = scmi_set_protocol_priv;
 	pi->ph.get_priv = scmi_get_protocol_priv;
 	refcount_set(&pi->users, 1);
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index b2a92d2b2986..5461fa333152 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -141,6 +141,7 @@ struct scmi_xfer {
 };
 
 struct scmi_xfer_ops;
+struct scmi_proto_helpers_ops;
 
 /**
  * struct scmi_protocol_handle  - Reference to an initialized protocol instance
@@ -165,10 +166,24 @@ struct scmi_xfer_ops;
 struct scmi_protocol_handle {
 	struct device *dev;
 	const struct scmi_xfer_ops *xops;
+	const struct scmi_proto_helpers_ops *hops;
 	int (*set_priv)(const struct scmi_protocol_handle *ph, void *priv);
 	void *(*get_priv)(const struct scmi_protocol_handle *ph);
 };
 
+/**
+ * struct scmi_proto_helpers_ops  - References to common protocol helpers
+ * @extended_name_get: A common helper function to retrieve extended naming
+ *		       for the specified resource using the specified command.
+ *		       Result is returned as a NULL terminated string in the
+ *		       pre-allocated area pointed to by @name with maximum
+ *		       capacity of @len bytes.
+ */
+struct scmi_proto_helpers_ops {
+	int (*extended_name_get)(const struct scmi_protocol_handle *ph,
+				 u8 cmd_id, u32 res_id, char *name, size_t len);
+};
+
 /**
  * struct scmi_xfer_ops  - References to the core SCMI xfer operations.
  * @version_get: Get this version protocol.
-- 
2.32.0

