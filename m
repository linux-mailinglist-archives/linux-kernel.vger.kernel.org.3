Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB53B4CE297
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 05:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiCEE0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 23:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiCEEZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 23:25:59 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1693D53708;
        Fri,  4 Mar 2022 20:25:04 -0800 (PST)
X-UUID: f91cd922797a4c02b60543ed4c65f1a6-20220305
X-UUID: f91cd922797a4c02b60543ed4c65f1a6-20220305
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1076188222; Sat, 05 Mar 2022 12:25:00 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Mar 2022 12:24:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 5 Mar
 2022 12:24:58 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Mar 2022 12:24:57 +0800
Message-ID: <6555d89deb9087825f865b9d4265f07465e7ae09.camel@mediatek.com>
Subject: Re: [v2 01/17] ASoC: mediatek: mt6366: add codec driver
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <perex@perex.cz>,
        <p.zabel@pengutronix.de>, <geert+renesas@glider.be>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <aaronyu@google.com>, <zhangqilong3@huawei.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Sat, 5 Mar 2022 12:24:57 +0800
In-Reply-To: <b22976ee-6426-cabf-f153-fbe093611e97@collabora.com>
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
         <20220217134205.15400-2-jiaxin.yu@mediatek.com>
         <b22976ee-6426-cabf-f153-fbe093611e97@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-18 at 15:54 +0100, AngeloGioacchino Del Regno wrote:
> Il 17/02/22 14:41, Jiaxin Yu ha scritto:
> > Mt6366 is a new version of mt6358, and they are same about audio
> > part.
> > So we can reuse the driver of mt6358.
> > 
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> 
> Hello Jiaxin,
> I'm sorry but this commit makes very little sense.
> 
> If you want to advertise MT6366 support, please write a note and/or
> a new compatible string inside of the mt6358 driver (and dt-
> bindings),
> then, please drop this commit.
> 

Hello angelogioacchino,

Thank you for your advice.

If I add a new compatible string inside of the mt6358 driver and dt-
bindings, then the machine driver which want to use mt6366 should
select SND_SOC_MT6358.

like below:

config SND_SOC_MT8186_MT6366_DA7219_MAX98357
	tristate "ASoC Audio driver for MT8186 with DA7219 MAX98357A
codec"
 	depends on I2C && GPIOLIB
 	depends on SND_SOC_MT8186 && MTK_PMIC_WRAP
 	select SND_SOC_MT6366   ==> SND_SOC_MT6358
	...

I just doubt it's enough to make sense. I originally wanted to put this
relationship in the sound/soc/codecs layer. So that this relationship
is not perceived by users(machine driver).
However, if the general practice is like this, I will adopt your
suggestion. Thank you again.

> 
> > ---
> >   sound/soc/codecs/Kconfig  | 8 ++++++++
> >   sound/soc/codecs/Makefile | 1 +
> >   2 files changed, 9 insertions(+)
> > 
> > diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> > index 8fa24783ce01..6631094678f5 100644
> > --- a/sound/soc/codecs/Kconfig
> > +++ b/sound/soc/codecs/Kconfig
> > @@ -132,6 +132,7 @@ config SND_SOC_ALL_CODECS
> >   	imply SND_SOC_MT6351
> >   	imply SND_SOC_MT6358
> >   	imply SND_SOC_MT6359
> > +	imply SND_SOC_MT6366
> >   	imply SND_SOC_MT6660
> >   	imply SND_SOC_NAU8315
> >   	imply SND_SOC_NAU8540
> > @@ -1888,6 +1889,13 @@ config SND_SOC_MT6359_ACCDET
> >   	  for ASoC codec soc-jack detection mechanism.
> >   	  Select N if you don't have jack on board.
> >   
> > +config SND_SOC_MT6366
> > +	tristate "MediaTek MT6366 Codec"
> > +	depends on MTK_PMIC_WRAP
> > +	help
> > +	  Enable support for the platform which uses MT6366 as
> > +	  external codec device.
> > +
> >   config SND_SOC_MT6660
> >   	tristate "Mediatek MT6660 Speaker Amplifier"
> >   	depends on I2C
> > diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> > index 42d00aa4ee46..1279684feaf0 100644
> > --- a/sound/soc/codecs/Makefile
> > +++ b/sound/soc/codecs/Makefile
> > @@ -465,6 +465,7 @@ obj-$(CONFIG_SND_SOC_MT6351)	+= snd-soc-
> > mt6351.o
> >   obj-$(CONFIG_SND_SOC_MT6358)	+= snd-soc-mt6358.o
> >   obj-$(CONFIG_SND_SOC_MT6359)	+= snd-soc-mt6359.o
> >   obj-$(CONFIG_SND_SOC_MT6359_ACCDET) += mt6359-accdet.o
> > +obj-$(CONFIG_SND_SOC_MT6366)	+= snd-soc-mt6358.o
> >   obj-$(CONFIG_SND_SOC_MT6660)	+= snd-soc-mt6660.o
> >   obj-$(CONFIG_SND_SOC_NAU8315)   += snd-soc-nau8315.o
> >   obj-$(CONFIG_SND_SOC_NAU8540)   += snd-soc-nau8540.o
> 
> 

