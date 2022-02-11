Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EDB4B249F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349540AbiBKLmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:42:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiBKLmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:42:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA7BE9B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:42:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EFA9221128;
        Fri, 11 Feb 2022 11:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644579730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQFbjKgXBQhPR1Tis7coIjTSRK1bvjGaqsCPLGRRs2w=;
        b=ajC8L4bjMIOFXlm633Vg06ax2yH6r+JQjoEQd38cJrC2URPQY/LL1fv1igh+7mER1s5Xa8
        a6Qx1kGcPad31jSeUapRmGo5Z0Op9ZnjubZ/tz07gnmSxQZmZyD7MBcTPadTEkfdaCF0lU
        RObcoBY54sstDi4i8iovXUPfcjAhfAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644579730;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQFbjKgXBQhPR1Tis7coIjTSRK1bvjGaqsCPLGRRs2w=;
        b=pp55ioSBqvxbC9xkV/TpcKn6H7qtt01rU1bsZiLcWq+5deuq7VEjei0hABqJgfdSVbAuGJ
        B11kefL2UMPzuNDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C04FF13C03;
        Fri, 11 Feb 2022 11:42:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MC0+LpJLBmJ2VgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 11 Feb 2022 11:42:10 +0000
Message-ID: <e7fbbdca-6590-7e45-3efd-279fba7f8376@suse.cz>
Date:   Fri, 11 Feb 2022 12:42:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 05/13] mm/munlock: replace clear_page_mlock() by final
 clearance
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
 <652a918-8a11-c1e9-a760-854873841bc@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <652a918-8a11-c1e9-a760-854873841bc@google.com>
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

On 2/6/22 22:38, Hugh Dickins wrote:
> Placing munlock_vma_page() at the end of page_remove_rmap() shifts most
> of the munlocking to clear_page_mlock(), since PageMlocked is typically
> still set when mapcount has fallen to 0.  That is not what we want: we
> want /proc/vmstat's unevictable_pgs_cleared to remain as a useful check
> on the integrity of of the mlock/munlock protocol - small numbers are
> not surprising, but big numbers mean the protocol is not working.
> 
> That could be easily fixed by placing munlock_vma_page() at the start of
> page_remove_rmap(); but later in the series we shall want to batch the
> munlocking, and that too would tend to leave PageMlocked still set at
> the point when it is checked.
> 
> So delete clear_page_mlock() now: leave it instead to release_pages()
> (and __page_cache_release()) to do this backstop clearing of Mlocked,
> when page refcount has fallen to 0.  If a pinned page occasionally gets
> counted as Mlocked and Unevictable until it is unpinned, that's okay.
> 
> A slightly regrettable side-effect of this change is that, since
> release_pages() and __page_cache_release() may be called at interrupt
> time, those places which update NR_MLOCK with interrupts enabled
> had better use mod_zone_page_state() than __mod_zone_page_state()
> (but holding the lruvec lock always has interrupts disabled).
> 
> This change, forcing Mlocked off when refcount 0 instead of earlier
> when mapcount 0, is not fundamental: it can be reversed if performance
> or something else is found to suffer; but this is the easiest way to
> separate the stats - let's not complicate that without good reason.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
