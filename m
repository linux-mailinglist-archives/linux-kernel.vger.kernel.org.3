Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC29596B87
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbiHQIlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiHQIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:41:47 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062737E811
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:41:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M71cr1ZgDz1N7Hc;
        Wed, 17 Aug 2022 16:38:20 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 16:41:40 +0800
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before
 set_pte_at()
To:     Muchun Song <muchun.song@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-5-linmiaohe@huawei.com>
 <D8C00BDA-160D-40CE-AFBD-9488F85E76CE@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ea67ab10-667e-f361-b80f-dafb13da4808@huawei.com>
Date:   Wed, 17 Aug 2022 16:41:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <D8C00BDA-160D-40CE-AFBD-9488F85E76CE@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/8/17 10:53, Muchun Song wrote:
> 
> 
>> On Aug 16, 2022, at 21:05, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> The memory barrier smp_wmb() is needed to make sure that preceding stores
>> to the page contents become visible before the below set_pte_at() write.
> 
> I’m not sure if you are right. I think it is set_pte_at()’s responsibility.

Maybe not. There're many call sites do the similar things:

hugetlb_mcopy_atomic_pte
__do_huge_pmd_anonymous_page
collapse_huge_page
do_anonymous_page
migrate_vma_insert_page
mcopy_atomic_pte

Take do_anonymous_page as an example:

	/*
	 * The memory barrier inside __SetPageUptodate makes sure that
	 * preceding stores to the page contents become visible before
	 * the set_pte_at() write.
	 */
	__SetPageUptodate(page);

So I think a memory barrier is needed before the set_pte_at() write. Or am I miss something?

Thanks,
Miaohe Lin

> Take arm64 (since it is a Relaxed Memory Order model) as an example (the
> following code snippet is set_pte()), I see a barrier guarantee. So I am
> curious what issues you are facing. So I want to know the basis for you to
> do this change.
> 
>  static inline void set_pte(pte_t *ptep, pte_t pte)
>  {
>         *ptep = pte;
> 
>         /*
>          * Only if the new pte is valid and kernel, otherwise TLB maintenance
>          * or update_mmu_cache() have the necessary barriers.
>          */
>         if (pte_valid_not_user(pte)) {
>                dsb(ishst);
>                isb();
>         }
>  }
> 
> Thanks.
> 
