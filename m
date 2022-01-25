Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0015A49B094
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiAYJju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574598AbiAYJfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:35:25 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF4FC0613EC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 01:35:25 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id t9so4094618lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 01:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ds7Vt/tFNVx1HfjRDYOvcP2J7EyY9TlFxYDikA7nbJ0=;
        b=qbcQnPQQ2zXFB+OtbktgbOTcYl45D+Hu8HRufY3rYgzbZVIeWHxdg2bv6C6eNjMbKI
         Zpmq23qIrrxaH/lb6lFd8+EsA4NYaKH6kTZdBvNH8MfGBKlOvpSviQH2DqH7IvPehpQK
         HozEjAWjVZ1E+kjWAH3gSQM4bFxtr6y8TY7KZUJXt+5o4ngpb3d9mUm5Muw5oB5Rx24q
         0EEEdAmE9+L15lOXx6rndJcCMpddOKG8hCYfcW5IzMSx9fEiYS5Zf/8A3EnPFVYyrvKU
         nw5NiErF9wJF+0RujXrRZZEy449AmS5ufFYJbM8XY3p3jBViceYTUeNldsAq3LWJXpXK
         rgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ds7Vt/tFNVx1HfjRDYOvcP2J7EyY9TlFxYDikA7nbJ0=;
        b=bSfiBvl9Ej9kfavW8N1RY42Ewl4BFlWtfsArFX2wna05eBB+Hewc6TpDeGWoTodr2U
         WgkBGTYHbvK/uSz8WQDJI1myJAHjT/iyJJh3lMZnsDpadW6fpak0Ff2MBCiCduLww3km
         15foa9qxUruIctCHozv8fxCoiG/Zjn1hEPqEb4LfyIpyOstym5biEp27AESYUQZryFUE
         wb9QxS+bTrK4oIFKcu+s67PWZYD7zjrGWsC0lGGpymtaDXn51uYEqXR2tr9NS3378Hgz
         lOyo8aptfo84SwsbE9kuguYhQZde1+Ojypj48UgXdnDvanyDbEbXWw/2NqndbWnHMYKc
         SIhg==
X-Gm-Message-State: AOAM530UirQZ9LsF0eGIAKlKGXF+90YI5OeyMMIYZpk1qS9ryZHyYI/E
        PbO/Y/O0ZnKFisS3Jy//kEJgSA==
X-Google-Smtp-Source: ABdhPJx3bagG4o8dfiP2tuzEmgv0sHDRPbmKATo01+IryqyUsHfd0gbOBfqDjquWLls8b8Tc3+w8mg==
X-Received: by 2002:a2e:9217:: with SMTP id k23mr13723170ljg.229.1643103323585;
        Tue, 25 Jan 2022 01:35:23 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id i9sm1431729lfj.32.2022.01.25.01.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 01:35:23 -0800 (PST)
Message-ID: <a7a6ddd2-9d40-3ac2-2b7f-bb521c8d3728@cogentembedded.com>
Date:   Tue, 25 Jan 2022 12:35:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drivers: irqchip: add irq-type-changer
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-kernel@vger.kernel.org
References: <20220124095652.522099-1-nikita.yoush@cogentembedded.com>
 <878rv58ghy.wl-maz@kernel.org>
 <a179c80c-7ce8-da1a-f344-5d72b65c3da4@cogentembedded.com>
 <874k5s8a32.wl-maz@kernel.org>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <874k5s8a32.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> I also don't see why you model this as the actual device that triggers
>>> the interrupt.
>>
>> Well, that somehow matches the physical reality. In the case of wl18xx
>> on KF, physically the interrupt signal indeed originates from the
>> intermediate chip - the inverting level-shifter.
> 
> Reality? By allowing something like an edge-to-level conversion? How
> can that work?

Edge to level can be problematic, but level to edge does not cause any difficulties, nor in generating 
nor in handling.

>> In contrary, an abstraction of intermediate entity that does a static
>> conversion of the trigger type and does not need any software control,
>> looks sane. And, hardware designers do strange things sometimes, I
>> won't be surprised observing a change from level to edge one day.
> 
> If you think that it can happen without a HW register that latches the
> edge and requires an ack, you need to question your understanding of
> an interrupt life cycle, and of the properties of the various trigger
> types.

There are plenty of devices capable to signal both level and edge interrupts, configurable by a 
register. Basic handling is always the same, and involves masking the interrupt at interrupt controller 
while IRQs disabled, then enabling IRQs, then programming the device to clear the interrupt condition, 
then unmasking the interrupt at interrupt controller. If the trigger type is level or edge, is only 
interesting to interrupt controller driver, but not to a wider scope.

Nothing stops hw designers from doing all sort of strange things with interrupt signals. Right now I 
have a board on my desk where interrupt signals from several chips are wired to inputs of a logical AND 
element and the output of that is wired to SoC's gpio. I don't see what stops them tomorrow from setting 
up their CPLDs to issue a short impulse at output in return to a level change on input. And that will be 
a level to edge converter.

>> In driver's init, I only call of_irq_parse_one() for interrupt defined
>> in the changer's node. This does not create a mapping for it. The
>> mapping is only created when changer's "interrupt-child" creates a
>> mapping for their interrupt - then changer's alloc() routine calls
>> irq_domain_alloc_irqs_parent() in the same way as all other
>> hierarchical irqchips do.
>>
>> I don't see where double mapping can appear here. Please explain.
> 
> Just look at your code. You start probing a device that has an
> 'interrupts' property. This triggers the allocation of an interrupt.

Where does it trigger it?

And what is this "allocation", after all? Is it allocation of virq number? That allocation happens when 
irq_create_fwspec_mapping() calls irq_domain_alloc_irqs(). But this path does not necessary gets 
executed in probing. In the current irq_tyoe_changer driver, it is not.


Nikita
