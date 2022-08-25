Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E175A130D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbiHYOMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiHYOMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:12:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE2EC2F00B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:12:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 289D3ED1;
        Thu, 25 Aug 2022 07:12:17 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B18383F71A;
        Thu, 25 Aug 2022 07:12:10 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, cristian.marussi@arm.com
Subject: [PATCH v2 1/9] firmware: arm_scmi: Refactor xfer in-flight registration routines
Date:   Thu, 25 Aug 2022 15:11:44 +0100
Message-Id: <20220825141152.2334536-2-cristian.marussi@arm.com>
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

Move the whole xfer in-flight registration process out of scmi_xfer_get
and while at that, split the sequence number selection steps from the
in-flight registration procedure itself.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 102 +++++++++++++++++++----------
 1 file changed, 68 insertions(+), 34 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 609ebedee9cb..e5193da2ce09 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -311,8 +311,6 @@ static int scmi_xfer_token_set(struct scmi_xfers_info *minfo,
 	if (xfer_id != next_token)
 		atomic_add((int)(xfer_id - next_token), &transfer_last_id);
 
-	/* Set in-flight */
-	set_bit(xfer_id, minfo->xfer_alloc_table);
 	xfer->hdr.seq = (u16)xfer_id;
 
 	return 0;
@@ -330,33 +328,77 @@ static inline void scmi_xfer_token_clear(struct scmi_xfers_info *minfo,
 	clear_bit(xfer->hdr.seq, minfo->xfer_alloc_table);
 }
 
+/**
+ * scmi_xfer_inflight_register_unlocked  - Register the xfer as in-flight
+ *
+ * @xfer: The xfer to register
+ * @minfo: Pointer to Tx/Rx Message management info based on channel type
+ *
+ * Note that this helper assumes that the xfer to be registered as in-flight
+ * had been built using an xfer sequence number which still corresponds to a
+ * free slot in the xfer_alloc_table.
+ *
+ * Context: Assumes to be called with @xfer_lock already acquired.
+ */
+static inline void
+scmi_xfer_inflight_register_unlocked(struct scmi_xfer *xfer,
+				     struct scmi_xfers_info *minfo)
+{
+	/* Set in-flight */
+	set_bit(xfer->hdr.seq, minfo->xfer_alloc_table);
+	hash_add(minfo->pending_xfers, &xfer->node, xfer->hdr.seq);
+	xfer->pending = true;
+}
+
+/**
+ * scmi_xfer_pending_set  - Pick a proper sequence number and mark the xfer
+ * as pending in-flight
+ *
+ * @xfer: The xfer to act upon
+ * @minfo: Pointer to Tx/Rx Message management info based on channel type
+ *
+ * Return: 0 on Success or error otherwise
+ */
+static inline int scmi_xfer_pending_set(struct scmi_xfer *xfer,
+					struct scmi_xfers_info *minfo)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&minfo->xfer_lock, flags);
+	/* Set a new monotonic token as the xfer sequence number */
+	ret = scmi_xfer_token_set(minfo, xfer);
+	if (!ret)
+		scmi_xfer_inflight_register_unlocked(xfer, minfo);
+	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
+
+	return ret;
+}
+
 /**
  * scmi_xfer_get() - Allocate one message
  *
  * @handle: Pointer to SCMI entity handle
  * @minfo: Pointer to Tx/Rx Message management info based on channel type
- * @set_pending: If true a monotonic token is picked and the xfer is added to
- *		 the pending hash table.
  *
  * Helper function which is used by various message functions that are
  * exposed to clients of this driver for allocating a message traffic event.
  *
- * Picks an xfer from the free list @free_xfers (if any available) and, if
- * required, sets a monotonically increasing token and stores the inflight xfer
- * into the @pending_xfers hashtable for later retrieval.
+ * Picks an xfer from the free list @free_xfers (if any available) and perform
+ * a basic initialization.
+ *
+ * Note that, at this point, still no sequence number is assigned to the
+ * allocated xfer, nor it is registered as a pending transaction.
  *
  * The successfully initialized xfer is refcounted.
  *
- * Context: Holds @xfer_lock while manipulating @xfer_alloc_table and
- *	    @free_xfers.
+ * Context: Holds @xfer_lock while manipulating @free_xfers.
  *
- * Return: 0 if all went fine, else corresponding error.
+ * Return: An initialized xfer if all went fine, else pointer error.
  */
 static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
-				       struct scmi_xfers_info *minfo,
-				       bool set_pending)
+				       struct scmi_xfers_info *minfo)
 {
-	int ret;
 	unsigned long flags;
 	struct scmi_xfer *xfer;
 
@@ -376,25 +418,8 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
 	 */
 	xfer->transfer_id = atomic_inc_return(&transfer_last_id);
 
-	if (set_pending) {
-		/* Pick and set monotonic token */
-		ret = scmi_xfer_token_set(minfo, xfer);
-		if (!ret) {
-			hash_add(minfo->pending_xfers, &xfer->node,
-				 xfer->hdr.seq);
-			xfer->pending = true;
-		} else {
-			dev_err(handle->dev,
-				"Failed to get monotonic token %d\n", ret);
-			hlist_add_head(&xfer->node, &minfo->free_xfers);
-			xfer = ERR_PTR(ret);
-		}
-	}
-
-	if (!IS_ERR(xfer)) {
-		refcount_set(&xfer->users, 1);
-		atomic_set(&xfer->busy, SCMI_XFER_FREE);
-	}
+	refcount_set(&xfer->users, 1);
+	atomic_set(&xfer->busy, SCMI_XFER_FREE);
 	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 
 	return xfer;
@@ -652,7 +677,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 	ktime_t ts;
 
 	ts = ktime_get_boottime();
-	xfer = scmi_xfer_get(cinfo->handle, minfo, false);
+	xfer = scmi_xfer_get(cinfo->handle, minfo);
 	if (IS_ERR(xfer)) {
 		dev_err(dev, "failed to get free message slot (%ld)\n",
 			PTR_ERR(xfer));
@@ -1041,13 +1066,22 @@ static int xfer_get_init(const struct scmi_protocol_handle *ph,
 	    tx_size > info->desc->max_msg_size)
 		return -ERANGE;
 
-	xfer = scmi_xfer_get(pi->handle, minfo, true);
+	xfer = scmi_xfer_get(pi->handle, minfo);
 	if (IS_ERR(xfer)) {
 		ret = PTR_ERR(xfer);
 		dev_err(dev, "failed to get free message slot(%d)\n", ret);
 		return ret;
 	}
 
+	/* Pick a sequence number and register this xfer as in-flight */
+	ret = scmi_xfer_pending_set(xfer, minfo);
+	if (ret) {
+		dev_err(pi->handle->dev,
+			"Failed to get monotonic token %d\n", ret);
+		__scmi_xfer_put(minfo, xfer);
+		return ret;
+	}
+
 	xfer->tx.len = tx_size;
 	xfer->rx.len = rx_size ? : info->desc->max_msg_size;
 	xfer->hdr.type = MSG_TYPE_COMMAND;
-- 
2.32.0

