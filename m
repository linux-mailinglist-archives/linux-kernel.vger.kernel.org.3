Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309C14625E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhK2Wob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhK2Wn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:43:57 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062D2C0FE6F0;
        Mon, 29 Nov 2021 13:56:08 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id bf8so37297834oib.6;
        Mon, 29 Nov 2021 13:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S4HMg9Cqzy49DZfObS/nodtisQ36nE3uRedqyLq9A6A=;
        b=JZRRDbL8JoEWWc7Jwo7kkQWNsWK2dK8VaoiwN2hB/Md6qF6r0dkbSsAwFB6FNTOLNi
         jw+yOSt3Vgabq3jf0WsWHKWB4/dhgwDyy+dkkUclaf0T/fmb4MXylaT8OGTplVVYSohJ
         cvoVG1embbmZ3m0y7ee2QjncNtarL7DtUcEFiXz0bSLUmQ6fczwo2Rq/mBmhp0lMLf19
         L0KslFNjz7XiYgQAZCTPE7TzKYj9CYJTpUdMmq8cMcfogwYqaZkjaaK4pqmg+FJxnUaF
         4Y1DkMkWXS3INFSahsb8WeIJzmI/kG0aNNnQDWWn/VSIikw29GTSmNE93Cl3J1MNhliM
         KSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S4HMg9Cqzy49DZfObS/nodtisQ36nE3uRedqyLq9A6A=;
        b=udao0RmqanOKOpKKFub7CWNPkt0iQuLd0gxhPyPpfKITqIkuviKYPkNUpwyh9K5nIX
         k/U9tkmnYo2HTAhBsGV7Hu0LKmM0T79xuAd4ZUW6ccABrdwdoQ9MQDEYTgYA4PqJJT3w
         3XhdMFl0WPRjfMkjsvVA0Cbnj5Pbml3EdWpamzklML1t14bxwTnVblg7p7ByD8IHcbpe
         Z6FWIcf5aDXV+826nlUkqc+0IsDfilxBVpkDQLI9ajUjCTg+1kqh42CR0xcUpPsTrT9S
         WpZq971dS8PSfFQwmgXI9LTGYmfAkyA6fMH+LBAqm662EujIWk5xC/8LJuFawFygq9xZ
         WdqA==
X-Gm-Message-State: AOAM531wNKdp6+QoXR1kPkbCoX/D/8+XkYzNCZaucfhhcH2jhpHFKCoj
        ZGLqzqTKb/zOxbZFqxEZm+g=
X-Google-Smtp-Source: ABdhPJw7twICvTFN/dcfPEhKd1KQPj98QA2U0U256m35GR0DANz0+GAeqVcmWCdf0VP6hWGlSonb3A==
X-Received: by 2002:a05:6808:c7:: with SMTP id t7mr688504oic.30.1638222967419;
        Mon, 29 Nov 2021 13:56:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 111sm2840564otu.55.2021.11.29.13.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 13:56:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>
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
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 7/9] watchdog: max77620: add support for the max77714
 variant
Message-ID: <65a9c26d-31cb-7c4c-df87-12aee8f43578@roeck-us.net>
Date:   Mon, 29 Nov 2021 13:56:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8efe5354-6308-4f0c-a0c8-6657f705cfb1@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/21 1:24 PM, Luca Ceresoli wrote:
[ ... ]
>>>   
>>> +static const struct max77620_variant max77620_wdt_data = {
>>> +	.wdt_info = {
>>> +		.identity = "max77620-watchdog",
>>> +		.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
>>> +	},
>>
>> That does not have to be, and should not be, part of device specific data,
>> just because of the identity string.
> 
> Ok, no problem, will fix, but I have two questions.
> 
> First, what's the reason? Coding style or a functional difference?
> Usually const data is preferred to runtime assignment.
> 

wdt_info is not chip specific variant information as nothing but the identity
string is different, and there is no technical need for that difference.

> Second: it's not clear how you expect it to be done. Looking into the

I gave you three options to pick from.

> kernel it looks like almost all drivers set a constant string. I could
> find only one exception, f71808e_wdt:
> https://elixir.bootlin.com/linux/v5.16-rc3/source/drivers/watchdog/f71808e_wdt.c#L471
> 
>> Either keep the current identity string,
>> mark max77620_wdt_info as __ro_after_init and overwrite the identity string
>> there during probe
> 
> And also remove 'static' I guess. Hm, I don't love this, as above I tend
> to prefer static const when possible for file-scoped data.
> 

Where did I suggest to remove 'static', and what would be the benefit of making
the variable global ?

>> or add the structure to max77620_wdt and fill it out there.
> 
> Do you mean like the following, untested, kind-of-pseudocode?
> 
>   struct max77620_wdt {
>   	struct device			*dev;
>   	struct regmap			*rmap;
> 	const struct max77620_variant	*drv_data;
> +	struct watchdog_info		info;     /* not a pointer! */
>   	struct watchdog_device		wdt_dev;
>   };
> 
> and then, in probe:
> 
>     wdt->dev = dev;
>     wdt->drv_data = (const struct max77620_variant *)id->driver_data;
>     /* ... assign other wdt fields ... */
> +  strlcpy(wdt_dev->info.identity, id->name, \
> +          sizeof(wdt_dev->info.identity));
> +  wdt_dev->info.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | \
> +                          WDIOF_MAGICCLOSE;
> 
For example, yes.

> Finally, what about simply:
> 
>   static const struct max77620_variant max77620_wdt_data = {
> 	.wdt_info = {
> -		.identity = "max77620-watchdog",
> +		.identity = "max77xxx-watchdog",
> 		.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | ...
> 	},
> 
> and always use that struct unconditionally? The max63xx_wdt.c driver
> seems to do that. Or, if this is an issue for backward compatibility (is
> it?), just leave max77620_wdt_data and the .identity field will always
> be "max77620-watchdog" even when using a MAX77714.

Also ok with me.

Guenter
