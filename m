Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA7354D903
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358439AbiFPDvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiFPDvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:51:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD1E457B1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:51:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 596C81F966;
        Thu, 16 Jun 2022 03:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655351459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kgekXoCDL26pheijKCAbO6D+nCr6WwwLdj7j0T3u+/A=;
        b=OpJuqgXMMfz+tNzD3+xYrklWCIAxh1JDRO9FJpP3iKnVcWxAlBnd6D8Ty2Rexjg0LJV98G
        EIVGPOoU7jHZ+ifRsOZ1W5rnevFqwh8U0UWqv61c5ljnc0NdCn16jNDf+XvPhB5oj/4/bN
        +cJjR2DEHjyklwX8ycdVH+EVS6uN54w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655351459;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kgekXoCDL26pheijKCAbO6D+nCr6WwwLdj7j0T3u+/A=;
        b=JaDcKUWz9UYhbnX49/Q7zIcvfL36cu57dKQVoTCr75wCFZh8fdFGnTl1MgVvhi1IPSe/WV
        MPXEK9jD+DWflVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00DEF1344E;
        Thu, 16 Jun 2022 03:50:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZyPSOKKoqmK8KwAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 16 Jun 2022 03:50:58 +0000
Date:   Thu, 16 Jun 2022 05:50:57 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb: remove minimum_order variable
Message-ID: <YqqooWsR36fnFSKA@localhost.localdomain>
References: <20220616033846.96937-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616033846.96937-1-songmuchun@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 11:38:46AM +0800, Muchun Song wrote:
> The following commit:
> 
>   commit 641844f5616d ("mm/hugetlb: introduce minimum hugepage order")
> 
> fixed a static checker warning and introduced a global variable minimum_order
> to fix the warning.  However, the local variable in dissolve_free_huge_pages()
> can be initialized to huge_page_order(&default_hstate) to fix the warning.
> So remove minimum_order to simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/hugetlb.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8ea4e51d8186..405d1c7441c9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -66,12 +66,6 @@ static bool hugetlb_cma_page(struct page *page, unsigned int order)
>  #endif
>  static unsigned long hugetlb_cma_size __initdata;
>  
> -/*
> - * Minimum page order among possible hugepage sizes, set to a proper value
> - * at boot time.
> - */
> -static unsigned int minimum_order __read_mostly = UINT_MAX;
> -
>  __initdata LIST_HEAD(huge_boot_pages);
>  
>  /* for command line parsing */
> @@ -2161,11 +2155,17 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
>  	unsigned long pfn;
>  	struct page *page;
>  	int rc = 0;
> +	unsigned int order;
> +	struct hstate *h;
>  
>  	if (!hugepages_supported())
>  		return rc;
>  
> -	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
> +	order = huge_page_order(&default_hstate);
> +	for_each_hstate(h)
> +		order = min(order, huge_page_order(h));
> +
> +	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << order) {
>  		page = pfn_to_page(pfn);
>  		rc = dissolve_free_huge_page(page);
>  		if (rc)
> @@ -3157,9 +3157,6 @@ static void __init hugetlb_init_hstates(void)
>  	struct hstate *h, *h2;
>  
>  	for_each_hstate(h) {
> -		if (minimum_order > huge_page_order(h))
> -			minimum_order = huge_page_order(h);
> -
>  		/* oversize hugepages were init'ed in early boot */
>  		if (!hstate_is_gigantic(h))
>  			hugetlb_hstate_alloc_pages(h);
> @@ -3184,7 +3181,6 @@ static void __init hugetlb_init_hstates(void)
>  				h->demote_order = h2->order;
>  		}
>  	}
> -	VM_BUG_ON(minimum_order == UINT_MAX);
>  }
>  
>  static void __init report_hugepages(void)
> -- 
> 2.11.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
