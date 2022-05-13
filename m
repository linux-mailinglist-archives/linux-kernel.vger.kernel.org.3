Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83285267E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382713AbiEMREB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354115AbiEMRD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:03:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEFA4969F;
        Fri, 13 May 2022 10:03:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 940361F41739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652461437;
        bh=Wh5LQZ8ySmvO8IXpMu/GG9iqNwxWpEjWpdkHdKriJ+Q=;
        h=From:To:Cc:Subject:Date:From;
        b=R+V3I2Jh5vL98BYzEHGYtDZrsY0+WfwU5DEvBB6aM6vpV3PqRCu4oWmkkDdVf1Je1
         0i+HP0hGqGAW/tRKgjCP/Fw37ogEjErmonDLuPT3oA8u2xQJAhWjNNKxiQFHHxeNNe
         XXxMOUp46bTVcN7ZAthwmwzEqeTAC3xi1BsenusTQhnjYzQTO3HOS6/ZjXyv8Vy0Ok
         m5gB3atNx5oZ100UtNxr/MF8hWVDzsj9C9CST5TBFvrp8jOIpfyjTtlK/QaJHD8lqp
         m0XKj5aKTMN7e83r6itASd2qoHl/aaRdzIJRJKCEE/jZgIkT1EI9bNVreAr1DXoiUM
         Zjp7PGebW2gCQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] soc: mediatek: mtk-mmsys: Add support for MT6795 Helio X10
Date:   Fri, 13 May 2022 19:03:50 +0200
Message-Id: <20220513170350.502501-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
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

Add MM support for the MT6795 SoC, using the mmsys default routing
table.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

In order for this patch to have any meaning and functionality, it is
required to also have in-tree the [1] MT6795 clocks series, even
though that's not required to actually compile this code.

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=641493

 drivers/soc/mediatek/mtk-mmsys.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 06d8e83a2cb5..38b36b881a3b 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -57,6 +57,13 @@ static const struct mtk_mmsys_match_data mt6779_mmsys_match_data = {
 	},
 };
 
+static const struct mtk_mmsys_driver_data mt6795_mmsys_driver_data = {
+	.clk_driver = "clk-mt6795-mm",
+	.routes = mmsys_default_routing_table,
+	.num_routes = ARRAY_SIZE(mmsys_default_routing_table),
+	.sw0_rst_offset = MT8183_MMSYS_SW0_RST_B,
+};
+
 static const struct mtk_mmsys_driver_data mt6797_mmsys_driver_data = {
 	.clk_driver = "clk-mt6797-mm",
 };
@@ -363,6 +370,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
 		.compatible = "mediatek,mt6779-mmsys",
 		.data = &mt6779_mmsys_match_data,
 	},
+	{
+		.compatible = "mediatek,mt6795-mmsys",
+		.data = &mt6795_mmsys_driver_data,
+	},
 	{
 		.compatible = "mediatek,mt6797-mmsys",
 		.data = &mt6797_mmsys_match_data,
-- 
2.35.1

