Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F3158401F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiG1Ngq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiG1NgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 268343AB24
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659015374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwVqeB8CVAxIsoXNrlyLlhsjO6kg3P6+cWogXZRjgas=;
        b=aJl+qe7GBxKm0oETjf9od5Tltlw/y+27QSpvVHn8n06uKDSK/d+jeImSxKCrS+qKXlL+vZ
        gPP2Jp176te5r4iq7WQkcB2ugRTjqaMlr1NMurpKqSTonk1fAjDlr4PfUfrfEFHOyXG3YF
        u4qcqZZUFTU/beoxS5BDOKqHz4yfSVw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-mMI7mb-ROkWqrcre2doKdA-1; Thu, 28 Jul 2022 09:36:12 -0400
X-MC-Unique: mMI7mb-ROkWqrcre2doKdA-1
Received: by mail-ed1-f69.google.com with SMTP id w15-20020a056402268f00b0043be4012ea9so1118112edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vwVqeB8CVAxIsoXNrlyLlhsjO6kg3P6+cWogXZRjgas=;
        b=AeSBhi2/5xTnNx6lxKWmQLCZZpoxyGLtBIV6MUgxJE/blpwsKt7NrLV02MRcU/vuYN
         8qn7xepoxUdhLuqBfapvy9lcQ25FckkgFtwUZGropXawSfJdoGD4ProxpWMIp2+H1yo+
         XP4ExUzrJElf0SljW88+4KDkqPb4T0OIMyNJPaU5KAsSNFw9rc+ZQbWBm13kwK83lt1S
         26ZxgMHFRySYZiP5Wt+WgpEZBE5co/OYCLlyns1Pi0H/kJ2yMCdgFGKevI4tg8eKo1dN
         dl6HrR0N0JVyXc1gncHBmCANgVQtJNujYGC2MYi/EmGni8hhhYjXsazI4/l3Z+09ie6a
         //AA==
X-Gm-Message-State: AJIora8jtnMKoXyAPDqdPy7tnqse+ICE7V5AFGcfgmVQaf7t6MimMUJe
        aD/2rnYq/yte5daQDVArd6RBuUqk795haBRCkmrSrcqbegzwzd5ioo1DujSNTSy6Lab2lpXLekT
        sNIcY4plDnoVRKAYQFcdumb/2
X-Received: by 2002:a17:906:9b86:b0:6fe:d37f:b29d with SMTP id dd6-20020a1709069b8600b006fed37fb29dmr21130846ejc.327.1659015371623;
        Thu, 28 Jul 2022 06:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sfypymdX4DGOjpFNc/J4D7wASEWj7qxsUEP67Fol6y/IVoA9gvde2VL8LBPAR7ca6Rq2Gj7Q==
X-Received: by 2002:a17:906:9b86:b0:6fe:d37f:b29d with SMTP id dd6-20020a1709069b8600b006fed37fb29dmr21130811ejc.327.1659015370899;
        Thu, 28 Jul 2022 06:36:10 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id e27-20020a170906315b00b0072b1bb3cc08sm418643eje.120.2022.07.28.06.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 06:36:10 -0700 (PDT)
Message-ID: <2b1b4cd1-faec-85a1-5ad2-e2b29290e0c1@redhat.com>
Date:   Thu, 28 Jul 2022 15:36:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] platform/x86: p2sb: Move out of
 X86_PLATFORM_DEVICES dependency
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Mark Gross <markgross@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Kate Hsuan <hpa@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220718145328.14374-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220718145328.14374-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/18/22 16:53, Andy Shevchenko wrote:
> The P2SB library is used for various drivers, including server
> platforms. That's why the dependency on X86_PLATFORM_DEVICES
> seems superfluous.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> v2: added X86 to the dependencies of P2SB (Hans), added Rb tag (Hans)

Lee I presume that since you've merged the original series
(in your ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-5.20
branch) that you will take this fix on top ?

This fix is necessary to fix a bunch of randconfig build
failures in the current linux-next.

>  drivers/platform/x86/Kconfig            | 12 ++++++++++++
>  drivers/platform/x86/Makefile           |  4 ++++
>  drivers/platform/x86/intel/Kconfig      | 12 ------------
>  drivers/platform/x86/intel/Makefile     |  2 --
>  drivers/platform/x86/{intel => }/p2sb.c |  0
>  5 files changed, 16 insertions(+), 14 deletions(-)
>  rename drivers/platform/x86/{intel => }/p2sb.c (100%)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bc4013e950ed..21e03bb901d2 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1164,6 +1164,18 @@ config WINMATE_FM07_KEYS
>  
>  endif # X86_PLATFORM_DEVICES
>  
> +config P2SB
> +	bool "Primary to Sideband (P2SB) bridge access support"
> +	depends on PCI && X86
> +	help
> +	  The Primary to Sideband (P2SB) bridge is an interface to some
> +	  PCI devices connected through it. In particular, SPI NOR controller
> +	  in Intel Apollo Lake SoC is one of such devices.
> +
> +	  The main purpose of this library is to unhide P2SB device in case
> +	  firmware kept it hidden on some platforms in order to access devices
> +	  behind it.
> +
>  config PMC_ATOM
>         def_bool y
>         depends on PCI

Note once this is added to Lee's ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-5.20
branch there will be a small/trivial conflict between it and my pdx86/for-next
branch since commit 3cd8cc98d63 ("platform/x86: Drop the PMC_ATOM Kconfig option")
removes the config PMC_ATOM option from the end of drivers/platform/x86/Kconfig .

Not really a problem, but something to be aware of.

Regards,

Hans




> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 4a59f47a46e2..f04001431c91 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -120,6 +120,10 @@ obj-$(CONFIG_X86_ANDROID_TABLETS)	+= x86-android-tablets.o
>  # Intel uncore drivers
>  obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
>  
> +# Intel miscellaneous drivers
> +intel_p2sb-y				:= p2sb.o
> +obj-$(CONFIG_P2SB)			+= intel_p2sb.o
> +
>  # Intel PMIC / PMC / P-Unit devices
>  obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
>  obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
> diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
> index c9cfbaae436b..794968bda115 100644
> --- a/drivers/platform/x86/intel/Kconfig
> +++ b/drivers/platform/x86/intel/Kconfig
> @@ -70,18 +70,6 @@ config INTEL_OAKTRAIL
>  	  enable/disable the Camera, WiFi, BT etc. devices. If in doubt, say Y
>  	  here; it will only load on supported platforms.
>  
> -config P2SB
> -	bool "Primary to Sideband (P2SB) bridge access support"
> -	depends on PCI
> -	help
> -	  The Primary to Sideband (P2SB) bridge is an interface to some
> -	  PCI devices connected through it. In particular, SPI NOR controller
> -	  in Intel Apollo Lake SoC is one of such devices.
> -
> -	  The main purpose of this library is to unhide P2SB device in case
> -	  firmware kept it hidden on some platforms in order to access devices
> -	  behind it.
> -
>  config INTEL_BXTWC_PMIC_TMU
>  	tristate "Intel Broxton Whiskey Cove TMU Driver"
>  	depends on INTEL_SOC_PMIC_BXTWC
> diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
> index 741a9404db98..717933dd0cfd 100644
> --- a/drivers/platform/x86/intel/Makefile
> +++ b/drivers/platform/x86/intel/Makefile
> @@ -28,8 +28,6 @@ intel_int0002_vgpio-y			:= int0002_vgpio.o
>  obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
>  intel_oaktrail-y			:= oaktrail.o
>  obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
> -intel_p2sb-y				:= p2sb.o
> -obj-$(CONFIG_P2SB)			+= intel_p2sb.o
>  intel_sdsi-y				:= sdsi.o
>  obj-$(CONFIG_INTEL_SDSI)		+= intel_sdsi.o
>  intel_vsec-y				:= vsec.o
> diff --git a/drivers/platform/x86/intel/p2sb.c b/drivers/platform/x86/p2sb.c
> similarity index 100%
> rename from drivers/platform/x86/intel/p2sb.c
> rename to drivers/platform/x86/p2sb.c

