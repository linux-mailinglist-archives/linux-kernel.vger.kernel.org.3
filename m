Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE14C3B71
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbiBYCJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbiBYCJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:09:46 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8601D6F5C;
        Thu, 24 Feb 2022 18:09:15 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id z7so5903858oid.4;
        Thu, 24 Feb 2022 18:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TlS/mHPQltts63hV34cgOLWKISJN15OAtTEuH9GiHLM=;
        b=S+0rNPaebeZxOkhFMPFvDP5qZGvP9Wq7kRqawaCJQBHCFSPQRhqezV3s1tW7ZwbLU6
         PBT+GeZw9mSSh6WhVbGKVH+pxWHo+/bI3grPB8EEspsnl0s3dZTCwzywzjfTqkyU7ecQ
         xhg3jishbE89aC7a/5XodYObERKETvHJrUZXuCV7PPFQOr/cYeMbxzb6f90pwnnbbKan
         KrYRPaCtacLjvov2eTrY7Yev68zjwuEDAkwE18sgfPlPZgLKNWzC7U3Pmw4JR+1KMUSz
         tMkaOov2LO08EAASOptn4iwMaa3f/4w9A3YeC2yGICzGbpQIOCJLc+cARtHAk1cZineA
         FjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TlS/mHPQltts63hV34cgOLWKISJN15OAtTEuH9GiHLM=;
        b=BctVzVE5UuiSqAsM7BpWw7e8M9pJJpze7iJOwfftC1KnYO7ojCNFWD8XKQEfVoSBO7
         2OrWMjYHsIer1R41D5b3hUhYWKguYBluo9hYOVT7TKs0KWLwYwV26PYC3I1b+jEXjGYS
         Xo0zTg7RFEuhQKCE4Zy98eyfd43dvI8ACMhWAYLJWLMtTiHK1WPUASqEaimuruBrQmQo
         Eyb2QMExI3l716J0E5/hcjDNMFu1J0Tv41eOmJ/YWZJbE3IOlNaer+YaBEtRiBVrQ6LY
         tXoPr1Ov59CGXoGd3lB5+liZFnsHuyzzUvqsdgZHzODsKkiUdzjwjiK/0MXI6TotUL5W
         y+sw==
X-Gm-Message-State: AOAM532LedBoZGxcbWYew5PtPK4GIreLLsyMJTQrdF/+IyQmsMtNOgAA
        3YCTTwakhpjgvlYfX5OUCH4=
X-Google-Smtp-Source: ABdhPJyHiRzRmRckKRBX/CtYeIwh5f4lEBJBmfHd/7r897QWwvRQXyHYqTOVxq4RNNK9Uxsc2YcCfg==
X-Received: by 2002:a05:6808:1647:b0:2d7:3d46:dbe3 with SMTP id az7-20020a056808164700b002d73d46dbe3mr485922oib.253.1645754955076;
        Thu, 24 Feb 2022 18:09:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm467269oou.10.2022.02.24.18.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 18:09:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 24 Feb 2022 18:09:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (core) Add support for pwm auto channels
 attribute
Message-ID: <20220225020913.GA1976093@roeck-us.net>
References: <20220224061210.16452-1-W_Armin@gmx.de>
 <20220224061210.16452-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224061210.16452-2-W_Armin@gmx.de>
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

On Thu, Feb 24, 2022 at 07:12:09AM +0100, Armin Wolf wrote:
> pwm[1-*]_auto_channels_temp is documented as an official
> hwmon sysfs attribute, yet there is no support for it in
> the new with_info-API. Fix that.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/hwmon.c | 1 +
>  include/linux/hwmon.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 0d6c6809f26c..989e2c8496dd 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -604,6 +604,7 @@ static const char * const hwmon_pwm_attr_templates[] = {
>  	[hwmon_pwm_enable] = "pwm%d_enable",
>  	[hwmon_pwm_mode] = "pwm%d_mode",
>  	[hwmon_pwm_freq] = "pwm%d_freq",
> +	[hwmon_pwm_auto_channels_temp] = "pwm%d_auto_channels_temp",
>  };
> 
>  static const char * const hwmon_intrusion_attr_templates[] = {
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index fad1f1df26df..eba380b76d15 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -332,12 +332,14 @@ enum hwmon_pwm_attributes {
>  	hwmon_pwm_enable,
>  	hwmon_pwm_mode,
>  	hwmon_pwm_freq,
> +	hwmon_pwm_auto_channels_temp,
>  };
> 
>  #define HWMON_PWM_INPUT			BIT(hwmon_pwm_input)
>  #define HWMON_PWM_ENABLE		BIT(hwmon_pwm_enable)
>  #define HWMON_PWM_MODE			BIT(hwmon_pwm_mode)
>  #define HWMON_PWM_FREQ			BIT(hwmon_pwm_freq)
> +#define HWMON_PWM_AUTO_CHANNELS_TEMP	BIT(hwmon_pwm_auto_channels_temp)
> 
>  enum hwmon_intrusion_attributes {
>  	hwmon_intrusion_alarm,
