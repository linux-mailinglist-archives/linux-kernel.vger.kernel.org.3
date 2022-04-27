Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84085119A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbiD0Njf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiD0NjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:39:18 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8A549F91;
        Wed, 27 Apr 2022 06:36:06 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.109.156.243])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 233C6F98ACFB;
        Wed, 27 Apr 2022 15:36:04 +0200 (CEST)
Received: from [192.168.1.42] (88.125.132.16) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 15:36:04 +0200
Message-ID: <f3bb1c5d-1583-995e-213a-5eebc632c7bf@traphandler.com>
Date:   Wed, 27 Apr 2022 15:36:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 2/2] watchdog: Add Renesas RZ/N1 Watchdog driver
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, <wim@linux-watchdog.org>,
        <geert+renesas@glider.be>, <tzungbi@kernel.org>,
        <linux-watchdog@vger.kernel.org>
CC:     <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
References: <20220413082527.155740-1-jjhiblot@traphandler.com>
 <20220413082527.155740-3-jjhiblot@traphandler.com>
 <79a5ec82-da71-57c3-d7bb-11607cb71bb4@roeck-us.net>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <79a5ec82-da71-57c3-d7bb-11607cb71bb4@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [88.125.132.16]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 5099482153730914805
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudehgdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpedvfeekudegkeeuuedvueeuveejffdtvdethfelkefhfefftdetteffiefgvddtieenucfkpheptddrtddrtddrtddpkeekrdduvdehrddufedvrdduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepphhhihhlrdgvugifohhrthhhhiesrhgvnhgvshgrshdrtghomh
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/04/2022 15:03, Guenter Roeck wrote:
> On 4/13/22 01:25, Jean-Jacques Hiblot wrote:
>> From: Phil Edworthy <phil.edworthy@renesas.com>
>>
>> This is a driver for the standard WDT on the RZ/N1 devices. This WDT has
>> very limited timeout capabilities. However, it can reset the device.
>> To do so, the corresponding bits in the SysCtrl RSTEN register need to
>> be enabled. This is not done by this driver.
>>
>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
>> ---
>>   drivers/watchdog/Kconfig    |   8 ++
>>   drivers/watchdog/Makefile   |   1 +
>>   drivers/watchdog/rzn1_wdt.c | 203 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 212 insertions(+)
>>   create mode 100644 drivers/watchdog/rzn1_wdt.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index c4e82a8d863f..4d5e503c8950 100644
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
>> index 000000000000..fa32716727b7
>> --- /dev/null
>> +++ b/drivers/watchdog/rzn1_wdt.c
>> @@ -0,0 +1,203 @@
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
>> +#include <linux/reboot.h>
>> +#include <linux/watchdog.h>
>> +
>> +#define DEFAULT_TIMEOUT        60
>> +
>> +#define RZN1_WDT_RETRIGGER            0x0
>> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL        0
>> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL_MASK    0xfff
>> +#define RZN1_WDT_RETRIGGER_PRESCALE        BIT(12)
>> +#define RZN1_WDT_RETRIGGER_ENABLE        BIT(13)
>> +#define RZN1_WDT_RETRIGGER_WDSI            (0x2 << 14)
>> +
>> +#define RZN1_WDT_PRESCALER            16384
>> +#define RZN1_WDT_MAX                4095
>> +
>> +struct rzn1_watchdog {
>> +    struct watchdog_device        wdtdev;
>> +    void __iomem            *base;
>> +    unsigned long            clk_rate;
>
> Nit: Whenever clk_rate is used, it is divided by 1000.
> It might be better to store and use clk_rate_khz instead.

OK. I'll change this.

Thanks,

JJ

>
> Guenter
