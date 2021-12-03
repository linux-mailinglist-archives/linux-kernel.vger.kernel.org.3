Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9664C4678CC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381293AbhLCNxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381209AbhLCNxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:53:33 -0500
X-Greylist: delayed 90720 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Dec 2021 05:50:09 PST
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CADEC06174A;
        Fri,  3 Dec 2021 05:50:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id BE0EC41E96;
        Fri,  3 Dec 2021 13:50:04 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] watchdog: Add Apple SoC watchdog driver
To:     Guenter Roeck <linux@roeck-us.net>,
        Sven Peter <sven@svenpeter.dev>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Janne Grunau <j@jannau.net>
References: <20211130161809.64591-1-sven@svenpeter.dev>
 <20211130161809.64591-2-sven@svenpeter.dev>
 <6CD6E96A-CE02-4D59-9654-1AACF9E2CC0B@marcan.st>
 <1d3abc70-dce3-68c7-662f-63fdc269c1b7@roeck-us.net>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <cc911fd8-96d2-efac-6163-64592b95b669@marcan.st>
Date:   Fri, 3 Dec 2021 22:50:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1d3abc70-dce3-68c7-662f-63fdc269c1b7@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2021 23.36, Guenter Roeck wrote:
> On 12/1/21 10:44 PM, Hector Martin "marcan" wrote:
>>
>>
>> On 2021年12月1日 1:18:09 JST, Sven Peter <sven@svenpeter.dev> wrote:
>>> Add support for the watchdog timer found in Apple SoCs. This driver is
>>> also required to reboot these machines.
>>>
>>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>>> ---
>>> v1 -> v2:
>>> - set the default timeout to 30s and call watchdog_init_timeout
>>>     to allow the device tree to override it
>>> - set WDOG_HW_RUNNING if the watchdog is enabled at boot
>>> - check that the clock rate is not zero
>>> - use unsigned long instead of u32 for clk_rate
>>> - use devm_add_action_or_reset instead of manually calling
>>>     clk_disable_unprepare
>>> - explain the magic number in apple_wdt_restart
>>>
>>> MAINTAINERS                  |   1 +
>>> drivers/watchdog/Kconfig     |  12 ++
>>> drivers/watchdog/Makefile    |   1 +
>>> drivers/watchdog/apple_wdt.c | 226 +++++++++++++++++++++++++++++++++++
>>> 4 files changed, 240 insertions(+)
>>> create mode 100644 drivers/watchdog/apple_wdt.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 859201bbd4e8..6190f0b40983 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1757,6 +1757,7 @@ F:	drivers/i2c/busses/i2c-pasemi-platform.c
>>> F:	drivers/irqchip/irq-apple-aic.c
>>> F:	drivers/mailbox/apple-mailbox.c
>>> F:	drivers/pinctrl/pinctrl-apple-gpio.c
>>> +F:	drivers/watchdog/apple_wdt.c
>>> F:	include/dt-bindings/interrupt-controller/apple-aic.h
>>> F:	include/dt-bindings/pinctrl/apple.h
>>> F:	include/linux/apple-mailbox.h
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index 9d222ba17ec6..170dec880c8f 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -976,6 +976,18 @@ config MSC313E_WATCHDOG
>>> 	  To compile this driver as a module, choose M here: the
>>> 	  module will be called msc313e_wdt.
>>>
>>> +config APPLE_WATCHDOG
>>> +	tristate "Apple SoC watchdog"
>>> +	depends on ARCH_APPLE || COMPILE_TEST
>>> +	select WATCHDOG_CORE
>>> +	help
>>> +	  Say Y here to include support for the Watchdog found in Apple
>>> +	  SoCs such as the M1. Next to the common watchdog features this
>>> +	  driver is also required in order to reboot these SoCs.
>>> +
>>> +	  To compile this driver as a module, choose M here: the
>>> +	  module will be called apple_wdt.
>>> +
>>> # X86 (i386 + ia64 + x86_64) Architecture
>>>
>>> config ACQUIRE_WDT
>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>> index 2ee97064145b..270a518bd8f3 100644
>>> --- a/drivers/watchdog/Makefile
>>> +++ b/drivers/watchdog/Makefile
>>> @@ -93,6 +93,7 @@ obj-$(CONFIG_PM8916_WATCHDOG) += pm8916_wdt.o
>>> obj-$(CONFIG_ARM_SMC_WATCHDOG) += arm_smc_wdt.o
>>> obj-$(CONFIG_VISCONTI_WATCHDOG) += visconti_wdt.o
>>> obj-$(CONFIG_MSC313E_WATCHDOG) += msc313e_wdt.o
>>> +obj-$(CONFIG_APPLE_WATCHDOG) += apple_wdt.o
>>>
>>> # X86 (i386 + ia64 + x86_64) Architecture
>>> obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
>>> diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
>>> new file mode 100644
>>> index 000000000000..76e5bedd50d1
>>> --- /dev/null
>>> +++ b/drivers/watchdog/apple_wdt.c
>>> @@ -0,0 +1,226 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>>> +/*
>>> + * Apple SoC Watchdog driver
>>> + *
>>> + * Copyright (C) The Asahi Linux Contributors
>>> + */
>>> +
>>> +#include <linux/bits.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/io.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/limits.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/watchdog.h>
>>> +
>>> +/*
>>> + * Apple Watchdog MMIO registers
>>> + *
>>> + * This HW block has three separate watchdogs. WD0 resets the machine
>>> + * to recovery mode and is not very useful for us. WD1 and WD2 trigger a normal
>>> + * machine reset. WD0 additionally supports a configurable interrupt.
>>> + * This information can be used to implement pretimeout support at a later time.
>>> + *
>>> + * APPLE_WDT_WDx_CUR_TIME is a simple counter incremented for each tick of the
>>> + * reference clock. It can also be overwritten to any value.
>>> + * Whenever APPLE_WDT_CTRL_RESET_EN is set in APPLE_WDT_WDx_CTRL and
>>> + * APPLE_WDTx_WD1_CUR_TIME >= APPLE_WDTx_WD1_BITE_TIME the entire machine is
>>> + * reset.
>>> + * Whenever APPLE_WDT_CTRL_IRQ_EN is set and APPLE_WDTx_WD1_CUR_TIME >=
>>> + * APPLE_WDTx_WD1_BARK_TIME an interrupt is triggered and
>>> + * APPLE_WDT_CTRL_IRQ_STATUS is set. The interrupt can be cleared by writing
>>> + * 1 to APPLE_WDT_CTRL_IRQ_STATUS.
>>> + */
>>> +#define APPLE_WDT_WD0_CUR_TIME		0x00
>>> +#define APPLE_WDT_WD0_BITE_TIME		0x04
>>> +#define APPLE_WDT_WD0_BARK_TIME		0x08
>>> +#define APPLE_WDT_WD0_CTRL		0x0c
>>> +
>>> +#define APPLE_WDT_WD1_CUR_TIME		0x10
>>> +#define APPLE_WDT_WD1_BITE_TIME		0x14
>>> +#define APPLE_WDT_WD1_CTRL		0x1c
>>> +
>>> +#define APPLE_WDT_WD2_CUR_TIME		0x20
>>> +#define APPLE_WDT_WD2_BITE_TIME		0x24
>>> +#define APPLE_WDT_WD2_CTRL		0x2c
>>> +
>>> +#define APPLE_WDT_CTRL_IRQ_EN		BIT(0)
>>> +#define APPLE_WDT_CTRL_IRQ_STATUS	BIT(1)
>>> +#define APPLE_WDT_CTRL_RESET_EN		BIT(2)
>>> +
>>> +#define APPLE_WDT_TIMEOUT_DEFAULT	30
>>> +
>>> +struct apple_wdt {
>>> +	struct watchdog_device wdd;
>>> +	void __iomem *regs;
>>> +	unsigned long clk_rate;
>>> +};
>>> +
>>> +static struct apple_wdt *to_apple_wdt(struct watchdog_device *wdd)
>>> +{
>>> +	return container_of(wdd, struct apple_wdt, wdd);
>>> +}
>>> +
>>> +static int apple_wdt_start(struct watchdog_device *wdd)
>>> +{
>>> +	struct apple_wdt *wdt = to_apple_wdt(wdd);
>>> +
>>> +	writel_relaxed(0, wdt->regs + APPLE_WDT_WD1_CUR_TIME);
>>> +	writel_relaxed(APPLE_WDT_CTRL_RESET_EN, wdt->regs + APPLE_WDT_WD1_CTRL);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int apple_wdt_stop(struct watchdog_device *wdd)
>>> +{
>>> +	struct apple_wdt *wdt = to_apple_wdt(wdd);
>>> +
>>> +	writel_relaxed(0, wdt->regs + APPLE_WDT_WD1_CTRL);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int apple_wdt_ping(struct watchdog_device *wdd)
>>> +{
>>> +	struct apple_wdt *wdt = to_apple_wdt(wdd);
>>> +
>>> +	writel_relaxed(0, wdt->regs + APPLE_WDT_WD1_CUR_TIME);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int apple_wdt_set_timeout(struct watchdog_device *wdd, unsigned int s)
>>> +{
>>> +	struct apple_wdt *wdt = to_apple_wdt(wdd);
>>> +
>>> +	writel_relaxed(0, wdt->regs + APPLE_WDT_WD1_CUR_TIME);
>>> +	writel_relaxed(wdt->clk_rate * s, wdt->regs + APPLE_WDT_WD1_BITE_TIME);
>>> +
>>> +	wdd->timeout = s;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static unsigned int apple_wdt_get_timeleft(struct watchdog_device *wdd)
>>> +{
>>> +	struct apple_wdt *wdt = to_apple_wdt(wdd);
>>> +	u32 cur_time, reset_time;
>>> +
>>> +	cur_time = readl_relaxed(wdt->regs + APPLE_WDT_WD1_CUR_TIME);
>>> +	reset_time = readl_relaxed(wdt->regs + APPLE_WDT_WD1_BITE_TIME);
>>> +
>>> +	return (reset_time - cur_time) / wdt->clk_rate;
>>> +}
>>> +
>>> +static int apple_wdt_restart(struct watchdog_device *wdd, unsigned long mode,
>>> +			     void *cmd)
>>> +{
>>> +	struct apple_wdt *wdt = to_apple_wdt(wdd);
>>> +
>>> +	writel_relaxed(APPLE_WDT_CTRL_RESET_EN, wdt->regs + APPLE_WDT_WD1_CTRL);
>>> +	writel_relaxed(0, wdt->regs + APPLE_WDT_WD1_BITE_TIME);
>>> +	writel_relaxed(0, wdt->regs + APPLE_WDT_WD1_CUR_TIME);
>>> +
>>> +	/*
>>> +	 * Flush writes and then wait for the SoC to reset. Even though the
>>> +	 * reset is queued almost immediately experiments have shown that it
>>> +	 * can take up to ~20-25ms until the SoC is actually reset. Just wait
>>> +	 * 50ms here to be safe.
>>> +	 */
>>> +	(void)readl_relaxed(wdt->regs + APPLE_WDT_WD1_CUR_TIME);
>>> +	mdelay(50);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void apple_wdt_clk_disable_unprepare(void *data)
>>> +{
>>> +	clk_disable_unprepare(data);
>>> +}
>>> +
>>> +static struct watchdog_ops apple_wdt_ops = {
>>> +	.owner = THIS_MODULE,
>>> +	.start = apple_wdt_start,
>>> +	.stop = apple_wdt_stop,
>>> +	.ping = apple_wdt_ping,
>>> +	.set_timeout = apple_wdt_set_timeout,
>>> +	.get_timeleft = apple_wdt_get_timeleft,
>>> +	.restart = apple_wdt_restart,
>>> +};
>>> +
>>> +static struct watchdog_info apple_wdt_info = {
>>> +	.identity = "Apple SoC Watchdog",
>>> +	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
>>> +};
>>> +
>>> +static int apple_wdt_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct apple_wdt *wdt;
>>> +	struct clk *clk;
>>> +	u32 wdt_ctrl;
>>> +	int ret;
>>> +
>>> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>>> +	if (!wdt)
>>> +		return -ENOMEM;
>>> +
>>> +	wdt->regs = devm_platform_ioremap_resource(pdev, 0);
>>> +	if (IS_ERR(wdt->regs))
>>> +		return PTR_ERR(wdt->regs);
>>> +
>>> +	clk = devm_clk_get(dev, NULL);
>>> +	if (IS_ERR(clk))
>>> +		return PTR_ERR(clk);
>>> +
>>> +	ret = clk_prepare_enable(clk);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = devm_add_action_or_reset(dev, apple_wdt_clk_disable_unprepare,
>>> +				       clk);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	wdt->clk_rate = clk_get_rate(clk);
>>> +	if (!wdt->clk_rate)
>>> +		return -EINVAL;
>>> +
>>> +	wdt->wdd.ops = &apple_wdt_ops;
>>> +	wdt->wdd.info = &apple_wdt_info;
>>> +	wdt->wdd.max_timeout = U32_MAX / wdt->clk_rate;
>>> +	wdt->wdd.timeout = APPLE_WDT_TIMEOUT_DEFAULT;
>>> +
>>> +	wdt_ctrl = readl_relaxed(wdt->regs + APPLE_WDT_WD1_CTRL);
>>> +	if (wdt_ctrl & APPLE_WDT_CTRL_RESET_EN)
>>> +		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
>>> +
>>> +	watchdog_init_timeout(&wdt->wdd, 0, dev);
>>> +	apple_wdt_set_timeout(&wdt->wdd, wdt->wdd.timeout);
>>> +	watchdog_stop_on_unregister(&wdt->wdd);
>>> +	watchdog_set_restart_priority(&wdt->wdd, 128);
>>> +
>>> +	return devm_watchdog_register_device(dev, &wdt->wdd);
>>> +}
>>> +
>>> +static const struct of_device_id apple_wdt_of_match[] = {
>>> +	{ .compatible = "apple,wdt" },
>>> +	{},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, apple_wdt_of_match);
>>> +
>>> +static struct platform_driver apple_wdt_driver = {
>>> +	.driver = {
>>> +		.name = "apple-watchdog",
>>> +		.of_match_table = apple_wdt_of_match,
>>> +	},
>>> +	.probe = apple_wdt_probe,
>>> +};
>>> +module_platform_driver(apple_wdt_driver);
>>> +
>>> +MODULE_DESCRIPTION("Apple SoC watchdog driver");
>>> +MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
>>> +MODULE_LICENSE("Dual MIT/GPL");
>>
>> Reviewed-by: Hector Martin <marcan@marcan.st>
>>
>> Thanks, looks good! Any chance you can do a quick v3 with the MAINTAINERS changes split off? As usual, I'd rather make life easier for people merging upstream :)
>>
> 
> Usually I don't ask for such a split, and I don't recall that being an issue.
> So, from my perspective, that is not necessary.

We're upstreaming a bunch of things in parallel that touch the same 
MAINTAINERS section, and if each of those goes through subsystem trees, 
they all end up creating a pile of conflicts when merged. This has 
already happened a few times (I got a ping from linux-next about it the 
other day).

To make life easier for upstream mergers, we prefer to split off 
MAINTAINERS changes. Then instead of going through the subsystem tree, I 
can push those up through the SoC tree, making sure to resolve any 
conflicts/ordering issues. Then everyone upstream of us is happy :-)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
