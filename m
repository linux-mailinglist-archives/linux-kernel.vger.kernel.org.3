Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479E959F687
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbiHXJmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbiHXJlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:41:52 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62923B956
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:41:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VN7.k26_1661334105;
Received: from 30.97.48.45(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VN7.k26_1661334105)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 17:41:46 +0800
Message-ID: <f7544713-d856-0875-41dd-52a5c27ba015@linux.alibaba.com>
Date:   Wed, 24 Aug 2022 17:41:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
To:     David Hildenbrand <david@redhat.com>,
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
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <7ee73879-e402-9175-eae8-41471d80d59e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2022 3:31 PM, David Hildenbrand wrote:
>>>>>
>>>>> IMHO, these follow_huge_xxx() functions are arch-specified at first and
>>>>> were moved into the common hugetlb.c by commit 9e5fc74c3025 ("mm:
>>>>> hugetlb: Copy general hugetlb code from x86 to mm"), and now there are
>>>>> still some arch-specified follow_huge_xxx() definition, for example:
>>>>> ia64: follow_huge_addr
>>>>> powerpc: follow_huge_pd
>>>>> s390: follow_huge_pud
>>>>>
>>>>> What I mean is that follow_hugetlb_page() is a common and
>>>>> not-arch-specified function, is it suitable to change it to be
>>>>> arch-specified?
>>>>> And thinking more, can we rename follow_hugetlb_page() as
>>>>> hugetlb_page_faultin() and simplify it to only handle the page faults of
>>>>> hugetlb like the faultin_page() for normal page? That means we can make
>>>>> sure only follow_page_mask() can handle hugetlb.
>>>>>
>>>
>>> Something like that might work, but you still have two page table walkers
>>> for hugetlb.  I like David's idea (if I understand it correctly) of
>>
>> What I mean is we may change the hugetlb handling like normal page:
>> 1) use follow_page_mask() to look up a hugetlb firstly.
>> 2) if can not get the hugetlb, then try to page fault by
>> hugetlb_page_faultin().
>> 3) if page fault successed, then retry to find hugetlb by
>> follow_page_mask().
> 
> That implies putting more hugetlbfs special code into generic GUP,
> turning it even more complicated. But of course, it depends on how the
> end result looks like. My gut feeling was that hugetlb is better handled
> in follow_hugetlb_page() separately (just like we do with a lot of other
> page table walkers).

OK, fair enough.

>>
>> Just a rough thought, and I need more investigation for my idea and
>> David's idea.
>>
>>> using follow_hugetlb_page for both cases.  As noted, it will need to be
>>> taught how to not trigger faults in the follow_page_mask case.
>>
>> Anyway, I also agree we need some cleanup, and firstly I think we should
>> cleanup these arch-specified follow_huge_xxx() on some architectures
>> which are similar with the common ones. I will look into these.
> 
> There was a recent discussion on that, e.g.:
> 
> https://lkml.kernel.org/r/20220818135717.609eef8a@thinkpad

Thanks.

> 
>>
>> However, considering cleanup may need more investigation and
>> refactoring, now I prefer to make these bug-fix patches of this patchset
>> into mainline firstly, which are suitable to backport to old version to
>> fix potential race issues. Mike and David, how do you think? Could you
>> help to review these patches? Thanks.
> 
> Patch #1 certainly add more special code just to handle another hugetlb
> corner case (CONT pages), and maybe just making it all use
> follow_hugetlb_page() would be even cleaner and less error prone.
> 
> I agree that locking is shaky, but I'm not sure if we really want to
> backport this to stable trees:
> 
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> "It must fix a real bug that bothers people (not a, “This could be a
> problem...” type thing)."
> 
> 
> Do we actually have any instance of this being a real (and not a
> theoretical) problem? If not, I'd rather clean it all up right away.

I think this is a real problem (not theoretical), and easy to write some 
code to show the issue. For example, suppose thread A is trying to look 
up a CONT-PTE size hugetlb page under the lock, however antoher thread B 
can migrate the CONT-PTE hugetlb page at the same time, which will cause 
thread A to get an incorrect page, if thread A want to do something for 
this incorrect page, error occurs.

Actually we also want to backport these fixes to the distro with old 
kernel versions to make the hugetlb more stable. Otherwise we must hit 
these issues sooner or later if the customers use CONT-PTE/PMD hugetlb.

Anyway, if you and Mike still think these issues are not important 
enough to be fixed in the old versions, I can do the cleanup firstly.
