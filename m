Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868804FC1C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348376AbiDKQHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345446AbiDKQHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:07:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD6E15A1D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:04:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD67B21603;
        Mon, 11 Apr 2022 16:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649693087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHFh1jwX5pV2tRmPHOuYUbDsVAwhBs6UFlw43cW6vHc=;
        b=SEf4w1+6eXB4ors94oWCkbB/HwpK6i0bgzB17lKX3SJ+kD6pMErJauFwRkK1ygDreoET+w
        nFonp3qTdJMZuE2ehLIo3CFSN5QY3bGUkBTzuCMoLffbU/ld96WPdj/WkIKBzww7ylT94F
        u9P2GxVuJnkit067Jyq5ne2XYg7mWzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649693087;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHFh1jwX5pV2tRmPHOuYUbDsVAwhBs6UFlw43cW6vHc=;
        b=uYnaGC9h5c7Rjf0CqFTJQN4PTi56bH/6ffoKOF30QxC0xlWksXYk/mO4hIe3EQh1SthlqS
        yI13+mHx4bDwCLDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 795CD13A93;
        Mon, 11 Apr 2022 16:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bo4ZHZ9RVGIJcQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 11 Apr 2022 16:04:47 +0000
Message-ID: <cfae3eb8-009c-106d-c77f-c15278f238a1@suse.cz>
Date:   Mon, 11 Apr 2022 18:04:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 01/16] mm/rmap: fix missing swap_free() in
 try_to_unmap() after arch_unmap_one() failed
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
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org,
        Khalid Aziz <khalid.aziz@oracle.com>
References: <20220329160440.193848-1-david@redhat.com>
 <20220329160440.193848-2-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220329160440.193848-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 18:04, David Hildenbrand wrote:
> In case arch_unmap_one() fails, we already did a swap_duplicate(). let's
> undo that properly via swap_free().
> 
> Fixes: ca827d55ebaa ("mm, swap: Add infrastructure for saving page metadata on swap")
> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/rmap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 5cb970d51f0a..07f59bc6ffc1 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1637,6 +1637,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  				break;
>  			}
>  			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
> +				swap_free(entry);
>  				set_pte_at(mm, address, pvmw.pte, pteval);
>  				ret = false;
>  				page_vma_mapped_walk_done(&pvmw);

