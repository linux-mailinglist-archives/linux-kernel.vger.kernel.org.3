Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A37957352A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbiGMLQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiGMLPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:15:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ED1101483;
        Wed, 13 Jul 2022 04:15:19 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DDE1D66019C5;
        Wed, 13 Jul 2022 12:15:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657710917;
        bh=B3pFqcpJL4uwSDHR2Pb8ZpJXQWecgKAmffWdGwqPWmw=;
        h=From:To:Cc:Subject:Date:From;
        b=i+41z0e13diW6eFHtsCimC6PSbECS2XIIbU2wvuzy/1wbayHdEOfKVgNWd2oNg0qj
         qv2v4xUtxiienjybifjfLlGfLhdWHJOrvSk8vgNeMUiQhbEBWxpyCXxu3H5KtSha9T
         fPZp4YHYxxME11uwfIcrzdYRPmoutuQ/wZk3lhmUOynLZyQMhxMVJiJa2srXcbD0Jv
         LglwMPdn195bx+c3Mzae9vS7RsNSrddsBlQJXJs+F+yATDaQFpkFB9Av393nSQ89GS
         eTQMZvUZGbyN/zqFHhxoTca0FDqgBesefKUifU3hKJtAvU+gAbLchho3UAcqA64S/N
         z+DU3NNXVLobA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     myungjoo.ham@samsung.com
Cc:     kyungmin.park@samsung.com, cw00.choi@samsung.com,
        matthias.bgg@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        jia-wei.chang@mediatek.com, johnson.wang@mediatek.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] PM / devfreq: mtk-cci: Handle sram regulator probe deferral
Date:   Wed, 13 Jul 2022 13:15:11 +0200
Message-Id: <20220713111511.115007-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
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

If the regulator_get_optional()	call for the SRAM regulator returns
a probe deferral, we must bail out and retry probing later: failing
to do this will	produce	unstabilities on platforms requiring the
handling for this regulator.

Fixes: b615b00c42da ("PM / devfreq: mediatek: Introduce MediaTek CCI devfreq driver")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/devfreq/mtk-cci-devfreq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
index 71abb3fbd042..e5458ada5197 100644
--- a/drivers/devfreq/mtk-cci-devfreq.c
+++ b/drivers/devfreq/mtk-cci-devfreq.c
@@ -291,9 +291,13 @@ static int mtk_ccifreq_probe(struct platform_device *pdev)
 	}
 
 	drv->sram_reg = devm_regulator_get_optional(dev, "sram");
-	if (IS_ERR(drv->sram_reg))
+	if (IS_ERR(drv->sram_reg)) {
+		ret = PTR_ERR(drv->sram_reg);
+		if (ret == -EPROBE_DEFER)
+			goto out_free_resources;
+
 		drv->sram_reg = NULL;
-	else {
+	} else {
 		ret = regulator_enable(drv->sram_reg);
 		if (ret) {
 			dev_err(dev, "failed to enable sram regulator\n");
-- 
2.35.1

