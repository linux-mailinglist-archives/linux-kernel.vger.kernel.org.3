Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE774BA1A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbiBQNm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:42:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241209AbiBQNma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:42:30 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134E919C33;
        Thu, 17 Feb 2022 05:42:14 -0800 (PST)
X-UUID: f25b260dd2754d3a8edefe3ca2f71812-20220217
X-UUID: f25b260dd2754d3a8edefe3ca2f71812-20220217
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1966730756; Thu, 17 Feb 2022 21:42:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Feb 2022 21:42:11 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Feb 2022 21:42:10 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <perex@perex.cz>,
        <p.zabel@pengutronix.de>, <geert+renesas@glider.be>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <aaronyu@google.com>, <zhangqilong3@huawei.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [v2 01/17] ASoC: mediatek: mt6366: add codec driver
Date:   Thu, 17 Feb 2022 21:41:49 +0800
Message-ID: <20220217134205.15400-2-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mt6366 is a new version of mt6358, and they are same about audio part.
So we can reuse the driver of mt6358.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 sound/soc/codecs/Kconfig  | 8 ++++++++
 sound/soc/codecs/Makefile | 1 +
 2 files changed, 9 insertions(+)

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
index 42d00aa4ee46..1279684feaf0 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -465,6 +465,7 @@ obj-$(CONFIG_SND_SOC_MT6351)	+= snd-soc-mt6351.o
 obj-$(CONFIG_SND_SOC_MT6358)	+= snd-soc-mt6358.o
 obj-$(CONFIG_SND_SOC_MT6359)	+= snd-soc-mt6359.o
 obj-$(CONFIG_SND_SOC_MT6359_ACCDET) += mt6359-accdet.o
+obj-$(CONFIG_SND_SOC_MT6366)	+= snd-soc-mt6358.o
 obj-$(CONFIG_SND_SOC_MT6660)	+= snd-soc-mt6660.o
 obj-$(CONFIG_SND_SOC_NAU8315)   += snd-soc-nau8315.o
 obj-$(CONFIG_SND_SOC_NAU8540)   += snd-soc-nau8540.o
-- 
2.18.0

