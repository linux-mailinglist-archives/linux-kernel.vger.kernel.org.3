Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7045D4B2357
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244530AbiBKKig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:38:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiBKKid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:38:33 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0764DD41;
        Fri, 11 Feb 2022 02:38:27 -0800 (PST)
X-UUID: 132cd1ca924447b6a00f1e5d537fbd3d-20220211
X-UUID: 132cd1ca924447b6a00f1e5d537fbd3d-20220211
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 133670868; Fri, 11 Feb 2022 18:38:24 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 11 Feb 2022 18:38:23 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Feb 2022 18:38:23 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <perex@perex.cz>,
        <p.zabel@pengutronix.de>, <geert+renesas@glider.be>
CC:     <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <zhangqilong3@huawei.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jiaxin Yu <jiaxin.yu@mediatek.corp-partner.google.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH 01/15] ASoC: mediatek: mt6366: add codec driver
Date:   Fri, 11 Feb 2022 18:38:04 +0800
Message-ID: <20220211103818.8266-2-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
References: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiaxin Yu <jiaxin.yu@mediatek.corp-partner.google.com>

Mt6366 is a new version of mt6358, and they are same about audio part.
So we can reuse the driver of mt6358.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 sound/soc/codecs/Kconfig  | 8 ++++++++
 sound/soc/codecs/Makefile | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8fa24783ce01..6631094678f5 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -132,6 +132,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_MT6351
 	imply SND_SOC_MT6358
 	imply SND_SOC_MT6359
+	imply SND_SOC_MT6366
 	imply SND_SOC_MT6660
 	imply SND_SOC_NAU8315
 	imply SND_SOC_NAU8540
@@ -1888,6 +1889,13 @@ config SND_SOC_MT6359_ACCDET
 	  for ASoC codec soc-jack detection mechanism.
 	  Select N if you don't have jack on board.
 
+config SND_SOC_MT6366
+	tristate "MediaTek MT6366 Codec"
+	depends on MTK_PMIC_WRAP
+	help
+	  Enable support for the platform which uses MT6366 as
+	  external codec device.
+
 config SND_SOC_MT6660
 	tristate "Mediatek MT6660 Speaker Amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 42d00aa4ee46..df6518306cd4 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -137,6 +137,7 @@ snd-soc-mt6351-objs := mt6351.o
 snd-soc-mt6358-objs := mt6358.o
 snd-soc-mt6359-objs := mt6359.o
 snd-soc-mt6359-accdet-objs := mt6359-accdet.o
+snd-soc-mt6366-objs := mt6358.o
 snd-soc-mt6660-objs := mt6660.o
 snd-soc-nau8315-objs := nau8315.o
 snd-soc-nau8540-objs := nau8540.o
@@ -465,6 +466,7 @@ obj-$(CONFIG_SND_SOC_MT6351)	+= snd-soc-mt6351.o
 obj-$(CONFIG_SND_SOC_MT6358)	+= snd-soc-mt6358.o
 obj-$(CONFIG_SND_SOC_MT6359)	+= snd-soc-mt6359.o
 obj-$(CONFIG_SND_SOC_MT6359_ACCDET) += mt6359-accdet.o
+obj-$(CONFIG_SND_SOC_MT6366)	+= snd-soc-mt6366.o
 obj-$(CONFIG_SND_SOC_MT6660)	+= snd-soc-mt6660.o
 obj-$(CONFIG_SND_SOC_NAU8315)   += snd-soc-nau8315.o
 obj-$(CONFIG_SND_SOC_NAU8540)   += snd-soc-nau8540.o
-- 
2.18.0

