Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E048E802
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiANKBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:01:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58304 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiANKBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:01:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 885901F3D3;
        Fri, 14 Jan 2022 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642154509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FOYyJ+5PryBiIbGPc7XqpaSxwuYNJz35yFytEnydoNk=;
        b=qF0zeehEMSICTRnjesFyIhNuEP/oUM7oK0Uf9XUzXLwzMq/86nvLsDyPCYrECfoIvh1jB2
        CHEVRypkMbd9WHfIMqddhPuO7MW6KVw3lJgAB2gfKiS1Q34g9Qc/98UulX6E0tNB7XnZI1
        WkO8e0JRw4QO/Nk3m0gfnisDRAP8YDg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4F0AAA3B81;
        Fri, 14 Jan 2022 10:01:49 +0000 (UTC)
Date:   Fri, 14 Jan 2022 11:01:49 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Christoph Lameter <cl@gentwo.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Nico Pache <npache@redhat.com>
Subject: Re: [PATCH v2 2/4] mm: handle uninitialized numa nodes gracefully
Message-ID: <YeFKDfO0V5oc6/pR@dhcp22.suse.cz>
References: <YbHfBgPQMkjtuHYF@dhcp22.suse.cz>
 <20211214100732.26335-1-mhocko@kernel.org>
 <20211214100732.26335-3-mhocko@kernel.org>
 <alpine.DEB.2.22.394.2112141131180.370323@gentwo.de>
 <Ybh0NwH1grEyLoe8@dhcp22.suse.cz>
 <20220114002415.wfhhdp7ixn7kztqk@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114002415.wfhhdp7ixn7kztqk@master>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-01-22 00:24:15, Wei Yang wrote:
> On Tue, Dec 14, 2021 at 11:38:47AM +0100, Michal Hocko wrote:
> >On Tue 14-12-21 11:33:41, Christoph Lameter wrote:
> >> On Tue, 14 Dec 2021, Michal Hocko wrote:
> >> 
> >> > This patch takes a different approach (following a lead of [3]) and it
> >> > pre allocates pgdat for all possible nodes in an arch indipendent code
> >> > - free_area_init. All uninitialized nodes are treated as memoryless
> >> > nodes. node_state of the node is not changed because that would lead to
> >> > other side effects - e.g. sysfs representation of such a node and from
> >> > past discussions [4] it is known that some tools might have problems
> >> > digesting that.
> >> 
> >> Would it be possible to define a pgdat statically and place it in read
> >> only memory? Populate with values that ensure that the page allocator
> >> does not blow up but does a defined fallback.
> >> 
> >> Point the pgdat for all nodes not online to that readonly pgdat?
> >> 
> >> Maybe that would save some memory. When the node comes online then a real
> >> pgdat could be allocated.
> >
> >This is certainly possible but also it is more complex. I aim for as
> >simple as possible at this stage. The reason I am not concerned about
> >memory overhead so much (even though the pgdat is a large data
> >structure) is that these unpopulated nodes are rather rare. We might see
> >more of them in the future but we are not quite there yet so I do not
> >think this is a major obstacle for now.
> 
> Another thing is we still have a chance to get NULL NODE_DATA if we failed to
> allocate it. And this is the problem we want to address here.

System that is short on memory that early in the boot to fail this
allocation is very likely not going to finish the boot. I do not think
we can make any reasonable allocation failure handling here.

-- 
Michal Hocko
SUSE Labs
