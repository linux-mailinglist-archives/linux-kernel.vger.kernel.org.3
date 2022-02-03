Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2A34A8084
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349558AbiBCIjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:39:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55508 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349220AbiBCIje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:39:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 40C4A1F3A5;
        Thu,  3 Feb 2022 08:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643877573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1IR6teMxtrUP9W66+J3byF21I9uPu8QtHmbbzm958a8=;
        b=eKuXArW/GmZea5Yf/lm7ZO4buRrMFTKqSZUKteMtfW1jfQr3GIbsOkTft8e+93oqR5oPoL
        /QLQuV81wxAu38gatOX1BJaJGpdFjcFTjQP2hW0YSHeq4yXi9Kt8f6qIb+Q+NdlU5LjRZT
        1n4IX/k5uCHCRLniHIB6cn6YqMnhJYU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 06FEDA3B83;
        Thu,  3 Feb 2022 08:39:32 +0000 (UTC)
Date:   Thu, 3 Feb 2022 09:39:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
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
Message-ID: <YfuUxI3k27msAORC@dhcp22.suse.cz>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-3-mhocko@kernel.org>
 <YfKgE5hTgbaBeaMa@kernel.org>
 <YfKwjAlPW2kJUv5w@dhcp22.suse.cz>
 <20220201024119.2ailcw4rp5thambz@master>
 <YfkDXYhGjAvAKKeU@dhcp22.suse.cz>
 <20220203002116.akpk5um5nkpeflve@master>
 <YfuC6IaasxcnAdGl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfuC6IaasxcnAdGl@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-02-22 09:23:20, Mike Rapoport wrote:
> On Thu, Feb 03, 2022 at 12:21:16AM +0000, Wei Yang wrote:
> > On Tue, Feb 01, 2022 at 10:54:37AM +0100, Michal Hocko wrote:
> > >On Tue 01-02-22 02:41:19, Wei Yang wrote:
> > >> On Thu, Jan 27, 2022 at 03:47:40PM +0100, Michal Hocko wrote:
> > >> [...]
> > >> >> > +			/*
> > >> >> > +			 * not marking this node online because we do not want to
> > >> >> > +			 * confuse userspace by sysfs files/directories for node
> > >> >> > +			 * without any memory attached to it (see topology_init)
> > >> >> > +			 * The pgdat will get fully initialized when a memory is
> > >> >> > +			 * hotpluged into it by hotadd_init_pgdat
> > >> >> > +			 */
> > >> 
> > >> Hmm... which following step would mark the node online? On x86, the node is
> > >> onlined in alloc_node_date(). This is not onlined here.
> > >
> > >The comment tries to explain that this happens during the memory
> > >hotplug. Or maybe I have missed your question?
> > >
> > 
> > I am not sure for others, while the comment confused me a little.
> > 
> > Currently in kernel, there are two situations for node online:
> > 
> >   * during memory hotplug
> >   * during sys-init
> > 
> > For memory hotplug, we allocate pgdat and online node. And current hot-add
> > process has already put them in two steps:
> > 
> >   1. __try_online_node()
> >   2. node_set_online()
> > 
> > So emphasize "not online" node here, confuse me a little. It is a natural
> > thing to not online node until it has memory.
> > 
> > But from another point of view, the comment here is reasonable. During
> > sys-init, we online node at the same time when creating pgdat. And even for
> > memory-less node on x86, we online them too.
> > 
> > Well, this is all about the comment. I have tried to grab may head but not
> > come up with a better idea.
> > 
> > Or maybe this is just my personal feeling, don't bother if no-one else feel
> > like this.
> 
> I shuffled the words a bit, maybe this sounds better not only to me :)
> 
> /*
>  * We do not want to confuse userspace by sysfs files/directories for node
>  * without any memory attached to it, so this node is not marked as
>  * N_MEMORY and not marked online so that topology_init() won't create
>  * sysfs hierarchy for this node.  The pgdat will get fully initialized by
>  * hotadd_init_pgdat() when memory is hotpluged into this node
>  */

Yes, I like this comment more than mine. Andrew could you replace it in
your tree or should I repost the patch?

Thanks!
-- 
Michal Hocko
SUSE Labs
