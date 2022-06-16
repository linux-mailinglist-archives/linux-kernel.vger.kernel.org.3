Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554A754D900
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358434AbiFPDs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346612AbiFPDsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:48:55 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E129045059
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:48:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VGVio0B_1655351328;
Received: from 30.97.48.140(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VGVio0B_1655351328)
          by smtp.aliyun-inc.com;
          Thu, 16 Jun 2022 11:48:49 +0800
Message-ID: <255ccf96-2c12-9ca0-9f8b-8a8461253952@linux.alibaba.com>
Date:   Thu, 16 Jun 2022 11:48:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 1/3] hugetlb: skip to end of PT page mapping when pte
 not present
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
 <20220527225849.284839-2-mike.kravetz@oracle.com>
 <437e45c5-c46a-46f4-f9cf-d8c2397c988d@linux.alibaba.com>
 <YqpNmsLrbCowS1IE@monkey>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YqpNmsLrbCowS1IE@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/2022 5:22 AM, Mike Kravetz wrote:
> On 05/30/22 18:10, Baolin Wang wrote:
>>
>>
>> On 5/28/2022 6:58 AM, Mike Kravetz wrote:
>>> HugeTLB address ranges are linearly scanned during fork, unmap and
>>> remap operations.  If a non-present entry is encountered, the code
>>> currently continues to the next huge page aligned address.  However,
>>> a non-present entry implies that the page table page for that entry
>>> is not present.  Therefore, the linear scan can skip to the end of
>>> range mapped by the page table page.  This can speed operations on
>>> large sparsely populated hugetlb mappings.
>>>
>>> Create a new routine hugetlb_mask_last_hp() that will return an
>>> address mask.  When the mask is ORed with an address, the result
>>> will be the address of the last huge page mapped by the associated
>>> page table page.  Use this mask to update addresses in routines which
>>> linearly scan hugetlb address ranges when a non-present pte is
>>> encountered.
>>>
>>> hugetlb_mask_last_hp is related to the implementation of huge_pte_offset
>>> as hugetlb_mask_last_hp is called when huge_pte_offset returns NULL.
>>> This patch only provides a complete hugetlb_mask_last_hp implementation
>>> when CONFIG_ARCH_WANT_GENERAL_HUGETLB is defined.  Architectures which
>>> provide their own versions of huge_pte_offset can also provide their own
>>> version of hugetlb_mask_last_hp.
>>
>> I tested on my ARM64 machine with implementing arm64 specific
>> hugetlb_mask_last_hp() as below, and it works well.
>>
>> Just a few nits inline, otherwise looks good to me.
>> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index d93ba128a2b0..e04a097ffcc4 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -376,6 +376,28 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>>          return NULL;
>>   }
>>
>> +unsigned long hugetlb_mask_last_hp(struct hstate *h)
>> +{
>> +       unsigned long hp_size = huge_page_size(h);
>> +
>> +       switch (hp_size) {
>> +       case P4D_SIZE:
>> +               return PGDIR_SIZE - P4D_SIZE;
>> +       case PUD_SIZE:
>> +               return P4D_SIZE - PUD_SIZE;
>> +       case CONT_PMD_SIZE:
>> +               return PUD_SIZE - CONT_PMD_SIZE;
>> +       case PMD_SIZE:
>> +               return PUD_SIZE - PMD_SIZE;
>> +       case CONT_PTE_SIZE:
>> +               return PMD_SIZE - CONT_PTE_SIZE;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       return ~(0UL);
>> +}
> 
> Hello Baolin,
> 
> Would you mind sending this as a proper patch with commit message and
> 'Signed-off-by:'?  I would like to include it in the upcoming patch series.

Sure. I've sent it out [1], and please fold it into your series. Thanks.

[1] 
https://lore.kernel.org/all/7256dbe078d7231f45b0f47c2c52a3bd3aa10da7.1655350193.git.baolin.wang@linux.alibaba.com/
