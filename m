Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75376462343
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhK2V3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:29:50 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:35937 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229635AbhK2V1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:27:49 -0500
Received: from [77.244.183.192] (port=61954 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mro8S-0001y6-Vg; Mon, 29 Nov 2021 22:24:29 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH v4 7/9] watchdog: max77620: add support for the max77714
 variant
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20211120155707.4019487-1-luca@lucaceresoli.net>
 <20211120155707.4019487-8-luca@lucaceresoli.net>
 <20211129155320.GA2761477@roeck-us.net>
Message-ID: <8efe5354-6308-4f0c-a0c8-6657f705cfb1@lucaceresoli.net>
Date:   Mon, 29 Nov 2021 22:24:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129155320.GA2761477@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

thanks for you review!

On 29/11/21 16:53, Guenter Roeck wrote:
> On Sat, Nov 20, 2021 at 04:57:05PM +0100, Luca Ceresoli wrote:
>> The MAX77714 is a MFD chip whose watchdog has the same programming
>> procedures as the MAX77620 watchdog, but most register offsets and bit
>> masks are different, as well as some features.
>>
>> Support the MAX77714 watchdog by adding a variant description table holding
>> the differences.
>>
>> All the features implemented by this driver are available on the MAX77714
>> except for the lack of a WDTOFFC bit. Instead of using a "HAS_*" flag we
>> handle this by holding in the cnfg_glbl2_cfg_bits struct field the bits
>> (i.e. the features) to enable in the CNFG_GLBL2 register. These bits differ
>> among the two models. This implementation allows to avoid any conditional
>> code, keeping the execution flow unchanged.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> ---
>>
>> This patch is new in v4. It replaces v3 patch 7 ("watchdog: max77714: add
>> driver for the watchdog in the MAX77714 PMIC") by adding MAX77714 wdog
>> support to the existing MAX77620 wdog driver instead of adding a new
>> driver. Suggested by Guenter Roeck and Krzysztof Kozlowski.
>> ---
>>  drivers/watchdog/Kconfig        |  2 +-
>>  drivers/watchdog/max77620_wdt.c | 96 +++++++++++++++++++++++++--------
>>  2 files changed, 75 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index a6d97f30325a..f920ad271dde 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -677,7 +677,7 @@ config MAX63XX_WATCHDOG
>>  
>>  config MAX77620_WATCHDOG
>>  	tristate "Maxim Max77620 Watchdog Timer"
>> -	depends on MFD_MAX77620 || COMPILE_TEST
>> +	depends on MFD_MAX77620 || MFD_MAX77714 || COMPILE_TEST
>>  	select WATCHDOG_CORE
>>  	help
>>  	  This is the driver for the Max77620 watchdog timer.
>> diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
>> index be6a53c30002..06b48295fab6 100644
>> --- a/drivers/watchdog/max77620_wdt.c
>> +++ b/drivers/watchdog/max77620_wdt.c
>> @@ -3,8 +3,10 @@
>>   * Maxim MAX77620 Watchdog Driver
>>   *
>>   * Copyright (C) 2016 NVIDIA CORPORATION. All rights reserved.
>> + * Copyright (C) 2021 Luca Ceresoli
>>   *
>>   * Author: Laxman Dewangan <ldewangan@nvidia.com>
>> + * Author: Luca Ceresoli <luca@lucaceresoli.net>
>>   */
>>  
>>  #include <linux/err.h>
>> @@ -13,6 +15,7 @@
>>  #include <linux/module.h>
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/mfd/max77620.h>
>> +#include <linux/mfd/max77714.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/regmap.h>
>>  #include <linux/slab.h>
>> @@ -20,17 +23,66 @@
>>  
>>  static bool nowayout = WATCHDOG_NOWAYOUT;
>>  
>> +/**
>> + * struct max77620_variant - Data specific to a chip variant
>> + * @wdt_info:            watchdog descriptor
>> + * @reg_onoff_cnfg2:     ONOFF_CNFG2 register offset
>> + * @reg_cnfg_glbl2:      CNFG_GLBL2 register offset
>> + * @reg_cnfg_glbl3:      CNFG_GLBL3 register offset
>> + * @wdtc_mask:           WDTC bit mask in CNFG_GLBL3 (=bits to update to ping the watchdog)
>> + * @bit_wd_rst_wk:       WD_RST_WK bit offset within ONOFF_CNFG2
>> + * @cnfg_glbl2_cfg_bits: configuration bits to enable in CNFG_GLBL2 register
>> + */
>> +struct max77620_variant {
>> +	const struct watchdog_info wdt_info;
>> +	u8 reg_onoff_cnfg2;
>> +	u8 reg_cnfg_glbl2;
>> +	u8 reg_cnfg_glbl3;
>> +	u8 wdtc_mask;
>> +	u8 bit_wd_rst_wk;
>> +	u8 cnfg_glbl2_cfg_bits;
>> +};
>> +
>>  struct max77620_wdt {
>>  	struct device			*dev;
>>  	struct regmap			*rmap;
>> +	const struct max77620_variant	*drv_data;
>>  	struct watchdog_device		wdt_dev;
>>  };
>>  
>> +static const struct max77620_variant max77620_wdt_data = {
>> +	.wdt_info = {
>> +		.identity = "max77620-watchdog",
>> +		.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
>> +	},
> 
> That does not have to be, and should not be, part of device specific data,
> just because of the identity string.

Ok, no problem, will fix, but I have two questions.

First, what's the reason? Coding style or a functional difference?
Usually const data is preferred to runtime assignment.

Second: it's not clear how you expect it to be done. Looking into the
kernel it looks like almost all drivers set a constant string. I could
find only one exception, f71808e_wdt:
https://elixir.bootlin.com/linux/v5.16-rc3/source/drivers/watchdog/f71808e_wdt.c#L471

> Either keep the current identity string,
> mark max77620_wdt_info as __ro_after_init and overwrite the identity string
> there during probe

And also remove 'static' I guess. Hm, I don't love this, as above I tend
to prefer static const when possible for file-scoped data.

> or add the structure to max77620_wdt and fill it out there.

Do you mean like the following, untested, kind-of-pseudocode?

 struct max77620_wdt {
 	struct device			*dev;
 	struct regmap			*rmap;
	const struct max77620_variant	*drv_data;
+	struct watchdog_info		info;     /* not a pointer! */
 	struct watchdog_device		wdt_dev;
 };

and then, in probe:

   wdt->dev = dev;
   wdt->drv_data = (const struct max77620_variant *)id->driver_data;
   /* ... assign other wdt fields ... */
+  strlcpy(wdt_dev->info.identity, id->name, \
+          sizeof(wdt_dev->info.identity));
+  wdt_dev->info.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | \
+                          WDIOF_MAGICCLOSE;

Finally, what about simply:

 static const struct max77620_variant max77620_wdt_data = {
	.wdt_info = {
-		.identity = "max77620-watchdog",
+		.identity = "max77xxx-watchdog",
		.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | ...
	},

and always use that struct unconditionally? The max63xx_wdt.c driver
seems to do that. Or, if this is an issue for backward compatibility (is
it?), just leave max77620_wdt_data and the .identity field will always
be "max77620-watchdog" even when using a MAX77714.

Thanks for you patience in reading so far.
-- 
Luca (slightly confused, but very open to learning)
