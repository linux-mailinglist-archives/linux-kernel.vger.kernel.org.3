Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48E559308C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242851AbiHOOSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242847AbiHOOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:18:10 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 242B221808;
        Mon, 15 Aug 2022 07:18:08 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 15 Aug 2022 23:18:07 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id E63C92059027;
        Mon, 15 Aug 2022 23:18:06 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 15 Aug 2022 23:18:06 +0900
Received: from [10.212.182.72] (unknown [10.212.182.72])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 1CC63B62A4;
        Mon, 15 Aug 2022 23:18:05 +0900 (JST)
Subject: Re: [PATCH v5 04/33] thermal/drivers/uniphier: Switch to new of API
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        mhiramat@kernel.org, talel@amazon.com, thierry.reding@gmail.com,
        digetx@gmail.com, jonathanh@nvidia.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, baolin.wang7@gmail.com,
        f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        mcoquelin.stm32@gmail.com, glaroque@baylibre.com,
        miquel.raynal@bootlin.com, shawnguo@kernel.org,
        niklas.soderlund@ragnatech.se, matthias.bgg@gmail.com,
        j-keerthy@ti.com, Amit Kucheria <amitk@kernel.org>,
        "moderated list:ARM/UNIPHIER ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220804224349.1926752-5-daniel.lezcano@linexp.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <fcb9c36a-1e4f-f406-6309-9661392936db@socionext.com>
Date:   Mon, 15 Aug 2022 23:18:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220804224349.1926752-5-daniel.lezcano@linexp.org>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/08/05 7:43, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach. The ops are no longer device
> tree specific and are the generic ones provided by the core code.
> 
> Convert the ops to the thermal_zone_device_ops format and use the new
> API to register the thermal zone with these generic ops.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

> ---
>   drivers/thermal/uniphier_thermal.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/uniphier_thermal.c
> b/drivers/thermal/uniphier_thermal.c
> index 4cae5561a2a3..4111d99ef50e 100644
> --- a/drivers/thermal/uniphier_thermal.c
> +++ b/drivers/thermal/uniphier_thermal.c
> @@ -187,9 +187,9 @@ static void uniphier_tm_disable_sensor(struct
> uniphier_tm_dev *tdev)
>   	usleep_range(1000, 2000);	/* The spec note says at least 1ms
> */
>   }
>   
> -static int uniphier_tm_get_temp(void *data, int *out_temp)
> +static int uniphier_tm_get_temp(struct thermal_zone_device *tz, int
> *out_temp)
>   {
> -	struct uniphier_tm_dev *tdev = data;
> +	struct uniphier_tm_dev *tdev = tz->devdata;
>   	struct regmap *map = tdev->regmap;
>   	int ret;
>   	u32 temp;
> @@ -204,7 +204,7 @@ static int uniphier_tm_get_temp(void *data, int
> *out_temp)
>   	return 0;
>   }
>   
> -static const struct thermal_zone_of_device_ops uniphier_of_thermal_ops =
> {
> +static const struct thermal_zone_device_ops uniphier_of_thermal_ops = {
>   	.get_temp = uniphier_tm_get_temp,
>   };
>   
> @@ -289,8 +289,8 @@ static int uniphier_tm_probe(struct platform_device
> *pdev)
>   
>   	platform_set_drvdata(pdev, tdev);
>   
> -	tdev->tz_dev = devm_thermal_zone_of_sensor_register(dev, 0, tdev,
> -						&uniphier_of_thermal_ops);
> +	tdev->tz_dev = devm_thermal_of_zone_register(dev, 0, tdev,
> +						
> &uniphier_of_thermal_ops);
>   	if (IS_ERR(tdev->tz_dev)) {
>   		dev_err(dev, "failed to register sensor device\n");
>   		return PTR_ERR(tdev->tz_dev);
> 

---
Best Regards
Kunihiko Hayashi
