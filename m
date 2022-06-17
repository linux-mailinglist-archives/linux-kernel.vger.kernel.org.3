Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BAF54F467
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381164AbiFQJeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380766AbiFQJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:34:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E17661618;
        Fri, 17 Jun 2022 02:34:32 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 14304660179C;
        Fri, 17 Jun 2022 10:34:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655458470;
        bh=Q9STMdUQcIR3bQLkRReyfMntLGa0Stetlsm7PC5C6QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMB1QY5aIPAN5J4Yoc6UocSIRoK7OZqGP+NEeXBefOccqGJf+8hkJ45xj94ghFbfa
         igUaVxji0/ZoVpDl1ooqCd8GvrKk0bSA0H+qmOzWD/LZf19tcsvwQ5C+Q2trmmi8HV
         WQ9zV3EHGvvvsDYUPN0p/p1tXvmog9eoHwtERpsQ19HKnlo1ecjwafEJAp/Th3OBPm
         cNRh6so0mD3FxAx/PiKcNu8nORgVyH7zt+VXB86CSnYVKua2LLLbWXMo2/q5muQemg
         mB1FBdL5TCYMR8L/7Kcfb/9JzvHynOsbyuLavq1Cboz936KCE5j/nVry1amAtjbAx1
         LDUNy8w6lX+xw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] clk: mediatek: clk-mt8195-vdo0: Set rate on vdo0_dp_intf0_dp_intf's parent
Date:   Fri, 17 Jun 2022 11:34:23 +0200
Message-Id: <20220617093424.75589-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220617093424.75589-1-angelogioacchino.delregno@collabora.com>
References: <20220617093424.75589-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CLK_SET_RATE_PARENT flag to the CLK_VDO0_DP_INTF0_DP_INTF
clock: this is required to trigger clock source selection on
CLK_TOP_EDP, while avoiding to manage the enablement of the former
separately from the latter in the displayport driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Fixes: 70282c90d4a2 ("clk: mediatek: Add MT8195 vdosys0 clock support")
---
 drivers/clk/mediatek/clk-mt8195-vdo0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
index 261a7f76dd3c..07b46bfd5040 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -37,6 +37,10 @@ static const struct mtk_gate_regs vdo0_2_cg_regs = {
 #define GATE_VDO0_2(_id, _name, _parent, _shift)			\
 	GATE_MTK(_id, _name, _parent, &vdo0_2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
+#define GATE_VDO0_2_FLAGS(_id, _name, _parent, _shift, _flags)		\
+	GATE_MTK_FLAGS(_id, _name, _parent, &vdo0_2_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_setclr, _flags)
+
 static const struct mtk_gate vdo0_clks[] = {
 	/* VDO0_0 */
 	GATE_VDO0_0(CLK_VDO0_DISP_OVL0, "vdo0_disp_ovl0", "top_vpp", 0),
@@ -85,7 +89,8 @@ static const struct mtk_gate vdo0_clks[] = {
 	/* VDO0_2 */
 	GATE_VDO0_2(CLK_VDO0_DSI0_DSI, "vdo0_dsi0_dsi", "top_dsi_occ", 0),
 	GATE_VDO0_2(CLK_VDO0_DSI1_DSI, "vdo0_dsi1_dsi", "top_dsi_occ", 8),
-	GATE_VDO0_2(CLK_VDO0_DP_INTF0_DP_INTF, "vdo0_dp_intf0_dp_intf", "top_edp", 16),
+	GATE_VDO0_2_FLAGS(CLK_VDO0_DP_INTF0_DP_INTF, "vdo0_dp_intf0_dp_intf",
+			  "top_edp", 16, CLK_SET_RATE_PARENT),
 };
 
 static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
-- 
2.35.1

