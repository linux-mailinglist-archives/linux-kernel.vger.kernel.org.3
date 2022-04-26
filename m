Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51F1510A94
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355018AbiDZUgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355034AbiDZUgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:36:46 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1781AAB63;
        Tue, 26 Apr 2022 13:33:28 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e2fa360f6dso20645354fac.2;
        Tue, 26 Apr 2022 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VZ4m53/siNJy3szXTYThcPOYpErMJB0pa/nMP6ZGHk4=;
        b=cixBLl8WkxFLsGtzEnwriihAF1Snv3H0DEFiF30yyvsbVvX3BaQyEkeXtgM/nyizi0
         gykhgLjvfbL3EM2B+gFp0F3lsS85RRk3wDg7bT+LPzl4zudWhSGNVR5e6Z1atWBSkGu/
         L5ZbyiRG7Ob0We2rZCmZJvWzUCAIW0c2ASFr7s8r6asqr+FcGTU8Q/t6X6w+pIDBuiUn
         /5gnK5JcPreXWbThuXvA6fXGBc0GmCZgTalNWS4Yl2L9+6zHvb/vOKK3G6eA8LyBSUWD
         NqbgDYC3m0ZO+l+65u5/J4IrGP+jfAx0PJs18VC/Cj0DK5MXPPzW3ChzT2xYs0NwbtPw
         kvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VZ4m53/siNJy3szXTYThcPOYpErMJB0pa/nMP6ZGHk4=;
        b=auvDg0zrQFJ4ZIaJjBVPZT0/UBz3B3nHqErO1iCT/iFukguXUUXx5yO0sLL6PSXGDy
         nmRZrIupFhlohJF/A1opntQAR7lGf9P0ST2ByFnFE8PXmnphaev9wNb8eVxgG8ZMDWvt
         J3ghWswT3fHbpm0jsvaMICHtlSaaBGupzd7nc4wZcBNvjDCc6Pz7RxDPgfi8Fs6lLgGV
         r2d43hFF1TjPJ4Z/G1JEEZTUhttRV76n9Fcl5oaAnvlNasHACwRYR66Gad1URb9TPLMZ
         G7gfILiG/bWvKXdiEkkPkWkd0dpD7gy8VwB3lIXfW5JnZmHzcS11hioZDOjOkZGEaZ8C
         hLDQ==
X-Gm-Message-State: AOAM533SMq735l06scb4hhTqman89Q9BOsaqmIEf3Z8r6bZNsoAqqrh5
        VvYd2+lAlb3kiQytl0AvFdo=
X-Google-Smtp-Source: ABdhPJyCtcfZ1jSPkur0xtPK8uPf0o8G0+H6j5Ooe/MmqE+1nIUd0FFIDjFF1cTIEkkqrZTFBF+0HA==
X-Received: by 2002:a05:6870:c1cd:b0:e6:757f:9a04 with SMTP id i13-20020a056870c1cd00b000e6757f9a04mr10077260oad.265.1651005208188;
        Tue, 26 Apr 2022 13:33:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k15-20020a4a2a0f000000b0033a34a057c8sm5985507oof.11.2022.04.26.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:33:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Apr 2022 13:33:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (dell-smm) Avoid unnecessary SMM calls during
 init
Message-ID: <20220426203325.GP4093517@roeck-us.net>
References: <20220426200320.399435-1-W_Armin@gmx.de>
 <20220426200320.399435-2-W_Armin@gmx.de>
 <20220426202048.GO4093517@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426202048.GO4093517@roeck-us.net>
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

On Tue, Apr 26, 2022 at 01:20:48PM -0700, Guenter Roeck wrote:
> On Tue, Apr 26, 2022 at 10:03:18PM +0200, Armin Wolf wrote:
> > When the driver tries to detect the fan multiplier during
> > module initialisation, it issues one SMM call for each fan.
> > Those SMM calls are however redundant and also try to query
> > fans which may not be present.
> > Fix that by detecting the fan multiplier during hwmon
> > initialisation when no extra SMM calls are needed.
> > Also dont assume the last nominal speed entry to be the
> > biggest and instead check all entries.
> > 
> > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > ---
> >  drivers/hwmon/dell-smm-hwmon.c | 37 +++++++++++++---------------------
> >  1 file changed, 14 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> > index 30b6f0c28093..202ee884de9e 100644
> > --- a/drivers/hwmon/dell-smm-hwmon.c
> > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > @@ -50,7 +50,7 @@
> >  #define I8K_SMM_GET_DELL_SIG2	0xffa3
> > 
> >  #define I8K_FAN_MULT		30
> > -#define I8K_FAN_MAX_RPM		30000
> > +#define I8K_FAN_RPM_THRESHOLD	1000
> >  #define I8K_MAX_TEMP		127
> > 
> >  #define I8K_FN_NONE		0x00
> > @@ -326,7 +326,7 @@ static int __init i8k_get_fan_nominal_speed(const struct dell_smm_data *data, u8
> >  	if (data->disallow_fan_support)
> >  		return -EINVAL;
> > 
> > -	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * data->i8k_fan_mult;
> > +	return i8k_smm(&regs) ? : (regs.eax & 0xffff);
> >  }
> > 
> >  /*
> > @@ -776,6 +776,7 @@ static int dell_smm_read(struct device *dev, enum hwmon_sensor_types type, u32 a
> >  			 long *val)
> >  {
> >  	struct dell_smm_data *data = dev_get_drvdata(dev);
> > +	int mult = data->i8k_fan_mult;
> >  	int ret;
> > 
> >  	switch (type) {
> > @@ -804,11 +805,11 @@ static int dell_smm_read(struct device *dev, enum hwmon_sensor_types type, u32 a
> > 
> >  			return 0;
> >  		case hwmon_fan_min:
> > -			*val = data->fan_nominal_speed[channel][0];
> > +			*val = data->fan_nominal_speed[channel][0] * mult;
> > 
> >  			return 0;
> >  		case hwmon_fan_max:
> > -			*val = data->fan_nominal_speed[channel][data->i8k_fan_max];
> > +			*val = data->fan_nominal_speed[channel][data->i8k_fan_max] * mult;
> > 
> >  			return 0;
> >  		case hwmon_fan_target:
> > @@ -819,7 +820,7 @@ static int dell_smm_read(struct device *dev, enum hwmon_sensor_types type, u32 a
> >  			if (ret > data->i8k_fan_max)
> >  				ret = data->i8k_fan_max;
> > 
> > -			*val = data->fan_nominal_speed[channel][ret];
> > +			*val = data->fan_nominal_speed[channel][ret] * mult;
> > 
> >  			return 0;
> >  		default:
> > @@ -1071,6 +1072,13 @@ static int __init dell_smm_init_hwmon(struct device *dev)
> >  				break;
> >  			}
> >  			data->fan_nominal_speed[i][state] = err;
> > +			/*
> > +			 * Autodetect fan multiplier based on nominal rpm if multiplier
> > +			 * was not specified as module param or in DMI. If fan reports
> > +			 * rpm value too high then set multiplier to 1.
> > +			 */
> > +			if (!fan_mult && err > I8K_FAN_RPM_THRESHOLD)
> > +				data->i8k_fan_mult = 1;
> >  		}
> >  	}
> > 
> > @@ -1359,7 +1367,6 @@ static int __init dell_smm_probe(struct platform_device *pdev)
> >  	struct dell_smm_data *data;
> >  	const struct dmi_system_id *id, *fan_control;
> >  	int ret;
> > -	u8 fan;
> > 
> >  	data = devm_kzalloc(&pdev->dev, sizeof(struct dell_smm_data), GFP_KERNEL);
> >  	if (!data)
> > @@ -1414,24 +1421,8 @@ static int __init dell_smm_probe(struct platform_device *pdev)
> >  		dev_info(&pdev->dev, "enabling support for setting automatic/manual fan control\n");
> >  	}
> > 
> > -	if (!fan_mult) {
> > -		/*
> > -		 * Autodetect fan multiplier based on nominal rpm
> > -		 * If fan reports rpm value too high then set multiplier to 1
> > -		 */
> > -		for (fan = 0; fan < DELL_SMM_NO_FANS; ++fan) {
> > -			ret = i8k_get_fan_nominal_speed(data, fan, data->i8k_fan_max);
> > -			if (ret < 0)
> > -				continue;
> > -
> > -			if (ret > I8K_FAN_MAX_RPM)
> > -				data->i8k_fan_mult = 1;
> > -			break;
> > -		}
> > -	} else {
> > -		/* Fan multiplier was specified in module param or in dmi */
> > +	if (fan_mult)
> 
> Might as well drop the if statement here.
> 
Never mind, I see that is removed later anyway.

Guenter

> >  		data->i8k_fan_mult = fan_mult;
> > -	}
> > 
> >  	ret = dell_smm_init_hwmon(&pdev->dev);
> >  	if (ret)
> > --
> > 2.30.2
> > 
