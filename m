Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66B957F4C2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 13:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiGXLIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 07:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXLI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 07:08:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA517E17
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 04:08:28 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LrL0f0tnKzWf6t;
        Sun, 24 Jul 2022 19:04:34 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Jul 2022 19:08:24 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Jul
 2022 19:08:24 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>, <tzungbi@kernel.org>,
        <jiaxin.yu@mediatek.com>, <julianbraha@gmail.com>,
        <geert+renesas@glider.be>
CC:     <renzhijie2@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH -next] ASoC: mediatek: mt8186: fix Kconfig dependency
Date:   Sun, 24 Jul 2022 19:06:19 +0800
Message-ID: <20220724110619.212774-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_SND_SOC_MT8186=y and CONFIG_SND_SOC_MT6358 is not set,
make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:

sound/soc/mediatek/mt8186/mt8186-mt6366-common.o: In function `mt8186_mt6366_init':
mt8186-mt6366-common.c:(.text+0x4d): undefined reference to `mt6358_set_mtkaif_protocol'
make: *** [vmlinux] Error 1

To fix this build error, add select SND_SOC_MT6358 to config SND_SOC_MT8186 dependency.

Fixes: 097e874ad3fc ("ASoC: mediatek: mt8186: add platform driver")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 sound/soc/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 96917743b0db..363fa4d47680 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -157,6 +157,7 @@ config SND_SOC_MT8186
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on COMMON_CLK
 	select SND_SOC_MEDIATEK
+	select SND_SOC_MT6358
 	select MFD_SYSCON if SND_SOC_MT6358
 	help
 	  This adds ASoC driver for Mediatek MT8186 boards
-- 
2.17.1

