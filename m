Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1E057141C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiGLINM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiGLINF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:13:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F3E39B19D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:13:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F4891516;
        Tue, 12 Jul 2022 01:13:03 -0700 (PDT)
Received: from [10.162.42.8] (unknown [10.162.42.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4F973F73D;
        Tue, 12 Jul 2022 01:13:00 -0700 (PDT)
Message-ID: <520e487b-a274-9b92-b01b-164ee9a2b6c3@arm.com>
Date:   Tue, 12 Jul 2022 13:42:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] hugetlb: fix memoryleak in hugetlb_mcopy_atomic_pte
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, songmuchun@bytedance.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220709092629.54291-1-linmiaohe@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220709092629.54291-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/22 14:56, Miaohe Lin wrote:
> When alloc_huge_page fails, *pagep is set to NULL without put_page first.
> So the hugepage indicated by *pagep is leaked.
> 
> Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/hugetlb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 06c2d86b1ba3..598c37279fee 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5962,6 +5962,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  
>  		page = alloc_huge_page(dst_vma, dst_addr, 0);
>  		if (IS_ERR(page)) {
> +			put_page(*pagep);
>  			ret = -ENOMEM;
>  			*pagep = NULL;
>  			goto out;
