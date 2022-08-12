Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F56A590E94
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbiHLKB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiHLKBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:01:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65925A5718;
        Fri, 12 Aug 2022 03:01:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24879B82316;
        Fri, 12 Aug 2022 10:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A49C433C1;
        Fri, 12 Aug 2022 10:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660298509;
        bh=s58ue2CyPXl6/8g0VYA+ViWugJ65i3F1UtTTqhXIejM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ScAbCWrrh+KuR8k+ubctiqFW5ukzlqwwV3oCSDpEhAR9JC42ccDSBUsthjS6UN3dP
         sIKQywHObhoJV+ecAAR8NXB8X7w9YMK8p+/uCirVLWmDhbYFazVrzNlMfVZfWAauyS
         cnIoGp4kJcAYspIfxnV/R2NxYKa5fX4FdXcg9p+eC1jh5uxGnYghynFo0D5MHzIaSQ
         33RqtApVF4pWR++8FeLVFA2ByywRWU6evFUsF/K+F3i6xVxpCqUhrfsMH0jughG3f9
         wFD+TDjr+BtMGZ8+a8CMjl1+hXpJ1Hri+1BpI+CQHnmbZKsUa7zUWdAkzyrEUuE9QU
         32fvoojgKqO2w==
Message-ID: <63d459cc-23f0-ce8d-9fe4-b0015b4e41ab@kernel.org>
Date:   Fri, 12 Aug 2022 13:01:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 07/26] thermal/drivers/exynos: Use generic
 thermal_zone_get_trip() function
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
 <20220809220436.711020-8-daniel.lezcano@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220809220436.711020-8-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2022 01:04, Daniel Lezcano wrote:
> The thermal framework gives the possibility to register the trip
> points with the thermal zone. When that is done, no get_trip_* ops are
> needed and they can be removed.
> 
> Convert ops content logic into generic trip points and register them with the
> thermal zone.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 41 ++++++++++------------------
>  1 file changed, 15 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 51874d0a284c..5204e343d5b0 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -260,16 +260,8 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>  {
>  	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>  	struct thermal_zone_device *tzd = data->tzd;
> -	const struct thermal_trip * const trips =
> -		of_thermal_get_trip_points(tzd);
>  	unsigned int status;
> -	int ret = 0, temp, hyst;
> -
> -	if (!trips) {
> -		dev_err(&pdev->dev,
> -			"Cannot get trip points from device tree!\n");
> -		return -ENODEV;
> -	}
> +	int ret = 0, temp;
>  
>  	if (data->soc != SOC_ARCH_EXYNOS5433) /* FIXME */
>  		ret = tzd->ops->get_crit_temp(tzd, &temp);
> @@ -303,19 +295,16 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>  
>  		/* Write temperature code for rising and falling threshold */
>  		for (i = 0; i < ntrips; i++) {
> -			/* Write temperature code for rising threshold */
> -			ret = tzd->ops->get_trip_temp(tzd, i, &temp);
> -			if (ret)
> -				goto err;
> -			temp /= MCELSIUS;
> -			data->tmu_set_trip_temp(data, i, temp);
>  
> -			/* Write temperature code for falling threshold */
> -			ret = tzd->ops->get_trip_hyst(tzd, i, &hyst);
> +			struct thermal_trip trip;
> +			
> +			ret = thermal_zone_get_trip(tzd, i, &trip);
>  			if (ret)
>  				goto err;
> -			hyst /= MCELSIUS;
> -			data->tmu_set_trip_hyst(data, i, temp, hyst);
> +
> +			data->tmu_set_trip_temp(data, i, trip.temperature / MCELSIUS);
> +			data->tmu_set_trip_hyst(data, i, trip.temperature / MCELSIUS,
> +						trip.hysteresis / MCELSIUS);
>  		}
>  
>  		data->tmu_clear_irqs(data);
> @@ -360,21 +349,21 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
>  }
>  
>  static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
> -					 int trip, u8 temp)
> +					 int trip_id, u8 temp)
>  {
> -	const struct thermal_trip * const trips =
> -		of_thermal_get_trip_points(data->tzd);
> +	struct thermal_trip trip;
>  	u8 ref, th_code;
>  
> -	ref = trips[0].temperature / MCELSIUS;
> -
> -	if (trip == 0) {
> +	thermal_zone_get_trip(data->tzd, 0, &trip);

This can return error and trip will be uninitialized.


Best regards,
Krzysztof
