Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49555596DA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiFXJf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiFXJfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:35:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2F8792B9;
        Fri, 24 Jun 2022 02:35:40 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0FBDC6601809;
        Fri, 24 Jun 2022 10:35:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656063339;
        bh=ed21MxQBys0eLKmWDwmejvGmdOdkFhFLW6SX1N40rec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nlz/joAXFpNGitizoNGWQDSpZqV8ygdSeWrtaw3sPrNgrlq9p/4pumQcq+cYtTW72
         EVcvjxEzCrwKDIgArhiWt98IHPi5VmtTgsNJppGMELqDxsXzoAtHiG3zuL8NcO+h54
         eqe8z+QpuNbR7piAbxWGM0YNGKTIZAjn9ieNNX+FYrR22X3TePhZJrFuKBppjW21FP
         uokeZ31GL+by9ws3CThFWRru+g7w0tEyxT2GeSOPhaQ3zLMM0YYJqKfGHm8F/mYpMy
         T50plrZXMiv97owksfujzAzeycFKB1/qKS+S+zLVvHzUGzLQnwskQg0zgMwuhC44gJ
         uOV4QA0u4+BWA==
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
Subject: [PATCH v3 5/7] clk: mediatek: clk-apmixed: Remove unneeded __init annotation
Date:   Fri, 24 Jun 2022 11:35:23 +0200
Message-Id: <20220624093525.243077-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220624093525.243077-1-angelogioacchino.delregno@collabora.com>
References: <20220624093525.243077-1-angelogioacchino.delregno@collabora.com>
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

Remove an unneeded __init annotation from the declaration of function
mtk_clk_register_ref2usb_tx(): this avoids section mismatch warnings
during modpost phase when called from functions that have no such
annotation (useful when clocks are platform drivers).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

