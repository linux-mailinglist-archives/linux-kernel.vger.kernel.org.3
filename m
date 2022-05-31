Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440CB5394FF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346175AbiEaQci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244921AbiEaQce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:32:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4B32899E;
        Tue, 31 May 2022 09:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=mCLptYXedfhjubmlw5BpJM5vBm1Qu0fjfrsKQvvk7a0=; b=nC5Eoo4x8LEjS3jCnrkAdRn+Xl
        v659Gte5fzH4eSwXz7SESGqNma8VaWcPPENSqIx1zJl8H8vZIgoslN3fD1SooS/tQs7Ok/wJI3I8G
        dwXaiawIZwfLs6S1iNcbYhMmmfRZAnVDzJkeLdkLP+Iy9uUwb2dYmzDG74DHjRRMMLqxErb/QRJOh
        JK1i0MGCK1CKgd+8BnFvvLxXmEaqVCVoAwsaCGHoQuDdd3g1CwwwRcwJOnyn/vLbm5A1lQk0WktQf
        jADk5Qro9M5jXaV5/T78JglmKEeCPTPQxaL+VOjpyIynu5iyimUp3d4kJyjE5FQdnIk3zG/Z0Ng33
        xtqcd6WA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nw4nE-005WpB-9E; Tue, 31 May 2022 16:32:28 +0000
Message-ID: <eb11e6b1-01cb-78af-2b2d-5884106ad9c7@infradead.org>
Date:   Tue, 31 May 2022 09:32:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v16 4/4] m68k: introduce a virtual m68k machine
Content-Language: en-US
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alessandro Zummo <a.zummo@towertech.it>
References: <20220406201523.243733-1-laurent@vivier.eu>
 <20220406201523.243733-5-laurent@vivier.eu>
 <3b783435-e734-5391-e758-d709e0462839@infradead.org>
 <64ce78bf-b81b-1eec-74f3-650a72f2874b@vivier.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <64ce78bf-b81b-1eec-74f3-650a72f2874b@vivier.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/22 23:05, Laurent Vivier wrote:
> Le 31/05/2022 à 03:14, Randy Dunlap a écrit :
>> Hi--
> 
> Hi,
> 
>> On 4/6/22 13:15, Laurent Vivier wrote:
>>> diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
>>> index eeab4f3e6c19..188a8f8a0104 100644
>>> --- a/arch/m68k/Kconfig.machine
>>> +++ b/arch/m68k/Kconfig.machine
>>> @@ -149,6 +149,23 @@ config SUN3
>>>           If you don't want to compile a kernel exclusively for a Sun 3, say N.
>>>   +config VIRT
>>> +    bool "Virtual M68k Machine support"
>>> +    depends on MMU
>>> +    select GENERIC_CLOCKEVENTS
>>> +    select GOLDFISH
>>> +    select GOLDFISH_TIMER
>>> +    select GOLDFISH_TTY
>>> +    select M68040
>>> +    select MMU_MOTOROLA if MMU
>>> +    select RTC_CLASS
>>> +    select RTC_DRV_GOLDFISH
>>> +    select TTY
>>> +    select VIRTIO_MMIO
>>
>> This select VIRTIO_MMIO can cause a kconfig warning:
>>
>> WARNING: unmet direct dependencies detected for VIRTIO_MMIO
>>    Depends on [n]: VIRTIO_MENU [=n] && HAS_IOMEM [=y] && HAS_DMA [=y]
> 
> In my repo, VIRTIO_MMIO has no dependency on VIRTIO_MENU:
> 
> ./drivers/virtio/Kconfig
> config VIRTIO_MMIO
>         tristate "Platform bus driver for memory mapped virtio devices"
>         depends on HAS_IOMEM && HAS_DMA

As Arnd explained...

> 
>>    Selected by [y]:
>>    - VIRT [=y] && M68KCLASSIC [=y] && MMU [=y]
> 
> How do you generate this warning?

It's just a random randconfig.

> The first version of my patch added the VIRTIO_MENU but Geert said it's not necessary because VIRTIO_MENU defaults to y.
> 
> https://lore.kernel.org/lkml/CAMuHMdUFh2W-bY5Ez1aOTZQjq0=THvmOf22JdxWoNNtFLskSzw@mail.gmail.com/

It's still a user-settable value and can be disabled, so the Kconfig entry
should account for (allow for) that, either with 'select' or 'depends on'.

>>
>>> +    help
>>> +      This options enable a pure virtual machine based on m68k,
>>> +      VIRTIO MMIO devices and GOLDFISH interfaces (TTY, RTC, PIC)
>>
>> The sentence above needs an ending period ('.').
>>
> 
> I agree.
> 
> Thanks,
> Laurent
> 

-- 
~Randy
