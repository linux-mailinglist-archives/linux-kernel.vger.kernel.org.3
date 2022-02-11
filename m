Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC424B2D20
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiBKStS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:49:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiBKStQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:49:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B295C57
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:49:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 788C8212C5;
        Fri, 11 Feb 2022 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644605352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPoThXiMgcVwXwbCWZMDUGT+DkRAo11uKH0ojRAxncU=;
        b=Lmm3SHWwTd8a0LSnP1bgl7Ooq4yP4pVs2McqNVdeL4Pz3ZrB/jwMQEeKC+Dt/lqu+h6xvw
        GZIIANv1rm/uFAxQNFxZ6ybhQ+865nDGOuvzGchMc+UrcByUdYYXEClJJD+gdQTJDKMizE
        AP8dsjsL7hDm/Yo6Pm5H85tjZ3CgMfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644605352;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPoThXiMgcVwXwbCWZMDUGT+DkRAo11uKH0ojRAxncU=;
        b=ZuucMhu6mUi2/io7C0WqnO8en3CpYXZpJYSwgwim0nMWA565M4r/t9LScsoAvya+LXBTY+
        iHvwygCLJVj9WjBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DA6213C0F;
        Fri, 11 Feb 2022 18:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ek8/CaivBmKtJwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 11 Feb 2022 18:49:12 +0000
Message-ID: <f9960727-d061-8856-45ce-4e33e8ed1de6@suse.cz>
Date:   Fri, 11 Feb 2022 19:49:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
 <90c8962-d188-8687-dc70-628293316343@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 11/13] mm/munlock: page migration needs mlock pagevec
 drained
In-Reply-To: <90c8962-d188-8687-dc70-628293316343@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/22 22:49, Hugh Dickins wrote:
> Page migration of a VM_LOCKED page tends to fail, because when the old
> page is unmapped, it is put on the mlock pagevec with raised refcount,
> which then fails the freeze.
> 
> At first I thought this would be fixed by a local mlock_page_drain() at
> the upper rmap_walk() level - which would have nicely batched all the
> munlocks of that page; but tests show that the task can too easily move
> to another cpu, leaving pagevec residue behind which fails the migration.
> 
> So try_to_migrate_one() drain the local pagevec after page_remove_rmap()
> from a VM_LOCKED vma; and do the same in try_to_unmap_one(), whose
> TTU_IGNORE_MLOCK users would want the same treatment; and do the same
> in remove_migration_pte() - not important when successfully inserting
> a new page, but necessary when hoping to retry after failure.
> 
> Any new pagevec runs the risk of adding a new way of stranding, and we
> might discover other corners where mlock_page_drain() or lru_add_drain()
> would now help.  If the mlock pagevec raises doubts, we can easily add a
> sysctl to tune its length to 1, which reverts to synchronous operation.

Not a fan of adding new sysctls like those as that just pushes the failure
of kernel devs to poor admins :)
The old pagevec usage deleted by patch 1 was limited to the naturally larger
munlock_vma_pages_range() operation. The new per-cpu based one is more
general, which obviously has its advantages, but then it might bring new
corner cases.
So if this turns out to be an big problem, I would rather go back to the
limited scenario pagevec than a sysctl?

> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/migrate.c | 2 ++
>  mm/rmap.c    | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index f4bcf1541b62..e7d0b68d5dcb 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -251,6 +251,8 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
>  				page_add_file_rmap(new, vma, false);
>  			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
>  		}
> +		if (vma->vm_flags & VM_LOCKED)
> +			mlock_page_drain(smp_processor_id());
>  
>  		/* No need to invalidate - it was non-present before */
>  		update_mmu_cache(vma, pvmw.address, pvmw.pte);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 5442a5c97a85..714bfdc72c7b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1656,6 +1656,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  		 * See Documentation/vm/mmu_notifier.rst
>  		 */
>  		page_remove_rmap(subpage, vma, PageHuge(page));
> +		if (vma->vm_flags & VM_LOCKED)
> +			mlock_page_drain(smp_processor_id());
>  		put_page(page);
>  	}
>  
> @@ -1930,6 +1932,8 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>  		 * See Documentation/vm/mmu_notifier.rst
>  		 */
>  		page_remove_rmap(subpage, vma, PageHuge(page));
> +		if (vma->vm_flags & VM_LOCKED)
> +			mlock_page_drain(smp_processor_id());
>  		put_page(page);
>  	}
>  

