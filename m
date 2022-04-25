Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC5B50E509
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbiDYQEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243162AbiDYQEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:04:25 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C2410FF6;
        Mon, 25 Apr 2022 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650902481; x=1682438481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JppRMw7VzTNcFr6TWQib8GtwFbi4LrTykY6ZE6u94MQ=;
  b=DVvX+Ap+2lgq9k13ldHadbJ9iOI5taqq3v5rJHQ6qNRuVt11vBdTrfP7
   am58Sq/KcsiydlttF25qnqU0u8qD0VuQpfuWiz3IUst8V2GxMAZamgR1i
   Y6W/j29bImvop93a7kGjWALUSrICy/76MLXe3AyS63trinBUNqdkVHjBV
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 25 Apr 2022 09:01:20 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Apr 2022 09:01:18 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 25 Apr 2022 21:30:49 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 85FACBC8; Mon, 25 Apr 2022 21:30:48 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        wsa+renesas@sang-engineering.com, yoshihiro.shimoda.uh@renesas.com,
        linus.walleij@linaro.org, digetx@gmail.com,
        briannorris@chromium.org, quic_riteshh@quicinc.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
Subject: [PATCH V5 2/5] mmc: sdhci: Capture eMMC and SD card errors
Date:   Mon, 25 Apr 2022 21:30:40 +0530
Message-Id: <1650902443-26357-3-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650902443-26357-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1650902443-26357-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/mmc/host/sdhci.c | 54 ++++++++++++++++++++++++++++++++++++------------
 drivers/mmc/host/sdhci.h |  3 +++
 include/linux/mmc/mmc.h  |  6 ++++++
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2215202..1cda28ba 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -224,6 +224,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 		if (timedout) {
 			pr_err("%s: Reset 0x%x never completed.\n",
 				mmc_hostname(host->mmc), (int)mask);
+			sdhci_err_stats_inc(host, CTRL_TIMEOUT);
 			sdhci_dumpregs(host);
 			return;
 		}
@@ -1716,6 +1717,7 @@ static bool sdhci_send_command_retry(struct sdhci_host *host,
 		if (!timeout--) {
 			pr_err("%s: Controller never released inhibit bit(s).\n",
 			       mmc_hostname(host->mmc));
+			sdhci_err_stats_inc(host, CTRL_TIMEOUT);
 			sdhci_dumpregs(host);
 			cmd->error = -EIO;
 			return false;
@@ -1965,6 +1967,7 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 		if (timedout) {
 			pr_err("%s: Internal clock never stabilised.\n",
 			       mmc_hostname(host->mmc));
+			sdhci_err_stats_inc(host, CTRL_TIMEOUT);
 			sdhci_dumpregs(host);
 			return;
 		}
@@ -1987,6 +1990,7 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 			if (timedout) {
 				pr_err("%s: PLL clock never stabilised.\n",
 				       mmc_hostname(host->mmc));
+				sdhci_err_stats_inc(host, CTRL_TIMEOUT);
 				sdhci_dumpregs(host);
 				return;
 			}
@@ -3161,6 +3165,7 @@ static void sdhci_timeout_timer(struct timer_list *t)
 	if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
 		pr_err("%s: Timeout waiting for hardware cmd interrupt.\n",
 		       mmc_hostname(host->mmc));
+		sdhci_err_stats_inc(host, REQ_TIMEOUT);
 		sdhci_dumpregs(host);
 
 		host->cmd->error = -ETIMEDOUT;
@@ -3183,6 +3188,7 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
 	    (host->cmd && sdhci_data_line_cmd(host->cmd))) {
 		pr_err("%s: Timeout waiting for hardware interrupt.\n",
 		       mmc_hostname(host->mmc));
+		sdhci_err_stats_inc(host, REQ_TIMEOUT);
 		sdhci_dumpregs(host);
 
 		if (host->data) {
@@ -3234,17 +3240,21 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 			return;
 		pr_err("%s: Got command interrupt 0x%08x even though no command operation was in progress.\n",
 		       mmc_hostname(host->mmc), (unsigned)intmask);
+		sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
 		sdhci_dumpregs(host);
 		return;
 	}
 
 	if (intmask & (SDHCI_INT_TIMEOUT | SDHCI_INT_CRC |
 		       SDHCI_INT_END_BIT | SDHCI_INT_INDEX)) {
-		if (intmask & SDHCI_INT_TIMEOUT)
+		if (intmask & SDHCI_INT_TIMEOUT) {
 			host->cmd->error = -ETIMEDOUT;
-		else
+			sdhci_err_stats_inc(host, CMD_TIMEOUT);
+		} else {
 			host->cmd->error = -EILSEQ;
-
+			if (!mmc_op_tuning(host->cmd->opcode))
+				sdhci_err_stats_inc(host, CMD_CRC);
+		}
 		/* Treat data command CRC error the same as data CRC error */
 		if (host->cmd->data &&
 		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) ==
@@ -3266,6 +3276,8 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 			  -ETIMEDOUT :
 			  -EILSEQ;
 
+		sdhci_err_stats_inc(host, AUTO_CMD);
+
 		if (sdhci_auto_cmd23(host, mrq)) {
 			mrq->sbc->error = err;
 			__sdhci_finish_mrq(host, mrq);
@@ -3342,6 +3354,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
 				host->data_cmd = NULL;
 				data_cmd->error = -ETIMEDOUT;
+				sdhci_err_stats_inc(host, CMD_TIMEOUT);
 				__sdhci_finish_mrq(host, data_cmd->mrq);
 				return;
 			}
@@ -3370,23 +3383,29 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 
 		pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
 		       mmc_hostname(host->mmc), (unsigned)intmask);
+		sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
 		sdhci_dumpregs(host);
 
 		return;
 	}
 
-	if (intmask & SDHCI_INT_DATA_TIMEOUT)
+	if (intmask & SDHCI_INT_DATA_TIMEOUT) {
 		host->data->error = -ETIMEDOUT;
-	else if (intmask & SDHCI_INT_DATA_END_BIT)
+		sdhci_err_stats_inc(host, DAT_TIMEOUT);
+	} else if (intmask & SDHCI_INT_DATA_END_BIT)
 		host->data->error = -EILSEQ;
 	else if ((intmask & SDHCI_INT_DATA_CRC) &&
 		SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))
-			!= MMC_BUS_TEST_R)
+			!= MMC_BUS_TEST_R) {
 		host->data->error = -EILSEQ;
+		if (!mmc_op_tuning(host->cmd->opcode))
+			sdhci_err_stats_inc(host, DAT_CRC);
+	}
 	else if (intmask & SDHCI_INT_ADMA_ERROR) {
 		pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc),
 		       intmask);
 		sdhci_adma_show_error(host);
+		sdhci_err_stats_inc(host, ADMA);
 		host->data->error = -EIO;
 		if (host->ops->adma_workaround)
 			host->ops->adma_workaround(host, intmask);
@@ -3584,6 +3603,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	if (unexpected) {
 		pr_err("%s: Unexpected interrupt 0x%08x.\n",
 			   mmc_hostname(host->mmc), unexpected);
+		sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
 		sdhci_dumpregs(host);
 	}
 
@@ -3905,20 +3925,27 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 	if (!host->cqe_on)
 		return false;
 
-	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC))
+	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) {
 		*cmd_error = -EILSEQ;
-	else if (intmask & SDHCI_INT_TIMEOUT)
+		if (!mmc_op_tuning(host->cmd->opcode))
+			sdhci_err_stats_inc(host, CMD_CRC);
+	} else if (intmask & SDHCI_INT_TIMEOUT) {
 		*cmd_error = -ETIMEDOUT;
-	else
+		sdhci_err_stats_inc(host, CMD_TIMEOUT);
+	} else
 		*cmd_error = 0;
 
-	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC))
+	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
 		*data_error = -EILSEQ;
-	else if (intmask & SDHCI_INT_DATA_TIMEOUT)
+		if (!mmc_op_tuning(host->cmd->opcode))
+			sdhci_err_stats_inc(host, DAT_CRC);
+	} else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
 		*data_error = -ETIMEDOUT;
-	else if (intmask & SDHCI_INT_ADMA_ERROR)
+		sdhci_err_stats_inc(host, DAT_TIMEOUT);
+	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
 		*data_error = -EIO;
-	else
+		sdhci_err_stats_inc(host, ADMA);
+	} else
 		*data_error = 0;
 
 	/* Clear selected interrupts. */
@@ -3934,6 +3961,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 		sdhci_writel(host, intmask, SDHCI_INT_STATUS);
 		pr_err("%s: CQE: Unexpected interrupt 0x%08x.\n",
 		       mmc_hostname(host->mmc), intmask);
+		sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
 		sdhci_dumpregs(host);
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d7929d7..95a08f0 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -356,6 +356,9 @@ struct sdhci_adma2_64_desc {
  */
 #define MMC_CMD_TRANSFER_TIME	(10 * NSEC_PER_MSEC) /* max 10 ms */
 
+#define sdhci_err_stats_inc(host, err_name) \
+	mmc_debugfs_err_stats_inc((host)->mmc, MMC_ERR_##err_name)
+
 enum sdhci_cookie {
 	COOKIE_UNMAPPED,
 	COOKIE_PRE_MAPPED,	/* mapped by sdhci_pre_req() */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index d9a65c6..9c50bc4 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -99,6 +99,12 @@ static inline bool mmc_op_multi(u32 opcode)
 	       opcode == MMC_READ_MULTIPLE_BLOCK;
 }
 
+static inline bool mmc_op_tuning(u32 opcode)
+{
+	return opcode == MMC_SEND_TUNING_BLOCK ||
+			opcode == MMC_SEND_TUNING_BLOCK_HS200;
+}
+
 /*
  * MMC_SWITCH argument format:
  *
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

