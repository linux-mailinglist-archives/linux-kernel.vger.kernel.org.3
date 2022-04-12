Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242734FDC72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381027AbiDLK1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbiDLKUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:20:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6364EA01
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:26:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 45B7E21607;
        Tue, 12 Apr 2022 09:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649755605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/z3vs/uGK6fYvmeCC8WIfRK8ClbBQCivi/ZueGKwhRg=;
        b=CCrJGkWfhf6K63aXfS7Jy9M27QPYITldqJDk62cMjm8rShXsPSTfaSbMCd89qcKLPcq/WD
        ijjxP4UWux1A00vzr3NrHXBek0Dub9htK3YCODbp8WDaJCmMRNlYmiYGeZZJUt5ZdkOoJB
        VYM1Xtr6rDcVf9p3AJC95woI4H5RGdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649755605;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/z3vs/uGK6fYvmeCC8WIfRK8ClbBQCivi/ZueGKwhRg=;
        b=XP+jAGBAXo0qytAx75Y2ByiVQmQcc1SGvd5uN+dQj41CUHsxIj501pYwWjDQ1UfpwsF853
        7m3Es8sJkdcXLOAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE71513A99;
        Tue, 12 Apr 2022 09:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XXqKMdRFVWKDLAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 12 Apr 2022 09:26:44 +0000
Message-ID: <7225391a-5798-94ae-7a01-9a9dd344e13a@suse.cz>
Date:   Tue, 12 Apr 2022 11:26:44 +0200
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
 <20220329160440.193848-10-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 09/16] mm/rmap: use page_move_anon_rmap() when reusing
 a mapped PageAnon() page exclusively
In-Reply-To: <20220329160440.193848-10-david@redhat.com>
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
> We want to mark anonymous pages exclusive, and when using
> page_move_anon_rmap() we know that we are the exclusive user, as
> properly documented. This is a preparation for marking anonymous pages
> exclusive in page_move_anon_rmap().
> 
> In both instances, we're holding page lock and are sure that we're the
> exclusive owner (page_count() == 1). hugetlb already properly uses
> page_move_anon_rmap() in the write fault handler.

Yeah, note that do_wp_page() used to call page_move_anon_rmap() always since
the latter was introduced, until commit 09854ba94c6a ("mm: do_wp_page()
simplification"). Probably not intended.

> Note that in case of a PTE-mapped THP, we'll only end up calling this
> function if the whole THP is only referenced by the single PTE mapping
> a single subpage (page_count() == 1); consequently, it's fine to modify
> the compound page mapping inside page_move_anon_rmap().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/huge_memory.c | 2 ++
>  mm/memory.c      | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c4526343565a..dd16819c5edc 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1317,6 +1317,8 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>  		try_to_free_swap(page);
>  	if (page_count(page) == 1) {
>  		pmd_t entry;
> +
> +		page_move_anon_rmap(page, vma);
>  		entry = pmd_mkyoung(orig_pmd);
>  		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>  		if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry, 1))
> diff --git a/mm/memory.c b/mm/memory.c
> index 03e29c9614e0..4303c0fdcf17 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3303,6 +3303,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  		 * and the page is locked, it's dark out, and we're wearing
>  		 * sunglasses. Hit it.
>  		 */
> +		page_move_anon_rmap(page, vma);
>  		unlock_page(page);
>  		wp_page_reuse(vmf);
>  		return VM_FAULT_WRITE;

