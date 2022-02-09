Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612904AF9DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbiBISWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbiBISV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:21:29 -0500
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C51C0613C9;
        Wed,  9 Feb 2022 10:21:30 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.109.146.130])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id BF120E3FA3BB;
        Wed,  9 Feb 2022 19:21:28 +0100 (CET)
Received: from [192.168.1.103] (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 19:21:28 +0100
Message-ID: <bebb25da-d046-6f84-08c8-c744dd18261d@traphandler.com>
Date:   Wed, 9 Feb 2022 19:21:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 5/6] watchdog: Add Renesas RZ/N1 Watchdog driver
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
References: <20220208183511.2925304-1-jjhiblot@traphandler.com>
 <20220208183511.2925304-6-jjhiblot@traphandler.com>
 <CAMuHMdV4PM9gC2wDZJKXKUt7AG2wS+adub=M+d0BrOedZ9ENPg@mail.gmail.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <CAMuHMdV4PM9gC2wDZJKXKUt7AG2wS+adub=M+d0BrOedZ9ENPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: CAS2.emp2.local (172.16.1.2) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 443886039216961876
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrheelgdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtjeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpefhiedthedttdegueeggfdtjeegtdeileeftdegheeutdetjeeuieehtdevvdefieenucfkpheptddrtddrtddrtddpkeekrdduvdehrddufedvrdejkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqfigrthgthhguohhgsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 09/02/2022 09:28, Geert Uytterhoeven wrote:
> Hi Jean-Jacques,
>
> On Tue, Feb 8, 2022 at 7:35 PM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>> From: Phil Edworthy <phil.edworthy@renesas.com>
>>
>> This is a driver for the standard WDT on the RZ/N1 devices. This WDT has
>> very limited timeout capabilities. However, it can reset the device.
>> To do so, the corresponding bits in the SysCtrl RSTEN register need to
>> be enabled. This is not done by this driver.
>>
>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> Thanks for your patch!
>
>> --- /dev/null
>> +++ b/drivers/watchdog/rzn1_wdt.c
>> @@ -0,0 +1,208 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Renesas RZ/N1 Watchdog timer.
>> + * This is a 12-bit timer driver from a (62.5/16384) MHz clock. It can't even
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
>> +#define DEFAULT_TIMEOUT                60
>> +
>> +#define RZN1_WDT_RETRIGGER                     0x0
>> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL          0
>> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL_MASK     0xfff
>> +#define RZN1_WDT_RETRIGGER_PRESCALE            BIT(12)
>> +#define RZN1_WDT_RETRIGGER_ENABLE              BIT(13)
>> +#define RZN1_WDT_RETRIGGER_WDSI                        (0x2 << 14)
>> +
>> +#define RZN1_WDT_PRESCALER                     16384
>> +#define RZN1_WDT_MAX                           4095
>> +
>> +struct rzn1_watchdog {
>> +       struct watchdog_device          wdt;
>> +       void __iomem                    *base;
>> +       unsigned long                   clk_rate;
>> +};
>> +
>> +#define to_rzn1_watchdog(_ptr) \
>> +       container_of(_ptr, struct rzn1_watchdog, wdt)
>> +
>> +static inline uint32_t get_max_heart_beat(uint32_t clk_rate)
> unsigned long clk_rate
>
>> +{
>> +       return (RZN1_WDT_MAX * RZN1_WDT_PRESCALER) / (clk_rate / 1000);
> Is clk_rate always a multiple of 1000? If not, you want to reorder
> this to avoid losing precision.

The clock is 62.5 MHz, so dividing by 1000 doesn't cause a big precision 
loss.

I could use the 64bit division but it seemed less readable and the 
watchdog is

not used as a precise timer anyway.

>
>> +}
>> +static inline uint32_t compute_reload_value(uint32_t tick_ms, uint32_t clk)
> unsigned long clk_rate
>
>> +{
>> +       return (tick_ms * (clk / 1000)) / RZN1_WDT_PRESCALER;
> Likewise.
>
>> +}
>> +static int rzn1_wdt_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct rzn1_watchdog *wdt;
>> +       struct device_node *np = dev->of_node;
>> +       struct clk *clk;
>> +       int ret;
>> +       int irq;
>> +
>> +       wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>> +       if (!wdt)
>> +               return -ENOMEM;
>> +
>> +       wdt->wdt = rzn1_wdt;
>> +       wdt->wdt.parent = dev;
>> +
>> +       wdt->base = devm_platform_ioremap_resource(pdev, 0);
>> +       if (IS_ERR(wdt->base))
>> +               return PTR_ERR(wdt->base);
>> +
>> +       irq = platform_get_irq(pdev, 0);
>> +       if (irq < 0) {
>> +               dev_err(dev, "failed to get the irq\n");
> No need to print a message, platform_get_irq() already does that.
>
>> +               return irq;
>> +       }
>> +
>> +       ret = devm_request_irq(dev, irq, rzn1_wdt_irq, 0,
>> +                              np->name, wdt);
>> +       if (ret) {
>> +               dev_err(dev, "failed to request irq %d\n", irq);
>> +               return ret;
>> +       }
>> +
>> +       clk = devm_clk_get(dev, NULL);
>> +       if (IS_ERR(clk)) {
>> +               dev_err(dev, "failed to get the clock\n");
>> +               return PTR_ERR(clk);
>> +       }
>> +
>> +       ret = clk_prepare_enable(clk);
>> +       if (ret) {
>> +               dev_err(dev, "failed to prepare/enable the clock\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = devm_add_action_or_reset(dev, rzn1_wdt_clk_disable_unprepare,
>> +                                      clk);
>> +       if (ret) {
>> +               dev_err(dev, "failed to register clock unprepare callback\n");
>> +               clk_disable_unprepare(clk);
> Please drop this, as devm_add_action_or_reset() calls the
> action on failure.
>
>> +               return ret;
>> +       }
>> +
>> +       wdt->clk_rate = clk_get_rate(clk);
>> +       if (!wdt->clk_rate) {
>> +               dev_err(dev, "failed to get the clock rate\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       /*
>> +        * The period of the watchdog cannot be changed once set
>> +        * and is limited to a very short period.
>> +        * Configure it for a 1s period once and for all, and
>> +        * rely on the heart-beat provided by the watchdog core
>> +        * to make this usable by the user-space.
>> +        */
>> +       wdt->wdt.max_hw_heartbeat_ms = get_max_heart_beat(wdt->clk_rate);
>> +       if (wdt->wdt.max_hw_heartbeat_ms > 1000)
>> +               wdt->wdt.max_hw_heartbeat_ms = 1000;
>> +
>> +       wdt->wdt.timeout = DEFAULT_TIMEOUT;
>> +       ret = watchdog_init_timeout(&wdt->wdt, 0, dev);
>> +
>> +       return devm_watchdog_register_device(dev, &wdt->wdt);
>> +}
>> +
>> +
>> +static const struct of_device_id rzn1_wdt_match[] = {
>> +       { .compatible = "renesas,r9a06g032-wdt" },
> No need to match on the soc-specific compatible value, as the
> family-specific value should be present in the DTB, too.
>
>> +       { .compatible = "renesas,rzn1-wdt" },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(of, rzn1_wdt_match);
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
