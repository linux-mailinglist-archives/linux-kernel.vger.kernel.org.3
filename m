Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC552497F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbiAXMYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:24:05 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:52336 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239140AbiAXMYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:24:04 -0500
X-UUID: 7495296568a1467ab7ba9ce6c7b92a5f-20220124
X-UUID: 7495296568a1467ab7ba9ce6c7b92a5f-20220124
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <derong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1179741836; Mon, 24 Jan 2022 20:24:00 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 24 Jan 2022 20:23:59 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Jan 2022 20:23:58 +0800
From:   Derong Liu <derong.liu@mediatek.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsp_upstream@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Derong Liu <derong.liu@mediatek.com>
Subject: [PATCH] mmc: mediatek: Add cmd polling mode
Date:   Mon, 24 Jan 2022 20:18:14 +0800
Message-ID: <20220124121814.17452-1-derong.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found sdcard can gain more read/write performance
when using cmd polling mode instead of interrupt mode, in the meantime,
there are much more devices have equipped with high frequency cpu,
so it is necessary to support cmd polling mode.

Signed-off-by: Derong Liu <derong.liu@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 92 +++++++++++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 65037e1d7723..612f5115ca4b 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -465,6 +465,7 @@ struct msdc_host {
 	bool hs400_tuning;	/* hs400 mode online tuning */
 	bool internal_cd;	/* Use internal card-detect logic */
 	bool cqhci;		/* support eMMC hw cmdq */
+	bool cmd_polling_mode;	/* support cmd polling mode */
 	struct msdc_save_para save_para; /* used when gate HCLK */
 	struct msdc_tune_para def_tune_para; /* default tune setting */
 	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
@@ -1250,6 +1251,63 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
 	return true;
 }
 
+static inline int use_cmd_polling_mode(struct msdc_host *host,
+	struct mmc_command *cmd)
+{
+	/* R1B use interrupt mode */
+	return (host->cmd_polling_mode &&
+			((mmc_from_priv(host))->caps2 & MMC_CAP2_NO_SDIO) &&
+			(mmc_resp_type(cmd) != MMC_RSP_R1B));
+}
+
+static bool msdc_command_resp_polling(struct msdc_host *host,
+	struct mmc_request *mrq, struct mmc_command *cmd,
+	unsigned long timeout)
+{
+	bool ret = false;
+	unsigned long tmo;
+	int events;
+	unsigned long flags;
+
+	if (!use_cmd_polling_mode(host, cmd))
+		goto exit;
+
+retry:
+	tmo = jiffies + timeout;
+	while (1) {
+		spin_lock_irqsave(&host->lock, flags);
+		events = readl(host->base + MSDC_INT);
+		if (events & cmd_ints_mask) {
+			/* clear all int flag */
+			events &= cmd_ints_mask;
+			writel(events, host->base + MSDC_INT);
+			spin_unlock_irqrestore(&host->lock, flags);
+			break;
+		}
+		spin_unlock_irqrestore(&host->lock, flags);
+
+		if (time_after(jiffies, tmo) &&
+			((events & cmd_ints_mask) == 0)) {
+			dev_info(host->dev, "[%s]: CMD<%d> polling_for_completion timeout ARG<0x%.8x>\n",
+				__func__, cmd->opcode, cmd->arg);
+			ret = msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
+			goto exit;
+		}
+	}
+
+	if (cmd) {
+		ret = msdc_cmd_done(host, events, mrq, cmd);
+		/* if only autocmd23 done,
+		 * it needs to polling the continue read/write cmd directly.
+		 */
+		if (!ret)
+			goto retry;
+	}
+
+exit:
+	return ret;
+}
+
 static void msdc_start_command(struct msdc_host *host,
 		struct mmc_request *mrq, struct mmc_command *cmd)
 {
@@ -1273,7 +1331,10 @@ static void msdc_start_command(struct msdc_host *host,
 	rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
 
 	spin_lock_irqsave(&host->lock, flags);
-	sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
+	if (use_cmd_polling_mode(host, cmd))
+		sdr_clr_bits(host->base + MSDC_INTEN, cmd_ints_mask);
+	else
+		sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	writel(cmd->arg, host->base + SDC_ARG);
@@ -1290,9 +1351,11 @@ static void msdc_cmd_next(struct msdc_host *host,
 	       host->hs400_tuning))) ||
 	    (mrq->sbc && mrq->sbc->error))
 		msdc_request_done(host, mrq);
-	else if (cmd == mrq->sbc)
+	else if (cmd == mrq->sbc) {
 		msdc_start_command(host, mrq, mrq->cmd);
-	else if (!cmd->data)
+		msdc_command_resp_polling(host, mrq,
+				mrq->cmd, CMD_TIMEOUT);
+	} else if (!cmd->data)
 		msdc_request_done(host, mrq);
 	else
 		msdc_start_data(host, cmd, cmd->data);
@@ -1314,10 +1377,15 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	 * use HW option,  otherwise use SW option
 	 */
 	if (mrq->sbc && (!mmc_card_mmc(mmc->card) ||
-	    (mrq->sbc->arg & 0xFFFF0000)))
+	    (mrq->sbc->arg & 0xFFFF0000))) {
 		msdc_start_command(host, mrq, mrq->sbc);
-	else
+		msdc_command_resp_polling(host, mrq,
+				mrq->sbc, CMD_TIMEOUT);
+	} else {
 		msdc_start_command(host, mrq, mrq->cmd);
+		msdc_command_resp_polling(host, mrq,
+				mrq->cmd, CMD_TIMEOUT);
+	}
 }
 
 static void msdc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -1350,9 +1418,11 @@ static void msdc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 static void msdc_data_xfer_next(struct msdc_host *host, struct mmc_request *mrq)
 {
 	if (mmc_op_multi(mrq->cmd->opcode) && mrq->stop && !mrq->stop->error &&
-	    !mrq->sbc)
+	    !mrq->sbc) {
 		msdc_start_command(host, mrq, mrq->stop);
-	else
+		msdc_command_resp_polling(host, mrq,
+				mrq->stop, CMD_TIMEOUT);
+	} else
 		msdc_request_done(host, mrq);
 }
 
@@ -2492,11 +2562,15 @@ static void msdc_of_property_parse(struct platform_device *pdev,
 	else
 		host->hs400_cmd_resp_sel_rising = false;
 
-	if (of_property_read_bool(pdev->dev.of_node,
-				  "supports-cqe"))
+	if (of_property_read_bool(pdev->dev.of_node, "supports-cqe"))
 		host->cqhci = true;
 	else
 		host->cqhci = false;
+
+	if (of_property_read_bool(pdev->dev.of_node, "mediatek,cmd-polling-mode"))
+		host->cmd_polling_mode = true;
+	else
+		host->cmd_polling_mode = false;
 }
 
 static int msdc_of_clock_parse(struct platform_device *pdev,
-- 
2.18.0

