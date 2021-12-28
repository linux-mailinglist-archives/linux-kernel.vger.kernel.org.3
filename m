Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4248A480CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 20:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbhL1TDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 14:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbhL1TD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 14:03:27 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F83C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 11:03:27 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id i11so19678012ljm.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 11:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kGZrv9UpYltVRc8QB5252cW36uUUIgY+7pGeLvcC0zA=;
        b=vJNftmK7/XaU63ZQWUX5nrqi2BpDNhP6J89YulwgvPDzjAOa7tsKDbE9VH8T1oBpDA
         WUgV3O9yZl+nQEFUETy7yHehAN4YLapFo7xqC1lOmd5Lg2ekR34WtH5nUNd3EoLyA0iN
         AE3x2v6fQrxoNvqtOi22OBqAYsI3BwtAU72FuvCypnFKvpwUjsa2CakN3BnwHwnGC6Oy
         zzOEw4Fxu3hdmmTW6qSj2VAlTk6Mz6lrv4FZYibkBmi7BLYS48UBFVxd6g0PNx9THxwc
         TuZBhDLscyq/lma1r/LP80aN4WtiI0YBflBdcPeHEFkM/28pyoMJqUbE8sjb7FCoqh3B
         nPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kGZrv9UpYltVRc8QB5252cW36uUUIgY+7pGeLvcC0zA=;
        b=smy4x29jKPN0DQifV6oLGA3VUw0HM6DouxXS8SKShjKo8dqiVmoaXVF8BdR/z55wVR
         8aPigPxHRFRs14LI0e3u2RFNcIDdHsAuwFuy0SR1aWQsRQkSVDon3Tz5oOtfX34VvWjJ
         MIN7nEPfH5fo7QsulQp2vh351yF+yfPomrf19JWCVcF7AZOyHdalVUw0Gxfwtg5yo34I
         tC/wzdB6kTWKSEnAnKEcjDoYYcCDWgWxcTyEkybf3mg2moVFQ5z23VOgTxzfllS09LiL
         BZxxVJjp1L7tY6OyjssAeh9KfunaLbKGM+0T69gEwnCD8X7zo1078yWeglDyCypu+LpM
         iWZg==
X-Gm-Message-State: AOAM5316HIu+Qzf4kMtmOCudoqfXIqQA7IS6tIkmelyA41I06vmoOYfX
        Da9mL+up82sHDx3lZOR1I66S2DmWTKr2b+Ca
X-Google-Smtp-Source: ABdhPJyploqg3aoSaHG23ApAopJcmJj5mxJB8lJgwe4SS3UI0gZp73YPAuu/sWLbhcsNMmfoZjuF+A==
X-Received: by 2002:a2e:93c6:: with SMTP id p6mr19231103ljh.476.1640718204781;
        Tue, 28 Dec 2021 11:03:24 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id i4sm1324109lfu.51.2021.12.28.11.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 11:03:24 -0800 (PST)
Subject: Re: [PATCH/RFC] drivers/irqchip: add irq-inverter
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211228165642.2514766-1-nikita.yoush@cogentembedded.com>
 <87h7aszj70.wl-maz@kernel.org>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <b5e0ff57-885a-051b-4c4c-a02b005fa1f1@cogentembedded.com>
Date:   Tue, 28 Dec 2021 22:03:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87h7aszj70.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

>> Interrupt trigger type is typically used to configure interrupt
>> controller to properly interpret interrupt signal sent from a device.
>>
>> However, some devices have configureable interrupt outputs, and drivers
>> tend to use interrupt trigger type also to configure device interrupt
>> output.
>>
>> This works well when device interrupt output is connected directly to
>> interrupt controller input. However, this is not always the case.
>> Sometimes the interrupt signal gets inverted between the device
>> producing it and the controller consuming it. Combined with both sides
>> using the same interrupt trigger type to configure the signal, this
>> results into non-working setup regardless of what interrupt trigger type
>> is configured.
> 
> Regardless? Surely there is a canonical, working configuration.

It is working as long as either hardware delivers interrupt signal without inversion, or only one side 
(producer or consumer) is configured while the other side stays constant.

It does not work when hardware inverts singnal and both producer and consumer are configured.

>> Usage example, for Kingfisher extension board for Renesas Gen-3 Soc,
>> that has WiFi interrupt delivered over inverting level-shifter:
>>
>> / {
>> 	wlcore_interrupt: inverter {
>> 		compatible = "linux,irq-inverter";
>> 		interrupts-extended = <&gpio1 25 IRQ_TYPE_EDGE_RISING>;
>> 		interrupt-controller;
>> 		#interrupt-cells = <0>;
>> 	};
>> };
>>
>> &wlcore {
>> 	interrupts-extended = <&wlcore_interrupt>;
>> };
> 
> So you don't describe the trigger at the endpoint level, but at the
> pseudo-interrupt controller level? /me feels mildly sick.

Could you please explain how this could be done?

Regardless of what is configured at endpoint side, interrupt controller driver will use that to set up 
interrupt controller, and wl18xxx driver (in the case) will use that to configure wl18xx. That results 
into SAME settings at producer and consumer sides, and hardware requires OPPOSITE sittings at producer 
and consumer sides.

It is not a problem in interrupt controller driver - that driver does it's job correctly, setting up the 
interrupt type that is requested.

It is likely not a problem in interrupt source (i.e. wl18xx) driver - that driver tries to set up it's 
irq in the way that will work with any interrupt controller. Perhaps it can be possible to update wl18xx 
driver to allow fixed setup of interrupt polarity, but that looks like addressing problem at wrong 
location. It is not an issue with wl18xx. There are quite a few drivers in the tree that setup interrupt 
polarity for their devices based on what irq_get_trigger_type() returns.

The root cause if the issue is the board itself, that inverts the signal. Thus it looks correct to tie 
the fix to the board. And a device node describing the interconnect looks like an elegant solution for this.

> And by the way: "An interrupt specifier is one or more cells of data
> (as specified by #interrupt-cells) ...". Ergo, #interrupt-cells cannot
> be 0 when the interrupt controller can be an interrupt-parent.

Code works with #interrupt-cells=0 correctly, as long as interrupts-extended property is used at 
producer side.

>> Then, wl18xx driver gets IRQ_TYPE_EDGE_FALLING return from
>> irq_get_trigger_type() call, and configures interrupt output for that.
>> Then the signal is delivered inverted to the GPIO module, and handled
>> correctly, because GPIO is configured for IRQ_TYPE_EDGE_RISING.
> 
> So this is only to avoid writing the correct device tree?

No. It is an attempt to describe a case that seems to be not currently describable.

Vendor BSPs solve this by commenting out irq polarity setup in drivers. Thus obviously breaking use 
cases other than these BSPs are for. I'm trying to suggest a portable alternative instead.

>> - why not using hierarchial irq_domain?
>> - because with hierarchial irq_domain, same interrupt gets the same virq
>>    number at all levels, and trigger type is tied to virq number, so need
>>    different virq numbers for reporting different trigger types
> 
> Why would you have different interrupt numbers? A given line has one
> configuration at any given point, and only one.

The goal is - make irq_get_trigger_type() returning different values for producer and consumer of the 
interrupt. Because, that matches the hardware behavior.

While irq_get_trigger_type() is used for that, returning different values for producer and consumer is 
obviously impossible.

Originally, I was considering to add a different API to use by interrupt producer instead of 
irq_get_trigger_type(), to deliver information configured by additional flag in DT node for interrupt 
producer. I.e.
     interrupts = <25 IRQ_TYPE_EDGE_RISING | IRQ_INVERTED_ROUTE>

But, inverted route is not a feature of interrupt, it is a feature of connection. I.e. nothing stops 
from having several sources routed to the same interrupt, and having only one of these sources inverted. 
This means, the IRQ_INVERTED_ROUTE flag is not interrupt's flag but connection's flag. And, a virtual 
irqchip looked like a good abstraction to describe connection.

The fact that this make the entire solution much smaller, was just a pleasant side-effect ;).

>> - why using request_irq() for parent irq, instead of setting up chained
>>    interrupt in irqchips?
>> - because this way code is much simpler, and shall work for all cases
>>    (such as normal/threaded parent irq, normal/threaded child irq,
>>    different parent interrupt chips, etc)
> 
> And that's a NAK for deliberately violating the irqchip API.

I've learned the idea of calling generic_handle_irq() from interrupt handler from 
Documentation/driver-api/gpio/driver.rst

It looked as an elegant solution to avoid complexity (such as: a chained interrupt is activated at 
registration time, assuming there is a piece of hardware [chained controller] that will avoid interrupt 
firing until a chained source fires...  but for pure-software chained interrupt, must keep parent 
disabled up to when a handler for child is installed)

But, I definitely don't insist on this approach.

>> - why just not introducing separate API for consumer-side and
>>    produced-side trigger type?
>> - because with the chosen approach, no changes are needed to any cases
>>    that don't suffer from inverted interrupt routing
> 
> The right way to do it is to use the existing API by exposing the
> inverter (there are existing examples in the tree, using the
> hierarchical model). It isn't rocket science, and not much more code
> than the pile of hacks^W^W^Wcreative approach you have.

Could you please point me to such examples? I could not find any.

Thanks,

Nikita
