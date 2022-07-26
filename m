Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F51C5814F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbiGZOSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiGZORl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:17:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEC82253C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:17:37 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6675D6601B25;
        Tue, 26 Jul 2022 15:17:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658845055;
        bh=J9b6/urhItRjBm3nPg4B1bDfTVM2sZCWw+pgg0y0QmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eU64ltO89iqfLkpis1m/3c+OTw3RePXolf/ehCW9mbYkG8dCg6wMicer1CnVFu1Vz
         HJuOq/yR81CCiv+I5tG51QvePQzLKHdi9zEIgM4hBmZywlkaCuWS9BpRbheGBKwE/w
         ZOADhP3G0GX+gyrWESnZn/H9wBzQ5HsdnR12ixWz1JuhHXbDv1LLoMQvK1Pp6aYMto
         nngOqnyvPvTyFNqMOCUhwY3JNteIFh6xZK7TFqlI850tRO15xaNk0RnERT6KnE4Zk2
         ZmAmr9HDUIpk+Kh7lHAOx9dPUzFPmtbfAyn/lmG7hxhyiwwTDu7kT01ETs5o5FLFe9
         EAelZgzg6iHLA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     roger.lu@mediatek.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/6] soc: mediatek: mtk-svs: Drop of_match_ptr() for of_match_table
Date:   Tue, 26 Jul 2022 16:16:51 +0200
Message-Id: <20220726141653.177948-5-angelogioacchino.delregno@collabora.com>
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

If CONFIG_OF is not set, we get a -Wunused-const-variable: dropping
of_match_ptr() solves that issue.

Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index fcf246a6bb07..80d0bab1a045 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2840,7 +2840,7 @@ static struct platform_driver svs_driver = {
 	.driver	= {
 		.name		= "mtk-svs",
 		.pm		= &svs_pm_ops,
-		.of_match_table	= of_match_ptr(svs_of_match),
+		.of_match_table	= svs_of_match,
 	},
 };
 
-- 
2.35.1

