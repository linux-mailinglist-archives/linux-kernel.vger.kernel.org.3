Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A924D43CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiCJJx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbiCJJxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:53:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D95313AA2C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:52:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E3B4B1F381;
        Thu, 10 Mar 2022 09:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646905938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5uc9Zb/DUB2n8zIlbDo/Hnwif6HsJ2MbwsbUkiP3UI=;
        b=dzGJ1MlW+qlz5MVx/BTgnPNHe32Ma4O92yfMiR6lsyCHdtjfa3Lt+ohPEB46Z0tismmk04
        V93IFsfZA3JGcYjUfAnzjsIKglQ7wex6Pf1NaVAFd0vteSHQAsEJjUc2XuTgc7uGuV/ztv
        7IaADm6xkmPXHIBk0gJ9R626pjF36n4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646905938;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5uc9Zb/DUB2n8zIlbDo/Hnwif6HsJ2MbwsbUkiP3UI=;
        b=jlnVMP88lYv7I0vPGbTOlaLEvki/tPwWGctVYRaniYiAfx0rDKATwLu3N0lqpqKRTWwc3Y
        ufmdcScnSfg62+AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5682213FA3;
        Thu, 10 Mar 2022 09:52:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gaKcE1LKKWJoXgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Mar 2022 09:52:18 +0000
Message-ID: <a661aa1c-e5d8-1480-6007-db3ced1b1e00@suse.cz>
Date:   Thu, 10 Mar 2022 10:52:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 5/9] mm/huge_memory: streamline COW logic in
 do_huge_pmd_wp_page()
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
        Liang Zhang <zhangliang5@huawei.com>, linux-mm@kvack.org
References: <20220131162940.210846-1-david@redhat.com>
 <20220131162940.210846-6-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220131162940.210846-6-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 17:29, David Hildenbrand wrote:
> We currently have a different COW logic for anon THP than we have for
> ordinary anon pages in do_wp_page(): the effect is that the issue reported
> in CVE-2020-29374 is currently still possible for anon THP: an unintended
> information leak from the parent to the child.
> 
> Let's apply the same logic (page_count() == 1), with similar
> optimizations to remove additional references first as we really want to
> avoid PTE-mapping the THP and copying individual pages best we can.
> 
> If we end up with a page that has page_count() != 1, we'll have to PTE-map
> the THP and fallback to do_wp_page(), which will always copy the page.
> 
> Note that KSM does not apply to THP.
> 
> I. Interaction with the swapcache and writeback
> 
> While a THP is in the swapcache, the swapcache holds one reference on each
> subpage of the THP. So with PageSwapCache() set, we expect as many
> additional references as we have subpages. If we manage to remove the
> THP from the swapcache, all these references will be gone.
> 
> Usually, a THP is not split when entered into the swapcache and stays a
> compound page. However, try_to_unmap() will PTE-map the THP and use PTE
> swap entries. There are no PMD swap entries for that purpose, consequently,
> we always only swapin subpages into PTEs.
> 
> Removing a page from the swapcache can fail either when there are remaining
> swap entries (in which case COW is the right thing to do) or if the page is
> currently under writeback.
> 
> Having a locked, R/O PMD-mapped THP that is in the swapcache seems to be
> possible only in corner cases, for example, if try_to_unmap() failed
> after adding the page to the swapcache. However, it's comparatively easy to
> handle.
> 
> As we have to fully unmap a THP before starting writeback, and swapin is
> always done on the PTE level, we shouldn't find a R/O PMD-mapped THP in the
> swapcache that is under writeback. This should at least leave writeback
> out of the picture.
> 
> II. Interaction with GUP references
> 
> Having a R/O PMD-mapped THP with GUP references (i.e., R/O references)
> will result in PTE-mapping the THP on a write fault. Similar to ordinary
> anon pages, do_wp_page() will have to copy sub-pages and result in a
> disconnect between the GUP references and the pages actually mapped into
> the page tables. To improve the situation in the future, we'll need
> additional handling to mark anonymous pages as definitely exclusive to a
> single process, only allow GUP pins on exclusive anon pages, and
> disallow sharing of exclusive anon pages with GUP pins e.g., during
> fork().
> 
> III. Interaction with references from LRU pagevecs
> 
> There is no need to try draining the (local) LRU pagevecs in case we would
> stumble over a !PageLRU() page: folio_add_lru() and friends will always
> flush the affected pagevec after adding a compound page to it
> immediately -- pagevec_add_and_need_flush() always returns "true" for them.
> Note that the LRU pagevecs will hold a reference on the compound page for
> a very short time, between adding the page to the pagevec and draining it
> immediately afterwards.
> 
> IV. Interaction with speculative/temporary references
> 
> Similar to ordinary anon pages, other speculative/temporary references on
> the THP, for example, from the pagecache or page migration code, will
> disallow exclusive reuse of the page. We'll have to PTE-map the THP.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/huge_memory.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 406a3c28c026..f34ebc5cb827 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1303,7 +1303,6 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>  	page = pmd_page(orig_pmd);
>  	VM_BUG_ON_PAGE(!PageHead(page), page);
>  
> -	/* Lock page for reuse_swap_page() */
>  	if (!trylock_page(page)) {
>  		get_page(page);
>  		spin_unlock(vmf->ptl);
> @@ -1319,10 +1318,15 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>  	}
>  
>  	/*
> -	 * We can only reuse the page if nobody else maps the huge page or it's
> -	 * part.
> +	 * See do_wp_page(): we can only map the page writable if there are
> +	 * no additional references. Note that we always drain the LRU
> +	 * pagevecs immediately after adding a THP.
>  	 */
> -	if (reuse_swap_page(page)) {
> +	if (page_count(page) > 1 + PageSwapCache(page) * thp_nr_pages(page))
> +		goto unlock_fallback;
> +	if (PageSwapCache(page))
> +		try_to_free_swap(page);
> +	if (page_count(page) == 1) {
>  		pmd_t entry;
>  		entry = pmd_mkyoung(orig_pmd);
>  		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
> @@ -1333,6 +1337,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>  		return VM_FAULT_WRITE;
>  	}
>  
> +unlock_fallback:
>  	unlock_page(page);
>  	spin_unlock(vmf->ptl);
>  fallback:

