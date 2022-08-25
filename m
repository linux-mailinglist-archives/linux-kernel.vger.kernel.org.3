Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B464D5A1313
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbiHYOM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbiHYOMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:12:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F087D62A90
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:12:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CBDD15DB;
        Thu, 25 Aug 2022 07:12:23 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E60503F71A;
        Thu, 25 Aug 2022 07:12:16 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, cristian.marussi@arm.com
Subject: [PATCH v2 4/9] firmware: arm_scmi: Add xfer raw helpers
Date:   Thu, 25 Aug 2022 15:11:47 +0100
Message-Id: <20220825141152.2334536-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220825141152.2334536-1-cristian.marussi@arm.com>
References: <20220825141152.2334536-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few SCMI helpers useful to implement SCMI Raw access support.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
- added scmi_xfer_raw_channel_get
---
 drivers/firmware/arm_scmi/common.h |   9 +++
 drivers/firmware/arm_scmi/driver.c | 101 +++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 096b66442d84..6d2a57a696d8 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -212,6 +212,15 @@ struct scmi_desc {
 	const bool atomic_enabled;
 };
 
+void scmi_xfer_raw_put(const struct scmi_handle *handle,
+		       struct scmi_xfer *xfer);
+struct scmi_xfer *scmi_xfer_raw_get(const struct scmi_handle *handle);
+struct scmi_chan_info *
+scmi_xfer_raw_channel_get(const struct scmi_handle *handle, u8 protocol_id);
+
+int scmi_xfer_raw_inflight_register(const struct scmi_handle *handle,
+				    struct scmi_xfer *xfer);
+
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
 extern const struct scmi_desc scmi_mailbox_desc;
 #endif
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 56b1a917f618..a49d9eaa1c09 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -350,6 +350,53 @@ scmi_xfer_inflight_register_unlocked(struct scmi_xfer *xfer,
 	xfer->pending = true;
 }
 
+/**
+ * scmi_xfer_inflight_register  - Try to register an xfer as in-flight
+ *
+ * @xfer: The xfer to register
+ * @minfo: Pointer to Tx/Rx Message management info based on channel type
+ *
+ * Note that this helper does NOT assume anything about the sequence number
+ * that was baked into the provided xfer, so it checks at first if it can
+ * be mapped to a free slot and fails with an error if another xfer with the
+ * same sequence number is currently still registered as in-flight.
+ *
+ * Return: 0 on Success or -EBUSY if sequence number embedded in the xfer
+ *	   could not rbe mapped to a free slot in the xfer_alloc_table.
+ */
+static int scmi_xfer_inflight_register(struct scmi_xfer *xfer,
+				       struct scmi_xfers_info *minfo)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&minfo->xfer_lock, flags);
+	if (!test_bit(xfer->hdr.seq, minfo->xfer_alloc_table))
+		scmi_xfer_inflight_register_unlocked(xfer, minfo);
+	else
+		ret = -EBUSY;
+	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
+
+	return ret;
+}
+
+/**
+ * scmi_xfer_raw_inflight_register  - An helper to register the given xfer as in
+ * flight on the TX channe, if possible.
+ *
+ * @handle: Pointer to SCMI entity handle
+ * @xfer: The xfer to register
+ *
+ * Return: 0 on Success, error otherwise
+ */
+int scmi_xfer_raw_inflight_register(const struct scmi_handle *handle,
+				    struct scmi_xfer *xfer)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	return scmi_xfer_inflight_register(xfer, &info->tx_minfo);
+}
+
 /**
  * scmi_xfer_pending_set  - Pick a proper sequence number and mark the xfer
  * as pending in-flight
@@ -425,6 +472,44 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
 	return xfer;
 }
 
+/**
+ * scmi_xfer_raw_get  - Helper to get a bare free xfer from the TX channel
+ *
+ * @handle: Pointer to SCMI entity handle
+ *
+ * Note that xfer is taken from the TX channel structures.
+ *
+ * Return: A valid xfer on Success, or an error-pointer otherwise
+ */
+struct scmi_xfer *scmi_xfer_raw_get(const struct scmi_handle *handle)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	return scmi_xfer_get(handle, &info->tx_minfo);
+}
+
+/**
+ * scmi_xfer_raw_channel_get  - Helper to get a reference to the proper channel
+ * to use for a specific protocol_id Raw transaction.
+ *
+ * @handle: Pointer to SCMI entity handle
+ * @protocol_id: Identifier of the protocol
+ *
+ * Return: A reference to the channel to use, or an ERR_PTR
+ */
+struct scmi_chan_info *
+scmi_xfer_raw_channel_get(const struct scmi_handle *handle, u8 protocol_id)
+{
+	struct scmi_chan_info *cinfo;
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	cinfo = idr_find(&info->tx_idr, protocol_id);
+	if (unlikely(!cinfo))
+		return ERR_PTR(-EINVAL);
+
+	return cinfo;
+}
+
 /**
  * __scmi_xfer_put() - Release a message
  *
@@ -453,6 +538,22 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 }
 
+/**
+ * scmi_xfer_raw_put  - Release an xfer that was taken by @scmi_xfer_raw_get
+ *
+ * @handle: Pointer to SCMI entity handle
+ * @xfer: A reference to the xfer to put
+ *
+ * Note that as with other xfer_put() handlers the xfer is really effectively
+ * released only if there are no more users on the system.
+ */
+void scmi_xfer_raw_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	return __scmi_xfer_put(&info->tx_minfo, xfer);
+}
+
 /**
  * scmi_xfer_lookup_unlocked  -  Helper to lookup an xfer_id
  *
-- 
2.32.0

