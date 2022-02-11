Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07974B2BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352260AbiBKRnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:43:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352261AbiBKRnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:43:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A03CFE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:43:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0401621138;
        Fri, 11 Feb 2022 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644601417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vj/Ol/hZTbE5apgmIaAmhVjsuurc9KldGUO8mmrGwvA=;
        b=eluiWHfTkrA40pLxrXbxFdqoQhZWiksAhdnWjtoo3YMM+lVri+p8cLNKFjz7EvHRuMRkvl
        +93ov6g7GGrZuR52jZe8s1pbrFOXxBgxBz8TjcSBx6T+yZTu5ZeURt4GPdS+s4lZEv4jAD
        9qHLLLm7xdbkvAQOYDuoT3AF0u95EUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644601417;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vj/Ol/hZTbE5apgmIaAmhVjsuurc9KldGUO8mmrGwvA=;
        b=91/DtaYamMw5ZQJYiCN+N6ADznO1/JwXV5As6lNF0eo+nzjWwH3GPna5Ppjw1UuCJtXRAg
        bUA6/vBaSBOdz0Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C072513CA2;
        Fri, 11 Feb 2022 17:43:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WSdULkigBmIeEQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 11 Feb 2022 17:43:36 +0000
Message-ID: <e6b6c076-3826-b960-78c4-ccbbd686fc65@suse.cz>
Date:   Fri, 11 Feb 2022 18:43:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 09/13] mm/munlock: delete smp_mb() from
 __pagevec_lru_add_fn()
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
 <9121d34d-4889-51f1-56c7-255138f43b8d@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <9121d34d-4889-51f1-56c7-255138f43b8d@google.com>
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

On 2/6/22 22:45, Hugh Dickins wrote:
> My reading of comment on smp_mb__after_atomic() in __pagevec_lru_add_fn()
> says that it can now be deleted; and that remains so when the next patch
> is added.

Agree with moderate certainty.

> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/swap.c | 37 +++++++++----------------------------
>  1 file changed, 9 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 682a03301a2c..3f770b1ea2c1 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1025,37 +1025,18 @@ static void __pagevec_lru_add_fn(struct folio *folio, struct lruvec *lruvec)
>  
>  	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
>  
> +	folio_set_lru(folio);
>  	/*
> -	 * A folio becomes evictable in two ways:
> -	 * 1) Within LRU lock [munlock_vma_page() and __munlock_pagevec()].
> -	 * 2) Before acquiring LRU lock to put the folio on the correct LRU
> -	 *    and then
> -	 *   a) do PageLRU check with lock [check_move_unevictable_pages]
> -	 *   b) do PageLRU check before lock [clear_page_mlock]
> -	 *
> -	 * (1) & (2a) are ok as LRU lock will serialize them. For (2b), we need
> -	 * following strict ordering:
> -	 *
> -	 * #0: __pagevec_lru_add_fn		#1: clear_page_mlock
> -	 *
> -	 * folio_set_lru()			folio_test_clear_mlocked()
> -	 * smp_mb() // explicit ordering	// above provides strict
> -	 *					// ordering
> -	 * folio_test_mlocked()			folio_test_lru()
> +	 * Is an smp_mb__after_atomic() still required here, before
> +	 * folio_evictable() tests PageMlocked, to rule out the possibility
> +	 * of stranding an evictable folio on an unevictable LRU?  I think
> +	 * not, because munlock_page() only clears PageMlocked while the LRU
> +	 * lock is held.
>  	 *
> -	 *
> -	 * if '#1' does not observe setting of PG_lru by '#0' and
> -	 * fails isolation, the explicit barrier will make sure that
> -	 * folio_evictable check will put the folio on the correct
> -	 * LRU. Without smp_mb(), folio_set_lru() can be reordered
> -	 * after folio_test_mlocked() check and can make '#1' fail the
> -	 * isolation of the folio whose mlocked bit is cleared (#0 is
> -	 * also looking at the same folio) and the evictable folio will
> -	 * be stranded on an unevictable LRU.
> +	 * (That is not true of __page_cache_release(), and not necessarily
> +	 * true of release_pages(): but those only clear PageMlocked after
> +	 * put_page_testzero() has excluded any other users of the page.)
>  	 */
> -	folio_set_lru(folio);
> -	smp_mb__after_atomic();
> -
>  	if (folio_evictable(folio)) {
>  		if (was_unevictable)
>  			__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);

