Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F0B54BEA9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiFOAXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiFOAXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:23:33 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF4E2715B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:23:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 31so8294326pgv.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wT9rm3o+U6Igx3tYZ1kl9LxKasFqYQ4xLe4QS7mGtYI=;
        b=lOyo/bPY+/LdlgWRDSn/H+9ELq2+IjUJzijgfjjERq9OZRCtZXyNiPhqrkppJk3rdV
         8NfNeWbf2lGIFm0Y/dp0D2DKv3E6gY3kVEwI67pCnnJbrw4X2kvz+jgPTI94Dcpj1zx1
         boTU5/EZhdh0egytNN6UO5PjGYWt4biAJMwlyDLBSE9K2aK8+JZE96SLE6Q0f6hFj/q9
         UbIOcNYX1dJU/+eneSZ4A3LvsIRnAWHWLejjzpz3ZgMST6C/54l6CfOPGzCCzd4BobEe
         CXhFeVlGaW4g8/cwNatdegTEhcQSy5XMHTeQ5T82w+akp22K6HkXb4JQ5Cmwj6ehRTIE
         BONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wT9rm3o+U6Igx3tYZ1kl9LxKasFqYQ4xLe4QS7mGtYI=;
        b=QwqYkQVSvlxoMEKColLrKHPPqE7SkqzbkI60txNT4D4eLCyQPlyFjJ+X1vjit3zkED
         HXWX2x8Tej4yss3qYYFfTL94Z6PhWYOm/xkOC/tVGX7KSbdAb4W/CD99e3cpL8qKFuvO
         9000N7QWlvzbuGGtCBxnfkiKVuQ2gCUXoIzlnIJIK09Q8sxbxQF7YAbITB+q1Dj+oqa0
         O3aq+zkJEyKD3rJw3STxFrvOUCm/sA7nbqCTQeEj0fxqIAXURbCpyhIPgNKF8htifPUp
         3HA046+SVrEgfunbv7OV7zOIjmbfSK+72M7z6NCIB7LpxawecUZ+RGchllyhGvnTyqdF
         aGNg==
X-Gm-Message-State: AOAM533zoq9ZuyDbVEEl9BeJ4hYcBhPiX/ZLUUIWLrowKwfUZN0V+ar6
        xdGDqz66/Wd2IhSkCIEE408T0Q==
X-Google-Smtp-Source: ABdhPJwmHec19iD7+TBbTDyaQcMfBjK2xCa2d4H8yDZ/SWAF6NAB9QYcVI6DTGnXhSDYMgPByscS5Q==
X-Received: by 2002:a63:6a85:0:b0:3fa:722a:fbdc with SMTP id f127-20020a636a85000000b003fa722afbdcmr6695651pgc.174.1655252609559;
        Tue, 14 Jun 2022 17:23:29 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090a8e8100b001dc37aef4ffsm188391pjo.48.2022.06.14.17.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 17:23:28 -0700 (PDT)
Date:   Tue, 14 Jun 2022 17:23:24 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, aarcange@redhat.com,
        willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, david@redhat.com,
        surenb@google.com, peterx@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mm/khugepaged: trivial typo and codestyle cleanup
Message-ID: <YqkmfLu9z/hcvebl@google.com>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
 <20220611084731.55155-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611084731.55155-4-linmiaohe@huawei.com>
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
> Fix some typos and tweak the code to meet codestyle. No functional
> change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/khugepaged.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a8adb2d1e9c6..1b5dd3820eac 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -260,7 +260,7 @@ static ssize_t khugepaged_max_ptes_none_store(struct kobject *kobj,
>  	unsigned long max_ptes_none;
>  
>  	err = kstrtoul(buf, 10, &max_ptes_none);
> -	if (err || max_ptes_none > HPAGE_PMD_NR-1)
> +	if (err || max_ptes_none > HPAGE_PMD_NR - 1)
>  		return -EINVAL;
>  
>  	khugepaged_max_ptes_none = max_ptes_none;
> @@ -286,7 +286,7 @@ static ssize_t khugepaged_max_ptes_swap_store(struct kobject *kobj,
>  	unsigned long max_ptes_swap;
>  
>  	err  = kstrtoul(buf, 10, &max_ptes_swap);
> -	if (err || max_ptes_swap > HPAGE_PMD_NR-1)
> +	if (err || max_ptes_swap > HPAGE_PMD_NR - 1)
>  		return -EINVAL;
>  
>  	khugepaged_max_ptes_swap = max_ptes_swap;
> @@ -313,7 +313,7 @@ static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
>  	unsigned long max_ptes_shared;
>  
>  	err  = kstrtoul(buf, 10, &max_ptes_shared);
> -	if (err || max_ptes_shared > HPAGE_PMD_NR-1)
> +	if (err || max_ptes_shared > HPAGE_PMD_NR - 1)
>  		return -EINVAL;
>  
>  	khugepaged_max_ptes_shared = max_ptes_shared;
> @@ -599,7 +599,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  	int none_or_zero = 0, shared = 0, result = 0, referenced = 0;
>  	bool writable = false;
>  
> -	for (_pte = pte; _pte < pte+HPAGE_PMD_NR;
> +	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
>  	     _pte++, address += PAGE_SIZE) {
>  		pte_t pteval = *_pte;
>  		if (pte_none(pteval) || (pte_present(pteval) &&
> @@ -1216,7 +1216,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>  
>  	memset(khugepaged_node_load, 0, sizeof(khugepaged_node_load));
>  	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
> -	for (_address = address, _pte = pte; _pte < pte+HPAGE_PMD_NR;
> +	for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>  	     _pte++, _address += PAGE_SIZE) {
>  		pte_t pteval = *_pte;
>  		if (is_swap_pte(pteval)) {
> @@ -1306,7 +1306,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>  		/*
>  		 * Check if the page has any GUP (or other external) pins.
>  		 *
> -		 * Here the check is racy it may see totmal_mapcount > refcount
> +		 * Here the check is racy it may see total_mapcount > refcount
>  		 * in some cases.
>  		 * For example, one process with one forked child process.
>  		 * The parent has the PMD split due to MADV_DONTNEED, then
> @@ -1557,7 +1557,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>  		 * mmap_write_lock(mm) as PMD-mapping is likely to be split
>  		 * later.
>  		 *
> -		 * Not that vma->anon_vma check is racy: it can be set up after
> +		 * Note that vma->anon_vma check is racy: it can be set up after
>  		 * the check but before we took mmap_lock by the fault path.
>  		 * But page lock would prevent establishing any new ptes of the
>  		 * page, so we are safe.
> -- 
> 2.23.0
> 
> 

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
