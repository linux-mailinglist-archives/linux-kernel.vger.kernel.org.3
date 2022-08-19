Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1876B599C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348964AbiHSMmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348487AbiHSMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:42:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F66B101592
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:42:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b5so775372wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=STFUwd3P3RCFDKggsHSgjhqp3ELyGxnNRW4j2OtnQqw=;
        b=XiwKUUgJKSwVfDJgFeGLX+5Jsc5ngW2f82DuBhhMw7iB8ZzpdNFBy4cQN19QfhCpxO
         jnbMs6vtaJU+iEJMxA0HERAJemrrcM4EYzqYTjMqNFqqj+W8fWLqc9hnOxOogyreZLhe
         2wifpDhGJFIm33r3fhtY3n2aK68KI1uq7KE6ecatvEjOY2wTa+EZoGXF1Rs6jlWnVIcp
         4ji/4iVpKQE1Wx/ki9f2+mupXwnc5cVS74BUa4aI1twkWWoqIrK0Kwo1wN0LwSds3r4t
         iCKfTnLheBDPAThEaLRUwK+s6qhoX5QpZnDlnj64e55FVV6czlSdDJMjQ0N8SqF/kCNC
         D+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=STFUwd3P3RCFDKggsHSgjhqp3ELyGxnNRW4j2OtnQqw=;
        b=okb1aZsafnhSKfPNrgnaVYVJUi8ejd2nTClwyZuZV2MDMQdqVbtnISMdtI8uOgWvUI
         wf4ReMycqVCrFjqbOWEwxeDlF+LWAYo8gdgpMMGTXXYXHJ455DOPFFsKLfpBV6E/9Qsc
         4obr8U2x0rv9bwjG3N7io8BzR96n0fw9+2dwv/vMj7GT2ZQUBCbcllA2OE892WoX3i51
         gCFL2PMR6NL5B4rVDasEKF6TIoOjNbVupgR9/IdWJnH6J9HvwCurnkmFOQRgl6uNRzZy
         LO53ztjjI3HAbT6+s7MbiTFfJQMJeRDUHINuDnM8fv8Drwf70h5rWbCNgvHBk9rUYP0u
         XZmw==
X-Gm-Message-State: ACgBeo0GxSuXlOwFMH4aYSUuqkVAGjlkgV2lYdeteE8PuS3sIsqsYlb2
        rnRwJA16rPMdmFA1yTx/eWvsIw==
X-Google-Smtp-Source: AA6agR6iKn9BNfE00AOvWvIw3AI7ymdDxs2QDsG5cCU1owiwmljXcUhpNRRydJslODlItFSFymCybg==
X-Received: by 2002:adf:eb52:0:b0:223:9164:b5b4 with SMTP id u18-20020adfeb52000000b002239164b5b4mr4182090wrn.518.1660912927505;
        Fri, 19 Aug 2022 05:42:07 -0700 (PDT)
Received: from blmsp ([2001:4090:a245:8020:2658:1f7c:362:3e99])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b003a5ee64cc98sm10122201wmq.33.2022.08.19.05.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 05:42:06 -0700 (PDT)
Date:   Fri, 19 Aug 2022 14:42:06 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH v2 2/4] soc: mediatek: Add support of WAY_EN operations
Message-ID: <20220819124206.kwp6ammicyy4z3jb@blmsp>
References: <20220725081853.1636444-1-msp@baylibre.com>
 <20220725081853.1636444-3-msp@baylibre.com>
 <dccc2863-a9db-d9ea-01e1-a18cf0db1d1e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dccc2863-a9db-d9ea-01e1-a18cf0db1d1e@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

Thanks for your review, I fixed most, comments inline.

On Mon, Jul 25, 2022 at 11:55:27AM +0200, AngeloGioacchino Del Regno wrote:
> Il 25/07/22 10:18, Markus Schneider-Pargmann ha scritto:
> > From: Alexandre Bailon <abailon@baylibre.com>
> > 
> > This updates the power domain to support WAY_EN operations. These
> > operations enable a path between different units of the chip and are
> > labeled as 'way_en' in the register descriptions.
> > 
> > This operation is required by the mt8365 for the MM power domain.
> > 
> > Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> > 
> > Notes:
> >      Changes in v2:
> >      - some minor style fixes.
> >      - Renamed 'wayen' to 'way_en' to clarify the meaning
> >      - Updated commit message
> > 
> >   drivers/soc/mediatek/mtk-pm-domains.c | 64 +++++++++++++++++++++------
> >   drivers/soc/mediatek/mtk-pm-domains.h | 28 +++++++-----
> >   2 files changed, 68 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> > index 5ced254b082b..d0eae2227813 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.c
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> > @@ -44,6 +44,7 @@ struct scpsys_domain {
> >   	struct clk_bulk_data *subsys_clks;
> >   	struct regmap *infracfg;
> >   	struct regmap *smi;
> > +	struct regmap *infracfg_nao;
> 
> What does "nao" mean?

I couldn't find the meaning of nao right now. It is the name of the
infracfg node in the datasheet. The normal one is called 'infracfg_ao'
the other one 'infracfg_nao' as far as I can see.

> 
> Besides, please move that before *infracfg to at least keep the same type members
> alphabetically sorted..
> 
> >   	struct regulator *supply;
> >   };
> > @@ -116,23 +117,38 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
> >   					MTK_POLL_TIMEOUT);
> >   }
> > -static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
> > +static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd,
> > +				      struct regmap *regmap, struct regmap *infracfg_nao)
> >   {
> >   	int i, ret;
> >   	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
> > -		u32 val, mask = bpd[i].bus_prot_mask;
> > +		u32 mask = bpd[i].bus_prot_mask;
> > +		u32 val = mask, sta_mask = mask;
> 
> You have modified the macros to use sta_mask as mask, so, why are you doing
> that distinction in here between the two? You can simply keep assigning
> 
> 		u32 mask = bpd[1].bus_prot_mask;
> 		u32 sta_mask = bpd[1].bus_prot_sta_mask;
> 
> > +		struct regmap *ack_regmap = regmap;
> 
> Double assignment. You're reassigning this if way_en == true.
> 
> >   		if (!mask)
> >   			break;
> > +		if (bpd[i].way_en) {
> > +			if (!infracfg_nao)
> > +				return -ENODEV;
> > +
> > +			val = 0;
> > +			sta_mask = bpd[i].bus_prot_sta_mask;
> > +			ack_regmap = infracfg_nao;
> > +		}
> 
> 		if (bpd[i].way_en) {
> 			ack_regmap = regmap_nao;
> 			val = 0;
> 		} else {
> 			ack_regmap = regmap;
> 			val = mask;
> 		}
> 
> > +
> >   		if (bpd[i].bus_prot_reg_update)
> > -			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
> > +			regmap_update_bits(regmap, bpd[i].bus_prot_set, mask, val);
> >   		else
> >   			regmap_write(regmap, bpd[i].bus_prot_set, mask);
> > -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> > -					       val, (val & mask) == mask,
> > +		if (bpd[i].ignore_clr_ack)
> > +			continue;
> 
> You're adding that ignore_clr_ack here in the bus prot enablement function
> which wasn't here before... and I didn't check carefully, but I think that
> this is wrong: as the name says, it's to "ignore CLEAR ack", we're not doing
> any clearing here, we're not in bus_protect_disable.
> 
> If you're really sure that this is not a mistake, you should guard it for way_en.

We are clearing bits here if way_en is true and bus_prot_reg_update is
true as well. Then val=0 and regmap_update_bits(..., mask, val) will
clear the bits given in mask. And yes either way_en or val==0 should
probably be checked here. Thanks.

> 
> > +
> > +		ret = regmap_read_poll_timeout(ack_regmap, bpd[i].bus_prot_sta,
> > +					       val, (val & sta_mask) == sta_mask,
> >   					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> >   		if (ret)
> >   			return ret;
> > @@ -145,34 +161,49 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
> >   {
> >   	int ret;
> > -	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg, pd->infracfg);
> > +	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg,
> > +					 pd->infracfg, pd->infracfg_nao);
> >   	if (ret)
> >   		return ret;
> > -	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi);
> > +	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi, NULL);
> >   }
> > +#define mask_cond(way_en, val, mask) \
> > +	((way_en && ((val & mask) == mask)) || (!way_en && !(val & mask)))
> > +
> >   static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
> > -				       struct regmap *regmap)
> > +				       struct regmap *regmap, struct regmap *infracfg_nao)
> >   {
> >   	int i, ret;
> >   	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
> > -		u32 val, mask = bpd[i].bus_prot_mask;
> > +		u32 val = 0, mask = bpd[i].bus_prot_mask;
> > +		u32 sta_mask = mask;
> > +		struct regmap *ack_regmap = regmap;
> >   		if (!mask)
> >   			continue;
> > +		if (bpd[i].way_en) {
> > +			if (!infracfg_nao)
> > +				return -ENODEV;
> > +
> > +			val = mask;
> > +			sta_mask = bpd[i].bus_prot_sta_mask;
> > +			ack_regmap = infracfg_nao;
> > +		}
> > +
> >   		if (bpd[i].bus_prot_reg_update)
> > -			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, mask);
> > +			regmap_update_bits(regmap, bpd[i].bus_prot_clr, mask, val);
> >   		else
> >   			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
> >   		if (bpd[i].ignore_clr_ack)
> >   			continue;
> > -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> > -					       val, !(val & mask),
> > +		ret = regmap_read_poll_timeout(ack_regmap, bpd[i].bus_prot_sta,
> > +					       val, mask_cond(bpd[i].way_en, val, sta_mask),
> 
> "I don't know why", my brain still keeps telling me that using different functions
> for the WAY_EN (en/dis) is just better.
> 
> This commit seems to be overcomplicating two "easy" en/dis functions.

Looking at the code again, I think you are right. I redesigned basically
this whole patch, and I think it is easier to understand now.
> 
> >   					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> >   		if (ret)
> >   			return ret;
> > @@ -185,11 +216,12 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
> >   {
> >   	int ret;
> > -	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi);
> > +	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi, NULL);
> >   	if (ret)
> >   		return ret;
> > -	return _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
> > +	return _scpsys_bus_protect_disable(pd->data->bp_infracfg,
> > +			pd->infracfg, pd->infracfg_nao);
> >   }
> >   static int scpsys_regulator_enable(struct regulator *supply)
> > @@ -363,6 +395,10 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
> >   			return ERR_CAST(pd->smi);
> >   	}
> > +	pd->infracfg_nao = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,infracfg_nao");
> > +	if (IS_ERR(pd->infracfg_nao))
> > +		return ERR_CAST(pd->infracfg_nao);
> > +
> 
> I think that we should enforce a check here:
> 
> pd->infracfg_nao = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg_nao");
> if (IS_ERR(pd->infracfg_nao)) {
> 	/* checking if infracfg_nao != NULL at every pwoeron/poweroff is largely
> 	 * suboptimal, as if it't present once, it's present always (!)
> 	 */
> 	if (we have WAY_EN)
> 		return ERR_CAST ...
> 	pd->infracfg_nao = NULL;
> }

Yes, I added another check that enforces .bp_smi not having any way_en
configuration.

Thanks,
Markus
