Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C061D477262
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbhLPM6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbhLPM55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:57:57 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932CDC061574;
        Thu, 16 Dec 2021 04:57:57 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E6C771F4628E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639659476; bh=4TdGbUGIeTVxOIguEjJvEZfyGK3EgCiTdErpnWEzqWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atnacH+mBG+G5Tq9HQwafvLXg/nC8eiWi2MxeJIo8GRcFnYqpaVy7AiY6FXBqmNXP
         7LOdvnTL7437yXU6tpolFxjase3HSdVyCFBQTis1SHV00mOh4zXwPXJawZrqs/Uz8S
         jRowMD3Xnohgzr7erUgrzGCqpvY2iAuMndkNCMeJlAdsSW/uSH2DQZMAUeBsFZu3aY
         OM5mK7LPANu/mt/qaRR7JCkzmK4WUd3wTqjPJXWOJ5ThA4bAMGIbWbpASM0E1PRg5p
         2v+5FCN9Zl2mSzCfyYvelVdGT9Lz31ylktEq2XCpjR9KTNUnhDCHKvwcDRvbZ4L9JZ
         4rfmqDhj8r4vQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chaotian.jing@mediatek.com
Cc:     ulf.hansson@linaro.org, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 3/5] mmc: mtk-sd: Take action for no-sdio device-tree parameter
Date:   Thu, 16 Dec 2021 13:57:46 +0100
Message-Id: <20211216125748.179602-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211216125748.179602-1-angelogioacchino.delregno@collabora.com>
References: <20211216125748.179602-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver was unconditionally enabling support for SDIO mode,
but we do have a generic "no-sdio" DT parameter that sets caps2
MMC_CAP2_NO_SDIO.

Modify the HW initialization sequence to enable SDIO support only
if it hasn't been explicitly disabled in device-tree.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index d067636434ca..f08695e52601 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1638,6 +1638,7 @@ static void msdc_init_hw(struct msdc_host *host)
 {
 	u32 val;
 	u32 tune_reg = host->dev_comp->pad_tune_reg;
+	struct mmc_host *mmc = mmc_from_priv(host);
 
 	if (host->reset) {
 		reset_control_assert(host->reset);
@@ -1743,14 +1744,18 @@ static void msdc_init_hw(struct msdc_host *host)
 				     MSDC_PAD_TUNE_RXDLYSEL);
 	}
 
-	/* Configure to enable SDIO mode.
-	 * it's must otherwise sdio cmd5 failed
-	 */
-	sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
+	if (mmc->caps2 & MMC_CAP2_NO_SDIO) {
+		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
+		sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
+		sdr_clr_bits(host->base + SDC_ADV_CFG0, SDC_DAT1_IRQ_TRIGGER);
+	} else {
+		/* Configure to enable SDIO mode, otherwise SDIO CMD5 fails */
+		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
 
-	/* Config SDIO device detect interrupt function */
-	sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
-	sdr_set_bits(host->base + SDC_ADV_CFG0, SDC_DAT1_IRQ_TRIGGER);
+		/* Config SDIO device detect interrupt function */
+		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+		sdr_set_bits(host->base + SDC_ADV_CFG0, SDC_DAT1_IRQ_TRIGGER);
+	}
 
 	/* Configure to default data timeout */
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
-- 
2.33.1

