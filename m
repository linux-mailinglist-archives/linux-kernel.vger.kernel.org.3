Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82C8597857
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbiHQU7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242085AbiHQU73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:59:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D7B31EC5;
        Wed, 17 Aug 2022 13:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=+sAI0zAQr3hKqh3S7Ub3Pjtx8QiiDOQOFJrusSJOP1s=; b=TtLc72xu6LV0SkrJY7yJuS8JcE
        8R3DxQfrftB1hBc8lJtwgNvldu5j9HSrLNR5kX7SQsK5xWCeo80NqCUlCSuDTazJN3i5vMb7jCjlS
        A/8F0c67K/s0RXxrWV/I+abC1t+y0XvvgD+TCRYJiCI5lHVI7l1vU/i/1QnA5rTMXSTHzXKk5B+yY
        D0Do6qyvhaCSnYCKj7+L5QzF1itMoQV/r2/126H8+oBk1i9Fq/548GeGmvtR3SV2Pot5r3j1rPkDx
        3rUmHQSyEs+SN8GOMP+8d/OuRZM2Dbob3QEB07KXQqrYwBajDnZ5/rjb2vsY1cA7O6XbpWrqQ+FGn
        ln/JJVCg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOQ8H-006hbs-OW; Wed, 17 Aug 2022 20:59:21 +0000
Message-ID: <f599c358-815f-088e-f2aa-b064ccb64e44@infradead.org>
Date:   Wed, 17 Aug 2022 13:59:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-parisc compile failure in current git
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <892b6ab7-862c-1c0a-2996-0f8408e5043d@linux.ee>
 <89515325-fc21-31da-d238-6f7a9abbf9a0@gmx.de>
 <CAK7LNATuzry1MUj-VruOVUwU_nH2xJd_2SxD_s_Z1QBb3PVnQw@mail.gmail.com>
 <5dfd81eb-c8ca-b7f5-e80e-8632767c022d@gmx.de>
 <CAK7LNATO_30uHzAe-Vsy+hgu=wwEN_aPGET4Ys78rc3=nSuJsg@mail.gmail.com>
 <YNOafsB81ZcP2r7z@ls3530>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YNOafsB81ZcP2r7z@ls3530>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/23/21 13:33, Helge Deller wrote:
> * Masahiro Yamada <masahiroy@kernel.org>:
>> On Thu, Jun 10, 2021 at 4:04 PM Helge Deller <deller@gmx.de> wrote:
>>>
>>> Hi Masahiro,
>>>
>>> On 6/10/21 4:03 AM, Masahiro Yamada wrote:
>>>> On Thu, Jun 10, 2021 at 7:50 AM Helge Deller <deller@gmx.de> wrote:

[snip]

>>>> But, please keep in mind that there is an issue remaining.
>>>>
>>>> Please see this code:
>>>>
>>>> ifdef CONFIG_64BIT
>>>> UTS_MACHINE := parisc64
>>>> CHECKFLAGS += -D__LP64__=1
>>>> CC_ARCHES = hppa64
>>>> LD_BFD := elf64-hppa-linux
>>>> else # 32-bit
>>>> CC_ARCHES = hppa hppa2.0 hppa1.1
>>>> LD_BFD := elf32-hppa-linux
>>>> endif
>>>>
>>>>
>>>> UTS_MACHINE is determined by CONFIG_64BIT.
>>>>
>>>> CONFIG_64BIT is defined only after Kconfig is finished.
>>>> When you are trying to configure the .config,
>>>> CONFIG_64BIT is not defined yet.
>>>> So UTS_MACHINE is always 'parisc'.
>>>
>>> Yes.
>>> See above, but it worked when I had SUBARCH=x86 (when running my laptop).
>>>
>>>
>>>> As you know, Kconfig files now have a bunch of 'cc-option' syntax
>>>> to check the compiler capability in Kconfig time.
>>>> Hence, you need to provide a proper compiler in Kconfig time too.
>>>>
>>>> When you build a 64-bit parisc kernel on a 32-bit parisc machine,
>>>
>>> Please note, that we don't have a 64-bit parisc userspace yet (just kernel).
>>> This means, that all builds on parisc machines are 32bit and do a
>>> cross-compilation to a parisc64 kernel if requested in the .config.
>>>
>>>> Kconfig is passed with CC=gcc since SUBARCH==UTS_MACHINE==parisc.
>>>> After Kconfig, CROSS_COMPILE=hppa64-* is set,
>>>> and the kernel is built by CC=hppa64-*-gcc.
>>>
>>> Right. That is the old behaviour. Based on the CONFIG_64BIT option
>>> the hppa64 compiler is choosen for CROSS_COMPILE.
>>>
>>>> So, Kconfig evaluated a compiletely different compiler. This is pointless.
>>>
>>> Yes, probably.
>>>
>>>
>>>> There are some options
>>>>
>>>> [option 1]
>>>>    revert the parisc bit of 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3
>>>>    This will restore the functionality you may want, but
>>>>    as I said above, Kconfig is doing pointless things.
>>>
>>> as mentioned above: Doesn't solve the issue.
>>>
>>>> [option 2]
>>>>     Stop using cc-cross-prefix, and pass CROSS_COMPILE explicitly.
>>>>     This is what many architectures including arm, arm64 do.
>>>>     You need to explicitly pass CROSS_COMPILE=aarch64-linux-gnu- etc.
>>>>     if you are cross-compiling arm64.
>>>
>>> Might be an option, but it's not as handy as simply choosing CONFIG_64BIT
>>> and then things are done automatically.
>>>
>>>> [option 3]
>>>>     Introduce ARCH=parisc64.
>>>>
>>>>     When you are building 64-bit kernel, you can pass ARCH=parisc64
>>>>      A patch attached.  (but not tested much)
>>>
>>> Tried it, but doesn't work.
>>> asm-offsets.c is still preprocessed with 32bit compiler (gcc, not hppa20-gcc).
>>>
>>> Thanks for your help so far!
>>> If you like I'm happy to give you an account on a hppa64 machine to reproduce yourself.
>>> I'll now try to bisect where it goes wrong. There must be something else before commit 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3.
>>>
>>> Helge
>>
>>
>> Sorry for my late reply.
> 
> Me too.... :-(

Sorry to jump in even later, but:

I see that
$ make ARCH=parisc64 defconfig
does set CONFIG_64BIT.

Is there a way to do
$ make ARCH=parisc64 allmodconfig
?
That does not set CONFIG_64BIT in my testing.
(testing on linux-next-20220817)

I would like to have a command-line method to do that,
without editing the .config file.

Thanks.
-- 
~Randy
