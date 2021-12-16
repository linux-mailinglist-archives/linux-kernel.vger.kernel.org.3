Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6A4477260
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbhLPM55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbhLPM55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:57:57 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5EEC061574;
        Thu, 16 Dec 2021 04:57:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AE4C81F4581D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639659475; bh=upDPcbxBYutQtszG8wB8h6Plz3y3C270hIXAtcwT3uc=;
        h=From:To:Cc:Subject:Date:From;
        b=lT/N3y1Q5eNFji0fTHTbRaij5rW4KmqMjOG7yMWOHj60FPDJwqHv+X5HvhWnwfXS3
         WeRBEOLCLJ5nMGmbNZmtKH3MvnbILVM9CVlmjTXMI8Pk07Na1R0C7RDdsdN/8zha+i
         gQwkNB4OoMu+HX+RFW52IQjOPpIlj/CTNtmREpxH0BoSmZ1qxi2UmjAwzTqz8HFXq2
         LdpCdozpnZhMbFZyP/Qanp+lGnsDQ5hcmppGXIHk1R1B/NoEgcdiXRBpaca/4Fu4nE
         0Cm4S6ynIXNMjscrya3BRNAKEC65mVWpRiZ9P0+9Py3fb7F5gS2+CuWFd3AM01PJI/
         2LWHk3tqo1KFg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chaotian.jing@mediatek.com
Cc:     ulf.hansson@linaro.org, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/5] mmc: mtk-sd: Use readl_poll_timeout instead of open-coded polling
Date:   Thu, 16 Dec 2021 13:57:44 +0100
Message-Id: <20211216125748.179602-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace all instances of open-coded while loops for polling registers
with calls to readl_poll_timeout() and, while at it, also fix some
possible infinite loop instances.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 64 ++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 632775217d35..d5a9c269d492 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -636,12 +636,11 @@ static void msdc_reset_hw(struct msdc_host *host)
 	u32 val;
 
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_RST);
-	while (readl(host->base + MSDC_CFG) & MSDC_CFG_RST)
-		cpu_relax();
+	readl_poll_timeout(host->base + MSDC_CFG, val, !(val & MSDC_CFG_RST), 0, 0);
 
 	sdr_set_bits(host->base + MSDC_FIFOCS, MSDC_FIFOCS_CLR);
-	while (readl(host->base + MSDC_FIFOCS) & MSDC_FIFOCS_CLR)
-		cpu_relax();
+	readl_poll_timeout(host->base + MSDC_FIFOCS, val,
+			   !(val & MSDC_FIFOCS_CLR), 0, 0);
 
 	val = readl(host->base + MSDC_INT);
 	writel(val, host->base + MSDC_INT);
@@ -814,8 +813,9 @@ static void msdc_gate_clock(struct msdc_host *host)
 	clk_disable_unprepare(host->h_clk);
 }
 
-static void msdc_ungate_clock(struct msdc_host *host)
+static int msdc_ungate_clock(struct msdc_host *host)
 {
+	u32 val;
 	int ret;
 
 	clk_prepare_enable(host->h_clk);
@@ -825,11 +825,11 @@ static void msdc_ungate_clock(struct msdc_host *host)
 	ret = clk_bulk_prepare_enable(MSDC_NR_CLOCKS, host->bulk_clks);
 	if (ret) {
 		dev_err(host->dev, "Cannot enable pclk/axi/ahb clock gates\n");
-		return;
+		return ret;
 	}
 
-	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
-		cpu_relax();
+	return readl_poll_timeout(host->base + MSDC_CFG, val,
+				  (val & MSDC_CFG_CKSTB), 1, 20000);
 }
 
 static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
@@ -840,6 +840,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	u32 div;
 	u32 sclk;
 	u32 tune_reg = host->dev_comp->pad_tune_reg;
+	u32 val;
 
 	if (!hz) {
 		dev_dbg(host->dev, "set mclk to 0\n");
@@ -920,8 +921,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	else
 		clk_prepare_enable(clk_get_parent(host->src_clk));
 
-	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
-		cpu_relax();
+	readl_poll_timeout(host->base + MSDC_CFG, val, (val & MSDC_CFG_CKSTB), 0, 0);
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
 	mmc->actual_clock = sclk;
 	host->mclk = hz;
@@ -1231,13 +1231,13 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 static inline bool msdc_cmd_is_ready(struct msdc_host *host,
 		struct mmc_request *mrq, struct mmc_command *cmd)
 {
-	/* The max busy time we can endure is 20ms */
-	unsigned long tmo = jiffies + msecs_to_jiffies(20);
+	u32 val;
+	int ret;
 
-	while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) &&
-			time_before(jiffies, tmo))
-		cpu_relax();
-	if (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) {
+	/* The max busy time we can endure is 20ms */
+	ret = readl_poll_timeout_atomic(host->base + SDC_STS, val,
+					!(val & SDC_STS_CMDBUSY), 1, 20000);
+	if (ret) {
 		dev_err(host->dev, "CMD bus busy detected\n");
 		host->error |= REQ_CMD_BUSY;
 		msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
@@ -1245,12 +1245,10 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
 	}
 
 	if (mmc_resp_type(cmd) == MMC_RSP_R1B || cmd->data) {
-		tmo = jiffies + msecs_to_jiffies(20);
 		/* R1B or with data, should check SDCBUSY */
-		while ((readl(host->base + SDC_STS) & SDC_STS_SDCBUSY) &&
-				time_before(jiffies, tmo))
-			cpu_relax();
-		if (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY) {
+		ret = readl_poll_timeout_atomic(host->base + SDC_STS, val,
+						!(val & SDC_STS_SDCBUSY), 1, 20000);
+		if (ret) {
 			dev_err(host->dev, "Controller busy detected\n");
 			host->error |= REQ_CMD_BUSY;
 			msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
@@ -1376,6 +1374,8 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
 	    (MSDC_INT_XFER_COMPL | MSDC_INT_DATCRCERR | MSDC_INT_DATTMO
 	     | MSDC_INT_DMA_BDCSERR | MSDC_INT_DMA_GPDCSERR
 	     | MSDC_INT_DMA_PROTECT);
+	u32 val;
+	int ret;
 
 	spin_lock_irqsave(&host->lock, flags);
 	done = !host->data;
@@ -1392,8 +1392,14 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
 				readl(host->base + MSDC_DMA_CFG));
 		sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_STOP,
 				1);
-		while (readl(host->base + MSDC_DMA_CFG) & MSDC_DMA_CFG_STS)
-			cpu_relax();
+
+		ret = readl_poll_timeout_atomic(host->base + MSDC_DMA_CFG, val,
+						!(val & MSDC_DMA_CFG_STS), 1, 20000);
+		if (ret) {
+			dev_dbg(host->dev, "DMA stop timed out\n");
+			return false;
+		}
+
 		sdr_clr_bits(host->base + MSDC_INTEN, data_ints_mask);
 		dev_dbg(host->dev, "DMA stop\n");
 
@@ -2674,7 +2680,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	spin_lock_init(&host->lock);
 
 	platform_set_drvdata(pdev, mmc);
-	msdc_ungate_clock(host);
+	ret = msdc_ungate_clock(host);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot ungate clocks!\n");
+		goto release_mem;
+	}
 	msdc_init_hw(host);
 
 	if (mmc->caps2 & MMC_CAP2_CQE) {
@@ -2833,8 +2843,12 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct msdc_host *host = mmc_priv(mmc);
+	int ret;
+
+	ret = msdc_ungate_clock(host);
+	if (ret)
+		return ret;
 
-	msdc_ungate_clock(host);
 	msdc_restore_reg(host);
 	return 0;
 }
-- 
2.33.1

