Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F57E5366C6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354413AbiE0Ryl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354370AbiE0Ry1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:54:27 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06E5D9E88;
        Fri, 27 May 2022 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653674067; x=1685210067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UN3lY1Pk+MR3I3jKJRMZqOMcLEDD883OqErweoErmtI=;
  b=wLZ0gezmVjLw2DeG+h2ojFKetLaCtiEnN4WIiaH/kITbUZlfWl0YdRsD
   fNihuypFZUQWaz7eKBc28vY20WF+zNOEJCgNZz8XpaMs0nwodpr4DtBcY
   TYXK645xqRDXfXmu3J127spvKYVZaVCMJ2RhSN8exxCKoAegVX2ZS/tqS
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 May 2022 10:54:27 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 May 2022 10:54:25 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 27 May 2022 23:24:03 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 42B63184A; Fri, 27 May 2022 23:24:02 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        wsa+renesas@sang-engineering.com, shawn.lin@rock-chips.com,
        yoshihiro.shimoda.uh@renesas.com, digetx@gmail.com,
        quic_asutoshd@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
Subject: [PATCH V8 3/5] mmc: debugfs: Add debug fs entry for mmc driver
Date:   Fri, 27 May 2022 23:23:54 +0530
Message-Id: <1653674036-21829-4-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653674036-21829-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1653674036-21829-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debug fs entry to query eMMC and SD card errors statistics

Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/debugfs.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 3fdbc80..6aa5a60 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -223,6 +223,59 @@ static int mmc_clock_opt_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
 	"%llu\n");
 
+static int mmc_err_stats_show(struct seq_file *file, void *data)
+{
+	struct mmc_host *host = (struct mmc_host *)file->private;
+	const char *desc[MMC_ERR_MAX] = {
+		[MMC_ERR_CMD_TIMEOUT] = "Command Timeout Occurred",
+		[MMC_ERR_CMD_CRC] = "Command CRC Errors Occurred",
+		[MMC_ERR_DAT_TIMEOUT] = "Data Timeout Occurred",
+		[MMC_ERR_DAT_CRC] = "Data CRC Errors Occurred",
+		[MMC_ERR_AUTO_CMD] = "Auto-Cmd Error Occurred",
+		[MMC_ERR_ADMA] = "ADMA Error Occurred",
+		[MMC_ERR_TUNING] = "Tuning Error Occurred",
+		[MMC_ERR_CMDQ_RED] = "CMDQ RED Errors",
+		[MMC_ERR_CMDQ_GCE] = "CMDQ GCE Errors",
+		[MMC_ERR_CMDQ_ICCE] = "CMDQ ICCE Errors",
+		[MMC_ERR_REQ_TIMEOUT] = "Request Timedout",
+		[MMC_ERR_CMDQ_REQ_TIMEOUT] = "CMDQ Request Timedout",
+		[MMC_ERR_ICE_CFG] = "ICE Config Errors",
+		[MMC_ERR_CTRL_TIMEOUT] = "Controller Timedout errors",
+		[MMC_ERR_UNEXPECTED_IRQ] = "Unexpected IRQ errors",
+	};
+	int i;
+
+	for (i = 0; i < MMC_ERR_MAX; i++) {
+		if (desc[i])
+			seq_printf(file, "# %s:\t %d\n",
+					desc[i], host->err_stats[i]);
+	}
+
+	return 0;
+}
+
+static int mmc_err_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mmc_err_stats_show, inode->i_private);
+}
+
+static ssize_t mmc_err_stats_write(struct file *filp, const char __user *ubuf,
+				   size_t cnt, loff_t *ppos)
+{
+	struct mmc_host *host = filp->f_mapping->host->i_private;
+
+	pr_debug("%s: Resetting MMC error statistics\n", __func__);
+	memset(host->err_stats, 0, sizeof(host->err_stats));
+
+	return cnt;
+}
+
+static const struct file_operations mmc_err_stats_fops = {
+	.open	= mmc_err_stats_open,
+	.read	= seq_read,
+	.write	= mmc_err_stats_write,
+};
+
 void mmc_add_host_debugfs(struct mmc_host *host)
 {
 	struct dentry *root;
@@ -236,6 +289,9 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
 				   &mmc_clock_fops);
 
+	debugfs_create_file("err_stats", 0600, root, host,
+			    &mmc_err_stats_fops);
+
 #ifdef CONFIG_FAIL_MMC_REQUEST
 	if (fail_request)
 		setup_fault_attr(&fail_default_attr, fail_request);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

