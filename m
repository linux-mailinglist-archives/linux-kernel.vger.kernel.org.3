Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CB04DD6B9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiCRJBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbiCRJBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10CC31F89DA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647593984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LNiAdfgE3Nl/NVyJMxU8/mXL5a6p2DA33RjxNuB2/iY=;
        b=W1G/jVZ6RnAfyZtXjfdJmuwcFnEDBQiSC7LtIRd5yRfqWoUZ8LkEPJNqs9gPC3u66v0OWq
        zEarq5FdgWvwZuypxZcA0t1QdVeLPZSjSDvpXiExOa6B4GQdxgsZV9qofWns5NqcGY5UCW
        3xtqFlk7tajRT8LZ0nVlcUefi2EFvm4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-YkD4BhFnP82epb02MBT_xg-1; Fri, 18 Mar 2022 04:59:42 -0400
X-MC-Unique: YkD4BhFnP82epb02MBT_xg-1
Received: by mail-ed1-f71.google.com with SMTP id n4-20020a5099c4000000b00418ed58d92fso3851588edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LNiAdfgE3Nl/NVyJMxU8/mXL5a6p2DA33RjxNuB2/iY=;
        b=E77DEqBOHO8wENEJb1O2wykMCr3O/xuDPSh4XI/3o6IHLw42T4PJeTKyV98DctblCb
         6N/UzOHj+PX2Hcp2pWcRZRajhyCCR/4nImu1VrHn0Wgp1Jlzo7lses1PjoNBVZUQaHdr
         6uF2upov8Iowm0wqI3OceIQST5UI7MKW7vjmRnnQWKWveTbuvUfvwDTeZHJIsxY5rQ8t
         mUqLbpmUQRzrnL4SMqIYIAm8PDQ3rcOWPTTyw+Pw/4Wpdh+3QdMST4MCG5QKo/Mmj7Mu
         3hEBeY44PKEO8ufV31F/CmnKbCJyzeuHm6rGTzwnnlq9XeJWVJutDAgmC9EEMsvK4BhR
         Qlfg==
X-Gm-Message-State: AOAM533hAqxBN74GaipM44eF21Er8PgQwuF6rkWhepPF9jTpfSzdxyxB
        g35xjU6GJpNSQ4Kyyl7ElrWPqxqKlIEYP4g/CU8fuYswKE1pbSu7MWSgDAN9WEbxHpeyBLZcPi2
        opk2gHCAo8336LvrsKeUBynjC
X-Received: by 2002:a50:d711:0:b0:410:a51a:77c5 with SMTP id t17-20020a50d711000000b00410a51a77c5mr8403778edi.154.1647593981719;
        Fri, 18 Mar 2022 01:59:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO7mabwLFukZI7CdYqOZ1/S9UWU062HG91YFS95yyYMOXazcxgyJ2b4LUaZpL3mHXOBcMbtA==
X-Received: by 2002:a50:d711:0:b0:410:a51a:77c5 with SMTP id t17-20020a50d711000000b00410a51a77c5mr8403763edi.154.1647593981460;
        Fri, 18 Mar 2022 01:59:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id u23-20020a17090626d700b006cfcd39645fsm3429595ejc.88.2022.03.18.01.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 01:59:40 -0700 (PDT)
Message-ID: <30e7417e-43f3-5858-6663-9280f78e3af1@redhat.com>
Date:   Fri, 18 Mar 2022 09:59:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/4] power: supply: max17042_battery: Add unit conversion
 macros
Content-Language: en-US
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
 <20220318001048.20922-2-sebastian.krzyszkowiak@puri.sm>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220318001048.20922-2-sebastian.krzyszkowiak@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/18/22 01:10, Sebastian Krzyszkowiak wrote:
> Instead of sprinkling the code with magic numbers, put the unit
> definitions used by the gauge into a set of macros. Macros are
> used instead of simple defines in order to not require floating
> point operations for divisions.
> 
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
>  drivers/power/supply/max17042_battery.c | 40 +++++++++++++++----------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index ab031bbfbe78..c019d6c52363 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -51,6 +51,15 @@
>  
>  #define MAX17042_VMAX_TOLERANCE		50 /* 50 mV */
>  
> +#define MAX17042_CURRENT_LSB		1562500ll /* µV */
> +#define MAX17042_CURRENT_RSENSE(x)	(x * MAX17042_CURRENT_LSB) /* µV */
> +#define MAX17042_CAPACITY_LSB		5000000ll /* µVh */
> +#define MAX17042_CAPACITY_RSENSE(x)	(x * MAX17042_CAPACITY_LSB) /* µVh */
> +#define MAX17042_TIME(x)		(x * 5625 / 1000) /* s */
> +#define MAX17042_VOLTAGE(x)		(x * 625 / 8) /* µV */
> +#define MAX17042_RESISTANCE(x)		(x / 4096) /* Ω */
> +#define MAX17042_TEMPERATURE(x)		(x / 256) /* °C */
> +
>  struct max17042_chip {
>  	struct i2c_client *client;
>  	struct regmap *regmap;
> @@ -103,8 +112,7 @@ static int max17042_get_temperature(struct max17042_chip *chip, int *temp)
>  
>  	*temp = sign_extend32(data, 15);
>  	/* The value is converted into deci-centigrade scale */
> -	/* Units of LSB = 1 / 256 degree Celsius */
> -	*temp = *temp * 10 / 256;
> +	*temp = MAX17042_TEMPERATURE(*temp * 10);

Shouldn't the "* 10"  be part of the macro?

Otherwise this looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


>  	return 0;
>  }
>  
> @@ -161,7 +169,7 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
>  		return ret;
>  
>  	avg_current = sign_extend32(data, 15);
> -	avg_current *= 1562500 / chip->pdata->r_sns;
> +	avg_current *= MAX17042_CURRENT_LSB / chip->pdata->r_sns;
>  
>  	if (avg_current > 0)
>  		*status = POWER_SUPPLY_STATUS_CHARGING;
> @@ -181,7 +189,7 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
>  		goto health_error;
>  
>  	/* bits [0-3] unused */
> -	vavg = val * 625 / 8;
> +	vavg = MAX17042_VOLTAGE(val);
>  	/* Convert to millivolts */
>  	vavg /= 1000;
>  
> @@ -190,7 +198,7 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
>  		goto health_error;
>  
>  	/* bits [0-3] unused */
> -	vbatt = val * 625 / 8;
> +	vbatt = MAX17042_VOLTAGE(val);
>  	/* Convert to millivolts */
>  	vbatt /= 1000;
>  
> @@ -297,21 +305,21 @@ static int max17042_get_property(struct power_supply *psy,
>  		if (ret < 0)
>  			return ret;
>  
> -		val->intval = data * 625 / 8;
> +		val->intval = MAX17042_VOLTAGE(data);
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
>  		ret = regmap_read(map, MAX17042_AvgVCELL, &data);
>  		if (ret < 0)
>  			return ret;
>  
> -		val->intval = data * 625 / 8;
> +		val->intval = MAX17042_VOLTAGE(data);
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
>  		ret = regmap_read(map, MAX17042_OCVInternal, &data);
>  		if (ret < 0)
>  			return ret;
>  
> -		val->intval = data * 625 / 8;
> +		val->intval = MAX17042_VOLTAGE(data);
>  		break;
>  	case POWER_SUPPLY_PROP_CAPACITY:
>  		if (chip->pdata->enable_current_sense)
> @@ -328,7 +336,7 @@ static int max17042_get_property(struct power_supply *psy,
>  		if (ret < 0)
>  			return ret;
>  
> -		data64 = data * 5000000ll;
> +		data64 = MAX17042_CAPACITY_RSENSE(data);
>  		do_div(data64, chip->pdata->r_sns);
>  		val->intval = data64;
>  		break;
> @@ -337,7 +345,7 @@ static int max17042_get_property(struct power_supply *psy,
>  		if (ret < 0)
>  			return ret;
>  
> -		data64 = data * 5000000ll;
> +		data64 = MAX17042_CAPACITY_RSENSE(data);
>  		do_div(data64, chip->pdata->r_sns);
>  		val->intval = data64;
>  		break;
> @@ -346,7 +354,7 @@ static int max17042_get_property(struct power_supply *psy,
>  		if (ret < 0)
>  			return ret;
>  
> -		data64 = data * 5000000ll;
> +		data64 = MAX17042_CAPACITY_RSENSE(data);
>  		do_div(data64, chip->pdata->r_sns);
>  		val->intval = data64;
>  		break;
> @@ -355,7 +363,7 @@ static int max17042_get_property(struct power_supply *psy,
>  		if (ret < 0)
>  			return ret;
>  
> -		data64 = sign_extend64(data, 15) * 5000000ll;
> +		data64 = MAX17042_CAPACITY_RSENSE(sign_extend64(data, 15));
>  		val->intval = div_s64(data64, chip->pdata->r_sns);
>  		break;
>  	case POWER_SUPPLY_PROP_TEMP:
> @@ -397,7 +405,7 @@ static int max17042_get_property(struct power_supply *psy,
>  			if (ret < 0)
>  				return ret;
>  
> -			data64 = sign_extend64(data, 15) * 1562500ll;
> +			data64 = MAX17042_CURRENT_RSENSE(sign_extend64(data, 15));
>  			val->intval = div_s64(data64, chip->pdata->r_sns);
>  		} else {
>  			return -EINVAL;
> @@ -409,7 +417,7 @@ static int max17042_get_property(struct power_supply *psy,
>  			if (ret < 0)
>  				return ret;
>  
> -			data64 = sign_extend64(data, 15) * 1562500ll;
> +			data64 = MAX17042_CURRENT_RSENSE(sign_extend64(data, 15));
>  			val->intval = div_s64(data64, chip->pdata->r_sns);
>  		} else {
>  			return -EINVAL;
> @@ -420,7 +428,7 @@ static int max17042_get_property(struct power_supply *psy,
>  		if (ret < 0)
>  			return ret;
>  
> -		data64 = data * 1562500ll;
> +		data64 = MAX17042_CURRENT_RSENSE(data);
>  		val->intval = div_s64(data64, chip->pdata->r_sns);
>  		break;
>  	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
> @@ -428,7 +436,7 @@ static int max17042_get_property(struct power_supply *psy,
>  		if (ret < 0)
>  			return ret;
>  
> -		val->intval = data * 5625 / 1000;
> +		val->intval = MAX17042_TIME(data);
>  		break;
>  	default:
>  		return -EINVAL;

