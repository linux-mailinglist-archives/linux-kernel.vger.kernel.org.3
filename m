Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1160F4AFED6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiBIVB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:01:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiBIVB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:01:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A93C035440
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 13:01:28 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E99B01F391;
        Wed,  9 Feb 2022 21:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644440486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q81KcrINMylJ5+uqns4dLh+8xUMp5QZhdKl6MCEbW1k=;
        b=dL/717QMasiax5WptP9WIZqCthi3hg7YFDjvRxMgPhkMMq49Ib72b2hF5RalmEYbo1+uNa
        C3CW4D6/qwm/vZOnCBfft2n3GNXbf5JLSyYV9fpwk2vCAz9lLo+2Qfx8+QN/HzFeFjhktY
        +ePf7Jnz/1cUmTbfpv/8NKk5eazJnCk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9B9BBA3B84;
        Wed,  9 Feb 2022 21:01:26 +0000 (UTC)
Date:   Wed, 9 Feb 2022 22:01:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
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
Subject: Re: [PATCH 00/13] mm/munlock: rework of mlock+munlock page handling
Message-ID: <YgQrpMpYiGZXqdbp@dhcp22.suse.cz>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
 <YgPfX+/f0ksBpx6G@dhcp22.suse.cz>
 <147388c6-eb7-5c58-79a-7a8279c27fd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147388c6-eb7-5c58-79a-7a8279c27fd@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-02-22 08:21:17, Hugh Dickins wrote:
> On Wed, 9 Feb 2022, Michal Hocko wrote:
[...]
> > The only thing that is not entirely clear to me at the moment is why you
> > have chosen to ignore already mapped LOCKONFAULT pages. They will
> > eventually get sorted out during the reclaim/migration but this can
> > backfire if too many pages have been pre-faulted before LOCKONFAULT
> > call. Maybe not an interesting case in the first place but I am still
> > wondering why you have chosen that way.
> 
> I'm puzzled: what makes you think I'm ignoring already mapped LOCKONFAULT
> pages?  I'd consider that a bug.

I've had the following path in mind
__mm_populate
  populate_vma_page_range
    if (vma->vm_flags & VM_LOCKONFAULT)
    	return nr_page

which means that __get_user_pages is not called at all. This also means
that follow_page_mask is skipped. The page table walk used to mark
already mapped pages as mlocked so unless I miss some other path it
would stay on its original LRU list and only get real mlock protection
when encountered by the reclaim or migration.
 
> It is the case, isn't it, that a VM_LOCKONFAULT area always has VM_LOCKED
> set too?  If I've got that wrong, yes, I'll need to revisit conditions.

Yes, I did't really mean we would lose the mlock protection. We would
just do the lazy mlock also on pages which are already mapped. This is
certainly not a correctness issue - althoug stats might be off - but it
could polute existing LRUs with mlocked pages rather easily.

As I've said. Either I am still missing something or this might even not
be a big deal in real life. I was mostly curious about the choice to
exclude the page table walk for LOCKONFAULT.
-- 
Michal Hocko
SUSE Labs
