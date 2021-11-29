Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15493462235
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhK2U36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbhK2UZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:25:59 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC23C025443
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:02:57 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o13so38198419wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z003iAfd5DmRdeNMD4pYCdDSVh44TQ96BcYcHSpw8t0=;
        b=nGUdmCJAmeuhJB83LSa/zUip3YbHx0RT190f3qVw/iP7eXKNEx+ATgrxX8Rx0usBBc
         17YThq0uvSCxxmMVmQB7/31iKVD3xvQO/SaNDkLtwBc9zK83aJmjDv14nH66tdsvpJqP
         Q8uRzqnKoC1LXM4yBl1idtYuOULVdCN+vGjgd+3uFBRdI6I2UPV14VF65NB3LzP1bG/h
         N033VQ6sQ5RNLY8MuyMvKOZbGSO/GQxIZ1l58EorImieNimtF/BJyxrc2zVlBgyVlOYo
         mWNhRhHT8bNf0G2PXq/0ptL0s4ebM28Fi277EvhrYfvQqe5U3GuwQOKHWmTEVESgayHr
         mySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z003iAfd5DmRdeNMD4pYCdDSVh44TQ96BcYcHSpw8t0=;
        b=BMgAM5W6Oe4uFHAnDm8uJhQm4gIdTpBaS+VerysbwN3HAaj9AlLebV8bXBy5z3R/k3
         EnPOQ892Cd107rD8gzapz6cE9TKGZXvo0YMpEcet0JL8TelJddrBtvjmX+WhTqwc1Q6d
         +LDj93CdzbaG6BtQMQix++oP8wKGxcebavOETdxIGmjsrtjAg4nnUCv0XvdQ1wanZdhK
         pquSKK7qMOldhdKZDit4KK1oeVcKsvM+xhAiD4fTnHDDBJs22q+HnP0zfd9vwcgq/tMO
         y4bDJeqiGJ9Rf+3dtr9oVCiMbX4aA42SFJk3TXwmLwJqkIm9FQuxCNgW0OIZ4FA9iLSJ
         WYuA==
X-Gm-Message-State: AOAM532uM/La8u5n2e/LnDwuWDZZ2crh25OPgkGa9IpW3r9EmfslHZV3
        /lMHkQkMkOUaSlNP4e7EIhKle6zwKxzNww==
X-Google-Smtp-Source: ABdhPJzZ4z4VPUpkBiOV8u5UNp2SJhiMx34cu9Ze1zo0PAMcM2c8Hfyc1mrXcNgI4wIblKuAiA+7ew==
X-Received: by 2002:a5d:6508:: with SMTP id x8mr34679736wru.388.1638205375752;
        Mon, 29 Nov 2021 09:02:55 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:7880:daae:2d50:bb5e? ([2a01:e34:ed2f:f020:7880:daae:2d50:bb5e])
        by smtp.googlemail.com with ESMTPSA id s8sm14366917wro.19.2021.11.29.09.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 09:02:55 -0800 (PST)
Subject: Re: [PATCH 1/5] clocksource: Add MStar MSC313e timer support
To:     Romain Perier <romain.perier@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211126202144.72936-1-romain.perier@gmail.com>
 <20211126202144.72936-2-romain.perier@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6cf881ea-1761-b3b2-5d0d-9a83595c1246@linaro.org>
Date:   Mon, 29 Nov 2021 18:02:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211126202144.72936-2-romain.perier@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2021 21:21, Romain Perier wrote:
> The MSC313e-compatible SoCs have 3 timer hardware blocks. All of these
> are free running 32-bit increasing counters and can generate interrupts.
> This commit adds basic support for these timers, the first timer block
> being used as clocksource/sched_clock and delay, while the others will
> be used as clockevents.

Please you elaborate a bit more the internals of this timer as it is a
initial submission


> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> Co-developed-by: Daniel Palmer <daniel@0x0f.com>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/clocksource/Kconfig         |  10 ++
>  drivers/clocksource/Makefile        |   1 +
>  drivers/clocksource/timer-msc313e.c | 228 ++++++++++++++++++++++++++++
>  4 files changed, 240 insertions(+)
>  create mode 100644 drivers/clocksource/timer-msc313e.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a2345ce8521..f39a1617bf50 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2282,6 +2282,7 @@ F:	Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
>  F:	arch/arm/boot/dts/mstar-*
>  F:	arch/arm/mach-mstar/
>  F:	drivers/clk/mstar/
> +F:	drivers/clocksource/timer-msc313e.c
>  F:	drivers/gpio/gpio-msc313.c
>  F:	drivers/rtc/rtc-msc313.c
>  F:	drivers/watchdog/msc313e_wdt.c
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index f65e31bab9ae..822e711da284 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -671,6 +671,16 @@ config MILBEAUT_TIMER
>  	help
>  	  Enables the support for Milbeaut timer driver.
>  
> +config MSC313E_TIMER
> +	bool "MSC313E timer driver"

Silent option please and platform config option enables it.

> +	depends on ARCH_MSTARV7 || COMPILE_TEST
> +	select TIMER_OF
> +	select CLKSRC_MMIO
> +	help
> +	  Enables support for the MStar MSC313E timer driver.
> +	  This provides access to multiple interrupt generating
> +	  programmable 32-bit free running incrementing counters.
> +
>  config INGENIC_TIMER
>  	bool "Clocksource/timer using the TCU in Ingenic JZ SoCs"
>  	default MACH_INGENIC
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index c17ee32a7151..fa5f624eadb6 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
>  obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
>  obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
>  obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
> +obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
> diff --git a/drivers/clocksource/timer-msc313e.c b/drivers/clocksource/timer-msc313e.c
> new file mode 100644
> index 000000000000..81f161744349
> --- /dev/null
> +++ b/drivers/clocksource/timer-msc313e.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MStar timer driver
> + *
> + * Copyright (C) 2021 Daniel Palmer
> + * Copyright (C) 2021 Romain Perier
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqreturn.h>
> +#include <linux/sched_clock.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/delay.h>
> +
> +#include "timer-of.h"
> +
> +#define TIMER_NAME "msc313e_timer"
> +
> +#define MSC313E_REG_CTRL		0x00
> +#define MSC313E_REG_CTRL_TIMER_EN	BIT(0)
> +#define MSC313E_REG_CTRL_TIMER_TRIG	BIT(1)
> +#define MSC313E_REG_CTRL_TIMER_INT_EN	BIT(8)
> +#define MSC313E_REG_TIMER_MAX_LOW	0x08
> +#define MSC313E_REG_TIMER_MAX_HIGH	0x0c
> +#define MSC313E_REG_COUNTER_LOW		0x10
> +#define MSC313E_REG_COUNTER_HIGH	0x14
> +
> +#define TIMER_SYNC_TICKS		3
> +
> +struct msc313e_delay {
> +	void __iomem *base;
> +	struct delay_timer delay;
> +};
> +
> +static void __iomem *msc313e_clksrc;
> +static struct msc313e_delay msc313e_delay;

I'm not sure that compiles on other platform than mstarv7

> +static void msc313e_timer_stop(void __iomem *base)
> +{
> +	writew(0, base + MSC313E_REG_CTRL);
> +}
> +
> +static void msc313e_timer_start(void __iomem *base, bool periodic)
> +{
> +	u16 reg;
> +
> +	reg = readw(base + MSC313E_REG_CTRL);
> +	if (periodic)
> +		reg |= MSC313E_REG_CTRL_TIMER_EN;
> +	else
> +		reg |= MSC313E_REG_CTRL_TIMER_TRIG;
> +	writew(reg | MSC313E_REG_CTRL_TIMER_INT_EN, base + MSC313E_REG_CTRL);
> +}
> +
> +static void msc313e_timer_setup(void __iomem *base, unsigned long delay)
> +{
> +	writew(delay >> 16, base + MSC313E_REG_TIMER_MAX_HIGH);
> +	writew(delay & 0xffff, base + MSC313E_REG_TIMER_MAX_LOW);

Is it safe? (eg. arc_timer.c?)

> +}
> +
> +static unsigned long msc313e_timer_current_value(void __iomem *base)
> +{
> +	unsigned long result;
> +
> +	result = readw(base + MSC313E_REG_COUNTER_LOW);
> +	result |= readw(base + MSC313E_REG_COUNTER_HIGH) << 16;

Is it safe?

cf. timer-microchip-pit64b.c and/or arc_timer.c

> +	return result;
> +}
> +
> +static int msc313e_timer_clkevt_shutdown(struct clock_event_device *evt)
> +{
> +	struct timer_of *timer = to_timer_of(evt);
> +
> +	msc313e_timer_stop(timer_of_base(timer));
> +
> +	return 0;
> +}
> +
> +static int msc313e_timer_clkevt_set_oneshot(struct clock_event_device *evt)
> +{
> +	struct timer_of *timer = to_timer_of(evt);
> +
> +	msc313e_timer_stop(timer_of_base(timer));
> +	msc313e_timer_start(timer_of_base(timer), false);
> +
> +	return 0;
> +}
> +
> +static int msc313e_timer_clkevt_set_periodic(struct clock_event_device *evt)
> +{
> +	struct timer_of *timer = to_timer_of(evt);
> +
> +	msc313e_timer_stop(timer_of_base(timer));
> +	msc313e_timer_setup(timer_of_base(timer), timer_of_period(timer));
> +	msc313e_timer_start(timer_of_base(timer), true);
> +
> +	return 0;
> +}
> +
> +static int msc313e_timer_clkevt_next_event(unsigned long evt, struct clock_event_device *clkevt)
> +{
> +	struct timer_of *timer = to_timer_of(clkevt);
> +
> +	msc313e_timer_stop(timer_of_base(timer));
> +	msc313e_timer_setup(timer_of_base(timer), evt);
> +	msc313e_timer_start(timer_of_base(timer), false);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t msc313e_timer_clkevt_irq(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = dev_id;
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static u64 msc313e_timer_clksrc_read(struct clocksource *cs)
> +{
> +	return msc313e_timer_current_value(msc313e_clksrc) & cs->mask;
> +}
> +
> +static unsigned long msc313e_read_delay_timer_read(void)
> +{
> +	return msc313e_timer_current_value(msc313e_delay.base);
> +}
> +
> +static u64 msc313e_timer_sched_clock_read(void)
> +{
> +	return msc313e_timer_current_value(msc313e_clksrc);
> +}
> +
> +static struct clock_event_device msc313e_clkevt = {
> +	.name = TIMER_NAME,
> +	.rating = 300,
> +	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> +	.set_state_shutdown = msc313e_timer_clkevt_shutdown,
> +	.set_state_periodic = msc313e_timer_clkevt_set_periodic,
> +	.set_state_oneshot = msc313e_timer_clkevt_set_oneshot,
> +	.tick_resume = msc313e_timer_clkevt_shutdown,
> +	.set_next_event = msc313e_timer_clkevt_next_event,
> +};
> +
> +static int __init msc313e_clkevt_init(struct device_node *np)
> +{
> +	int ret;
> +	struct timer_of *to;
> +
> +	to = kzalloc(sizeof(*to), GFP_KERNEL);
> +	if (!to)
> +		return -ENOMEM;
> +
> +	to->flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE;
> +	to->of_irq.handler = msc313e_timer_clkevt_irq;
> +	ret = timer_of_init(np, to);
> +	if (ret)
> +		return ret;
> +
> +	msc313e_clkevt.cpumask = cpu_possible_mask;
> +	msc313e_clkevt.irq = to->of_irq.irq;
> +	to->clkevt = msc313e_clkevt;
> +
> +	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
> +					TIMER_SYNC_TICKS, 0xffffffff);
> +	return 0;
> +}
> +
> +static int __init msc313e_clksrc_init(struct device_node *np)
> +{
> +	struct timer_of to = { 0 };
> +	int ret;
> +	u16 reg;
> +
> +	to.flags = TIMER_OF_BASE | TIMER_OF_CLOCK;
> +	ret = timer_of_init(np, &to);
> +	if (ret)
> +		return ret;
> +
> +	msc313e_delay.base = timer_of_base(&to);
> +	msc313e_delay.delay.read_current_timer = msc313e_read_delay_timer_read;
> +	msc313e_delay.delay.freq = timer_of_rate(&to);
> +
> +	msc313e_clksrc = timer_of_base(&to);
> +	reg = readw(msc313e_clksrc + MSC313E_REG_CTRL);
> +	reg |= MSC313E_REG_CTRL_TIMER_EN;
> +	writew(reg, msc313e_clksrc + MSC313E_REG_CTRL);
> +
> +	register_current_timer_delay(&msc313e_delay.delay);
> +
> +	sched_clock_register(msc313e_timer_sched_clock_read, 32, timer_of_rate(&to));
> +	return clocksource_mmio_init(timer_of_base(&to), TIMER_NAME, timer_of_rate(&to), 300, 32,
> +				     msc313e_timer_clksrc_read);

format 80char max please, run checkpatch.pl before submitting

> +}
> +
> +static int __init msc313e_timer_init(struct device_node *np)
> +{
> +	int ret = 0;
> +	static int num_called;
> +
> +	switch (num_called) {
> +	case 0:
> +		ret = msc313e_clksrc_init(np);
> +		if (ret)
> +			return ret;
> +		break;
> +
> +	default:
> +		ret = msc313e_clkevt_init(np);
> +		if (ret)
> +			return ret;
> +		break;
> +	}
> +
> +	num_called++;
> +
> +	return 0;
> +}
> +
> +TIMER_OF_DECLARE(msc313, "mstar,msc313e-timer", msc313e_timer_init);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
