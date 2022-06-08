Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F33E5430ED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbiFHM5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239543AbiFHM5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:57:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2479D1C2051
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 05:57:28 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LJ6f04PDDz1KBns;
        Wed,  8 Jun 2022 20:55:36 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 20:57:25 +0800
Subject: Re: [PATCH v1 5/5] mm, hwpoison: enable memory error handling on 1GB
 hugepage
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
 <20220602050631.771414-6-naoya.horiguchi@linux.dev>
 <ff58b65d-e55d-04c0-e26d-3c92830b5912@huawei.com>
 <20220608061635.GA1413099@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5743855d-8f22-0d82-56c0-1ab61ad431b7@huawei.com>
Date:   Wed, 8 Jun 2022 20:57:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220608061635.GA1413099@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/8 14:16, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Jun 07, 2022 at 10:11:24PM +0800, Miaohe Lin wrote:
>> On 2022/6/2 13:06, Naoya Horiguchi wrote:
>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>
>>> Now error handling code is prepared, so remove the blocking code and
>>> enable memory error handling on 1GB hugepage.
>>>
>>
>> I'm nervous about this change. It seems there are many code paths not awared of pud swap entry.
>> I browsed some of them:
>> apply_to_pud_range called from apply_to_page_range:
>>
>> apply_to_pud_range:
>> 	next = pud_addr_end(addr, end);
>> 	if (pud_none(*pud) && !create)
>> 		continue;
>> 	if (WARN_ON_ONCE(pud_leaf(*pud)))
>> 		return -EINVAL;
>> 	if (!pud_none(*pud) && WARN_ON_ONCE(pud_bad(*pud))) {
>> 		if (!create)
>> 			continue;
>> 		pud_clear_bad(pud);
>> 	}
>> 	err = apply_to_pmd_range(mm, pud, addr, next,
>> 				 fn, data, create, mask);
>>
>> For !pud_present case, it will mostly reach apply_to_pmd_range and call pmd_offset on it. And invalid
>> pointer will be de-referenced.
> 
> apply_to_pmd_range() has BUG_ON(pud_huge(*pud)) and apply_to_pte_range() has
> BUG_ON(pmd_huge(*pmd)), so this page table walking code seems to not expect
> to handle pmd/pud level mapping.

Yes, you're right. These functions are not intended to handle pmd/pud level mapping.

> 
>>
>> Another example might be copy_pud_range and so on. So I think it might not be prepared to enable the
>> 1GB hugepage or all of these places should be fixed?
> 
> I think that most of page table walker for user address space should first
> check is_vm_hugetlb_page() and call hugetlb specific walking code for vma
> with VM_HUGETLB.
> copy_page_range() is a good example.  It calls copy_hugetlb_page_range()
> for vma with VM_HUGETLB and the function should support hwpoison entry.
> But I feel that I need testing for confirmation.

Sorry, I missed it should be called from hugetlb variants.

> 
> And I'm not sure that all other are prepared for non-present pud-mapping,
> so I'll need somehow code inspection and testing for each.

I browsed the code again, there still might be some problematic code paths:

1.For follow_pud_mask, !pud_present will mostly reach follow_pmd_mask(). This can be
called for hugetlb page. (Note gup_pud_range is fixed at 15494520b776 ("mm: fix gup_pud_range"))

2.Even for huge_pte_alloc, pud_offset will be called in pud_alloc. So pudp will be an invalid pointer.
And it will be de-referenced later.

I hope I'm not miss something again this time. ;)

> 
> Thanks,
> Naoya Horiguchi

Thanks!

> 

