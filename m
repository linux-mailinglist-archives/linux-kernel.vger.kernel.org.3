Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E44857EF67
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbiGWOOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiGWOOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:14:42 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF491BEBD;
        Sat, 23 Jul 2022 07:14:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b9so6672651pfp.10;
        Sat, 23 Jul 2022 07:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=52l53PPT/FcIbKnOSvw7Wn9kkbTZs3TIi9sGaC2KmXU=;
        b=LVJSxtGC1re0no2jEAasGsZex+Dd9AqPkS1PdVbJnORPnScc+ryCTnauv3IVMCceJ/
         mmjrhrvVVD99Y2tGgG1vtivn78qD0mJsItDxgCyerBbb99DJJNz9kBGV6YXkGv00ix0/
         JpSf07xF5xzETw2usgmWPyZWNfT6K/0c9agrxIEj3+b9aJldp4C1EYNzLPdle4tN924o
         P65LhH2JsNPAFuciUESICEhEWmKjUItpVyOMWTj7Jd7CcGMxpyC27sc2gJcTUKKy4A1E
         yxEjWO/3lvhCxdE87UoSkIi/8f1bwXsZlH5ADM2UECbQDRUDhxYqa488z8o/yVW5Luut
         oXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=52l53PPT/FcIbKnOSvw7Wn9kkbTZs3TIi9sGaC2KmXU=;
        b=uS0hxt+bOVBGmRAbWMPlxJIvDvDepDLFspGZSI6ar8EzR1xoRBn4c7cZmMAnBbk8My
         b+WK5PPoUdGK+B+JjMalm94vzsphIzaO2AzBcvRF0Xrxe8GiKZYmIYsSnzfSmDAMBNyL
         qMDj1Dvf0tuHuGJk/x+w+uuBZ1amq801HhQY0iuMh9kCzGNOHlZOfM5PYH51nvtZRlQe
         zAVIczVOLyRaKPYj3jd+CFZu2XmTj/eRS/aoEtlYNTiJD6w9mR+Ny1Ca5z56e27qnjzs
         ndN4rRQp1LHwlrQkb19BS0cSUUEURp3sEi2V+SakhtjWqWC354TmSJ1rrYjBaaZG5XDU
         Ku8Q==
X-Gm-Message-State: AJIora9xF8OTuRBs6iS3g1vEzGrSCp8+o0xc9NzvP7zE+AthpXCiX+kk
        NCEB2otCt04MEr10qvYQZH5bzUzKADDr8Q==
X-Google-Smtp-Source: AGRyM1tE+tZST42Mmp7H4HS0/4uyWeIuUuXSze46yoBNP7IKT/g8Un3NXHTzXTEtnvr5LzU0Y9xraQ==
X-Received: by 2002:a65:558f:0:b0:419:57c9:31dd with SMTP id j15-20020a65558f000000b0041957c931ddmr4097662pgs.222.1658585680948;
        Sat, 23 Jul 2022 07:14:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b0016a565f3f34sm5806060plc.168.2022.07.23.07.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 07:14:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 23 Jul 2022 07:14:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (dell-smm) Add support for pwmX_fan_channel
 attribute
Message-ID: <20220723141439.GB2979894@roeck-us.net>
References: <20220723033820.22612-1-W_Armin@gmx.de>
 <20220723033820.22612-3-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723033820.22612-3-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 05:38:20AM +0200, Armin Wolf wrote:
> The SMM interface does not differentiate between fan channels
> and pwm channels, so each pwmX is associated with fanX_*.
> 
> Inform userspace programs of this with the pwmX_fan_channel
> attribute.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  Documentation/hwmon/dell-smm-hwmon.rst |  1 +
>  drivers/hwmon/dell-smm-hwmon.c         | 15 ++++++++++++---
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
> index e5d85e40972c..2b0651c3f7c5 100644
> --- a/Documentation/hwmon/dell-smm-hwmon.rst
> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
> @@ -38,6 +38,7 @@ fan[1-3]_min                    RO      Minimal Fan speed in RPM
>  fan[1-3]_max                    RO      Maximal Fan speed in RPM
>  fan[1-3]_target                 RO      Expected Fan speed in RPM
>  pwm[1-3]                        RW      Control the fan PWM duty-cycle.
> +pwm[1-3]_fan_channel            RO      Hints which PWM is connected to which fan
>  pwm1_enable                     WO      Enable or disable automatic BIOS fan
>                                          control (not supported on all laptops,
>                                          see below for details).
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 7f8d95dd2717..e6bf65d2ffc6 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -713,6 +713,11 @@ static umode_t dell_smm_is_visible(const void *drvdata, enum hwmon_sensor_types
>  			if (data->fan[channel])
>  				return 0644;
> 
> +			break;
> +		case hwmon_pwm_fan_channel:
> +			if (data->fan[channel])
> +				return 0444;
> +
>  			break;
>  		case hwmon_pwm_enable:
>  			if (data->auto_fan)
> @@ -800,6 +805,10 @@ static int dell_smm_read(struct device *dev, enum hwmon_sensor_types type, u32 a
> 
>  			*val = clamp_val(ret * data->i8k_pwm_mult, 0, 255);
> 
> +			return 0;
> +		case hwmon_pwm_fan_channel:
> +			*val = channel + 1;
> +

This effectively just returns the channel number and
thus adds adds zero value.

Guenter

>  			return 0;
>  		default:
>  			break;
> @@ -943,9 +952,9 @@ static const struct hwmon_channel_info *dell_smm_info[] = {
>  			   HWMON_F_TARGET
>  			   ),
>  	HWMON_CHANNEL_INFO(pwm,
> -			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> -			   HWMON_PWM_INPUT,
> -			   HWMON_PWM_INPUT
> +			   HWMON_PWM_INPUT | HWMON_PWM_FAN_CHANNEL | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_FAN_CHANNEL,
> +			   HWMON_PWM_INPUT | HWMON_PWM_FAN_CHANNEL
>  			   ),
>  	NULL
>  };
> --
> 2.30.2
> 
