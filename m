Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2F959A4A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354720AbiHSRiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354697AbiHSRhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:37:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3FD165724
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:56:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n4so5821733wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=j8ZFLgSTuoY+TTUHZWrcVuE8dk4bzAu1Ol/k32eYOKo=;
        b=nCeLu/MZDEMn9xcn0UTdb5giZelaptFqrYfLTpFVpGUyRt0a1rfHB4zbFeY9u5RuEm
         ra8qEx/QlowcDY/sLXOYo7z54En5EAHFO0cqMb62GuwRUQ9Zdls4Yp7wHMh3F6rIUi2I
         vWLmusLiXpm669P3BO45yjiYa+Ou1SRyJJaGoxTXX5NgprcEqo2dFf/lKhBaI58KkYVl
         MfoBO5ML0AJoT50U4+m9Xfd6Mt9tX2rBzarQV5eoM8RDXlfFtyu1luEELfOmpcXi/OLg
         iU6vZ7FsU9qjsk1OhfJnEo2lIY9RNBvWOCJlpEqoAaaVbH6uk35/BgD12N020ftgQ28m
         0iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=j8ZFLgSTuoY+TTUHZWrcVuE8dk4bzAu1Ol/k32eYOKo=;
        b=lKd0pS9T17xg0isn/PddbF2bP1kxKGoAhKWJsQ57eZaZ2mTSD02MPA2hWKyC6ANSfA
         rIhWMKOEtrGyPdHu6GZaBvuOvp2zVBIe8Qs7RfUDVSchuMt6I2W8yo5QEYf0Fonsov3J
         8Sq57x2LOBWfB7MJdODFyPmeaeqF6/NVVud3LLp/gbUmECsLGlHFdcXHOXiZ6OKo9FvX
         boJb8VJTMDcRM5tRMq0rCSXRPnUz8VfVw6NgOliz29bwLS52nRLJUki1OybENhkDDgBQ
         D8jLEg8lepXjOvO7zWI0aAGoNgaY/kSPjvGUSE5c/FHttCmeoWI7WvggBgiv6eSOC7xy
         JReg==
X-Gm-Message-State: ACgBeo3/EQA6SAb+I0t/DdCq6MNBJ8tKgMLwDrp5fcUxYFN+WIlL/0f2
        prZ5yCK3vyESsbfKXBcHOdE3cQ==
X-Google-Smtp-Source: AA6agR53e1VEDJjz/li961SS7ONlLdMbFVXssWMS5p0Je6jZnUgfpFJ4cC21S0dWpydRb8Bl9rTJBQ==
X-Received: by 2002:a05:6000:184c:b0:223:2c8b:c43c with SMTP id c12-20020a056000184c00b002232c8bc43cmr4882669wri.16.1660928171492;
        Fri, 19 Aug 2022 09:56:11 -0700 (PDT)
Received: from [10.35.5.6] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a5537bb2besm5826357wmj.25.2022.08.19.09.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 09:56:10 -0700 (PDT)
Message-ID: <2306e6c2-f07c-719c-1052-9bc60e59eca6@sifive.com>
Date:   Fri, 19 Aug 2022 17:56:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [RFC v4 06/10] pwm: dwc: split pci out of core driver
Content-Language: en-GB
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
 <20220816211454.237751-7-ben.dooks@sifive.com>
 <edecb3a9-e2d4-41a1-1d06-b3a30a9bac60@linux.intel.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <edecb3a9-e2d4-41a1-1d06-b3a30a9bac60@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2022 14:38, Jarkko Nikula wrote:
> Hi
> 
> On 8/17/22 00:14, Ben Dooks wrote:
>> Moving towards adding non-pci support for the driver, move the pci
>> parts out of the core into their own module. This is partly due to
>> the module_driver() code only being allowed once in a module and also
>> to avoid a number of #ifdef if we build a single file in a system
>> without pci support.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
> 
> I quickly tested this on Intel Elkhart and didn't notice any regression. 
> A few comments below.
> 
>>   drivers/pwm/Kconfig       |  14 +++-
>>   drivers/pwm/Makefile      |   1 +
>>   drivers/pwm/pwm-dwc-pci.c | 133 ++++++++++++++++++++++++++++++++
>>   drivers/pwm/pwm-dwc.c     | 158 +-------------------------------------
>>   drivers/pwm/pwm-dwc.h     |  58 ++++++++++++++
>>   5 files changed, 207 insertions(+), 157 deletions(-)
>>   create mode 100644 drivers/pwm/pwm-dwc-pci.c
>>   create mode 100644 drivers/pwm/pwm-dwc.h
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 3f3c53af4a56..a9f1c554db2b 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -175,15 +175,23 @@ config PWM_CROS_EC
>>         Controller.
>>   config PWM_DWC
>> -    tristate "DesignWare PWM Controller"
>> -    depends on PCI || COMPILE_TEST
>> +    tristate "DesignWare PWM Controller core"
>>       depends on HAS_IOMEM
>>       help
>> -      PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
>> +      PWM driver for Synopsys DWC PWM Controller.
>>         To compile this driver as a module, choose M here: the module
>>         will be called pwm-dwc.
>> +config PWM_DWC_PCI
>> +    tristate "DesignWare PWM Controller core"
> 
> Same text as core part has. How about "DesignWare PWM Controller PCI 
> driver"?

Thanks, did notice a couple of kconfig issues so will look at that.

> 
>> +    depends on PWM_DWC && HAS_IOMEM && PCI
>> +    help
>> +      PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
>> +
>> +      To compile this driver as a module, choose M here: the module
>> +      will be called pwm-dwc-pci.
>> +
>>   config PWM_EP93XX
>>       tristate "Cirrus Logic EP93xx PWM support"
>>       depends on ARCH_EP93XX || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 7bf1a29f02b8..a70d36623129 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLPS711X)    += pwm-clps711x.o
>>   obj-$(CONFIG_PWM_CRC)        += pwm-crc.o
>>   obj-$(CONFIG_PWM_CROS_EC)    += pwm-cros-ec.o
>>   obj-$(CONFIG_PWM_DWC)        += pwm-dwc.o
>> +obj-$(CONFIG_PWM_DWC_PCI)    += pwm-dwc-pci.o
>>   obj-$(CONFIG_PWM_EP93XX)    += pwm-ep93xx.o
>>   obj-$(CONFIG_PWM_FSL_FTM)    += pwm-fsl-ftm.o
>>   obj-$(CONFIG_PWM_HIBVT)        += pwm-hibvt.o
>> diff --git a/drivers/pwm/pwm-dwc-pci.c b/drivers/pwm/pwm-dwc-pci.c
>> new file mode 100644
>> index 000000000000..2213d0e7f3c8
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-dwc-pci.c
>> @@ -0,0 +1,133 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * DesignWare PWM Controller driver (PCI part)
>> + *
>> + * Copyright (C) 2018-2020 Intel Corporation
>> + *
>> + * Author: Felipe Balbi (Intel)
>> + * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> + * Author: Raymond Tan <raymond.tan@intel.com>
>> + *
>> + * Limitations:
>> + * - The hardware cannot generate a 0 % or 100 % duty cycle. Both 
>> high and low
>> + *   periods are one or more input clock periods long.
>> + */
>> +
> 
> I think this is more common limitation rather than PCI part.

The PCI is based off an core without the support, it is added
as a build option as of (IIRC) the 2.13 core.

> 
>> --- a/drivers/pwm/pwm-dwc.c
>> +++ b/drivers/pwm/pwm-dwc.c
>> @@ -1,16 +1,12 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>> - * DesignWare PWM Controller driver
>> + * DesignWare PWM Controller driver core
>>    *
>>    * Copyright (C) 2018-2020 Intel Corporation
>>    *
>>    * Author: Felipe Balbi (Intel)
>>    * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>>    * Author: Raymond Tan <raymond.tan@intel.com>
>> - *
>> - * Limitations:
>> - * - The hardware cannot generate a 0 % or 100 % duty cycle. Both 
>> high and low
>> - *   periods are one or more input clock periods long.
>>    */
> 
> Relates to previous comment, is there reason why this limitation is 
> removed from the core part?

See above.

> 
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-dwc.h
>> +#define DWC_CLK_PERIOD_NS    10
> 
> Perhaps this addition can be removed if patch 7/10 goes before this 
> patch? It's anyway specific to PCI part only.

Will look into that

