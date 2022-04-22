Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C526F50BA50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448759AbiDVOlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448757AbiDVOk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0EF5BD3B;
        Fri, 22 Apr 2022 07:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB86360A6A;
        Fri, 22 Apr 2022 14:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A66C385A4;
        Fri, 22 Apr 2022 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650638285;
        bh=2KebUru9Oip9dwY6heZ6bnUO3jvAGYTmEfS1DsUFi3Q=;
        h=From:To:Cc:Subject:Date:From;
        b=Mfj6dWMxh99Gz193yLbjJA6A8S0nfoOyYro41TieznHo2CfRLaNXSp1nLz2WGMXxs
         iZrMWJTT4P0wU9C35c8ezGmYqW98A4hqworQy5NVgaAu3vOdrP0BTY5m3cltV5bXME
         kBTOlulQjJ9Utq7Q2Gzaa9kh1aRyRQVRU/pvgSCsw7EDoO02eMtpxTFy5N+H2ve164
         rE09lZ17NluAimAgO5g+AD0yxKZBMfah6W9d7Ixb/60j2L1/DbZKEnP9zIX/oz16P1
         ldZbT31gBN9QrbtyyMh9VnmiTvjjRbAB+vTlje54hMpTDu8NNVroCVmwCo1ol1zCIV
         4RBabTRGhDaIQ==
From:   matthias.bgg@kernel.org
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     weiyi.lu@mediatek.com, chun-jie.chen@mediatek.com,
        ikjn@chromium.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        allen-kh.cheng@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] clk: mediatek: Delete MT8192 msdc gate
Date:   Fri, 22 Apr 2022 16:37:56 +0200
Message-Id: <20220422143756.14806-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The msdc gate is part of the MMC driver. Delete the not used code.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/clk/mediatek/clk-mt8192-msdc.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8192-msdc.c b/drivers/clk/mediatek/clk-mt8192-msdc.c
index 87c3b79b79cf..635f7a0b629a 100644
--- a/drivers/clk/mediatek/clk-mt8192-msdc.c
+++ b/drivers/clk/mediatek/clk-mt8192-msdc.c
@@ -12,28 +12,15 @@
 
 #include <dt-bindings/clock/mt8192-clk.h>
 
-static const struct mtk_gate_regs msdc_cg_regs = {
-	.set_ofs = 0xb4,
-	.clr_ofs = 0xb4,
-	.sta_ofs = 0xb4,
-};
-
 static const struct mtk_gate_regs msdc_top_cg_regs = {
 	.set_ofs = 0x0,
 	.clr_ofs = 0x0,
 	.sta_ofs = 0x0,
 };
 
-#define GATE_MSDC(_id, _name, _parent, _shift)	\
-	GATE_MTK(_id, _name, _parent, &msdc_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
-
 #define GATE_MSDC_TOP(_id, _name, _parent, _shift)	\
 	GATE_MTK(_id, _name, _parent, &msdc_top_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
-static const struct mtk_gate msdc_clks[] = {
-	GATE_MSDC(CLK_MSDC_AXI_WRAP, "msdc_axi_wrap", "axi_sel", 22),
-};
-
 static const struct mtk_gate msdc_top_clks[] = {
 	GATE_MSDC_TOP(CLK_MSDC_TOP_AES_0P, "msdc_top_aes_0p", "aes_msdcfde_sel", 0),
 	GATE_MSDC_TOP(CLK_MSDC_TOP_SRC_0P, "msdc_top_src_0p", "infra_msdc0_src", 1),
@@ -52,11 +39,6 @@ static const struct mtk_gate msdc_top_clks[] = {
 	GATE_MSDC_TOP(CLK_MSDC_TOP_AHB2AXI_BRG_AXI, "msdc_top_ahb2axi_brg_axi", "axi_sel", 14),
 };
 
-static const struct mtk_clk_desc msdc_desc = {
-	.clks = msdc_clks,
-	.num_clks = ARRAY_SIZE(msdc_clks),
-};
-
 static const struct mtk_clk_desc msdc_top_desc = {
 	.clks = msdc_top_clks,
 	.num_clks = ARRAY_SIZE(msdc_top_clks),
@@ -64,9 +46,6 @@ static const struct mtk_clk_desc msdc_top_desc = {
 
 static const struct of_device_id of_match_clk_mt8192_msdc[] = {
 	{
-		.compatible = "mediatek,mt8192-msdc",
-		.data = &msdc_desc,
-	}, {
 		.compatible = "mediatek,mt8192-msdc_top",
 		.data = &msdc_top_desc,
 	}, {
-- 
2.34.1

