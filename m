Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348E148AD6B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbiAKMP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:15:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36196 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239729AbiAKMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:15:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1C3881F37D;
        Tue, 11 Jan 2022 12:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641903354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6+JAry045TLIOVRVpHkscU6H5JvReU1Ni4x9xqAc5Hs=;
        b=Q0wToMB5B4fvkvap3Tl92vK1gx4lEu7ovBe+cTlvJsvrggKAzQsPLdTpOmVhZyPSHKLbZY
        Sn0hP6aBONEgsTmox0pllqW/7tXn8g9wOGZtEfYzwXl6Fjxr3YXkZtNdDthQEc7nmAASyO
        BSPTrPIz7/d1WkwPOzm2AaUbzompPPU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4A460A3B83;
        Tue, 11 Jan 2022 12:15:53 +0000 (UTC)
Date:   Tue, 11 Jan 2022 13:15:50 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Alexey Avramov <hakavlad@inbox.lv>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 6/9] mm: multigenerational lru: aging
Message-ID: <Yd109jeRllJbjV9o@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <Ydg8AeE6JIUnC+ps@dhcp22.suse.cz>
 <YdjOazilBEkdUT7x@google.com>
 <YdxSUuDc3OC4pe+f@dhcp22.suse.cz>
 <1641900108.61dd684cb0e59@mail.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641900108.61dd684cb0e59@mail.inbox.lv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-01-22 11:21:48, Alexey Avramov wrote:
> > I do not really see any arguments why an userspace based trashing
> > detection cannot be used for those.
> 
> Firsly,
> because this is the task of the kernel, not the user space.
> Memory is managed by the kernel, not by the user space.
> The absence of such a mechanism in the kernel is a fundamental problem.
> The userspace tools are ugly hacks:
> some of them consume a lot of CPU [1],
> some of them consume a lot of memory [2],
> some of them cannot into process_mrelease() (earlyoom, nohang),
> some of them kill only the whole cgroup (systemd-oomd, oomd) [3]
> and depends on systemd and cgroup_v2 (oomd, systemd-oomd).

Thanks for those links. Read through them and my understanding is that
most of those are very specific to the tool used and nothing really
fundamental because of lack of kernel support.

> One of the biggest challenges for userspace oom-killers is to potentially
> function under intense memory pressure and are prone to getting stuck in
> memory reclaim themselves [4].

This one is more interesting and the truth is that handling the complete
OOM situation from the userspace is really tricky. Especially when with
a more complex oom decision policy. In the past we have discussed
potential ways to implement a oom kill policy be kernel modules or eBPF.
Without anybody following up on that.

But I suspect you are mixing up two things here. One of them is out
of memory situation where no memory can be reclaimed and allocated.

The other is one where the memory can be reclaimed, a progress is made,
but that leads to a trashing when the most of the time is spent on
refaulting a memory reclaimed shortly before.

The first one is addressed by the global oom killer and it tries to
be really conservative as much as possible because this is a very
disruptive operation. But the later one is more complex and a proper
handling really depends on the particular workload to be handled
properly because it is more of a QoS than an emergency action to keep
the system alive.

There are workloads which prefer a temporary trashing over its working
set during a peak memory demand rather than an OOM kill because way too
much work would be thrown away. On the other side workloads that are
latency sensitive can see even the direct reclaim as a runtime visible
problem.

I hope you can imagine there is a really large gap between those
two cases and no simple solution can be applied to the whole
range. Therefore we have PSI and refault stats exported to the userspace
so that a workload specific policy can be implemented there.

If userspace has hard time to use that data and action upon then let's
talk about specifics. For the most steady trashing situations I have
seen the userspace with mlocked memory and the code can make a forward
progress and mediate the situation.

[...]

> [1] https://github.com/facebookincubator/oomd/issues/79
> [2] https://github.com/hakavlad/nohang#memory-and-cpu-usage
> [3] https://github.com/facebookincubator/oomd/issues/125
> [4] https://lore.kernel.org/all/CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com/
> [5] https://github.com/zen-kernel/zen-kernel/issues/223
> [6] https://raw.githubusercontent.com/hakavlad/cache-tests/main/mg-LRU-v3_vs_classic-LRU/3-firefox-tail-OOM/mg-LRU-1/psi2
> [7] https://lore.kernel.org/linux-mm/20211202150614.22440-1-mgorman@techsingularity.net/
-- 
Michal Hocko
SUSE Labs
