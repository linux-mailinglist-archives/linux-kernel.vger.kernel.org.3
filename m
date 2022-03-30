Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A324EB852
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbiC3CfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiC3CfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:35:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB00FFD03;
        Tue, 29 Mar 2022 19:33:14 -0700 (PDT)
X-UUID: 9bf5674a47b648fbabf9829f4a820b1c-20220330
X-UUID: 9bf5674a47b648fbabf9829f4a820b1c-20220330
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1552206381; Wed, 30 Mar 2022 10:33:09 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 30 Mar 2022 10:33:08 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 30 Mar
 2022 10:33:07 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Mar 2022 10:33:06 +0800
Message-ID: <dee3fbb7c9f0c3e1f11143db1d6fc4381cab827f.camel@mediatek.com>
Subject: Re: [v7 2/4] ASoC: mediatek: mt8192: refactor for I2S3 DAI link of
 speaker
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>, <tzungbi@google.com>,
        <angelogioacchino.delregno@collabora.com>, <aaronyu@google.com>,
        <matthias.bgg@gmail.com>, <trevor.wu@mediatek.com>,
        <linmq006@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Date:   Wed, 30 Mar 2022 10:33:06 +0800
In-Reply-To: <20220329223002.uo7kiemopkh7ak4x@notapiano>
References: <20220324064511.10665-1-jiaxin.yu@mediatek.com>
         <20220324064511.10665-3-jiaxin.yu@mediatek.com>
         <20220329223002.uo7kiemopkh7ak4x@notapiano>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-29 at 18:30 -0400, Nícolas F. R. A. Prado wrote:
> Hi Jiaxin,
> 
> On Thu, Mar 24, 2022 at 02:45:09PM +0800, Jiaxin Yu wrote:
> > MT8192 platform will use rt1015 or rt105p codec, so through the
> > snd_soc_of_get_dai_link_codecs() to complete the configuration
> > of dai_link's codecs.
> > 
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > ---
> >  .../mt8192/mt8192-mt6359-rt1015-rt5682.c      | 108 ++++++++++--
> > ------
> >  1 file changed, 59 insertions(+), 49 deletions(-)
> > 
> > diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-
> > rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
> > index ee91569c0911..837c2ccd5b3d 100644
> > --- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
> > +++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
> > @@ -604,17 +604,9 @@ SND_SOC_DAILINK_DEFS(i2s2,
> >  		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
> >  		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> >  
> > -SND_SOC_DAILINK_DEFS(i2s3_rt1015,
> > +SND_SOC_DAILINK_DEFS(i2s3,
> >  		     DAILINK_COMP_ARRAY(COMP_CPU("I2S3")),
> > -		     DAILINK_COMP_ARRAY(COMP_CODEC(RT1015_DEV0_NAME,
> > -						   RT1015_CODEC_DAI),
> > -					COMP_CODEC(RT1015_DEV1_NAME,
> > -						   RT1015_CODEC_DAI)),
> > -		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> > -
> > -SND_SOC_DAILINK_DEFS(i2s3_rt1015p,
> > -		     DAILINK_COMP_ARRAY(COMP_CPU("I2S3")),
> > -		     DAILINK_COMP_ARRAY(COMP_CODEC("rt1015p", "HiFi")),
> > +		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
> >  		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> >  
> >  SND_SOC_DAILINK_DEFS(i2s5,
> > @@ -929,6 +921,7 @@ static struct snd_soc_dai_link
> > mt8192_mt6359_dai_links[] = {
> >  		.dpcm_playback = 1,
> >  		.ignore_suspend = 1,
> >  		.be_hw_params_fixup = mt8192_i2s_hw_params_fixup,
> > +		SND_SOC_DAILINK_REG(i2s3),
> >  	},
> >  	{
> >  		.name = "I2S5",
> > @@ -1100,55 +1093,64 @@ static struct snd_soc_card
> > mt8192_mt6359_rt1015p_rt5682_card = {
> >  	.num_dapm_routes =
> > ARRAY_SIZE(mt8192_mt6359_rt1015p_rt5682_routes),
> >  };
> >  
> > +static int mt8192_mt6359_card_set_be_link(struct snd_soc_card
> > *card,
> > +					  struct snd_soc_dai_link
> > *link,
> > +					  struct device_node *node,
> > +					  char *link_name)
> > +{
> > +	int ret;
> > +
> > +	if (node && strcmp(link->name, link_name) == 0) {
> > +		ret = snd_soc_of_get_dai_link_codecs(card->dev, node,
> > link);
> > +		if (ret < 0) {
> > +			dev_err_probe(card->dev, ret, "get dai link
> > codecs fail\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
> >  {
> >  	struct snd_soc_card *card;
> > -	struct device_node *platform_node, *hdmi_codec;
> > +	struct device_node *platform_node, *hdmi_codec, *speaker_codec;
> >  	int ret, i;
> >  	struct snd_soc_dai_link *dai_link;
> >  	struct mt8192_mt6359_priv *priv;
> >  
> > -	platform_node = of_parse_phandle(pdev->dev.of_node,
> > -					 "mediatek,platform", 0);
> > -	if (!platform_node) {
> > -		dev_err(&pdev->dev, "Property 'platform' missing or
> > invalid\n");
> > +	card = (struct snd_soc_card *)of_device_get_match_data(&pdev-
> > >dev);
> > +	if (!card)
> >  		return -EINVAL;
> > +	card->dev = &pdev->dev;
> > +
> > +	platform_node = of_parse_phandle(pdev->dev.of_node,
> > "mediatek,platform", 0);
> > +	if (!platform_node) {
> > +		ret = -EINVAL;
> > +		dev_err_probe(&pdev->dev, ret, "Property 'platform'
> > missing or invalid\n");
> > +		goto err_platform_node;
> >  	}
> >  
> > -	card = (struct snd_soc_card *)of_device_get_match_data(&pdev-
> > >dev);
> > -	if (!card) {
> > +	hdmi_codec = of_parse_phandle(pdev->dev.of_node,
> > "mediatek,hdmi-codec", 0);
> > +	if (!hdmi_codec) {
> >  		ret = -EINVAL;
> > -		goto put_platform_node;
> > +		dev_err_probe(&pdev->dev, ret, "Property 'hdmi-codec'
> > missing or invalid\n");
> > +		goto err_hdmi_codec;
> 
> You're making hdmi-codec a required property, since now the driver
> fails to
> probe without it. Is it really required though? The driver code still
> checks for
> the presence of hdmi_codec before using it, so shouldn't it be fine
> to let it be
> optional?
> 
> If it is really required now though, then I guess at least the dt-
> binding should
> be updated accordingly. (Although I think this would technically
> break the ABI?)
> 
> Thanks,
> Nícolas

Hi Nícolas,

Thanks for your comment. Indeed I made hdmi-codec a required property,
because it is a must in this machine driver. I prefer to report errors
during the registration rather than during the use.

So I'd like to take your second suggestion. I need to update dt-binding 
that set hdmi-codec as required property.

"(Although I think this would technicallybreak the ABI?)"
==> I can't understand this question, could you help explain it in more
detail.

Thanks,
Jiaxin.Yu

> 
>  	}
> > -	card->dev = &pdev->dev;
> >  
> > -	hdmi_codec = of_parse_phandle(pdev->dev.of_node,
> > -				      "mediatek,hdmi-codec", 0);
> > +	speaker_codec = of_get_child_by_name(pdev->dev.of_node,
> > "speaker-codecs");
> > +	if (!speaker_codec) {
> > +		ret = -EINVAL;
> > +		dev_err_probe(&pdev->dev, ret, "Property 'speaker-
> > codecs' missing or invalid\n");
> > +		goto err_speaker_codec;
> > +	}
> >  
> 
snip...
> >  
> > -put_hdmi_codec:
> > +err_probe:
> > +	of_node_put(speaker_codec);
> > +err_speaker_codec:
> >  	of_node_put(hdmi_codec);
> > -put_platform_node:
> > +err_hdmi_codec:
> >  	of_node_put(platform_node);
> > +err_platform_node:
> >  	return ret;
> >  }
> >  
> > -- 
> > 2.18.0
> > 
> > 

