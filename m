Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56CA49E563
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbiA0PE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:04:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38924 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbiA0PE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:04:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9251BB8226E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F060EC340E4;
        Thu, 27 Jan 2022 15:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643295864;
        bh=4DDJ0R0l0lKF3t9F9nLmdfprQlVOrocx1zdesDaL97A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7X07oQ9duTQ02ktflfQEnrcwx6le8k6+d2Zaea8O/aL1Eqqc1VwveDX3f4HGbFAj
         XBUcaoZyRzH03Y5YRP0U0ujMPVnPtzrC/Ya563DyQ9I49ePH2qwn2Ue4eE1GSR0mtf
         rLHQgkrPAuAtCzFXtjMZ8RXvE2/5MDjel15nAEOy97gkitJciePEHJGFjLwcABOabb
         T06tUl47mrD5HTWGG9R2hpAadbjglBAktrZwXeDYRlWPlZDe+g+MpkLXkiFuPnSBWd
         24Nwd6iWJG55ylmkP6aZZb17cpLDABEYL9i+Bn5/ELxsfyd3Xw2nV29HQtf1Rf4J06
         MtlJqOqO+77dQ==
Date:   Thu, 27 Jan 2022 17:04:14 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>
Subject: Re: [PATCH 2/6] mm: handle uninitialized numa nodes gracefully
Message-ID: <YfK0bnylHxiMzYj+@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-3-mhocko@kernel.org>
 <YfKgE5hTgbaBeaMa@kernel.org>
 <YfKwjAlPW2kJUv5w@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfKwjAlPW2kJUv5w@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 03:47:40PM +0100, Michal Hocko wrote:
> On Thu 27-01-22 15:37:23, Mike Rapoport wrote:
> > On Thu, Jan 27, 2022 at 09:53:01AM +0100, Michal Hocko wrote:
> [...]
> > > +		if (!node_online(nid)) {
> > > +			pr_warn("Node %d uninitialized by the platform. Please report with boot dmesg.\n", nid);
> > 
> > Do we assume that platform code must allocate node data for all nodes in
> > the system? Because if we don't this warning is misleading.
> 
> At least x86 does that (init_cpu_to_node). Now that you brought that up
> I guess you are right that this could be more misleading than helpful.

I'm not sure if other architectures allocate memoryless nodes, but for sure
only x86 initializes it with free_area_init_memoryless_node().

> What about
> 			pr_info("Initializing node %d as memoryless\n", nid);
> Is this better?

I think yes.

> > > +
> > > +			/* Allocator not initialized yet */
> > > +			pgdat = arch_alloc_nodedata(nid);
> > > +			if (!pgdat) {
> > > +				pr_err("Cannot allocate %zuB for node %d.\n",
> > > +						sizeof(*pgdat), nid);
> > > +				continue;
> > > +			}
> > > +			arch_refresh_nodedata(nid, pgdat);
> > > +			free_area_init_memoryless_node(nid);
> > > +			/*
> > > +			 * not marking this node online because we do not want to
> > > +			 * confuse userspace by sysfs files/directories for node
> > > +			 * without any memory attached to it (see topology_init)
> > > +			 * The pgdat will get fully initialized when a memory is
> > > +			 * hotpluged into it by hotadd_init_pgdat
> > > +			 */
> > > +			continue;
> > 
> > This can be made slightly more concise if we fall through after
> > arch_refresh_nodedata(), e.g. something like
> > 
> > 			...
> > 
> > 			arch_refresh_nodedata(nid, pgdat);
> > 		}
> > 
> > 		pgdat = NODE_DATA(nid);
> > 		free_area_init_node(nid);
> > 
> > 		/*
> > 		 * Do not mark memoryless node online because we do not want to
> > 		 * confuse userspace by sysfs files/directories for node
> > 		 * without any memory attached to it (see topology_init)
> > 		 * The pgdat will get fully initialized when a memory is
> > 		 * hotpluged into it by hotadd_init_pgdat
> > 		 */
> > 		if (!pgdat->node_present_pages)
> > 			continue;
> > 
> > but I don't feel strongly about it.
> 
> I do not have strong preference either way. Unless this is considered
> better by more people I would stick with what I have.
> -- 
> Michal Hocko
> SUSE Labs

-- 
Sincerely yours,
Mike.
