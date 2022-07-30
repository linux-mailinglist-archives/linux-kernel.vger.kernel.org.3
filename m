Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65215857DE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 03:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiG3B5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 21:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiG3B5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 21:57:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8205FDEC8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 18:57:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LvnWZ6FMkz1M8RC;
        Sat, 30 Jul 2022 09:54:50 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 30 Jul 2022 09:57:46 +0800
Subject: Re: [RFC PATCH v4 8/8] hugetlb: use new vma_lock for pmd sharing
 synchronization
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
 <20220706202347.95150-9-mike.kravetz@oracle.com>
 <ddab06a9-ab81-5ebd-9273-c50744f6da60@huawei.com> <YuLLqbq1aOwFPsdi@monkey>
 <2adbbbd2-51d2-744d-77b4-374fe651873b@huawei.com> <YuQbxTHGMWTbvahN@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b158e4bf-510a-ee6f-fb16-8fbdb209c4d5@huawei.com>
Date:   Sat, 30 Jul 2022 09:57:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YuQbxTHGMWTbvahN@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/7/30 1:41, Mike Kravetz wrote:
> On 07/29/22 09:41, Miaohe Lin wrote:
>> On 2022/7/29 1:47, Mike Kravetz wrote:
>>> On 07/28/22 14:51, Miaohe Lin wrote:
>> snip
>>>>
>>>> Do we need to check &mm->mm_users == 0 here in case the address_space of corresponding process
>>>> has exited? In this case, mmdrop will drop the last reference and free the skipped_mm. So we will
>>>> use skipped_mm below after it's freed?
>>>>
>>>
>>> Good point!
>>> I think we need to wait to drop since we want to hold the read lock.
>>> Will update.
>>>
>>>>> +		vma = find_vma(skipped_mm, skipped_vm_start);
>>>>> +		if (!vma || vma->vm_file->f_mapping != mapping ||
>>>>
>>>> If skipped_vm_start is unmapped and remapped as a anon vma before we taking the mmap_read_lock,
>>>> vma->vm_file will be NULL?
>>>>
>>>
>>> IIUC, vma->vm_file will always be set even for an anon vma.  The fault
>>> code depends on this.  See beginning of hugetlb_fault() where we
>>> unconditionally do:
>>>
>>> mapping = vma->vm_file->f_mapping;
>>
>> What if vma is non-hugetlb anon vma?
>>
> 
> Right.  The first check after !vma should be for hugetlb as we do not
> care if non-hugetlb vmas and want to quit.  Something like,
> 
> 	vma = find_vma(skipped_mm, skipped_vm_start);
> 	if (!vma || !is_vm_hugetlb_page(vma) ||
> 

This looks good to me. Thanks.

