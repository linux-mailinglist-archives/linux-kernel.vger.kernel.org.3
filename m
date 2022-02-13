Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECCC4B3C0A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 16:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbiBMP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 10:28:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiBMP2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 10:28:16 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858515D645;
        Sun, 13 Feb 2022 07:28:09 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so16538248ooi.2;
        Sun, 13 Feb 2022 07:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6aCjQbPB/NFLPju2mWWwFjBHH6//tqesN/M2C2qyHLI=;
        b=WT55gHoK2vkRQasLoyPgIMKw8AxAdTqaMvAvNhfU7dhu+EP+JLiBJZWXN+umLn6Pzf
         1VbzgxYViebVGkC2zX6nA082IggWAe4HSwpIsj1oF2LtdFGMBwoSgyER22tlgRYQyjT2
         DdkBwhtMV2UHh7g9qDeFmdu3ux/z58BQ+GSm18E68W3+8QyCYe8sw04t2SHV8lYOTJb9
         ap2gtAzotGqC0nsSkV29nDyKi17GDnzph0g3HKhRt0YGSQf0IWRNMrTCFHAE7XooJj4m
         Lk10Rgec4/jX2hK9o24L7IAHSqU+hrBXe5hr2Vm4TbPygEGc5Yi7cZ+AvFaF4SrZD3LI
         J29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=6aCjQbPB/NFLPju2mWWwFjBHH6//tqesN/M2C2qyHLI=;
        b=Ykj/+da7nVvkr4WBWTYjATssp183Hkdr266VKY+tZe5cmOWX3t7YHWjjducKOMuFlM
         y1tcaU0T8NsI7ApwrUlm5qD/wgOMMGBCl/NiXZHZVXwinyQuuJKfcdaKzApSXGaz/lt7
         61X+JG9o15CHOfYMmfotxMBqifHCJsdQfMNu9Ry+KFeUah+XxzHnmLl1UPSAJ+leY8Te
         w223nFHO8OatFFnJSqamZQJo3oLX140vkbIQw3aTG7tTieme5VWOQDQbTQ692E08St6W
         orAk+7McUuwEhNL+kIsbmLI6VsTOzfqgeaz6jPRGgzhsZWKud6i6kX02O+nZtRaxjggB
         cJyw==
X-Gm-Message-State: AOAM5326t9lYD+CxXcPbBiimF+nCDq2OZD8tNsqkfcQwG9iDw3cscjfB
        2WPYtbYeB74dy23pDQdaxXZY2JLHkQQ1Tw==
X-Google-Smtp-Source: ABdhPJxosmE0I2lRVAB02ky13GVj+ULBRYH9kW+YwLuAky/mU4oJWjTwqovp5vh7Ja04S1j/hMmf7g==
X-Received: by 2002:a05:6870:1487:: with SMTP id k7mr2778775oab.308.1644766089318;
        Sun, 13 Feb 2022 07:28:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j2sm9550549ooj.2.2022.02.13.07.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 07:28:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 13 Feb 2022 07:28:07 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, x86@kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/2] dell-smm-hwmon: rewrite CONFIG_I8K description
Message-ID: <20220213152807.GA4073956@roeck-us.net>
References: <20220212125654.357408-1-mat.jonczyk@o2.pl>
 <20220212125654.357408-2-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220212125654.357408-2-mat.jonczyk@o2.pl>
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

On Sat, Feb 12, 2022 at 01:56:54PM +0100, Mateusz Jończyk wrote:
> It is not the laptops, but the /proc/i8k interface that is legacy (or so
> I think was the intention of the help text author). The old description
> was confusing, fix this.
> 
> The phrase "Say Y if you intend to run this kernel on old Dell laptops
> or want to use userspace package i8kutils." was introduced in 2015, in
> commit 039ae58503f3 ("hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k")
> 
> I think that "old laptops" was about hotkey and Fn key support - this
> driver in the 2.4 kernels' era apparently had these capabilities
> (see: https://github.com/vitorafsr/i8kutils , description of
> "repeat_rate" kernel module parameter).
> 
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Mark Gross <markgross@kernel.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> v2:
>   - help text language fixes (thanks: Randy Dunlap),
>   - modify commit description.
> ---
>  drivers/hwmon/Kconfig | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 1ee4e5eff567..39aeecc72800 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -506,19 +506,18 @@ config SENSORS_DELL_SMM
>  	  userspace interface for i8kutils package.
>  
>  config I8K
> -	bool "Dell i8k legacy laptop support"
> +	bool "Legacy /proc/i8k interface of Dell laptop SMM BIOS hwmon driver"
>  	depends on SENSORS_DELL_SMM
>  	depends on PROC_FS
>  	help
> -	  This option enables legacy /proc/i8k userspace interface in hwmon
> -	  dell-smm-hwmon driver. Character file /proc/i8k reports bios version,
> -	  temperature and allows controlling fan speeds of Dell laptops via
> -	  System Management Mode. For old Dell laptops (like Dell Inspiron 8000)
> -	  it reports also power and hotkey status. For fan speed control is
> -	  needed userspace package i8kutils.
> +	  This option enables the legacy /proc/i8k userspace interface of the
> +	  dell-smm-hwmon driver. The character file /proc/i8k exposes the BIOS
> +	  version, temperatures and allows control of fan speeds of some Dell
> +	  laptops. Sometimes it also reports power and hotkey status.
>  
> -	  Say Y if you intend to run this kernel on old Dell laptops or want to
> -	  use userspace package i8kutils.
> +	  This interface is required to run programs from the i8kutils package.
> +
> +	  Say Y if you intend to run userspace programs that use this interface.
>  	  Say N otherwise.
>  
>  config SENSORS_DA9052_ADC
