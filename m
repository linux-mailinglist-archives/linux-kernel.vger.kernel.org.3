Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C37F596774
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbiHQCeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbiHQCeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:34:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1981550054
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:34:15 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6sRs3dvMzXdNr;
        Wed, 17 Aug 2022 10:30:01 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 10:34:12 +0800
Subject: Re: [PATCH v6 2/2] mm: fix the handling Non-LRU pages returned by
 follow_page
To:     Haiyue Wang <haiyue.wang@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <apopple@nvidia.com>, <ying.huang@intel.com>,
        <songmuchun@bytedance.com>, <naoya.horiguchi@linux.dev>,
        <alex.sierra@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220816022102.582865-1-haiyue.wang@intel.com>
 <20220816022102.582865-3-haiyue.wang@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f9bb1faf-3e09-2db4-5210-4cea09654452@huawei.com>
Date:   Wed, 17 Aug 2022 10:34:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220816022102.582865-3-haiyue.wang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/8/16 10:21, Haiyue Wang wrote:
> The handling Non-LRU pages returned by follow_page() jumps directly, it
> doesn't call put_page() to handle the reference count, since 'FOLL_GET'
> flag for follow_page() has get_page() called. Fix the zone device page
> check by handling the page reference count correctly before returning.
> 
> And as David reviewed, "device pages are never PageKsm pages". Drop this
> zone device page check for break_ksm().
> 
> Fixes: 3218f8712d6b ("mm: handling Non-LRU pages returned by vm_normal_pages")
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Thanks for your fixing. LGTM with one nit below. But I have no strong opinion on it.
So with or without fixing below nit:

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  mm/huge_memory.c |  4 ++--
>  mm/ksm.c         | 12 +++++++++---
>  mm/migrate.c     | 19 ++++++++++++-------
>  3 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8a7c1b344abe..b2ba17c3dcd7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2963,10 +2963,10 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  		/* FOLL_DUMP to ignore special (like zero) pages */
>  		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
>  
> -		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
> +		if (IS_ERR_OR_NULL(page))
>  			continue;
>  
> -		if (!is_transparent_hugepage(page))
> +		if (is_zone_device_page(page) || !is_transparent_hugepage(page))

!is_transparent_hugepage should already do the work here? IIRC, zone_device_page can't be
a transhuge page anyway. And only transparent_hugepage is cared here.

Thanks,
Miaohe Lin

