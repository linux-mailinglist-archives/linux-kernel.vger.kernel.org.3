Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EDF539557
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbiEaRRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbiEaRRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:17:15 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAB7140F8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:17:14 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id w5USneYqRNUm1w5UTnpWfe; Tue, 31 May 2022 19:17:11 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 31 May 2022 19:17:11 +0200
X-ME-IP: 90.11.190.129
Message-ID: <bfe13669-0b22-2b50-12df-e37095faf62c@wanadoo.fr>
Date:   Tue, 31 May 2022 19:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/4] soc: mediatek: add support of MTK_SCPD_STRICT_BUSP
 cap
Content-Language: fr
To:     Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220530204214.913251-1-fparent@baylibre.com>
 <20220530204214.913251-3-fparent@baylibre.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220530204214.913251-3-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 30/05/2022 à 22:42, Fabien Parent a écrit :
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> This adds support of MTK_SCPD_STRICT_BUSP cap.
> This is required by the mt8365, for the MM power domain.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>   drivers/soc/mediatek/mtk-pm-domains.c | 37 ++++++++++++++++++++-------
>   drivers/soc/mediatek/mtk-pm-domains.h |  1 +
>   2 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 90b91b3b19a8..beaa5785fda2 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -263,17 +263,36 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
>   	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
>   
> -	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
> -	if (ret)
> -		goto err_pwr_ack;
> +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUSP)) {
> +		/*
> +		 * In few Mediatek platforms(e.g. MT6779), the bus protect
> +		 * policy is stricter, which leads to bus protect release must
> +		 * be prior to bus access.
> +		 */
> +		ret = scpsys_sram_enable(pd);
> +		if (ret < 0)
> +			goto err_pwr_ack;

Hi,
with this new path, the error handling path looks odd because the order 
of operation is not the same.

>   
> -	ret = scpsys_sram_enable(pd);
> -	if (ret < 0)
> -		goto err_disable_subsys_clks;
> +		ret = scpsys_bus_protect_disable(pd);
> +		if (ret < 0)
> +			goto err_pwr_ack;

Here...

>   
> -	ret = scpsys_bus_protect_disable(pd);
> -	if (ret < 0)
> -		goto err_disable_sram;
> +		ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
> +		if (ret < 0)
> +			goto err_pwr_ack;

... and here as well.

CJ

> +	} else {
> +		ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
> +		if (ret)
> +			goto err_pwr_ack;
> +
> +		ret = scpsys_sram_enable(pd);
> +		if (ret < 0)
> +			goto err_disable_subsys_clks;
> +
> +		ret = scpsys_bus_protect_disable(pd);
> +		if (ret < 0)
> +			goto err_disable_sram;
> +	}
>   
>   	return 0;
>   
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index a3955d960233..5347471bc3c4 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -8,6 +8,7 @@
>   #define MTK_SCPD_SRAM_ISO		BIT(2)
>   #define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(3)
>   #define MTK_SCPD_DOMAIN_SUPPLY		BIT(4)
> +#define MTK_SCPD_STRICT_BUSP		BIT(5)
>   #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
>   
>   #define SPM_VDE_PWR_CON			0x0210

