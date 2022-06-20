Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103135515B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbiFTKZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiFTKZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:25:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A23612776
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:25:00 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3AC2E660166D;
        Mon, 20 Jun 2022 11:24:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655720698;
        bh=2y7HCdJit3cXRA/sDODSECzq5lWWkGtctbxdIAXtr5U=;
        h=From:To:Cc:Subject:Date:From;
        b=JRR5D1caw1ZcwxMgpxW97vZsMeHafj7w8aot2aPajs1M7TM3xcsOef6iQPvE+dsl0
         CeOy9FUfLZwMlTaks+kXcjbamsg0eFmqKSLym6WD/WrRHFoB9Stv8IRMM88rc/PoFY
         /fLJF/KT2rQInCoc7Y5Pp55JG174wzdiJRV3tG3aU1MPnyrNzsHDnKA1JeWsQbAJrm
         89yG32Gu7SICP9amZOPiE5Wv/Axa5B7St5ogalkjH6SoD9D8IVO5A7n2oOsa4o4vp1
         2VXOvCkoYLPMwjNsQY+aR6vkzfhh8lhIiJOdr4RCcNbYCoYy+vNAvPFT7gs65Yr1dA
         Ts5btv9Tp7fow==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     fparent@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] soc: mediatek: mutex: Use DDP_COMPONENT_DITHER0 mod index for MT8365
Date:   Mon, 20 Jun 2022 12:24:54 +0200
Message-Id: <20220620102454.131417-1-angelogioacchino.delregno@collabora.com>
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

In commit
4e8988c634a1 ("soc: mediatek: add DDP_DOMPONENT_DITHER0 enum for mt8195 vdosys0")
the enum mtk_ddp_comp_id was modified to add an index number to the
DITHER component because some new SoCs have multiple dither blocks.

As a result, all of the mutex mod arrays have been changed to use the
new definition instead of the old one (even if that's retained): for
consistency purposes, follow the same trend on the newly introduced
MT8365 mutex mod array.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index fa8e0ba38803..2fd8318c3bdc 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -358,7 +358,7 @@ static const unsigned int mt8365_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8365_MUTEX_MOD_DISP_AAL,
 	[DDP_COMPONENT_CCORR] = MT8365_MUTEX_MOD_DISP_CCORR,
 	[DDP_COMPONENT_COLOR0] = MT8365_MUTEX_MOD_DISP_COLOR0,
-	[DDP_COMPONENT_DITHER] = MT8365_MUTEX_MOD_DISP_DITHER,
+	[DDP_COMPONENT_DITHER0] = MT8365_MUTEX_MOD_DISP_DITHER,
 	[DDP_COMPONENT_DPI0] = MT8365_MUTEX_MOD_DISP_DPI0,
 	[DDP_COMPONENT_DSI0] = MT8365_MUTEX_MOD_DISP_DSI0,
 	[DDP_COMPONENT_GAMMA] = MT8365_MUTEX_MOD_DISP_GAMMA,
-- 
2.35.1

