Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4353A57FCC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiGYJzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiGYJzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:55:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3D26262;
        Mon, 25 Jul 2022 02:55:32 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6E66966015E7;
        Mon, 25 Jul 2022 10:55:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658742931;
        bh=SCxjD0r6W2093T144vIJ+kv/iLm6YRMmyB+sEXDO65I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=INejVMHUlE0QG8D/2t58BRmaCjdB941Hiz5Hhc3wGvXpn+1o78HC/jIWtcDSR79QG
         zAskvAjSQ5C1axslCWugrrZHA00PgqU5sVFRNGBL6mSdn44nXZPrn3apprfpViHpFy
         Ytml4igRZGTQ/g5T9EzJuIlhYtBzmB7782hi2FU1iTsCFJ9nA3dP/gF9/LmTAuBei9
         4VowvFaoJ+thhP2LY21TpCiBGOf36jJ4NFOUmIb6XaMJI5vv/Ly+UnxvjTDP241vyu
         scTbBsWjXdWZitUfd4eX8bU+dH3/eN4HQyXLrrg8bypQvvKVn/B2Ov41+7v/R1QtEU
         0rmDfo28EG1HA==
Message-ID: <dccc2863-a9db-d9ea-01e1-a18cf0db1d1e@collabora.com>
Date:   Mon, 25 Jul 2022 11:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/4] soc: mediatek: Add support of WAY_EN operations
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
References: <20220725081853.1636444-1-msp@baylibre.com>
 <20220725081853.1636444-3-msp@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220725081853.1636444-3-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/07/22 10:18, Markus Schneider-Pargmann ha scritto:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> This updates the power domain to support WAY_EN operations. These
> operations enable a path between different units of the chip and are
> labeled as 'way_en' in the register descriptions.
> 
> This operation is required by the mt8365 for the MM power domain.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> 
> Notes:
>      Changes in v2:
>      - some minor style fixes.
>      - Renamed 'wayen' to 'way_en' to clarify the meaning
>      - Updated commit message
> 
>   drivers/soc/mediatek/mtk-pm-domains.c | 64 +++++++++++++++++++++------
>   drivers/soc/mediatek/mtk-pm-domains.h | 28 +++++++-----
>   2 files changed, 68 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 5ced254b082b..d0eae2227813 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -44,6 +44,7 @@ struct scpsys_domain {
>   	struct clk_bulk_data *subsys_clks;
>   	struct regmap *infracfg;
>   	struct regmap *smi;
> +	struct regmap *infracfg_nao;

What does "nao" mean?

Besides, please move that before *infracfg to at least keep the same type members
alphabetically sorted..

>   	struct regulator *supply;
>   };
>   
> @@ -116,23 +117,38 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
>   					MTK_POLL_TIMEOUT);
>   }
>   
> -static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
> +static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd,
> +				      struct regmap *regmap, struct regmap *infracfg_nao)
>   {
>   	int i, ret;
>   
>   	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
> -		u32 val, mask = bpd[i].bus_prot_mask;
> +		u32 mask = bpd[i].bus_prot_mask;
> +		u32 val = mask, sta_mask = mask;

You have modified the macros to use sta_mask as mask, so, why are you doing
that distinction in here between the two? You can simply keep assigning

		u32 mask = bpd[1].bus_prot_mask;
		u32 sta_mask = bpd[1].bus_prot_sta_mask;

> +		struct regmap *ack_regmap = regmap;

Double assignment. You're reassigning this if way_en == true.

>   
>   		if (!mask)
>   			break;
>   
> +		if (bpd[i].way_en) {
> +			if (!infracfg_nao)
> +				return -ENODEV;
> +
> +			val = 0;
> +			sta_mask = bpd[i].bus_prot_sta_mask;
> +			ack_regmap = infracfg_nao;
> +		}

		if (bpd[i].way_en) {
			ack_regmap = regmap_nao;
			val = 0;
		} else {
			ack_regmap = regmap;
			val = mask;
		}

> +
>   		if (bpd[i].bus_prot_reg_update)
> -			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
> +			regmap_update_bits(regmap, bpd[i].bus_prot_set, mask, val);
>   		else
>   			regmap_write(regmap, bpd[i].bus_prot_set, mask);
>   
> -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> -					       val, (val & mask) == mask,
> +		if (bpd[i].ignore_clr_ack)
> +			continue;

You're adding that ignore_clr_ack here in the bus prot enablement function
which wasn't here before... and I didn't check carefully, but I think that
this is wrong: as the name says, it's to "ignore CLEAR ack", we're not doing
any clearing here, we're not in bus_protect_disable.

If you're really sure that this is not a mistake, you should guard it for way_en.

> +
> +		ret = regmap_read_poll_timeout(ack_regmap, bpd[i].bus_prot_sta,
> +					       val, (val & sta_mask) == sta_mask,
>   					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>   		if (ret)
>   			return ret;
> @@ -145,34 +161,49 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>   {
>   	int ret;
>   
> -	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg, pd->infracfg);
> +	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg,
> +					 pd->infracfg, pd->infracfg_nao);
>   	if (ret)
>   		return ret;
>   
> -	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi);
> +	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi, NULL);
>   }
>   
> +#define mask_cond(way_en, val, mask) \
> +	((way_en && ((val & mask) == mask)) || (!way_en && !(val & mask)))
> +
>   static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
> -				       struct regmap *regmap)
> +				       struct regmap *regmap, struct regmap *infracfg_nao)
>   {
>   	int i, ret;
>   
>   	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
> -		u32 val, mask = bpd[i].bus_prot_mask;
> +		u32 val = 0, mask = bpd[i].bus_prot_mask;
> +		u32 sta_mask = mask;
> +		struct regmap *ack_regmap = regmap;
>   
>   		if (!mask)
>   			continue;
>   
> +		if (bpd[i].way_en) {
> +			if (!infracfg_nao)
> +				return -ENODEV;
> +
> +			val = mask;
> +			sta_mask = bpd[i].bus_prot_sta_mask;
> +			ack_regmap = infracfg_nao;
> +		}
> +
>   		if (bpd[i].bus_prot_reg_update)
> -			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, mask);
> +			regmap_update_bits(regmap, bpd[i].bus_prot_clr, mask, val);
>   		else
>   			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
>   
>   		if (bpd[i].ignore_clr_ack)
>   			continue;
>   
> -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> -					       val, !(val & mask),
> +		ret = regmap_read_poll_timeout(ack_regmap, bpd[i].bus_prot_sta,
> +					       val, mask_cond(bpd[i].way_en, val, sta_mask),

"I don't know why", my brain still keeps telling me that using different functions
for the WAY_EN (en/dis) is just better.

This commit seems to be overcomplicating two "easy" en/dis functions.

>   					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>   		if (ret)
>   			return ret;
> @@ -185,11 +216,12 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
>   {
>   	int ret;
>   
> -	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi);
> +	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi, NULL);
>   	if (ret)
>   		return ret;
>   
> -	return _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
> +	return _scpsys_bus_protect_disable(pd->data->bp_infracfg,
> +			pd->infracfg, pd->infracfg_nao);
>   }
>   
>   static int scpsys_regulator_enable(struct regulator *supply)
> @@ -363,6 +395,10 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>   			return ERR_CAST(pd->smi);
>   	}
>   
> +	pd->infracfg_nao = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,infracfg_nao");
> +	if (IS_ERR(pd->infracfg_nao))
> +		return ERR_CAST(pd->infracfg_nao);
> +

I think that we should enforce a check here:

pd->infracfg_nao = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg_nao");
if (IS_ERR(pd->infracfg_nao)) {
	/* checking if infracfg_nao != NULL at every pwoeron/poweroff is largely
	 * suboptimal, as if it't present once, it's present always (!)
	 */
	if (we have WAY_EN)
		return ERR_CAST ...
	pd->infracfg_nao = NULL;
}
	

>   	num_clks = of_clk_get_parent_count(node);
>   	if (num_clks > 0) {
>   		/* Calculate number of subsys_clks */
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index daa24e890dd4..e788d6bdde9d 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -39,23 +39,29 @@
>   
>   #define SPM_MAX_BUS_PROT_DATA		6
>   
> -#define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
> -		.bus_prot_mask = (_mask),			\
> -		.bus_prot_set = _set,				\
> -		.bus_prot_clr = _clr,				\
> -		.bus_prot_sta = _sta,				\
> -		.bus_prot_reg_update = _update,			\
> -		.ignore_clr_ack = _ignore,			\
> +#define _BUS_PROT(_mask, _sta_mask, _set, _clr, _sta, _update, _ignore, _way_en) {	\
> +		.bus_prot_mask = (_mask),				\
> +		.bus_prot_set = _set,					\
> +		.bus_prot_clr = _clr,					\
> +		.bus_prot_sta = _sta,					\
> +		.bus_prot_sta_mask = _sta_mask,				\
> +		.bus_prot_reg_update = _update,				\
> +		.ignore_clr_ack = _ignore,				\
> +		.way_en = _way_en,					\
>   	}
>   
>   #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
> -		_BUS_PROT(_mask, _set, _clr, _sta, false, false)
> +		_BUS_PROT(_mask, _mask, _set, _clr, _sta, false, false, false)
>   
>   #define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
> -		_BUS_PROT(_mask, _set, _clr, _sta, false, true)
> +		_BUS_PROT(_mask, _mask, _set, _clr, _sta, false, true, false)
>   
>   #define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
> -		_BUS_PROT(_mask, _set, _clr, _sta, true, false)
> +		_BUS_PROT(_mask, _mask, _set, _clr, _sta, true, false, false)
> +
> +#define BUS_PROT_WAY_EN(_en_mask, _sta_mask, _set, _sta)	\
> +		_BUS_PROT(_en_mask, _sta_mask, _set, _set, _sta, true, false, \
> +			  true)
>   
>   #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
>   		BUS_PROT_UPDATE(_mask,				\
> @@ -68,8 +74,10 @@ struct scpsys_bus_prot_data {
>   	u32 bus_prot_set;
>   	u32 bus_prot_clr;
>   	u32 bus_prot_sta;
> +	u32 bus_prot_sta_mask;
>   	bool bus_prot_reg_update;
>   	bool ignore_clr_ack;
> +	bool way_en;
>   };
>   
>   /**
