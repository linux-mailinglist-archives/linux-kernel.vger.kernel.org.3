Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652C752B896
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbiERLRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbiERLRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:17:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E856FD32;
        Wed, 18 May 2022 04:17:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 316B81F44F2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652872630;
        bh=tM2NCHISdeqiBeyAihI46o5xT7S0JD/iOFvY+O5f134=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJv9xjvcP4IElo/guUDQn5PT6u+KDJYzf+uNfc6sUGn63+hDRxLT4T3bTFO9Q13ua
         E4UmbjTVxkCJoy3GuJ0XR0tVBuHj/NsnWzuDwa0ZN8jUXAZDCaPmbEdt9Z8gf6AQj2
         e6Gom9ZD8nfsNRaCChwSFda3R9JQ0wAvhySHtCodyUrU9BEuPK7/3oqnRtR5mFjuy3
         zWOdHydzu+sI24gBX0DUB5D3VaQL4Khea7jsQ2HH3aH52+yyIfPSucf5Q20Axo5eU/
         gXhtPHViaX/74Xzul1Cl2/Wj/0gEQWVjqCrGGn1QzrR5g8uwnlnwGZwX/7Dw5huwoq
         3bXnMGq9CL/VQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, angelogioacchino.delregno@collabora.com,
        jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
        fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
Subject: [PATCH v2 6/7] clk: mediatek: Export required symbols to compile clk drivers as module
Date:   Wed, 18 May 2022 13:16:51 +0200
Message-Id: <20220518111652.223727-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518111652.223727-1-angelogioacchino.delregno@collabora.com>
References: <20220518111652.223727-1-angelogioacchino.delregno@collabora.com>
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

In order to compile the clock drivers for various MediaTek SoCs as
modules, it is necessary to export a few functions from the MediaTek
specific clocks (and reset) libraries.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-apmixed.c | 1 +
 drivers/clk/mediatek/clk-cpumux.c  | 2 ++
 drivers/clk/mediatek/clk-mtk.c     | 2 ++
 drivers/clk/mediatek/reset.c       | 1 +
 4 files changed, 6 insertions(+)

diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
index 6b0ab0a346e8..f126da693a7f 100644
--- a/drivers/clk/mediatek/clk-apmixed.c
+++ b/drivers/clk/mediatek/clk-apmixed.c
@@ -98,5 +98,6 @@ struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
 
 	return &tx->hw;
 }
+EXPORT_SYMBOL_GPL(mtk_clk_register_ref2usb_tx);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
index 2b5d48591738..25618eff6f2a 100644
--- a/drivers/clk/mediatek/clk-cpumux.c
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -150,6 +150,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 
 	return PTR_ERR(hw);
 }
+EXPORT_SYMBOL_GPL(mtk_clk_register_cpumuxes);
 
 void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
 				 struct clk_hw_onecell_data *clk_data)
@@ -166,5 +167,6 @@ void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
 		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
 	}
 }
+EXPORT_SYMBOL_GPL(mtk_clk_unregister_cpumuxes);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 05a188c62119..41e60a7e8ff9 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -459,6 +459,7 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	mtk_free_clk_data(clk_data);
 	return r;
 }
+EXPORT_SYMBOL_GPL(mtk_clk_simple_probe);
 
 int mtk_clk_simple_remove(struct platform_device *pdev)
 {
@@ -472,5 +473,6 @@ int mtk_clk_simple_remove(struct platform_device *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_clk_simple_remove);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 179505549a7c..290ceda84ce4 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -228,5 +228,6 @@ int mtk_register_reset_controller_with_dev(struct device *dev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_register_reset_controller_with_dev);
 
 MODULE_LICENSE("GPL");
-- 
2.35.1

