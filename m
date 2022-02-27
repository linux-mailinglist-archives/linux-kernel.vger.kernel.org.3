Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB72E4C5C79
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 16:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiB0PCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 10:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiB0PCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 10:02:12 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505836D1B2;
        Sun, 27 Feb 2022 07:01:35 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id y7so11365326oih.5;
        Sun, 27 Feb 2022 07:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=Dt2CstZbDRcILlp2OTf0pybA98dCd6PGokRHBgdlVeU=;
        b=Z0/QYD5v+W0JQR26MU3psLvCzSgxvwfy6QorRfXtGO94pjLH6PCFG68ybQDsXHMdey
         03ab7QUHqPwX9Q5UNU/MD6QzUL9DU9f30keUji0X24JE/x/+oVVXwDCO8ecGP/kD1j6i
         fswrfo1qctAmerKHd42Z20BmCyEQkdouzolfjQTnMdAtLGQRQQo59xCotcgEgI2KkO9E
         KWjs0tNgAL0g3D+FusU6T3r8V9IT1WcFuvlA9FzO9EAdIWTK0pIuEP8Cl0Fht2lbl241
         /QySGBc7AxiqB7vuYtq4YcbT1FbAuO6YISoVTdUolEVsoBHijwlpX2c9bT6hrnZqZ+/X
         gTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=Dt2CstZbDRcILlp2OTf0pybA98dCd6PGokRHBgdlVeU=;
        b=MEXfSVvPhE1WNhFBV0asBpsq0Aqzue4n2vZV2zvnuye2mIwgIWxZ9qGtobKgSz2vg3
         sl80DE1Cbe+IHIsBsiYR+3fLJ/+8VVoLCorQSB6JT5XWsLbympkEHx1rgoXY1KbK/Hp7
         wb96jhN8fxHLzKRhFoFYWtF+xGC3Yyr3weilDF4vdYzTTNtBV0dKjC30UQF4WUh20I0I
         fVmoW70ujExxgzYFbqzbkxKIi0SHOuf0Hd27HfXUdO3Lg9O5eT9xn0qoxvTooMqnrZwk
         0sdoiku2iF+F8mWabETNlJS2EknCUK7ZbVvc7gdyaRRm+M5Z5idMMSef95jZyFZqCT9H
         lAaQ==
X-Gm-Message-State: AOAM533KoKITzoX+NVoOUWQqwZLQeRXVwYkhrkVIshlqUsOUnfkkSZrK
        IQi4D7InqTaJWFbZTABJGCbXclehDHM=
X-Google-Smtp-Source: ABdhPJzpivHohiXlZVbdqCFZmP1Z3O8YXb5tSedGhroFC/BjJOsw1girvHKIC5KY7IRixipBELl++w==
X-Received: by 2002:a05:6808:1402:b0:2d3:4a20:3dfa with SMTP id w2-20020a056808140200b002d34a203dfamr7533400oiv.143.1645974094602;
        Sun, 27 Feb 2022 07:01:34 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j10-20020a4ad2ca000000b0031c515672d0sm3647286oos.23.2022.02.27.07.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 07:01:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b4a1d4e1-a7b9-00f9-75d2-56003138883f@roeck-us.net>
Date:   Sun, 27 Feb 2022 07:01:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Renze Nicolai <renze@rnplus.nl>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20220226133047.6226-1-zev@bewilderbeest.net>
 <20220226133047.6226-2-zev@bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/5] hwmon: (nct6775) Rearrange attr-group initialization
In-Reply-To: <20220226133047.6226-2-zev@bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/22 05:30, Zev Weiss wrote:
> We now track the number of attribute groups in nct6775_data, as a
> measure to simplify handling differences in the set of enabled
> attribute groups between nct6775 drivers (platform & i2c).  As a side
> effect, we also reduce the amount of IS_ERR()/PTR_ERR() boilerplate a
> bit.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>   drivers/hwmon/nct6775.c | 84 ++++++++++++++++++++---------------------
>   1 file changed, 42 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index 2b91f7e05126..139b2fe5ca4d 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -1198,6 +1198,7 @@ struct nct6775_data {
>   	const char *name;
>   
>   	const struct attribute_group *groups[7];
> +	u8 num_groups;
>   
>   	u16 reg_temp[5][NUM_TEMP]; /* 0=temp, 1=temp_over, 2=temp_hyst,
>   				    * 3=temp_crit, 4=temp_lcrit
> @@ -1405,10 +1406,18 @@ struct sensor_template_group {
>   	int base;
>   };
>   
> -static struct attribute_group *
> -nct6775_create_attr_group(struct device *dev,
> -			  const struct sensor_template_group *tg,
> -			  int repeat)
> +static int nct6775_add_attr_group(struct nct6775_data *data, const struct attribute_group *group)
> +{
> +	/* Need to leave a NULL terminator at the end of data->groups */
> +	if (WARN_ON(data->num_groups == ARRAY_SIZE(data->groups) - 1))
> +		return -ENOSPC;
> +

At work we are struggling with a whopping 500,000+ (!) WARN backtraces
_each day_. I would be happy if you send me patches removing some of
those, but I am not inclined to accept patches adding them. If people
don't notice that the driver doesn't load, they won't notice the warning
either, and it will just add to all the other warning backtrace noise.

Guenter

> +	data->groups[data->num_groups++] = group;
> +	return 0;
> +}
> +
> +static int nct6775_add_template_attr_group(struct device *dev, struct nct6775_data *data,
> +					   const struct sensor_template_group *tg, int repeat)
>   {
>   	struct attribute_group *group;
>   	struct sensor_device_attr_u *su;
> @@ -1419,28 +1428,28 @@ nct6775_create_attr_group(struct device *dev,
>   	int i, count;
>   
>   	if (repeat <= 0)
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>   
>   	t = tg->templates;
>   	for (count = 0; *t; t++, count++)
>   		;
>   
>   	if (count == 0)
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>   
>   	group = devm_kzalloc(dev, sizeof(*group), GFP_KERNEL);
>   	if (group == NULL)
> -		return ERR_PTR(-ENOMEM);
> +		return -ENOMEM;
>   
>   	attrs = devm_kcalloc(dev, repeat * count + 1, sizeof(*attrs),
>   			     GFP_KERNEL);
>   	if (attrs == NULL)
> -		return ERR_PTR(-ENOMEM);
> +		return -ENOMEM;
>   
>   	su = devm_kzalloc(dev, array3_size(repeat, count, sizeof(*su)),
>   			       GFP_KERNEL);
>   	if (su == NULL)
> -		return ERR_PTR(-ENOMEM);
> +		return -ENOMEM;
>   
>   	group->attrs = attrs;
>   	group->is_visible = tg->is_visible;
> @@ -1478,7 +1487,7 @@ nct6775_create_attr_group(struct device *dev,
>   		}
>   	}
>   
> -	return group;
> +	return nct6775_add_attr_group(data, group);
>   }
>   
>   static bool is_word_sized(struct nct6775_data *data, u16 reg)
> @@ -4020,10 +4029,8 @@ static int nct6775_probe(struct platform_device *pdev)
>   	const u16 *reg_temp_crit_l = NULL, *reg_temp_crit_h = NULL;
>   	int num_reg_temp, num_reg_temp_mon, num_reg_tsi_temp;
>   	u8 cr2a;
> -	struct attribute_group *group;
>   	struct device *hwmon_dev;
>   	struct sensor_template_group tsi_temp_tg;
> -	int num_attr_groups = 0;
>   
>   	if (sio_data->access == access_direct) {
>   		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> @@ -4844,46 +4851,39 @@ static int nct6775_probe(struct platform_device *pdev)
>   	nct6775_init_fan_common(dev, data);
>   
>   	/* Register sysfs hooks */
> -	group = nct6775_create_attr_group(dev, &nct6775_pwm_template_group,
> -					  data->pwm_num);
> -	if (IS_ERR(group))
> -		return PTR_ERR(group);
> -
> -	data->groups[num_attr_groups++] = group;
> -
> -	group = nct6775_create_attr_group(dev, &nct6775_in_template_group,
> -					  fls(data->have_in));
> -	if (IS_ERR(group))
> -		return PTR_ERR(group);
> -
> -	data->groups[num_attr_groups++] = group;
> -
> -	group = nct6775_create_attr_group(dev, &nct6775_fan_template_group,
> -					  fls(data->has_fan));
> -	if (IS_ERR(group))
> -		return PTR_ERR(group);
> +	err = nct6775_add_template_attr_group(dev, data, &nct6775_pwm_template_group,
> +					      data->pwm_num);
> +	if (err)
> +		return err;
>   
> -	data->groups[num_attr_groups++] = group;
> +	err = nct6775_add_template_attr_group(dev, data, &nct6775_in_template_group,
> +					      fls(data->have_in));
> +	if (err)
> +		return err;
>   
> -	group = nct6775_create_attr_group(dev, &nct6775_temp_template_group,
> -					  fls(data->have_temp));
> -	if (IS_ERR(group))
> -		return PTR_ERR(group);
> +	err = nct6775_add_template_attr_group(dev, data, &nct6775_fan_template_group,
> +					      fls(data->has_fan));
> +	if (err)
> +		return err;
>   
> -	data->groups[num_attr_groups++] = group;
> +	err = nct6775_add_template_attr_group(dev, data, &nct6775_temp_template_group,
> +					      fls(data->have_temp));
> +	if (err)
> +		return err;
>   
>   	if (data->have_tsi_temp) {
>   		tsi_temp_tg.templates = nct6775_tsi_temp_template;
>   		tsi_temp_tg.is_visible = nct6775_tsi_temp_is_visible;
>   		tsi_temp_tg.base = fls(data->have_temp) + 1;
> -		group = nct6775_create_attr_group(dev, &tsi_temp_tg, fls(data->have_tsi_temp));
> -		if (IS_ERR(group))
> -			return PTR_ERR(group);
> -
> -		data->groups[num_attr_groups++] = group;
> +		err = nct6775_add_template_attr_group(dev, data, &tsi_temp_tg,
> +						      fls(data->have_tsi_temp));
> +		if (err)
> +			return err;
>   	}
>   
> -	data->groups[num_attr_groups++] = &nct6775_group_other;
> +	err = nct6775_add_attr_group(data, &nct6775_group_other);
> +	if (err)
> +		return err;
>   
>   	hwmon_dev = devm_hwmon_device_register_with_groups(dev, data->name,
>   							   data, data->groups);

