Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2E94CE341
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 07:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiCEGUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 01:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiCEGUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 01:20:47 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F54E522DA;
        Fri,  4 Mar 2022 22:19:55 -0800 (PST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxWs39ACNi6B0DAA--.15394S3;
        Sat, 05 Mar 2022 14:19:42 +0800 (CST)
Subject: Re: [PATCH v4 0/4] MIPS: Modify mem= and memmap= parameter
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
 <Yh3tgr+g/6IElq0P@kernel.org>
 <cfd74b5b-39c3-733a-5226-515991f91f39@loongson.cn>
 <Yh4uUoYT+YS5Jxsv@kernel.org>
 <8956c625-c18d-846e-3e65-7920776b27f3@loongson.cn>
 <alpine.DEB.2.21.2203041627150.47558@angie.orcam.me.uk>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <4e10d7a4-3b3e-a220-8cd2-565614288950@loongson.cn>
Date:   Sat, 5 Mar 2022 14:19:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2203041627150.47558@angie.orcam.me.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxWs39ACNi6B0DAA--.15394S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1Uur1xJw4DKrWrKr48JFb_yoW5ZF1xpF
        W5Ka1xKF4kJF1SkryxCw1Iqry0y3yrt395Kr93Jryvkws8ZF1I9r1fKa98Za4DXr1fWa42
        vF42qF9F9a4DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfU1uc_DUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/05/2022 01:05 AM, Maciej W. Rozycki wrote:
> On Wed, 2 Mar 2022, Tiezhu Yang wrote:
>
>>> As for memmap= option, it does not specify the memory map but rather alters
>>> the memory map passed by the firmware. Particularity in MIPS implementation
>>> it allows to add a single range of available or reserved memory.
>>>
>>> AFAIU, for the kdump use-case mem=X@Y should suffice.
>>
>> We can modify some code to make mem=X@Y work well,
>> but according to Documentation/admin-guide/kernel-parameters.txt,
>> the common way is mem=X and memmap=X@Y, so mem=X@Y for mips seems
>> odd, the intention of this patchset is to make mem= and memmap=
>> work well and consistent with the other archs.
>
>  It is not the MIPS implementation that is odd, it is the others that have
> changed the semantics that are.
>
>  When I added `mem=...' support to the MIPS platform, back on Dec 11th,
> 2000, which I needed for a system with with memory holes until I got
> proper memory probing implemented, AFAIR the only other implementation was
> for the x86 and naturally what I did for the MIPS platform was exactly the
> same.  It used to be documented too, but the documentation was removed
> sometime back in 2003 when someone has changed the x86 semantics for
> reasons unknown to me and without letting people working on other
> platforms know, so things diverged.
>
>  Please review:
>
> <https://lore.kernel.org/linux-mips/alpine.LFD.2.21.2010050133330.333514@eddie.linux-mips.org/>
>
> as it has been already discussed.
>
>  If you have a system that hangs with `mem=3G' and which does have
> contiguous RAM available for the kernel to use from 0 through to 3GiB,
> then please either bisect the problem or try finding the root cause as it
> used to work at least those 21 years ago.  Conversely if your system does
> *not* have such RAM available, then use the correct option(s) instead that
> reflect your memory map.
>
>  It is preferable that the memory map be determined automatically either
> by the firmware and then passed to the kernel somehow, or a device tree
> entry, or probed by the kernel itself.  You shouldn't have to specify
> `mem=...' by hand except for debugging or as a temporary workaround.
>
>  For example I have an x86 system that Linux does not how to interrogate
> for RAM beyond 64MiB, so I do use `memmap=128M@0' (for legacy reasons the
> x86 platform has a special exception to always exclude area between 640K
> and 1M from being used even if not explicitly specified, but we do not
> have a need for such legacy such legacy concerns with the MIPS port).  I
> consider it an interim measure however until the kernel has been fixed.
>
>   Maciej
>

Hi Mike, Thomas and Maciej,

Thank you very much for your feedbacks and discussions.

To be frank, I think mem= and memmap= are used for debugging and testing
in most cases, the intention of this patchset is to refactor the related
code to make them work well on mips.

Now, if put the current patch #2 as the first patch, and then modify the
current patch #1 to support both mem=limit and mem=limit@base (if @base
is omitted, it is equivalent to mem=limit), the other patches #3 and #4
remain unchanged, make sense?

I will send v5 for your review.

Thanks,
Tiezhu

