Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFEA51CEFE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388327AbiEFCaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 22:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387611AbiEFCaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 22:30:23 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFF514026
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 19:26:41 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KvZ854dLhzNkTG;
        Fri,  6 May 2022 10:21:57 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:26:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <matthias.bgg@gmail.com>, <tzungbi@google.com>,
        <angelogioacchino.delregno@collabora.com>, <trevor.wu@mediatek.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: mediatek: mt8195: Fix build warning without CONFIG_OF
Date:   Fri, 6 May 2022 10:26:38 +0800
Message-ID: <20220506022638.15864-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/mediatek/mt8195/mt8195-mt6359.c:1639:32: warning: ‘mt8195_mt6359_max98390_rt5682_card’ defined but not used [-Wunused-variable]
 1639 | static struct mt8195_card_data mt8195_mt6359_max98390_rt5682_card = {
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/mediatek/mt8195/mt8195-mt6359.c:1634:32: warning: ‘mt8195_mt6359_rt1011_rt5682_card’ defined but not used [-Wunused-variable]
 1634 | static struct mt8195_card_data mt8195_mt6359_rt1011_rt5682_card = {
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/mediatek/mt8195/mt8195-mt6359.c:1629:32: warning: ‘mt8195_mt6359_rt1019_rt5682_card’ defined but not used [-Wunused-variable]
 1629 | static struct mt8195_card_data mt8195_mt6359_rt1019_rt5682_card = {
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These variables is only used with CONFIG_OF, move it into the ifdef block.

Fixes: 86a6b9c9dfff ("ASoC: mediatek: mt8195: add machine support for max98390 and rt5682")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/mediatek/mt8195/mt8195-mt6359.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index 3e32fe801b3c..f90675f14d60 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -1626,6 +1626,7 @@ static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 	return ret;
 }
 
+#ifdef CONFIG_OF
 static struct mt8195_card_data mt8195_mt6359_rt1019_rt5682_card = {
 	.name = "mt8195_r1019_5682",
 	.quirk = RT1019_SPEAKER_AMP_PRESENT,
@@ -1641,7 +1642,6 @@ static struct mt8195_card_data mt8195_mt6359_max98390_rt5682_card = {
 	.quirk = MAX98390_SPEAKER_AMP_PRESENT,
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id mt8195_mt6359_dt_match[] = {
 	{
 		.compatible = "mediatek,mt8195_mt6359_rt1019_rt5682",
-- 
2.17.1

