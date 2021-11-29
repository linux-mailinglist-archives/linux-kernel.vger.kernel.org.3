Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D66546202A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351036AbhK2TT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:19:58 -0500
Received: from foss.arm.com ([217.140.110.172]:45644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352317AbhK2TRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:17:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 027C8147A;
        Mon, 29 Nov 2021 11:12:47 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 694AC3F5A1;
        Mon, 29 Nov 2021 11:12:45 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 09/16] firmware: arm_scmi: Make smc support atomic sync commands replies
Date:   Mon, 29 Nov 2021 19:11:49 +0000
Message-Id: <20211129191156.29322-10-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211129191156.29322-1-cristian.marussi@arm.com>
References: <20211129191156.29322-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sync_cmds_atomic_replies in the SMC transport descriptor and remove
SMC specific .poll_done callback support since polling is bypassed when
sync_cmds_atomic_replies is set.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- removed RFC tag
- added comment on setting flag
- remove smc_poll_done
---
 drivers/firmware/arm_scmi/smc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index d6c6ad9f6bab..b2f31d3feb10 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -173,14 +173,6 @@ static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret)
 	mutex_unlock(&scmi_info->shmem_lock);
 }
 
-static bool
-smc_poll_done(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
-{
-	struct scmi_smc *scmi_info = cinfo->transport_info;
-
-	return shmem_poll_done(scmi_info->shmem, xfer);
-}
-
 static const struct scmi_transport_ops scmi_smc_ops = {
 	.chan_available = smc_chan_available,
 	.chan_setup = smc_chan_setup,
@@ -188,7 +180,6 @@ static const struct scmi_transport_ops scmi_smc_ops = {
 	.send_message = smc_send_message,
 	.mark_txdone = smc_mark_txdone,
 	.fetch_response = smc_fetch_response,
-	.poll_done = smc_poll_done,
 };
 
 const struct scmi_desc scmi_smc_desc = {
@@ -196,4 +187,13 @@ const struct scmi_desc scmi_smc_desc = {
 	.max_rx_timeout_ms = 30,
 	.max_msg = 20,
 	.max_msg_size = 128,
+	/*
+	 * Setting .sync_cmds_atomic_replies to true for SMC assumes that,
+	 * once the SMC instruction has completed successfully, the issued
+	 * SCMI command would have been already fully processed by the SCMI
+	 * platform firmware and so any possible response value expected
+	 * for the issued command will be immmediately ready to be fetched
+	 * from the shared memory area.
+	 */
+	.sync_cmds_atomic_replies = true,
 };
-- 
2.17.1

