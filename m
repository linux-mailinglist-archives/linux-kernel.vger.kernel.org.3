Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98697462026
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380157AbhK2TTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:19:50 -0500
Received: from foss.arm.com ([217.140.110.172]:45636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347464AbhK2TRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:17:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45E9F143B;
        Mon, 29 Nov 2021 11:12:41 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96A133F5A1;
        Mon, 29 Nov 2021 11:12:39 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 06/16] firmware: arm_scmi: Add configurable polling mode for transports
Date:   Mon, 29 Nov 2021 19:11:46 +0000
Message-Id: <20211129191156.29322-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211129191156.29322-1-cristian.marussi@arm.com>
References: <20211129191156.29322-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI communications along TX channels can optionally be provided of a
completion interrupt; when such interrupt is not available, command
transactions should rely on polling, where the SCMI core takes care to
repeatedly evaluate the transport-specific .poll_done() function, if
available, to determine if and when a request was fully completed or
timed out.

Such mechanism is already present and working on a single transfer base:
SCMI protocols can indeed enable hdr.poll_completion on specific commands
ahead of each transfer and cause that transaction to be handled with
polling.

Introduce a couple of flags to be able to enforce such polling behaviour
globally at will:

 - scmi_desc.force_polling: to statically switch the whole transport to
   polling mode.

 - scmi_chan_info.no_completion_irq: to switch a single channel dynamically
   to polling mode if, at runtime, is determined that no completion
   interrupt was available for such channel.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v5 --> v6
- removed check on replies received by IRQs when xfer was requested
  as poll_completion (not all transport can suppress IRQs on an xfer basis)
v4 --> v5
- make force_polling const
- introduce polling_enabled flag to simplify checks on do_xfer
v3 --> v4:
- renamed .needs_polling flag to .no_completion_irq
- refactored error path when polling needed but not supported
---
 drivers/firmware/arm_scmi/common.h | 11 +++++++++++
 drivers/firmware/arm_scmi/driver.c | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 6438b5248c24..99b74f4d39b6 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -339,11 +339,19 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
  * @dev: Reference to device in the SCMI hierarchy corresponding to this
  *	 channel
  * @handle: Pointer to SCMI entity handle
+ * @no_completion_irq: Flag to indicate that this channel has no completion
+ *		       interrupt mechanism for synchronous commands.
+ *		       This can be dynamically set by transports at run-time
+ *		       inside their provided .chan_setup().
+ * @polling_enabled: Flag used to annotate if polling mode is currently enabled
+ *		     on this channel.
  * @transport_info: Transport layer related information
  */
 struct scmi_chan_info {
 	struct device *dev;
 	struct scmi_handle *handle;
+	bool no_completion_irq;
+	bool polling_enabled;
 	void *transport_info;
 };
 
@@ -402,6 +410,8 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  *	be pending simultaneously in the system. May be overridden by the
  *	get_max_msg op.
  * @max_msg_size: Maximum size of data per message that can be handled.
+ * @force_polling: Flag to force this whole transport to use SCMI core polling
+ *		   mechanism instead of completion interrupts even if available.
  */
 struct scmi_desc {
 	int (*transport_init)(void);
@@ -410,6 +420,7 @@ struct scmi_desc {
 	int max_rx_timeout_ms;
 	int max_msg;
 	int max_msg_size;
+	const bool force_polling;
 };
 
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 476b91845e40..8a30b832899c 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -817,6 +817,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	struct device *dev = info->dev;
 	struct scmi_chan_info *cinfo;
 
+	/* Check for polling request on custom command xfers at first */
 	if (xfer->hdr.poll_completion && !info->desc->ops->poll_done) {
 		dev_warn_once(dev,
 			      "Polling mode is not supported by transport.\n");
@@ -827,6 +828,10 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	if (unlikely(!cinfo))
 		return -EINVAL;
 
+	/* Initialized to true ONLY if also supported by transport. */
+	if (cinfo->polling_enabled)
+		xfer->hdr.poll_completion = true;
+
 	/*
 	 * Initialise protocol id now from protocol handle to avoid it being
 	 * overridden by mistake (or malice) by the protocol code mangling with
@@ -1527,6 +1532,18 @@ static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
 	if (ret)
 		return ret;
 
+	if (tx && (cinfo->no_completion_irq || info->desc->force_polling)) {
+		if (info->desc->ops->poll_done) {
+			dev_info(dev,
+				 "Enabled polling mode TX channel - prot_id:%d\n",
+				 prot_id);
+			cinfo->polling_enabled = true;
+		} else {
+			dev_warn(dev,
+				 "Polling mode NOT supported by transport.\n");
+		}
+	}
+
 idr_alloc:
 	ret = idr_alloc(idr, cinfo, prot_id, prot_id + 1, GFP_KERNEL);
 	if (ret != prot_id) {
-- 
2.17.1

