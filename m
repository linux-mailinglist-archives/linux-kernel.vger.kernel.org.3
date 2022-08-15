Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F25592ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbiHOHk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241492AbiHOHks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:40:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A765960C6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660549246; x=1692085246;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=yOnnsZdwTjhOV4GiTvcT6QmvdCBeALTyO14/f1k1UWk=;
  b=m7rCS6xujoFPPosWNdVp7cjS1w0LWwn5tssqATb0oMnMMOepIL/W1WTw
   Tm96cpPmA2bVfRGNylqwRMYKCkDhrRZTGIU+bW3QFmTWblc2AIlAaCArE
   IMeTowVXLkOm4xBKzMuAHY/osu+X+CIItovarX/Dqo9o+gne6yE+112HE
   +iF2Pke2JF3VKx78JNItRGRi5j/eq33ABGzYqMGFbNObK9o6P+P4DWge3
   Lxw0tQ3BfRNtndXgcMCHjf8v2BsS9eQJdU9TjK5C2hbIxKGzcnr9oUq5X
   1HW0w4kaOssTKIMNoPSQjMBG7ekO4vHDYCDI+prhJva59F4ZCYwK9de6J
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="293181715"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="293181715"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 00:40:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="582796154"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 00:40:26 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Haiyue Wang <haiyue.wang@intel.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <david@redhat.com>,
        <apopple@nvidia.com>, <linmiaohe@huawei.com>,
        <songmuchun@bytedance.com>, <naoya.horiguchi@linux.dev>,
        <alex.sierra@amd.com>
Subject: Re: [PATCH v5 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
References: <20220812084921.409142-1-haiyue.wang@intel.com>
        <20220815070240.470469-1-haiyue.wang@intel.com>
        <20220815070240.470469-2-haiyue.wang@intel.com>
Date:   Mon, 15 Aug 2022 15:40:17 +0800
In-Reply-To: <20220815070240.470469-2-haiyue.wang@intel.com> (Haiyue Wang's
        message of "Mon, 15 Aug 2022 15:02:39 +0800")
Message-ID: <87k07ac5um.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haiyue Wang <haiyue.wang@intel.com> writes:

> Not all huge page APIs support FOLL_GET option, so move_pages() syscall
> will fail to get the page node information for some huge pages.
>
> Like x86 on linux 5.19 with 1GB huge page API follow_huge_pud(), it will
> return NULL page for FOLL_GET when calling move_pages() syscall with the
> NULL 'nodes' parameter, the 'status' parameter has '-2' error in array.
>
> Note: follow_huge_pud() now supports FOLL_GET in linux 6.0.
>       Link: https://lore.kernel.org/all/20220714042420.1847125-3-naoya.horiguchi@linux.dev
>
> But these huge page APIs don't support FOLL_GET:
>   1. follow_huge_pud() in arch/s390/mm/hugetlbpage.c
>   2. follow_huge_addr() in arch/ia64/mm/hugetlbpage.c
>      It will cause WARN_ON_ONCE for FOLL_GET.
>   3. follow_huge_pgd() in mm/hugetlb.c
>
> This is an temporary solution to mitigate the side effect of the race
> condition fix by calling follow_page() with FOLL_GET set for huge pages.
>
> After supporting follow huge page by FOLL_GET is done, this fix can be
> reverted safely.
>
> Fixes: 4cd614841c06 ("mm: migration: fix possible do_pages_stat_array racing with memory offline")
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/migrate.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6a1597c92261..581dfaad9257 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1848,6 +1848,7 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>  
>  	for (i = 0; i < nr_pages; i++) {
>  		unsigned long addr = (unsigned long)(*pages);
> +		unsigned int foll_flags = FOLL_DUMP;
>  		struct vm_area_struct *vma;
>  		struct page *page;
>  		int err = -EFAULT;
> @@ -1856,8 +1857,12 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>  		if (!vma)
>  			goto set_status;
>  
> +		/* Not all huge page follow APIs support 'FOLL_GET' */
> +		if (!is_vm_hugetlb_page(vma))
> +			foll_flags |= FOLL_GET;
> +
>  		/* FOLL_DUMP to ignore special (like zero) pages */
> -		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
> +		page = follow_page(vma, addr, foll_flags);
>  
>  		err = PTR_ERR(page);
>  		if (IS_ERR(page))
> @@ -1865,7 +1870,8 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>  
>  		if (page && !is_zone_device_page(page)) {
>  			err = page_to_nid(page);
> -			put_page(page);
> +			if (foll_flags & FOLL_GET)
> +				put_page(page);
>  		} else {
>  			err = -ENOENT;
>  		}
