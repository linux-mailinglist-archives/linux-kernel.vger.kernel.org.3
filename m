Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F0B560AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 22:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiF2UFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 16:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiF2UFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:05:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB1535869;
        Wed, 29 Jun 2022 13:05:39 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9FC5C660194C;
        Wed, 29 Jun 2022 21:05:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656533138;
        bh=wA2jDF5jhWNY2EPA/ycOSjh4UOW5u3KqQjpi/Q1H1Xc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FI85VpieM3E2wpg+bT+g4CkrH0pcelahztRbS1nJjBf0QkiNILhd5K1gsxXRokSDh
         YcY9po03I4B1HDxJn/MCoTik+Z+Ltqf0fB0diN6+axmIojN4h9JHOEIaMXy3CkJmoR
         0Y2yjjhvJxzSuWzt+n9/AAON6WB7GkUWr745hAjvEoKN0ykf02DX6NQfilXowVNDJl
         nt++17HqsNQHXzJVPz8AtOzrThlAfu1LPu/g/kkXj5U6B3GLsCTMzU2ZgPqHuvnXtj
         grId4V+x54nSS6Xoqh/FcsVDkAc7cwDegpIvC2egtY/qjrREa76yo8t5/KMSoCDm6Y
         4GjnOsHOS7/5A==
Message-ID: <b4adef64-cc2c-14ab-b16d-3f8c27f3834b@collabora.com>
Date:   Wed, 29 Jun 2022 23:05:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] thermal/drivers/tegra: Remove get_trend function
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
 <20220616202537.303655-2-daniel.lezcano@linaro.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220616202537.303655-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 23:25, Daniel Lezcano wrote:
> The get_trend function does already what the generic framework does.
> 
> Remove it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/tegra/soctherm.c | 32 --------------------------------
>  1 file changed, 32 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index 210325f92559..825eab526619 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -633,37 +633,6 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
>  	return 0;
>  }
>  
> -static int tegra_thermctl_get_trend(void *data, int trip,
> -				    enum thermal_trend *trend)
> -{
> -	struct tegra_thermctl_zone *zone = data;
> -	struct thermal_zone_device *tz = zone->tz;
> -	int trip_temp, temp, last_temp, ret;
> -
> -	if (!tz)
> -		return -EINVAL;
> -
> -	ret = tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
> -	if (ret)
> -		return ret;
> -
> -	temp = READ_ONCE(tz->temperature);
> -	last_temp = READ_ONCE(tz->last_temperature);
> -
> -	if (temp > trip_temp) {
> -		if (temp >= last_temp)
> -			*trend = THERMAL_TREND_RAISING;
> -		else
> -			*trend = THERMAL_TREND_STABLE;
> -	} else if (temp < trip_temp) {
> -		*trend = THERMAL_TREND_DROPPING;
> -	} else {
> -		*trend = THERMAL_TREND_STABLE;
> -	}
> -
> -	return 0;
> -}
> -
>  static void thermal_irq_enable(struct tegra_thermctl_zone *zn)
>  {
>  	u32 r;
> @@ -716,7 +685,6 @@ static int tegra_thermctl_set_trips(void *data, int lo, int hi)
>  static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
>  	.get_temp = tegra_thermctl_get_temp,
>  	.set_trip_temp = tegra_thermctl_set_trip_temp,
> -	.get_trend = tegra_thermctl_get_trend,
>  	.set_trips = tegra_thermctl_set_trips,
>  };
>  

Guenter fixed the LM90 driver problem. There are other regressions in
the latest -next which complicate testing, but I can't see any problems
from the thermal side.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
