Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20AF4FFDCF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbiDMSbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiDMSbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:31:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22F7517D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:29:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A1031FCFD;
        Wed, 13 Apr 2022 18:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649874549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=udxWiFetaVRX6oE+syOH0avrLwfMsA1ybP67ux1QMmI=;
        b=ShHqV0T6frA0p6n4+3CmYyqzMh3pnmAuGVfChug9KR9FOMDIiNHuMLsbgjLUM1u/QqETLU
        vW3LllDzl8UFYorhU2t9l34+w+g3BLn0knDt3ECyUkj3Mz1P5B6nMaZd46/YoO3e3Lxc6G
        VwOn9WyCOv/iWdm7Wqy95VIIdfCPons=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649874549;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=udxWiFetaVRX6oE+syOH0avrLwfMsA1ybP67ux1QMmI=;
        b=vnv6S+u3ccJM4Vew/+tglAGC1CBh8yD/X5XM+78B7qzAbgzS1hZbj2jMTsc1xxMZf3KVSS
        vHt9kJI3HFvP/SDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06F9313A91;
        Wed, 13 Apr 2022 18:29:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JUHHAHUWV2JGdAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 13 Apr 2022 18:29:09 +0000
Message-ID: <abc33620-b0dc-67e3-d3a9-2094475bf16e@suse.cz>
Date:   Wed, 13 Apr 2022 20:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 12/16] mm: remember exclusively mapped anonymous pages
 with PG_anon_exclusive
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
> fully reliable.
> 
> Whenever an anonymous page is to be shared (fork(), KSM), or when
> temporarily unmapping an anonymous page (swap, migration), the relevant
> PG_anon_exclusive bit has to be cleared to mark the anonymous page
> possibly shared. Clearing will fail if there are GUP pins on the page:
> * For fork(), this means having to copy the page and not being able to
>   share it. fork() protects against concurrent GUP using the PT lock and
>   the src_mm->write_protect_seq.
> * For KSM, this means sharing will fail. For swap this means, unmapping
>   will fail, For migration this means, migration will fail early. All
>   three cases protect against concurrent GUP using the PT lock and a
>   proper clear/invalidate+flush of the relevant page table entry.
> 
> This fixes memory corruptions reported for FOLL_PIN | FOLL_WRITE, when a
> pinned page gets mapped R/O and the successive write fault ends up
> replacing the page instead of reusing it. It improves the situation for
> O_DIRECT/vmsplice/... that still use FOLL_GET instead of FOLL_PIN,
> if fork() is *not* involved, however swapout and fork() are still
> problematic. Properly using FOLL_PIN instead of FOLL_GET for these
> GUP users will fix the issue for them.
> 
> I. Details about basic handling
> 
> I.1. Fresh anonymous pages
> 
> page_add_new_anon_rmap() and hugepage_add_new_anon_rmap() will mark the
> given page exclusive via __page_set_anon_rmap(exclusive=1). As that is
> the mechanism fresh anonymous pages come into life (besides migration
> code where we copy the page->mapping), all fresh anonymous pages will
> start out as exclusive.
> 
> I.2. COW reuse handling of anonymous pages
> 
> When a COW handler stumbles over a (sub)page that's marked exclusive, it
> simply reuses it. Otherwise, the handler tries harder under page lock to
> detect if the (sub)page is exclusive and can be reused. If exclusive,
> page_move_anon_rmap() will mark the given (sub)page exclusive.
> 
> Note that hugetlb code does not yet check for PageAnonExclusive(), as it
> still uses the old COW logic that is prone to the COW security issue
> because hugetlb code cannot really tolerate unnecessary/wrong COW as
> huge pages are a scarce resource.
> 
> I.3. Migration handling
> 
> try_to_migrate() has to try marking an exclusive anonymous page shared
> via page_try_share_anon_rmap(). If it fails because there are GUP pins
> on the page, unmap fails. migrate_vma_collect_pmd() and
> __split_huge_pmd_locked() are handled similarly.
> 
> Writable migration entries implicitly point at shared anonymous pages.
> For readable migration entries that information is stored via a new
> "readable-exclusive" migration entry, specific to anonymous pages.
> 
> When restoring a migration entry in remove_migration_pte(), information
> about exlusivity is detected via the migration entry type, and
> RMAP_EXCLUSIVE is set accordingly for
> page_add_anon_rmap()/hugepage_add_anon_rmap() to restore that
> information.
> 
> I.4. Swapout handling
> 
> try_to_unmap() has to try marking the mapped page possibly shared via
> page_try_share_anon_rmap(). If it fails because there are GUP pins on the
> page, unmap fails. For now, information about exclusivity is lost. In the
> future, we might want to remember that information in the swap entry in
> some cases, however, it requires more thought, care, and a way to store
> that information in swap entries.
> 
> I.5. Swapin handling
> 
> do_swap_page() will never stumble over exclusive anonymous pages in the
> swap cache, as try_to_migrate() prohibits that. do_swap_page() always has
> to detect manually if an anonymous page is exclusive and has to set
> RMAP_EXCLUSIVE for page_add_anon_rmap() accordingly.
> 
> I.6. THP handling
> 
> __split_huge_pmd_locked() has to move the information about exclusivity
> from the PMD to the PTEs.
> 
> a) In case we have a readable-exclusive PMD migration entry, simply insert
> readable-exclusive PTE migration entries.
> 
> b) In case we have a present PMD entry and we don't want to freeze
> ("convert to migration entries"), simply forward PG_anon_exclusive to
> all sub-pages, no need to temporarily clear the bit.
> 
> c) In case we have a present PMD entry and want to freeze, handle it
> similar to try_to_migrate(): try marking the page shared first. In case
> we fail, we ignore the "freeze" instruction and simply split ordinarily.
> try_to_migrate() will properly fail because the THP is still mapped via
> PTEs.
> 
> When splitting a compound anonymous folio (THP), the information about
> exclusivity is implicitly handled via the migration entries: no need to
> replicate PG_anon_exclusive manually.
> 
> I.7. fork() handling
> 
> fork() handling is relatively easy, because PG_anon_exclusive is only
> expressive for some page table entry types.
> 
> a) Present anonymous pages
> 
> page_try_dup_anon_rmap() will mark the given subpage shared -- which
> will fail if the page is pinned. If it failed, we have to copy (or
> PTE-map a PMD to handle it on the PTE level).
> 
> Note that device exclusive entries are just a pointer at a PageAnon()
> page. fork() will first convert a device exclusive entry to a present
> page table and handle it just like present anonymous pages.
> 
> b) Device private entry
> 
> Device private entries point at PageAnon() pages that cannot be mapped
> directly and, therefore, cannot get pinned.
> 
> page_try_dup_anon_rmap() will mark the given subpage shared, which
> cannot fail because they cannot get pinned.
> 
> c) HW poison entries
> 
> PG_anon_exclusive will remain untouched and is stale -- the page table
> entry is just a placeholder after all.
> 
> d) Migration entries
> 
> Writable and readable-exclusive entries are converted to readable
> entries: possibly shared.
> 
> I.8. mprotect() handling
> 
> mprotect() only has to properly handle the new readable-exclusive
> migration entry:
> 
> When write-protecting a migration entry that points at an anonymous
> page, remember the information about exclusivity via the
> "readable-exclusive" migration entry type.
> 
> II. Migration and GUP-fast
> 
> Whenever replacing a present page table entry that maps an exclusive
> anonymous page by a migration entry, we have to mark the page possibly
> shared and synchronize against GUP-fast by a proper
> clear/invalidate+flush to make the following scenario impossible:
> 
> 1. try_to_migrate() places a migration entry after checking for GUP pins
>    and marks the page possibly shared.
> 2. GUP-fast pins the page due to lack of synchronization
> 3. fork() converts the "writable/readable-exclusive" migration entry into a
>    readable migration entry
> 4. Migration fails due to the GUP pin (failing to freeze the refcount)
> 5. Migration entries are restored. PG_anon_exclusive is lost
> 
> -> We have a pinned page that is not marked exclusive anymore.
> 
> Note that we move information about exclusivity from the page to the
> migration entry as it otherwise highly overcomplicates fork() and
> PTE-mapping a THP.
> 
> III. Swapout and GUP-fast
> 
> Whenever replacing a present page table entry that maps an exclusive
> anonymous page by a swap entry, we have to mark the page possibly
> shared and synchronize against GUP-fast by a proper
> clear/invalidate+flush to make the following scenario impossible:
> 
> 1. try_to_unmap() places a swap entry after checking for GUP pins and
>    clears exclusivity information on the page.
> 2. GUP-fast pins the page due to lack of synchronization.
> 
> -> We have a pinned page that is not marked exclusive anymore.
> 
> If we'd ever store information about exclusivity in the swap entry,
> similar to migration handling, the same considerations as in II would
> apply. This is future work.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
