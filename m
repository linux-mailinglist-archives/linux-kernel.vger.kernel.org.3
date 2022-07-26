Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AF45814F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbiGZOR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbiGZORk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:17:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C18E2870E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:17:36 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C3DC26601B23;
        Tue, 26 Jul 2022 15:17:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658845055;
        bh=AHG4+jEaEDFr9xaoQpgJI1/zRGeAc4nkoFr0uAgZJkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsCoduHAL5q1mNuESUMDSIwO9M2a5travyRW3DGyox+IEOjpgqIYslk8NCdeCkgl+
         kmPEbGBceeo/0xB++mrNAxHXDc0JYm4J3ByqPjGAgYNCKrT/HiOmlJ4W6vdL9O/xdk
         J/lr/ADLeZ6gn+8pIg6Az9DOW2Jq35aol8m63jjEsjJWQ0MVOz/teSPXK1dI8by3m0
         uJN65AJTb8pwyoHI1MKFMqoVM1vdE+GLGD0HXL5ynJbkdsptxSFnGV6TZdNsMRPrwv
         PpLFcEJFVyMpSNNMBnVdwMaeRvddaNpdCE08eBIX4+Ytj+ZIr5QMAruljdc1LgXVny
         1a0D32Wn/19JA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     roger.lu@mediatek.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 3/6] soc: mediatek: mtk-svs: Remove hardcoded irqflags
Date:   Tue, 26 Jul 2022 16:16:50 +0200
Message-Id: <20220726141653.177948-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
References: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt flags are specified in devicetree: forcing them into
the driver is suboptimal and not very useful.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index ee990acfc2d5..fcf246a6bb07 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -262,7 +262,6 @@ static const u32 svs_regs_v2[] = {
  * @rst: svs platform reset control
  * @efuse_parsing: svs platform efuse parsing function pointer
  * @probe: svs platform probe function pointer
- * @irqflags: svs platform irq settings flags
  * @efuse_max: total number of svs efuse
  * @tefuse_max: total number of thermal efuse
  * @regs: svs platform registers map
@@ -280,7 +279,6 @@ struct svs_platform {
 	struct reset_control *rst;
 	bool (*efuse_parsing)(struct svs_platform *svsp);
 	int (*probe)(struct svs_platform *svsp);
-	unsigned long irqflags;
 	size_t efuse_max;
 	size_t tefuse_max;
 	const u32 *regs;
@@ -294,7 +292,6 @@ struct svs_platform_data {
 	struct svs_bank *banks;
 	bool (*efuse_parsing)(struct svs_platform *svsp);
 	int (*probe)(struct svs_platform *svsp);
-	unsigned long irqflags;
 	const u32 *regs;
 	u32 bank_max;
 };
@@ -2680,7 +2677,6 @@ static const struct svs_platform_data svs_mt8192_platform_data = {
 	.banks = svs_mt8192_banks,
 	.efuse_parsing = svs_mt8192_efuse_parsing,
 	.probe = svs_mt8192_platform_probe,
-	.irqflags = IRQF_TRIGGER_HIGH,
 	.regs = svs_regs_v2,
 	.bank_max = ARRAY_SIZE(svs_mt8192_banks),
 };
@@ -2699,7 +2695,6 @@ static const struct svs_platform_data svs_mt8183_platform_data = {
 	.banks = svs_mt8183_banks,
 	.efuse_parsing = svs_mt8183_efuse_parsing,
 	.probe = svs_mt8183_platform_probe,
-	.irqflags = IRQF_TRIGGER_LOW,
 	.regs = svs_regs_v2,
 	.bank_max = ARRAY_SIZE(svs_mt8183_banks),
 };
@@ -2743,7 +2738,6 @@ static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
 	svsp->banks = svsp_data->banks;
 	svsp->efuse_parsing = svsp_data->efuse_parsing;
 	svsp->probe = svsp_data->probe;
-	svsp->irqflags = svsp_data->irqflags;
 	svsp->regs = svsp_data->regs;
 	svsp->bank_max = svsp_data->bank_max;
 
@@ -2782,8 +2776,7 @@ static int svs_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
-					svsp->irqflags | IRQF_ONESHOT,
-					svsp->name, svsp);
+					IRQF_ONESHOT, svsp->name, svsp);
 	if (ret) {
 		dev_err(svsp->dev, "register irq(%d) failed: %d\n",
 			svsp_irq, ret);
-- 
2.35.1

