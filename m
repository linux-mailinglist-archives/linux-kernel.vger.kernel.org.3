Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEBF47BD00
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhLUJiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:38:15 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:49375 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236423AbhLUJiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:38:14 -0500
Received: from host-79-2-93-196.business.telecomitalia.it ([79.2.93.196]:35472 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mzbb1-0007jy-QE; Tue, 21 Dec 2021 10:38:11 +0100
Subject: Re: [PATCH v5 5/9] mfd: max77714: Add driver for Maxim MAX77714 PMIC
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20211211175951.30763-1-luca@lucaceresoli.net>
 <20211211175951.30763-6-luca@lucaceresoli.net> <YcGeZVgqNWDyvovW@google.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <698fb091-6532-7bba-bc14-6275db32c524@lucaceresoli.net>
Date:   Tue, 21 Dec 2021 10:38:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcGeZVgqNWDyvovW@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 21/12/21 10:29, Lee Jones wrote:
> On Sat, 11 Dec 2021, Luca Ceresoli wrote:
> 
>> Add a simple driver for the Maxim MAX77714 PMIC, supporting RTC and
>> watchdog only.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> ---
>>
>> Changes in v5: none
>>
>> Changes in v4: none
>>
>> Changes in v3:
>>  - Suggested by Lee Jones:
>>    - move struct mfd_cell to top of file
>>    - remove struct max77714 and its kmalloc, not used after probe
>>    - reword error messages
>>    - add "/* pF */" onto the end of the load_cap line
>>
>> Changes in v2:
>>  - fix "watchdog" word in heading comment (Guenter Roeck)
>>  - move struct max77714 to .c file (Krzysztof Kozlowski)
>>  - change include guard format (Krzysztof Kozlowski)
>>  - allow building as a module (Krzysztof Kozlowski)
>>  - remove of_match_ptr usage (Krzysztof Kozlowski / lkp)
>>    (Reported-by: kernel test robot <lkp@intel.com>)
>> ---
>>  MAINTAINERS                  |   2 +
>>  drivers/mfd/Kconfig          |  14 ++++
>>  drivers/mfd/Makefile         |   1 +
>>  drivers/mfd/max77714.c       | 152 +++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/max77714.h |  60 ++++++++++++++
>>  5 files changed, 229 insertions(+)
>>  create mode 100644 drivers/mfd/max77714.c
>>  create mode 100644 include/linux/mfd/max77714.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a08f5167dfe0..ef3ffba828af 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11586,6 +11586,8 @@ MAXIM MAX77714 PMIC MFD DRIVER
>>  M:	Luca Ceresoli <luca@lucaceresoli.net>
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
>> +F:	drivers/mfd/max77714.c
>> +F:	include/linux/mfd/max77714.h
>>  
>>  MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
>>  M:	Javier Martinez Canillas <javier@dowhile0.org>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 3fb480818599..1b9d772bdae6 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -855,6 +855,20 @@ config MFD_MAX77693
>>  	  additional drivers must be enabled in order to use the functionality
>>  	  of the device.
>>  
>> +config MFD_MAX77714
>> +	tristate "Maxim Semiconductor MAX77714 PMIC Support"
>> +	depends on I2C
>> +	depends on OF || COMPILE_TEST
>> +	select MFD_CORE
>> +	select REGMAP_I2C
>> +	help
>> +	  Say yes here to add support for Maxim Semiconductor MAX77714.
>> +	  This is a Power Management IC with 4 buck regulators, 9
>> +	  low-dropout regulators, 8 GPIOs, RTC, watchdog etc. This driver
>> +	  provides common support for accessing the device; additional
>> +	  drivers must be enabled in order to use each functionality of the
>> +	  device.
>> +
>>  config MFD_MAX77843
>>  	bool "Maxim Semiconductor MAX77843 PMIC Support"
>>  	depends on I2C=y
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 0b1b629aef3e..03115cf1336b 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -162,6 +162,7 @@ obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
>>  obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
>>  obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
>>  obj-$(CONFIG_MFD_MAX77693)	+= max77693.o
>> +obj-$(CONFIG_MFD_MAX77714)	+= max77714.o
>>  obj-$(CONFIG_MFD_MAX77843)	+= max77843.o
>>  obj-$(CONFIG_MFD_MAX8907)	+= max8907.o
>>  max8925-objs			:= max8925-core.o max8925-i2c.o
>> diff --git a/drivers/mfd/max77714.c b/drivers/mfd/max77714.c
>> new file mode 100644
>> index 000000000000..08dfb69bc6e8
>> --- /dev/null
>> +++ b/drivers/mfd/max77714.c
>> @@ -0,0 +1,152 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Maxim MAX77714 MFD Driver
> 
> I'm only mentioning this because you are still missing some reviews.
> 
> But I'd prefer for drivers not to describe themselves as MFD Drivers.
> 
> The term Parent or Core driver is usually better.
> 
> If you have to respin the set, please fix it.

OK. However No plan for a new iteration, but the wdog patches still need
a review so it's possible. I don't expect changes for the other patches,
they are acked and unchanged since a couple iterations.

> If not, please sent a subsequent fix-up.

Sure. Maybe I'll find some good will and reword all drivers which
currently self-describe as "MFD drivers".

> Acked-by: Lee Jones <lee.jones@linaro.org>

Thanks.
-- 
Luca
