Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829A44B25C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245552AbiBKM2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:28:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350083AbiBKM1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:27:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E60BF57
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:27:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D3E291F3A2;
        Fri, 11 Feb 2022 12:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644582447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OMTT5iiyjFVPOD3au65s1i3U4tMtMbGOAoi81BKHy10=;
        b=n/nMaDalA292S13jD0IMDYqoNMoH9n8kldxKj7r9fxHjM/49sIcbCFDArZFVr2CJDyZZ+g
        R3AqvsZNUVKj9icpY97GAf7Uu3RRK66wSs7IXbeduQ1HoPBsKX/wOO92CFS6GOZMJUDjs8
        vCVrBLQhdCoEmCOyRp7LtZFEnIOia1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644582447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OMTT5iiyjFVPOD3au65s1i3U4tMtMbGOAoi81BKHy10=;
        b=S/YLpLRl7YBreu/bCwbF4OgqcJW6FYEUtlo0MjGKVHUvufGvWyvWVRc/ceEcpyHCxP45gg
        IF206xDiQWhlJcBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9974613C6D;
        Fri, 11 Feb 2022 12:27:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6AjUJC9WBmIbbgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 11 Feb 2022 12:27:27 +0000
Message-ID: <826e69d0-c81c-06c1-c675-b54bd4557ff3@suse.cz>
Date:   Fri, 11 Feb 2022 13:27:27 +0100
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
 <3d204af4-664f-e4b0-4781-16718a2efb9c@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 06/13] mm/munlock: maintain page->mlock_count while
 unevictable
In-Reply-To: <3d204af4-664f-e4b0-4781-16718a2efb9c@google.com>
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

On 2/6/22 22:40, Hugh Dickins wrote:
> Previous patches have been preparatory: now implement page->mlock_count.
> The ordering of the "Unevictable LRU" is of no significance, and there is
> no point holding unevictable pages on a list: place page->mlock_count to
> overlay page->lru.prev (since page->lru.next is overlaid by compound_head,
> which needs to be even so as not to satisfy PageTail - though 2 could be
> added instead of 1 for each mlock, if that's ever an improvement).
> 
> But it's only safe to rely on or modify page->mlock_count while lruvec
> lock is held and page is on unevictable "LRU" - we can save lots of edits
> by continuing to pretend that there's an imaginary LRU here (there is an
> unevictable count which still needs to be maintained, but not a list).
> 
> The mlock_count technique suffers from an unreliability much like with
> page_mlock(): while someone else has the page off LRU, not much can
> be done.  As before, err on the safe side (behave as if mlock_count 0),
> and let try_to_unlock_one() move the page to unevictable if reclaim finds
> out later on - a few misplaced pages don't matter, what we want to avoid
> is imbalancing reclaim by flooding evictable lists with unevictable pages.
> 
> I am not a fan of "if (!isolate_lru_page(page)) putback_lru_page(page);":
> if we have taken lruvec lock to get the page off its present list, then
> we save everyone trouble (and however many extra atomic ops) by putting
> it on its destination list immediately.

Good point.

> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mm_inline.h | 11 +++++--
>  include/linux/mm_types.h  | 19 +++++++++--
>  mm/huge_memory.c          |  5 ++-
>  mm/memcontrol.c           |  3 +-
>  mm/mlock.c                | 68 +++++++++++++++++++++++++++++++--------
>  mm/mmzone.c               |  7 ++++
>  mm/swap.c                 |  1 +
>  7 files changed, 92 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index b725839dfe71..884d6f6af05b 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -99,7 +99,8 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
>  
>  	update_lru_size(lruvec, lru, folio_zonenum(folio),
>  			folio_nr_pages(folio));
> -	list_add(&folio->lru, &lruvec->lists[lru]);
> +	if (lru != LRU_UNEVICTABLE)
> +		list_add(&folio->lru, &lruvec->lists[lru]);
>  }
>  
>  static __always_inline void add_page_to_lru_list(struct page *page,
> @@ -115,6 +116,7 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
>  
>  	update_lru_size(lruvec, lru, folio_zonenum(folio),
>  			folio_nr_pages(folio));
> +	/* This is not expected to be used on LRU_UNEVICTABLE */

Felt uneasy about this at first because it's just a _tail version of
lruvec_add_folio, and there's probably nothing fundamental about the users
of _tail to not encounter unevictable pages. But if the assumption is ever
violated, the poisoned list head should make it immediately clear, so I
guess that's fine.

>  	list_add_tail(&folio->lru, &lruvec->lists[lru]);
>  }
>  
> @@ -127,8 +129,11 @@ static __always_inline void add_page_to_lru_list_tail(struct page *page,
>  static __always_inline
>  void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
>  {
> -	list_del(&folio->lru);
> -	update_lru_size(lruvec, folio_lru_list(folio), folio_zonenum(folio),
> +	enum lru_list lru = folio_lru_list(folio);
> +
> +	if (lru != LRU_UNEVICTABLE)
> +		list_del(&folio->lru);
> +	update_lru_size(lruvec, lru, folio_zonenum(folio),
>  			-folio_nr_pages(folio));
>  }
>  
