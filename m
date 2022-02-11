Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9061D4B2BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352023AbiBKRTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:19:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244536AbiBKRTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:19:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E22C95
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:19:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0ED1F1F3AA;
        Fri, 11 Feb 2022 17:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644599980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uILjlSDN1FN8OOLhjeaE5XGyYvqt6MKuWO5g9cvdqUI=;
        b=cnkiRgwT+qCMYd/sM4tBXGuCaPvNwTUHOCuk377e+Ms6STQjzR2ByZIyLm6hgriLLsg7wB
        L+u5r7awJjmgYs1MOYkOgyeIsKLevomq/XAtyR2GxG8s2JkUX7TfUBOXqURzowofLSgsgV
        pwSSHfJSV9b1ydfntC1F+zOtvXNvKrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644599980;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uILjlSDN1FN8OOLhjeaE5XGyYvqt6MKuWO5g9cvdqUI=;
        b=Wd1WNoDqiOq4dCFsftayNEyUQ1Z2lq5wdTS3VAaBXv+sWHUpRKGObnFileZh1OXJp+CF0z
        nomQ+z/bYDQ26NCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD6E713C97;
        Fri, 11 Feb 2022 17:19:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LWGdLauaBmKfBwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 11 Feb 2022 17:19:39 +0000
Message-ID: <8a974112-bfa8-7c48-e429-4ad5ec8e5ac4@suse.cz>
Date:   Fri, 11 Feb 2022 18:19:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 08/13] mm/migrate: __unmap_and_move() push good newpage to
 LRU
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
 <33fb71cf-ea55-123a-bf9d-fdad297cae1@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <33fb71cf-ea55-123a-bf9d-fdad297cae1@google.com>
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

On 2/6/22 22:43, Hugh Dickins wrote:
> Compaction, NUMA page movement, THP collapse/split, and memory failure
> do isolate unevictable pages from their "LRU", losing the record of
> mlock_count in doing so (isolators are likely to use page->lru for their
> own private lists, so mlock_count has to be presumed lost).
> 
> That's unfortunate, and we should put in some work to correct that: one
> can imagine a function to build up the mlock_count again - but it would
> require i_mmap_rwsem for read, so be careful where it's called.  Or
> page_referenced_one() and try_to_unmap_one() might do that extra work.
> 
> But one place that can very easily be improved is page migration's
> __unmap_and_move(): a small adjustment to where the successful new page
> is put back on LRU, and its mlock_count (if any) is built back up by
> remove_migration_ptes().
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/migrate.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7c4223ce2500..f4bcf1541b62 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1032,6 +1032,21 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>  	if (!page_mapped(page))
>  		rc = move_to_new_page(newpage, page, mode);
>  
> +	/*
> +	 * When successful, push newpage to LRU immediately: so that if it
> +	 * turns out to be an mlocked page, remove_migration_ptes() will
> +	 * automatically build up the correct newpage->mlock_count for it.
> +	 *
> +	 * We would like to do something similar for the old page, when
> +	 * unsuccessful, and other cases when a page has been temporarily
> +	 * isolated from the unevictable LRU: but this case is the easiest.
> +	 */
> +	if (rc == MIGRATEPAGE_SUCCESS) {
> +		lru_cache_add(newpage);
> +		if (page_was_mapped)
> +			lru_add_drain();
> +	}
> +
>  	if (page_was_mapped)
>  		remove_migration_ptes(page,
>  			rc == MIGRATEPAGE_SUCCESS ? newpage : page, false);
> @@ -1045,20 +1060,12 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>  	unlock_page(page);
>  out:
>  	/*
> -	 * If migration is successful, decrease refcount of the newpage
> +	 * If migration is successful, decrease refcount of the newpage,
>  	 * which will not free the page because new page owner increased
> -	 * refcounter. As well, if it is LRU page, add the page to LRU
> -	 * list in here. Use the old state of the isolated source page to
> -	 * determine if we migrated a LRU page. newpage was already unlocked
> -	 * and possibly modified by its owner - don't rely on the page
> -	 * state.
> +	 * refcounter.
>  	 */
> -	if (rc == MIGRATEPAGE_SUCCESS) {
> -		if (unlikely(!is_lru))
> -			put_page(newpage);
> -		else
> -			putback_lru_page(newpage);
> -	}
> +	if (rc == MIGRATEPAGE_SUCCESS)
> +		put_page(newpage);
>  
>  	return rc;
>  }

