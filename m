Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBFD54CC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348160AbiFOPOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244854AbiFOPOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:14:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2A9369DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:14:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i15so10692213plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1qhKddPqonN/zP/GiDkOrtFuHIgE7zljctNwI9S4zyY=;
        b=Z+B7AoLqPAPphaZAEaeSdA8hjKnZpgaxJYTjYPC5x2GwU1vPoYtDnzr1Cy22VQtVpB
         GS+uzvDFiCSy/zXXTSQU2Ss60c3Qsaa1XJfoNXrXw9uTdznIDB8NXmjDy/S3fPR3iirw
         Wo9KPIGYpg1dxcDUqkvxoYJGXty29kmT3l6Bjg+vll+tOhL4w2cCibJ4cK93P3fofMF/
         O76/kYxE3R7OVvo+HVbkis37t821Kpa1znqsUwyM2OR6OAO6MwE1gNUhZdss24IDslTY
         yHX85OGBVsFiNkMjBzi0MUP1KF98jhCsH4ChDMCe8D1LCRY+PMfgC7yEs/qbZ33Y6p4X
         JCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1qhKddPqonN/zP/GiDkOrtFuHIgE7zljctNwI9S4zyY=;
        b=6SfrQsYRoBol2eBOUX8I7kB5k1PYmld9/datAORQcdy7NUGEn0EgsLYuNcVk3T8kcn
         20Rki5SuC0bm1/dn46Uv5jbCE7IgtktRMbLZVcj2CRzC0ZtETZtivcPGIPQLXRpxldpi
         H4gAncahsTqIgvscvA9CQqQ9dV5XcETxaHpcCdcwiZAZDt0hP6GxZGU53tcVr96+PElf
         +41wY2gOO5O41NUN3Pj1+zZg2mnzBSaqpfE04ZXERt4c+YK/mTtjugxsy0kfgANTusGx
         nBJRZwHDV+Ef16Kf5Q5lkjyM9sjBH9MU17Ed85j8+84mgOWzHjvLteQcKrI4K5LmxZVb
         YPYQ==
X-Gm-Message-State: AJIora8HPA2QS9F6T1ieGtU/y+l7jMiSYBqtSKR5O7SYa5n83RGUuMaR
        obLqmVoHGewo7IQyHsQyKoK0tQ==
X-Google-Smtp-Source: AGRyM1uxHj6R4sbIxf0Zg4t5IclxLq6pAQSzx2aBq8UNHAow2bgLm6NcTqYoXR6ttPc2ANrhu4bvEA==
X-Received: by 2002:a17:90b:38c8:b0:1e8:5202:f6d4 with SMTP id nn8-20020a17090b38c800b001e85202f6d4mr3272pjb.149.1655306076948;
        Wed, 15 Jun 2022 08:14:36 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902654d00b001637704269fsm9468817pln.223.2022.06.15.08.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:14:36 -0700 (PDT)
Date:   Wed, 15 Jun 2022 08:14:32 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, aarcange@redhat.com,
        willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, david@redhat.com,
        surenb@google.com, peterx@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/khugepaged: stop swapping in page when
 VM_FAULT_RETRY occurs
Message-ID: <Yqn3WLLy+5MnqZn3@google.com>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
 <20220611084731.55155-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611084731.55155-3-linmiaohe@huawei.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jun 16:47, Miaohe Lin wrote:
> When do_swap_page returns VM_FAULT_RETRY, we do not retry here and thus
> swap entry will remain in pagetable. This will result in later failure.
> So stop swapping in pages in this case to save cpu cycles.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/khugepaged.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 73570dfffcec..a8adb2d1e9c6 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1003,19 +1003,16 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
>  		swapped_in++;
>  		ret = do_swap_page(&vmf);
>  
> -		/* do_swap_page returns VM_FAULT_RETRY with released mmap_lock */
> +		/*
> +		 * do_swap_page returns VM_FAULT_RETRY with released mmap_lock.
> +		 * Note we treat VM_FAULT_RETRY as VM_FAULT_ERROR here because
> +		 * we do not retry here and swap entry will remain in pagetable
> +		 * resulting in later failure.
> +		 */
>  		if (ret & VM_FAULT_RETRY) {
>  			mmap_read_lock(mm);
> -			if (hugepage_vma_revalidate(mm, haddr, &vma)) {
> -				/* vma is no longer available, don't continue to swapin */
> -				trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> -				return false;
> -			}
> -			/* check if the pmd is still valid */
> -			if (mm_find_pmd(mm, haddr) != pmd) {
> -				trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> -				return false;
> -			}
> +			trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> +			return false;
>  		}
>  		if (ret & VM_FAULT_ERROR) {
>  			trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
> -- 
> 2.23.0
> 
>

I've convinced myself this is correct, but don't understand how we got here.
AFAICT, we've always continued to fault in pages, and, as you mention, don't
retry ones that have failed with VM_FAULT_RETRY - so
__collapse_huge_page_isolate() should fail. I don't think (?) there is any
benefit to continuing to swap if we don't handle VM_FAULT_RETRY appropriately.

So, I think this change looks good from that perspective. I suppose the only
other question would be: should we handle the VM_FAULT_RETRY case? Maybe 1
additional attempt then fail? AFAIK, this mostly (?) happens when the page is
locked.  Maybe it's not worth the extra complexity though..
