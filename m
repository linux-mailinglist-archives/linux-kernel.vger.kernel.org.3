Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87832495CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379704AbiAUJRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:17:52 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:55977 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343890AbiAUJRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:17:51 -0500
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A26D21BF205;
        Fri, 21 Jan 2022 09:17:49 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 1/1] ARM: orion/gpio: Get rid of unused first
 parameter in orion_gpio_init()
In-Reply-To: <20211214140656.53694-1-andriy.shevchenko@linux.intel.com>
References: <20211214140656.53694-1-andriy.shevchenko@linux.intel.com>
Date:   Fri, 21 Jan 2022 10:17:49 +0100
Message-ID: <8735lh5txe.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> The OF node pointer is always NULL, get rid of unused parameter in
> orion_gpio_init(). As a side effect it will allow to switch GPIO
> library to the fwnode API, as well as in case of resurrecting it here
> it should be fwnode_handle anyways.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


Applied on mvebu/arm

Thanks,

Gregory

> ---
> v2: wrapped to 80 limit (Russell)
>  arch/arm/mach-dove/irq.c                      | 6 +++---
>  arch/arm/mach-mv78xx0/irq.c                   | 3 +--
>  arch/arm/mach-orion5x/irq.c                   | 2 +-
>  arch/arm/plat-orion/gpio.c                    | 8 ++------
>  arch/arm/plat-orion/include/plat/orion-gpio.h | 3 +--
>  5 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
> index 31ccbcee2627..d36f6b8269c2 100644
> --- a/arch/arm/mach-dove/irq.c
> +++ b/arch/arm/mach-dove/irq.c
> @@ -73,12 +73,12 @@ void __init dove_init_irq(void)
>  	/*
>  	 * Initialize gpiolib for GPIOs 0-71.
>  	 */
> -	orion_gpio_init(NULL, 0, 32, DOVE_GPIO_LO_VIRT_BASE, 0,
> +	orion_gpio_init(0, 32, DOVE_GPIO_LO_VIRT_BASE, 0,
>  			IRQ_DOVE_GPIO_START, gpio0_irqs);
>  
> -	orion_gpio_init(NULL, 32, 32, DOVE_GPIO_HI_VIRT_BASE, 0,
> +	orion_gpio_init(32, 32, DOVE_GPIO_HI_VIRT_BASE, 0,
>  			IRQ_DOVE_GPIO_START + 32, gpio1_irqs);
>  
> -	orion_gpio_init(NULL, 64, 8, DOVE_GPIO2_VIRT_BASE, 0,
> +	orion_gpio_init(64, 8, DOVE_GPIO2_VIRT_BASE, 0,
>  			IRQ_DOVE_GPIO_START + 64, gpio2_irqs);
>  }
> diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-mv78xx0/irq.c
> index 788569e960e1..0b5f055ca1c3 100644
> --- a/arch/arm/mach-mv78xx0/irq.c
> +++ b/arch/arm/mach-mv78xx0/irq.c
> @@ -67,7 +67,6 @@ void __init mv78xx0_init_irq(void)
>  	 * registers for core #1 are at an offset of 0x18 from those of
>  	 * core #0.)
>  	 */
> -	orion_gpio_init(NULL, 0, 32, GPIO_VIRT_BASE,
> -			mv78xx0_core_index() ? 0x18 : 0,
> +	orion_gpio_init(0, 32, GPIO_VIRT_BASE, mv78xx0_core_index() ? 0x18 : 0,
>  			IRQ_MV78XX0_GPIO_START, gpio0_irqs);
>  }
> diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
> index ac4af2283bef..1ae775d02d90 100644
> --- a/arch/arm/mach-orion5x/irq.c
> +++ b/arch/arm/mach-orion5x/irq.c
> @@ -49,6 +49,6 @@ void __init orion5x_init_irq(void)
>  	/*
>  	 * Initialize gpiolib for GPIOs 0-31.
>  	 */
> -	orion_gpio_init(NULL, 0, 32, GPIO_VIRT_BASE, 0,
> +	orion_gpio_init(0, 32, GPIO_VIRT_BASE, 0,
>  			IRQ_ORION5X_GPIO_START, gpio0_irqs);
>  }
> diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
> index 734f0be4f14a..3ef9ecdd6343 100644
> --- a/arch/arm/plat-orion/gpio.c
> +++ b/arch/arm/plat-orion/gpio.c
> @@ -516,8 +516,7 @@ static void orion_gpio_mask_irq(struct irq_data *d)
>  	irq_gc_unlock(gc);
>  }
>  
> -void __init orion_gpio_init(struct device_node *np,
> -			    int gpio_base, int ngpio,
> +void __init orion_gpio_init(int gpio_base, int ngpio,
>  			    void __iomem *base, int mask_offset,
>  			    int secondary_irq_base,
>  			    int irqs[4])
> @@ -545,9 +544,6 @@ void __init orion_gpio_init(struct device_node *np,
>  	ochip->chip.base = gpio_base;
>  	ochip->chip.ngpio = ngpio;
>  	ochip->chip.can_sleep = 0;
> -#ifdef CONFIG_OF
> -	ochip->chip.of_node = np;
> -#endif
>  	ochip->chip.dbg_show = orion_gpio_dbg_show;
>  
>  	spin_lock_init(&ochip->lock);
> @@ -605,7 +601,7 @@ void __init orion_gpio_init(struct device_node *np,
>  			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
>  
>  	/* Setup irq domain on top of the generic chip. */
> -	ochip->domain = irq_domain_add_legacy(np,
> +	ochip->domain = irq_domain_add_legacy(NULL,
>  					      ochip->chip.ngpio,
>  					      ochip->secondary_irq_base,
>  					      ochip->secondary_irq_base,
> diff --git a/arch/arm/plat-orion/include/plat/orion-gpio.h b/arch/arm/plat-orion/include/plat/orion-gpio.h
> index e856b073a9c8..25a2963e0e0f 100644
> --- a/arch/arm/plat-orion/include/plat/orion-gpio.h
> +++ b/arch/arm/plat-orion/include/plat/orion-gpio.h
> @@ -30,8 +30,7 @@ int orion_gpio_led_blink_set(struct gpio_desc *desc, int state,
>  void orion_gpio_set_valid(unsigned pin, int mode);
>  
>  /* Initialize gpiolib. */
> -void __init orion_gpio_init(struct device_node *np,
> -			    int gpio_base, int ngpio,
> +void __init orion_gpio_init(int gpio_base, int ngpio,
>  			    void __iomem *base, int mask_offset,
>  			    int secondary_irq_base,
>  			    int irq[4]);
> -- 
> 2.33.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
