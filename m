Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7EC4CA58C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242071AbiCBNFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242029AbiCBNE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:04:56 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B6BC2E40;
        Wed,  2 Mar 2022 05:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646226253; x=1677762253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=0Pp6zzFaPm+z/5Swraj/qnkxiWNsONk0eUFF4PCYf9I=;
  b=DeaJQ/ZSf3MGwdCnVZPxwQop/Ce6oxziIrIxtmJrPyk32S9uDflwcuqA
   5TYEOC3w8uXhO9yG9V481zhRgWXW2N/k5gZjFKtBdQZNO2jGdxUQN1BYu
   SMhasaAauui877Ll6OA+zGlm8zoayKGGpdKjTc4t5FYsF+bDB0ZCkd3P0
   o=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 02 Mar 2022 05:04:13 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 Mar 2022 05:04:11 -0800
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 Mar 2022 18:33:59 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 424D8587E; Wed,  2 Mar 2022 18:33:58 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, quic_riteshh@quicinc.com,
        asutoshd@quicinc.com, ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_vbadigan@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Liangliang Lu <luliang@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
Subject: [PATCH V4 6/7] mmc: sdhci: Set error state for mmc driver
Date:   Wed,  2 Mar 2022 18:33:46 +0530
Message-Id: <1646226227-32429-7-git-send-email-quic_c_sbhanu@quicinc.com>
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

Set error state if any errors observed in eMMC and SD card driver level.

Signed-off-by: Liangliang Lu <luliang@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 drivers/mmc/host/sdhci.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 741fb06..4ba3797 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -224,6 +224,8 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 		if (timedout) {
 			pr_err("%s: Reset 0x%x never completed.\n",
 				mmc_hostname(host->mmc), (int)mask);
+			if (host->mmc && !host->mmc->err_state)
+				mmc_debugfs_err_stats_enable(host->mmc);
 			sdhci_dumpregs(host);
 			return;
 		}
@@ -1716,6 +1718,8 @@ static bool sdhci_send_command_retry(struct sdhci_host *host,
 		if (!timeout--) {
 			pr_err("%s: Controller never released inhibit bit(s).\n",
 			       mmc_hostname(host->mmc));
+			if (host->mmc && !host->mmc->err_state)
+				mmc_debugfs_err_stats_enable(host->mmc);
 			sdhci_dumpregs(host);
 			cmd->error = -EIO;
 			return false;
@@ -1965,6 +1969,8 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 		if (timedout) {
 			pr_err("%s: Internal clock never stabilised.\n",
 			       mmc_hostname(host->mmc));
+			if (host->mmc && !host->mmc->err_state)
+				mmc_debugfs_err_stats_enable(host->mmc);
 			sdhci_dumpregs(host);
 			return;
 		}
@@ -1987,6 +1993,8 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 			if (timedout) {
 				pr_err("%s: PLL clock never stabilised.\n",
 				       mmc_hostname(host->mmc));
+				if (host->mmc && !host->mmc->err_state)
+					mmc_debugfs_err_stats_enable(host->mmc);
 				sdhci_dumpregs(host);
 				return;
 			}
@@ -3162,6 +3170,8 @@ static void sdhci_timeout_timer(struct timer_list *t)
 		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
 		pr_err("%s: Timeout waiting for hardware cmd interrupt.\n",
 		       mmc_hostname(host->mmc));
+		if (host->mmc && !host->mmc->err_state)
+			mmc_debugfs_err_stats_enable(host->mmc);
 		sdhci_dumpregs(host);
 
 		host->cmd->error = -ETIMEDOUT;
@@ -3185,6 +3195,8 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
 		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
 		pr_err("%s: Timeout waiting for hardware interrupt.\n",
 		       mmc_hostname(host->mmc));
+		if (host->mmc && !host->mmc->err_state)
+			mmc_debugfs_err_stats_enable(host->mmc);
 		sdhci_dumpregs(host);
 
 		if (host->data) {
@@ -3236,6 +3248,8 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 			return;
 		pr_err("%s: Got command interrupt 0x%08x even though no command operation was in progress.\n",
 		       mmc_hostname(host->mmc), (unsigned)intmask);
+		if (host->mmc && !host->mmc->err_state)
+			mmc_debugfs_err_stats_enable(host->mmc);
 		sdhci_dumpregs(host);
 		return;
 	}
@@ -3289,6 +3303,8 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
 	void *desc = host->adma_table;
 	dma_addr_t dma = host->adma_addr;
 
+	if (host->mmc && !host->mmc->err_state)
+		mmc_debugfs_err_stats_enable(host->mmc);
 	sdhci_dumpregs(host);
 
 	while (true) {
@@ -3378,6 +3394,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 
 		pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
 		       mmc_hostname(host->mmc), (unsigned)intmask);
+		if (host->mmc && !host->mmc->err_state)
+			mmc_debugfs_err_stats_enable(host->mmc);
 		sdhci_dumpregs(host);
 
 		return;
@@ -3599,6 +3617,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	if (unexpected) {
 		pr_err("%s: Unexpected interrupt 0x%08x.\n",
 			   mmc_hostname(host->mmc), unexpected);
+		if (host->mmc && !host->mmc->err_state)
+			mmc_debugfs_err_stats_enable(host->mmc);
 		sdhci_dumpregs(host);
 	}
 
@@ -3962,6 +3982,8 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 		sdhci_writel(host, intmask, SDHCI_INT_STATUS);
 		pr_err("%s: CQE: Unexpected interrupt 0x%08x.\n",
 		       mmc_hostname(host->mmc), intmask);
+		if (host->mmc && !host->mmc->err_state)
+			mmc_debugfs_err_stats_enable(host->mmc);
 		sdhci_dumpregs(host);
 	}
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

