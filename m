Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4202B59F8DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiHXLz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiHXLz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C1389825
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 04:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661342153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uB7JX4rwQ1QQKKzqGmvRRI31yxXDnu7LmVuoM7kwxno=;
        b=R46xFHtTK1WMhJVfRcRaHKRhcx8mi/evrJsk57uYLD2jSs679h7Uk9Lfky9adEao7qa0Vi
        vwytk4gIBW5X2CmS49zqKRvweTJ69bqm319aD2vSnk36Dn1zaTunswy4ZuFACyUlKpKo6j
        2GG7l4gsi3kSQxVxMufKAwBcM3Ts4FQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-342-8Ur40Z70OSegQDVL6H0sGw-1; Wed, 24 Aug 2022 07:55:52 -0400
X-MC-Unique: 8Ur40Z70OSegQDVL6H0sGw-1
Received: by mail-wr1-f72.google.com with SMTP id t12-20020adfa2cc000000b00224f577fad1so2724444wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 04:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=uB7JX4rwQ1QQKKzqGmvRRI31yxXDnu7LmVuoM7kwxno=;
        b=mzyZjgbYfWYkBV8Ugv/tzd/X0AALhJkSma0q5DeOC2PQL5bcNGJOaAMJSPYCIbNtG4
         VcTzHY9soxHUc/J2hJoIhgNPe/nqRHj2U9atX2//h/oTrUMxKw9n5MpjC9cr9cgjM34q
         fTm3kUm3z27ng7tHwv91xUs08RwMbPWLCIZ+yCbsyo+32wpZ+POdtlIcXRYMrJF20IPz
         yDejAiO0Q3WuJxxCA0BtZnys4f7x0iTSDzYcYeOl55PjPrbGL4MA1inIl++jZNsq+Pfe
         fDb5tLsKjPmiL44Ox1xG5WtuLbgB7c29P/6mdbAs69GG2kdWc6jFSpjA7kf+qv6Kt0t6
         GkRQ==
X-Gm-Message-State: ACgBeo2MS0XkKn8HPrpnoZjBCDM4bCQJ7bUyPtfLs1UbmUzHvNjorfqQ
        5f7U0ijwjobhNm3GQYf6vHeuctCqrBttNPv2MhiP2rrE9N+bgG45G+mvDQ6H3yG4Gi58KWnmPAr
        8+l/CnEHUZ88tKuaUKGl46k4N
X-Received: by 2002:a05:600c:3048:b0:3a6:5ce0:9701 with SMTP id n8-20020a05600c304800b003a65ce09701mr5021975wmh.97.1661342151445;
        Wed, 24 Aug 2022 04:55:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR49bi50eCt2LNUrAZlvVOKjuNthVlkuzP0lLjDKV+SrdetW1FaWOpENe29cJZP7cBw3oYp1WQ==
X-Received: by 2002:a05:600c:3048:b0:3a6:5ce0:9701 with SMTP id n8-20020a05600c304800b003a65ce09701mr5021959wmh.97.1661342151154;
        Wed, 24 Aug 2022 04:55:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:c500:5445:cf40:2e32:6e73? (p200300cbc707c5005445cf402e326e73.dip0.t-ipconnect.de. [2003:cb:c707:c500:5445:cf40:2e32:6e73])
        by smtp.gmail.com with ESMTPSA id bt2-20020a056000080200b002255eebf785sm6594605wrb.89.2022.08.24.04.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 04:55:50 -0700 (PDT)
Message-ID: <041e2e43-2227-1681-743e-5f82e245b5ea@redhat.com>
Date:   Wed, 24 Aug 2022 13:55:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
 <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
 <4c24b891-04ce-2608-79d2-a75dc236533f@redhat.com>
 <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
 <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com> <YwVo7xSO+VebkIfQ@monkey>
 <64669c0a-4a6e-f034-a15b-c4a8deea9e5d@linux.alibaba.com>
 <7ee73879-e402-9175-eae8-41471d80d59e@redhat.com>
 <f7544713-d856-0875-41dd-52a5c27ba015@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f7544713-d856-0875-41dd-52a5c27ba015@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.22 11:41, Baolin Wang wrote:
> 
> 
> On 8/24/2022 3:31 PM, David Hildenbrand wrote:
>>>>>>
>>>>>> IMHO, these follow_huge_xxx() functions are arch-specified at first and
>>>>>> were moved into the common hugetlb.c by commit 9e5fc74c3025 ("mm:
>>>>>> hugetlb: Copy general hugetlb code from x86 to mm"), and now there are
>>>>>> still some arch-specified follow_huge_xxx() definition, for example:
>>>>>> ia64: follow_huge_addr
>>>>>> powerpc: follow_huge_pd
>>>>>> s390: follow_huge_pud
>>>>>>
>>>>>> What I mean is that follow_hugetlb_page() is a common and
>>>>>> not-arch-specified function, is it suitable to change it to be
>>>>>> arch-specified?
>>>>>> And thinking more, can we rename follow_hugetlb_page() as
>>>>>> hugetlb_page_faultin() and simplify it to only handle the page faults of
>>>>>> hugetlb like the faultin_page() for normal page? That means we can make
>>>>>> sure only follow_page_mask() can handle hugetlb.
>>>>>>
>>>>
>>>> Something like that might work, but you still have two page table walkers
>>>> for hugetlb.  I like David's idea (if I understand it correctly) of
>>>
>>> What I mean is we may change the hugetlb handling like normal page:
>>> 1) use follow_page_mask() to look up a hugetlb firstly.
>>> 2) if can not get the hugetlb, then try to page fault by
>>> hugetlb_page_faultin().
>>> 3) if page fault successed, then retry to find hugetlb by
>>> follow_page_mask().
>>
>> That implies putting more hugetlbfs special code into generic GUP,
>> turning it even more complicated. But of course, it depends on how the
>> end result looks like. My gut feeling was that hugetlb is better handled
>> in follow_hugetlb_page() separately (just like we do with a lot of other
>> page table walkers).
> 
> OK, fair enough.
> 
>>>
>>> Just a rough thought, and I need more investigation for my idea and
>>> David's idea.
>>>
>>>> using follow_hugetlb_page for both cases.  As noted, it will need to be
>>>> taught how to not trigger faults in the follow_page_mask case.
>>>
>>> Anyway, I also agree we need some cleanup, and firstly I think we should
>>> cleanup these arch-specified follow_huge_xxx() on some architectures
>>> which are similar with the common ones. I will look into these.
>>
>> There was a recent discussion on that, e.g.:
>>
>> https://lkml.kernel.org/r/20220818135717.609eef8a@thinkpad
> 
> Thanks.
> 
>>
>>>
>>> However, considering cleanup may need more investigation and
>>> refactoring, now I prefer to make these bug-fix patches of this patchset
>>> into mainline firstly, which are suitable to backport to old version to
>>> fix potential race issues. Mike and David, how do you think? Could you
>>> help to review these patches? Thanks.
>>
>> Patch #1 certainly add more special code just to handle another hugetlb
>> corner case (CONT pages), and maybe just making it all use
>> follow_hugetlb_page() would be even cleaner and less error prone.
>>
>> I agree that locking is shaky, but I'm not sure if we really want to
>> backport this to stable trees:
>>
>> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>
>> "It must fix a real bug that bothers people (not a, “This could be a
>> problem...” type thing)."
>>
>>
>> Do we actually have any instance of this being a real (and not a
>> theoretical) problem? If not, I'd rather clean it all up right away.
> 
> I think this is a real problem (not theoretical), and easy to write some 
> code to show the issue. For example, suppose thread A is trying to look 
> up a CONT-PTE size hugetlb page under the lock, however antoher thread B 
> can migrate the CONT-PTE hugetlb page at the same time, which will cause 
> thread A to get an incorrect page, if thread A want to do something for 
> this incorrect page, error occurs.
> 
> Actually we also want to backport these fixes to the distro with old 
> kernel versions to make the hugetlb more stable. Otherwise we must hit 
> these issues sooner or later if the customers use CONT-PTE/PMD hugetlb.
> 
> Anyway, if you and Mike still think these issues are not important 
> enough to be fixed in the old versions, I can do the cleanup firstly.
> 

[asking myself which follow_page() users actually care about hugetlb,
and why we need this handling in follow_page at all]

Which follow_page() user do we care about here? Primarily mm/migrate.c
only I assume?

-- 
Thanks,

David / dhildenb

