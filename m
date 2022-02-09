Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCFB4AF572
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiBIPgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbiBIPf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:35:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6F1C0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:36:01 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9F84821106;
        Wed,  9 Feb 2022 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644420960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fiB/RLA6+TRPqiQcsJO/7jhpKwwOHhChnXu8OxtZJF8=;
        b=Eg39W1KhWOahMF4A1WT7hIsLEiwE3gTmUaPCXZ5KqFrqA9wLmpSk/tyKevPPhJi2l7t7Qh
        PApTRciEYxRKIqeSk0m4ZA4Hz1NNH+G0Ai83QbG1P/lrvUVagPrRvO5glCYzsj321l89f4
        oSh5zJHH4LC/yD0pNAPM2pZ5wNsF8mQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 430AEA3B84;
        Wed,  9 Feb 2022 15:36:00 +0000 (UTC)
Date:   Wed, 9 Feb 2022 16:35:59 +0100
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
Message-ID: <YgPfX+/f0ksBpx6G@dhcp22.suse.cz>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 06-02-22 13:27:41, Hugh Dickins wrote:
> I wondered whether to post this munlocking rework in
> https://lore.kernel.org/linux-mm/35c340a6-96f-28a0-2b7b-2f9fbddc01f@google.com/
> 
> There the discussion was OOM reaping, but the main reason for the rework
> has been catastrophic contention on i_mmap_rwsem when exiting from
> multiply mlocked files; and frustration with how contorted munlocking is.

yeah, I do not think that too many care about oom_reaper stumbling over
vast portions of the mlocked memory problem. So far I have seen only LTP
oom02 hitting this and that one does mlockall and intentionally hits
OOM. So far I haven't seen any actual workload hiting something similar.
But hey, if we get a better and easier to maintain mlock code then the
oom_reaper will surely add to a huge thanks.

> Here it is based on 5.17-rc2, applies also to -rc3, almost cleanly to
> mmotm 2022-02-03-21-58 (needs two easy fixups in mm/huge_memory.c); but
> likely to conflict (I hope not fundamentally) with several concurrent
> large patchsets.
> 
> tl;dr
>  mm/mlock.c  |  634 +++++++++++++++-----------------------
>  23 files changed, 510 insertions(+), 779 deletions(-)

This is really impressive!

> In my own opinion, this is ready to go in: that whatever its defects,
> it's a big practical improvement over what's presently there.  Others
> may differ; and it may be too much to arrive at a quick opinion on.
> My hope is that it will strike a chord with some who have laboured in
> this area in the past: I'll be short of time to do much more with it,
> so maybe someone else could take over if necessary.
> 
> At present there's no update to Documentation/vm/unevictable-lru.rst:
> that always needs a different mindset, can follow later, please refer
> to commit messages for now.

Yes, that would help for sure.

So far I have only managed to read through the series and trying to put
all the pieces together (so far I have given up on the THP part) and my
undestanding is far from complete. But I have to say I like the general
approach and overall simplification.

The only thing that is not entirely clear to me at the moment is why you
have chosen to ignore already mapped LOCKONFAULT pages. They will
eventually get sorted out during the reclaim/migration but this can
backfire if too many pages have been pre-faulted before LOCKONFAULT
call. Maybe not an interesting case in the first place but I am still
wondering why you have chosen that way.

I will be off next couple of days and plan to revisit this afterwards
(should time allow). Anyway thanks a lot Hugh!
-- 
Michal Hocko
SUSE Labs
