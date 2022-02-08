Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1D04AD685
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349985AbiBHL0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbiBHKNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:13:14 -0500
X-Greylist: delayed 455 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 02:13:11 PST
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FDEC03FEC0;
        Tue,  8 Feb 2022 02:13:11 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.108.16.173])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 7817F23D5BB;
        Tue,  8 Feb 2022 10:05:33 +0000 (UTC)
Received: from [192.168.1.103] (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 11:05:32 +0100
Message-ID: <1ce1b7ae-a9e9-4d13-5faa-ea087e78e9dc@traphandler.com>
Date:   Tue, 8 Feb 2022 11:05:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 6/6] watchdog: Add Renesas RZ/N1 Watchdog driver
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
CC:     Phil Edworthy <phil.edworthy@renesas.com>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
References: <20220204161806.3126321-1-jjhiblot@traphandler.com>
 <20220204161806.3126321-7-jjhiblot@traphandler.com>
 <b3f041c5-9fe6-cf96-397e-582ac3434fa2@roeck-us.net>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <b3f041c5-9fe6-cf96-397e-582ac3434fa2@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: DAG1EX2.emp2.local (172.16.2.2) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 4642648267688917332
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrheejgddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthekredttdefjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepueefgeegveekgfeutdehueefffdtheekgeekteduteejheejtdduueevffekheetnecukfhppedtrddtrddtrddtpdekkedruddvhedrudefvddrjeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdifrghttghhughoghesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/02/2022 18:27, Guenter Roeck wrote:
> On 2/4/22 08:18, Jean-Jacques Hiblot wrote:
>> From: Phil Edworthy <phil.edworthy@renesas.com>
>>
>> This is a driver for the standard WDT on the RZ/N1 devices. This WDT has
>> very limited timeout capabilities. However, it can reset the device.
>> To do so, the corresponding bits in the SysCtrl RSTEN register need to
>> be enabled. This is not done by this driver.
>>
>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> ---
>>   drivers/watchdog/Kconfig    |   8 ++
>>   drivers/watchdog/Makefile   |   1 +
>>   drivers/watchdog/rzn1_wdt.c | 197 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 206 insertions(+)
>>   create mode 100644 drivers/watchdog/rzn1_wdt.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index c8fa79da23b3..ba6e4ebef404 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -883,6 +883,14 @@ config RENESAS_RZAWDT
>>         This driver adds watchdog support for the integrated 
>> watchdogs in the
>>         Renesas RZ/A SoCs. These watchdogs can be used to reset a 
>> system.
>>   +config RENESAS_RZN1WDT
>> +    tristate "Renesas RZ/N1 watchdog"
>> +    depends on ARCH_RENESAS || COMPILE_TEST
>> +    select WATCHDOG_CORE
>> +    help
>> +      This driver adds watchdog support for the integrated watchdogs 
>> in the
>> +      Renesas RZ/N1 SoCs. These watchdogs can be used to reset a 
>> system.
>> +
>>   config RENESAS_RZG2LWDT
>>       tristate "Renesas RZ/G2L WDT Watchdog"
>>       depends on ARCH_RENESAS || COMPILE_TEST
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index f7da867e8782..38d38564f47b 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -84,6 +84,7 @@ obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
>>   obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
>>   obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
>>   obj-$(CONFIG_RENESAS_RZAWDT) += rza_wdt.o
>> +obj-$(CONFIG_RENESAS_RZN1WDT) += rzn1_wdt.o
>>   obj-$(CONFIG_RENESAS_RZG2LWDT) += rzg2l_wdt.o
>>   obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
>>   obj-$(CONFIG_STM32_WATCHDOG) += stm32_iwdg.o
>> diff --git a/drivers/watchdog/rzn1_wdt.c b/drivers/watchdog/rzn1_wdt.c
>> new file mode 100644
>> index 000000000000..0d3284a44dde
>> --- /dev/null
>> +++ b/drivers/watchdog/rzn1_wdt.c
>> @@ -0,0 +1,197 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Renesas RZ/N1 Watchdog timer.
>> + * This is a 12-bit timer driver from a (62.5/16384) MHz clock. It 
>> can't even
>> + * cope with 2 seconds.
>> + *
>> + * Copyright 2018 Renesas Electronics Europe Ltd.
>> + *
>> + * Derived from Ralink RT288x watchdog timer.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/watchdog.h>
>> +
>> +#define RZN1_WDT_RETRIGGER            0x0
>> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL        0
>> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL_MASK    0xfff
>> +#define RZN1_WDT_RETRIGGER_PRESCALE        BIT(12)
>> +#define RZN1_WDT_RETRIGGER_ENABLE        BIT(13)
>> +#define RZN1_WDT_RETRIGGER_WDSI            (0x2 << 14)
>> +
>> +#define RZN1_WDT_PRESCALER            BIT(14)
>> +#define RZN1_WDT_MAX                4095
>> +
>> +struct rzn1_watchdog {
>> +    struct watchdog_device        wdt;
>> +    struct device            *dev;
>> +    void __iomem            *base;
>> +    unsigned int            irq;
>> +    unsigned int            reload_val;
>> +    unsigned long            clk_rate;
>> +};
>> +
>> +#define to_rzn1_watchdog(_ptr) \
>> +    container_of(_ptr, struct rzn1_watchdog, wdt)
>> +
>> +static int rzn1_wdt_ping(struct watchdog_device *w)
>> +{
>> +    struct rzn1_watchdog *wdt = to_rzn1_watchdog(w);
>> +
>> +    /* Any value retrigggers the watchdog */
>> +    writel(0, wdt->base + RZN1_WDT_RETRIGGER);
>> +
>> +    return 0;
>> +}
>> +
>> +static int rzn1_wdt_start(struct watchdog_device *w)
>> +{
>> +    struct rzn1_watchdog *wdt = to_rzn1_watchdog(w);
>> +    u32 val;
>> +
>> +    /*
>> +     * The hardware allows you to write to this reg only once.
>> +     * Since this includes the reload value, there is no way to 
>> change the
>> +     * timeout once started. Also note that the WDT clock is half 
>> the bus
>> +     * fabric clock rate, so if the bus fabric clock rate is changed 
>> after
>> +     * the WDT is started, the WDT interval will be wrong.
>> +     */
>> +    val = RZN1_WDT_RETRIGGER_WDSI;
>> +    val |= RZN1_WDT_RETRIGGER_ENABLE;
>> +    val |= RZN1_WDT_RETRIGGER_PRESCALE;
>> +    val |= wdt->reload_val;
>> +    writel(val, wdt->base + RZN1_WDT_RETRIGGER);
>> +
>> +    return 0;
>> +}
>> +
>> +static int rzn1_wdt_set_timeout(struct watchdog_device *w, unsigned 
>> int t)
>> +{
>> +    struct rzn1_watchdog *wdt = to_rzn1_watchdog(w);
>> +
>> +    w->timeout = t;
>> +
>> +    wdt->reload_val = (t * wdt->clk_rate) / RZN1_WDT_PRESCALER;
>> +
>
> Is that really what you want, given that it can only be set once,
> when the watchdog is started for the first time ?
> From the context, I would assume that you'd want to always set reload_val
> to wdt->clk_rate / RZN1_WDT_PRESCALER. That could be done in the probe
> function, meaning a set_timeout function is not really needed.
>
Thanks for the review and advice. I didn't want to modify too heavily 
the out-of-tree

driver at first. I'll update the driver and take your comments into 
consideration

>> +    return 0;
>> +}
>> +
>> +static irqreturn_t rzn1_wdt_irq(int irq, void *_wdt)
>> +{
>> +    struct rzn1_watchdog *wdt = (struct rzn1_watchdog *)_wdt;
>> +
>> +    dev_info(wdt->dev, "%s triggered\n", __func__);
>> +    return IRQ_HANDLED;
>> +}
>
> What is the point of supporting an interrupt if it doesn't do anything
> other than saying that it happened ?
It is possible to trigger an interrupt or reset the SOC when the watchdog

expires. It depends on the value of the RSTEN register in the sysctrl.

This interrupt handler has no functional purpose, but keeping it has 2 
benefits:

- it let the user know that a watchdog interrupt occurred.

- it serves as a reference for other developers to build custom handlers.


>
>> +
>> +static struct watchdog_info rzn1_wdt_info = {
>> +    .identity = "RZ/N1 Watchdog",
>> +    .options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | 
>> WDIOF_KEEPALIVEPING,
>> +};
>> +
>> +static const struct watchdog_ops rzn1_wdt_ops = {
>> +    .owner = THIS_MODULE,
>> +    .start = rzn1_wdt_start,
>> +    .ping = rzn1_wdt_ping,
>> +    .set_timeout = rzn1_wdt_set_timeout,
>> +};
>> +
>> +static const struct watchdog_device rzn1_wdt_dev = {
>> +    .info = &rzn1_wdt_info,
>> +    .ops = &rzn1_wdt_ops,
>> +    .min_timeout = 0,
>
> Really ? Did you try that ?
>> +    .max_timeout = 1,
>
> Documentation says
>
>  * @max_hw_heartbeat_ms:
>  *              Hardware limit for maximum timeout, in milli-seconds.
>  *              Replaces max_timeout if specified.
>
> and you set max_hw_heartbeat_ms below, so this is unnecessary.
>
>> +    .status = WATCHDOG_NOWAYOUT_INIT_STATUS,
>> +};
>> +
>> +static int rzn1_wdt_probe(struct platform_device *pdev)
>> +{
>> +    struct rzn1_watchdog *wdt;
>> +    int ret;
>> +    struct device_node *np = pdev->dev.of_node;
>> +    int err;
>> +    struct clk *clk;
>> +
>> +    wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL); > +    
>> if (!wdt)
>> +        return -ENOMEM;
>> +    wdt->dev = &pdev->dev;
>> +    wdt->wdt = rzn1_wdt_dev;
>> +    platform_set_drvdata(pdev, wdt);
>> +
>> +    wdt->base = devm_platform_ioremap_resource(pdev, 0);
>> +    if (IS_ERR(wdt->base)) {
>> +        dev_err(wdt->dev, "unable to get register bank\n");
>> +        return PTR_ERR(wdt->base);
>> +    }
>> +    wdt->irq = irq_of_parse_and_map(np, 0);
>> +    if (wdt->irq == NO_IRQ) {
>> +        dev_err(wdt->dev, "failed to get IRQ from DT\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    err = devm_request_irq(wdt->dev, wdt->irq, rzn1_wdt_irq, 0,
>> +                   np->name, wdt);
>> +    if (err) {
>> +        dev_err(wdt->dev, "failed to request irq %d\n", wdt->irq);
>> +        return err;
>> +    }
>> +    clk = devm_clk_get(wdt->dev, NULL);
>> +    if (!IS_ERR(clk) && clk_prepare_enable(clk))
>> +        return PTR_ERR(clk);
>
> That doesn't work. clk is not an ERR_PTR here, and the return value
> is thus an PTR_ERR() on a real pointer. This needs to be split into
> separate statements and checks.
>
>> +
>> +    wdt->clk_rate = clk_get_rate(clk);
>> +    if (!wdt->clk_rate) {
>> +        err = -EINVAL;
>> +        goto err_clk_disable;
>> +    }
>> +
>> +    wdt->reload_val = RZN1_WDT_MAX;
>> +    wdt->wdt.max_hw_heartbeat_ms = (RZN1_WDT_MAX * 1000) /
>> +                    (wdt->clk_rate / RZN1_WDT_PRESCALER);
>> +
>> +    ret = watchdog_init_timeout(&wdt->wdt, 0, &pdev->dev);
>> +    if (ret)
>> +        dev_warn(&pdev->dev, "Specified timeout invalid, using 
>> default");
>> +
>
> wdt->wdt.parent needs to be set as well.
>
>> +    ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdt);
>
> You either have to add a callback to disable and unprepare the clock
> when the driver is removed (see other watchdog drivers for example), or
> you need a remove function and can not use 
> devm_watchdog_register_device().
>
>> +    if (ret)
>> +        goto error;
>> +
>> +    dev_info(wdt->dev, "Initialized\n");
>> +
>> +    return 0;
>> +
>> +error:
>> +err_clk_disable:
>
> To labels pointing to the same place does not add any value.
>
>> +    clk_disable_unprepare(clk);
>> +    dev_warn(wdt->dev, "Initialization failed\n");
>
> This is not a warning.
>
>> +    return err;
>> +}
>> +
>> +
>> +static const struct of_device_id rzn1_wdt_match[] = {
>> +    { .compatible = "renesas,rzn1-wdt" },
>> +    {},
>> +};
>> +MODULE_DEVICE_TABLE(of, rzn1_wdt_match);
>> +
>> +static struct platform_driver rzn1_wdt_driver = {
>> +    .probe        = rzn1_wdt_probe,
>> +    .driver        = {
>> +        .name        = KBUILD_MODNAME,
>> +        .of_match_table    = rzn1_wdt_match,
>> +    },
>> +};
>> +
>> +module_platform_driver(rzn1_wdt_driver);
>> +
>> +MODULE_DESCRIPTION("Renesas RZ/N1 hardware watchdog");
>> +MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
>> +MODULE_LICENSE("GPL v2");
>
