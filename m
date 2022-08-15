Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFDE59308E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiHOOTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiHOOTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:19:06 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8A651F2C9;
        Mon, 15 Aug 2022 07:19:05 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 15 Aug 2022 23:19:05 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 3096920584CE;
        Mon, 15 Aug 2022 23:19:05 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 15 Aug 2022 23:19:05 +0900
Received: from [10.212.182.72] (unknown [10.212.182.72])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 3F146B62A4;
        Mon, 15 Aug 2022 23:19:04 +0900 (JST)
Subject: Re: [PATCH v2 09/26] thermal/drivers/uniphier: Use generic
 thermal_zone_get_trip() function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "moderated list:ARM/UNIPHIER ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
 <20220809220436.711020-10-daniel.lezcano@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <2dd3203b-8d49-9976-e79c-f23473eb30a4@socionext.com>
Date:   Mon, 15 Aug 2022 23:19:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220809220436.711020-10-daniel.lezcano@linaro.org>
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

On 2022/08/10 7:04, Daniel Lezcano wrote:
> The thermal framework gives the possibility to register the trip
> points with the thermal zone. When that is done, no get_trip_* ops are
> needed and they can be removed.
> 
> Convert ops content logic into generic trip points and register them with
> the
> thermal zone.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/uniphier_thermal.c | 26 +++++++++++---------------
>   1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/thermal/uniphier_thermal.c
> b/drivers/thermal/uniphier_thermal.c
> index 4111d99ef50e..1675174480aa 100644
> --- a/drivers/thermal/uniphier_thermal.c
> +++ b/drivers/thermal/uniphier_thermal.c
> @@ -248,8 +248,7 @@ static int uniphier_tm_probe(struct platform_device
> *pdev)
>   	struct regmap *regmap;
>   	struct device_node *parent;
>   	struct uniphier_tm_dev *tdev;
> -	const struct thermal_trip *trips;
> -	int i, ret, irq, ntrips, crit_temp = INT_MAX;
> +	int i, ret, irq, crit_temp = INT_MAX;
>   
>   	tdev = devm_kzalloc(dev, sizeof(*tdev), GFP_KERNEL);
>   	if (!tdev)
> @@ -296,20 +295,17 @@ static int uniphier_tm_probe(struct platform_device
> *pdev)
>   		return PTR_ERR(tdev->tz_dev);
>   	}
>   
> -	/* get trip points */
> -	trips = of_thermal_get_trip_points(tdev->tz_dev);
> -	ntrips = of_thermal_get_ntrips(tdev->tz_dev);
> -	if (ntrips > ALERT_CH_NUM) {
> -		dev_err(dev, "thermal zone has too many trips\n");
> -		return -E2BIG;
> -	}
> -
>   	/* set alert temperatures */
> -	for (i = 0; i < ntrips; i++) {
> -		if (trips[i].type == THERMAL_TRIP_CRITICAL &&
> -		    trips[i].temperature < crit_temp)
> -			crit_temp = trips[i].temperature;
> -		uniphier_tm_set_alert(tdev, i, trips[i].temperature);
> +	for (i = 0; i < thermal_zone_get_num_trips(tdev->tz_dev); i++) {
> +
> +		struct thermal_trip trip;
> +
> +		thermal_zone_get_trip(tdev->tz_dev, i, &trip);
> +		

I found this line has white spaces. Otherwise,

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

> +		if (trip.type == THERMAL_TRIP_CRITICAL &&
> +		    trip.temperature < crit_temp)
> +			crit_temp = trip.temperature;
> +		uniphier_tm_set_alert(tdev, i, trip.temperature);
>   		tdev->alert_en[i] = true;
>   	}
>   	if (crit_temp > CRITICAL_TEMP_LIMIT) {
> 

---
Best Regards
Kunihiko Hayashi
