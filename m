Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACDA52B602
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiERJK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbiERJKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:10:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49135E47;
        Wed, 18 May 2022 02:10:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 51E3C1F4432B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652865045;
        bh=FlrKwEJaWOEcsQb+NEXsjeQ2j8JFEBDbmFMsL5Q5hK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wqi00/h/rLUy4nZRdCsCz6bv47BFhnhvAHEc1mXljIaU1uSOjfKZGIDCOJhrMZGzd
         K6uLVba1kIshyPketkRmAvCOlNRsDSe3zDvtqQI/w5CtcnZ2Ht5C5ZgCRQS3rThAGg
         8wUMyY3AbTkdu177rskNbUU3CpbG1RaIdjbMlMN2F7TZX6c7Sy8qTy8r1QqNq2Du2V
         pdhc0PWm1xnUFAYxob5AKbjlZXIx8rwEgX1nShxlGy55seZaOQ1hxukhPYoOXbz/8T
         Ai3s2ZaIA6YjcnRhrlFtNhTilI5ZVOBFatqH8P5+ywsIc4w2YQa7FslrRay9qOmhKq
         RE2aTol+pl3Vg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 2/2] memory: mtk-smi: Add support for MT6795 Helio X10
Date:   Wed, 18 May 2022 11:10:38 +0200
Message-Id: <20220518091038.22380-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518091038.22380-1-angelogioacchino.delregno@collabora.com>
References: <20220518091038.22380-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek Helio X10 (MT6795) SoC has 5 LARBs and one common SMI
instance without any sub-common and without GALS.

While the smi-common configuration is specific to this SoC, on the
LARB side, this is similar to MT8173, in the sense that it doesn't
need the port in LARB, and the register layout is also compatible
with that one, which makes us able to fully reuse the smi-larb
platform data struct that was introduced for MT8173.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 86a3d34f418e..7d26bc3485fd 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -21,11 +21,13 @@
 /* SMI COMMON */
 #define SMI_L1LEN			0x100
 
+#define SMI_L1_ARB			0x200
 #define SMI_BUS_SEL			0x220
 #define SMI_BUS_LARB_SHIFT(larbid)	((larbid) << 1)
 /* All are MMU0 defaultly. Only specialize mmu1 here. */
 #define F_MMU1_LARB(larbid)		(0x1 << SMI_BUS_LARB_SHIFT(larbid))
 
+#define SMI_READ_FIFO_TH		0x230
 #define SMI_M4U_TH			0x234
 #define SMI_FIFO_TH1			0x238
 #define SMI_FIFO_TH2			0x23c
@@ -360,6 +362,7 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{.compatible = "mediatek,mt2701-smi-larb", .data = &mtk_smi_larb_mt2701},
 	{.compatible = "mediatek,mt2712-smi-larb", .data = &mtk_smi_larb_mt2712},
 	{.compatible = "mediatek,mt6779-smi-larb", .data = &mtk_smi_larb_mt6779},
+	{.compatible = "mediatek,mt6795-smi-larb", .data = &mtk_smi_larb_mt8173},
 	{.compatible = "mediatek,mt8167-smi-larb", .data = &mtk_smi_larb_mt8167},
 	{.compatible = "mediatek,mt8173-smi-larb", .data = &mtk_smi_larb_mt8173},
 	{.compatible = "mediatek,mt8183-smi-larb", .data = &mtk_smi_larb_mt8183},
@@ -541,6 +544,13 @@ static struct platform_driver mtk_smi_larb_driver = {
 	}
 };
 
+static const struct mtk_smi_reg_pair mtk_smi_common_mt6795_init[SMI_COMMON_INIT_REGS_NR] = {
+	{SMI_L1_ARB, 0x1b},
+	{SMI_M4U_TH, 0xce810c85},
+	{SMI_FIFO_TH1, 0x43214c8},
+	{SMI_READ_FIFO_TH, 0x191f},
+};
+
 static const struct mtk_smi_reg_pair mtk_smi_common_mt8195_init[SMI_COMMON_INIT_REGS_NR] = {
 	{SMI_L1LEN, 0xb},
 	{SMI_M4U_TH, 0xe100e10},
@@ -565,6 +575,12 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt6779 = {
 		    F_MMU1_LARB(5) | F_MMU1_LARB(6) | F_MMU1_LARB(7),
 };
 
+static const struct mtk_smi_common_plat mtk_smi_common_mt6795 = {
+	.type	  = MTK_SMI_GEN2,
+	.bus_sel  = F_MMU1_LARB(0),
+	.init     = mtk_smi_common_mt6795_init,
+};
+
 static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
 	.type     = MTK_SMI_GEN2,
 	.has_gals = true,
@@ -609,6 +625,7 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{.compatible = "mediatek,mt2701-smi-common", .data = &mtk_smi_common_gen1},
 	{.compatible = "mediatek,mt2712-smi-common", .data = &mtk_smi_common_gen2},
 	{.compatible = "mediatek,mt6779-smi-common", .data = &mtk_smi_common_mt6779},
+	{.compatible = "mediatek,mt6795-smi-common", .data = &mtk_smi_common_mt6795},
 	{.compatible = "mediatek,mt8167-smi-common", .data = &mtk_smi_common_gen2},
 	{.compatible = "mediatek,mt8173-smi-common", .data = &mtk_smi_common_gen2},
 	{.compatible = "mediatek,mt8183-smi-common", .data = &mtk_smi_common_mt8183},
-- 
2.35.1

