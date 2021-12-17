Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADC44789BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhLQLWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:22:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:1882 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233443AbhLQLWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:22:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="238478675"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="238478675"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 03:22:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="466472708"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 03:22:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1myBIz-007O9b-Ub;
        Fri, 17 Dec 2021 13:21:41 +0200
Date:   Fri, 17 Dec 2021 13:21:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lakshmi.sowjanya.d@intel.com
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, bgolaszewski@baylibre.com,
        linux-kernel@vger.kernel.org, tamal.saha@intel.com,
        pandith.n@intel.com, kenchappa.demakkanavar@intel.com
Subject: Re: [PATCH v3 2/2] pinctrl: Add Intel Thunder Bay pinctrl driver
Message-ID: <YbxyxdiHCYgBKZlQ@smile.fi.intel.com>
References: <20211216150100.21171-1-lakshmi.sowjanya.d@intel.com>
 <20211216150100.21171-3-lakshmi.sowjanya.d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216150100.21171-3-lakshmi.sowjanya.d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 08:31:00PM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> About Intel Thunder Bay:
> -----------------------
> Intel Thunder Bay is a computer vision AI accelerator SoC based on ARM CPU.
> 
> Pinctrl IP:
> ----------
> The SoC has a customised pinmux controller IP which controls pin
> multiplexing and configuration.
> 
> Thunder Bay pinctrl IP is not based on and have nothing in common with the
> existing pinctrl drivers. The registers used are incompatible with the
> existing drivers, so it requires a new driver.
> 
> Add pinctrl driver to enable pin control support in the Intel Thunder Bay
> SoC.

...

+ bits.h.

> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>

> +#include <linux/pinctrl/pinconf.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>

Can you move this...

> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>

...here?

> +#include "core.h"
> +#include "pinconf.h"
> +#include "pinctrl-utils.h"
> +#include "pinmux.h"

...

> +#define THB_GPIO_REG_OFFSET(pin_num)			((pin_num) * (0x4))

'(0x4)' --> '4'

...

> +static int thb_write_gpio_data(struct gpio_chip *chip, unsigned int offset, unsigned int value)
> +{
> +	int data_offset;
> +	u32 data_reg;
> +
> +	data_offset = 0x2000u + (offset / 32);
> +
> +	data_reg = thb_gpio_read_reg(chip, data_offset);
> +
> +	if (value > 0)

if (value)

> +		data_reg |= BIT(offset % 32);
> +	else
> +		data_reg &= ~BIT(offset % 32);
> +
> +	return thb_gpio_write_reg(chip, data_offset, data_reg);
> +}

...

> +static int thunderbay_gpio_set_direction_input(struct gpio_chip *chip, unsigned int offset)
> +{
> +	u32 reg = thb_gpio_read_reg(chip, offset);
> +
> +	/* set pin as input only if it is GPIO else error */
> +	if (reg & THB_GPIO_PORT_SELECT_MASK) {

Can it be

	reg = thb_gpio_read_reg(chip, offset);
	if (!(reg & THB_GPIO_PORT_SELECT_MASK))
		return -EINVAL;

?

> +		reg &= (~THB_GPIO_PAD_DIRECTION_MASK);

Too many parentheses.

> +		thb_gpio_write_reg(chip, offset, reg);
> +		return 0;
> +	}
> +	return -EINVAL;
> +}

...

> +static int thunderbay_gpio_set_direction_output(struct gpio_chip *chip,
> +						unsigned int offset, int value)
> +{
> +	u32 reg = thb_gpio_read_reg(chip, offset);
> +
> +	/* set pin as output only if it is GPIO else error */
> +	if (reg & THB_GPIO_PORT_SELECT_MASK) {

As per above.

> +		reg |= THB_GPIO_PAD_DIRECTION_MASK;
> +		thb_gpio_write_reg(chip, offset, reg);
> +		thunderbay_gpio_set_value(chip, offset, value);
> +		return 0;
> +	}
> +	return -EINVAL;
> +}

...

> +static int thunderbay_gpio_get_value(struct gpio_chip *chip, unsigned int offset)
> +{
> +	u32 reg = thb_gpio_read_reg(chip, offset);

> +	int gpio_dir = 0;

Useless assignment.

> +	/* Read pin value only if it is GPIO else error */
> +	if (reg & THB_GPIO_PORT_SELECT_MASK) {
> +		/* 0=in, 1=out */
> +		gpio_dir = (reg & THB_GPIO_PAD_DIRECTION_MASK) > 0;

!!(reg & ...)

> +		/* Returns negative value when pin is configured as PORT */
> +		return thb_read_gpio_data(chip, offset, gpio_dir);
> +	}
> +	return -EINVAL;

And as per above.

> +}

...

> +	/* identifies the first GPIO number handled by this chip; or,
> +	 * if negative during registration, requests dynamic ID allocation.
> +	 * Please pass -1 as base to let gpiolib select the chip base in all possible cases.
> +	 * We want to get rid of the static GPIO number space in the long run.
> +	 */

/*
 * Please, fix the style of the
 * multi-line comments. Pay attention
 * to the grammar, etc. Everywhere.
 */

...

> +	/* Number of GPIOs handled by this controller; the last GPIO handled is (base + ngpio - 1)*/

Too long comment with missed white space.

...

> +	/* Register/add Thunder Bay GPIO chip with Linux framework */
> +	ret = gpiochip_add_data(chip, tpc);

Why not devm_*()?

> +	if (ret)
> +		dev_err(tpc->dev, "Failed to add gpiochip\n");

> +	return ret;

return 0;

But overall, use dev_err_probe().

I stopped here, since there are too many same comments over all functions in
this driver.

...

> +	{
> +		.compatible = "intel,thunderbay-pinctrl",
> +		.data = &thunderbay_data

+ Comma.

> +	},

...

> +	of_id = of_match_node(thunderbay_pinctrl_match, pdev->dev.of_node);

You already have dev, use it everywhere in the ->probe().

> +	if (!of_id)
> +		return -ENODEV;

Use of_device_get_match_data() (or how is it called?).

...

> +	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);

> +	if (!iomem)
> +		return -ENXIO;

Redundant, but see below.

> +
> +	tpc->base0 =  devm_ioremap_resource(dev, iomem);
> +	if (IS_ERR(tpc->base0))
> +		return PTR_ERR(tpc->base0);

I dunno if you read any of previous comments regarding to other drivers.
The above is just one API call. Find it and use.

...

> +static int thunderbay_pinctrl_remove(struct platform_device *pdev)
> +{
> +	/* thunderbay_pinctrl_remove function to clear the assigned memory */
> +	return 0;
> +}

Why do you need this stub? What for?

...

> +

Redundant blank line.

> +builtin_platform_driver(thunderbay_pinctrl_driver);

-- 
With Best Regards,
Andy Shevchenko


