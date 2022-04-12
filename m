Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAB94FDAFC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391707AbiDLJgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389363AbiDLJXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:23:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766AEFFD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:37:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 083B81F857;
        Tue, 12 Apr 2022 08:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649752636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G4ao738LLtWqNZgjmUvHl2wQE4C+ip35g2Uztgp8uAo=;
        b=Hod7n3879Pt5Km1ei/HV+w94yTgZ+//8QZg+AaD5zVU52g2b1/ITGOJcaK92n7K01T29tV
        ZsEcUVgZ9Z0wam2sxQQH03bix+5wGkdPRZMokBrj8cNfgWm7TvgDpR+6pkA1UK0r375SiM
        1pMjMyvvmd6RoBUeXVWn09Av3YWH8JU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649752636;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G4ao738LLtWqNZgjmUvHl2wQE4C+ip35g2Uztgp8uAo=;
        b=rvt1sOBwqRU9RHohtoNx1tvQvk2VX8ObxsOJGVZg+2a5Wl0nRNcuvmUQ1eaH4/zM1Rke8m
        sajVXI7I3VVxVzBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 855C513780;
        Tue, 12 Apr 2022 08:37:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xi3rHzs6VWIHGAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 12 Apr 2022 08:37:15 +0000
Message-ID: <b43366d3-2235-36f9-75df-a33575b68db2@suse.cz>
Date:   Tue, 12 Apr 2022 10:37:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 07/16] mm/rmap: pass rmap flags to
 hugepage_add_anon_rmap()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220329160440.193848-1-david@redhat.com>
 <20220329160440.193848-8-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220329160440.193848-8-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 18:04, David Hildenbrand wrote:
> Let's prepare for passing RMAP_EXCLUSIVE, similarly as we do for
> page_add_anon_rmap() now. RMAP_COMPOUND is implicit for hugetlb
> pages and ignored.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/rmap.h | 2 +-
>  mm/migrate.c         | 3 ++-
>  mm/rmap.c            | 9 ++++++---
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index aa734d2e2b01..f47bc937c383 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -191,7 +191,7 @@ void page_add_file_rmap(struct page *, struct vm_area_struct *,
>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
>  void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
> -		unsigned long address);
> +		unsigned long address, rmap_t flags);
>  void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
>  		unsigned long address);
>  
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 436f0ec2da03..48db9500d20e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -232,7 +232,8 @@ static bool remove_migration_pte(struct folio *folio,
>  			pte = pte_mkhuge(pte);
>  			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
>  			if (folio_test_anon(folio))
> -				hugepage_add_anon_rmap(new, vma, pvmw.address);
> +				hugepage_add_anon_rmap(new, vma, pvmw.address,
> +						       RMAP_NONE);
>  			else
>  				page_dup_file_rmap(new, true);
>  			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 71bf881da2a6..b972eb8f351b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2347,9 +2347,11 @@ void rmap_walk_locked(struct folio *folio, const struct rmap_walk_control *rwc)
>   * The following two functions are for anonymous (private mapped) hugepages.
>   * Unlike common anonymous pages, anonymous hugepages have no accounting code
>   * and no lru code, because we handle hugepages differently from common pages.
> + *
> + * RMAP_COMPOUND is ignored.
>   */
> -void hugepage_add_anon_rmap(struct page *page,
> -			    struct vm_area_struct *vma, unsigned long address)
> +void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
> +			    unsigned long address, rmap_t flags)
>  {
>  	struct anon_vma *anon_vma = vma->anon_vma;
>  	int first;
> @@ -2359,7 +2361,8 @@ void hugepage_add_anon_rmap(struct page *page,
>  	/* address might be in next vma when migration races vma_adjust */
>  	first = atomic_inc_and_test(compound_mapcount_ptr(page));
>  	if (first)
> -		__page_set_anon_rmap(page, vma, address, 0);
> +		__page_set_anon_rmap(page, vma, address,
> +				     !!(flags & RMAP_EXCLUSIVE));
>  }
>  
>  void hugepage_add_new_anon_rmap(struct page *page,

