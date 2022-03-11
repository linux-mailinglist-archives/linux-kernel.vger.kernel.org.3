Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFA54D62B5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349009AbiCKOBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348984AbiCKOBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:01:12 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14F11C4B37;
        Fri, 11 Mar 2022 06:00:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id C822C1F46391
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647007206;
        bh=3WEzDbh+VAM6VRDltBG23G7sJCG0mykuVJq3j9dIzZI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d3hHRpXiySQZvdS+IQF5v05NBTdx2UJj9qa9PF45Ik97NIAv/cqAA9syE4W1C7ONs
         x+56gwI9rqywv3S1RmhYy8RRIBfZoBYj8YQpzfJDen24tM71spoYEda/55E7y/gJAu
         USYszBds2y/y55xEZkq0r8YQyv4ZiYPDJjLMhsa6mJarw+1mrR00VKflrqa+iGHP4H
         Qcmb6pExdIu7brJWlC5Pc+mKfqD5K0D/zEkcP5PlIHyaRwJaM0xpNuy/+5lAxX3rN+
         6/T8BGoyIgDuRyWcgAmf2Ema4XC/epPve1/7pZIRJVpHfAL86UNeFCveglTvhl5eUp
         i0Zwzu9g+97kg==
Subject: Re: [PATCH] gpio: Restrict usage of gc irq members before
 initialization
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, krisman@collabora.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
References: <20220310132108.225387-1-shreeya.patel@collabora.com>
 <CAHp75VdGWxnxRzEhSknXHRZf1SX0x=pvca_CL0VinWNFcqCQwg@mail.gmail.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <c08664da-d83f-8789-cc8c-5ae3339d9b89@collabora.com>
Date:   Fri, 11 Mar 2022 19:29:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdGWxnxRzEhSknXHRZf1SX0x=pvca_CL0VinWNFcqCQwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/03/22 8:14 pm, Andy Shevchenko wrote:
> On Thu, Mar 10, 2022 at 3:22 PM Shreeya Patel
> <shreeya.patel@collabora.com> wrote:
>> gc irq members are exposed before they could be completely
>> initialized and this leads to race conditions.
>>
>> One such issue was observed for the gc->irq.domain variable which
>> was accessed through the I2C interface in gpiochip_to_irq() before
>> it could be initialized by gpiochip_add_irqchip(). This resulted in
>> Kernel NULL pointer dereference.
>>
>> To avoid such scenarios, restrict usage of gc irq members before
>> they are completely initialized.
> Fixes tag?
>
> ...


We don't really have any specific commit which introduces this issue so
I did not add fixes tag here.

>> +bool gc_irq_initialized;
> Non-static?
>
> Why is it global?
>
> ...
>
>> @@ -1593,6 +1594,8 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>>
>>          acpi_gpiochip_request_interrupts(gc);
>>
>> +       gc_irq_initialized = true;
> This is wrong. Imagine a system where you have more than one GPIO chip.
>
> ...


Yes, thanks for pointing it out. This flag introduced should be a member of
gpio_chip structure as mentioned by Gabriel and then it should work for
multiple gpio chips as well.

>> -       if (gc->to_irq) {
>> +       if (gc->to_irq && gc_irq_initialized) {
>>                  int retirq = gc->to_irq(gc, offset);
> Shouldn't it rather be something like
>
>    if (gc->to_irq) {
>      if (! ..._initialized)
>        return -EPROBE_DEFER;
>      ...
>    }
>
> ?


No, the above code will still bring in issues when gc->to_irq is NULL
and will return -ENXIO. We have seen race in registering of gc->to_irq
as well which is why we had introduced the following patch as the first 
step.

https://lore.kernel.org/lkml/20220216202655.194795-1-shreeya.patel@collabora.com/t/


Thanks,
Shreeya Patel

>
> --
> With Best Regards,
> Andy Shevchenko
