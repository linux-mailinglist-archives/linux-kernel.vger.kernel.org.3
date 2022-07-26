Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EF55814F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbiGZOSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238310AbiGZORm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:17:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDE022515
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:17:40 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0A64D6601B27;
        Tue, 26 Jul 2022 15:17:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658845056;
        bh=/YuYtrnNwsD9jkmjIALrbGiIMTfJWaxC43e7WbK4aCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0NRuHC3FwUAZ+21sfLzXLOmEjDlMxL2Iu/IQCIi+nmUxt4Q9ZCyhbrD4Tpd7sTBL
         N6xojx9ZSaCE1/Dv/yrgueuLKvny9iopLc0Xu7UyF0/CV0U+KussNSJ8deNKXNIbbB
         AQa0nI0/srRuKBKn/zgjbJZQGUddKHThp0OnMlLiyQF1GgVCPg5J0wfWwDXJ9cXms0
         xREkQdKsR1jUTlLxKeLTA+Xbj51rI48UUuLr2/4ltItqppeumz7c8aSohm13zAmrRh
         /rkuQlGT3vKjpB4KJrim2R3qa5dG6Let3t8ygwkdDh7I9cxxfx929oCNb6c3YOV3t3
         dNYx+yLXIk1ZA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     roger.lu@mediatek.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 5/6] soc: mediatek: mtk-svs: Use devm variant for dev_pm_opp_of_add_table()
Date:   Tue, 26 Jul 2022 16:16:52 +0200
Message-Id: <20220726141653.177948-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
References: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
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

In error cases, this driver never calls dev_pm_opp_of_remove_table():
instead of doing that, simple switch to a devm variant, which will
automagically do that for us.

Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 80d0bab1a045..25b49d8af59a 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1626,7 +1626,7 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
 
 		dev_set_drvdata(svsb->dev, svsp);
 
-		ret = dev_pm_opp_of_add_table(svsb->opp_dev);
+		ret = devm_pm_opp_of_add_table(svsb->opp_dev);
 		if (ret) {
 			dev_err(svsb->dev, "add opp table fail: %d\n", ret);
 			return ret;
-- 
2.35.1

