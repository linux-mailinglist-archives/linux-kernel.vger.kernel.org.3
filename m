Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C60545CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346411AbiFJHJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346369AbiFJHJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:09:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8E832239C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:09:38 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LKBp571kXzRhWY;
        Fri, 10 Jun 2022 15:06:21 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 15:09:35 +0800
Subject: Re: [v3 PATCH 1/7] mm: khugepaged: check THP flag in
 hugepage_vma_check()
To:     Yang Shi <shy828301@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <vbabka@suse.cz>, <kirill.shutemov@linux.intel.com>,
        <willy@infradead.org>, <akpm@linux-foundation.org>
References: <20220606214414.736109-1-shy828301@gmail.com>
 <20220606214414.736109-2-shy828301@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <85932a40-a05b-3610-5836-aab36d2664f0@huawei.com>
Date:   Fri, 10 Jun 2022 15:09:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220606214414.736109-2-shy828301@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/6/7 5:44, Yang Shi wrote:
> Currently the THP flag check in hugepage_vma_check() will fallthrough if
> the flag is NEVER and VM_HUGEPAGE is set.  This is not a problem for now
> since all the callers have the flag checked before or can't be invoked if
> the flag is NEVER.
> 
> However, the following patch will call hugepage_vma_check() in more
> places, for example, page fault, so this flag must be checked in
> hugepge_vma_check().
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks!

> ---
>  mm/khugepaged.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 671ac7800e53..84b9cf4b9be9 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -458,6 +458,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>  	if (shmem_file(vma->vm_file))
>  		return shmem_huge_enabled(vma);
>  
> +	if (!khugepaged_enabled())
> +		return false;
> +
>  	/* THP settings require madvise. */
>  	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
>  		return false;
> 

