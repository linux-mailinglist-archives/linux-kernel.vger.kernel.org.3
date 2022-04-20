Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD45508517
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377274AbiDTJkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377251AbiDTJkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:40:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1E31FA67;
        Wed, 20 Apr 2022 02:37:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y32so1799633lfa.6;
        Wed, 20 Apr 2022 02:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/dU/bSf14Ab0tI91k2QUnJHgk7X/oBAW24Zh119x0JA=;
        b=CZhMJwu+Rio3vopC8VebZ/RpGlpwRoRMm4PIwCULt6GMid1iOPf6IlJKhPJHZ7Wtdw
         hWsTJtpUL2eBa74Hy9vXQ+qLoVtz5Fi6lUVOJnnCAIvPQiMtv4OTjKk2zkza+GOD5fYv
         NgKxigstSf1f1r4qW6JK+aioKUZ3Up5UepwhoI457giEtDm6BsbPW0rYW7qVZxIxFFcE
         H5FKbxfDp71xdPufUks2gm27zVNPIbQ5xOa4rsfU0lEg4zqgK3Ah5th9X483FtVK6v1e
         E18nSli9jhtIOwFBnG2iIM2C+fjkR4I3S0wNcvKJN33ujsqOSm/pNt6X94O7djxS3Us+
         637Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/dU/bSf14Ab0tI91k2QUnJHgk7X/oBAW24Zh119x0JA=;
        b=FaYD9lX/Z+BGAjfPLi9ZzRMpEjxL0upmta19w3Uxqhq6ctyCUDf1gsga3mQJn5e1+8
         46yDZaxv/lHmv2eN5tukQnW3MykKVkTXqZQGtMqBOuGOGHKzlVPrKVp1XPS9jGC2ZO3c
         3tgDne/9JkCbc0Juv+9plsCT5GfHV00ZRLQcfzWqvpCbvK4WahoXtgyUnGT1Zm8UsafT
         tGlcg14vXkcKMjkl3sLY1eUu0SDNEoChmQAhMB1+RdUPEJCYgBBZEgpwQdNiUI91TiTR
         ++xEcuaViX0Kj8yBTYKuFm6eq2ynPJoHjZphiYwQBXplUONp6lwY/wMxpdrdWcw8SleR
         L62A==
X-Gm-Message-State: AOAM532s6o0lGO/ZBUonX6r0q1YtqgNT5PBIaspkhCXlu0zdp5+dA44E
        oXhaJpoEL1asAEcSRVzTZ1A=
X-Google-Smtp-Source: ABdhPJxhvFXJOYE0tC6ZGWr00v7QPGQRjzrOmTMqFJNceph36/W5kQRjur4kXv7SalDSDqysYpzFDg==
X-Received: by 2002:a05:6512:3d8e:b0:471:b4d4:32f with SMTP id k14-20020a0565123d8e00b00471b4d4032fmr2898742lfv.288.1650447451188;
        Wed, 20 Apr 2022 02:37:31 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id s30-20020a195e1e000000b00471b420e06csm271055lfb.250.2022.04.20.02.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:37:30 -0700 (PDT)
Date:   Wed, 20 Apr 2022 12:37:28 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Schspa Shi <schspa@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>, brgl@bgdev.pl,
        andy.shevchenko@gmail.com, linus.walleij@linaro.org,
        f.fainelli@gmail.com, hoan@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com
Subject: Re: [PATCH v3] gpio: use raw spinlock for gpio chip shadowed data
Message-ID: <20220420093728.yzsiozkwdjn3jbbc@mobilestation>
References: <CAMRc=Meo4TbdxQzynb7paDgC7J19Tc6hhKU7du4mZvgP0mynTQ@mail.gmail.com>
 <20220419012810.88417-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220419012810.88417-1-schspa@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 09:28:10AM +0800, Schspa Shi wrote:
> In case of PREEMPT_RT, there is a raw_spinlock -> spinlock dependency
> as the lockdep report shows.
> 
> __irq_set_handler
>   irq_get_desc_buslock
>     __irq_get_desc_lock
>       raw_spin_lock_irqsave(&desc->lock, *flags);  // raw spinlock get here
>   __irq_do_set_handler
>     mask_ack_irq
>       dwapb_irq_ack
>         spin_lock_irqsave(&gc->bgpio_lock, flags); // sleep able spinlock
>   irq_put_desc_busunlock
> 
> Replace with a raw lock to avoid BUGs. This lock is only used to access
> registers, and It's safe to replace with the raw lock without bad
> influence.
> 
> [   15.090359][    T1] =============================
> [   15.090365][    T1] [ BUG: Invalid wait context ]
> [   15.090373][    T1] 5.10.59-rt52-00983-g186a6841c682-dirty #3 Not tainted
> [   15.090386][    T1] -----------------------------
> [   15.090392][    T1] swapper/0/1 is trying to lock:
> [   15.090402][    T1] 70ff00018507c188 (&gc->bgpio_lock){....}-{3:3}, at: _raw_spin_lock_irqsave+0x1c/0x28
> [   15.090470][    T1] other info that might help us debug this:
> [   15.090477][    T1] context-{5:5}
> [   15.090485][    T1] 3 locks held by swapper/0/1:
> [   15.090497][    T1]  #0: c2ff0001816de1a0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock+0x98/0x104
> [   15.090553][    T1]  #1: ffff90001485b4b8 (irq_domain_mutex){+.+.}-{4:4}, at: irq_domain_associate+0xbc/0x6d4
> [   15.090606][    T1]  #2: 4bff000185d7a8e0 (lock_class){....}-{2:2}, at: _raw_spin_lock_irqsave+0x1c/0x28
> [   15.090654][    T1] stack backtrace:
> [   15.090661][    T1] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.10.59-rt52-00983-g186a6841c682-dirty #3
> [   15.090682][    T1] Hardware name: Horizon Robotics Journey 5 DVB (DT)
> [   15.090692][    T1] Call trace:
> ......
> [   15.090811][    T1]  _raw_spin_lock_irqsave+0x1c/0x28
> [   15.090828][    T1]  dwapb_irq_ack+0xb4/0x300
> [   15.090846][    T1]  __irq_do_set_handler+0x494/0xb2c
> [   15.090864][    T1]  __irq_set_handler+0x74/0x114
> [   15.090881][    T1]  irq_set_chip_and_handler_name+0x44/0x58
> [   15.090900][    T1]  gpiochip_irq_map+0x210/0x644
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> 
> ---
> 
> Changelog:
> v1 -> v2:
>         - Reduce the useless stacktrace.
>         - Split to series of patches
> v2 -> v3:
>         - Restore to a single patch as Andy and Bartosz's suggest
>         - add cutter ‘--- ‘ line for Change log
> ---
>  drivers/gpio/gpio-amdpt.c                 | 10 +++----
>  drivers/gpio/gpio-brcmstb.c               | 12 ++++----
>  drivers/gpio/gpio-cadence.c               | 12 ++++----

>  drivers/gpio/gpio-dwapb.c                 | 36 +++++++++++------------

for the dwapb-gpio.c driver:
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

>  drivers/gpio/gpio-grgpio.c                | 30 +++++++++----------
>  drivers/gpio/gpio-hlwd.c                  | 18 ++++++------
>  drivers/gpio/gpio-idt3243x.c              | 12 ++++----
>  drivers/gpio/gpio-ixp4xx.c                |  4 +--
>  drivers/gpio/gpio-loongson1.c             |  8 ++---
>  drivers/gpio/gpio-menz127.c               |  8 ++---
>  drivers/gpio/gpio-mlxbf2.c                | 18 ++++++------
>  drivers/gpio/gpio-mmio.c                  | 22 +++++++-------
>  drivers/gpio/gpio-sifive.c                | 12 ++++----
>  drivers/gpio/gpio-tb10x.c                 |  4 +--
>  drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c |  8 ++---
>  include/linux/gpio/driver.h               |  2 +-
>  16 files changed, 108 insertions(+), 108 deletions(-)
> 

[...]

> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index b0f3aca61974..7130195da48d 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -243,9 +243,9 @@ static void dwapb_irq_ack(struct irq_data *d)
>  	u32 val = BIT(irqd_to_hwirq(d));
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&gc->bgpio_lock, flags);
> +	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
>  	dwapb_write(gpio, GPIO_PORTA_EOI, val);
> -	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> +	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>  }
>  
>  static void dwapb_irq_mask(struct irq_data *d)
> @@ -255,10 +255,10 @@ static void dwapb_irq_mask(struct irq_data *d)
>  	unsigned long flags;
>  	u32 val;
>  
> -	spin_lock_irqsave(&gc->bgpio_lock, flags);
> +	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
>  	val = dwapb_read(gpio, GPIO_INTMASK) | BIT(irqd_to_hwirq(d));
>  	dwapb_write(gpio, GPIO_INTMASK, val);
> -	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> +	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>  }
>  
>  static void dwapb_irq_unmask(struct irq_data *d)
> @@ -268,10 +268,10 @@ static void dwapb_irq_unmask(struct irq_data *d)
>  	unsigned long flags;
>  	u32 val;
>  
> -	spin_lock_irqsave(&gc->bgpio_lock, flags);
> +	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
>  	val = dwapb_read(gpio, GPIO_INTMASK) & ~BIT(irqd_to_hwirq(d));
>  	dwapb_write(gpio, GPIO_INTMASK, val);
> -	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> +	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>  }
>  
>  static void dwapb_irq_enable(struct irq_data *d)
> @@ -281,11 +281,11 @@ static void dwapb_irq_enable(struct irq_data *d)
>  	unsigned long flags;
>  	u32 val;
>  
> -	spin_lock_irqsave(&gc->bgpio_lock, flags);
> +	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
>  	val = dwapb_read(gpio, GPIO_INTEN);
>  	val |= BIT(irqd_to_hwirq(d));
>  	dwapb_write(gpio, GPIO_INTEN, val);
> -	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> +	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>  }
>  
>  static void dwapb_irq_disable(struct irq_data *d)
> @@ -295,11 +295,11 @@ static void dwapb_irq_disable(struct irq_data *d)
>  	unsigned long flags;
>  	u32 val;
>  
> -	spin_lock_irqsave(&gc->bgpio_lock, flags);
> +	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
>  	val = dwapb_read(gpio, GPIO_INTEN);
>  	val &= ~BIT(irqd_to_hwirq(d));
>  	dwapb_write(gpio, GPIO_INTEN, val);
> -	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> +	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>  }
>  
>  static int dwapb_irq_set_type(struct irq_data *d, u32 type)
> @@ -309,7 +309,7 @@ static int dwapb_irq_set_type(struct irq_data *d, u32 type)
>  	irq_hw_number_t bit = irqd_to_hwirq(d);
>  	unsigned long level, polarity, flags;
>  
> -	spin_lock_irqsave(&gc->bgpio_lock, flags);
> +	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
>  	level = dwapb_read(gpio, GPIO_INTTYPE_LEVEL);
>  	polarity = dwapb_read(gpio, GPIO_INT_POLARITY);
>  
> @@ -344,7 +344,7 @@ static int dwapb_irq_set_type(struct irq_data *d, u32 type)
>  	dwapb_write(gpio, GPIO_INTTYPE_LEVEL, level);
>  	if (type != IRQ_TYPE_EDGE_BOTH)
>  		dwapb_write(gpio, GPIO_INT_POLARITY, polarity);
> -	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> +	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>  
>  	return 0;
>  }
> @@ -374,7 +374,7 @@ static int dwapb_gpio_set_debounce(struct gpio_chip *gc,
>  	unsigned long flags, val_deb;
>  	unsigned long mask = BIT(offset);
>  
> -	spin_lock_irqsave(&gc->bgpio_lock, flags);
> +	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
>  
>  	val_deb = dwapb_read(gpio, GPIO_PORTA_DEBOUNCE);
>  	if (debounce)
> @@ -383,7 +383,7 @@ static int dwapb_gpio_set_debounce(struct gpio_chip *gc,
>  		val_deb &= ~mask;
>  	dwapb_write(gpio, GPIO_PORTA_DEBOUNCE, val_deb);
>  
> -	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> +	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>  
>  	return 0;
>  }
> @@ -738,7 +738,7 @@ static int dwapb_gpio_suspend(struct device *dev)
>  	unsigned long flags;
>  	int i;
>  
> -	spin_lock_irqsave(&gc->bgpio_lock, flags);
> +	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
>  	for (i = 0; i < gpio->nr_ports; i++) {
>  		unsigned int offset;
>  		unsigned int idx = gpio->ports[i].idx;
> @@ -765,7 +765,7 @@ static int dwapb_gpio_suspend(struct device *dev)
>  			dwapb_write(gpio, GPIO_INTMASK, ~ctx->wake_en);
>  		}
>  	}
> -	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> +	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>  
>  	clk_bulk_disable_unprepare(DWAPB_NR_CLOCKS, gpio->clks);
>  
> @@ -785,7 +785,7 @@ static int dwapb_gpio_resume(struct device *dev)
>  		return err;
>  	}
>  
> -	spin_lock_irqsave(&gc->bgpio_lock, flags);
> +	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
>  	for (i = 0; i < gpio->nr_ports; i++) {
>  		unsigned int offset;
>  		unsigned int idx = gpio->ports[i].idx;
> @@ -812,7 +812,7 @@ static int dwapb_gpio_resume(struct device *dev)
>  			dwapb_write(gpio, GPIO_PORTA_EOI, 0xffffffff);
>  		}
>  	}
> -	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> +	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
>  
>  	return 0;
>  }

[...]

