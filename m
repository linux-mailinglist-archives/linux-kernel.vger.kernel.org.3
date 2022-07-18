Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF46578506
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiGRONP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiGRONN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E82E2715A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658153591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HEXGIVwfrt07LtwhxUfTMwTUQOGHho48gf67fULBC/s=;
        b=aemA4W1GvYi8Rhc2XRF+jNBAOTooG2/kdeB1ynJlzV4HfiHGC87pEt1yVqh1BAqdLtXYH/
        aaYLM1GpZ3LEaTbwuC8RPa/F9SP5ZoY69IgZOgwpHANJkKZaVQfffWORyMNiXFnMpqELU+
        fbhJZOFWq9a0pHRE/6r/u36ZcY22K9Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-OLPZUqQ2PxS3D-kO5-7MBA-1; Mon, 18 Jul 2022 10:13:10 -0400
X-MC-Unique: OLPZUqQ2PxS3D-kO5-7MBA-1
Received: by mail-ed1-f69.google.com with SMTP id w15-20020a056402268f00b0043ac600a6bcso7908140edd.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HEXGIVwfrt07LtwhxUfTMwTUQOGHho48gf67fULBC/s=;
        b=WSpfpP/CVPcdILgy1dIABROM5N0I33BQVJGkpmUoOMq+KvYOOPt33FNa813WePVcdG
         nJbJ/aVVzihLs69v7r5zYJ12SW5fHaEimHWwGSQ9bzoexSy29now6w4BKPmm8s1cRfcV
         07IJJOaydvnDxC9mCiU8JOObZzCtIW3I+2yK4LGPVxb058lOXU8P8skZY5bccEnLjCI6
         8FZ8Qv5tKdDYWuK8VYReE8xaxMwrLg1OHnAU4JLGBdT5+/MEatyj1T8wteGG3ggJwXqC
         /+pXdRKumkkUNh6KEhgC/UZu9/TdxxcbRrYyPDN4hOMgGyLphm6EctVevdeAe7SNHT2e
         /aeg==
X-Gm-Message-State: AJIora9Kaq9E6GlH0hIKQTkjx9xQJuS5/aiV2fUTvwarst/GBGuBOdQL
        B1PqkQba9sGdR7oLI3vMxF9I6Y5KIVybdCE1cGVox+0KyZnGVLRsjbgO2SRQ4DWSv8MmIlLl3EB
        GMG1UwYgwq6nFDpLYrLwzhFoX
X-Received: by 2002:a05:6402:358d:b0:43a:c600:a678 with SMTP id y13-20020a056402358d00b0043ac600a678mr37500603edc.219.1658153588903;
        Mon, 18 Jul 2022 07:13:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v+L2EpsFUtH/PoBmDiVf/DKk3qClDJkE5lw7mlgjotUmcg0wUEt9TxWgocXkgbM7tHvXVvgw==
X-Received: by 2002:a05:6402:358d:b0:43a:c600:a678 with SMTP id y13-20020a056402358d00b0043ac600a678mr37500567edc.219.1658153588662;
        Mon, 18 Jul 2022 07:13:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id l9-20020a170906078900b00722e31fcf42sm5441935ejc.184.2022.07.18.07.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 07:13:08 -0700 (PDT)
Message-ID: <aa9e27c7-e4cf-00f1-e88a-8d6c3857eb71@redhat.com>
Date:   Mon, 18 Jul 2022 16:13:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/1] platform/x86: p2sb: Move out of
 X86_PLATFORM_DEVICES dependency
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>,
        Jonathan Yong <jonathan.yong@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        kernel test robot <lkp@intel.com>
References: <20220718114748.6365-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220718114748.6365-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/18/22 13:47, Andy Shevchenko wrote:
> The P2SB library is used for various drivers, including server
> platforms. That's why the dependency on X86_PLATFORM_DEVICES
> seems superfluous.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/Kconfig            | 12 ++++++++++++
>  drivers/platform/x86/Makefile           |  4 ++++
>  drivers/platform/x86/intel/Kconfig      | 12 ------------
>  drivers/platform/x86/intel/Makefile     |  2 --
>  drivers/platform/x86/{intel => }/p2sb.c |  0
>  5 files changed, 16 insertions(+), 14 deletions(-)
>  rename drivers/platform/x86/{intel => }/p2sb.c (100%)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bc4013e950ed..cab9ceb85436 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1164,6 +1164,18 @@ config WINMATE_FM07_KEYS
>  
>  endif # X86_PLATFORM_DEVICES
>  
> +config P2SB
> +	bool "Primary to Sideband (P2SB) bridge access support"
> +	depends on PCI

This needs to become "PCI && X86" to avoid this possible getting
enabled on other platforms.

With that added you may add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

and this also counts as my ack for merging this through
Lee's MFD tree together with the rest of the series.

Regards,

Hans


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

