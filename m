Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAD246247A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhK2WTl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Nov 2021 17:19:41 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:33867 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232943AbhK2WRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:17:49 -0500
Received: from [77.244.183.192] (port=62584 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mrour-000EyV-6F; Mon, 29 Nov 2021 23:14:28 +0100
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
 <8efe5354-6308-4f0c-a0c8-6657f705cfb1@lucaceresoli.net>
 <65a9c26d-31cb-7c4c-df87-12aee8f43578@roeck-us.net>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <4d3d39e7-73f1-fd12-d61e-adbb08147da9@lucaceresoli.net>
Date:   Mon, 29 Nov 2021 23:14:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <65a9c26d-31cb-7c4c-df87-12aee8f43578@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
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

On 29/11/21 22:56, Guenter Roeck wrote:
> On 11/29/21 1:24 PM, Luca Ceresoli wrote:
> [ ... ]
>>>>   +static const struct max77620_variant max77620_wdt_data = {
>>>> +    .wdt_info = {
>>>> +        .identity = "max77620-watchdog",
>>>> +        .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
>>>> WDIOF_MAGICCLOSE,
>>>> +    },
>>>
>>> That does not have to be, and should not be, part of device specific
>>> data,
>>> just because of the identity string.
>>
>> Ok, no problem, will fix, but I have two questions.
>>
>> First, what's the reason? Coding style or a functional difference?
>> Usually const data is preferred to runtime assignment.
>>
> 
> wdt_info is not chip specific variant information as nothing but the
> identity
> string is different, and there is no technical need for that difference.
> 
>> Second: it's not clear how you expect it to be done. Looking into the
> 
> I gave you three options to pick from.

Perhaps it's because I'm not a native English speaker, but I thought
"either" introduces an alternative between two options (wiktionary
confirms, FWIW). Reading your sentence in that perspective gave it a
different meaning.

>> kernel it looks like almost all drivers set a constant string. I could
>> find only one exception, f71808e_wdt:
>> https://elixir.bootlin.com/linux/v5.16-rc3/source/drivers/watchdog/f71808e_wdt.c#L471
>>
>>
>>> Either keep the current identity string,
>>> mark max77620_wdt_info as __ro_after_init and overwrite the identity
>>> string
>>> there during probe
>>
>> And also remove 'static' I guess. Hm, I don't love this, as above I tend
>> to prefer static const when possible for file-scoped data.
>>
> 
> Where did I suggest to remove 'static', and what would be the benefit of
> making
> the variable global ?

You didn't. But since max77620_wdt_info is currently file-scoped, should
it be modified during probe it would generate a weird situation in case
one has both a max77714 and a max77620 on the same board (unlikely but
possible), as two instances of the same driver would modify the same
(static) data.

But all of this discussion is getting quite theoretical as...

>>> or add the structure to max77620_wdt and fill it out there.
>>
>> Do you mean like the following, untested, kind-of-pseudocode?
>>
>>   struct max77620_wdt {
>>       struct device            *dev;
>>       struct regmap            *rmap;
>>     const struct max77620_variant    *drv_data;
>> +    struct watchdog_info        info;     /* not a pointer! */
>>       struct watchdog_device        wdt_dev;
>>   };
>>
>> and then, in probe:
>>
>>     wdt->dev = dev;
>>     wdt->drv_data = (const struct max77620_variant *)id->driver_data;
>>     /* ... assign other wdt fields ... */
>> +  strlcpy(wdt_dev->info.identity, id->name, \
>> +          sizeof(wdt_dev->info.identity));
>> +  wdt_dev->info.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | \
>> +                          WDIOF_MAGICCLOSE;
>>
> For example, yes.
> 
>> Finally, what about simply:
>>
>>   static const struct max77620_variant max77620_wdt_data = {
>>     .wdt_info = {
>> -        .identity = "max77620-watchdog",
>> +        .identity = "max77xxx-watchdog",
>>         .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | ...
>>     },
>>
>> and always use that struct unconditionally? The max63xx_wdt.c driver
>> seems to do that. Or, if this is an issue for backward compatibility (is
>> it?), just leave max77620_wdt_data and the .identity field will always
>> be "max77620-watchdog" even when using a MAX77714.

...I'll go for this last, simplest option: same struct, same string, always.

-- 
Luca

