Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0A054F468
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381204AbiFQJek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379989AbiFQJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:34:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA84951E4B;
        Fri, 17 Jun 2022 02:34:32 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D1DD3660179D;
        Fri, 17 Jun 2022 10:34:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655458471;
        bh=pGH8Jhv8K2/nD4MKxwp8iQfMRDcZpcfthKCb1vXYh2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJyotv6t4Hiv4uT6+vHHfgJSpwbVQGm+bhfIc3s3jUCxTIfCoHF5Z9MnG6MVlq+aj
         whAdRbaaFqIchO11AOf4dcEC2sGPJO5dqwc/dXtwzmjhr4MObVw7Qex48SXuhjLe9z
         2C71GzdOIkDyG0037SJnLaP/Nblv9F4K4HxSlFUAsYq5Ghp51jlYviRmuG2rGVZ3hE
         92D07YHRMu8tnkKfp/cc6Fc3tGtdW71ilzmqRuZds/i42Ceet3hKNsPnZDxYF97Cvd
         witAY/tFVtA22foFeLsQaM4cs5q5ZxPDkfjNSOivCcU/11/iCEmfduEtwUzX6f6/FC
         bFYKgXSs7tHhA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: mediatek: clk-mt8195-vdo1: Reparent and set rate on vdo1_dpintf's parent
Date:   Fri, 17 Jun 2022 11:34:24 +0200
Message-Id: <20220617093424.75589-3-angelogioacchino.delregno@collabora.com>
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

Like it was done for the vdo0_dp_intf0_dp_intf clock (used for eDP),
add the CLK_SET_RATE_PARENT flag to CLK_VDO1_DPINTF (used for DP)
and also fix its parent clock name as it has to be "top_dp" for two
reasons:
 - This is its real parent!
 - Likewise to eDP/VDO0 counterpart, we need clock source
   selection on CLK_TOP_DP.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Fixes: 269987505ba9 ("clk: mediatek: Add MT8195 vdosys1 clock support")
---
 drivers/clk/mediatek/clk-mt8195-vdo1.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index 3378487d2c90..d54d7726d186 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -43,6 +43,10 @@ static const struct mtk_gate_regs vdo1_3_cg_regs = {
 #define GATE_VDO1_2(_id, _name, _parent, _shift)			\
 	GATE_MTK(_id, _name, _parent, &vdo1_2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
+#define GATE_VDO1_2_FLAGS(_id, _name, _parent, _shift, _flags)		\
+	GATE_MTK_FLAGS(_id, _name, _parent, &vdo1_2_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_setclr, _flags)
+
 #define GATE_VDO1_3(_id, _name, _parent, _shift)			\
 	GATE_MTK(_id, _name, _parent, &vdo1_3_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
@@ -99,7 +103,7 @@ static const struct mtk_gate vdo1_clks[] = {
 	GATE_VDO1_2(CLK_VDO1_DISP_MONITOR_DPI0, "vdo1_disp_monitor_dpi0", "top_vpp", 1),
 	GATE_VDO1_2(CLK_VDO1_DPI1, "vdo1_dpi1", "top_vpp", 8),
 	GATE_VDO1_2(CLK_VDO1_DISP_MONITOR_DPI1, "vdo1_disp_monitor_dpi1", "top_vpp", 9),
-	GATE_VDO1_2(CLK_VDO1_DPINTF, "vdo1_dpintf", "top_vpp", 16),
+	GATE_VDO1_2_FLAGS(CLK_VDO1_DPINTF, "vdo1_dpintf", "top_dp", 16, CLK_SET_RATE_PARENT),
 	GATE_VDO1_2(CLK_VDO1_DISP_MONITOR_DPINTF, "vdo1_disp_monitor_dpintf", "top_vpp", 17),
 	/* VDO1_3 */
 	GATE_VDO1_3(CLK_VDO1_26M_SLOW, "vdo1_26m_slow", "clk26m", 8),
-- 
2.35.1

