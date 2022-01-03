Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C30483398
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiACOjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:39:11 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47788 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbiACOh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:37:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 947C31F424E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641220642;
        bh=QIrc2bb8Mrasiom9iIiy7g+f0RYvDaspbjMj2QcgCbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDXnfUhNavlAFHDED0sqUIs8UUE3luAUemyeH9Z3+Qt4JASAwIr8giPgfx+fZbeOp
         JyG2wHkUolD88qUv8kbRdFx7evoxtIJFtGYcmhHOr2wqAB1brS0ESiDUVZl6kDg4MB
         Flxk/dbcOX0sLIq2Gz03y44y4Bd35JvvKd+jan7ldXalJMA+/ydxrWmnAfBuPXk0sP
         C4Q0DCunCHhmxFaxulbwB3xxEgDYf8smUwzauFzaNemcluEPjb7PD1Fd5JM1MGulKy
         JxduP95Z4Y8+3FKA8cXoYFewbAsBcHJuuguHRNP8LfhHH1cX+NK3jhlnBEezQAc0Pi
         i++DXtBaXm9Aw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, miles.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 2/2] clk: mediatek: clk-gate: Use regmap_{set/clear}_bits helpers
Date:   Mon,  3 Jan 2022 15:37:12 +0100
Message-Id: <20220103143712.46675-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220103143712.46675-1-angelogioacchino.delregno@collabora.com>
References: <20220103143712.46675-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Appropriately change calls to regmap_update_bits() with regmap_set_bits()
and regmap_clear_bits() for improved readability.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-gate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 957fa1d68f07..5d88b428565b 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -53,17 +53,15 @@ static void mtk_cg_clr_bit(struct clk_hw *hw)
 static void mtk_cg_set_bit_no_setclr(struct clk_hw *hw)
 {
 	struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
-	u32 cgbit = BIT(cg->bit);
 
-	regmap_update_bits(cg->regmap, cg->sta_ofs, cgbit, cgbit);
+	regmap_set_bits(cg->regmap, cg->sta_ofs, BIT(cg->bit));
 }
 
 static void mtk_cg_clr_bit_no_setclr(struct clk_hw *hw)
 {
 	struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
-	u32 cgbit = BIT(cg->bit);
 
-	regmap_update_bits(cg->regmap, cg->sta_ofs, cgbit, 0);
+	regmap_clear_bits(cg->regmap, cg->sta_ofs, BIT(cg->bit));
 }
 
 static int mtk_cg_enable(struct clk_hw *hw)
-- 
2.33.1

