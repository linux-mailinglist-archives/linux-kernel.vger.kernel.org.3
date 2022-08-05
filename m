Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F2458A46C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiHEBUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiHEBUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:20:04 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D0871BCE;
        Thu,  4 Aug 2022 18:20:03 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2751JdLK127630;
        Thu, 4 Aug 2022 20:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659662379;
        bh=xVg4Rc1wyAEPnHP+dLUX1rSBue1ZBaUejyLmG1hs/xM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=RKJBGrROxMIOhbL1NYPde9O27IUb2mWnVnJJcwri26pQkiPeCWorOh97k8QjQDlhg
         8sF6awfejheK8JnWrUQYMUetjeU9a+jHFmIrYjJYwire4c9YEQTSaCAzha7e3pCqiR
         qiRYAkoYZSwc/RocVGz70IfkFeDHizS0e20+gSRk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2751JdVi006868
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Aug 2022 20:19:39 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 4
 Aug 2022 20:19:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 4 Aug 2022 20:19:38 -0500
Received: from [10.250.232.200] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2751JTAX008557;
        Thu, 4 Aug 2022 20:19:30 -0500
Message-ID: <d55ed858-ccb2-1983-e93a-3090e1960eb0@ti.com>
Date:   Fri, 5 Aug 2022 06:49:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 24/33] thermal/drivers/ti-soc: Switch to new of API
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        <daniel.lezcano@linaro.org>, <rafael@kernel.org>
CC:     <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <khilman@baylibre.com>,
        <abailon@baylibre.com>, <lukasz.luba@arm.com>,
        <broonie@kernel.org>, <damien.lemoal@opensource.wdc.com>,
        <heiko@sntech.de>, <hayashi.kunihiko@socionext.com>,
        <mhiramat@kernel.org>, <talel@amazon.com>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>,
        <jonathanh@nvidia.com>, <anarsoul@gmail.com>,
        <tiny.windzz@gmail.com>, <baolin.wang7@gmail.com>,
        <f.fainelli@gmail.com>, <bjorn.andersson@linaro.org>,
        <mcoquelin.stm32@gmail.com>, <glaroque@baylibre.com>,
        <miquel.raynal@bootlin.com>, <shawnguo@kernel.org>,
        <niklas.soderlund@ragnatech.se>, <matthias.bgg@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220804224349.1926752-25-daniel.lezcano@linexp.org>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <20220804224349.1926752-25-daniel.lezcano@linexp.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/2022 4:13 AM, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach. The ops are no longer device
> tree specific and are the generic ones provided by the core code.
> 
> Convert the ops to the thermal_zone_device_ops format and use the new
> API to register the thermal zone with these generic ops.

Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>   .../thermal/ti-soc-thermal/ti-thermal-common.c   | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index 703039d8b937..8a9055bd376e 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -65,10 +65,10 @@ static inline int ti_thermal_hotspot_temperature(int t, int s, int c)
>   
>   /* thermal zone ops */
>   /* Get temperature callback function for thermal zone */
> -static inline int __ti_thermal_get_temp(void *devdata, int *temp)
> +static inline int __ti_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>   {
>   	struct thermal_zone_device *pcb_tz = NULL;
> -	struct ti_thermal_data *data = devdata;
> +	struct ti_thermal_data *data = tz->devdata;
>   	struct ti_bandgap *bgp;
>   	const struct ti_temp_sensor *s;
>   	int ret, tmp, slope, constant;
> @@ -85,8 +85,8 @@ static inline int __ti_thermal_get_temp(void *devdata, int *temp)
>   		return ret;
>   
>   	/* Default constants */
> -	slope = thermal_zone_get_slope(data->ti_thermal);
> -	constant = thermal_zone_get_offset(data->ti_thermal);
> +	slope = thermal_zone_get_slope(tz);
> +	constant = thermal_zone_get_offset(tz);
>   
>   	pcb_tz = data->pcb_tz;
>   	/* In case pcb zone is available, use the extrapolation rule with it */
> @@ -107,9 +107,9 @@ static inline int __ti_thermal_get_temp(void *devdata, int *temp)
>   	return ret;
>   }
>   
> -static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
> +static int __ti_thermal_get_trend(struct thermal_zone_device *tz, int trip, enum thermal_trend *trend)
>   {
> -	struct ti_thermal_data *data = p;
> +	struct ti_thermal_data *data = tz->devdata;
>   	struct ti_bandgap *bgp;
>   	int id, tr, ret = 0;
>   
> @@ -130,7 +130,7 @@ static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
>   	return 0;
>   }
>   
> -static const struct thermal_zone_of_device_ops ti_of_thermal_ops = {
> +static const struct thermal_zone_device_ops ti_of_thermal_ops = {
>   	.get_temp = __ti_thermal_get_temp,
>   	.get_trend = __ti_thermal_get_trend,
>   };
> @@ -170,7 +170,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
>   		return -EINVAL;
>   
>   	/* in case this is specified by DT */
> -	data->ti_thermal = devm_thermal_zone_of_sensor_register(bgp->dev, id,
> +	data->ti_thermal = devm_thermal_of_zone_register(bgp->dev, id,
>   					data, &ti_of_thermal_ops);
>   	if (IS_ERR(data->ti_thermal)) {
>   		dev_err(bgp->dev, "thermal zone device is NULL\n");
