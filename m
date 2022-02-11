Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383774B2C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245487AbiBKSHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:07:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiBKSHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:07:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B89ED48
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:07:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 065A121138;
        Fri, 11 Feb 2022 18:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644602836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfCjCvHMDToNcN74EaLVeN2Qevm9EI2WuXryd6EYo3E=;
        b=iJjYScGeXDJdKrGbIVkZpBpOs2NTmGhcEVuHTR2ybi1juN+y3MRLMI+ZGahy85llW2vVDZ
        84nSORebjkLF3zaVBkk86m0anx2xRqikbawBWCoUV3tWhArkp7azzkK2Qllvpj52BCD6WZ
        xZ1LHWx7fm7hXRS8oOn8u3BeZwcybtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644602836;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfCjCvHMDToNcN74EaLVeN2Qevm9EI2WuXryd6EYo3E=;
        b=vbjv1NEdRR6wadZfog0v/LSzN+verwvr/Fi+FlO71jxMaIO9pcr2e8TQSdRlujmUpJP+uB
        plPOZ6sgKAZqgMBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB0FB13C9E;
        Fri, 11 Feb 2022 18:07:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2UK0LNOlBmKrGQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 11 Feb 2022 18:07:15 +0000
Message-ID: <0e2dbdf3-f831-abbb-5ca8-02c8d1ab1a01@suse.cz>
Date:   Fri, 11 Feb 2022 19:07:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 06/13] mm/munlock: maintain page->mlock_count while
 unevictable
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
> @@ -72,19 +91,40 @@ void mlock_page(struct page *page)
>   */
>  void munlock_page(struct page *page)
>  {
> +	struct lruvec *lruvec;
> +	int nr_pages = thp_nr_pages(page);
> +
>  	VM_BUG_ON_PAGE(PageTail(page), page);
>  
> +	lock_page_memcg(page);

Hm this (and unlock_page_memcg() below) didn't catch my attention until I
see patch 10/13 removes it again. It also AFAICS wasn't present in the code
removed by patch 1. Am I missing something or it wasn't necessary to add it
in the first place?

> +	lruvec = folio_lruvec_lock_irq(page_folio(page));
> +	if (PageLRU(page) && PageUnevictable(page)) {
> +		/* Then mlock_count is maintained, but might undercount */
> +		if (page->mlock_count)
> +			page->mlock_count--;
> +		if (page->mlock_count)
> +			goto out;
> +	}
> +	/* else assume that was the last mlock: reclaim will fix it if not */
> +
>  	if (TestClearPageMlocked(page)) {
> -		int nr_pages = thp_nr_pages(page);
> -
> -		mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
> -		if (!isolate_lru_page(page)) {
> -			putback_lru_page(page);
> -			count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
> -		} else if (PageUnevictable(page)) {
> -			count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
> -		}
> +		__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
> +		if (PageLRU(page) || !PageUnevictable(page))
> +			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
> +		else
> +			__count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
> +	}
> +
> +	/* page_evictable() has to be checked *after* clearing Mlocked */
> +	if (PageLRU(page) && PageUnevictable(page) && page_evictable(page)) {
> +		del_page_from_lru_list(page, lruvec);
> +		ClearPageUnevictable(page);
> +		add_page_to_lru_list(page, lruvec);
> +		__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
>  	}
> +out:
> +	unlock_page_lruvec_irq(lruvec);
> +	unlock_page_memcg(page);
>  }
>  
>  /*
