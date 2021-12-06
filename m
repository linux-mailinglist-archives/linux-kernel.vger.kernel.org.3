Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A3146946D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241908AbhLFK5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:57:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36660 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241901AbhLFK5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:57:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 08A321FD2F;
        Mon,  6 Dec 2021 10:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638788061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mTQenVZXC28Q/8X+IA/oYr0s+T8NO0f7tYXy3OEAYQ8=;
        b=D6hRDIizYMifchoBG00olyl4bg53Kcylp+0v9wzftJtiI9LmFxP/P8557aHXn8mLVSUsGV
        aM6CpNVl3EQfU9hBmjDq7hKrk1JpJaxJoz7OSPReC++v1a9eudwFn1JD8EIbZHXSMsXsu5
        RvjKb6T68164o2/Sg/jSzETNqL3psRE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B692CA3B8E;
        Mon,  6 Dec 2021 10:54:20 +0000 (UTC)
Date:   Mon, 6 Dec 2021 11:54:20 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <Ya3r3C/OpnK7OBPt@dhcp22.suse.cz>
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com>
 <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-12-21 11:45:54, David Hildenbrand wrote:
> > This doesn't seen complete. Slab shrinkers are used in the reclaim
> > context. Previously offline nodes could be onlined later and this would
> > lead to NULL ptr because there is no hook to allocate new shrinker
> > infos. This would be also really impractical because this would have to
> > update all existing memcgs...
> 
> Instead of going through the trouble of updating...
> 
> ...  maybe just keep for_each_node() and check if the target node is
> offline. If it's offline, just allocate from the first online node.
> After all, we're not using __GFP_THISNODE, so there are no guarantees
> either way ...

This looks like another way to paper over a deeper underlying problem
IMHO. Fundamentally we have a problem that some pgdata are not allocated
and that causes a lot of headache. Not to mention that node_online
is just adding to a confusion because it doesn't really tell anything
about the logical state of the node.

I think we really should get rid of this approach rather than play a
whack-a-mole. We should really drop all notion of node_online and
instead allocate pgdat for each possible node. Arch specific code should
make sure that zone lists are properly initialized.
-- 
Michal Hocko
SUSE Labs
