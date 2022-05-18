Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A6252BBD8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbiERNSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbiERNSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:18:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9247B0A64;
        Wed, 18 May 2022 06:18:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79712B82032;
        Wed, 18 May 2022 13:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D865C385AA;
        Wed, 18 May 2022 13:18:12 +0000 (UTC)
Message-ID: <adb0c664-a662-4823-9e54-0daab22932a0@linux-m68k.org>
Date:   Wed, 18 May 2022 23:18:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] m68knommu: fix 68000 CPU link with no platform
 selected
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20220518065639.2432213-1-gerg@linux-m68k.org>
 <20220518065639.2432213-4-gerg@linux-m68k.org>
 <CAMuHMdWADK4d-OxKYdnRvbtVsGtbZ_+vF2D70S-5hXNt0rqg9w@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAMuHMdWADK4d-OxKYdnRvbtVsGtbZ_+vF2D70S-5hXNt0rqg9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 18/5/22 19:20, Geert Uytterhoeven wrote:
> Hi Greg.
> 
> On Wed, May 18, 2022 at 8:56 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> If building for a nommu m68k classic CPU and no platform (board) is
>> selected then the final link fails with:
>>
>>       LD      vmlinux.o
>>     m68k-linux-ld: cannot find arch/m68k/kernel/head.o: No such file or directory
>>     make: *** [Makefile:1158: vmlinux] Error 1
>>
>> Not selecting a platform is ok, that is a generic 68000 system build.
>> All of the platform selections are for 68328 variants.
>>
>> The underlying problem is that the CPU config option (CONFIG_M68000)
>> ends up not being set, it is currently only selected by one of the
>> platform choices.
>>
>> Change CONFIG_M68000 so that it is always enabled for the nommu m68k
>> classic configuration.
>>
>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> 
> Thanks for your patch!
> 
>> --- a/arch/m68k/Kconfig.cpu
>> +++ b/arch/m68k/Kconfig.cpu
>> @@ -37,7 +37,7 @@ endchoice
>>   if M68KCLASSIC
>>
>>   config M68000
>> -       bool
>> +       def_bool y
> 
> And then the selects can be removed, too, as the symbol is now always
> enabled?

Yes, I think that would be the case.


> I'm wondering how to handle this when another nommu-m68k-classic
> platform shows up (again, cfr. the removed 68360 support) , that
> would need a different head.S?  Of course that's something to be
> solved later...

Yes, indeed. I am kinda kicking that can down the road :-)

It probably doesn't make a lot of sense to be able to select
multiple platform types in this specific nommu m68k classic setup.
The startup config code does not support probing of platform type,
it has hard coded #if conditionals that mean it only supports a
single platform selection anyway.

Anyway, a problem to deal with when we have more choices here.


>>          depends on !MMU
>>          select CPU_HAS_NO_BITFIELDS
>>          select CPU_HAS_NO_CAS
> 
> Note that mmu-m68k-classic (e.g. CONFIG_MMU=y + allnonfig) has the
> same problem.  That config does need other fixes too.  E.g. I have
> a local patch to make sure NR_IRQS is never zero, but never got to
> solve the missing head.o problem in an acceptable way.

Yep, ok.

Regards
Greg



> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
