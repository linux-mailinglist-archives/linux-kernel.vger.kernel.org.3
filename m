Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0875AA510
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiIBB3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbiIBB3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:29:40 -0400
Received: from out199-17.us.a.mail.aliyun.com (out199-17.us.a.mail.aliyun.com [47.90.199.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B112A6C21
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:29:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VO3hyue_1662082171;
Received: from 30.97.48.41(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VO3hyue_1662082171)
          by smtp.aliyun-inc.com;
          Fri, 02 Sep 2022 09:29:32 +0800
Message-ID: <46ab4086-8a7f-7c20-c326-72a863b77fbb@linux.alibaba.com>
Date:   Fri, 2 Sep 2022 09:29:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] mm/hugetlb: fix races when looking up a CONT-PTE/PMD
 size hugetlb page
To:     Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org
Cc:     songmuchun@bytedance.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <635f43bdd85ac2615a58405da82b4d33c6e5eb05.1662017562.git.baolin.wang@linux.alibaba.com>
 <YxEevpqBy2rIjcrO@monkey>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YxEevpqBy2rIjcrO@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/2022 5:06 AM, Mike Kravetz wrote:
> On 09/01/22 18:41, Baolin Wang wrote:
>> On some architectures (like ARM64), it can support CONT-PTE/PMD size
>> hugetlb, which means it can support not only PMD/PUD size hugetlb
>> (2M and 1G), but also CONT-PTE/PMD size(64K and 32M) if a 4K page size
>> specified.
>>
>> So when looking up a CONT-PTE size hugetlb page by follow_page(), it
>> will use pte_offset_map_lock() to get the pte entry lock for the CONT-PTE
>> size hugetlb in follow_page_pte(). However this pte entry lock is incorrect
>> for the CONT-PTE size hugetlb, since we should use huge_pte_lock() to
>> get the correct lock, which is mm->page_table_lock.
>>
>> That means the pte entry of the CONT-PTE size hugetlb under current
>> pte lock is unstable in follow_page_pte(), we can continue to migrate
>> or poison the pte entry of the CONT-PTE size hugetlb, which can cause
>> some potential race issues, even though they are under the 'pte lock'.
>>
>> For example, suppose thread A is trying to look up a CONT-PTE size
>> hugetlb page by move_pages() syscall under the lock, however antoher
>> thread B can migrate the CONT-PTE hugetlb page at the same time, which
>> will cause thread A to get an incorrect page, if thread A also wants to
>> do page migration, then data inconsistency error occurs.
>>
>> Moreover we have the same issue for CONT-PMD size hugetlb in
>> follow_huge_pmd().
>>
>> To fix above issues, rename the follow_huge_pmd() as follow_huge_pmd_pte()
>> to handle PMD and PTE level size hugetlb, which uses huge_pte_lock() to
>> get the correct pte entry lock to make the pte entry stable.
>>
>> Cc: <stable@vger.kernel.org>
>> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>> Changes from v2:
>>   - Combine PMD and PTE level hugetlb handling into one function.
>>   - Drop unnecessary patches.
>>   - Update the commit message.
> 
> Baolin, were you able to at least exercise the new code paths?  Especially the
> path for CONT_PTE.  Code looks fine to me.

Yes, I've tested CONT-PTE, CONT-PMD and PMD size hugetlb with 
move_pages() syscall, all works well and the lock is expected.

> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> It is a little hackish, but this is only for backports.  So, I think it is OK.
> We may want to point out that code cleanup and simplification is going upstream
> that will address these issues in a more elegant manner.
> 
>>
>> Mike, please fold this patch into your series. Thanks.
> 
> If I understand Andrew, this can go in as a separate patch for backport to
> address potential bugs.  I will provide a cleanup/simplification that will
> remove this going forward.
> 
> Andrew also asked for a Fixes tag.
> Support for CONT_PMD/_PTE was added with bb9dd3df8ee9 "arm64: hugetlb: refactor
> find_num_contig()".  Patch series "Support for contiguous pte hugepages", v4.
> However, I do not believe these code paths were executed until migration
> support was added with 5480280d3f2d "arm64/mm: enable HugeTLB migration for
> contiguous bit HugeTLB pages"
> I would go with 5480280d3f2d.

Make sense. And I saw Andrew has helped to add a Fixes tag with your 
suggestion. Thanks Mike and Andrew.
