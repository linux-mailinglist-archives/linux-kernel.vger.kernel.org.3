Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B1258FE02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbiHKOEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbiHKOEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:04:13 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E798E0EB
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:03:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a18-20020a05600c349200b003a30de68697so2832013wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=dpQfYCCq/+drn5iVB9ooRHyxDLZEMRfg+qD3Ah/XRwI=;
        b=LBukdHOxshC0eaPZwrYKpBhE3oNPQ77xKDjHTNorwbx/w5cFBhWAnv2mo6uTvrRyNT
         iOvaTwAMQjpD9IWFXFd2uz9Er8W3n+A9izVgLOdj4RHOyhT3b12zaHkyC6p7ReSMqdYx
         R3fGzrbg5CLcJBBfmABnkcRWIy0/pI1JQiRr0DmJlD6terq7tTjA7RuCkoVKb8D3Tt6f
         VQWQo7P5pn1n6RLW9IisY2nYEdCapwjnrGsLfxZZGnH4UXTEkBoMM+aqpSq9uEhjuA79
         u/psj55al7DaMkCVvS2zBngOIjNfWkzFfljxO50DRE+jgVOkA7yamf/MpqYF/cbXLyTW
         rUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dpQfYCCq/+drn5iVB9ooRHyxDLZEMRfg+qD3Ah/XRwI=;
        b=vJEXQ1oMMSx5qBf5/VF+mPalWIA4H/NcJwPjaX2abvYc5rnRDjxLBrMdjyS2/b5+75
         Yi7tU5wxgP9kGKd/6dt8w+ulP3mzfP6sgjhrKft9yQJbcjBIr1jpas+yO3GCf5qEx0m6
         pY/tEL7Gh41eKVHeFn8fx/Dqzw/j1fK3YDyTheicPa1Oi1nJf3XwZ0gKouyrrUaPKuf4
         YaLX0sscBfD1YWLGHvbw8TL5efdsYRTMO3qzo2l52qNJhtWegcPt0M5bJ9kDh7KVMwTv
         iynnKMYshlTy6E5KaBHtH6DqU+MejDGZRbGub0VgvZWC5Ar3gd09Lr3g743Pcf2e2bOj
         T7vQ==
X-Gm-Message-State: ACgBeo2ws3QFkk2oe/bJO6wjLTvVBJJsGUoZ2q4x0n4L7fVYlovjrl6D
        lTUzCGLqxB6krcrz8SN73N5f1A==
X-Google-Smtp-Source: AA6agR5/Q13zQywSqGjb6atTMN6zwLk7aEPRPv2fr1R6J2efULxfFSt02cN0hmFriJS62o4D6adq1Q==
X-Received: by 2002:a05:600c:3b02:b0:3a5:2460:f059 with SMTP id m2-20020a05600c3b0200b003a52460f059mr5879198wms.129.1660226635702;
        Thu, 11 Aug 2022 07:03:55 -0700 (PDT)
Received: from [10.1.3.77] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d4b8c000000b002206203ed3dsm18938330wrt.29.2022.08.11.07.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 07:03:55 -0700 (PDT)
Message-ID: <51d8767e-f73c-6045-871f-88b4df098cb2@baylibre.com>
Date:   Thu, 11 Aug 2022 16:03:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] watchdog: meson: keep running if already active
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220801092150.4449-1-pboos@baylibre.com>
 <7ab495dd-4b3e-46e8-6db0-1dd20860043f@roeck-us.net>
From:   Philippe Boos <pboos@baylibre.com>
In-Reply-To: <7ab495dd-4b3e-46e8-6db0-1dd20860043f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/22 13:58, Guenter Roeck wrote:
> On 8/1/22 02:21, Philippe Boos wrote:
>> If the watchdog is already running (e.g.: started by bootloader) then
>> the kernel driver should keep the watchdog active but the amlogic driver
>> turns it off.
>>
>> Let the driver fix the clock rate if already active because we do not
>> know the previous timebase value. To avoid unintentional resetting we
>> temporarily set it to its maximum value.
>>
>> Then keep the enable bit if is was previously active.
>>
>> Signed-off-by: Philippe Boos <pboos@baylibre.com>
> 
> What changed since v1 ?
In v1, we read watchdog's enable bit before writing its config register,
then we write the register, this will always stop the watchdog. If it
was previously active we restart it. So, in v1, if the kernel crashes
just before the watchdog restarts it will be stuck forever.

In v2, we read watchdog's enable bit before writing its config register,
if it is already active we keep the enable bit when writing the
register.

Regards,

Philippe Boos
> 
> Guenter
> 
>> ---
>>   drivers/watchdog/meson_gxbb_wdt.c | 24 +++++++++++++++++++-----
>>   1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
>> index 5a9ca10fbcfa..8be8fd9e5637 100644
>> --- a/drivers/watchdog/meson_gxbb_wdt.c
>> +++ b/drivers/watchdog/meson_gxbb_wdt.c
>> @@ -146,6 +146,7 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>>       struct device *dev = &pdev->dev;
>>       struct meson_gxbb_wdt *data;
>>       int ret;
>> +    u32 ctrl_reg;
>>         data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>       if (!data)
>> @@ -177,13 +178,26 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>>       data->wdt_dev.timeout = DEFAULT_TIMEOUT;
>>       watchdog_set_drvdata(&data->wdt_dev, data);
>>   +    ctrl_reg = readl(data->reg_base + GXBB_WDT_CTRL_REG) &
>> +                GXBB_WDT_CTRL_EN;
>> +
>> +    if (ctrl_reg) {
>> +        /* Watchdog is running - keep it running but extend timeout
>> +         * to the maximum while setting the timebase
>> +         */
>> +        set_bit(WDOG_HW_RUNNING, &data->wdt_dev.status);
>> +        meson_gxbb_wdt_set_timeout(&data->wdt_dev,
>> +                GXBB_WDT_TCNT_SETUP_MASK / 1000);
>> +    }
>> +
>>       /* Setup with 1ms timebase */
>> -    writel(((clk_get_rate(data->clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
>> -        GXBB_WDT_CTRL_EE_RESET |
>> -        GXBB_WDT_CTRL_CLK_EN |
>> -        GXBB_WDT_CTRL_CLKDIV_EN,
>> -        data->reg_base + GXBB_WDT_CTRL_REG);
>> +    ctrl_reg |= ((clk_get_rate(data->clk) / 1000) &
>> +            GXBB_WDT_CTRL_DIV_MASK) |
>> +            GXBB_WDT_CTRL_EE_RESET |
>> +            GXBB_WDT_CTRL_CLK_EN |
>> +            GXBB_WDT_CTRL_CLKDIV_EN;
>>   +    writel(ctrl_reg, data->reg_base + GXBB_WDT_CTRL_REG);
>>       meson_gxbb_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);
>>         watchdog_stop_on_reboot(&data->wdt_dev);
> 

