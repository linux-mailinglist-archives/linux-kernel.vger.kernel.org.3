Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9243657EF6C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbiGWORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWORi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:17:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C04F2C3;
        Sat, 23 Jul 2022 07:17:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e132so6599313pgc.5;
        Sat, 23 Jul 2022 07:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iy3Y3lD3PO74W8Het/zkyRyD8CcEacldwVGPN3h0yJs=;
        b=ZxXKz/F4T1if8NpcwsPo+6cBfgUkiyEfQPafk7ppyjuI3vBmFW4zKf3A8mJct2DDUR
         u1jeZLxE2TPZPreuFIWaeS+cJ6uNBO0QNecKVzpoWBgTyuiGokCFzguv8+Ye6DoNsqph
         b7Ca1XkjvIqdm3QM2q851K06D8zhpy4gsVZh9BotXcsUBrWh0V6WTVq/J6Ol9pnI2y39
         aR5zl7xA9d1+ESyHdIxO5VNQotkvjll38mG1390iXlW0DSgrjVNd16yeXb3+Ot8GRTr3
         gWtzUpj7halua5Qdj/5uCp+4c2Gn0q0i8GTcVyqHsh8SVBSQNyXju0RU0d2gEmBvEswy
         CnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=iy3Y3lD3PO74W8Het/zkyRyD8CcEacldwVGPN3h0yJs=;
        b=KT0bKt2Ed4a3LqHvYQjXTTB4aTK0bQSQD91AZ7I+CNcE1lylBTTIqy+Ld7VNjynWry
         I1S4xazhK5rWWpk2MNWiGq4Kwt8rHVR/sWjfa2VA+iPOJXqmzmnlsYIT1WowoXFCwWCP
         FkXB9MAVSXittneTt7nebPCVDKVjJZZTBAyCK3J2clMcp/U89Z/XJtF4qTRKT5G2/WmP
         4bvWebTl8LskWcwP7ooVYvm6W3dRGMH1ikC1Lk1Av/WpkcpIRSHKw3L/Sw9Nbnd65IfZ
         JxyHJXksqg2vJy6nUi/egofFs4VH+B0/az4gMr9PnnMolzXO+rLxJBi1mL5H/tNGuIZl
         BWoA==
X-Gm-Message-State: AJIora+dlZTTqyEUduT7jORi1TVOwMUKeHoAEGS/5p6bR6UH1EMoUIx1
        g6wAhbKgBSlWEqa+5p0rchU=
X-Google-Smtp-Source: AGRyM1ujYcP1yJgo+rDWSQwkI1xmC664v7RFo3ceP60DbAGIHHuY64vv8Yl0GaJDqLuvD6dm4WA5kg==
X-Received: by 2002:a05:6a00:1745:b0:52a:f0d3:ae7 with SMTP id j5-20020a056a00174500b0052af0d30ae7mr5066230pfc.72.1658585856394;
        Sat, 23 Jul 2022 07:17:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j13-20020a170903024d00b0016d1b70872asm5818692plh.134.2022.07.23.07.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 07:17:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 23 Jul 2022 07:17:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: Add pwmX_fan_channel attribute
Message-ID: <20220723141734.GC2979894@roeck-us.net>
References: <20220723033820.22612-1-W_Armin@gmx.de>
 <20220723033820.22612-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723033820.22612-2-W_Armin@gmx.de>
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

On Sat, Jul 23, 2022 at 05:38:19AM +0200, Armin Wolf wrote:
> Until now, userspace software needs to guess which
> PWM channel is associated with which fan channel by
> probing each PWM output and watch for fan speed changes.
> This proccess is error-prone and unreliable.
> 
> Some hwmon chips, especially firmware-based ones, already
> know which PWM output is associated with which fan channel.
> 
> Allow such chips to export this knowledge to userspace.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

All of the chips I am aware of have a fixed association from pwm channel
output to fan input. None I am aware of make this association configurable.
I do not see the value of this attribute.

Guenter

> ---
>  Documentation/ABI/testing/sysfs-class-hwmon | 8 ++++++++
>  Documentation/hwmon/sysfs-interface.rst     | 3 +++
>  drivers/hwmon/hwmon.c                       | 1 +
>  include/linux/hwmon.h                       | 2 ++
>  4 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
> index 7271781a23b2..f3d653bcf736 100644
> --- a/Documentation/ABI/testing/sysfs-class-hwmon
> +++ b/Documentation/ABI/testing/sysfs-class-hwmon
> @@ -315,6 +315,14 @@ Description:
> 
>  		RW
> 
> +What:		/sys/class/hwmon/hwmonX/pwmY_fan_channel
> +Description:
> +		Select which fan channel is controlled by this PWM output.
> +
> +		Valid fan channel/PWM output combinations are chip-dependent.
> +
> +		RW
> +
>  What:		/sys/class/hwmon/hwmonX/pwmY_auto_channels_temp
>  Description:
>  		Select which temperature channels affect this PWM output in
> diff --git a/Documentation/hwmon/sysfs-interface.rst b/Documentation/hwmon/sysfs-interface.rst
> index 209626fb2405..17fcec03d3c5 100644
> --- a/Documentation/hwmon/sysfs-interface.rst
> +++ b/Documentation/hwmon/sysfs-interface.rst
> @@ -209,6 +209,9 @@ PWM
>  `pwm[1-*]_freq`
>  		Base PWM frequency in Hz.
> 
> +`pwm[1-*]_fan_channel`
> +                Select which fan channel is controlled by this PWM output.
> +
>  `pwm[1-*]_auto_channels_temp`
>  		Select which temperature channels affect this PWM output in
>  		auto mode.
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 2e2cd79d89eb..8c2d7574c461 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -604,6 +604,7 @@ static const char * const hwmon_pwm_attr_templates[] = {
>  	[hwmon_pwm_enable] = "pwm%d_enable",
>  	[hwmon_pwm_mode] = "pwm%d_mode",
>  	[hwmon_pwm_freq] = "pwm%d_freq",
> +	[hwmon_pwm_fan_channel] = "pwm%d_fan_channel",
>  	[hwmon_pwm_auto_channels_temp] = "pwm%d_auto_channels_temp",
>  };
> 
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index 14325f93c6b2..9d40cc1e520f 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -332,6 +332,7 @@ enum hwmon_pwm_attributes {
>  	hwmon_pwm_enable,
>  	hwmon_pwm_mode,
>  	hwmon_pwm_freq,
> +	hwmon_pwm_fan_channel,
>  	hwmon_pwm_auto_channels_temp,
>  };
> 
> @@ -339,6 +340,7 @@ enum hwmon_pwm_attributes {
>  #define HWMON_PWM_ENABLE		BIT(hwmon_pwm_enable)
>  #define HWMON_PWM_MODE			BIT(hwmon_pwm_mode)
>  #define HWMON_PWM_FREQ			BIT(hwmon_pwm_freq)
> +#define HWMON_PWM_FAN_CHANNEL		BIT(hwmon_pwm_fan_channel)
>  #define HWMON_PWM_AUTO_CHANNELS_TEMP	BIT(hwmon_pwm_auto_channels_temp)
> 
>  enum hwmon_intrusion_attributes {
> --
> 2.30.2
> 
