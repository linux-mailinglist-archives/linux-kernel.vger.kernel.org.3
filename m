Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E79580F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiGZIz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiGZIzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:55:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4822ED58;
        Tue, 26 Jul 2022 01:55:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 360556601B15;
        Tue, 26 Jul 2022 09:55:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658825751;
        bh=7IwJqaz+R5Cs5Q6KElpkBqwQlDJ+5hJluvz7CFG5eNU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jNQ02sBc0MrrXzNT1gras1gHBPXz14i+8cCbYPXC24xWIOvSV/MAMSrRkk19OiVqr
         FliZzLpJ5TI/xIxmKmidC3TDY+q0rIBNsWmtl/ka52N0ZNivIzjbL9CMWDwrqAMn77
         oIqr5KKhn7UFwYiopl614ipkm7p41C8Wqjet82I9LThlG/YLLLnAFzmvpBan8xpRzk
         0GsPkADgUXW0y/Xjrzzj9jieQqdAXT8+uPP5n9WXS4QseQ61aGvYXtzy/ml1t2Xn3y
         e1xfb0pgf5wxeG8LBkYgy8UuL2wWV+iQwV43lcskWfXGdnREgVjRYF2IZJ/NiQO8A/
         yKhTc+/T4QIxA==
Message-ID: <5c8713ea-ad31-9d53-006b-05a3984672b2@collabora.com>
Date:   Tue, 26 Jul 2022 10:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 20/32] thermal/drivers/mtk: Switch to new of API
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Amit Kucheria <amitk@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
 <20220725212637.2818207-21-daniel.lezcano@linexp.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220725212637.2818207-21-daniel.lezcano@linexp.org>
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

Il 25/07/22 23:26, Daniel Lezcano ha scritto:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach. The ops are no longer device
> tree specific and are the generic ones provided by the core code.
> 
> Convert the ops to the thermal_zone_device_ops format and use the new
> API to register the thermal zone with these generic ops.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/thermal/mtk_thermal.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index ede94eadddda..8440692e3890 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -679,9 +679,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>   	return max;
>   }
>   
> -static int mtk_read_temp(void *data, int *temperature)
> +static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
>   {
> -	struct mtk_thermal *mt = data;
> +	struct mtk_thermal *mt = tz->devdata;
>   	int i;
>   	int tempmax = INT_MIN;
>   
> @@ -700,7 +700,7 @@ static int mtk_read_temp(void *data, int *temperature)
>   	return 0;
>   }
>   
> -static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
> +static const struct thermal_zone_device_ops mtk_thermal_ops = {
>   	.get_temp = mtk_read_temp,
>   };
>   
> @@ -1082,8 +1082,8 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, mt);
>   
> -	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
> -						     &mtk_thermal_ops);
> +	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
> +					      &mtk_thermal_ops);
>   	if (IS_ERR(tzdev)) {
>   		ret = PTR_ERR(tzdev);
>   		goto err_disable_clk_peri_therm;
> 


