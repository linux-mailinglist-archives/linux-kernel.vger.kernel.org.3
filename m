Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA45447E6D6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349483AbhLWRTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:19:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349465AbhLWRTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:19:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640279970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CijTsc167v3pAGmC2N7oOwhu+CF6iavgoBpCSS5GyC8=;
        b=S9QWfZ7Xyrwbegjc/pNiJ+ipWfOlHWjgXVVyi1aerxH+2XZXfxhATycL4GFw4idlpmVEgF
        LjRHTnlrhUZVERUR9i9QKW3zh92jM7tLOb149s66UBGu5dsIheKkUM9OVNWJD+p+uZCJaz
        rrvvDlNCpDGFDzwOz5CAH/5oww61pw0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-900FyxrzNlSAKCcm7Gy0bw-1; Thu, 23 Dec 2021 12:19:28 -0500
X-MC-Unique: 900FyxrzNlSAKCcm7Gy0bw-1
Received: by mail-ed1-f71.google.com with SMTP id s7-20020a056402520700b003f841380832so4983817edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:19:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CijTsc167v3pAGmC2N7oOwhu+CF6iavgoBpCSS5GyC8=;
        b=x7uXlHIY4MAGx2xqdLO3wi0+QBnvM64VRGQEFUq2dUeCXc5dbSrf1NdLGAR6xMk/2X
         lxuxjnpi/bcwxRpz29u2R10d+T2zZHiXgFdvAsjidPGRoLO3EfOY9xR2pcTZThyQ6pYp
         GCmDRaYzLmDLr/HH+AdDjWsDdGw1WNlbqm1G5H+elQDzs/ZZGHD8F8KLeo7+Gz3a+VEn
         7jNMwe1x8T81bqa5nXv2vgm3QrHYsoKRY72dDblQLPMWNfzYHzYQoCXbo3OGeAopSXMr
         /ywT6yZj0Uvt0GrJL3tYEAmO3PhjhfxdXaoorVoOBYn9Ls5AHSTx/9aXVCYK6Mc5BVbW
         qCOQ==
X-Gm-Message-State: AOAM531YpggwkirlSwAMieEuPB0jI8dbB/JwAn3iucbslP46nfFXzKbD
        nV10HM4UjzM1v5Nyd9Na4L16tDdDr12NLNFYNQYrDgT7bnJn894xjZtDZ5Cio+JfvYe4vi5Z2Nv
        Gh3WO8e4m8nznwtBiAMblRAjY
X-Received: by 2002:a17:907:2ce1:: with SMTP id hz1mr2795174ejc.199.1640279967240;
        Thu, 23 Dec 2021 09:19:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyT9S+JHIoW7NGHZadwBhgS0oce/K2kX1wdhNB/MBs3FMbd3d5gpaUfA8rQZMaCWLv2SCSqPQ==
X-Received: by 2002:a17:907:2ce1:: with SMTP id hz1mr2795165ejc.199.1640279967030;
        Thu, 23 Dec 2021 09:19:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id di18sm1951390ejc.56.2021.12.23.09.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 09:19:26 -0800 (PST)
Message-ID: <496d2006-481d-a94b-9ab0-e4b4dde315a1@redhat.com>
Date:   Thu, 23 Dec 2021 18:19:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1 1/1] platform/x86/intel: Remove
 X86_PLATFORM_DRIVERS_INTEL
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
References: <20211222194941.76054-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211222194941.76054-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/22/21 20:49, Andy Shevchenko wrote:
> While introduction of this menu brings a nice view in the configuration tools,
> it brought more issues than solves, i.e. it prevents to locate files in the
> intel/ subfolder without touching non-related Kconfig dependencies elsewhere.
> Drop X86_PLATFORM_DRIVERS_INTEL altogether.
> 
> Note, on x86 it's enabled by default and it's quite unlikely anybody wants to
> disable all of the modules in this submenu.
> 
> Fixes: 8bd836feb6ca ("platform/x86: intel_skl_int3472: Move to intel/ subfolder")
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/Makefile      |  2 +-
>  drivers/platform/x86/intel/Kconfig | 15 ---------------
>  2 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index dfb7ca88f012..18b11769073b 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -69,7 +69,7 @@ obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
>  obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>  
>  # Intel
> -obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)		+= intel/
> +obj-y				+= intel/
>  
>  # MSI
>  obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
> diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
> index e0cc64dcf72c..f8b53f24f6f2 100644
> --- a/drivers/platform/x86/intel/Kconfig
> +++ b/drivers/platform/x86/intel/Kconfig
> @@ -3,19 +3,6 @@
>  # Intel x86 Platform Specific Drivers
>  #
>  
> -menuconfig X86_PLATFORM_DRIVERS_INTEL
> -	bool "Intel x86 Platform Specific Device Drivers"
> -	default y
> -	help
> -	  Say Y here to get to see options for device drivers for
> -	  various Intel x86 platforms, including vendor-specific
> -	  drivers. This option alone does not add any kernel code.
> -
> -	  If you say N, all options in this submenu will be skipped
> -	  and disabled.
> -
> -if X86_PLATFORM_DRIVERS_INTEL
> -
>  source "drivers/platform/x86/intel/atomisp2/Kconfig"
>  source "drivers/platform/x86/intel/int1092/Kconfig"
>  source "drivers/platform/x86/intel/int33fe/Kconfig"
> @@ -195,5 +182,3 @@ config INTEL_UNCORE_FREQ_CONTROL
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called intel-uncore-frequency.
> -
> -endif # X86_PLATFORM_DRIVERS_INTEL
> 

