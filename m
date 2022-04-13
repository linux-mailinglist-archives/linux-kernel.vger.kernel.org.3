Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC334FFB45
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiDMQak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiDMQae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:30:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C722457AB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:28:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3C69C1F85F;
        Wed, 13 Apr 2022 16:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649867291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6KBdb4VmTn/pYFWt/6bB7of9YM7bDMO/GcHFky/8y9I=;
        b=DU+HQ89UjD06b24wlLrKpJV2S6O8fTX7sPiiaDe1a88vFba0Ms6yfuO3re5jmtDgOj3Fok
        TxxBs5fTagnMfwnHoiBSDHhfRZhznpIvy35DjGH3HU5ckmGdyBWb9jHu1DQePI4tCGP79t
        QlXEAy0XjyrWhhrp9vCnI1yRQyQ7Zmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649867291;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6KBdb4VmTn/pYFWt/6bB7of9YM7bDMO/GcHFky/8y9I=;
        b=2IMJ7dl+hMr8y+/nt+9WGKZAjpxH6qSdvNoKeRJrh7N5ThCMt47NVXICG7kGUnHzGkW9li
        Z2V4y9x4Vs1Nm/Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7A8113A91;
        Wed, 13 Apr 2022 16:28:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0okTLBr6VmJKSgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 13 Apr 2022 16:28:10 +0000
Message-ID: <012e3889-563b-e7fc-c2e3-e7a6373a55ac@suse.cz>
Date:   Wed, 13 Apr 2022 18:28:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
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
 <20220329160440.193848-13-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 12/16] mm: remember exclusively mapped anonymous pages
 with PG_anon_exclusive
In-Reply-To: <20220329160440.193848-13-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 18:04, David Hildenbrand wrote:
> Let's mark exclusively mapped anonymous pages with PG_anon_exclusive as
> exclusive, and use that information to make GUP pins reliable and stay
> consistent with the page mapped into the page table even if the
> page table entry gets write-protected.
> 
> With that information at hand, we can extend our COW logic to always
> reuse anonymous pages that are exclusive. For anonymous pages that
> might be shared, the existing logic applies.
> 
> As already documented, PG_anon_exclusive is usually only expressive in
> combination with a page table entry. Especially PTE vs. PMD-mapped
> anonymous pages require more thought, some examples: due to mremap() we
> can easily have a single compound page PTE-mapped into multiple page tables
> exclusively in a single process -- multiple page table locks apply.
> Further, due to MADV_WIPEONFORK we might not necessarily write-protect
> all PTEs, and only some subpages might be pinned. Long story short: once
> PTE-mapped, we have to track information about exclusivity per sub-page,
> but until then, we can just track it for the compound page in the head
> page and not having to update a whole bunch of subpages all of the time
> for a simple PMD mapping of a THP.
> 
> For simplicity, this commit mostly talks about "anonymous pages", while
> it's for THP actually "the part of an anonymous folio referenced via
> a page table entry".
> 
> To not spill PG_anon_exclusive code all over the mm code-base, we let
> the anon rmap code to handle all PG_anon_exclusive logic it can easily
> handle.
> 
> If a writable, present page table entry points at an anonymous (sub)page,
> that (sub)page must be PG_anon_exclusive. If GUP wants to take a reliably
> pin (FOLL_PIN) on an anonymous page references via a present
> page table entry, it must only pin if PG_anon_exclusive is set for the
> mapped (sub)page.
> 
> This commit doesn't adjust GUP, so this is only implicitly handled for
> FOLL_WRITE, follow-up commits will teach GUP to also respect it for
> FOLL_PIN without !FOLL_WRITE, to make all GUP pins of anonymous pages

	   without FOLL_WRITE ?

> fully reliable.

<snip>

> @@ -202,11 +203,26 @@ static inline int is_writable_migration_entry(swp_entry_t entry)
>  	return unlikely(swp_type(entry) == SWP_MIGRATION_WRITE);
>  }
>  
> +static inline int is_readable_migration_entry(swp_entry_t entry)
> +{
> +	return unlikely(swp_type(entry) == SWP_MIGRATION_READ);
> +}
> +
> +static inline int is_readable_exclusive_migration_entry(swp_entry_t entry)
> +{
> +	return unlikely(swp_type(entry) == SWP_MIGRATION_READ_EXCLUSIVE);
> +}

This one seems to be missing a !CONFIG_MIGRATION counterpart. Although the
only caller __split_huge_pmd_locked() probably indirectly only exists with
CONFIG_MIGRATION so it's not an immediate issue.  (THP selects COMPACTION
selects MIGRATION)

<snip>

> @@ -3035,10 +3083,19 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>  
>  	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
>  	pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
> +
> +	anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
> +	if (anon_exclusive && page_try_share_anon_rmap(page)) {
> +		set_pmd_at(mm, address, pvmw->pmd, pmdval);
> +		return;

I am admittedly not too familiar with this code, but looks like this means
we fail to migrate the THP, right? But we don't seem to be telling the
caller, which is try_to_migrate_one(), so it will continue and not terminate
the walk and return false?

> +	}
> +
>  	if (pmd_dirty(pmdval))
>  		set_page_dirty(page);
>  	if (pmd_write(pmdval))
>  		entry = make_writable_migration_entry(page_to_pfn(page));
> +	else if (anon_exclusive)
> +		entry = make_readable_exclusive_migration_entry(page_to_pfn(page));
>  	else
>  		entry = make_readable_migration_entry(page_to_pfn(page));
>  	pmdswp = swp_entry_to_pmd(entry);

<snip>

> @@ -1918,6 +1955,15 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  				page_vma_mapped_walk_done(&pvmw);
>  				break;
>  			}
> +			VM_BUG_ON_PAGE(pte_write(pteval) && folio_test_anon(folio) &&
> +				       !anon_exclusive, subpage);
> +			if (anon_exclusive &&
> +			    page_try_share_anon_rmap(subpage)) {
> +				set_pte_at(mm, address, pvmw.pte, pteval);
> +				ret = false;
> +				page_vma_mapped_walk_done(&pvmw);
> +				break;
> +			}

Yeah for the PTE version it seems to do what I'd expect.

>  			/*
>  			 * Store the pfn of the page in a special migration
