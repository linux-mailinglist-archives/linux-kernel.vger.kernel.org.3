Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D1749E4FF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242663AbiA0Orr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:47:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37714 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiA0Orl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:47:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B12DB218DF;
        Thu, 27 Jan 2022 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643294860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rSZXlPUAg0bB3OUoojAw9hk6oWvh6DbdoWJhKR5STeg=;
        b=pRdcL1MnuYNVCZWQs+757C++tyO0P0QrDz+ONlfGicyCU2R2lMWDr4+4aV1xAZ6YXfSNfg
        FnKA78GE/ESll7AwJ4/dQeSRO5Unho1sqjtnXi4axdW3y3dO/qDROx6DNEh4CmiIyFmmwm
        2fzeaKHI8Q5CynvsA7enp6x4HQSc28U=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7F612A3B84;
        Thu, 27 Jan 2022 14:47:40 +0000 (UTC)
Date:   Thu, 27 Jan 2022 15:47:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <YfKwjAlPW2kJUv5w@dhcp22.suse.cz>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-3-mhocko@kernel.org>
 <YfKgE5hTgbaBeaMa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfKgE5hTgbaBeaMa@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-01-22 15:37:23, Mike Rapoport wrote:
> On Thu, Jan 27, 2022 at 09:53:01AM +0100, Michal Hocko wrote:
[...]
> > +		if (!node_online(nid)) {
> > +			pr_warn("Node %d uninitialized by the platform. Please report with boot dmesg.\n", nid);
> 
> Do we assume that platform code must allocate node data for all nodes in
> the system? Because if we don't this warning is misleading.

At least x86 does that (init_cpu_to_node). Now that you brought that up
I guess you are right that this could be more misleading than helpful.
What about
			pr_info("Initializing node %d as memoryless\n", nid);
Is this better?

> > +
> > +			/* Allocator not initialized yet */
> > +			pgdat = arch_alloc_nodedata(nid);
> > +			if (!pgdat) {
> > +				pr_err("Cannot allocate %zuB for node %d.\n",
> > +						sizeof(*pgdat), nid);
> > +				continue;
> > +			}
> > +			arch_refresh_nodedata(nid, pgdat);
> > +			free_area_init_memoryless_node(nid);
> > +			/*
> > +			 * not marking this node online because we do not want to
> > +			 * confuse userspace by sysfs files/directories for node
> > +			 * without any memory attached to it (see topology_init)
> > +			 * The pgdat will get fully initialized when a memory is
> > +			 * hotpluged into it by hotadd_init_pgdat
> > +			 */
> > +			continue;
> 
> This can be made slightly more concise if we fall through after
> arch_refresh_nodedata(), e.g. something like
> 
> 			...
> 
> 			arch_refresh_nodedata(nid, pgdat);
> 		}
> 
> 		pgdat = NODE_DATA(nid);
> 		free_area_init_node(nid);
> 
> 		/*
> 		 * Do not mark memoryless node online because we do not want to
> 		 * confuse userspace by sysfs files/directories for node
> 		 * without any memory attached to it (see topology_init)
> 		 * The pgdat will get fully initialized when a memory is
> 		 * hotpluged into it by hotadd_init_pgdat
> 		 */
> 		if (!pgdat->node_present_pages)
> 			continue;
> 
> but I don't feel strongly about it.

I do not have strong preference either way. Unless this is considered
better by more people I would stick with what I have.
-- 
Michal Hocko
SUSE Labs
