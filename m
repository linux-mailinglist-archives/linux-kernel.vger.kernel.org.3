Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E8C57FBFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiGYJHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiGYJHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:07:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE88C101DA;
        Mon, 25 Jul 2022 02:07:28 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8899066015E7;
        Mon, 25 Jul 2022 10:07:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658740047;
        bh=uBO/pkzkv5EBZYyQnsx8/L7C7pGHaycXjjQey8xXLe4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QbtCyY/TkCm/cZ6AZqWzL7/QMYs2ImlWgUzVxfDiic5PcKm8bW9KeO+u+AdbMM+Z5
         bI0DjNsw21DmjykhDxvsLDyL1ImWvZ3OX2VSLVeSLlAM5D5uslVqbPAImGNKuZhzMf
         KetO4iahmMfcG0fIOg9u+5J0dbyU2UXGs6FSJn54KQ+gqrvaEasYO8sUe9uotVNFkb
         G72Aby95gW0LR8kpNE0tlQlRlmQv4Ulnzu48hz39lC8Tct1N1XO7Dk9CLcjrnvtun3
         xfll+2wTR+urIfDaTR5MdkiKhFzVMVuK1q5YVk/ROibH5h5QwLFEQ0brJiHvTjaOVQ
         CUnU9FPjpDKog==
Message-ID: <59d9e674-2021-b02e-4ec8-aee8a118a96d@collabora.com>
Date:   Mon, 25 Jul 2022 11:07:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] soc: mediatek: add support of MTK_SCPD_STRICT_BUSP
 cap
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
 <20220725081853.1636444-4-msp@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220725081853.1636444-4-msp@baylibre.com>
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
> This adds support for MTK_SCPD_STRICT_BUSP capability. It is a strict
> bus protection policy that requires the bus protection to be disabled
> before accessing the bus.
> This is required by the mt8365, for the MM power domain.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> 
> Notes:
>      Changes in v2:
>      - Fixup error handling path.
> 
>   drivers/soc/mediatek/mtk-pm-domains.c | 29 +++++++++++++++++++++++----
>   drivers/soc/mediatek/mtk-pm-domains.h |  1 +
>   2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index d0eae2227813..94ca8981f45e 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -240,6 +240,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   	struct scpsys *scpsys = pd->scpsys;
>   	bool tmp;
>   	int ret;
> +	bool strict_busprotect;
>   
>   	ret = scpsys_regulator_enable(pd->supply);
>   	if (ret)
> @@ -263,9 +264,18 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
>   	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
>   
> -	ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
> -	if (ret)
> -		goto err_pwr_ack;
> +	/*
> +	 * In few Mediatek platforms(e.g. MT6779), the bus protect policy is
> +	 * stricter, which leads to bus protect release must be prior to bus
> +	 * access.
> +	 */
> +	strict_busprotect = MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUSP);
> +	if (!strict_busprotect) {

Please directly check for MTK_SCPD_CAPS, you don't really need that bool variable,
not even for performance... and it fits just fine in one line, even.

	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION)) {

> +		ret = clk_bulk_prepare_enable(pd->num_subsys_clks,
> +					      pd->subsys_clks);
> +		if (ret)
> +			goto err_pwr_ack;
> +	}
>   
>   	ret = scpsys_sram_enable(pd);
>   	if (ret < 0)
> @@ -275,12 +285,23 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   	if (ret < 0)
>   		goto err_disable_sram;
>   
> +	if (strict_busprotect) {

	if (MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION)) {

> +		ret = clk_bulk_prepare_enable(pd->num_subsys_clks,
> +					      pd->subsys_clks);
> +		if (ret)
> +			goto err_enable_bus_protect;
> +	}
> +
>   	return 0;
>   
> +err_enable_bus_protect:

For human readability purposes (and paranoidly preventing future mistakes), I'd
add a check for the strict bus protection cap here too.

> +	scpsys_bus_protect_enable(pd);
>   err_disable_sram:
>   	scpsys_sram_disable(pd);
>   err_disable_subsys_clks:
> -	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
> +	if (!strict_busprotect)
> +		clk_bulk_disable_unprepare(pd->num_subsys_clks,
> +					   pd->subsys_clks);
>   err_pwr_ack:
>   	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
>   err_reg:
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index e788d6bdde9d..a50cfb926d22 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -8,6 +8,7 @@
>   #define MTK_SCPD_SRAM_ISO		BIT(2)
>   #define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(3)
>   #define MTK_SCPD_DOMAIN_SUPPLY		BIT(4)
> +#define MTK_SCPD_STRICT_BUSP		BIT(5)

MTK_SCPD_STRICT_BUS_PROTECTION is a bit more human readable.

>   #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
>   
>   #define SPM_VDE_PWR_CON			0x0210

Regards,
Angelo
