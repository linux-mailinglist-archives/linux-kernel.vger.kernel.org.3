Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43716579666
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiGSJdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbiGSJdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:33:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50404252A9;
        Tue, 19 Jul 2022 02:33:31 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2EF2B6601A84;
        Tue, 19 Jul 2022 10:33:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658223209;
        bh=yjRdxTBmptUMN4auYeM9Y82+2shgUi3524K4SvRLuJE=;
        h=From:To:Cc:Subject:Date:From;
        b=QbkfSgiQ3hzr/Zr8LvmYIcl2fBsFQiByscOKdsb43oIvT6sw8TcGugKzCcdH9p7Jv
         NHb1Uo1Cw7PTE493REX31cUou9KrVOatxv7yZj76j9TmJWrV3yLrqsKgR3FjvYb9Oc
         C0kdCH+5Up+6ZSrXcU7gfWGxhRAYpV8DRNoNW9YIF1GzGPJ0Jf6BwgG/OYIeQt6ynm
         znZQkZujL6AiPA3/XE8XDQ0zsptWp87f6eRTRwPzVUvFU0BMQEOI7F7EXROyYly5mi
         Ylh1VF1muMuxabbQGJIAlpd9UWy43K+6WNS5+L2d2tFN0avc7pJBUiTzLbd6yaw2NL
         AebOGwAOM9YrQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        chun-jie.chen@mediatek.com, miles.chen@mediatek.com,
        rex-bc.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mediatek: mt8195-infra_ao: Set pwrmcu clocks as critical
Date:   Tue, 19 Jul 2022 11:33:16 +0200
Message-Id: <20220719093316.37253-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
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

The pwrmcu is responsible for power management and idle states in SSPM:
on older SoCs this was managed in Linux drivers like sspm/mcupm/eemgpu
but, at least on MT8195, this functionality was transferred to the ATF
firmware.
For this reason, turning off the pwrmcu related clocks from the kernel
will lead to unability to resume the platform after suspend and other
currently unknown PM related side-effects.

Set the PWRMCU and PWRMCU_BUS_H clocks as critical to prevent the
kernel from turning them off, fixing the aforementioned issue.

Fixes: e2edf59dec0b ("clk: mediatek: Add MT8195 infrastructure clock support")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8195-infra_ao.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
index ce7ac16a2f42..75b54ec9c46c 100644
--- a/drivers/clk/mediatek/clk-mt8195-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
@@ -55,8 +55,12 @@ static const struct mtk_gate_regs infra_ao4_cg_regs = {
 #define GATE_INFRA_AO1(_id, _name, _parent, _shift)	\
 	GATE_INFRA_AO1_FLAGS(_id, _name, _parent, _shift, 0)
 
+#define GATE_INFRA_AO2_FLAGS(_id, _name, _parent, _shift, _flag)	\
+	GATE_MTK_FLAGS(_id, _name, _parent, &infra_ao2_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_setclr, _flag)
+
 #define GATE_INFRA_AO2(_id, _name, _parent, _shift)			\
-	GATE_MTK(_id, _name, _parent, &infra_ao2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+	GATE_INFRA_AO2_FLAGS(_id, _name, _parent, _shift, 0)
 
 #define GATE_INFRA_AO3_FLAGS(_id, _name, _parent, _shift, _flag)		\
 	GATE_MTK_FLAGS(_id, _name, _parent, &infra_ao3_cg_regs, _shift,	\
@@ -136,8 +140,11 @@ static const struct mtk_gate infra_ao_clks[] = {
 	GATE_INFRA_AO2(CLK_INFRA_AO_UNIPRO_SYS, "infra_ao_unipro_sys", "top_ufs", 11),
 	GATE_INFRA_AO2(CLK_INFRA_AO_UNIPRO_TICK, "infra_ao_unipro_tick", "top_ufs_tick1us", 12),
 	GATE_INFRA_AO2(CLK_INFRA_AO_UFS_MP_SAP_B, "infra_ao_ufs_mp_sap_b", "top_ufs_mp_sap_cfg", 13),
-	GATE_INFRA_AO2(CLK_INFRA_AO_PWRMCU, "infra_ao_pwrmcu", "top_pwrmcu", 15),
-	GATE_INFRA_AO2(CLK_INFRA_AO_PWRMCU_BUS_H, "infra_ao_pwrmcu_bus_h", "top_axi", 17),
+	/* pwrmcu is used by ATF for platform PM: clocks must never be disabled by the kernel */
+	GATE_INFRA_AO2_FLAGS(CLK_INFRA_AO_PWRMCU, "infra_ao_pwrmcu", "top_pwrmcu", 15,
+			     CLK_IS_CRITICAL),
+	GATE_INFRA_AO2_FLAGS(CLK_INFRA_AO_PWRMCU_BUS_H, "infra_ao_pwrmcu_bus_h", "top_axi", 17,
+			     CLK_IS_CRITICAL),
 	GATE_INFRA_AO2(CLK_INFRA_AO_APDMA_B, "infra_ao_apdma_b", "top_axi", 18),
 	GATE_INFRA_AO2(CLK_INFRA_AO_SPI4, "infra_ao_spi4", "top_spi", 25),
 	GATE_INFRA_AO2(CLK_INFRA_AO_SPI5, "infra_ao_spi5", "top_spi", 26),
-- 
2.35.1

