Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78DC462029
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351627AbhK2TTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:19:55 -0500
Received: from foss.arm.com ([217.140.110.172]:45642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351361AbhK2TRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:17:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3389D1477;
        Mon, 29 Nov 2021 11:12:45 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E83D3F5A1;
        Mon, 29 Nov 2021 11:12:43 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 08/16] firmware: arm_scmi: Add sync_cmds_atomic_replies transport flag
Date:   Mon, 29 Nov 2021 19:11:48 +0000
Message-Id: <20211129191156.29322-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211129191156.29322-1-cristian.marussi@arm.com>
References: <20211129191156.29322-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag to let the transport signal to the core if its handling of sync
command implies that, after .send_message has returned successfully, the
requested command can be assumed to be fully and completely executed on
SCMI platform side so that any possible response value is already
immediately available to be retrieved by a .fetch_response: in other words
the polling phase can be skipped in such a case and the response values
accessed straight away.

Note that all of the above applies only when polling mode of operation was
selected by the core: if instead a completion IRQ was found to be available
the normal response processing path based on completions will still be
followed.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v5 --> v6
- added polling_capable helper flag
v4 --> v5
- removed RFC tag
- consider sync_cmds_atomic_replies flag when deciding if polling is to be
  supported and .poll_done() is not provided.
- reviewed commit message
---
 drivers/firmware/arm_scmi/common.h |  8 ++++++
 drivers/firmware/arm_scmi/driver.c | 43 +++++++++++++++++++++++-------
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 99b74f4d39b6..bf25f0e89c78 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -412,6 +412,13 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  * @max_msg_size: Maximum size of data per message that can be handled.
  * @force_polling: Flag to force this whole transport to use SCMI core polling
  *		   mechanism instead of completion interrupts even if available.
+ * @sync_cmds_atomic_replies: Flag to indicate that the transport assures
+ *			      synchronous-command messages are atomically
+ *			      completed on .send_message: no need to poll
+ *			      actively waiting for a response.
+ *			      Used by core internally only when polling is
+ *			      selected as a waiting for reply method: i.e.
+ *			      if a completion irq was found use that anyway.
  */
 struct scmi_desc {
 	int (*transport_init)(void);
@@ -421,6 +428,7 @@ struct scmi_desc {
 	int max_msg;
 	int max_msg_size;
 	const bool force_polling;
+	const bool sync_cmds_atomic_replies;
 };
 
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8a30b832899c..8c04632f3ba3 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -134,6 +134,8 @@ struct scmi_protocol_instance {
  * @notify_priv: Pointer to private data structure specific to notifications.
  * @node: List head
  * @users: Number of users of this instance
+ * @polling_capable: A flag to annotate if the underlying transport can operate
+ *		     in polling mode.
  */
 struct scmi_info {
 	struct device *dev;
@@ -152,6 +154,7 @@ struct scmi_info {
 	void *notify_priv;
 	struct list_head node;
 	int users;
+	bool polling_capable;
 };
 
 #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
@@ -763,10 +766,28 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 				      xfer->hdr.poll_completion);
 
 	if (xfer->hdr.poll_completion) {
-		ktime_t stop = ktime_add_ms(ktime_get(), timeout_ms);
+		/*
+		 * Real polling is needed only if transport has NOT declared
+		 * itself to support synchronous commands replies.
+		 */
+		if (!info->desc->sync_cmds_atomic_replies) {
+			/*
+			 * Poll on xfer using transport provided .poll_done();
+			 * assumes no completion interrupt was available.
+			 */
+			ktime_t stop = ktime_add_ms(ktime_get(), timeout_ms);
+
+			spin_until_cond(scmi_xfer_done_no_timeout(cinfo,
+								  xfer, stop));
+			if (ktime_after(ktime_get(), stop)) {
+				dev_err(dev,
+					"timed out in resp(caller: %pS) - polling\n",
+					(void *)_RET_IP_);
+				ret = -ETIMEDOUT;
+			}
+		}
 
-		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
-		if (ktime_before(ktime_get(), stop)) {
+		if (!ret) {
 			unsigned long flags;
 
 			/*
@@ -779,11 +800,6 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 				xfer->state = SCMI_XFER_RESP_OK;
 			}
 			spin_unlock_irqrestore(&xfer->lock, flags);
-		} else {
-			dev_err(dev,
-				"timed out in resp(caller: %pS) - polling\n",
-				(void *)_RET_IP_);
-			ret = -ETIMEDOUT;
 		}
 	} else {
 		/* And we wait for the response. */
@@ -818,7 +834,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	struct scmi_chan_info *cinfo;
 
 	/* Check for polling request on custom command xfers at first */
-	if (xfer->hdr.poll_completion && !info->desc->ops->poll_done) {
+	if (xfer->hdr.poll_completion && !info->polling_capable) {
 		dev_warn_once(dev,
 			      "Polling mode is not supported by transport.\n");
 		return -EINVAL;
@@ -1533,7 +1549,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
 		return ret;
 
 	if (tx && (cinfo->no_completion_irq || info->desc->force_polling)) {
-		if (info->desc->ops->poll_done) {
+		if (info->polling_capable) {
 			dev_info(dev,
 				 "Enabled polling mode TX channel - prot_id:%d\n",
 				 prot_id);
@@ -1866,6 +1882,13 @@ static int scmi_probe(struct platform_device *pdev)
 
 	info->dev = dev;
 	info->desc = desc;
+	/*
+	 * Annotate if the underlying transport for this instance has polling
+	 * capabilities by providing a .poll_done callback OR not requiring
+	 * real polling at all.
+	 */
+	info->polling_capable = info->desc->ops->poll_done ||
+				info->desc->sync_cmds_atomic_replies;
 	INIT_LIST_HEAD(&info->node);
 	idr_init(&info->protocols);
 	mutex_init(&info->protocols_mtx);
-- 
2.17.1

