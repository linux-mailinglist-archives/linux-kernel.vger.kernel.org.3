Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1481D5A92AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiIAJEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiIAJCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EAA501B3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662022935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ZMoWPwR1EnVFWc2f4IKbHF9nS7YRRHgtVcAwnoRlcU=;
        b=KEs93tdVkCc9gheDZg3oId77kNmrsNeKvWLS3wVk9OT2hkV14qCFY9K9PqVJcLHMbASvxi
        JT6O6ToGwHKPWO1ghQDBORev6a9WUkuYyU6LK+vYa1Rs3wyIVuPggPGdC2wlfjs5igG/TK
        EEpOVghGCG/jMLOY/aJENsmqhvgi858=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-392-TTTDAiIBPzKIghPci7xtyQ-1; Thu, 01 Sep 2022 05:02:14 -0400
X-MC-Unique: TTTDAiIBPzKIghPci7xtyQ-1
Received: by mail-ej1-f71.google.com with SMTP id hp14-20020a1709073e0e00b00741a2093c4aso4811759ejc.20
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3ZMoWPwR1EnVFWc2f4IKbHF9nS7YRRHgtVcAwnoRlcU=;
        b=Tl+v4bdSoaU935dvc37ufz6YUaSXBalbaRI54UI2rmYA/K3Lk9bw46slW3gC2xnXdv
         LyoyKCZ4BoYjP3oTdMYRe/dZGExfmD7AJM+j9SlHpUJjwgyJih3JR+1HsWbnA23oPaFh
         ChFeVv7FI0CmdJKKeFeD38N3jtYMWU14EQL/v1w1sph1Pnyat0dCPlQBxW+pGSq1/KgN
         eXUsk0IkwXdAZDnosDnfO3ftgPTIPLHg2fAlbCSHfCsXnxgiUgDkuvVkRexnQuiWzD4j
         AXuTM/48bAJNAnf4XU6jt00+nnz7M6xSZyryK7ov/rOM2V+al2b7yJ06CnyJVtblSMXk
         iVzg==
X-Gm-Message-State: ACgBeo3XceS1m1UjOlcy4eNSlGiKAEwDRbSUZAgDRjq9aNAMF0mRqFUx
        dYI/VW+yKJSaweT2NOHkRVVRPeeGLzgu6fXAsZBIoEyOe377jxLzhZRchL99ghrHZ8PkqA5ZPHW
        HG0aL8xilPaDbmlbRdhDVAnv5
X-Received: by 2002:a17:907:3d89:b0:73d:6a08:b03b with SMTP id he9-20020a1709073d8900b0073d6a08b03bmr22082627ejc.458.1662022932705;
        Thu, 01 Sep 2022 02:02:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR64P/vqbN59d3gtZSiUOWuQnByGdJE/Bo75ErVPB1WItgxT7da7e9dlyhRKnWmgXqsB9V+0xA==
X-Received: by 2002:a17:907:3d89:b0:73d:6a08:b03b with SMTP id he9-20020a1709073d8900b0073d6a08b03bmr22082607ejc.458.1662022932424;
        Thu, 01 Sep 2022 02:02:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b35-20020a509f26000000b0043cbdb16fbbsm1020265edf.24.2022.09.01.02.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 02:02:11 -0700 (PDT)
Message-ID: <073c2dce-bd03-9dfe-539f-203b6fb7eeaf@redhat.com>
Date:   Thu, 1 Sep 2022 11:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/3] ACPI: PMIC: Replace open coded be16_to_cpu()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20220831135749.78743-1-andriy.shevchenko@linux.intel.com>
 <20220831135749.78743-2-andriy.shevchenko@linux.intel.com>
 <4f388bda-b991-0ab6-4098-4f5dbabe57fb@redhat.com>
 <Yw+0jGdk2pIQSoOT@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Yw+0jGdk2pIQSoOT@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/31/22 21:20, Andy Shevchenko wrote:
> On Wed, Aug 31, 2022 at 08:19:24PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 8/31/22 15:57, Andy Shevchenko wrote:
>>> It's easier to understand the nature of a data type when
>>> it's written explicitly. With that, replace open coded
>>> endianess conversion.
>>>
>>> As a side effect it fixes the returned value of
>>> intel_crc_pmic_update_aux() since ACPI PMIC core code
>>> expects negative or zero and never uses positive one.
>>>
>>> While at it, use macros from bits.h to reduce a room for mistake.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> ---
>>> v3: added tag (Mika)
>>>  drivers/acpi/pmic/intel_pmic_bxtwc.c    | 50 +++++++++++--------------
>>>  drivers/acpi/pmic/intel_pmic_bytcrc.c   | 20 +++++++---
>>>  drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 13 ++++---
>>>  drivers/acpi/pmic/intel_pmic_xpower.c   | 10 +++--
>>>  4 files changed, 51 insertions(+), 42 deletions(-)
>>>
>>> diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/intel_pmic_bxtwc.c
>>> index e247615189fa..90a2e62a37e4 100644
>>> --- a/drivers/acpi/pmic/intel_pmic_bxtwc.c
>>> +++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c
>>> @@ -7,19 +7,20 @@
>>>  
>>>  #include <linux/init.h>
>>>  #include <linux/acpi.h>
>>> +#include <linux/bits.h>
>>> +#include <linux/byteorder/generic.h>
>>>  #include <linux/mfd/intel_soc_pmic.h>
>>>  #include <linux/regmap.h>
>>>  #include <linux/platform_device.h>
>>>  #include "intel_pmic.h"
>>>  
>>> -#define WHISKEY_COVE_ALRT_HIGH_BIT_MASK 0x0F
>>> -#define WHISKEY_COVE_ADC_HIGH_BIT(x)	(((x & 0x0F) << 8))
>>> -#define WHISKEY_COVE_ADC_CURSRC(x)	(((x & 0xF0) >> 4))
>>> -#define VR_MODE_DISABLED        0
>>> -#define VR_MODE_AUTO            BIT(0)
>>> -#define VR_MODE_NORMAL          BIT(1)
>>> -#define VR_MODE_SWITCH          BIT(2)
>>> -#define VR_MODE_ECO             (BIT(0)|BIT(1))
>>> +#define PMIC_REG_MASK		GENMASK(11, 0)
>>> +
>>> +#define VR_MODE_DISABLED        (0 << 0)
>>> +#define VR_MODE_AUTO            (1 << 0)
>>> +#define VR_MODE_NORMAL          (2 << 0)
>>> +#define VR_MODE_ECO             (3 << 0)
>>> +#define VR_MODE_SWITCH          (4 << 0)
>>>  #define VSWITCH2_OUTPUT         BIT(5)
>>>  #define VSWITCH1_OUTPUT         BIT(4)
>>>  #define VUSBPHY_CHARGE          BIT(1)
>>> @@ -297,25 +298,20 @@ static int intel_bxtwc_pmic_update_power(struct regmap *regmap, int reg,
>>>  
>>>  static int intel_bxtwc_pmic_get_raw_temp(struct regmap *regmap, int reg)
>>>  {
>>> -	unsigned int val, adc_val, reg_val;
>>> -	u8 temp_l, temp_h, cursrc;
>>>  	unsigned long rlsb;
>>>  	static const unsigned long rlsb_array[] = {
>>>  		0, 260420, 130210, 65100, 32550, 16280,
>>>  		8140, 4070, 2030, 0, 260420, 130210 };
>>> +	unsigned int adc_val, reg_val;
>>> +	__be16 buf;
>>>  
>>> -	if (regmap_read(regmap, reg, &val))
>>> +	if (regmap_bulk_read(regmap, reg - 1, &buf, sizeof(buf)))
>>>  		return -EIO;
>>> -	temp_l = (u8) val;
>>>  
>>> -	if (regmap_read(regmap, (reg - 1), &val))
>>> -		return -EIO;
>>> -	temp_h = (u8) val;
>>
>> Hmm, you are changing the order of the register
>> reads here. The old code is doing:
>>
>> 	read(reg);
>> 	read(reg -1);
>>
>> Where as the new code is doing:
>>
>> 	read(reg -1);
>> 	read(reg);
>>
>> The order matters since typically upon reading the
>> low byte, the high bits will get latched so that
>> the next read of the high bytes uses the bits
>> from the same x-bits value as the low 8 bits.
>>
>> This avoids things like:
>>
>> 1. Entire register value (all bits) 0x0ff
>> 2. Read reg with low 8 bits, read 0x0ff
>> 3. Entire register value becomes 0x100
>> 4. Read reg with high bits
>> 5. Combined value now reads as 0x1ff
>>
>> I have no idea if the bxtwc PMIC latches
>> the bits, but giving the lack of documentation
>> it would IMHO be better to not change the reading order.
> 
> Interestingly documentation suggests otherwise, e.g.:
> 
> THRMZN0H_REG
> Battery Thermal Zone 0 Limit Register High
> Offset 044H
> 
> Description
> 
> Z0HYS	  Temperature hysteresis value for TCOLD threshold
> 
> Z0CURHYS  Battery ChargerTemperature Zone Current hysteresis for TCOLD (MSBs)
> 	  3 bits of the battery charger temperature zone current hysteresis for zones 0/1.
> 
> TCOLD_H	  Battery ChargerTemperature Zone Threshold for TCOLD (MSBs)
> 	  Upper 1 bit of the battery charger temperature zone threshold for zones 0/1.
> 	  Writes to THRMZN0H (and all thermal zone registers) are not committed until
> 	  THRMZN0L (lower byte) is written to.
> 	  Write Before: THRMZN0L_REG.TCOLD_L
> 
> (Note the last description)

I see, but that is about writes and the write path was already
first doing a read + write of reg - 1, followed by writing
reg 1. So for the write path this patch does not introduce
any functional changes. But what about the read path, is read
latching the same or does it need the inverse order of writes?

Note I think it is likely the read order for proper latching
is likely also first high then low, but it would be good to check.
If that is indeed the case then this would actually be a bugfix,
not just a cleanup.

Also you have only checked for 1 of the 4 PMICs you are making
changes to in this patch?

The commit message suggests this code change does not cause any
functional changes, but as discussed it actually does make changes,
so this should be in the commit message.

Talking about making changes to 4 PMICs unlike patch 1 and 3 the changes
in this one are not trivial so IMHO this should be split into 1 patch
per PMIC. This has 3 advantages:

1. It makes reviewing easier, during my initial review I stopped
at the intel_bxtwc_pmic changes not even realizing more was coming...

2. This makes properly describing the actual functional changes
in the commit message a lot easier, otherwise the commit msg
is going to become somewhat messy.

3. This will also make reverting things easier if something does
break (even if it is just for testing if these changes are the cause
of the breakage).

###

So I've been taking a closer look at these changes and here are some
more remarks:

intel_crc_pmic_get_raw_temp() you are again changing the order
in which the 2 (low/high) registers are read. This needs to be
checked and mentioned in the commit message.

intel_crc_pmic_update_aux() unlike the intel_pmic_bxtwc.c
equivalent in this case your changes do switch the write-order,
assuming the same write order as in bxtwc should be used
this would actually be another bugfix.

For intel_pmic_chtdc_ti.c this does seems to be purely a refactor.

For intel_pmic_xpower.c the original code actually seems
to be wrong, the datasheet says:

REG 5AH: GPADC pin input ADC data, highest 8bit
Bit 7-0 GPADC pin input ADC data, highest 8bit

REG 5BH: GPADC pin input ADC data, lowest 4bit
Bit 7-4 Reserved
Bit 3-0 GPADC pin input ADC data, lowest 4bit

So it looks like instead of your patch we actually need
the following fix:

--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -257,7 +257,7 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
 
 	ret = regmap_bulk_read(regmap, AXP288_GP_ADC_H, buf, 2);
 	if (ret == 0)
-		ret = (buf[0] << 4) + ((buf[1] >> 4) & 0x0f);
+		ret = (buf[0] << 4) | (buf[1] & 0x0f);
 
 	if (adc_ts_pin_ctrl & AXP288_ADC_TS_CURRENT_ON_OFF_MASK) {
 		regmap_update_bits(regmap, AXP288_ADC_TS_PIN_CTRL,

I will try to make some time to check this on actual hw to see if
the code or the doc is right soon-ish

Regards,

Hans

