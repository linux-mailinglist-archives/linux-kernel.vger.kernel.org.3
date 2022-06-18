Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0378550688
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 21:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiFRS7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiFRS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 14:59:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0AFBC14
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 11:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FA22B80A73
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 18:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BF8C3411A;
        Sat, 18 Jun 2022 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655578750;
        bh=ws53h1NXmmX0cetrK3lrrXLOfLYkEXhOk2mt+zenb5A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kt9FDGEs/IUr4/Kscyl9J5QUMEe4BtJVLy+eoV8NRuM0wDG9PdNps5+0RWAvEQeCG
         +awOToJuV/HCJo46hbINa8oIjo7h4RpXzUm7+4vPlscD5CePGO/OMW2lCuF+seZMsO
         u/WyUaPSUFnaAmungcQNUxqsJRSapX6gNy0OeQU0=
Date:   Sat, 18 Jun 2022 11:59:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/madvise: minor cleanup for swapin_walk_pmd_entry()
Message-Id: <20220618115909.5f2d1a4da68cc4115e73d14a@linux-foundation.org>
In-Reply-To: <20220618090527.37843-1-linmiaohe@huawei.com>
References: <20220618090527.37843-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jun 2022 17:05:27 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> Passing index to pte_offset_map_lock() directly so the below calculation
> can be avoided. Rename orig_pte to ptep as it's not changed. Also use
> helper is_swap_pte() to improve the readability. No functional change
> intended.
> 
> ...
>
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -195,7 +195,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
>  static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
>  	unsigned long end, struct mm_walk *walk)
>  {
> -	pte_t *orig_pte;
> +	pte_t *ptep;
>  	struct vm_area_struct *vma = walk->private;
>  	unsigned long index;
>  	struct swap_iocb *splug = NULL;
> @@ -209,11 +209,11 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
>  		struct page *page;
>  		spinlock_t *ptl;
>  
> -		orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
> -		pte = *(orig_pte + ((index - start) / PAGE_SIZE));
> -		pte_unmap_unlock(orig_pte, ptl);
> +		ptep = pte_offset_map_lock(vma->vm_mm, pmd, index, &ptl);
> +		pte = *ptep;
> +		pte_unmap_unlock(ptep, ptl);
>  
> -		if (pte_present(pte) || pte_none(pte))
> +		if (!is_swap_pte(pte))
>  			continue;
>  		entry = pte_to_swp_entry(pte);
>  		if (unlikely(non_swap_entry(entry)))

Also...

From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-madvise-minor-cleanup-for-swapin_walk_pmd_entry-fix
Date: Sat Jun 18 11:58:03 AM PDT 2022

reduce scope of `ptep'

Cc: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/madvise.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/madvise.c~mm-madvise-minor-cleanup-for-swapin_walk_pmd_entry-fix
+++ a/mm/madvise.c
@@ -195,7 +195,6 @@ success:
 static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 	unsigned long end, struct mm_walk *walk)
 {
-	pte_t *ptep;
 	struct vm_area_struct *vma = walk->private;
 	unsigned long index;
 	struct swap_iocb *splug = NULL;
@@ -208,6 +207,7 @@ static int swapin_walk_pmd_entry(pmd_t *
 		swp_entry_t entry;
 		struct page *page;
 		spinlock_t *ptl;
+		pte_t *ptep;
 
 		ptep = pte_offset_map_lock(vma->vm_mm, pmd, index, &ptl);
 		pte = *ptep;
_

