Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616A752B2E1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiERHCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiERHCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:02:47 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4315B43EC9;
        Wed, 18 May 2022 00:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652857366; x=1684393366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BN5wLRGjtLKhwO/YI3QqYiT0K0JR0D0zC9Y19zaVu+w=;
  b=ynLxWAt6R2IJxeAW5kDPXiAVxly5eAeud4phmG0GYd2hx4igIahWBwkI
   FzrZgz/28H62qx3dzmT8gEv3DlfHoYqxz40SkeAaKuRrLHIm0mgJ9wMCz
   Ny3qHATGphwmUaXqUMmzdkHHag+ipa0D6ZtT/JSh5fvkyloZXrvYXhhWs
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 18 May 2022 00:02:45 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 18 May 2022 00:02:44 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 18 May 2022 12:32:27 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id E4D0C176D; Wed, 18 May 2022 12:32:25 +0530 (IST)
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
Subject: [PATCH V6 3/5] mmc: debugfs: Add debug fs entry for mmc driver
Date:   Wed, 18 May 2022 12:32:18 +0530
Message-Id: <1652857340-6040-4-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652857340-6040-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1652857340-6040-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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

