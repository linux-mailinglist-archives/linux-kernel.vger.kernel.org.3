Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49AC57DD2F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 11:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiGVJGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbiGVJG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:06:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A6083F19;
        Fri, 22 Jul 2022 02:06:23 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BED446601AD5;
        Fri, 22 Jul 2022 10:06:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658480782;
        bh=Z7g3rMRXfsVUy9u/ifzOPNTpC7K1R1mO+IQ0gPIXbVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ke9XCuYmi6cOBfwxq64sKffugBd/rtnhu9Les17dtk9L9NS0YqF/8UqhqtJYhlrs2
         2Hdl/YqeJwa4d8X5p9gz5H3kobTljd2d6iFVf3SFLKl9+76H/HP60LM0iit8kBBzmG
         uisvu4x4Li6oefFgS5lCr4d1M/2jQCUzeenqF9WW8nf+cGUIU7bN6+agDnTKCm4kDV
         XyGH+59qJH11UsYaAe8hPQYR3OCHAzCkL0SxV8tB/jNSAC6/J4SBW9ZI4hRhmjFUie
         oaomugTbkDY0pCoXuM7KBuPdGgy47n3aaVUhYJW/PkE693qGO+bZbk/bAixRn52CHy
         /B9oOCf2ITD6A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, y.oudjana@protonmail.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        ck.hu@mediatek.com, fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, ikjn@chromium.org,
        miles.chen@mediatek.com, sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
Subject: [PATCH v6 5/8] clk: mediatek: clk-apmixed: Remove unneeded __init annotation
Date:   Fri, 22 Jul 2022 11:06:06 +0200
Message-Id: <20220722090609.52364-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220722090609.52364-1-angelogioacchino.delregno@collabora.com>
References: <20220722090609.52364-1-angelogioacchino.delregno@collabora.com>
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

Remove an unneeded __init annotation from the declaration of function
mtk_clk_register_ref2usb_tx(): this avoids section mismatch warnings
during modpost phase when called from functions that have no such
annotation (useful when clocks are platform drivers).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-apmixed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
index fc3d4146f482..6b0ab0a346e8 100644
--- a/drivers/clk/mediatek/clk-apmixed.c
+++ b/drivers/clk/mediatek/clk-apmixed.c
@@ -70,7 +70,7 @@ static const struct clk_ops mtk_ref2usb_tx_ops = {
 	.unprepare	= mtk_ref2usb_tx_unprepare,
 };
 
-struct clk_hw * __init mtk_clk_register_ref2usb_tx(const char *name,
+struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
 			const char *parent_name, void __iomem *reg)
 {
 	struct mtk_ref2usb_tx *tx;
-- 
2.35.1

