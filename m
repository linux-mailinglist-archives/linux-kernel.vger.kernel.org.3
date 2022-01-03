Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D78483399
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbiACOjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:39:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47774 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbiACOh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:37:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F2CF71F41FC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641220641;
        bh=qSvITlSu/EuyG+NjQRmV2sMPNmQCjRo2UzY7HOf2Nho=;
        h=From:To:Cc:Subject:Date:From;
        b=f/uhrvzMZjOrwsczlBf18PrfUJE/YL1OYGyZTyvSisSGMvRgJDPZJ+jnilDvi+vGG
         b59GQfaZ6JKukfLnVudHm0Vw27rDee2Jy4JzP7ywCDXovQNUkkVTJBccjBiHAp+DEE
         CaziJL8QXJcnqKd+au8Dx9HklGAe5rS6d82IQWjoSU3xcIiD0yhHSVts6vpvmBsoFi
         GZMtEsK7f6qisXmc+cyBwhJE6LVTJiHH54tDYNObW2o7w3L6XidoufnrP27X4KSRpc
         Q/c3OuxBOJmSYNZu91PYCI2/7OGaWfh1cUgWt3Y+kk3l7p9crtBvruF7UwtXiX8ywZ
         pH34lc3lUc7oQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, miles.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 1/2] clk: mediatek: clk-gate: Shrink by adding clockgating bit check helper
Date:   Mon,  3 Jan 2022 15:37:11 +0100
Message-Id: <20220103143712.46675-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a clockgating bit check helper and use it in functions
mtk_cg_bit_is_cleared(), mtk_cg_bit_is_set() to shrink the
file size.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-gate.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index b02d2f74dd0d..957fa1d68f07 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -16,28 +16,24 @@
 #include "clk-mtk.h"
 #include "clk-gate.h"
 
-static int mtk_cg_bit_is_cleared(struct clk_hw *hw)
+static u32 mtk_get_clockgating(struct clk_hw *hw)
 {
 	struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
 	u32 val;
 
 	regmap_read(cg->regmap, cg->sta_ofs, &val);
 
-	val &= BIT(cg->bit);
+	return val & BIT(cg->bit);
+}
 
-	return val == 0;
+static int mtk_cg_bit_is_cleared(struct clk_hw *hw)
+{
+	return mtk_get_clockgating(hw) == 0;
 }
 
 static int mtk_cg_bit_is_set(struct clk_hw *hw)
 {
-	struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
-	u32 val;
-
-	regmap_read(cg->regmap, cg->sta_ofs, &val);
-
-	val &= BIT(cg->bit);
-
-	return val != 0;
+	return mtk_get_clockgating(hw) != 0;
 }
 
 static void mtk_cg_set_bit(struct clk_hw *hw)
-- 
2.33.1

