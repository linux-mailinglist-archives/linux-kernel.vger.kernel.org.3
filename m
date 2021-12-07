Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5987446B9A1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbhLGK6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:58:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52288 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhLGK6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:58:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5B2B921B3D;
        Tue,  7 Dec 2021 10:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638874518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1fS/vZbZh9msdrSxyTZbVy9qyqqHF1IQgs77NLVOK1g=;
        b=DcexllzdzIygPzm1O6ITBxn1OVM+v/TKIxjtMcpFIznmSgUaeV4pTJXNKnZkJ1tTMETZve
        xX061YO4S/dImpkuT/1mTniO7Q8+kHa1mZum0h/5kjY/heaFyCk+TOkFGG1k+GV5fC1wtk
        k4EDDXtg2uQraU/aB/8LV3m6IHkD2PI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2AC0EA3B83;
        Tue,  7 Dec 2021 10:55:18 +0000 (UTC)
Date:   Tue, 7 Dec 2021 11:55:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>,
        Nico Pache <npache@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <Ya89lXTMZJJJfsfo@dhcp22.suse.cz>
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com>
 <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <24b4455c-aff9-ca9f-e29f-350833e7a0d1@virtuozzo.com>
 <CAHbLzko0UeNadswXEnwr6EtuKAZT4T-fnC5F7xnFcH4RbjhAiA@mail.gmail.com>
 <a48c16d6-07df-ff44-67e6-f0942672ec28@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a48c16d6-07df-ff44-67e6-f0942672ec28@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-12-21 20:01:34, David Hildenbrand wrote:
[...]
> Yes, that's what I refer to as fixing it in the caller -- similar to
> [1]. Michals point is to not require such node_online() checks at all,
> neither in the caller nor in the buddy.
> 
> I see 2 options short-term
> 
> 1) What we have in [1].
> 2) What I proposed in [2], fixing it for all such instances until we
> have something better.
> 
> Long term I tend to agree that what Michal proposes is better.
> 
> Short term I tend to like [2], because it avoids having to mess with all
> such instances to eventually get it right and the temporary overhead
> until we have the code reworked should be really negligible ...

I do dislike both but if I were to chose which to chose between the two
then 2 is surely more targeted. We really do not want to spread this
into bulk/pcp or whatever other allocator there is. The problem is that
somebody might still try to access NODE_DATA (e.g. via a helper that
hides that fact).

Anyway, I am not sure whether authors of the patch can reproduce the
problem and whether they can run a testing code on their machine. If yes
it would be great to try with http://lkml.kernel.org/r/Ya89aqij6nMwJrIZ@dhcp22.suse.cz
that I have just sent.

> [1] https://lkml.kernel.org/r/20211108202325.20304-1-amakhalov@vmware.com
> [2]
> https://lkml.kernel.org/r/51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com
> 
> -- 
> Thanks,
> 
> David / dhildenb

-- 
Michal Hocko
SUSE Labs
