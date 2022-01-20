Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2011495330
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiATR2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:28:20 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:38887 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346833AbiATR05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642699617; x=1674235617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2FIjShg5baSboHk5Y596ymu0qrv2AoIjmxzwRiyXO74=;
  b=rVis5IPdzyu6Q5vtTGNkx5tHaYnyEjsFzv3OOV1co4BOYbAxK4bjLdIN
   aIPdfvx+OxVwJo0uHWyKc5SefJqVzCKWJhrrmvQxH4qWuK5NKGgBEilOQ
   +embhBIE2kFKhKJ2t0O1Te8xYBM9CX+6G7+MNkLNJhlFuR2qHAxlvh5S+
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 20 Jan 2022 09:26:57 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Jan 2022 09:26:55 -0800
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 20 Jan 2022 22:56:35 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 4EEE6538E; Thu, 20 Jan 2022 22:56:34 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, quic_asutoshd@quicinc.com,
        ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stummala@codeaurora.org, vbadigan@codeaurora.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        sartgarg@codeaurora.org, nitirawa@codeaurora.org,
        sayalil@codeaurora.org,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Liangliang Lu <luliang@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
Subject: [PATCH V3 2/4] mmc: debugfs: Add debug fs entry for mmc driver
Date:   Thu, 20 Jan 2022 22:56:20 +0530
Message-Id: <1642699582-14785-3-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642699582-14785-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1642699582-14785-1-git-send-email-quic_c_sbhanu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debug fs entry to query eMMC and SD card errors statistics

Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Signed-off-by: Liangliang Lu <luliang@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
---
 drivers/mmc/core/debugfs.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 3fdbc80..f4cb594 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -223,6 +223,82 @@ static int mmc_clock_opt_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
 	"%llu\n");
 
+static int mmc_err_state_get(void *data, u64 *val)
+{
+	struct mmc_host *host = data;
+
+	if (!host)
+		return -EINVAL;
+
+	*val = host->err_state ? 1 : 0;
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(mmc_err_state, mmc_err_state_get, NULL, "%llu\n");
+
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
+	};
+	int i;
+
+	if (!host)
+		return -EINVAL;
+
+	if (!host->err_stats_enabled) {
+		seq_printf(file, "Not supported by driver\n");
+		return 0;
+	}
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
+	if (!host)
+		return -EINVAL;
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
@@ -236,6 +312,11 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
 				   &mmc_clock_fops);
 
+	debugfs_create_file("err_state", 0600, root, host,
+		&mmc_err_state);
+	debugfs_create_file("err_stats", 0600, root, host,
+		&mmc_err_stats_fops);
+
 #ifdef CONFIG_FAIL_MMC_REQUEST
 	if (fail_request)
 		setup_fault_attr(&fail_default_attr, fail_request);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

