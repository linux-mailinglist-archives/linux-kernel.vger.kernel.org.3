Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A346E4B2CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352665AbiBKS0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:26:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351978AbiBKS0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:26:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7362A196
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:26:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 292341F3A8;
        Fri, 11 Feb 2022 18:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644604001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lagKek43O/qlYtO4egbfLmplkVBaMU559cGMwzFezxo=;
        b=K2BX9sNSDjEWvAhU0x5qHgKPtI+KVUPLVavnf8/L/YHsPtXCtzqGjOVvbTjjJKJ+GuEnfB
        5+Gf651FgODORs5XHOhZarftbYzk0C8wdhBfe12w1McvstvCUMNOs6aC2ZgY/N7E3EVZX8
        k4M44X3assACkkUXkQrBIyg9lPmi0IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644604001;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lagKek43O/qlYtO4egbfLmplkVBaMU559cGMwzFezxo=;
        b=KTQc5p58rG+TvkAyrmsRVSVOg6xbHTtJXRQyYs1EK7uTfiYIrNczq97jvoYa4oiiFrPFnh
        d1aP+yYUh7Omf0AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D79F613CA5;
        Fri, 11 Feb 2022 18:26:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WZsCNGCqBmJrIAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 11 Feb 2022 18:26:40 +0000
Message-ID: <64fd7f7d-f797-fa3a-303b-cf36c1a62820@suse.cz>
Date:   Fri, 11 Feb 2022 19:26:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 10/13] mm/munlock: mlock_page() munlock_page() batch by
 pagevec
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
 <eadba522-cfe1-b0d6-56fc-7bc9f649b89d@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <eadba522-cfe1-b0d6-56fc-7bc9f649b89d@google.com>
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

On 2/6/22 22:47, Hugh Dickins wrote:
> A weakness of the page->mlock_count approach is the need for lruvec lock
> while holding page table lock.  That is not an overhead we would allow on
> normal pages, but I think acceptable just for pages in an mlocked area.
> But let's try to amortize the extra cost by gathering on per-cpu pagevec
> before acquiring the lruvec lock.
> 
> I have an unverified conjecture that the mlock pagevec might work out
> well for delaying the mlock processing of new file pages until they have
> got off lru_cache_add()'s pagevec and on to LRU.
> 
> The initialization of page->mlock_count is subject to races and awkward:
> 0 or !!PageMlocked or 1?  Was it wrong even in the implementation before
> this commit, which just widens the window?  I haven't gone back to think
> it through.  Maybe someone can point out a better way to initialize it.

Not me, it seems.

> Bringing lru_cache_add_inactive_or_unevictable()'s mlock initialization
> into mm/mlock.c has helped: mlock_new_page(), using the mlock pagevec,
> rather than lru_cache_add()'s pagevec.
> 
> Experimented with various orderings: the right thing seems to be for
> mlock_page() and mlock_new_page() to TestSetPageMlocked before adding to
> pagevec, but munlock_page() to leave TestClearPageMlocked to the later
> pagevec processing.
> 
> Dropped the VM_BUG_ON_PAGE(PageTail)s this time around: they have made
> their point, and the thp_nr_page()s already contain a VM_BUG_ON_PGFLAGS()
> for that.
> 
> This still leaves acquiring lruvec locks under page table lock each time
> the pagevec fills (or a THP is added): which I suppose is rather silly,
> since they sit on pagevec waiting to be processed long after page table
> lock has been dropped; but I'm disinclined to uglify the calling sequence
> until some load shows an actual problem with it (nothing wrong with
> taking lruvec lock under page table lock, just "nicer" to do it less).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
