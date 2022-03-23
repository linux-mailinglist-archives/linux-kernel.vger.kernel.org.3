Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5C4E4F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbiCWJVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiCWJVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:21:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC4F5D654
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:19:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 944671F43FE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648027185;
        bh=Knb3Qbz4FitufncDzqCAXY9iWmZ7oO2JSE4/JnyALn8=;
        h=From:To:Cc:Subject:Date:From;
        b=XGwOPIe2HYdU9TA+y06TluGf1bR0lZefNH5+gEcIAZBM/eQLWcnKIgS44l8x1HE39
         oFb8+spytzkN1/C8bUEPowRsB0Vj9XIrInGe5xiYLAFbnzmxf+XR/lRJuX18t/zWwG
         m47keWojG2LHU1FnBoAIq9X+Fkrd5Jjr8f6tDo9pGU/2ilPTJmALeB6Z2c6FfWSDVp
         kcnhzcEu7Sn447yW0CerVS8bNy8SbHAcJUGKZD0rRH9uKIOh4T8ypYgbPMkjRg2AlN
         RZY4iayneA5Y4fPh3KY582mrmFONwVCuzZZZEddLKJ0i4jqohN4tuaJhaSz20qestH
         KNixtcFQRR6mw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, rex-bc.chen@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2] soc: mediatek: mmsys: Add sw0_rst_offset for MT8192
Date:   Wed, 23 Mar 2022 10:19:32 +0100
Message-Id: <20220323091932.10648-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8192 has the same sw0 reset offset as MT8186: add the parameter
to be able to use mmsys as a reset controller for managing at
least the DSI reset line.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

v2: Change the offset to 0x160 (as defined for MT8186). Thanks, Rex-BC!

 drivers/soc/mediatek/mtk-mmsys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 4fc4c2c9ea20..f69521fabcce 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -70,6 +70,7 @@ static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
 	.clk_driver = "clk-mt8192-mm",
 	.routes = mmsys_mt8192_routing_table,
 	.num_routes = ARRAY_SIZE(mmsys_mt8192_routing_table),
+	.sw0_rst_offset = MT8186_MMSYS_SW0_RST_B,
 };
 
 static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data = {
-- 
2.35.1

