Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908A347001C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbhLJLjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:39:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:57326 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238051AbhLJLje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:39:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="262441700"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="262441700"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:35:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="581661751"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:35:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mve8u-004TK8-QX;
        Fri, 10 Dec 2021 13:32:48 +0200
Date:   Fri, 10 Dec 2021 13:32:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yuchang Hsu <saraon640529@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        Richard_Hsu@asmedia.com.tw, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Cindy1_Hsu@asmedia.com.tw, Andrew_Su@asmedia.com.tw
Subject: Re: [PATCH v4] gpio: amdpt: add new device ID and 24-pin support
Message-ID: <YbM64Dhlii+lKhRu@smile.fi.intel.com>
References: <20211210090315.4889-1-Richard_Hsu@asmedia.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210090315.4889-1-Richard_Hsu@asmedia.com.tw>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:03:15PM +0800, Yuchang Hsu wrote:
> From: Hsu Yuchang <Richard_Hsu@asmedia.com.tw>
> 
> Add an ACPI HID(AMDIF031) and pin number in the pt_gpio_acpi_match.

Very well!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Yuchang Hsu <Richard_Hsu@asmedia.com.tw>
> ---
> Reposition and modify the changelog
>  drivers/gpio/gpio-amdpt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
> index bbf53e289141..13f4e2af3800 100644
> --- a/drivers/gpio/gpio-amdpt.c
> +++ b/drivers/gpio/gpio-amdpt.c
> @@ -14,6 +14,7 @@
>  #include <linux/platform_device.h>
> 
>  #define PT_TOTAL_GPIO 8
> +#define PT_TOTAL_GPIO_EX 24
> 
>  /* PCI-E MMIO register offsets */
>  #define PT_DIRECTION_REG   0x00
> @@ -103,7 +104,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
>  	pt_gpio->gc.owner            = THIS_MODULE;
>  	pt_gpio->gc.request          = pt_gpio_request;
>  	pt_gpio->gc.free             = pt_gpio_free;
> -	pt_gpio->gc.ngpio            = PT_TOTAL_GPIO;
> +	pt_gpio->gc.ngpio            = (uintptr_t)device_get_match_data(dev);
>  #if defined(CONFIG_OF_GPIO)
>  	pt_gpio->gc.of_node          = dev->of_node;
>  #endif
> @@ -133,8 +134,9 @@ static int pt_gpio_remove(struct platform_device *pdev)
>  }
> 
>  static const struct acpi_device_id pt_gpio_acpi_match[] = {
> -	{ "AMDF030", 0 },
> -	{ "AMDIF030", 0 },
> +	{ "AMDF030", PT_TOTAL_GPIO },
> +	{ "AMDIF030", PT_TOTAL_GPIO },
> +	{ "AMDIF031", PT_TOTAL_GPIO_EX },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, pt_gpio_acpi_match);
> --
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


