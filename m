Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304E84CA587
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242054AbiCBNFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242026AbiCBNEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:04:54 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC67C2483;
        Wed,  2 Mar 2022 05:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646226251; x=1677762251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GG6sGclM2fUujkTtTHHmQtLlaAG4I43rIWX2xU4YyQY=;
  b=p+GF+lq/MEhDLKMm9dm10dgZO+gC+nCHrFN4y9/n0keoZCE2bPNn6k7v
   9qAxCZCTL0wpOxcx004zfP21D2VHus//fkPWNaJVXydjQIf7BTVVAWu+S
   6Oo4nDOh7E5wmV5ZGHj+sCRSDI6IMBbe3eX3BcQuj1BRyI9tnfTdVVliV
   k=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 02 Mar 2022 05:04:11 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 Mar 2022 05:04:09 -0800
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 Mar 2022 18:33:54 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id E9ACA587B; Wed,  2 Mar 2022 18:33:53 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, quic_riteshh@quicinc.com,
        asutoshd@quicinc.com, ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_vbadigan@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
Subject: [PATCH V4 3/7] mmc: debugfs: Add debug fs entry for mmc driver
Date:   Wed,  2 Mar 2022 18:33:43 +0530
Message-Id: <1646226227-32429-4-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646226227-32429-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1646226227-32429-1-git-send-email-quic_c_sbhanu@quicinc.com>
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
---
 drivers/mmc/core/debugfs.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 3fdbc80..db0988c 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -223,6 +223,63 @@ static int mmc_clock_opt_set(void *data, u64 val)
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
+	};
+	int i;
+
+	if (!host)
+		return -EINVAL;
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
@@ -236,6 +293,9 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
 				   &mmc_clock_fops);
 
+	debugfs_create_file("err_stats", 0600, root, host,
+		&mmc_err_stats_fops);
+
 #ifdef CONFIG_FAIL_MMC_REQUEST
 	if (fail_request)
 		setup_fault_attr(&fail_default_attr, fail_request);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

