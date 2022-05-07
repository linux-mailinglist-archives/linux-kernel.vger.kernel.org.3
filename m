Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FCA51E37E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 04:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445339AbiEGCS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 22:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356890AbiEGCS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 22:18:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91EB5D5E5
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 19:14:41 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kw9t25f3zzGnxg;
        Sat,  7 May 2022 10:11:54 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 7 May
 2022 10:14:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <matthias.bgg@gmail.com>, <tzungbi@google.com>,
        <angelogioacchino.delregno@collabora.com>,
        <trevor.wu@mediatek.com>, <arnd@arndb.de>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] ASoC: mediatek: mt8195: Fix build warning without CONFIG_OF
Date:   Sat, 7 May 2022 10:14:24 +0800
Message-ID: <20220507021424.12180-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Since all users of this driver do need CONFIG_OF anyway, there is no
need to save a few bytes on kernel builds while CONFIG_OF disabled, so
just remove the #ifdef to fix this warning.

Fixes: 86a6b9c9dfff ("ASoC: mediatek: mt8195: add machine support for max98390 and rt5682")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: remove #ifdef block as Arnd suggested
---
 sound/soc/mediatek/mt8195/mt8195-mt6359.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index f90675f14d60..54a00b0699b1 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -1626,7 +1626,6 @@ static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#ifdef CONFIG_OF
 static struct mt8195_card_data mt8195_mt6359_rt1019_rt5682_card = {
 	.name = "mt8195_r1019_5682",
 	.quirk = RT1019_SPEAKER_AMP_PRESENT,
@@ -1657,7 +1656,6 @@ static const struct of_device_id mt8195_mt6359_dt_match[] = {
 	},
 	{},
 };
-#endif
 
 static const struct dev_pm_ops mt8195_mt6359_pm_ops = {
 	.poweroff = snd_soc_poweroff,
@@ -1667,9 +1665,7 @@ static const struct dev_pm_ops mt8195_mt6359_pm_ops = {
 static struct platform_driver mt8195_mt6359_driver = {
 	.driver = {
 		.name = "mt8195_mt6359",
-#ifdef CONFIG_OF
 		.of_match_table = mt8195_mt6359_dt_match,
-#endif
 		.pm = &mt8195_mt6359_pm_ops,
 	},
 	.probe = mt8195_mt6359_dev_probe,
-- 
2.17.1

