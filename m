Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4D46BAFC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbhLGM1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:27:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:21700 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236021AbhLGM0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:26:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="298358880"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="298358880"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 04:23:23 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="461239930"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 04:23:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muZUC-003Dne-Ij;
        Tue, 07 Dec 2021 14:22:20 +0200
Date:   Tue, 7 Dec 2021 14:22:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Richard Hsu <saraon640529@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        Richard_Hsu@asmedia.com.tw, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Cindy1_Hsu@asmedia.com.tw, Andrew_Su@asmedia.com.tw
Subject: Re: [PATCH] gpio:gpio-amdpt:add new device and that 24-pin support
Message-ID: <Ya9R/Ab1x43lfxCU@smile.fi.intel.com>
References: <20211207094239.5059-1-Richard_Hsu@asmedia.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207094239.5059-1-Richard_Hsu@asmedia.com.tw>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:42:39PM +0800, Richard Hsu wrote:
> From: RichardHsu <Richard_Hsu@asmedia.com.tw>

Thanks for an update, my comments below.

First of all, don't forget versioning of the patch (in the Subject it should
be PATCH v2). Besides that, don't forget to include changelog (see below).

Subject should be:

	gpio: amdpt: add new device ID and 24-pin support

> New ACPI gpio device(AMDIF031) support 24 gpio pins. We add new device id and pin number to .driver_data of acpi_device_id structure
> and then retrieve it by device_get_match_data() that Andy suggest it.

Please, make sure your text is wrapped at ~72-75 characters.

> Signed-off-by: RichardHsu <Richard_Hsu@asmedia.com.tw>

Is it name out of one work like this? Otherwise put your Real Name here.

> ---

Changelog should be here, after '--- ' cutter line.

>  drivers/gpio/gpio-amdpt.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
> index bbf53e289141..a45693423a07 100644
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
> @@ -103,7 +104,8 @@ static int pt_gpio_probe(struct platform_device *pdev)
>  	pt_gpio->gc.owner            = THIS_MODULE;
>  	pt_gpio->gc.request          = pt_gpio_request;
>  	pt_gpio->gc.free             = pt_gpio_free;
> -	pt_gpio->gc.ngpio            = PT_TOTAL_GPIO;

> +	/* retrieve pin number from .driver_data of acpi_device_id structure */

Everybody understands or can easily get what the below API call does. No need
to have a comment.

> +	pt_gpio->gc.ngpio            = (uintptr_t)device_get_match_data(dev);
>  #if defined(CONFIG_OF_GPIO)
>  	pt_gpio->gc.of_node          = dev->of_node;
>  #endif
> @@ -133,8 +135,9 @@ static int pt_gpio_remove(struct platform_device *pdev)
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

The code itself looks good!

-- 
With Best Regards,
Andy Shevchenko


