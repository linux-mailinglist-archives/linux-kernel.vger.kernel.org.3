Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E894A5981
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiBAJyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:54:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44884 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiBAJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:54:38 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9451921116;
        Tue,  1 Feb 2022 09:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643709277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7FJI9cxvw91D3nHE/77fnkMXwVmLpQSxMXB/yC1y9jU=;
        b=OK3+ceKpCEpfce0DrAtdzfQNGqoQMXar021mgX/b8fYs23BP8g7WrRYOzVk1RP2jeWH8sg
        jbhwR8PIEfh5QlPJnTO+6wn4aTWZc9/SoCLi4Hm3pC//FjUXgWOiowUKO/4Q8ur62hGjaU
        F7IiB70yiYVIJfr8RZf17lqZXVPMDx0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7EE18A3B83;
        Tue,  1 Feb 2022 09:54:37 +0000 (UTC)
Date:   Tue, 1 Feb 2022 10:54:37 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Rafael Aquini <raquini@redhat.com>
Subject: Re: [PATCH 2/6] mm: handle uninitialized numa nodes gracefully
Message-ID: <YfkDXYhGjAvAKKeU@dhcp22.suse.cz>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-3-mhocko@kernel.org>
 <YfKgE5hTgbaBeaMa@kernel.org>
 <YfKwjAlPW2kJUv5w@dhcp22.suse.cz>
 <20220201024119.2ailcw4rp5thambz@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201024119.2ailcw4rp5thambz@master>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-02-22 02:41:19, Wei Yang wrote:
> On Thu, Jan 27, 2022 at 03:47:40PM +0100, Michal Hocko wrote:
> >[...]
> >> > +
> >> > +			/* Allocator not initialized yet */
> >> > +			pgdat = arch_alloc_nodedata(nid);
> >> > +			if (!pgdat) {
> >> > +				pr_err("Cannot allocate %zuB for node %d.\n",
> >> > +						sizeof(*pgdat), nid);
> >> > +				continue;
> >> > +			}
> >> > +			arch_refresh_nodedata(nid, pgdat);
> >> > +			free_area_init_memoryless_node(nid);
> 
> free_area_init_memoryless_node() seems to be defined used out side
> page_alloc.c? It just call free_area_init_node() directly. We want to use the
> name to reflect the effect?

yes.

> >> > +			/*
> >> > +			 * not marking this node online because we do not want to
> >> > +			 * confuse userspace by sysfs files/directories for node
> >> > +			 * without any memory attached to it (see topology_init)
> >> > +			 * The pgdat will get fully initialized when a memory is
> >> > +			 * hotpluged into it by hotadd_init_pgdat
> >> > +			 */
> 
> Hmm... which following step would mark the node online? On x86, the node is
> onlined in alloc_node_date(). This is not onlined here.

The comment tries to explain that this happens during the memory
hotplug. Or maybe I have missed your question?

[...]
-- 
Michal Hocko
SUSE Labs
