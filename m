Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0534AC8E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbiBGSxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbiBGSvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:51:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7B14C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644259874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4tMxQxcJ5rizEoS5UTJCaiSckKkfeW6Chcez0Web9VY=;
        b=el7LP5E3u2JxKzZW0POVD9LtNxLgSrAQqrr7tkwZU3Q+6NAD9pNZIJUVie3ucLlFuezSGq
        pb1h94HcG/LLOiiseFShecu6c7tK00NFEe92NR9RfM22evQNzVuCNK9t4M+Em8nUpE7JTi
        pM7IKnPWKsG3R0caUdXwKHWOz6Lmv+U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-4Snjwa9IPnyGDtBDoA5hhg-1; Mon, 07 Feb 2022 13:51:12 -0500
X-MC-Unique: 4Snjwa9IPnyGDtBDoA5hhg-1
Received: by mail-ed1-f69.google.com with SMTP id w15-20020a056402268f00b00408234dc1dfso8328670edd.16
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 10:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4tMxQxcJ5rizEoS5UTJCaiSckKkfeW6Chcez0Web9VY=;
        b=Xp2zRdDPcIsUTuJ1JLZQxqQCDCnphQxweBgB05SS8FyQT7Yt8pNe2SIvjI6WAZviz8
         4/tEiU6oyqmWDUMe+c3MS58oVtnktYJiLuX1tjDA1d5D+1omlszs9lH9ZRP8r8XHYUYG
         X1M59PGeOU1N5O3Xb4Ew3q0bfSmMWrFyGXSzZa8yAPtc0TQZj0+E6n4l8fG2eo+kK6Mw
         5khpSY5LTDduMjwJGTg59jnxd81Y7OOgoZEauIUJLIGJ3sz/Q2jrVoH93uTEwRVcKeSr
         wEDVVcsSdOrF3LKnHv2tLanBykUEcEMCWN9FKgpUIzHUgzENEbWdby9TV7pKy5FAfIBw
         616g==
X-Gm-Message-State: AOAM531+MSYjWjE0zuMeuuT9WAYmivbF2e1snfqr+WPqv/guUUYMXts4
        YRZXVXNap/23d5hB4LqmTYXAFHxZ0Lfle4wsoz7B0tE76ZncQrX1v2s37y7M15lfIoZSHQ5LT+5
        qzwq2m62XVxPy7Q014MHKP/0s
X-Received: by 2002:a17:906:2ed1:: with SMTP id s17mr869863eji.174.1644259871583;
        Mon, 07 Feb 2022 10:51:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZg/imwISIvk/tGi32MzWQSLQ+HCYDyUuOQuH46m+YuILwYJ63JRBI8JsIMyKkYrAEhfiE3w==
X-Received: by 2002:a17:906:2ed1:: with SMTP id s17mr869857eji.174.1644259871386;
        Mon, 07 Feb 2022 10:51:11 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id b17sm2491962ejd.34.2022.02.07.10.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 10:51:10 -0800 (PST)
Message-ID: <43bfd6d9-58a3-6f9c-0848-4ef147552afb@redhat.com>
Date:   Mon, 7 Feb 2022 19:51:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] x86/Kconfig: move and modify CONFIG_I8K
Content-Language: en-US
To:     =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Gross <markgross@kernel.org>
References: <20220207182940.242838-1-mat.jonczyk@o2.pl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220207182940.242838-1-mat.jonczyk@o2.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/7/22 19:29, Mateusz Jończyk wrote:
> In Kconfig, inside the "Processor type and features" menu, there is
> the CONFIG_I8K option: "Dell i8k legacy laptop support". This is
> very confusing - enabling CONFIG_I8K is not required for the kernel to
> support old Dell laptops. This option is specific to the dell-smm-hwmon
> driver, which mostly exports some hardware monitoring information and
> allows the user to change fan speed.
> 
> This option is misplaced, so move CONFIG_I8K to drivers/hwmon/Kconfig,
> where it belongs.
> 
> Also, modify the dependency order - change
>         select SENSORS_DELL_SMM
> to
>         depends on SENSORS_DELL_SMM
> as it is just a configuration option of dell-smm-hwmon. This includes
> changing the option type from tristate to bool. It was tristate because
> it could select CONFIG_SENSORS_DELL_SMM=m .
> 
> When running "make oldconfig" on configurations with
> CONFIG_SENSORS_DELL_SMM enabled , this change will result in an
> additional question (which could be printed several times during
> bisecting). I think that tidying up the configuration is worth it,
> though.
> 
> Next patch tweaks the description of CONFIG_I8K.
> 
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>

For other reviewers, the only consumer of the CONFIG_I8K
option is drivers/hwmon/dell-smm-hwmon.c
which has a couple of:
"#if IS_ENABLED(CONFIG_I8K)" checks to enable its old
legacy /proc/i8k interface.

So this move definitely makes sense.

I wonder if it would not be better to just completely drop
the old  /proc/i8k interface though ?

With that said, this series looks good to me, so:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans




> ---
>  arch/x86/Kconfig      | 17 -----------------
>  drivers/hwmon/Kconfig | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9f5bd41bf660..71d4ddd48c02 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1275,23 +1275,6 @@ config TOSHIBA
>  	  Say Y if you intend to run this kernel on a Toshiba portable.
>  	  Say N otherwise.
>  
> -config I8K
> -	tristate "Dell i8k legacy laptop support"
> -	depends on HWMON
> -	depends on PROC_FS
> -	select SENSORS_DELL_SMM
> -	help
> -	  This option enables legacy /proc/i8k userspace interface in hwmon
> -	  dell-smm-hwmon driver. Character file /proc/i8k reports bios version,
> -	  temperature and allows controlling fan speeds of Dell laptops via
> -	  System Management Mode. For old Dell laptops (like Dell Inspiron 8000)
> -	  it reports also power and hotkey status. For fan speed control is
> -	  needed userspace package i8kutils.
> -
> -	  Say Y if you intend to run this kernel on old Dell laptops or want to
> -	  use userspace package i8kutils.
> -	  Say N otherwise.
> -
>  config X86_REBOOTFIXUPS
>  	bool "Enable X86 board specific fixups for reboot"
>  	depends on X86_32
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 8df25f1079ba..dd244aa747ad 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -505,6 +505,21 @@ config SENSORS_DELL_SMM
>  	  When option I8K is also enabled this driver provides legacy /proc/i8k
>  	  userspace interface for i8kutils package.
>  
> +config I8K
> +	bool "Dell i8k legacy laptop support"
> +	depends on SENSORS_DELL_SMM
> +	help
> +	  This option enables legacy /proc/i8k userspace interface in hwmon
> +	  dell-smm-hwmon driver. Character file /proc/i8k reports bios version,
> +	  temperature and allows controlling fan speeds of Dell laptops via
> +	  System Management Mode. For old Dell laptops (like Dell Inspiron 8000)
> +	  it reports also power and hotkey status. For fan speed control is
> +	  needed userspace package i8kutils.
> +
> +	  Say Y if you intend to run this kernel on old Dell laptops or want to
> +	  use userspace package i8kutils.
> +	  Say N otherwise.
> +
>  config SENSORS_DA9052_ADC
>  	tristate "Dialog DA9052/DA9053 ADC"
>  	depends on PMIC_DA9052
> 

