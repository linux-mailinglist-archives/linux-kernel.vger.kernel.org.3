Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFFC4639B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242985AbhK3PUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbhK3PSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:18:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB9AC061763
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:13:06 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so19851665wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IiS4gXcieiwHRh30CfBLD5DtuaajJ0EBlCiC0ifH9UE=;
        b=S4bHKWWNsiRIbQrdnZkJeQwDDYj/eB6dkFyudT5wZl5zUv6G4RoAt1uTW/CoMpC77L
         Xw66Ax43FuHN/EsOedhnUpsZVfX5YuYj/J34O24C67kjmPOOE4FtTZlP0uiiFQ2rdM2+
         BuS+DphEsQLMWXvj+KPaITcYDyEHR8sciuYYw7DkPBgaozUYmZiZGZQYs2hgqfuoqYlu
         6sFYCK9h6eFKxZ7cfqMz4DOggsnkAy7us2PjQQPEu5l9kJoqEJxPel6ClwQA3GppsezB
         Gxl5xhA2iy35HkLwkMCQSs6OSx5XhrAD3h8a2nZOyt5TLrYBTiXRQXoq0L+XxGA6Mp7h
         tJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IiS4gXcieiwHRh30CfBLD5DtuaajJ0EBlCiC0ifH9UE=;
        b=qQ9BR2xMPLi/2RAohBu+ARC9iWF7o8BpzJ11pa/sXhPRAs1NSmj0JDze4vQBcQwRKe
         vWve/l2TCE9Y7yA14rMapweMGwBCGdj50D2/pBJjyDNre8WuVUdxHlkGOJKzFCeoCCmY
         NR606xVmSn3vC/diLUPykmzMPfiM3ZqB9CXemRs9D/69jfh0E3V7GY7MsqKAaIzqr/lK
         DWwAt46rTviYlbLgDdOXk62Yp4/UvQon1i12KTLMw+6DNA56++BOFQE6XVB5d64vjUU0
         pp+4hHvLl0Kmng1qKIPDy2KCB7TCsf7QYoWPQh1APZywQvY1IvpjOHH9a7X+nrImdHW3
         CTAQ==
X-Gm-Message-State: AOAM5314kQZLpASUW0DbUfM4uunIvJhw8e1w/vwItrys+xOxmzRmVHV3
        DSSjbiW34dxXSOwZJz6rF/SPfw==
X-Google-Smtp-Source: ABdhPJxVSAiBi7i5Qr1WSohC8Mr+dbuwKYwzM31nuLIOanvnl65+v/sEmGRaPG91oFjfdXjaD3ZKnA==
X-Received: by 2002:a7b:c008:: with SMTP id c8mr5917393wmb.55.1638285184845;
        Tue, 30 Nov 2021 07:13:04 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:7880:daae:2d50:bb5e? ([2a01:e34:ed2f:f020:7880:daae:2d50:bb5e])
        by smtp.googlemail.com with ESMTPSA id q24sm2480860wmj.21.2021.11.30.07.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 07:13:04 -0800 (PST)
Subject: Re: [PATCH] thermal: qoriq: Only enable sites that actually exist
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel@puri.sm
References: <20211129110252.1699112-1-sebastian.krzyszkowiak@puri.sm>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4a470e25-b1fa-bf7b-18d2-d21cbfe4fb3a@linaro.org>
Date:   Tue, 30 Nov 2021 16:13:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211129110252.1699112-1-sebastian.krzyszkowiak@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Sebastian,

thanks for the fix.

On 29/11/2021 12:02, Sebastian Krzyszkowiak wrote:
> On i.MX8MQ, enabling monitoring sites that aren't connected to anything
> can cause unwanted side effects on some units. This seems to happen
> once some of these sites report out-of-range readings and results in
> sensor misbehavior, such as thermal zone readings getting stuck or even
> suddenly reporting an impossibly high value, triggering emergency
> shutdowns.
> 
> The datasheet lists all non-existent sites as "reserved" and doesn't
> make any guarantees about being able to enable them at all, so let's
> not do that.

The description of what does the patch is missing here.

> Fixes: 45038e03d633 ("thermal: qoriq: Enable all sensors before registering them")
> 
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
>  drivers/thermal/qoriq_thermal.c | 63 ++++++++++++++++++++++-----------
>  1 file changed, 43 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 73049f9bea25..ef0848849ee2 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -32,7 +32,6 @@
>  #define TMR_DISABLE	0x0
>  #define TMR_ME		0x80000000
>  #define TMR_ALPF	0x0c000000
> -#define TMR_MSITE_ALL	GENMASK(15, 0)
>  
>  #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
>  #define TMTMIR_DEFAULT	0x0000000f
> @@ -129,33 +128,51 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
>  static int qoriq_tmu_register_tmu_zone(struct device *dev,
>  				       struct qoriq_tmu_data *qdata)
>  {
> -	int id;
> +	int ret = 0;
> +	struct device_node *np, *child, *sensor_np;
>  
> -	if (qdata->ver == TMU_VER1) {
> -		regmap_write(qdata->regmap, REGS_TMR,
> -			     TMR_MSITE_ALL | TMR_ME | TMR_ALPF);
> -	} else {
> -		regmap_write(qdata->regmap, REGS_V2_TMSR, TMR_MSITE_ALL);
> -		regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF_V2);
> -	}
> +	np = of_find_node_by_name(NULL, "thermal-zones");
> +	if (!np)
> +		return -ENODEV;
> +
> +	sensor_np = of_node_get(dev->of_node);
>  
> -	for (id = 0; id < SITES_MAX; id++) {
> +	for_each_available_child_of_node(np, child) {
>  		struct thermal_zone_device *tzd;
> -		struct qoriq_sensor *sensor = &qdata->sensor[id];
> -		int ret;
> +		struct qoriq_sensor *sensor;
> +		int id, site;
> +
> +		ret = thermal_zone_of_get_sensor_id(child, sensor_np, &id);
> +
> +		if (ret < 0) {
> +			dev_err(dev, "failed to get valid sensor id: %d\n", ret);
> +			of_node_put(child);
> +			break;
> +		}
>  
> +		sensor = &qdata->sensor[id];
>  		sensor->id = id;
>  
> +		/* Enable monitoring */
> +		if (qdata->ver == TMU_VER1) {
> +			site = 0x1 << (15 - id);
> +			regmap_update_bits(qdata->regmap, REGS_TMR,
> +					   site | TMR_ME | TMR_ALPF,
> +					   site | TMR_ME | TMR_ALPF);
> +		} else {
> +			site = 0x1 << id;
> +			regmap_update_bits(qdata->regmap, REGS_V2_TMSR, site, site);
> +			regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF_V2);
> +		}

Why not create the site mask in the loop and then call once the block
above out this loop?

>  		tzd = devm_thermal_zone_of_sensor_register(dev, id,
>  							   sensor,
>  							   &tmu_tz_ops);
> -		ret = PTR_ERR_OR_ZERO(tzd);
> -		if (ret) {
> -			if (ret == -ENODEV)
> -				continue;
> -
> -			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
> -			return ret;
> +		if (IS_ERR(tzd)) {
> +			ret = PTR_ERR(tzd);
> +			dev_err(dev, "failed to register thermal zone: %d\n", ret);
> +			of_node_put(child);
> +			break;
>  		}
>  
>  		if (devm_thermal_add_hwmon_sysfs(tzd))
> @@ -164,7 +181,13 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
>  
>  	}
>  
> -	return 0;
> +	of_node_put(sensor_np);
> +	of_node_put(np);
> +
> +	if (ret)
> +		regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
> +
> +	return ret;
>  }
>  
>  static int qoriq_tmu_calibration(struct device *dev,
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
