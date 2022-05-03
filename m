Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13F3517CA8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 06:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiECEk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 00:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiECEkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 00:40:52 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A41034666;
        Mon,  2 May 2022 21:37:20 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id z5-20020a9d62c5000000b00606041d11f1so5200152otk.2;
        Mon, 02 May 2022 21:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=cEx41mUNETFbYUOzVN18ifU8dkNJ2uJ17BjKZtGtfEc=;
        b=XZnLmusYqX5ax7IkYpODU6Qn6WYxGYTUkplMVADZxMlXWQq8UC7hyiCoApEikW8Zn3
         C/IBgOZxnLsGzWA7k9FaS41P2YsQHC7hnCWAQ06pBv2nDQsOJOQLd4Uy8u+TGIWygyKG
         WISm0L3qZHzzBpdITfeEKREWrrnVT9g6sCZueyccj7yZxDwB2jDXMa4vMjKT7R9xNIfY
         hAoK9fWqKNIAUUdtI0SUGB5M2SahjtqmrnZk9SXCI50EDI/dIviH5ObvhVBCVgQdlNU+
         RxFVKdAbjtryI/8Npbvyul+rmvlmgtjzlm+434BltLfPhnMcnR7KKSK9ag1BSPznnX+l
         EGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=cEx41mUNETFbYUOzVN18ifU8dkNJ2uJ17BjKZtGtfEc=;
        b=rywwkOTJKztzJoc7JZ7no5+u80Wtz+SjG46ifTb6Xbf/E0bcSjyKKJJ/t1QEk7hdVq
         QBFwrZydfeDSQNDDSE8bmV5ttzxrQ708vfDiRqXRMKzsYWOkFgL+/lTgQ5ks0SYHpDs9
         RRqCBk3rlnQSIEOYrWUs8Lo4FDYdxuf6UobZAn+Z2nGKe/EKN3XF4I9PNAL7jPgT1UgD
         XVUVN0ZKGz93+DQXGJJ5x/T+TRveHlqBh+LHIsjeMy11A+fAEP4qpeckV+vedQGfuUAX
         T8rf1vDBL0KvJIcVTe22OjHwgrVpKQ0JqmUDIqMkLnB88j58e7AEF1nkXjxW4ha4tzN0
         zijg==
X-Gm-Message-State: AOAM530GdZQGJaTRWfWvmBZqBFJlcXJPcyeJ+kl9zQtKXg/yshS+F0sj
        cBkZ9wcEj0QyJhYaijI8m3/omoX8pj0hGQ==
X-Google-Smtp-Source: ABdhPJwfT8i+VVHWOR/aYbe/QZQXxl6/4nJYOnQmQuaxfbnKsZ2sH4BUb3D26hNabZQ+R1F2guBLXw==
X-Received: by 2002:a05:6830:b90:b0:605:cb3a:8fc3 with SMTP id a16-20020a0568300b9000b00605cb3a8fc3mr5285441otv.30.1651552639485;
        Mon, 02 May 2022 21:37:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf22-20020a056808191600b00325cda1ff92sm3002067oib.17.2022.05.02.21.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 21:37:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6f69677c-18d9-abd9-93d7-cf1f29603ed6@roeck-us.net>
Date:   Mon, 2 May 2022 21:37:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Tzung-Bi Shih <tzungbi@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220429131349.21229-1-pali@kernel.org>
 <20220429131349.21229-2-pali@kernel.org> <YnCoQUGQsXIfbowQ@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/2] watchdog: max63xx_wdt: Add support for specifying
 WDI logic via GPIO
In-Reply-To: <YnCoQUGQsXIfbowQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 20:57, Tzung-Bi Shih wrote:
> On Fri, Apr 29, 2022 at 03:13:49PM +0200, Pali Rohár wrote:
>> @@ -27,6 +27,7 @@
>>   #include <linux/io.h>
>>   #include <linux/slab.h>
>>   #include <linux/property.h>
>> +#include <linux/gpio/consumer.h>
> 
> It would be better to keep them alphabetically.  Anyway, they aren't sorted
> originally...
> 
>> +static void max63xx_gpio_ping(struct max63xx_wdt *wdt)
>> +{
>> +	spin_lock(&wdt->lock);
> 
> Does it really need to acquire the lock?  It looks like the lock is to prevent
> concurrent accesses to the mmap in max63xx_mmap_ping() and max63xx_mmap_set().
> 

Actually, that doesn't work at all. spin_lock() directly contradicts
with gpiod_set_value_cansleep().

>> +	gpiod_set_value_cansleep(wdt->gpio_wdi, 1);
>> +	udelay(1);
> 
> Doesn't it need to include <linux/delay.h> for udelay()?
> 
>> @@ -225,10 +240,19 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
>>   		return -EINVAL;
>>   	}
>>   
>> +	wdt->gpio_wdi = devm_gpiod_get(dev, NULL, GPIOD_FLAGS_BIT_DIR_OUT);
>> +	if (IS_ERR(wdt->gpio_wdi) && PTR_ERR(wdt->gpio_wdi) != -ENOENT)
> 
> Use devm_gpiod_get_optional() to make the intent clear.  Also, it gets rid of
> the check for -ENOENT.
> 
>> +		return dev_err_probe(dev, PTR_ERR(wdt->gpio_wdi),
>> +				     "unable to request gpio: %ld\n",
>> +				     PTR_ERR(wdt->gpio_wdi));
> 
> It doesn't need to again print for PTR_ERR(wdt->gpio_wdi).  dev_err_probe()
> prints the error.
> 
>>   	err = max63xx_mmap_init(pdev, wdt);
>>   	if (err)
>>   		return err;
>>   
>> +	if (!IS_ERR(wdt->gpio_wdi))
>> +		wdt->ping = max63xx_gpio_ping;
> 
> Thus, the max63xx_gpio_ping() overrides max63xx_mmap_ping() if the GPIO was
> provided?  It would be better to mention the behavior in the commit message.
> 
> Also, could both the assignments of `wdt->gpio_wdi` and `wdt->ping` happen
> after max63xx_mmap_init()?

