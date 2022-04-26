Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A51510A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354941AbiDZUYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355109AbiDZUYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:24:00 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E811A05A;
        Tue, 26 Apr 2022 13:20:51 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-e93bbb54f9so7901965fac.12;
        Tue, 26 Apr 2022 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OSp7CuCzaWiyWxsSe0X5/jwsdoSOSKAISq8bfC5hTHI=;
        b=IYAt8ec8J3n6GhJ79MHaapsVcr37e/1YT+fLtXiBSZTRLlKkZ4LJdCVHVc3R0Tz6cP
         MBXqFpWY5kgMOhVhe2phh7KhoLAL8dPwW9u7tzceN42LSE3wSh2D1bAQF2CQC8QvwJB+
         3RCGDA6XjuNI0jQOCpori9d+k/bvg6qZf+bTWOoedfh5J31KIgxQbvBdjx33OQ44RkPc
         vxMjLVjscJ3swy5zeoqDaFTfvbeNIcyI+EMYt6shBbwCSxtGlKAlb58adAXXuW1MGqgn
         xKSdBqIi9wsuLdOcWIbdkVcsX843chzahy9dP4s8sPXQF89NG65LqQ13+VXeYdzpyzE+
         XNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OSp7CuCzaWiyWxsSe0X5/jwsdoSOSKAISq8bfC5hTHI=;
        b=szkJIiTJr6SLoK+t8bjFLXLnvirbFJ/8mZZpbQhYQtHGg9menw82esNvcKyTwNQNDe
         l/6xeJTVzvFZztpwJ54ZmQszs+7sXwlElQYAwCxccrf47IxwOGmQaAVGu76Bq9K3QIhF
         BJ9Pb3P2KScNKAUzD/i+lj5xtxZ18/hsaRvjx2qxwL0N/DhmlYFecKMMz7K1aJgrWXME
         SKJYF/3t84f3yxcAZb01fU0IXIPCqtsHomvkLrO6X3x+pKt31Wjpaycbl9gu44le32A4
         76nUsPmjqjb8zeJ77q8sNlly5fHxQlLs7FDy3ZQ87baoJE5Hqk8GVBY4MTqfvUuUwD1n
         Wocw==
X-Gm-Message-State: AOAM530SE65cwgxD3JF+CsA2I2GIP7xblfgwz9A4AH2aKJMb+6ykszEw
        c5akfK/QOgRg9WvPOpdyS6sfWfxV2vE=
X-Google-Smtp-Source: ABdhPJzp8LfFAaVTar+PL4DQy9wtSK3NjFTNXyRloFbcY7IL5JoYELytIY8sxJ0f8oy+X+CkNp7n5g==
X-Received: by 2002:a05:6870:580e:b0:e2:7e06:e785 with SMTP id r14-20020a056870580e00b000e27e06e785mr10572106oap.38.1651004450904;
        Tue, 26 Apr 2022 13:20:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n21-20020a9d4d15000000b00603fb46ddcbsm5202722otf.65.2022.04.26.13.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:20:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Apr 2022 13:20:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (dell-smm) Avoid unnecessary SMM calls during
 init
Message-ID: <20220426202048.GO4093517@roeck-us.net>
References: <20220426200320.399435-1-W_Armin@gmx.de>
 <20220426200320.399435-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426200320.399435-2-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:03:18PM +0200, Armin Wolf wrote:
> When the driver tries to detect the fan multiplier during
> module initialisation, it issues one SMM call for each fan.
> Those SMM calls are however redundant and also try to query
> fans which may not be present.
> Fix that by detecting the fan multiplier during hwmon
> initialisation when no extra SMM calls are needed.
> Also dont assume the last nominal speed entry to be the
> biggest and instead check all entries.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 37 +++++++++++++---------------------
>  1 file changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 30b6f0c28093..202ee884de9e 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -50,7 +50,7 @@
>  #define I8K_SMM_GET_DELL_SIG2	0xffa3
> 
>  #define I8K_FAN_MULT		30
> -#define I8K_FAN_MAX_RPM		30000
> +#define I8K_FAN_RPM_THRESHOLD	1000
>  #define I8K_MAX_TEMP		127
> 
>  #define I8K_FN_NONE		0x00
> @@ -326,7 +326,7 @@ static int __init i8k_get_fan_nominal_speed(const struct dell_smm_data *data, u8
>  	if (data->disallow_fan_support)
>  		return -EINVAL;
> 
> -	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * data->i8k_fan_mult;
> +	return i8k_smm(&regs) ? : (regs.eax & 0xffff);
>  }
> 
>  /*
> @@ -776,6 +776,7 @@ static int dell_smm_read(struct device *dev, enum hwmon_sensor_types type, u32 a
>  			 long *val)
>  {
>  	struct dell_smm_data *data = dev_get_drvdata(dev);
> +	int mult = data->i8k_fan_mult;
>  	int ret;
> 
>  	switch (type) {
> @@ -804,11 +805,11 @@ static int dell_smm_read(struct device *dev, enum hwmon_sensor_types type, u32 a
> 
>  			return 0;
>  		case hwmon_fan_min:
> -			*val = data->fan_nominal_speed[channel][0];
> +			*val = data->fan_nominal_speed[channel][0] * mult;
> 
>  			return 0;
>  		case hwmon_fan_max:
> -			*val = data->fan_nominal_speed[channel][data->i8k_fan_max];
> +			*val = data->fan_nominal_speed[channel][data->i8k_fan_max] * mult;
> 
>  			return 0;
>  		case hwmon_fan_target:
> @@ -819,7 +820,7 @@ static int dell_smm_read(struct device *dev, enum hwmon_sensor_types type, u32 a
>  			if (ret > data->i8k_fan_max)
>  				ret = data->i8k_fan_max;
> 
> -			*val = data->fan_nominal_speed[channel][ret];
> +			*val = data->fan_nominal_speed[channel][ret] * mult;
> 
>  			return 0;
>  		default:
> @@ -1071,6 +1072,13 @@ static int __init dell_smm_init_hwmon(struct device *dev)
>  				break;
>  			}
>  			data->fan_nominal_speed[i][state] = err;
> +			/*
> +			 * Autodetect fan multiplier based on nominal rpm if multiplier
> +			 * was not specified as module param or in DMI. If fan reports
> +			 * rpm value too high then set multiplier to 1.
> +			 */
> +			if (!fan_mult && err > I8K_FAN_RPM_THRESHOLD)
> +				data->i8k_fan_mult = 1;
>  		}
>  	}
> 
> @@ -1359,7 +1367,6 @@ static int __init dell_smm_probe(struct platform_device *pdev)
>  	struct dell_smm_data *data;
>  	const struct dmi_system_id *id, *fan_control;
>  	int ret;
> -	u8 fan;
> 
>  	data = devm_kzalloc(&pdev->dev, sizeof(struct dell_smm_data), GFP_KERNEL);
>  	if (!data)
> @@ -1414,24 +1421,8 @@ static int __init dell_smm_probe(struct platform_device *pdev)
>  		dev_info(&pdev->dev, "enabling support for setting automatic/manual fan control\n");
>  	}
> 
> -	if (!fan_mult) {
> -		/*
> -		 * Autodetect fan multiplier based on nominal rpm
> -		 * If fan reports rpm value too high then set multiplier to 1
> -		 */
> -		for (fan = 0; fan < DELL_SMM_NO_FANS; ++fan) {
> -			ret = i8k_get_fan_nominal_speed(data, fan, data->i8k_fan_max);
> -			if (ret < 0)
> -				continue;
> -
> -			if (ret > I8K_FAN_MAX_RPM)
> -				data->i8k_fan_mult = 1;
> -			break;
> -		}
> -	} else {
> -		/* Fan multiplier was specified in module param or in dmi */
> +	if (fan_mult)

Might as well drop the if statement here.

>  		data->i8k_fan_mult = fan_mult;
> -	}
> 
>  	ret = dell_smm_init_hwmon(&pdev->dev);
>  	if (ret)
> --
> 2.30.2
> 
