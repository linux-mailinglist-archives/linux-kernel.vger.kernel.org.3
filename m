Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E5949C921
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbiAZLzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240980AbiAZLzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:55:09 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AA4C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:55:09 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u15so25352573wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tBmW+lf5byWZ0u+U5OEU+LMX56w9NigfX147OiJk/D8=;
        b=f2/mYBa+dVpZHYUPSmX5Gag7yLz+R6kfTaUXW4qorKA4kQfJ5eMiDGrO63ZBPtNpmg
         2Ep7cLleDYazkXetpR8xqQ6AMN14Rms7mYKT+7/3LSJC/7koA5SfGETnu0K3UcrERDv9
         t1QsN9DYjXiJ5VQxTVwA5ft2O7C4EXctMWg2fp3gxmaVZw1LdFA+z9e5bcjMl1AaYN0Z
         u/uFXgTweYYeVKDAAuJh5Qc9pL7yV61Xoyry5XX4TKKWJ/KzoXHlxTmys6IGiVKvZWpm
         MbytUnT7mxn+8tFMiak0sEvHsg70zCubRB5AMavB6F7xLdSUW7tbo2v11LMrIymtOdlJ
         6vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tBmW+lf5byWZ0u+U5OEU+LMX56w9NigfX147OiJk/D8=;
        b=H6tnnQ9/uXHqAMGDicuRi6Gx9FybMgCvY8dVDL7OSJ/XRy7sJPM5cM8+fYBHCLJQ11
         3STsvww0ABaixjFhxBWjwFMHfji6EYGaxx1CsbOsfqo6lJOXCYj8EFABNNqZw2FqWfSl
         CO+AcAcE0OcpojpTZi0x7R0jscl2kfHUKR+/lNBLq3i98/lJSCMUlXoBvWc4AGwW8V+k
         P2ZUM9noqjT+/ZXXOygLZA0Lu4pTE7wj216sCvrCe+Iu/ak8yeEUTw6YOK+dIF7+jni+
         bBSV6LksxAOuxxss2My5tV4SZ7avRNM/PyzncOp3Nk4CzwwDHNzXg+pdA6BRVIggQrw+
         IBQA==
X-Gm-Message-State: AOAM532JZoUEFpN6A6cEwtJbYWt8uBehdGoMegYKq0Sk63HQtWN54ARP
        mFtjmSuuUMOR6eQr5rN3A+VHTw==
X-Google-Smtp-Source: ABdhPJw8a6ZDUNQCZHxJTuq1gtX12UjzYr2PXHJ0h8XT9a1SYM8xoZkQmSHgyEFEvZjFixxk8koZkw==
X-Received: by 2002:a5d:47cb:: with SMTP id o11mr8276220wrc.704.1643198107569;
        Wed, 26 Jan 2022 03:55:07 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e? ([2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e])
        by smtp.googlemail.com with ESMTPSA id f6sm19121939wrj.26.2022.01.26.03.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 03:55:06 -0800 (PST)
Subject: Re: [PATCH v12 4/5] clocksource/drivers: Add a goldfish-timer
 clocksource
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>
References: <20220121200738.2577697-1-laurent@vivier.eu>
 <20220121200738.2577697-5-laurent@vivier.eu>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2dc495b0-b9a1-e493-ddeb-d966afd624c0@linaro.org>
Date:   Wed, 26 Jan 2022 12:55:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220121200738.2577697-5-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Laurent,

On 21/01/2022 21:07, Laurent Vivier wrote:
> Add a clocksource based on the goldfish-rtc device.

As a first submission, please provide a more detailed description of the
timer.

> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  drivers/clocksource/Kconfig          |   7 ++
>  drivers/clocksource/Makefile         |   1 +
>  drivers/clocksource/timer-goldfish.c | 163 +++++++++++++++++++++++++++
>  include/clocksource/timer-goldfish.h |  11 ++
>  4 files changed, 182 insertions(+)
>  create mode 100644 drivers/clocksource/timer-goldfish.c
>  create mode 100644 include/clocksource/timer-goldfish.h
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index cfb8ea0df3b1..94f00374cebb 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -721,4 +721,11 @@ config MICROCHIP_PIT64B
>  	  modes and high resolution. It is used as a clocksource
>  	  and a clockevent.
>  
> +config GOLDFISH_TIMER
> +	bool "Clocksource using goldfish-rtc"
> +	depends on M68K || COMPILE_TEST
> +	depends on RTC_DRV_GOLDFISH
> +	help
> +	  Support for the timer/counter of goldfish-rtc
> +
>  endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index fa5f624eadb6..12f5d7e8cc2d 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -89,3 +89,4 @@ obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
>  obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
>  obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
>  obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
> +obj-$(CONFIG_GOLDFISH_TIMER)		+= timer-goldfish.o
> diff --git a/drivers/clocksource/timer-goldfish.c b/drivers/clocksource/timer-goldfish.c
> new file mode 100644
> index 000000000000..4c670a1aea16
> --- /dev/null
> +++ b/drivers/clocksource/timer-goldfish.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <linux/clocksource.h>
> +#include <linux/clockchips.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/goldfish.h>
> +#include <clocksource/timer-goldfish.h>
> +
> +#define TIMER_TIME_LOW		0x00	/* get low bits of current time  */
> +					/*   and update TIMER_TIME_HIGH  */
> +#define TIMER_TIME_HIGH		0x04	/* get high bits of time at last */
> +					/*   TIMER_TIME_LOW read         */
> +#define TIMER_ALARM_LOW		0x08	/* set low bits of alarm and     */
> +					/*   activate it                 */
> +#define TIMER_ALARM_HIGH	0x0c	/* set high bits of next alarm   */

Thanks for the comments giving the update details of the register.
However the format is not very easy to read. I suggest to add these
information in the log or above the macros being a bit more verbose

/*
 * bla bla
 */

> +#define TIMER_IRQ_ENABLED	0x10
> +#define TIMER_CLEAR_ALARM	0x14
> +#define TIMER_ALARM_STATUS	0x18
> +#define TIMER_CLEAR_INTERRUPT	0x1c
> +
> +struct goldfish_timer {
> +	struct clocksource cs;
> +	struct clock_event_device ced;
> +	struct resource res;
> +	void __iomem *base;
> +	int irq;

'res' and 'irq' can be local variable in the init function, they are not
used anywhere else

> +};
> +
> +static struct goldfish_timer *ced_to_gf(struct clock_event_device *ced)
> +{
> +	return container_of(ced, struct goldfish_timer, ced);
> +}
> +
> +static struct goldfish_timer *cs_to_gf(struct clocksource *cs)
> +{
> +	return container_of(cs, struct goldfish_timer, cs);
> +}
> +
> +static u64 goldfish_timer_read(struct clocksource *cs)
> +{
> +	struct goldfish_timer *timerdrv = cs_to_gf(cs);
> +	void __iomem *base = timerdrv->base;
> +	u32 time_low, time_high;
> +	u64 ticks;
> +
> +	/*
> +	 * time_low: get low bits of current time and update time_high
> +	 * time_high: get high bits of time at last time_low read
> +	 */
> +	time_low = gf_ioread32(base + TIMER_TIME_LOW);
> +	time_high = gf_ioread32(base + TIMER_TIME_HIGH);
> +
> +	ticks = ((u64)time_high << 32) | time_low;
> +
> +	return ticks;
> +}
> +
> +static int goldfish_timer_set_oneshot(struct clock_event_device *evt)
> +{
> +	struct goldfish_timer *timerdrv = ced_to_gf(evt);
> +	void __iomem *base = timerdrv->base;
> +
> +	gf_iowrite32(0, base + TIMER_ALARM_HIGH);
> +	gf_iowrite32(0, base + TIMER_ALARM_LOW);
> +	gf_iowrite32(1, base + TIMER_IRQ_ENABLED);
> +
> +	return 0;
> +}
> +
> +static int goldfish_timer_shutdown(struct clock_event_device *evt)
> +{
> +	struct goldfish_timer *timerdrv = ced_to_gf(evt);
> +	void __iomem *base = timerdrv->base;
> +
> +	gf_iowrite32(0, base + TIMER_IRQ_ENABLED);
> +
> +	return 0;
> +}
> +
> +static int goldfish_timer_next_event(unsigned long delta,
> +				     struct clock_event_device *evt)
> +{
> +	struct goldfish_timer *timerdrv = ced_to_gf(evt);
> +	void __iomem *base = timerdrv->base;
> +	u64 now;
> +
> +	now = goldfish_timer_read(&timerdrv->cs);
> +
> +	now += delta;
> +
> +	gf_iowrite32(upper_32_bits(now), base + TIMER_ALARM_HIGH);
> +	gf_iowrite32(lower_32_bits(now), base + TIMER_ALARM_LOW);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t golfish_timer_tick(int irq, void *dev_id)

"timer_tick" will be confusing with "scheduler timer tick". Please
rename it to (eg. goldfish_timer_irq)

Note: the function name 'golfish' instead of 'goldfish'

> +{
> +	struct clock_event_device *evt = dev_id;
> +	struct goldfish_timer *timerdrv = ced_to_gf(evt);
> +	void __iomem *base = timerdrv->base;
> +
> +	gf_iowrite32(1, base + TIMER_CLEAR_INTERRUPT);
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +void __init goldfish_timer_init(int irq, void __iomem *base)

Error handling please

int __init goldfish_timer_init(...)

> +{
> +	struct goldfish_timer *timerdrv;
> +	int ret;
> +
> +	timerdrv = kzalloc(sizeof(*timerdrv), GFP_KERNEL);
> +	if (!timerdrv)
> +		return;
> +
> +	timerdrv->base = base;
> +	timerdrv->irq = irq;

Not needed

> +	timerdrv->ced = (struct clock_event_device){
> +		.name			= "goldfish_timer",
> +		.features		= CLOCK_EVT_FEAT_ONESHOT,
> +		.set_state_shutdown	= goldfish_timer_shutdown,
> +		.set_state_oneshot      = goldfish_timer_set_oneshot,
> +		.set_next_event		= goldfish_timer_next_event,
> +	};

nit: add CR

> +	timerdrv->res = (struct resource){
> +		.name  = "goldfish_timer",
> +		.start = (unsigned long)base,
> +		.end   = (unsigned long)base + 0xfff,
> +	};

Could be a local variable, no?

> +	if (request_resource(&iomem_resource, &timerdrv->res)) {
> +		pr_err("Cannot allocate goldfish-timer resource\n");

nit: pr_err("Cannot allocate '%s' resource\n", res.name);

> +		return;
> +	}
> +
> +	timerdrv->cs = (struct clocksource){
> +		.name		= "goldfish_timer",
> +		.rating		= 400,
> +		.read		= goldfish_timer_read,
> +		.mask		= CLOCKSOURCE_MASK(64),
> +		.flags		= 0,
> +		.max_idle_ns	= LONG_MAX,
> +	};
> +
> +	clocksource_register_hz(&timerdrv->cs, NSEC_PER_SEC);
> +
> +	ret = request_irq(timerdrv->irq, golfish_timer_tick, IRQF_TIMER,
> +			  "goldfish_timer", &timerdrv->ced);

Why not pass directly 'timerdrv' ?

> +	if (ret) {
> +		pr_err("Couldn't register goldfish-timer interrupt\n");
> +		return;
> +	}
> +
> +	clockevents_config_and_register(&timerdrv->ced, NSEC_PER_SEC,
> +					1, 0xffffffff);
> +}
> diff --git a/include/clocksource/timer-goldfish.h b/include/clocksource/timer-goldfish.h
> new file mode 100644
> index 000000000000..b237267844f1
> --- /dev/null
> +++ b/include/clocksource/timer-goldfish.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * goldfish-timer clocksource
> + */
> +
> +#ifndef _CLOCKSOURCE_GOLDFISH_TIMER_H
> +#define _CLOCKSOURCE_GOLDFISH_TIMER_H
> +
> +extern void goldfish_timer_init(int irq, void __iomem *base);
> +
> +#endif /* _CLOCKSOURCE_GOLDFISH_TIMER_H */
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
