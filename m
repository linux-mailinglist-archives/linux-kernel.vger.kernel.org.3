Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433D056934C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiGFU1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiGFU1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:27:11 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5AC240B9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:27:09 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c13so19908221qtq.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 13:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vCGSz7zusjtnkr3Q7O2/mZ0UptwiPDRL0tl5M8VVAws=;
        b=N4fyaXTugfSCMZzh6KI2vlmFHUfeTOqy/470sw/X+usYSnPM9In0xLjYkmDjd1mFtT
         y3OJ4UEyAFBCLLThCuWjlQoMRIRdOVZaOP27j75oohImWgTaiXZafVRVRABTKI5NlsLw
         RfWYfufXTnsFMWQTT5kQuypiXmByp0j4Bh4Ml1DzSMjBEslGAr4erHqIeOgcJwesjvJv
         zwfTi0hx/H2Y8W2s90PyLrxiSjQCHEB8nh0qGMxxRECaYaP6yBFJ+Jr+rRAbLcQxEpH3
         0tbYiIv0pyJJXRqU+o9x2Y2AH263smwNQgEn/JQn4ollFeeqkI0yZBLuAIgpPeybj5Lm
         S4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vCGSz7zusjtnkr3Q7O2/mZ0UptwiPDRL0tl5M8VVAws=;
        b=pCmCUonxDlvasZonbJtOx/zv8W5laaN2ZGgWCxwAmbufOIPbr1eNFAsUSBRc7aXMjx
         hFxz06FYcHmh1nCTet37grxdD64d6PXizHfh7GN03u2Cf4H53eMt5Fue3EGN7jO9kUWi
         R/LDkGNi7zqY3ASUsmt6roDY8Q3SoZOQ+9ZAt9VJjnaSQ5sMqmKIkB32+gO/FGiz+jqy
         xFxQzvin8XtJygR4pQXKkfSUN8Wb46ElH9eta4Mj/BtXxMzWRchiXmLNMi0dEAzhuH+c
         BK1jEDWa5hWmsIzXRT0XLDQT0JL5Or/nL1ZRVTH0kg2jlZvdN9wopwqCIeIlmEgMOAEq
         btVw==
X-Gm-Message-State: AJIora/ZxFJ91TSMzzju3HyFhi3IWDN/V/OnVYk3Jh/KVCuOUyS1RYBH
        vH+/al6wih+OrgttAwfMNOQ=
X-Google-Smtp-Source: AGRyM1v7f/g+X7HWvshawn07kP5U99Z+MRgAqqZb8/Z4h6E+6221QuYDjmcm9dFzzSUq4rooG7CK+w==
X-Received: by 2002:a05:6214:c8c:b0:473:3e1:5007 with SMTP id r12-20020a0562140c8c00b0047303e15007mr8587013qvr.1.1657139228912;
        Wed, 06 Jul 2022 13:27:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o4-20020ac87c44000000b003164efd0a5fsm13890959qtv.41.2022.07.06.13.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 13:27:08 -0700 (PDT)
Message-ID: <dba1161c-4cee-0dfd-df62-385396e62679@gmail.com>
Date:   Wed, 6 Jul 2022 13:26:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] ARM: Fix MAX_DMA_ADDRESS overflow
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        open list <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20220706164606.68528-1-f.fainelli@gmail.com>
 <CAMuHMdVJG0cA4v+pfyeO8PpzFxtrggNeRrfEB8QFBiEZjYPt3A@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAMuHMdVJG0cA4v+pfyeO8PpzFxtrggNeRrfEB8QFBiEZjYPt3A@mail.gmail.com>
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

On 7/6/22 12:44, Geert Uytterhoeven wrote:
> Hi Florian,
> 
> On Wed, Jul 6, 2022 at 6:46 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>> Commit 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
>> added a check to determine whether arm_dma_zone_size is exceeding the
>> amount of kernel virtual address space available between the upper 4GB
>> virtual address limit and PAGE_OFFSET in order to provide a suitable
>> definition of MAX_DMA_ADDRESS that should fit within the 32-bit virtual
>> address space. The quantity used for comparison was off by a missing
>> trailing 0, leading to MAX_DMA_ADDRESS to be overflowing a 32-bit
>> quantity.
>>
>> This was caught with the bcm2711 platforms which defines a dma_zone_size
>> of 1GB, and using a PAGE_OFFSET of 0xc000_0000 (CONFIG_VMSPLIT_3G) with
>> CONFIG_DEBUG_VIRTUAL enabled would lead to MAX_DMA_ADDRESS being
>> 0x1_0000_0000 which overflows the unsigned long type used throughout
>> __pa() and __virt_addr_valid(). Because the virtual address passed to
>> __virt_addr_valid() would now be 0, the function would loudly warn, thus
>> making the platform unable to boot properly.
>>
>> Fixes: 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> Changes in v2:
>>
>> - simplify the patch and drop the first patch that attempted to fix an
>>    off by one in the calculation.
> 
> Thanks for the update!
> 
>> --- a/arch/arm/include/asm/dma.h
>> +++ b/arch/arm/include/asm/dma.h
>> @@ -10,7 +10,7 @@
>>   #else
>>   #define MAX_DMA_ADDRESS        ({ \
>>          extern phys_addr_t arm_dma_zone_size; \
>> -       arm_dma_zone_size && arm_dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
>                                                    ^^^^^^^^^^
> 0x10000000ULL, as the constant doesn't fit in 32-bit.
> However, both gcc (9.4.0) and sparse don't seem to complain about
> the missing suffix (anymore?).

Thanks, I will the ULL suffix in v3.
-- 
Florian
