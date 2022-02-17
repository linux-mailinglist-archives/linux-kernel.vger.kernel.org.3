Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D934BA23A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbiBQOBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:01:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241661AbiBQOA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:00:58 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B91E2B1671;
        Thu, 17 Feb 2022 06:00:20 -0800 (PST)
X-UUID: 334b4836794847bbb0e77f7a0a234c33-20220217
X-UUID: 334b4836794847bbb0e77f7a0a234c33-20220217
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 205135712; Thu, 17 Feb 2022 22:00:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Feb 2022 22:00:16 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Feb 2022 22:00:15 +0800
Message-ID: <a912ed83c8d959fc3bb0a08f00b3fd036beee270.camel@mediatek.com>
Subject: Re: [PATCH 09/15] ASoC: mediatek: mt8186: support tdm in platform
 driver
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
Date:   Thu, 17 Feb 2022 21:59:43 +0800
In-Reply-To: <YgZ/pzrJqvcAuzmE@sirena.org.uk>
References: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
         <20220211103818.8266-10-jiaxin.yu@mediatek.com>
         <YgZ/pzrJqvcAuzmE@sirena.org.uk>
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

On Fri, 2022-02-11 at 15:24 +0000, Mark Brown wrote:
> On Fri, Feb 11, 2022 at 06:38:12PM +0800, Jiaxin Yu wrote:
> 
> Again, mostly looks good just fairly small and easily fixable issues:
> 
> > +static int mtk_tdm_hd_en_event(struct snd_soc_dapm_widget *w,
> > +			       struct snd_kcontrol *kcontrol,
> > +			       int event)
> > +{
> > +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w-
> > >dapm);
> > +
> > +	dev_info(cmpnt->dev, "%s(), name %s, event 0x%x\n",
> > +		 __func__, w->name, event);
> > +
> > +	return 0;
> > +}
> 
> This does nothing, you can just remove it.

Yes, this is readlly useless, removed it in the v2 version.

> 
> > +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> > +	case SND_SOC_DAIFMT_NB_NF:
> > +		tdm_priv->bck_invert = TDM_BCK_NON_INV;
> > +		tdm_priv->lck_invert = TDM_LCK_NON_INV;
> > +		break;
> > +	case SND_SOC_DAIFMT_NB_IF:
> > +		tdm_priv->bck_invert = TDM_BCK_NON_INV;
> > +		tdm_priv->lck_invert = TDM_LCK_INV;
> > +		break;
> > +	case SND_SOC_DAIFMT_IB_NF:
> > +		tdm_priv->bck_invert = TDM_BCK_INV;
> > +		tdm_priv->lck_invert = TDM_LCK_NON_INV;
> > +		break;
> > +	case SND_SOC_DAIFMT_IB_IF:
> > +	default:
> > +		tdm_priv->bck_invert = TDM_BCK_INV;
> > +		tdm_priv->lck_invert = TDM_LCK_INV;
> 
> You should return an error in the default case rather than just
> picking
> one of the behaviours to help spot any configuration errors.

Done in the v2 version.

> 
> > +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> > +	case SND_SOC_DAIFMT_CBM_CFM:
> > +		tdm_priv->slave_mode = false;
> > +		break;
> > +	case SND_SOC_DAIFMT_CBS_CFS:
> > +		tdm_priv->slave_mode = true;
> 
> We're trying to move away from these defines and the master/slave
> terminology to talk about clock providers instead - the new defines
> are
> _PROVIDER_MASK, _DAIFMT_CBP_CFP and _DAIFMT_CBC_CFC.

Done in the v2 version.

