Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DC1469649
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243825AbhLFNKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:10:01 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55004 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242225AbhLFNKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:10:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 010FF212C5;
        Mon,  6 Dec 2021 13:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638795991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9K7RftGjQ4l6lY7PF5hHrou9HVqN2l0LIhFrO5xCxwU=;
        b=cFv0qpNtVh2cPCHRk4PnwSEC5n8ocHd7vzCeqS0VGoOgyU+Kzhl7X7pjg+vdqRFIq8MLiV
        qzb7gpJ1oyvWMjwSwYI79OSpsA7iwkRdAFmt4Y0OcaE66+ihENUM2t0dhLrXkdJLFFxNT/
        mYFJtO13EQiel8pCaDRHhQ34aBtDkZg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B2487A3B8F;
        Mon,  6 Dec 2021 13:06:30 +0000 (UTC)
Date:   Mon, 6 Dec 2021 14:06:27 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <Ya4K0+XCmv3NBmwQ@dhcp22.suse.cz>
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com>
 <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <Ya3r3C/OpnK7OBPt@dhcp22.suse.cz>
 <840cb3d0-61fe-b6cb-9918-69146ba06cf7@redhat.com>
 <Ya3yZWkj2wGRWDMz@dhcp22.suse.cz>
 <51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-12-21 13:43:27, David Hildenbrand wrote:
[...]
> > Now practically speaking !node_online should not apear node_online (note
> > I am attentionally avoiding to say offline and online as that has a
> > completely different semantic) shouldn't really happen for some
> > architectures. x86 should allocate pgdat for each possible node. I do
> > not know what was the architecture in this case but we already have
> > another report for x86 that remains unexplained.
> 
> So we'd allocate the pgdat although all we want is just a zonelist. The
> obvious alternative is to implement the fallback where reasonable -- for
> example, in the page allocator. It knows the fallback order:
> build_zonelists(). That's pretty much all we need the preferred_nid for.
> 
> So just making prepare_alloc_pages()/node_zonelist() deal with a missing
> pgdat could make sense as well. Something like:
> 
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index b976c4177299..2d2649e78766 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -508,9 +508,14 @@ static inline int gfp_zonelist(gfp_t flags)
>   *
>   * For the case of non-NUMA systems the NODE_DATA() gets optimized to
>   * &contig_page_data at compile-time.
> + *
> + * If the node does not have a pgdat yet, returns the zonelist of the
> + * first online node.
>   */
>  static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
>  {
> +       if (unlikely(!NODE_DATA(nid)))
> +               nid = first_online_node;
>         return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
>  }

This is certainly possible. But it a) adds a branch to the hotpath and
b) it doesn't solve any other potential dereference of garbage node.
 
> But of course, there might be value in a proper node-aware fallback list
> as we have in build_zonelists() -- but it remains questionable if the
> difference for these corner cases would be relevant in practice.

Only the platform knows the proper node topology and that includes
memory less nodes. So they should be setting up a node properly and we
shouldn't be dealing with this at the allocator nor any other code.

> Further, if we could have thousands of nodes, we'd have to update each
> and every one when building zone lists ...

Why would that be a practical problem?

> Removing the hotadd_new_pgdat() stuff does sound appealing, though.

Yes our hotplug code could be simplified as well. All we really need is
an arch code to initialize all the possible nodes.
-- 
Michal Hocko
SUSE Labs
