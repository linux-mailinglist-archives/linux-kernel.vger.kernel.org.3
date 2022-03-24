Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4BD4E6ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355461AbiCXWlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355456AbiCXWlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:41:18 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE15ADD64
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:39:42 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bc27so4975808pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2jY/kvhxQ4cJoS/OWK7PPPMsG+7IB6Z63fZGYtknmfE=;
        b=TGENlreCIufcddlhlrkoSHHWl1TXnDesvj9AktoHDNBTqe5aBdPKRaUXx8Yc121LtL
         FdXeOuAhaYFB1KyhIRm5WGEnj6zFsWeCID1MnJAfJqjaVhfJFscq/8zUq6i+Mw5qadzv
         o1GpiruMK6wysCNEOv+vTnP+2g4K2iq74dWTN/AchARJhsNTUI6WnoVsMHS7OhrYYtWR
         /8KJf+a6ANpmgu/hWKq3Q5fW+eyZ7CDOiws9wa2kuSotxmCPf1LwcmZOqM+9pocaPW8/
         MJrge55ks6nuZkuUxK3Ayi0LGWSKJ1IJD5410JXNMKkpteoDN0uTqMqYFxCEHFkGEzWu
         o2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2jY/kvhxQ4cJoS/OWK7PPPMsG+7IB6Z63fZGYtknmfE=;
        b=mqRrAQyOhknHaGgGMzFWalZ5OZJE+DkABX9LWvC3y0xxe7rxNSqSSJEPFO7ep/I3Yy
         gedoiqFH+L7Vt1ChMs2iRZjSHedMybAeXlOSFramz4qAQ1rXrJzDhevdIaRQTQ+uDZ1N
         geaoCmlFE2ynDkaNFZVEhtIjx5WJw2xnPDHiNt1s2q9Tvg+tet30NqSrwWN/B17Avk6m
         +vyxGKbBUdaiszH9l8RaBbYWI95+RiKfwfYb4myaLiBQ3BbH4uUnd0LPTyp729JFJebq
         CSstRA7LowsBty6qPvJsFOSGqITSmTUt/gL6whMw3KdteWnCgUIilf4/siiLcfDXrrrc
         qLSg==
X-Gm-Message-State: AOAM5333OojZJSNvh1PLcRu0xt7hpL17nnXDusA7F89kN6ikIgj8rihm
        tbWD4UfogpK1p+SqHePl6Cs=
X-Google-Smtp-Source: ABdhPJxsM9J08Gw3pvsBw3nmu1ZLiXzknA2dH7VOOqz9+PyNigXg7OSjPGm2ihlYQMw31wIadPudTg==
X-Received: by 2002:a63:1266:0:b0:381:5071:e942 with SMTP id 38-20020a631266000000b003815071e942mr5777490pgs.86.1648161582224;
        Thu, 24 Mar 2022 15:39:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id pj9-20020a17090b4f4900b001c744034e7csm11206774pjb.2.2022.03.24.15.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 15:39:41 -0700 (PDT)
Message-ID: <145fa83e-c4c8-ec0b-4626-8f99655174ba@gmail.com>
Date:   Thu, 24 Mar 2022 15:39:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] ARM: Clamp MAX_DMA_ADDRESS to 32-bit
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20220324175417.1014562-1-f.fainelli@gmail.com>
 <20220324175417.1014562-3-f.fainelli@gmail.com>
 <CAMuHMdWyDLoOit-VYPzLXxLz6W300xpo_wrqj=Pr9sZSwk_OwQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAMuHMdWyDLoOit-VYPzLXxLz6W300xpo_wrqj=Pr9sZSwk_OwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 13:31, Geert Uytterhoeven wrote:
> Hi Florian,
> 
> On Thu, Mar 24, 2022 at 6:54 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>> MAX_DMA_ADDRESS is a virtual address, therefore it needs to fit within a
>> 32-bit unsigned quantity. Platforms defining a DMA zone size in
>> their machine descriptor can easily overflow this quantity depending on
>> the DMA zone size and/or the PAGE_OFFSET setting.
>>
>> In most cases this is harmless, however in the case of a
>> CONFIG_DEBUG_VIRTUAL enabled, __virt_addr_valid() will be unable to
>> return that MAX_DMA_ADDRESS is valid because the value passed to that
>> function is an unsigned long which has already overflowed.
>>
>> Fixes: e377cd8221eb ("ARM: 8640/1: Add support for CONFIG_DEBUG_VIRTUAL")
>> Fixes: 2fb3ec5c9503 ("ARM: Replace platform definition of ISA_DMA_THRESHOLD/MAX_DMA_ADDRESS")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
>> --- a/arch/arm/include/asm/dma.h
>> +++ b/arch/arm/include/asm/dma.h
>> @@ -8,10 +8,12 @@
>>   #ifndef CONFIG_ZONE_DMA
>>   #define MAX_DMA_ADDRESS        0xffffffffUL
>>   #else
>> +#include <linux/minmax.h>
>>   #define MAX_DMA_ADDRESS        ({ \
>>          extern phys_addr_t arm_dma_zone_size; \
>>          arm_dma_zone_size && arm_dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
> 
> "arm_dma_zone_size < (0x10000000 - PAGE_OFFSET)" looks
> like an overflow-avoiding version of
> "PAGE_OFFSET + arm_dma_zone_size < 0x10000000".
> However, PAGE_OFFSET is always larger than 0x10000000,
> so "0x10000000 - PAGE_OFFSET" is a rather large number?

Yes it is a large number, though I am not too sure what the intention of 
this check was in the first place, whether it denoted the largest known 
DMA size of any machine at the time, or if it has any relationship to 
lowmem (in which case it does not account for its exact value since it 
can be changed indirectly via vmalloc= on the command line).

We ought to be just fine with keeping only:

min_t(phys_addr_t, (PAGE_OFFSET + arm_dma_zone_size - 1), 0xffffffffUL);

Santosh, what did 0x10000000 mean when you added it?
-- 
Florian
