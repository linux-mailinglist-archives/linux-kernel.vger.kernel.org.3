Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE91F4BA283
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbiBQOFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:05:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241610AbiBQOFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:05:36 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E28E145E06;
        Thu, 17 Feb 2022 06:05:12 -0800 (PST)
X-UUID: 13930417666347189e89e6836c68b0ee-20220217
X-UUID: 13930417666347189e89e6836c68b0ee-20220217
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 197789904; Thu, 17 Feb 2022 22:05:09 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 17 Feb 2022 22:05:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Feb
 2022 22:05:08 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Feb 2022 22:05:07 +0800
Message-ID: <62ad00889c7cf0e1f7501b9e5b3ab1b132639281.camel@mediatek.com>
Subject: Re: [PATCH 05/15] ASoC: mediatek: mt8186: support hw gain in
 platform driver
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <perex@perex.cz>,
        <p.zabel@pengutronix.de>, <geert+renesas@glider.be>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <zhangqilong3@huawei.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 17 Feb 2022 22:05:07 +0800
In-Reply-To: <YgZ9gadN8RksWeWN@sirena.org.uk>
References: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
         <20220211103818.8266-6-jiaxin.yu@mediatek.com>
         <YgZ9gadN8RksWeWN@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-11 at 15:15 +0000, Mark Brown wrote:
> On Fri, Feb 11, 2022 at 06:38:08PM +0800, Jiaxin Yu wrote:
> 
> Again, mostly looks good just some minor issues (I've not repeated
> some
> that applied to the prior code):
> 
> > +static const struct snd_kcontrol_new mtk_hw_gain2_in_ch1_mix[] = {
> > +	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN15,
> > +				    I_ADDA_UL_CH1, 1, 0),
> > +};
> 
> These end up as regular user visible controls so should have standard
> control names - in this case ending in Switch since it's a simple
> on/off.  A similar issue was there in the earlier patches.
Yes, I have corrected the control names in the other patches together.

> 
> > +static const struct snd_kcontrol_new mtk_hw_gain_controls[] = {
> > +	SOC_SINGLE("HW Gain 1", AFE_GAIN1_CON1,
> > +		   GAIN1_TARGET_SFT, GAIN1_TARGET_MASK, 0),
> > +	SOC_SINGLE("HW Gain 2", AFE_GAIN2_CON1,
> > +		   GAIN2_TARGET_SFT, GAIN2_TARGET_MASK, 0),
> 
> These should have standard names like "HW 1 Volume" so userspace has
> a
> better idea how to display them.

Ok, I see.

