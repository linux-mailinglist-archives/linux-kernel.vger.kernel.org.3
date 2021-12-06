Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8F4694ED
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbhLFLZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:25:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46972 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbhLFLZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:25:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4C0241FD2F;
        Mon,  6 Dec 2021 11:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638789734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BvSYSxqUyZM85qnxArSkYzCiwgcfqqandoTmRwSovz4=;
        b=A2QfZhy10vPgG8CEtuO5bsHCjPGIC7vvrr9Wh85wQqhLYsFM4GFmnpfg1QWqwivQJBzKdI
        2Y2gpr/PHJoWqrjdVHd7nCQB+d7Ok8yzTh+Qg4fol6bqi1BvViW7v+GTVS1MRa48sftdjn
        mHyXwTGnzPO5InNy41a9DyOdlE3cRNM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AEA4DA3B83;
        Mon,  6 Dec 2021 11:22:13 +0000 (UTC)
Date:   Mon, 6 Dec 2021 12:22:13 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <Ya3yZWkj2wGRWDMz@dhcp22.suse.cz>
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com>
 <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <Ya3r3C/OpnK7OBPt@dhcp22.suse.cz>
 <840cb3d0-61fe-b6cb-9918-69146ba06cf7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <840cb3d0-61fe-b6cb-9918-69146ba06cf7@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-12-21 12:00:50, David Hildenbrand wrote:
> On 06.12.21 11:54, Michal Hocko wrote:
> > On Mon 06-12-21 11:45:54, David Hildenbrand wrote:
> >>> This doesn't seen complete. Slab shrinkers are used in the reclaim
> >>> context. Previously offline nodes could be onlined later and this would
> >>> lead to NULL ptr because there is no hook to allocate new shrinker
> >>> infos. This would be also really impractical because this would have to
> >>> update all existing memcgs...
> >>
> >> Instead of going through the trouble of updating...
> >>
> >> ...  maybe just keep for_each_node() and check if the target node is
> >> offline. If it's offline, just allocate from the first online node.
> >> After all, we're not using __GFP_THISNODE, so there are no guarantees
> >> either way ...
> > 
> > This looks like another way to paper over a deeper underlying problem
> > IMHO. Fundamentally we have a problem that some pgdata are not allocated
> > and that causes a lot of headache. Not to mention that node_online
> > is just adding to a confusion because it doesn't really tell anything
> > about the logical state of the node.
> > 
> > I think we really should get rid of this approach rather than play a
> > whack-a-mole. We should really drop all notion of node_online and
> > instead allocate pgdat for each possible node. Arch specific code should
> > make sure that zone lists are properly initialized.
> > 
> 
> I'm not sure if it's rally whack-a-mole really applies. It's just the
> for_each_node_* calls that need love. In other cases, we shouldn't
> really stumble over an offline node.
> 
> Someone deliberately decided to use "for_each_node()" instead of
> for_each_online_node() without taking care of online vs. offline
> semantics. That's just a BUG and needs fixing IMHO.

Well, I would argue this is too much to ask for the API users. It is
also a trap that is just too easy to fall into. Turning for_each_node
into for_each_online_node will not solve the problem just by itself.
As you have pointed out an offline node can become online and without a
hotplug notifier there is no way for_each_online_node would be a proper
fit for anything that allocates memory only for online nodes. See the
trap? People think they are doing the right thing but they are not in
fact.

Now practically speaking !node_online should not apear node_online (note
I am attentionally avoiding to say offline and online as that has a
completely different semantic) shouldn't really happen for some
architectures. x86 should allocate pgdat for each possible node. I do
not know what was the architecture in this case but we already have
another report for x86 that remains unexplained.

My existing experience tells me that we have two major problems in this
area. Arch inconsistent behavior and really confusing APIs. We should be
addressing those rather than adding more hacks.

> After all, we do need patches to backport, reworking pgdat init isn't
> really something feasible for that I think. And I heard of PPC that can
> hotplug thousands of nodes ...

If this turns out to be a big problem them we can think of putting pgdat
on diet.
-- 
Michal Hocko
SUSE Labs
