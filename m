Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0A75A7332
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiHaBH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiHaBHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:07:20 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE4B9836D;
        Tue, 30 Aug 2022 18:07:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VNo9O5p_1661908034;
Received: from 30.97.48.45(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VNo9O5p_1661908034)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 09:07:15 +0800
Message-ID: <0a8025eb-cf15-453a-7d7d-7c72d008889a@linux.alibaba.com>
Date:   Wed, 31 Aug 2022 09:07:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        inuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220829234053.159158-1-mike.kravetz@oracle.com>
 <57c8f032-e48a-bacb-7922-3e2cc10dc0d2@linux.alibaba.com>
 <Yw4+YvdS9kJUnx1s@monkey> <Yw5ZTEqxZCAgEbK9@monkey>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Yw5ZTEqxZCAgEbK9@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/2022 2:39 AM, Mike Kravetz wrote:
> On 08/30/22 09:44, Mike Kravetz wrote:
>> On 08/30/22 09:06, Baolin Wang wrote:
>>> Hi Mike,
>>>
>>> On 8/30/2022 7:40 AM, Mike Kravetz wrote:
>>>> During discussions of this series [1], it was suggested that hugetlb
>>>> handling code in follow_page_mask could be simplified.  At the beginning
>>>> of follow_page_mask, there currently is a call to follow_huge_addr which
>>>> 'may' handle hugetlb pages.  ia64 is the only architecture which provides
>>>> a follow_huge_addr routine that does not return error.  Instead, at each
>>>> level of the page table a check is made for a hugetlb entry.  If a hugetlb
>>>> entry is found, a call to a routine associated with that entry is made.
>>>>
>>>> Currently, there are two checks for hugetlb entries at each page table
>>>> level.  The first check is of the form:
>>>> 	if (p?d_huge())
>>>> 		page = follow_huge_p?d();
>>>> the second check is of the form:
>>>> 	if (is_hugepd())
>>>> 		page = follow_huge_pd().
>>>>
>>>> We can replace these checks, as well as the special handling routines
>>>> such as follow_huge_p?d() and follow_huge_pd() with a single routine to
>>>> handle hugetlb vmas.
>>>>
>>>> A new routine hugetlb_follow_page_mask is called for hugetlb vmas at the
>>>> beginning of follow_page_mask.  hugetlb_follow_page_mask will use the
>>>> existing routine huge_pte_offset to walk page tables looking for hugetlb
>>>> entries.  huge_pte_offset can be overwritten by architectures, and already
>>>> handles special cases such as hugepd entries.
>>>
>>> Could you also mention that this patch will fix the lock issue for
>>> CONT-PTE/PMD hugetlb by changing to use huge_pte_lock()? which will help
>>> people to understand the issue.
>>
>> Will update message in v2.  Thanks for taking a look!
>>
> 
> One additional thought, we 'may' need a separate patch to fix the locking
> issues that can be easily backported.  Not sure this 'simplification' is
> a good backport candidate.

Yes, that was my thought before, but David did not like adding more 
make-legacy-cruft-happy code.

So how about creating a series that contains 3 patches: picking up patch 
1 and patch 3 of my previous series [1], and your current patch? That 
means patch 1 and patch 2 in this series can fix the lock issue 
explicitly and be suitable to backport, meanwhile patch 3 (which is your 
current patch) will cleanup the legacy code.

[1] 
https://lore.kernel.org/all/cover.1661240170.git.baolin.wang@linux.alibaba.com/
