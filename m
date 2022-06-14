Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8055654AB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350783AbiFNHwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355413AbiFNHvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11C4E40A30
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655193062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5vldjIUqidCO6vlFIaqoxzvdgolTmKJY9z8eS7S7dk=;
        b=Q5S9W+7Ct1+O/OC+dS7QFwlknuZyMwxs7dRExB90umGPN/9j59fUtEg+71yQTnipnabeVY
        jUIHgFW34/qQerFryntKmUkaTrYy0qPqvQdvOYRa6t91Urc5JEJCon/mrbsmteYMrQ5Z3P
        uVUkIjWH1E64Vvmm60mI3U+OO6QW9uU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-75oiaTFaN-eT-VgenFiSJQ-1; Tue, 14 Jun 2022 03:51:01 -0400
X-MC-Unique: 75oiaTFaN-eT-VgenFiSJQ-1
Received: by mail-wm1-f70.google.com with SMTP id v125-20020a1cac83000000b0039c832fbd02so3730100wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=P5vldjIUqidCO6vlFIaqoxzvdgolTmKJY9z8eS7S7dk=;
        b=Buxkh/oKN+6Kva0x+9HsdgvFPlTmPRhQSoWaehc8asFBggLvqkZHuThHGC4IR2nmfu
         MB6LJDp9WnRhDOZCSgKaWZZa4dGvzZnkMTMjgUGlK9ps1Qq2qqKuFk54O01AXE4qMQE9
         QS7wKi+wJSRZxZUA1PfHz7EUhtq6kOgPccvQ4XLMrgFvk0XU+3xRh5v7G366rGLyod4s
         kNiGRbY6dX5krIIVD/LZT2uc3reAdJzSr9vWtEomsAvjo6w59mMtPZ2h107r16K667OC
         dJa5gCEWlEvY0jb/VvFLyLj0k3gw+qyUluNReoA2pD7hWfuRcppSuoRW6MFo8eC7/0/b
         ytpg==
X-Gm-Message-State: AJIora/QGCpAZ3nhIivr6qvNqCTn6ln5VlBPJapNHuHEecI9vfqyiH+O
        eM/w8X+IfQdVTwkP4+iBYDyGx1KNnDuhUdq5MLTSCnpEU40nFFjy6h4WebIxkjDuL01t/HRiE7m
        KvifUqzZKjFVN0KdqQLaHRsrT
X-Received: by 2002:a5d:4650:0:b0:213:ba65:73fd with SMTP id j16-20020a5d4650000000b00213ba6573fdmr3467650wrs.61.1655193059876;
        Tue, 14 Jun 2022 00:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uuuaA6MjIUnj4gRWDfzmfKbYDTX3HpjKjHiI2FtFYEffsdxTUBszXdyoJ0Ax/8lNLp8uGq/g==
X-Received: by 2002:a5d:4650:0:b0:213:ba65:73fd with SMTP id j16-20020a5d4650000000b00213ba6573fdmr3467614wrs.61.1655193059541;
        Tue, 14 Jun 2022 00:50:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:cf00:aace:de16:d459:d411? (p200300cbc70bcf00aacede16d459d411.dip0.t-ipconnect.de. [2003:cb:c70b:cf00:aace:de16:d459:d411])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003974a00697esm20199504wmq.38.2022.06.14.00.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 00:50:58 -0700 (PDT)
Message-ID: <85ec2a50-e094-cc39-c42b-b36ce0f53010@redhat.com>
Date:   Tue, 14 Jun 2022 09:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Collingbourne <pcc@google.com>
References: <20220610181436.84713-1-david@redhat.com>
 <5DFB7262-6E32-4984-A346-B7DE5040B12F@gmail.com>
 <YqeTSj98t/KfOAJ9@xz-m1.local>
 <9b38302c-ed93-8825-f543-6ce8878748f9@redhat.com>
 <YqeqoitbPzww9gWg@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] mm/mprotect: try avoiding write faults for exclusive
 anonymous pages when changing protection
In-Reply-To: <YqeqoitbPzww9gWg@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Not really, but I assume performance gain will be minimal and might not
>> be worth the trouble.
>>
>> I'm fairly busy (and not aware of Andreas version), so I can look at
>> this, but it will be part of a separate patch because it will go on my
>> TODO list. Not mad if someone beats me to it ;)
> 
> Just for the reference:
> 
> https://github.com/aagit/aa/commit/34cd0d78db407af06d35a06b24be8e92593964be

Thanks for that reference!

> 
>>
>>>
>>>>>
>>>>> Results of a simple microbenchmark on my Ryzen 9 3900X, comparing the new
>>>>> optimization (avoiding write faults) during mprotect() with softdirty
>>>>> tracking, where we require a write fault.
>>>
>>> Are we comparing the mprotect() sequence operations against softdirty
>>> clearing operation?  Would it make more sense if we compare the same
>>> mprotect() sequence to kernels that are before/after this patch applied?
>>
>> For simplicity I compared on the same kernel, one time exploting the
>> optimization and one time disabling the optimization via softdirty.
>>
>> I can also simply measure without+with. Extra work for me to combine
>> outputs :P
> 
> Well, still that's normally how we work on these, don't we? :)
> 
> Still note that the SOFTDIRTY check (I think) was still reverted..  I meant
> I kept thinking below check "vma->vm_flags & VM_SOFTDIRTY" should be
> "!(vma->vm_flags & VM_SOFTDIRTY)", but again that's separate change so feel
> free to ignore as we've discussed, but please make sure even if you want to
> compare with softdirty that's taking into account.

I wrapped my head around that softdirty check *a lot* and ended up
figuring out that it unintuitively is correct. But maybe I ended up
confusing myself. Anyhow, this patch merely moves that check.

> 
>>
>>>
>>>>>
>>>>>  Running 1000 iterations each
>>>>>
>>>>>  ==========================================================
>>>>>  Measuring memset() of 4096 bytes
>>>>>   First write access:
>>>>>    Min: 169 ns, Max: 8997 ns, Avg: 830 ns
>>>>>   Second write access:
>>>>>    Min: 80 ns, Max: 251 ns, Avg: 168 ns
>>>>>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>>>>>    Min: 180 ns, Max: 290 ns, Avg: 190 ns
>>>>>   Write access after clearing softdirty:
>>>>>    Min: 451 ns, Max: 1774 ns, Avg: 470 ns
>>>>>  -> mprotect = 1.131 * second [avg]
>>>>>  -> mprotect = 0.404 * softdirty [avg]
>>>
>>> (I don't understand these two lines.. but maybe I'm the only one?)
>>
>> Most probably not.
>>
>> "mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE)" needs 113,1% the
>> runtime compared with the "second write" access.
>>
>> "mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE)" needs 40% of the
>> runtime compared with disabling the optimization via softdirty tracking.
>>
>> I may find time to clean that up a bit more to make it easier to consume
>> for humans.
> 
> I see, thanks.  Appending the explanation after the test result will also
> work for me.
> 
> I'm curious is that 113.1% came from tlb miss?  If that's the case, I'd
> suggest drop those comparisons if there's a new version, since they're
> probably not helping to explain what this patch is changing (avoid page
> faluts), and IMHO it can slightly confuse reviewers, if you agree.

As we seem to have easier benchmarks from Andrea and Peter, I can just
reuse these and make my life easier :)

[...]

>>>> Looks good in general. Just wondering (out loud) whether it makes more sense
>>>> to do all the vm_flags and cp_flags related checks in one of the callers
>>>> (mprotect_fixup()?) and propagate whether to try to write-unprotect in
>>>> cp_flags (e.g., by introducing new MM_CP_TRY_WRITE_UNPROTECT).
>>>
>>> I can see why David put it like that, because most of the checks are on
>>> ptes not vm_flags.
>>>
>>> But I also agree on this point, especially if to put it in another way:
>>> IMHO it'll be confusing if we keey MM_CP_DIRTY_ACCT==false for all private
>>> pages even if we're going to take them into account and do smart unprotect
>>> operations.
>>>
>>> So I'm wondering whether we could still at least move vm_flags check into
>>> the mprotect_fixup() as suggested by Nadav, perhaps something like:
>>>
>>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>>> index ba5592655ee3..aefd5fe982af 100644
>>> --- a/mm/mprotect.c
>>> +++ b/mm/mprotect.c
>>> @@ -583,7 +583,11 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>>          * held in write mode.
>>>          */
>>>         vma->vm_flags = newflags;
>>> -       dirty_accountable = vma_wants_writenotify(vma, vma->vm_page_prot);
>>> +       if (vma->vm_flags & VM_SHARED)
>>> +               dirty_accountable = vma_wants_writenotify(vma, vma->vm_page_prot);
>>> +       else
>>> +               /* For private mappings, only if it's writable */
>>> +               dirty_accountable = vma->vm_flags & VM_WRITE;
>>>         vma_set_page_prot(vma);
>>>  
>>>         change_protection(tlb, vma, start, end, vma->vm_page_prot,
>>>
>>> Then IIUC we could drop both the VM_WRITE check in change_pte_range(), and
>>> also the VM_SHARED check above in can_change_pte_writable().  Not sure
>>> whether that'll look slightly cleaner.
>>
>> I'll give it a shot and most probably rename dirty_accountable to
>> something more expressive -- like Nadav proposed, for example.
> 
> Sure.
> 
>>
>>>
>>> I'm also copying Peter Collingbourne <pcc@google.com> because afaict he
>>> proposed the initial idea (maybe worth some credit in the commit message?),
>>
>> Do you have a link to that conversation? Either my memory is messing
>> with me or I did this without reading that mail (which I think, because
>> it simply made sense with PageAnonExclusive at hand). Still, I can add a
>> reference to that mail and mention that this was suggested earlier by
>> Peter C..
> 
> I see, no worry then I thought it was coming from that.  In this case I'm
> not sure whether it's still needed.
> 
> PeterC's v1 was here:
> 
> https://lore.kernel.org/linux-mm/20201212053152.3783250-1-pcc@google.com/
> 
> But there're a bunch of versions:
> 
> https://lore.kernel.org/linux-mm/?q=mm%3A+improve+mprotect%28R%7CW%29+efficiency+on+pages+referenced+once

No idea why I missed that completely as I tend to read a lot linux-mm.
Thanks for the pointers!


-- 
Thanks,

David / dhildenb

