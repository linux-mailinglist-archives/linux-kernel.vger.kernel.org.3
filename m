Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6541247BCDD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbhLUJ3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbhLUJ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:29:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A10CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:29:13 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so1631302wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=E+OUjvCnSBIVoOPsykbmMVaOVrA8L4E94Kk6TCgw0jo=;
        b=IoxK+ClGrvbMTQhykcalbweIya3OerwbEqChoVnIW6R6LBwBrV6i4dOSWSwwqiLfLa
         7InK7hzSuWUW2YPN2Z+hCyewoICLGwdrVcNh8pA17iWeJaPr9YDs056IgxgAbBvbJhEY
         83QdtyYndPTHWvPqGPD6Kbtk4yQihDOB7idzkRuPTXbLDj1PI669uT95WLWNHOjkmzwG
         I2DsP4SMEVe8KIz9AWhg87l0rkkaOaDfOJddvSDahouDUuw1GyDEGpZSySsQDJrcjlUG
         +kjFHokxwHrADmwx5IjFVbaX2Zjepq/esd2tl9/ORsUtdd2bODMpY6YfuoUw5UxEWsXO
         wLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E+OUjvCnSBIVoOPsykbmMVaOVrA8L4E94Kk6TCgw0jo=;
        b=FCQLKjPsrD9IPwSbnxXElM0l9eVYDuea560cd4wvnBzafEV9VXKGJ4Koi7IN+EoraX
         s9n6uDFjER1/IEN0zWEH0rS/sD33ktx7D0eod6/QQJqgDNoXoEkVLDrfOykc2GT+BI31
         RWpLzIcMZIAMCL/E9UCJV8xdqvbjNyna7l5P6OJlh+plCrwZLsZftRywQBdUzVZSH1xT
         lF8e/UdMleGzth6V7ev1kSM3RyudCaABeTx8q26ivfgFVhPZjOJ6pbpJcR65BJCAiQ/L
         IlBMdAcpgjOfmgupsqCMD8LltSiWSpxyX863pTfcMHicG8SiXRPN3t5cfBI53gINbv7y
         K92A==
X-Gm-Message-State: AOAM533Aj1n+iC0NPGhQzmKyY5M1UzD74oQdmshalPBLVRaLOJl/YkrI
        a/wmlKBbN9INkZvz4Xb93kb6fQ==
X-Google-Smtp-Source: ABdhPJxAoAbZw7yJ1GaBfn5OQqJrEqLtDyo/KsPDod8usButB1eKgUdw+LQJhbJfofrl3Z2BJKX7Rg==
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr1874464wmj.147.1640078951624;
        Tue, 21 Dec 2021 01:29:11 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id c9sm1768897wml.12.2021.12.21.01.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 01:29:10 -0800 (PST)
Date:   Tue, 21 Dec 2021 09:29:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 5/9] mfd: max77714: Add driver for Maxim MAX77714 PMIC
Message-ID: <YcGeZVgqNWDyvovW@google.com>
References: <20211211175951.30763-1-luca@lucaceresoli.net>
 <20211211175951.30763-6-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211211175951.30763-6-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2021, Luca Ceresoli wrote:

> Add a simple driver for the Maxim MAX77714 PMIC, supporting RTC and
> watchdog only.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Changes in v5: none
> 
> Changes in v4: none
> 
> Changes in v3:
>  - Suggested by Lee Jones:
>    - move struct mfd_cell to top of file
>    - remove struct max77714 and its kmalloc, not used after probe
>    - reword error messages
>    - add "/* pF */" onto the end of the load_cap line
> 
> Changes in v2:
>  - fix "watchdog" word in heading comment (Guenter Roeck)
>  - move struct max77714 to .c file (Krzysztof Kozlowski)
>  - change include guard format (Krzysztof Kozlowski)
>  - allow building as a module (Krzysztof Kozlowski)
>  - remove of_match_ptr usage (Krzysztof Kozlowski / lkp)
>    (Reported-by: kernel test robot <lkp@intel.com>)
> ---
>  MAINTAINERS                  |   2 +
>  drivers/mfd/Kconfig          |  14 ++++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/max77714.c       | 152 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max77714.h |  60 ++++++++++++++
>  5 files changed, 229 insertions(+)
>  create mode 100644 drivers/mfd/max77714.c
>  create mode 100644 include/linux/mfd/max77714.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a08f5167dfe0..ef3ffba828af 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11586,6 +11586,8 @@ MAXIM MAX77714 PMIC MFD DRIVER
>  M:	Luca Ceresoli <luca@lucaceresoli.net>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
> +F:	drivers/mfd/max77714.c
> +F:	include/linux/mfd/max77714.h
>  
>  MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
>  M:	Javier Martinez Canillas <javier@dowhile0.org>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3fb480818599..1b9d772bdae6 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -855,6 +855,20 @@ config MFD_MAX77693
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_MAX77714
> +	tristate "Maxim Semiconductor MAX77714 PMIC Support"
> +	depends on I2C
> +	depends on OF || COMPILE_TEST
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to add support for Maxim Semiconductor MAX77714.
> +	  This is a Power Management IC with 4 buck regulators, 9
> +	  low-dropout regulators, 8 GPIOs, RTC, watchdog etc. This driver
> +	  provides common support for accessing the device; additional
> +	  drivers must be enabled in order to use each functionality of the
> +	  device.
> +
>  config MFD_MAX77843
>  	bool "Maxim Semiconductor MAX77843 PMIC Support"
>  	depends on I2C=y
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 0b1b629aef3e..03115cf1336b 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -162,6 +162,7 @@ obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
>  obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
>  obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
>  obj-$(CONFIG_MFD_MAX77693)	+= max77693.o
> +obj-$(CONFIG_MFD_MAX77714)	+= max77714.o
>  obj-$(CONFIG_MFD_MAX77843)	+= max77843.o
>  obj-$(CONFIG_MFD_MAX8907)	+= max8907.o
>  max8925-objs			:= max8925-core.o max8925-i2c.o
> diff --git a/drivers/mfd/max77714.c b/drivers/mfd/max77714.c
> new file mode 100644
> index 000000000000..08dfb69bc6e8
> --- /dev/null
> +++ b/drivers/mfd/max77714.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Maxim MAX77714 MFD Driver

I'm only mentioning this because you are still missing some reviews.

But I'd prefer for drivers not to describe themselves as MFD Drivers.

The term Parent or Core driver is usually better.

If you have to respin the set, please fix it.

If not, please sent a subsequent fix-up.

Once fixed:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
