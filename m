Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A38533CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243186AbiEYM3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241704AbiEYM2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:28:54 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6437B6D3B5;
        Wed, 25 May 2022 05:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653481733; x=1685017733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=wPKTjp4pBEiMz4EdkImMhZtUIupns5o1HS/xgzUFg7g=;
  b=Yy2Th0jcWnq/WXMqyHxf4Yu3ggCX+7/CdPIYxRnCnDSsPXcjo7dc8OCO
   8VsjHkOz0kf44M1utE1cUt2U08FoH/uv3QtDJf8WIgpNwAAy8n1s+IR14
   DCqMyMHj8GnXTCG4xR+h5Prcx13Ammp2RGB/EZ+iCtCIvL7xwHIHi+DYD
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 May 2022 05:28:53 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 May 2022 05:28:51 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 25 May 2022 17:58:27 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 3CE99180E; Wed, 25 May 2022 17:58:26 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        chris@printf.net, venkatg@codeaurora.org, gdjakov@mm-sol.com,
        quic_asutoshd@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
Subject: [PATCH V7 2/4] mmc: sdhci: Capture eMMC and SD card errors
Date:   Wed, 25 May 2022 17:58:19 +0530
Message-Id: <1653481701-19642-3-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653481701-19642-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1653481701-19642-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 33 ++++++++++++++++++++++++++-------
 drivers/mmc/host/sdhci.h |  3 +++
 include/linux/mmc/mmc.h  |  6 ++++++
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4805566..95c1b39 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -183,6 +183,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 		if (timeout == 0) {
 			pr_err("%s: Reset 0x%x never completed.\n",
 				mmc_hostname(host->mmc), (int)mask);
+			sdhci_err_stats_inc(host, CTRL_TIMEOUT);
 			sdhci_dumpregs(host);
 			return;
 		}
@@ -1093,6 +1094,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		if (timeout == 0) {
 			pr_err("%s: Controller never released inhibit bit(s).\n",
 			       mmc_hostname(host->mmc));
+			sdhci_err_stats_inc(host, CTRL_TIMEOUT);
 			sdhci_dumpregs(host);
 			cmd->error = -EIO;
 			sdhci_finish_mrq(host, cmd->mrq);
@@ -1363,6 +1365,7 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		if (timeout == 0) {
 			pr_err("%s: Internal clock never stabilised.\n",
 			       mmc_hostname(host->mmc));
+			sdhci_err_stats_inc(host, CTRL_TIMEOUT);
 			sdhci_dumpregs(host);
 			return;
 		}
@@ -2362,6 +2365,7 @@ static void sdhci_timeout_timer(unsigned long data)
 	if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
 		pr_err("%s: Timeout waiting for hardware cmd interrupt.\n",
 		       mmc_hostname(host->mmc));
+		sdhci_err_stats_inc(host, REQ_TIMEOUT);
 		sdhci_dumpregs(host);
 
 		host->cmd->error = -ETIMEDOUT;
@@ -2385,6 +2389,7 @@ static void sdhci_timeout_data_timer(unsigned long data)
 	    (host->cmd && sdhci_data_line_cmd(host->cmd))) {
 		pr_err("%s: Timeout waiting for hardware interrupt.\n",
 		       mmc_hostname(host->mmc));
+		sdhci_err_stats_inc(host, REQ_TIMEOUT);
 		sdhci_dumpregs(host);
 
 		if (host->data) {
@@ -2421,16 +2426,21 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
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
+			if (!mmc_op_tuning(host->cmd->opcode))
+				sdhci_err_stats_inc(host, CMD_CRC);
+		}
 
 		/*
 		 * If this command initiates a data phase and a response
@@ -2524,6 +2534,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		if (data_cmd && (data_cmd->flags & MMC_RSP_BUSY)) {
 			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
 				data_cmd->error = -ETIMEDOUT;
+				sdhci_err_stats_inc(host, CMD_TIMEOUT);
 				sdhci_finish_mrq(host, data_cmd->mrq);
 				return;
 			}
@@ -2551,22 +2562,29 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 
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
+	} else if (intmask & SDHCI_INT_DATA_END_BIT) {
 		host->data->error = -EILSEQ;
-	else if ((intmask & SDHCI_INT_DATA_CRC) &&
+		if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
+			sdhci_err_stats_inc(host, DAT_CRC);
+	} else if ((intmask & SDHCI_INT_DATA_CRC) &&
 		SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))
-			!= MMC_BUS_TEST_R)
+			!= MMC_BUS_TEST_R) {
 		host->data->error = -EILSEQ;
-	else if (intmask & SDHCI_INT_ADMA_ERROR) {
+		if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
+			sdhci_err_stats_inc(host, DAT_CRC);
+	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
 		pr_err("%s: ADMA error\n", mmc_hostname(host->mmc));
 		sdhci_adma_show_error(host);
+		sdhci_err_stats_inc(host, ADMA);
 		host->data->error = -EIO;
 		if (host->ops->adma_workaround)
 			host->ops->adma_workaround(host, intmask);
@@ -2720,6 +2738,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	if (unexpected) {
 		pr_err("%s: Unexpected interrupt 0x%08x.\n",
 			   mmc_hostname(host->mmc), unexpected);
+		sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
 		sdhci_dumpregs(host);
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c722cd2..492a350 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -321,6 +321,9 @@ struct sdhci_adma2_64_desc {
 /* Allow for a a command request and a data request at the same time */
 #define SDHCI_MAX_MRQS		2
 
+#define sdhci_err_stats_inc(host, err_name) \
+	mmc_debugfs_err_stats_inc((host)->mmc, MMC_ERR_##err_name)
+
 enum sdhci_cookie {
 	COOKIE_UNMAPPED,
 	COOKIE_PRE_MAPPED,	/* mapped by sdhci_pre_req() */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index c376209..2d66c89 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -90,6 +90,12 @@ static inline bool mmc_op_multi(u32 opcode)
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

