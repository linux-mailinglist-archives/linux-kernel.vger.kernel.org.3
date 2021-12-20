Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9442347B414
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbhLTT6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:58:06 -0500
Received: from foss.arm.com ([217.140.110.172]:34602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233278AbhLTT5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:57:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BA821FB;
        Mon, 20 Dec 2021 11:57:34 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 636133F718;
        Mon, 20 Dec 2021 11:57:31 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v8 05/11] firmware: arm_scmi: Make optee support sync_cmds_completed_on_ret
Date:   Mon, 20 Dec 2021 19:56:40 +0000
Message-Id: <20211220195646.44498-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220195646.44498-1-cristian.marussi@arm.com>
References: <20211220195646.44498-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare each OPTEE SCMI channel as not having a completion_irq so as to
enable polling mode and then enable also .sync_cmds_completed_on_ret flag
in the OPTEE transport descriptor so that real polling is itself
effectively bypassed on the rx path: once the optee command invocation has
successfully returned the core will directly fetch the response from the
shared memory area.

Remove OPTEE SCMI transport specific .poll_done callback support since
real polling is effectively bypassed when .sync_cmds_completed_on_ret is
set.

Add OPTEE SCMI transport specific .mark_txdone callback support in order to
properly handle channel locking along the tx path.

Cc: Etienne Carriere <etienne.carriere@linaro.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v7 -> v8
- renaming to sync_cmds_completed_on_ret
v6 --> v7
- reviewed commit message
---
 drivers/firmware/arm_scmi/optee.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 175b39bcd470..f460e12be4ea 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -363,6 +363,9 @@ static int scmi_optee_chan_setup(struct scmi_chan_info *cinfo, struct device *de
 	if (ret)
 		goto err_close_sess;
 
+	/* Enable polling */
+	cinfo->no_completion_irq = true;
+
 	mutex_lock(&scmi_optee_private->mu);
 	list_add(&channel->link, &scmi_optee_private->channel_list);
 	mutex_unlock(&scmi_optee_private->mu);
@@ -423,9 +426,8 @@ static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
 	shmem_tx_prepare(shmem, xfer);
 
 	ret = invoke_process_smt_channel(channel);
-
-	scmi_rx_callback(cinfo, shmem_read_header(shmem), NULL);
-	mutex_unlock(&channel->mu);
+	if (ret)
+		mutex_unlock(&channel->mu);
 
 	return ret;
 }
@@ -439,13 +441,11 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
 	shmem_fetch_response(shmem, xfer);
 }
 
-static bool scmi_optee_poll_done(struct scmi_chan_info *cinfo,
-				 struct scmi_xfer *xfer)
+static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret)
 {
 	struct scmi_optee_channel *channel = cinfo->transport_info;
-	struct scmi_shared_mem *shmem = get_channel_shm(channel, xfer);
 
-	return shmem_poll_done(shmem, xfer);
+	mutex_unlock(&channel->mu);
 }
 
 static struct scmi_transport_ops scmi_optee_ops = {
@@ -454,9 +454,9 @@ static struct scmi_transport_ops scmi_optee_ops = {
 	.chan_setup = scmi_optee_chan_setup,
 	.chan_free = scmi_optee_chan_free,
 	.send_message = scmi_optee_send_message,
+	.mark_txdone = scmi_optee_mark_txdone,
 	.fetch_response = scmi_optee_fetch_response,
 	.clear_channel = scmi_optee_clear_channel,
-	.poll_done = scmi_optee_poll_done,
 };
 
 static int scmi_optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
@@ -562,4 +562,5 @@ const struct scmi_desc scmi_optee_desc = {
 	.max_rx_timeout_ms = 30,
 	.max_msg = 20,
 	.max_msg_size = SCMI_OPTEE_MAX_MSG_SIZE,
+	.sync_cmds_completed_on_ret = true,
 };
-- 
2.17.1

