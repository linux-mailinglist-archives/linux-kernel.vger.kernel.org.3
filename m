Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF1D4A7FB1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349344AbiBCHXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:23:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55538 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242617AbiBCHXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:23:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A44EFB83355
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 07:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066B8C340E4;
        Thu,  3 Feb 2022 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643873010;
        bh=V7K25jTCXoH0BgptRaT8871n6m7moa8rRIaz4V09veo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKw9Genp3FGTt2PlwobnsNfAJd3NNgCpYX/1le+66knL+/J7tFRofkqmYKxCTbPue
         xoyVEhRy1VHb1WtymQt8gT0tEDoIfs+LKL2sVVGXq+7Djfb3tv8SInfjnSA/CA/FyM
         gQnK2aICmjWgOvqXelPpZ48MCIs9E6DdXhqOIvZCd7rVTV1EdMkd8U0mUljIL4LWG5
         2sO8+4/DNxYVkCMdvBkupaP9AEKUmENro33UH7/tMX0Jr0ps11dYV7B6fmQFp7Io24
         PsuZI0LhDwrVjKF63sNhXxsfxDLOUdl0soaydxG2WMrGpHlJ8XmYI6sK4ck8+WOQYD
         44qVAfI2Fufuw==
Date:   Thu, 3 Feb 2022 09:23:20 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
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
Message-ID: <YfuC6IaasxcnAdGl@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-3-mhocko@kernel.org>
 <YfKgE5hTgbaBeaMa@kernel.org>
 <YfKwjAlPW2kJUv5w@dhcp22.suse.cz>
 <20220201024119.2ailcw4rp5thambz@master>
 <YfkDXYhGjAvAKKeU@dhcp22.suse.cz>
 <20220203002116.akpk5um5nkpeflve@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203002116.akpk5um5nkpeflve@master>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 12:21:16AM +0000, Wei Yang wrote:
> On Tue, Feb 01, 2022 at 10:54:37AM +0100, Michal Hocko wrote:
> >On Tue 01-02-22 02:41:19, Wei Yang wrote:
> >> On Thu, Jan 27, 2022 at 03:47:40PM +0100, Michal Hocko wrote:
> >> [...]
> >> >> > +			/*
> >> >> > +			 * not marking this node online because we do not want to
> >> >> > +			 * confuse userspace by sysfs files/directories for node
> >> >> > +			 * without any memory attached to it (see topology_init)
> >> >> > +			 * The pgdat will get fully initialized when a memory is
> >> >> > +			 * hotpluged into it by hotadd_init_pgdat
> >> >> > +			 */
> >> 
> >> Hmm... which following step would mark the node online? On x86, the node is
> >> onlined in alloc_node_date(). This is not onlined here.
> >
> >The comment tries to explain that this happens during the memory
> >hotplug. Or maybe I have missed your question?
> >
> 
> I am not sure for others, while the comment confused me a little.
> 
> Currently in kernel, there are two situations for node online:
> 
>   * during memory hotplug
>   * during sys-init
> 
> For memory hotplug, we allocate pgdat and online node. And current hot-add
> process has already put them in two steps:
> 
>   1. __try_online_node()
>   2. node_set_online()
> 
> So emphasize "not online" node here, confuse me a little. It is a natural
> thing to not online node until it has memory.
> 
> But from another point of view, the comment here is reasonable. During
> sys-init, we online node at the same time when creating pgdat. And even for
> memory-less node on x86, we online them too.
> 
> Well, this is all about the comment. I have tried to grab may head but not
> come up with a better idea.
> 
> Or maybe this is just my personal feeling, don't bother if no-one else feel
> like this.

I shuffled the words a bit, maybe this sounds better not only to me :)

/*
 * We do not want to confuse userspace by sysfs files/directories for node
 * without any memory attached to it, so this node is not marked as
 * N_MEMORY and not marked online so that topology_init() won't create
 * sysfs hierarchy for this node.  The pgdat will get fully initialized by
 * hotadd_init_pgdat() when memory is hotpluged into this node
 */

-- 
Sincerely yours,
Mike.
