Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D979F49E4EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbiA0Opd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:45:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42428 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242545AbiA0Opc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:45:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 280AC1F385;
        Thu, 27 Jan 2022 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643294731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RcGkJCsMOxm3HKvLbnVc+nUcQAOUfO3nUHEQ2pC0eLY=;
        b=sbHrglxbbiD3Rv19cqAeVKqDVBqm7Kk+OThabUA+8TJBrTrYsAZJ4ZXb+W1dCEbS0ufskg
        u4ye3envSo3ZHt9dSqcbL7cEgIEN2wsPsN7RfS+Vuv1ofQeK9V+pH6m3v2AtK9rDbPtul2
        RmsG5RoumVr/ej4tMWdJsLmPCDHGrbQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EC2A6A3B85;
        Thu, 27 Jan 2022 14:45:30 +0000 (UTC)
Date:   Thu, 27 Jan 2022 15:45:30 +0100
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
Subject: Re: [PATCH 4/6] mm, memory_hotplug: reorganize new pgdat
 initialization
Message-ID: <YfKwCqxMkN+Slz11@dhcp22.suse.cz>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-5-mhocko@kernel.org>
 <YfKgq116n7vLRIa7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfKgq116n7vLRIa7@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-01-22 15:39:55, Mike Rapoport wrote:
> On Thu, Jan 27, 2022 at 09:53:03AM +0100, Michal Hocko wrote:
[...]
> > +	pgdat->nr_zones = 0;
> > +	pgdat->kswapd_order = 0;
> > +	pgdat->kswapd_highest_zoneidx = 0;
> > +	pgdat->node_start_pfn = 0;
> > +	for_each_online_cpu(cpu) {
> > +		struct per_cpu_nodestat *p;
> > +
> > +		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> > +		memset(p, 0, sizeof(*p));
> > +	}
> 
> It seems to me that most of this is already done by free_area_init_node()
> at boot time anyway. Do I miss something?

As already replied to David I really didn't want to change the existing
logic.
-- 
Michal Hocko
SUSE Labs
