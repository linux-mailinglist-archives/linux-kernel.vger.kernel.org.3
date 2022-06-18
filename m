Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0055027A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 05:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384043AbiFRD2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 23:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383842AbiFRD2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 23:28:03 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948B011827;
        Fri, 17 Jun 2022 20:27:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VGi1ydh_1655522870;
Received: from 30.13.184.185(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VGi1ydh_1655522870)
          by smtp.aliyun-inc.com;
          Sat, 18 Jun 2022 11:27:51 +0800
Message-ID: <e8cb00ab-f617-de14-9e5c-883f56da0b5f@linux.alibaba.com>
Date:   Sat, 18 Jun 2022 11:27:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] hugetlb: skip to end of PT page mapping when pte not
 present
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        catalin.marinas@arm.com, will@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220616210518.125287-1-mike.kravetz@oracle.com>
 <20220616210518.125287-2-mike.kravetz@oracle.com>
 <YqyMhmAjrQ4C+EyA@xz-m1.local> <Yqy3LZUOdH5GsZ9j@monkey>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Yqy3LZUOdH5GsZ9j@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/2022 1:17 AM, Mike Kravetz wrote:
> On 06/17/22 10:15, Peter Xu wrote:
>> Hi, Mike,
>>
>> On Thu, Jun 16, 2022 at 02:05:15PM -0700, Mike Kravetz wrote:
>>> @@ -6877,6 +6896,39 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>>>   	return (pte_t *)pmd;
>>>   }
>>>   
>>> +/*
>>> + * Return a mask that can be used to update an address to the last huge
>>> + * page in a page table page mapping size.  Used to skip non-present
>>> + * page table entries when linearly scanning address ranges.  Architectures
>>> + * with unique huge page to page table relationships can define their own
>>> + * version of this routine.
>>> + */
>>> +unsigned long hugetlb_mask_last_page(struct hstate *h)
>>> +{
>>> +	unsigned long hp_size = huge_page_size(h);
>>> +
>>> +	switch (hp_size) {
>>> +	case P4D_SIZE:
>>> +		return PGDIR_SIZE - P4D_SIZE;
>>> +	case PUD_SIZE:
>>> +		return P4D_SIZE - PUD_SIZE;
>>> +	case PMD_SIZE:
>>> +		return PUD_SIZE - PMD_SIZE;
>>> +	default:
>>
>> Should we add a WARN_ON_ONCE() if it should never trigger?
>>
> 
> Sure.  I will add this.
> 
>>> +		break; /* Should never happen */
>>> +	}
>>> +
>>> +	return ~(0UL);
>>> +}
>>> +
>>> +#else
>>> +
>>> +/* See description above.  Architectures can provide their own version. */
>>> +__weak unsigned long hugetlb_mask_last_page(struct hstate *h)
>>> +{
>>> +	return ~(0UL);
>>
>> I'm wondering whether it's better to return 0 rather than ~0 by default.
>> Could an arch with !CONFIG_ARCH_WANT_GENERAL_HUGETLB wrongly skip some
>> valid address ranges with ~0, or perhaps I misread?
> 
> Thank you, thank you, thank you Peter!
> 
> Yes, the 'default' return for hugetlb_mask_last_page() should be 0.  If
> there is no 'optimization', we do not want to modify the address so we
> want to OR with 0 not ~0.  My bad, I must have been thinking AND instead
> of OR.
> 
> I will change here as well as in Baolin's patch.

Ah, I also overlooked this. Thanks Peter, and thanks Mike for updating.
