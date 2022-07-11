Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8CB55C2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243312AbiF1CGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiF1CGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:06:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B852408C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:06:08 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LX7CK6zz1zShWs;
        Tue, 28 Jun 2022 10:02:37 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 10:06:06 +0800
Subject: Re: [PATCH v2 9/9] mm, hwpoison: enable memory error handling on 1GB
 hugepage
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-10-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8bce5d0f-eb82-515f-b7c2-1a644dcebb92@huawei.com>
Date:   Tue, 28 Jun 2022 10:06:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220623235153.2623702-10-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/6/24 7:51, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Now error handling code is prepared, so remove the blocking code and
> enable memory error handling on 1GB hugepage.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

The patch itself looks good to me.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks!

BTW: There might still be some places need to be changed. Maybe we can
process them altogether after this series is done?

> ---
>  include/linux/mm.h      |  1 -
>  include/ras/ras_event.h |  1 -
>  mm/memory-failure.c     | 16 ----------------
>  3 files changed, 18 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 044dc5a2e361..9d7e9b5a4d1d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3284,7 +3284,6 @@ enum mf_action_page_type {
>  	MF_MSG_DIFFERENT_COMPOUND,
>  	MF_MSG_HUGE,
>  	MF_MSG_FREE_HUGE,
> -	MF_MSG_NON_PMD_HUGE,
>  	MF_MSG_UNMAP_FAILED,
>  	MF_MSG_DIRTY_SWAPCACHE,
>  	MF_MSG_CLEAN_SWAPCACHE,
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index d0337a41141c..cbd3ddd7c33d 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -360,7 +360,6 @@ TRACE_EVENT(aer_event,
>  	EM ( MF_MSG_DIFFERENT_COMPOUND, "different compound page after locking" ) \
>  	EM ( MF_MSG_HUGE, "huge page" )					\
>  	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
> -	EM ( MF_MSG_NON_PMD_HUGE, "non-pmd-sized huge page" )		\
>  	EM ( MF_MSG_UNMAP_FAILED, "unmapping failed page" )		\
>  	EM ( MF_MSG_DIRTY_SWAPCACHE, "dirty swapcache page" )		\
>  	EM ( MF_MSG_CLEAN_SWAPCACHE, "clean swapcache page" )		\
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fc7b83cb6468..33521e059f7f 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -728,7 +728,6 @@ static const char * const action_page_types[] = {
>  	[MF_MSG_DIFFERENT_COMPOUND]	= "different compound page after locking",
>  	[MF_MSG_HUGE]			= "huge page",
>  	[MF_MSG_FREE_HUGE]		= "free huge page",
> -	[MF_MSG_NON_PMD_HUGE]		= "non-pmd-sized huge page",
>  	[MF_MSG_UNMAP_FAILED]		= "unmapping failed page",
>  	[MF_MSG_DIRTY_SWAPCACHE]	= "dirty swapcache page",
>  	[MF_MSG_CLEAN_SWAPCACHE]	= "clean swapcache page",
> @@ -1717,21 +1716,6 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  
>  	page_flags = head->flags;
>  
> -	/*
> -	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
> -	 * simply disable it. In order to make it work properly, we need
> -	 * make sure that:
> -	 *  - conversion of a pud that maps an error hugetlb into hwpoison
> -	 *    entry properly works, and
> -	 *  - other mm code walking over page table is aware of pud-aligned
> -	 *    hwpoison entries.
> -	 */
> -	if (huge_page_size(page_hstate(head)) > PMD_SIZE) {
> -		action_result(pfn, MF_MSG_NON_PMD_HUGE, MF_IGNORED);
> -		res = -EBUSY;
> -		goto out;
> -	}
> -
>  	if (!hwpoison_user_mappings(p, pfn, flags, head)) {
>  		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
>  		res = -EBUSY;
> 

