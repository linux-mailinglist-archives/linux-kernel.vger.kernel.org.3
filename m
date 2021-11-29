Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B6F46202C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351590AbhK2TUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:20:04 -0500
Received: from foss.arm.com ([217.140.110.172]:45648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354250AbhK2TRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:17:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B23D14BF;
        Mon, 29 Nov 2021 11:12:50 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2862A3F5A1;
        Mon, 29 Nov 2021 11:12:49 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 11/16] firmware: arm_scmi: Add support for atomic transports
Date:   Mon, 29 Nov 2021 19:11:51 +0000
Message-Id: <20211129191156.29322-12-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211129191156.29322-1-cristian.marussi@arm.com>
References: <20211129191156.29322-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An SCMI transport can be configured as .atomic_enabled in order to signal
to the SCMI core that all its TX path is executed in atomic context and
that, when requested, polling mode should be used while waiting for command
responses.

When a specific platform configuration had properly configured such a
transport as .atomic_enabled, the SCMI core will also take care not to
sleep in the corresponding RX path while waiting for a response if that
specific command transaction was requested as atomic using polling mode.

Asynchronous commands should not be used in an atomic context and so a
warning is emitted if polling was requested for an asynchronous command.

Add also a method to check, from the SCMI drivers, if the underlying SCMI
transport is currently configured to support atomic transactions: this will
be used by upper layers to determine if atomic requests can be supported at
all on this SCMI instance.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- reviewed commit message
- converted async WARN_ON to WARN_ON_ONCE
v5 --> v6
- removed atomic_capable
- fully relying on transport polling capabilities
- removed polling/atomic support for delayed_reponse and WARN
- merged with is_transport_atomic() patch
- is_transport_atomic() now considers polling_capable and
  atomic_enabled flags
v4 --> v5
- added .atomic_enabled flag to decide wheter to enable atomic mode or not
  for atomic_capable transports
- reviewed commit message
---
 drivers/firmware/arm_scmi/common.h |  4 +++
 drivers/firmware/arm_scmi/driver.c | 50 ++++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h      |  8 +++++
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index bf25f0e89c78..97a65d5fbb1d 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -419,6 +419,9 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  *			      Used by core internally only when polling is
  *			      selected as a waiting for reply method: i.e.
  *			      if a completion irq was found use that anyway.
+ * @atomic_enabled: Flag to indicate that this transport, which is assured not
+ *		    to sleep anywhere on the TX path, can be used in atomic mode
+ *		    when requested.
  */
 struct scmi_desc {
 	int (*transport_init)(void);
@@ -429,6 +432,7 @@ struct scmi_desc {
 	int max_msg_size;
 	const bool force_polling;
 	const bool sync_cmds_atomic_replies;
+	const bool atomic_enabled;
 };
 
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8c04632f3ba3..fd8ca72c67a1 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -907,6 +907,20 @@ static void reset_rx_to_maxsz(const struct scmi_protocol_handle *ph,
  * @ph: Pointer to SCMI protocol handle
  * @xfer: Transfer to initiate and wait for response
  *
+ * Using asynchronous commands in atomic/polling mode should be avoided since
+ * it could cause long busy-waiting here, so ignore polling for the delayed
+ * response and WARN if it was requested for this command transaction since
+ * upper layers should refrain from issuing such kind of requests.
+ *
+ * The only other option would have been to refrain from using any asynchronous
+ * command even if made available, when an atomic transport is detected, and
+ * instead forcibly use the synchronous version (thing that can be easily
+ * attained at the protocol layer), but this would also have led to longer
+ * stalls of the channel for synchronous commands and possibly timeouts.
+ * (in other words there is usually a good reason if a platform provides an
+ *  asynchronous version of a command and we should prefer to use it...just not
+ *  when using atomic/polling mode)
+ *
  * Return: -ETIMEDOUT in case of no delayed response, if transmit error,
  *	return corresponding error, else if all goes well, return 0.
  */
@@ -918,12 +932,24 @@ static int do_xfer_with_response(const struct scmi_protocol_handle *ph,
 
 	xfer->async_done = &async_response;
 
+	/*
+	 * Delayed responses should not be polled, so an async command should
+	 * not have been used when requiring an atomic/poll context; WARN and
+	 * perform instead a sleeping wait.
+	 * (Note Async + IgnoreDelayedResponses are sent via do_xfer)
+	 */
+	WARN_ON_ONCE(xfer->hdr.poll_completion);
+
 	ret = do_xfer(ph, xfer);
 	if (!ret) {
-		if (!wait_for_completion_timeout(xfer->async_done, timeout))
+		if (!wait_for_completion_timeout(xfer->async_done, timeout)) {
+			dev_err(ph->dev,
+				"timed out in delayed resp(caller: %pS)\n",
+				(void *)_RET_IP_);
 			ret = -ETIMEDOUT;
-		else if (xfer->hdr.status)
+		} else if (xfer->hdr.status) {
 			ret = scmi_to_linux_errno(xfer->hdr.status);
+		}
 	}
 
 	xfer->async_done = NULL;
@@ -1357,6 +1383,21 @@ static void scmi_devm_protocol_put(struct scmi_device *sdev, u8 protocol_id)
 	WARN_ON(ret);
 }
 
+/**
+ * scmi_is_transport_atomic  - Method to check if underlying transport for an
+ * SCMI instance is configured as atomic.
+ *
+ * @handle: A reference to the SCMI platform instance.
+ *
+ * Return: True if transport is configured as atomic
+ */
+static bool scmi_is_transport_atomic(const struct scmi_handle *handle)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	return info->desc->atomic_enabled && info->polling_capable;
+}
+
 static inline
 struct scmi_handle *scmi_handle_get_from_info_unlocked(struct scmi_info *info)
 {
@@ -1903,6 +1944,7 @@ static int scmi_probe(struct platform_device *pdev)
 	handle->version = &info->version;
 	handle->devm_protocol_get = scmi_devm_protocol_get;
 	handle->devm_protocol_put = scmi_devm_protocol_put;
+	handle->is_transport_atomic = scmi_is_transport_atomic;
 
 	if (desc->ops->link_supplier) {
 		ret = desc->ops->link_supplier(dev);
@@ -1921,6 +1963,10 @@ static int scmi_probe(struct platform_device *pdev)
 	if (scmi_notification_init(handle))
 		dev_err(dev, "SCMI Notifications NOT available.\n");
 
+	if (info->desc->atomic_enabled && !info->polling_capable)
+		dev_err(dev,
+			"Transport is not polling capable. Atomic mode not supported.\n");
+
 	/*
 	 * Trigger SCMI Base protocol initialization.
 	 * It's mandatory and won't be ever released/deinit until the
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 80e781c51ddc..9f895cb81818 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -612,6 +612,13 @@ struct scmi_notify_ops {
  * @devm_protocol_get: devres managed method to acquire a protocol and get specific
  *		       operations and a dedicated protocol handler
  * @devm_protocol_put: devres managed method to release a protocol
+ * @is_transport_atomic: method to check if the underlying transport for this
+ *			 instance handle is configured to support atomic
+ *			 transactions for commands.
+ *			 Some users of the SCMI stack in the upper layers could
+ *			 be interested to know if they can assume SCMI
+ *			 command transactions associated to this handle will
+ *			 never sleep and act accordingly.
  * @notify_ops: pointer to set of notifications related operations
  */
 struct scmi_handle {
@@ -622,6 +629,7 @@ struct scmi_handle {
 		(*devm_protocol_get)(struct scmi_device *sdev, u8 proto,
 				     struct scmi_protocol_handle **ph);
 	void (*devm_protocol_put)(struct scmi_device *sdev, u8 proto);
+	bool (*is_transport_atomic)(const struct scmi_handle *handle);
 
 	const struct scmi_notify_ops *notify_ops;
 };
-- 
2.17.1

