Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7914D6FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 17:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiCLQTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 11:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiCLQTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 11:19:52 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FE25F8E7;
        Sat, 12 Mar 2022 08:18:42 -0800 (PST)
X-UUID: aee794b93a184520b26ddf324e04e89d-20220313
X-UUID: aee794b93a184520b26ddf324e04e89d-20220313
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 399267673; Sun, 13 Mar 2022 00:18:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 13 Mar 2022 00:18:34 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 13 Mar 2022 00:18:34 +0800
Message-ID: <5fafa7d8a23fbdce82272529d817816f42c4ac37.camel@mediatek.com>
Subject: Re: [PATCH 4/5] ASoC: mediatek: mt8195: add machine driver with
 mt6359, max98390 and rt5682
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <broonie@kernel.org>,
        <tiwai@suse.com>, <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <yc.hung@mediatek.com>
Date:   Sun, 13 Mar 2022 00:18:34 +0800
In-Reply-To: <e812796f-6b9b-fe9d-50a7-b681d7b174fd@collabora.com>
References: <20220308072435.22460-1-trevor.wu@mediatek.com>
         <20220308072435.22460-5-trevor.wu@mediatek.com>
         <e812796f-6b9b-fe9d-50a7-b681d7b174fd@collabora.com>
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

On Thu, 2022-03-10 at 16:21 +0100, AngeloGioacchino Del Regno wrote:
> Il 08/03/22 08:24, Trevor Wu ha scritto:
> > This patch adds support for mt8195 board with mt6359, max98390 and
> > rt5682.
> > 
> > Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> 
> Hello Trevor,
> thanks for the patch! However, there's something to improve...
> 
> > ---
> >   sound/soc/mediatek/Kconfig                    |   16 +
> >   sound/soc/mediatek/mt8195/Makefile            |    5 +
> >   .../mt8195/mt8195-mt6359-max98390-rt5682.c    | 1058
> > +++++++++++++++++
> >   3 files changed, 1079 insertions(+)
> >   create mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-
> > max98390-rt5682.c
> >   
> > 

[...]
> > +
> > +static const struct snd_soc_dapm_widget
> > +	mt8195_mt6359_max98390_rt5682_widgets[] = {
> > +	SND_SOC_DAPM_SPK("Left Speaker", NULL),
> > +	SND_SOC_DAPM_SPK("Right Speaker", NULL),
> > +	SND_SOC_DAPM_HP("Headphone Jack", NULL),
> 
> We can at least partially reuse existing UCM2 configuration if you
> slightly change the names for these controls.
> 

I don't know what the UCM2 configuration means.
Could you give me more information?


> Specifically, MAX98090 (yes I know it's a different codec) has names
> "Speaker Left", "Speaker Right" instead, we will be able to at least
> partially reuse these (or get uniform naming, which is still good).
> As for the "Headphone Jack", it's simply "Headphone".
> 
> Please note that the actual control names in userspace will be,
> exactly,
> 
> "Speaker Left Switch", "Speaker Right Switch",
> "Headphone Left Switch", "Headphone Right Switch"...
> 
> ....where "Switch" gets automatically appended because of the control
> type.
> 
> > +	SND_SOC_DAPM_MIC("Headset Mic", NULL),
> 
> This "Headset Mic" name is fine.
> 
> > +	SND_SOC_DAPM_MIXER(SOF_DMA_DL2, SND_SOC_NOPM, 0, 0, NULL, 0),
> > +	SND_SOC_DAPM_MIXER(SOF_DMA_DL3, SND_SOC_NOPM, 0, 0, NULL, 0),
> > +	SND_SOC_DAPM_MIXER(SOF_DMA_UL4, SND_SOC_NOPM, 0, 0, NULL, 0),
> > +	SND_SOC_DAPM_MIXER(SOF_DMA_UL5, SND_SOC_NOPM, 0, 0, NULL, 0),
> > +};
> > +
[...]
> > +
> > +static struct snd_soc_dai_link
> > mt8195_mt6359_max98390_rt5682_dai_links[] = {
> 
> 
> ... again, different name, same contents ...
> 
> 
> And I won't go on repeating the same thing over and over again.
> I think that the best idea here is to either create a mt8195-mt6359-
> rt5682-common.c
> file, or to rename the others to something else and get them all in
> the same file.
> 
> 
> Regards,
> Angelo

Hi Angelo,

Thanks for your review.
Please forgive me for deleting some comments above.
I totally agree that most code can be reused.
I will try revising and merging all mt8195 machine drivers in a file.

Thanks,
Trevor

