Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A00A477266
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbhLPM6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbhLPM56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:57:58 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61DCC06173E;
        Thu, 16 Dec 2021 04:57:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 297CB1F46298
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639659477; bh=95YUTGCKclJCUo/J155djD8op/COnXfCbxovpAt5hxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdbzPwtKhwCYjZKlDiDthkB+6tSWZji+3jf8o/GV58yYnsMn0Nzcbsf5Tk97wP+rY
         XbJIQIihjHjgh4kYyJWk07ROWclHlKF4yuVSDDjCXOO98NlmXHrHdXOa+tSsBZDSqX
         Fm5U9ChqNNukayNV0imYaUgxXeA5hC9DtZWToZoJruBNe27EflMuIRwqpYjixHXNCC
         afCw+0QpvfCVgTXv2j+k1/vjKlrYF4gXWZYhQzGeKGUqPzG6rImHVkFmscwIxJ7b83
         /GTe28P3IANYbITM/3BJc80JZ4U170jMW1HMvRV9i33/laKTzi6c0ULRB2mPso5rG6
         6zqE+NUnF8q+w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chaotian.jing@mediatek.com
Cc:     ulf.hansson@linaro.org, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 5/5] mmc: mtk-sd: Assign src_clk parent to src_clk_cg for legacy DTs
Date:   Thu, 16 Dec 2021 13:57:48 +0100
Message-Id: <20211216125748.179602-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211216125748.179602-1-angelogioacchino.delregno@collabora.com>
References: <20211216125748.179602-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 3c1a88443698 ("mmc: mediatek: add support of source_cg clock")
an independent cg was introduced to avoid a hardware hang issue during
clock mode switches (subsequent commits will set that clock as optional).

When this clock is not present in device-tree, any operation is being
done on src_clk's parent (calling clk_get_parent()): to simplify this
and avoid checking for src_clk_cg presence everytime, just assign the
parent clock to src_clk_cg and remove the now useless checks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 59d7decc3051..65037e1d7723 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -901,14 +901,8 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 		}
 	}
 	sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
-	/*
-	 * As src_clk/HCLK use the same bit to gate/ungate,
-	 * So if want to only gate src_clk, need gate its parent(mux).
-	 */
-	if (host->src_clk_cg)
-		clk_disable_unprepare(host->src_clk_cg);
-	else
-		clk_disable_unprepare(clk_get_parent(host->src_clk));
+
+	clk_disable_unprepare(host->src_clk_cg);
 	if (host->dev_comp->clk_div_bits == 8)
 		sdr_set_field(host->base + MSDC_CFG,
 			      MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
@@ -917,11 +911,8 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 		sdr_set_field(host->base + MSDC_CFG,
 			      MSDC_CFG_CKMOD_EXTRA | MSDC_CFG_CKDIV_EXTRA,
 			      (mode << 12) | div);
-	if (host->src_clk_cg)
-		clk_prepare_enable(host->src_clk_cg);
-	else
-		clk_prepare_enable(clk_get_parent(host->src_clk));
 
+	clk_prepare_enable(host->src_clk_cg);
 	readl_poll_timeout(host->base + MSDC_CFG, val, (val & MSDC_CFG_CKSTB), 0, 0);
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
 	mmc->actual_clock = sclk;
@@ -2530,6 +2521,19 @@ static int msdc_of_clock_parse(struct platform_device *pdev,
 	if (IS_ERR(host->src_clk_cg))
 		return PTR_ERR(host->src_clk_cg);
 
+	/*
+	 * Fallback for legacy device-trees: src_clk and HCLK use the same
+	 * bit to control gating but they are parented to a different mux,
+	 * hence if our intention is to gate only the source, required
+	 * during a clk mode switch to avoid hw hangs, we need to gate
+	 * its parent (specified as a different clock only on new DTs).
+	 */
+	if (!host->src_clk_cg) {
+		host->src_clk_cg = clk_get_parent(host->src_clk);
+		if (IS_ERR(host->src_clk_cg))
+			return PTR_ERR(host->src_clk_cg);
+	}
+
 	host->sys_clk_cg = devm_clk_get_optional(&pdev->dev, "sys_cg");
 	if (IS_ERR(host->sys_clk_cg))
 		host->sys_clk_cg = NULL;
-- 
2.33.1

