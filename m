Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C384CA58F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242060AbiCBNFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242040AbiCBNE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:04:58 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2365BC2E40;
        Wed,  2 Mar 2022 05:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646226255; x=1677762255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4sywxk01cEBaroiqrhseZzU7BYxb6vKODGzjJcoNpM4=;
  b=R2VBqqSz7t6L/7wzFSfaDrUFVep1j6Wr3eZoNHCJ884MM0DktN+kmgso
   +ioaPMSqI/h9zSjBz/z8RkbS5Wn6Vuck/+TkvQt+n98ZNkjifcgpQv7ak
   TH8ayBoKnXqUvwqycQQinkt+OnPfIyDSz5nALASOMvtIX+rd6WTsgWfrg
   k=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 02 Mar 2022 05:04:14 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 Mar 2022 05:04:13 -0800
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 Mar 2022 18:33:53 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id B235E5881; Wed,  2 Mar 2022 18:33:52 +0530 (IST)
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
Subject: [PATCH V4 2/7] mmc: sdhci: Capture eMMC and SD card errors
Date:   Wed,  2 Mar 2022 18:33:42 +0530
Message-Id: <1646226227-32429-3-git-send-email-quic_c_sbhanu@quicinc.com>
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

Add changes to capture eMMC and SD card errors.
This is useful for debug and testing.

Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 drivers/mmc/host/sdhci.c | 52 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 07c6da1..741fb06 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3159,6 +3159,7 @@ static void sdhci_timeout_timer(struct timer_list *t)
 	spin_lock_irqsave(&host->lock, flags);
 
 	if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
+		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
 		pr_err("%s: Timeout waiting for hardware cmd interrupt.\n",
 		       mmc_hostname(host->mmc));
 		sdhci_dumpregs(host);
@@ -3181,6 +3182,7 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
 
 	if (host->data || host->data_cmd ||
 	    (host->cmd && sdhci_data_line_cmd(host->cmd))) {
+		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
 		pr_err("%s: Timeout waiting for hardware interrupt.\n",
 		       mmc_hostname(host->mmc));
 		sdhci_dumpregs(host);
@@ -3240,11 +3242,15 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 
 	if (intmask & (SDHCI_INT_TIMEOUT | SDHCI_INT_CRC |
 		       SDHCI_INT_END_BIT | SDHCI_INT_INDEX)) {
-		if (intmask & SDHCI_INT_TIMEOUT)
+		if (intmask & SDHCI_INT_TIMEOUT) {
 			host->cmd->error = -ETIMEDOUT;
-		else
+			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
+		} else {
 			host->cmd->error = -EILSEQ;
-
+			if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
+					host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
+				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_CRC);
+		}
 		/* Treat data command CRC error the same as data CRC error */
 		if (host->cmd->data &&
 		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) ==
@@ -3265,6 +3271,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 		int err = (auto_cmd_status & SDHCI_AUTO_CMD_TIMEOUT) ?
 			  -ETIMEDOUT :
 			  -EILSEQ;
+		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_AUTO_CMD);
 
 		if (sdhci_auto_cmd23(host, mrq)) {
 			mrq->sbc->error = err;
@@ -3342,6 +3349,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
 				host->data_cmd = NULL;
 				data_cmd->error = -ETIMEDOUT;
+				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
 				__sdhci_finish_mrq(host, data_cmd->mrq);
 				return;
 			}
@@ -3375,18 +3383,25 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		return;
 	}
 
-	if (intmask & SDHCI_INT_DATA_TIMEOUT)
+	if (intmask & SDHCI_INT_DATA_TIMEOUT) {
 		host->data->error = -ETIMEDOUT;
+		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_TIMEOUT);
+	}
 	else if (intmask & SDHCI_INT_DATA_END_BIT)
 		host->data->error = -EILSEQ;
 	else if ((intmask & SDHCI_INT_DATA_CRC) &&
 		SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))
-			!= MMC_BUS_TEST_R)
+			!= MMC_BUS_TEST_R) {
 		host->data->error = -EILSEQ;
+		if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
+				host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
+			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_CRC);
+	}
 	else if (intmask & SDHCI_INT_ADMA_ERROR) {
 		pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc),
 		       intmask);
 		sdhci_adma_show_error(host);
+		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_ADMA);
 		host->data->error = -EIO;
 		if (host->ops->adma_workaround)
 			host->ops->adma_workaround(host, intmask);
@@ -3905,20 +3920,33 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 	if (!host->cqe_on)
 		return false;
 
-	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC))
+	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) {
 		*cmd_error = -EILSEQ;
-	else if (intmask & SDHCI_INT_TIMEOUT)
+		if (intmask & SDHCI_INT_CRC) {
+			if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
+					host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
+				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_CRC);
+		}
+	} else if (intmask & SDHCI_INT_TIMEOUT) {
 		*cmd_error = -ETIMEDOUT;
-	else
+		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
+	} else
 		*cmd_error = 0;
 
-	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC))
+	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
 		*data_error = -EILSEQ;
-	else if (intmask & SDHCI_INT_DATA_TIMEOUT)
+		if (intmask & SDHCI_INT_DATA_CRC) {
+			if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
+					host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
+				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_CRC);
+		}
+	} else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
 		*data_error = -ETIMEDOUT;
-	else if (intmask & SDHCI_INT_ADMA_ERROR)
+		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_TIMEOUT);
+	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
 		*data_error = -EIO;
-	else
+		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_ADMA);
+	} else
 		*data_error = 0;
 
 	/* Clear selected interrupts. */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

