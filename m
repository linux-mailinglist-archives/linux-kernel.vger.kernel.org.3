Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1118530E43
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiEWJin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiEWJiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:38:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0671863FF;
        Mon, 23 May 2022 02:38:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A64751F426E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653298698;
        bh=XvaiufkFnN1wMlfvWPGiVI99J1BcUL6VmHZvtPIs1vM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J3u7n8+ezDneiHNhUBpp+KDQ0k6O3Slu7Ag9EoZBw4/fJx9FORvGjuEQ3g79+vbRI
         u1TR3W8Nlhoyi+mXH5Pe3Hg3ZwrCDHZk/aj7YqIgApW1JWsDnxY/RiNfBEKv15wjDo
         Je8cDqtkSt+nFrtWHGoHiGRqtc2+cmvXoLapIEf1h8vlJVmMhdGQ43BTwttlACBcu/
         s1gGnZ69LsTBCaCHHBV5QKhORxXk9tYuzndFX/8FV/FPqEw5drdpJyOKvT/kbGs4x5
         eZfmh9xaB4C58q1aVCCqzFxAiiDTjwqvu6sPZPS5l0NMNwQfMlrihU/5JPty1/nkhY
         gp0kO1HWK02lQ==
Message-ID: <d9563b65-2391-d32c-8a07-ca7a13cae7c7@collabora.com>
Date:   Mon, 23 May 2022 11:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 4/4] soc: mediatek: svs: add support for mt8195
Content-Language: en-US
To:     Tim Chang <jia-wei.chang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com
References: <20220523084034.26802-1-jia-wei.chang@mediatek.com>
 <20220523084034.26802-5-jia-wei.chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220523084034.26802-5-jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/05/22 10:40, Tim Chang ha scritto:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> To support svs on MT8195, add corresponding bank information, platform
> data, probe and parsing function.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>



> ---
>   drivers/soc/mediatek/mtk-svs.c | 151 +++++++++++++++++++++++++++++++++
>   1 file changed, 151 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 656d0361ff7d..bb5021648143 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -1680,6 +1680,89 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)

..snip..

> @@ -2559,6 +2697,16 @@ static struct svs_bank svs_mt8183_banks[] = {
>   	},
>   };
>   
> +static const struct svs_platform_data svs_mt8195_platform_data = {
> +	.name = "mt8195-svs",
> +	.banks = svs_mt8195_banks,
> +	.efuse_parsing = svs_mt8195_efuse_parsing,
> +	.probe = svs_mt8192_platform_probe,
> +	.irqflags = IRQF_TRIGGER_HIGH,

Interrupt flags are specified in devicetree; avoid declaring irqflags.

After that:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

