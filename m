Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD01558369F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiG1CCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbiG1CCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:02:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F014F6BF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:02:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LtYkD135xz1M8QM;
        Thu, 28 Jul 2022 09:59:48 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 10:02:41 +0800
Subject: Re: [RFC PATCH v4 4/8] hugetlbfs: catch and handle truncate racing
 with page faults
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
 <20220706202347.95150-5-mike.kravetz@oracle.com>
 <ee6af38d-f797-a64f-e5c4-78bad3753aca@huawei.com> <YuGLT+RlCynFM9Z4@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ae24c722-0b4a-def4-8cfe-e8b3b48a22c6@huawei.com>
Date:   Thu, 28 Jul 2022 10:02:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YuGLT+RlCynFM9Z4@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/28 3:00, Mike Kravetz wrote:
> On 07/27/22 17:20, Miaohe Lin wrote:
>> On 2022/7/7 4:23, Mike Kravetz wrote:
>>> Most hugetlb fault handling code checks for faults beyond i_size.
>>> While there are early checks in the code paths, the most difficult
>>> to handle are those discovered after taking the page table lock.
>>> At this point, we have possibly allocated a page and consumed
>>> associated reservations and possibly added the page to the page cache.
>>>
>>> When discovering a fault beyond i_size, be sure to:
>>> - Remove the page from page cache, else it will sit there until the
>>>   file is removed.
>>> - Do not restore any reservation for the page consumed.  Otherwise
>>>   there will be an outstanding reservation for an offset beyond the
>>>   end of file.
>>>
>>> The 'truncation' code in remove_inode_hugepages must deal with fault
>>> code potentially removing a page/folio from the cache after the page was
>>> returned by filemap_get_folios and before locking the page.  This can be
>>> discovered by a change in folio_mapping() after taking folio lock.  In
>>> addition, this code must deal with fault code potentially consuming
>>> and returning reservations.  To synchronize this, remove_inode_hugepages
>>> will now take the fault mutex for ALL indices in the hole or truncated
>>> range.  In this way, it KNOWS fault code has finished with the page/index
>>> OR fault code will see the updated file size.
>>>
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> ---
>>
>> <snip>
>>
>>> @@ -5606,8 +5610,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>>>  
>>>  	ptl = huge_pte_lock(h, mm, ptep);
>>>  	size = i_size_read(mapping->host) >> huge_page_shift(h);
>>> -	if (idx >= size)
>>> +	if (idx >= size) {
>>> +		beyond_i_size = true;
>>
>> Thanks for your patch. There is one question:
>>
>> Since races between hugetlb pagefault and truncate is guarded by hugetlb_fault_mutex,
>> do we really need to check it again after taking the page table lock?
>>
> 
> Well, the fault mutex can only guard a single hugetlb page.  The fault mutex
> is actually an array/table of mutexes hashed by mapping address and file index.
> So, during truncation we take take the mutex for each page as they are
> unmapped and removed.  So, the fault mutex only synchronizes operations
> on one specific page.  The idea with this patch is to coordinate the fault
> code and truncate code when operating on the same page.
> 
> In addition, changing the file size happens early in the truncate process
> before taking any locks/mutexes.

I wonder whether we can somewhat live with it to make code simpler. When changing the file size happens
after checking i_size but before taking the page table lock in hugetlb_fault, the truncate code would
remove the hugetlb page from the page cache for us after hugetlb_fault finishes if we don't roll back
when checking i_size again under the page table lock?

In a word, if hugetlb_fault see a truncated inode, back out early. If not, let truncate code does its
work. So we don't need to complicate the already complicated error path. Or am I miss something?

Thanks.

> 
