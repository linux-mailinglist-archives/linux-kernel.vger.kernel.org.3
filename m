Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC254D5237
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245280AbiCJSQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiCJSQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:16:40 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9390B13C38E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:15:38 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nSNK2-0006Hm-UL; Thu, 10 Mar 2022 19:15:34 +0100
Message-ID: <892bdc62-703a-2cac-27f7-5dd1ae14d7ea@leemhuis.info>
Date:   Thu, 10 Mar 2022 19:15:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Bug 215658 - arch/powerpc/mm/mmu_context.o Assembler messages:
 Error: unrecognized opcode: `dssall' (PowerMac G4)
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <831731e2-6769-3d36-0cdf-721437452fcc@leemhuis.info>
 <1367d2de-bc44-fb96-c1ef-fd4cf0fb82f4@csgroup.eu>
 <09086ab6-10ff-6334-6148-2fab9df64f9a@leemhuis.info>
In-Reply-To: <09086ab6-10ff-6334-6148-2fab9df64f9a@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1646936138;70b469a5;
X-HE-SMSGID: 1nSNK2-0006Hm-UL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.22 13:22, Thorsten Leemhuis wrote:
> On 10.03.22 12:22, Christophe Leroy wrote:
>> Le 10/03/2022 à 11:39, Thorsten Leemhuis a écrit :
>>> Hi, this is your Linux kernel regression tracker.
>>>
>>> I noticed a regression report in bugzilla.kernel.org that afaics nobody
>>> acted upon since it was reported about a week ago, that's why I decided
>>> to forward it to the lists and a few relevant people to the CC. To quote
>>> from the ticket:
>> I already looked at it when the ticket was opened and that's a bit puzzling.
> Yeah, same here, but I decided I to pick it up, as that's what I'm here for.

TWIMC, the reported stated in bugzilla:

```
> This was Gentoo Sources v5.16.12 not upstream sources. But now I am
> not able to reproduce it which is even more strange... Also Gentoos'
> v5.16.13 builds ok.
> 
> What I did in the meantime was downgrading to binutils 2.37 (had 2.38
> before) and rebuilding the toolchain afterwards.
> 
> So this probably was never a bug but an issue with my setup. ;)
> Closing here```

Thus removing it from the regression tracking as well:

#regzbot invalid: reporter can't reproduce anymore and the report was  a
bit puzzling anyway

Ciao, Thorsten

>> With v5.16.12 and the config file in the bug report I have no such problem:
>>
>>    CC      arch/powerpc/mm/fault.o
>>    CC      arch/powerpc/mm/mem.o
>> [...]
> 
> Maybe it's one of those bugs related to the version of binutils?
> 
>> The bug is puzzling because it says the problem is introduced by commit 
>> d51f86cfd8e3 ("powerpc/mm: Switch obsolete dssall to .long") whereas the 
>> purpose of that commit is exactly to fix the issue you are reporting.
>>
>> And as far as I can see that commit is not in v5.16.12, so my feeling is 
>> that somethings wrong with the bug report.
>>
>> By the way I think that cherry-picking that commit into v5.16.12 should 
>> fix it.
> 
> Maybe that's what he had meant to be writing? Maybe your comment in the
> ticket will lead to some enlightenment.
> 
> Thx for looking into this.
> 
> Ciao, Thorsten
> 
>>>> 5.16.12 kernel build for my G4 DP on my Talos II fails with:
>>>>
>>>> [...]
>>>>    CC      arch/powerpc/mm/init_32.o
>>>>    CC      arch/powerpc/mm/pgtable_32.o
>>>>    CC      arch/powerpc/mm/pgtable-frag.o
>>>>    CC      arch/powerpc/mm/ioremap.o
>>>>    CC      arch/powerpc/mm/ioremap_32.o
>>>>    CC      arch/powerpc/mm/init-common.o
>>>>    CC      arch/powerpc/mm/mmu_context.o
>>>> {standard input}: Assembler messages:
>>>> {standard input}:30: Error: unrecognized opcode: `dssall'
>>>> make[2]: *** [scripts/Makefile.build:287: arch/powerpc/mm/mmu_context.o] Fehler 1
>>>> make[1]: *** [scripts/Makefile.build:549: arch/powerpc/mm] Fehler 2
>>>> make: *** [Makefile:1846: arch/powerpc] Error 2
>>>>
>>>> This seems to have been introduced by commit d51f86cfd8e378d4907958db77da3074f6dce3ba "powerpc/mm: Switch obsolete dssall to .long"
>>>>
>>>> Reverting this commit fixes the build for my G4.
>>>
>>> Could somebody take a look into this? Or was this discussed somewhere
>>> else already? Or even fixed?
>>>
>>> Anyway, to get this tracked:
>>>
>>> #regzbot introduced: d51f86cfd8e378d4907958db77da3074f6dce3ba
>>> #regzbot from: Erhard F <erhard_f@mailbox.org>
>>> #regzbot title:  arch/powerpc/mm/mmu_context.o Assembler messages:
>>> Error: unrecognized opcode: `dssall' (PowerMac G4)
>>> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215658
>>>
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>
>>> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
>>> reports on my table. I can only look briefly into most of them and lack
>>> knowledge about most of the areas they concern. I thus unfortunately
>>> will sometimes get things wrong or miss something important. I hope
>>> that's not the case here; if you think it is, don't hesitate to tell me
>>> in a public reply, it's in everyone's interest to set the public record
>>> straight.
