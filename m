Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217E94AAAC5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380845AbiBESBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiBESBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:01:23 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A54C061348;
        Sat,  5 Feb 2022 10:01:23 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so8652159oor.12;
        Sat, 05 Feb 2022 10:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=djNPI0HvtcQshL64xPmHnLoLmFRJupwTpUAudKw6Jus=;
        b=LWsNXXHiyz47nl8AQBwGGtlDbK4/YIQZeB8kCa5hShGiKRiXkGmFn1iS6GJuA3FKv6
         U6T0ogReWFN21rzHEZ8vhIo72Uph2J/jFK9r/rXDoEf79tVV/1Igqj0c6wtsxz4MgAs1
         RZwTh3K5s6OBlTHxm8uQStqyfrw43d9T0WuAnjmdR2QlH+HbTYzJb06t5CHuoYu8hRk7
         pkjW3OnKB1SxmO9XMiqO2Q0fzdIZvf2kQy1FbSUtXBg8FMPvIWvWeRn4LIsiuo6bvGe6
         EgJJ8Sys8sqY0rsEAkirPXXeLaG36zSlbTceqL2yyR8amxSk60JveUd2xemnVOBtVuRG
         1ZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=djNPI0HvtcQshL64xPmHnLoLmFRJupwTpUAudKw6Jus=;
        b=bPmp+UfxdVdU/KFiLbpVD7KaNTO3jtTA1pWfs5YVonfc8GV6xIDRJukmXPCuUbQKaC
         8Ypx/TuAjHHgvmsDKR3Z3ynPqOzedNOpheelz6wv2Qp8L+lKln71PxlCOFVnGVSpKnPi
         l6cfd7L3IuEi1n/ckayHbqJpbcLocEVLPsAKnKEV8X0Z8ihss3csYzloIwQMMtQKXCey
         9CnAmfJZJecqXEZ9TY05oCf/LtSPBZx/ghlavLJEvnOQxV3TZ/xey4gQj9IETd9IC4wI
         +IBPM8Yx9lhjNLU4iEvqAemVQqfRe+Gyq5gxQXxgS5eePk86miLk4V4pcWiZ9qqvqnRG
         irhg==
X-Gm-Message-State: AOAM531DzeLTrp3yzhG147+jDB5IW1AYZoG3sqY49ikON+o3vz0/sdWd
        UKbkjFdCtQAJGgsA20vRAr0=
X-Google-Smtp-Source: ABdhPJz8p5uFUzGGj9S5zcl/aO4xXKWasyhZD0zNxp1MvZX7T8QH2d9uykAalEgB6cPFKKKcks/FYg==
X-Received: by 2002:a05:6870:ee12:: with SMTP id ga18mr452208oab.233.1644084082549;
        Sat, 05 Feb 2022 10:01:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x17sm2025545oop.1.2022.02.05.10.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 10:01:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 5 Feb 2022 10:01:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) read sensors as signed ints
Message-ID: <20220205180120.GA3076528@roeck-us.net>
References: <20220204163045.576903-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204163045.576903-1-eugene.shalygin@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 05:30:45PM +0100, Eugene Shalygin wrote:
> Temperature sensor readings are signed, which is hinted by their blank
> value (oxd8, 216 as unsigned and -40 as signed). T_Sensor, Crosshair
> VIII Hero, and a freezer were used to confirm that.
> 
> Here we read fan sensors as signed too, because with their typical
> values and 2-byte width, I can't tell a difference between signed and
> unsigned, as I don't have a high speed chipset fan.
> 
Hmm, I hope we won't get a situation where an unsigned is reported
and needed, but I guess we can deal with that if/when it happens.

> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/asus-ec-sensors.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 05244209c0c6..8a04c76527a4 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -221,7 +221,7 @@ static const struct dmi_system_id asus_ec_dmi_table[] __initconst = {
>  
>  struct ec_sensor {
>  	unsigned int info_index;
> -	u32 cached_value;
> +	s32 cached_value;
>  };
>  
>  struct ec_sensors_data {
> @@ -408,15 +408,15 @@ static int asus_ec_block_read(const struct device *dev,
>  	return status;
>  }
>  
> -static inline u32 get_sensor_value(const struct ec_sensor_info *si, u8 *data)
> +static inline s32 get_sensor_value(const struct ec_sensor_info *si, u8 *data)
>  {
>  	switch (si->addr.components.size) {
>  	case 1:
> -		return *data;
> +		return (s8)*data;
>  	case 2:
> -		return get_unaligned_be16(data);
> +		return (s16)get_unaligned_be16(data);
>  	case 4:
> -		return get_unaligned_be32(data);
> +		return (s32)get_unaligned_be32(data);
>  	default:
>  		return 0;
>  	}
> @@ -462,7 +462,7 @@ static int update_ec_sensors(const struct device *dev,
>  	return status;
>  }
>  
> -static int scale_sensor_value(u32 value, int data_type)
> +static long scale_sensor_value(s32 value, int data_type)
>  {
>  	switch (data_type) {
>  	case hwmon_curr:
> @@ -476,7 +476,7 @@ static int scale_sensor_value(u32 value, int data_type)
>  
>  static int get_cached_value_or_update(const struct device *dev,
>  				      int sensor_index,
> -				      struct ec_sensors_data *state, u32 *value)
> +				      struct ec_sensors_data *state, s32 *value)
>  {
>  	if (time_after(jiffies, state->last_updated + HZ)) {
>  		if (update_ec_sensors(dev, state)) {
> @@ -499,7 +499,7 @@ static int asus_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  			      u32 attr, int channel, long *val)
>  {
>  	int ret;
> -	u32 value = 0;
> +	s32 value = 0;
>  
>  	struct ec_sensors_data *state = dev_get_drvdata(dev);
>  	int sidx = find_ec_sensor_index(state, type, channel);
