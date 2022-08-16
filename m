Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0997A595725
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiHPJx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiHPJxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:53:10 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312DAA5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:54:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VMPKNX3_1660640081;
Received: from 30.97.48.47(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VMPKNX3_1660640081)
          by smtp.aliyun-inc.com;
          Tue, 16 Aug 2022 16:54:41 +0800
Message-ID: <eb6eb8ff-f0f3-fe6f-feac-887e46593a0e@linux.alibaba.com>
Date:   Tue, 16 Aug 2022 16:54:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
To:     Haiyue Wang <haiyue.wang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, david@redhat.com, apopple@nvidia.com,
        linmiaohe@huawei.com, ying.huang@intel.com,
        songmuchun@bytedance.com, naoya.horiguchi@linux.dev,
        alex.sierra@amd.com
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220816022102.582865-1-haiyue.wang@intel.com>
 <20220816022102.582865-2-haiyue.wang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220816022102.582865-2-haiyue.wang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/2022 10:21 AM, Haiyue Wang wrote:
> Not all huge page APIs support FOLL_GET option, so move_pages() syscall
> will fail to get the page node information for some huge pages.
> 
> Like x86 on linux 5.19 with 1GB huge page API follow_huge_pud(), it will
> return NULL page for FOLL_GET when calling move_pages() syscall with the
> NULL 'nodes' parameter, the 'status' parameter has '-2' error in array.
> 
> Note: follow_huge_pud() now supports FOLL_GET in linux 6.0.
>        Link: https://lore.kernel.org/all/20220714042420.1847125-3-naoya.horiguchi@linux.dev
> 
> But these huge page APIs don't support FOLL_GET:
>    1. follow_huge_pud() in arch/s390/mm/hugetlbpage.c
>    2. follow_huge_addr() in arch/ia64/mm/hugetlbpage.c
>       It will cause WARN_ON_ONCE for FOLL_GET.
>    3. follow_huge_pgd() in mm/hugetlb.c
> 
> This is an temporary solution to mitigate the side effect of the race
> condition fix by calling follow_page() with FOLL_GET set for huge pages.
> 
> After supporting follow huge page by FOLL_GET is done, this fix can be
> reverted safely.
> 
> Fixes: 4cd614841c06 ("mm: migration: fix possible do_pages_stat_array racing with memory offline")
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> ---

Looks good to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/migrate.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6a1597c92261..581dfaad9257 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1848,6 +1848,7 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>   
>   	for (i = 0; i < nr_pages; i++) {
>   		unsigned long addr = (unsigned long)(*pages);
> +		unsigned int foll_flags = FOLL_DUMP;
>   		struct vm_area_struct *vma;
>   		struct page *page;
>   		int err = -EFAULT;
> @@ -1856,8 +1857,12 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>   		if (!vma)
>   			goto set_status;
>   
> +		/* Not all huge page follow APIs support 'FOLL_GET' */
> +		if (!is_vm_hugetlb_page(vma))
> +			foll_flags |= FOLL_GET;
> +
>   		/* FOLL_DUMP to ignore special (like zero) pages */
> -		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
> +		page = follow_page(vma, addr, foll_flags);
>   
>   		err = PTR_ERR(page);
>   		if (IS_ERR(page))
> @@ -1865,7 +1870,8 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>   
>   		if (page && !is_zone_device_page(page)) {
>   			err = page_to_nid(page);
> -			put_page(page);
> +			if (foll_flags & FOLL_GET)
> +				put_page(page);
>   		} else {
>   			err = -ENOENT;
>   		}
