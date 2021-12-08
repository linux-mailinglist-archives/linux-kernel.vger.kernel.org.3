Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F6646CE9B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244616AbhLHIDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:03:11 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38516 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhLHIDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:03:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 26B9B1FDFC;
        Wed,  8 Dec 2021 07:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638950378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=48Rmgdh/aeAtsanBrawwYZfZRr9DwkoH/yH3qaoMmkI=;
        b=Tyh+69oV8hdda4F1kMnTxmejqry4J4lLOrfa7pgzt7icNN+jxmb3RfAG2nAI8TPz1v1yAx
        qPX0MViXBTInaXiLTEspteBJn3Cl0q+s5nsR22fwlwAQTZEwbA6jzS4bexsrcqBYbUQs7h
        LKlak2Ho6hLjQ0WX1mc1vbQ5oS4TkNA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E6AFDA3B81;
        Wed,  8 Dec 2021 07:59:37 +0000 (UTC)
Date:   Wed, 8 Dec 2021 08:59:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Nico Pache <npache@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <YbBl6O8wzgVQb6Oi@dhcp22.suse.cz>
References: <20211207224013.880775-1-npache@redhat.com>
 <20211207224013.880775-2-npache@redhat.com>
 <20211207154438.c1e49a3f0b5ebc9245aac61b@linux-foundation.org>
 <CAHbLzkoCds-WOoN5CKas4DThk8hU65pgtMcga10QEqEmKU2f5A@mail.gmail.com>
 <17a7d9e4-5ebc-1160-1e5e-97707b6e5286@redhat.com>
 <CAHbLzkokNjJOb2fknm2+5pgf1+PBHviZA73nug5+dCB=7NKF4w@mail.gmail.com>
 <CAHbLzkpG4aogZRW5ct9zKDU+5C8jwtWyRAkaia1x3+goR-wGMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpG4aogZRW5ct9zKDU+5C8jwtWyRAkaia1x3+goR-wGMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-12-21 17:26:32, Yang Shi wrote:
> On Tue, Dec 7, 2021 at 5:23 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Tue, Dec 7, 2021 at 4:33 PM Nico Pache <npache@redhat.com> wrote:
> > >
> > >
> > >
> > > On 12/7/21 19:26, Yang Shi wrote:
[...]
> > > > AFAICT, we have not reached agreement on how to fix it yet. I saw 3
> > > > proposals at least:
> > > >
> > > > 1. From Michal, allocate node data for all possible nodes.
> > > > https://lore.kernel.org/all/Ya89aqij6nMwJrIZ@dhcp22.suse.cz/T/#u
> > > >
> > > > 2. What this patch does. Proposed originally from
> > > > https://lore.kernel.org/all/20211108202325.20304-1-amakhalov@vmware.com/T/#u
> > >
> > > Correct me if im wrong, but isn't that a different caller? This patch fixes the
> > > issue in expand_one_shrinker_info.
> >
> > Yes, different caller, but same approach. The cons with this approach
> 
> And the same underlying problem.
> 
> > is we have to fix all the places. It seems Michal and David are not
> > fans for this approach IIRC.

Yes, agreed. We definitely do not want to spread this node_offline
oddity all over the place. There are two different way to approach this.
Either we handle node_offline nodes at the page allocator level when
setting the proper zonelist (ideally protect that by a static key for
setups which have these nodes) or we allocate pgdat for all possible
nodes. I would prefer the second because that is more robust (less
likely to blow up when somebody does
	for_each_node(nid)
		something(NODE_DATA(nid))

The discussion is ongoing at the original thread where Alexey Makhalov
reported a similar problem (the subthread is
http://lkml.kernel.org/r/Ya89aqij6nMwJrIZ@dhcp22.suse.cz)
-- 
Michal Hocko
SUSE Labs
