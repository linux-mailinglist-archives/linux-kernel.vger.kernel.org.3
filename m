Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CEF59960A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347011AbiHSH0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347004AbiHSH0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:26:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45281CCE09
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:26:39 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M8CvL03zSzGpgn;
        Fri, 19 Aug 2022 15:25:02 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 15:26:36 +0800
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before
 set_pte_at()
To:     Muchun Song <muchun.song@linux.dev>,
        Yin Fengwei <fengwei.yin@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-5-linmiaohe@huawei.com>
 <D8C00BDA-160D-40CE-AFBD-9488F85E76CE@linux.dev>
 <ea67ab10-667e-f361-b80f-dafb13da4808@huawei.com>
 <0EAF1279-6A1C-41FA-9A32-414C36B3792A@linux.dev>
 <019c1272-9d01-9d51-91a0-2d656b25c318@intel.com>
 <18adbf89-473e-7ba6-9a2b-522e1592bdc6@huawei.com>
 <9c791de0-b702-1bbe-38a4-30e87d9d1b95@intel.com>
 <931536E2-3948-40AB-88A7-E36F67954AAA@linux.dev>
 <7be98c64-88a1-3bee-7f92-67bb1f4f495b@huawei.com>
 <3B1463C2-9DC4-43D0-93EC-2D2334A20502@linux.dev>
 <7fa5b2b2-dcef-f264-7932-c4fdbb9619d0@intel.com>
 <C6F3DC27-4819-43A4-B884-DD3D03A2DF90@linux.dev>
 <7408156a-f708-5e73-d0a2-69b1acca9b96@intel.com>
 <15DD6DCA-39BC-4EA2-984F-D488E94CC4FF@linux.dev>
 <615c8ec8-6977-2ce0-f049-d2ec1619245c@huawei.com>
 <AB2E4E2F-D8E3-4A9C-BBF1-03652D5F66F2@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e2bcb7a3-837d-518f-cdd2-fc85173cb112@huawei.com>
Date:   Fri, 19 Aug 2022 15:26:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <AB2E4E2F-D8E3-4A9C-BBF1-03652D5F66F2@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/19 11:19, Muchun Song wrote:
> 
> 
>> On Aug 18, 2022, at 20:58, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2022/8/18 17:18, Muchun Song wrote:
>>>
>>>
>>>> On Aug 18, 2022, at 16:54, Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/18/2022 4:40 PM, Muchun Song wrote:
>>>>>
>>>>>
>>>>>> On Aug 18, 2022, at 16:32, Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 8/18/2022 3:59 PM, Muchun Song wrote:
>>>>>>>
>>>>>>>
>>>>>>>> On Aug 18, 2022, at 15:52, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>>>>>
>>>>>>>> On 2022/8/18 10:47, Muchun Song wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> On Aug 18, 2022, at 10:00, Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 8/18/2022 9:55 AM, Miaohe Lin wrote:
>>>>>>>>>>>>>> 	/*
>>>>>>>>>>>>>> 	 * The memory barrier inside __SetPageUptodate makes sure that
>>>>>>>>>>>>>> 	 * preceding stores to the page contents become visible before
>>>>>>>>>>>>>> 	 * the set_pte_at() write.
>>>>>>>>>>>>>> 	 */
>>>>>>>>>>>>>> 	__SetPageUptodate(page);
>>>>>>>>>>>>> IIUC, the case here we should make sure others (CPUs) can see new page’s
>>>>>>>>>>>>> contents after they have saw PG_uptodate is set. I think commit 0ed361dec369
>>>>>>>>>>>>> can tell us more details.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I also looked at commit 52f37629fd3c to see why we need a barrier before
>>>>>>>>>>>>> set_pte_at(), but I didn’t find any info to explain why. I guess we want
>>>>>>>>>>>>> to make sure the order between the page’s contents and subsequent memory
>>>>>>>>>>>>> accesses using the corresponding virtual address, do you agree with this?
>>>>>>>>>>>> This is my understanding also. Thanks.
>>>>>>>>>>> That's also my understanding. Thanks both.
>>>>>>>>>> I have an unclear thing (not related with this patch directly): Who is response
>>>>>>>>>> for the read barrier in the read side in this case?
>>>>>>>>>>
>>>>>>>>>> For SetPageUptodate, there are paring write/read memory barrier.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I have the same question. So I think the example proposed by Miaohe is a little
>>>>>>>>> difference from the case (hugetlb_vmemmap) here.
>>>>>>>>
>>>>>>>> Per my understanding, memory barrier in PageUptodate() is needed because user might access the
>>>>>>>> page contents using page_address() (corresponding pagetable entry already exists) soon. But for
>>>>>>>> the above proposed case, if user wants to access the page contents, the corresponding pagetable
>>>>>>>> should be visible first or the page contents can't be accessed. So there should be a data dependency
>>>>>>>> acting as memory barrier between pagetable entry is loaded and page contents is accessed.
>>>>>>>> Or am I miss something?
>>>>>>>
>>>>>>> Yep, it is a data dependency. The difference between hugetlb_vmemmap and PageUptodate() is that
>>>>>>> the page table (a pointer to the mapped page frame) is loaded by MMU while PageUptodate() is
>>>>>>> loaded by CPU. Seems like the data dependency should be inserted between the MMU access and the CPU
>>>>>>> access. Maybe it is hardware’s guarantee?
>>>>>> I just found the comment in pmd_install() explained why most arch has no read
>>>>>
>>>>> I think pmd_install() is a little different as well. We should make sure the
>>>>> page table walker (like GUP) see the correct PTE entry after they see the pmd
>>>>> entry.
>>>>
>>>> The difference I can see is that pmd/pte thing has both hardware page walker and
>>>> software page walker (like GUP) as read side. While the case here only has hardware
>>>> page walker as read side. But I suppose the memory barrier requirement still apply
>>>> here.
>>>
>>> I am not against this change. Just in order to make me get a better understanding of
>>> hardware behavior.
>>>
>>>>
>>>> Maybe we could do a test: add large delay between reset_struct_page() and set_pte_at?
>>>
>>> Hi Miaohe,
>>>
>>> Would you mind doing this test? One thread do vmemmap_restore_pte(), another thread
>>> detect if it can see a tail page with PG_head after the previous thread has executed
>>> set_pte_at().
>>
>> Will it be easier to construct the memory reorder manually like below?
>>
>> vmemmap_restore_pte()
>> 	...
>> 	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
>> 	/* might a delay. */
>> 	copy_page(to, (void *)walk->reuse_addr);
>> 	reset_struct_pages(to);
> 
> 
> Well, you have changed the code ordering. I thought we don’t change the code
> ordering. Just let the hardware do reordering. The ideal scenario would be
> as follows.
> 
> 
> CPU0:						CPU1:
> 
> vmemmap_restore_pte()
> 	copy_page(to, (void *)walk->reuse_addr);
>         reset_struct_pages(to); // clear the tail page’s PG_head
> 	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> 						// Detect if it can see a tail page with PG_head.
> 
> I should admit it is a little difficult to construct the scenario. After more
> thought, I think here should be inserted a barrier. So:
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Many thanks both for review and discussion. :)

Thanks,
Miaohe Lin

