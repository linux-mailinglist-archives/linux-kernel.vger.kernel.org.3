Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA24B530CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiEWJiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiEWJiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:38:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16F011468;
        Mon, 23 May 2022 02:38:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6A2F11F41D24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653298694;
        bh=+mM48zHrs1vI2jvIxwtcOKf64dJhB2TyhpCjZ7uDCtM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iST7cAMPBLCjzsMh4n4atbAlZTFPjGXPOe8rZ5qUNBhXeplo0jn6hLuuDtisSlPY4
         YsOVkJL1PmOxWNYBs+S4e2IGd34M1NWLm3Feooc8JA5axyPU978spk+Y+yhqhr2AH3
         0s1MmghNKKAx5IPVPM+79b61jMHtsFYDHV1oSygaOh+DpFbc48SQh8lkIPKD1V0oCy
         8ouPBcCLu1ghmosi6rBOT8OEoMpf15Yu4OeIq1+KhaaC+goYXJDQoSm3vmF6cLTl7l
         eYU+pD0KMMLQ+srUloQc5maKkMNGLLze2Qq1JAbjVH1v3ZW/twqNSC7oMOXLqAVkAs
         tf54CFmE3Yptw==
Message-ID: <0a1c4797-cfdf-1b45-62f0-18ecf78ed335@collabora.com>
Date:   Mon, 23 May 2022 11:38:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 2/4] soc: mediatek: svs: add support for mt8186
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
 <20220523084034.26802-3-jia-wei.chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220523084034.26802-3-jia-wei.chang@mediatek.com>
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
> MT8186 svs has a number of banks which used as optimization of opp
> voltage table for corresponding dvfs drivers.
> MT8186 svs big core uses 2-line high bank and low bank to optimize the
> voltage of opp table for higher and lower frequency respectively.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/soc/mediatek/mtk-svs.c | 351 ++++++++++++++++++++++++++++++++-
>   1 file changed, 344 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 606a00a2e57d..656d0361ff7d 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c

..snip..

> @@ -2245,6 +2569,16 @@ static const struct svs_platform_data svs_mt8192_platform_data = {
>   	.bank_max = ARRAY_SIZE(svs_mt8192_banks),
>   };
>   
> +static const struct svs_platform_data svs_mt8186_platform_data = {
> +	.name = "mt8186-svs",
> +	.banks = svs_mt8186_banks,
> +	.efuse_parsing = svs_mt8186_efuse_parsing,
> +	.probe = svs_mt8186_platform_probe,
> +	.irqflags = IRQF_TRIGGER_HIGH,

I know I gave you my R-b tag earlier, but I've just noticed that: please remove
irqflags, as this kind of flags are specified in devicetree and it is not
necessary to specify them here.

Thanks,
Angelo
