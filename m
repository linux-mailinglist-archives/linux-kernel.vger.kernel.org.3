Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A144052B1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 07:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiERFbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiERFbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:31:35 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A632313E9D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:31:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h186so1194781pgc.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9kEkRsbbLsq2qV20KhrtybMkQdykLU0YNEuC/iZp52Q=;
        b=g3ld8fRujihoN2eknR81U31G0FS+U73zYUSpmkf3drtwft6xCz09BWP5LHGh21RXHM
         ZqMqDENux59/5mX5V3SKbj4OgNfOR82SIerS4igN9GirjvkWmFEOPxXZxJaGWj4Abein
         4G5MQewmtTkjQyn6q0YPmUrm/jgXpQMfcrB9sshsTB84rkSscWZTQ7FRXErBkfE/5LY7
         69qMmHhS81MFeUam+P6BcV/1bsgMlTXNe7d17BaPewtAn4hdKqBi6tYpaI/EQI5RddlD
         qAery9se8TulsXXoZMHQluAoLgj4AG9Kl5+tQbAUy4NRdDPGs0fn61jYIuKJcnzJQ/fM
         xKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9kEkRsbbLsq2qV20KhrtybMkQdykLU0YNEuC/iZp52Q=;
        b=bGyPkc3LENFfNKE6Eh+rVhJJxYqsLIYYSeJ3o5a2uJMZddkndCGNUDg3hKQUSHD8m2
         UYSmNfO0BsbVskKffSB1TG1onF/nVMGvwabBrs+/eXhg8fJXKfpMU7W9Nur1Hc81Jg9/
         h2xaGRmIW1yw1V+JQVZJspvpDnOjLofB73hpKo0VwkgbEvtSP8TSgPcA5EMGnFWGkem3
         WwMAPEc99SPuWzNKDrat6XIIB0sWKu1f+8/854j2vviwoS71ujW3NkOeo6O6NwSRyE68
         p0kvwzWnHOY9CjQPsvD5HLoI49v1g+/f8iruikNf7sVFE+PVffWnVVRO/vQZPkUMUNiu
         yf8g==
X-Gm-Message-State: AOAM533575fXgiIPAqMuwpLG17MGgipCN03LZailogSuLX5mc+N1G06Z
        xfO6QiC3TIdqUC14f/khGo7miA==
X-Google-Smtp-Source: ABdhPJyeuvMsiegKpQJ08W3/jMArV0nt/mYOgEbBrg7ZcQmLJahdE2agmiW8yXxuNTu6FNSGK2Nbaw==
X-Received: by 2002:a63:2048:0:b0:3db:7de7:34b4 with SMTP id r8-20020a632048000000b003db7de734b4mr22634662pgm.105.1652851893176;
        Tue, 17 May 2022 22:31:33 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id in19-20020a17090b439300b001cb6527ca39sm2666824pjb.0.2022.05.17.22.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:31:32 -0700 (PDT)
Date:   Wed, 18 May 2022 13:31:29 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: pvmw: check possible huge PMD map by
 transhuge_vma_suitable()
Message-ID: <YoSEsa2zvqylYuZC@FVFYT0MHHV2J.usts.net>
References: <20220513191705.457775-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513191705.457775-1-shy828301@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 12:17:05PM -0700, Yang Shi wrote:
> IIUC PVMW checks if the vma is possibly huge PMD mapped by
> transparent_hugepage_active() and "pvmw->nr_pages >= HPAGE_PMD_NR".
> 
> Actually pvmw->nr_pages is returned by compound_nr() or
> folio_nr_pages(), so the page should be THP as long as "pvmw->nr_pages
> >= HPAGE_PMD_NR".  And it is guaranteed THP is allocated for valid VMA
> in the first place.  But it may be not PMD mapped if the VMA is file
> VMA and it is not properly aligned.  The transhuge_vma_suitable()
> is used to do such check, so replace transparent_hugepage_active() to
> it, which is too heavy and overkilling.
> 
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
> v2: * Fixed build error for !CONFIG_TRANSPARENT_HUGEPAGE
>     * Removed fixes tag per Willy
> 
>  include/linux/huge_mm.h | 8 ++++++--
>  mm/page_vma_mapped.c    | 2 +-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index fbf36bb1be22..c2826b1f4069 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -117,8 +117,10 @@ extern struct kobj_attribute shmem_enabled_attr;
>  extern unsigned long transparent_hugepage_flags;
>  
>  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> -		unsigned long haddr)
> +		unsigned long addr)
>  {
> +	unsigned long haddr;
> +
>  	/* Don't have to check pgoff for anonymous vma */
>  	if (!vma_is_anonymous(vma)) {
>  		if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
> @@ -126,6 +128,8 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>  			return false;
>  	}
>  
> +	haddr = addr & HPAGE_PMD_MASK;
> +
>  	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
>  		return false;
>  	return true;
> @@ -328,7 +332,7 @@ static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
>  }
>  
>  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> -		unsigned long haddr)
> +		unsigned long addr)
>  {
>  	return false;
>  }
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index c10f839fc410..e971a467fcdf 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -243,7 +243,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  			 * cleared *pmd but not decremented compound_mapcount().
>  			 */
>  			if ((pvmw->flags & PVMW_SYNC) &&
> -			    transparent_hugepage_active(vma) &&
> +			    transhuge_vma_suitable(vma, pvmw->address) &&

How about the following diff? Then we do not need to change
transhuge_vma_suitable().  All the users of transhuge_vma_suitable()
are already do the alignment by themselves.

Thanks.

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index c10f839fc410..0aed5ca60c67 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -243,7 +243,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
                         * cleared *pmd but not decremented compound_mapcount().
                         */
                        if ((pvmw->flags & PVMW_SYNC) &&
-                           transparent_hugepage_active(vma) &&
+                           IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
+                           transhuge_vma_suitable(vma, pvmw->address & HPAGE_PMD_MASK) &&
                            (pvmw->nr_pages >= HPAGE_PMD_NR)) {
                                spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);

>  			    (pvmw->nr_pages >= HPAGE_PMD_NR)) {
>  				spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
>  
> -- 
> 2.26.3
> 
> 
