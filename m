Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D30959CE03
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbiHWBnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiHWBnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:43:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBB15A80E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 18:43:00 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MBX486msQznThm;
        Tue, 23 Aug 2022 09:40:40 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 09:42:58 +0800
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before
 set_pte_at()
To:     Muchun Song <muchun.song@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-5-linmiaohe@huawei.com>
 <CBD5F92C-1D62-4331-A214-5B6D08E35809@linux.dev>
 <bfb89f55-a618-4b36-7075-654922a8ddaa@huawei.com>
 <F8381885-8B9F-405B-A860-AFB8A675D5A7@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c4c99f81-444e-91f3-5eb9-07590676341a@huawei.com>
Date:   Tue, 23 Aug 2022 09:42:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <F8381885-8B9F-405B-A860-AFB8A675D5A7@linux.dev>
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

On 2022/8/22 18:23, Muchun Song wrote:
> 
> 
>> On Aug 22, 2022, at 16:45, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2022/8/20 16:12, Muchun Song wrote:
>>>
>>>
>>>> On Aug 16, 2022, at 21:05, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>> The memory barrier smp_wmb() is needed to make sure that preceding stores
>>>> to the page contents become visible before the below set_pte_at() write.
>>>
>>> I found another place where is a similar case. See kasan_populate_vmalloc_pte() in
>>> mm/kasan/shadow.c. 
>>
>> Thanks for your report.
>>
>>>
>>> Should we fix it as well?
>>
>> I'm not familiar with kasan yet, but I think memory barrier is needed here or memory corrupt
>> can't be detected until the contents are visible. smp_mb__after_atomic before set_pte_at should
>> be enough? What's your opinion?
> 
> I didn’t see any atomic operation between set_pte_at() and memset(), I don’t think
> smp_mb__after_atomic() is feasible if we really need to insert a barrier. I suggest

Oh, it should be smp_mb__after_spinlock(), i.e. something like below:

diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 0e3648b603a6..38e503c89740 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -277,6 +277,7 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,

        spin_lock(&init_mm.page_table_lock);
        if (likely(pte_none(*ptep))) {
+               smp_mb__after_spinlock();
                set_pte_at(&init_mm, addr, ptep, pte);
                page = 0;
        }

Does this make sense for you?

> you to send a RFC patch to KASAN maintainers, they are more familiar with this than
> us.

Sounds like a good idea. Will do it.

Thanks,
Miaohe Lin

