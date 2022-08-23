Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2849559E45A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbiHWNMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbiHWNLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:11:55 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3992113491C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:12:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VN1TqVf_1661249538;
Received: from 30.97.48.53(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VN1TqVf_1661249538)
          by smtp.aliyun-inc.com;
          Tue, 23 Aug 2022 18:12:19 +0800
Message-ID: <888605a6-9e33-7485-3c90-94375390ea0b@linux.alibaba.com>
Date:   Tue, 23 Aug 2022 18:12:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 4/5] mm/hugetlb: use PMD page lock to protect CONT-PTE
 entries
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
 <88c8a8c68d87429f0fc48e81100f19b71f6e664f.1661240170.git.baolin.wang@linux.alibaba.com>
 <3661415c-6069-24ed-b647-6fe6993bddae@redhat.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <3661415c-6069-24ed-b647-6fe6993bddae@redhat.com>
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



On 8/23/2022 4:14 PM, David Hildenbrand wrote:
> On 23.08.22 09:50, Baolin Wang wrote:
>> Considering the pmd entries of a CONT-PMD hugetlb can not span on
>> multiple PMDs, we can change to use the PMD page lock, which can
>> be much finer grain that lock in the mm.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   include/linux/hugetlb.h | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 3a96f67..d4803a89 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -892,9 +892,17 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
>>   static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>>   					   struct mm_struct *mm, pte_t *pte)
>>   {
>> -	VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
>> +	unsigned long hp_size = huge_page_size(h);
>>   
>> -	if (huge_page_size(h) == PMD_SIZE) {
>> +	VM_BUG_ON(hp_size == PAGE_SIZE);
>> +
>> +	/*
>> +	 * Considering CONT-PMD size hugetlb, since the CONT-PMD entry
>> +	 * can not span multiple PMDs, then we can use the fine grained
>> +	 * PMD page lock.
>> +	 */
>> +	if (hp_size == PMD_SIZE ||
>> +	    (hp_size > PMD_SIZE && hp_size < PUD_SIZE)) {
>>   		return pmd_lockptr(mm, (pmd_t *) pte);
>>   	} else if (huge_page_size(h) < PMD_SIZE) {
>>   		unsigned long mask = ~(PTRS_PER_PTE * sizeof(pte_t) - 1);
> 
> Is there a measurable performance gain? IOW, do we really care?

IMO, It's just a theoretical analysis now:) Let me think about how to 
measure the performance gain.
