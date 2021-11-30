Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3B24629B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 02:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbhK3BdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 20:33:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:43350 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236277AbhK3BdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 20:33:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="235940662"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="235940662"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 17:29:56 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="459396575"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.50])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 17:29:53 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Hasan Al Maruf <hasan3050@gmail.com>
Cc:     dave.hansen@linux.intel.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, riel@surriel.com,
        yang.shi@linux.alibaba.com
Subject: Re: [PATCH 0/5] Transparent Page Placement for Tiered-Memory
References: <874k812fl8.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <874k812fl8.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date:   Tue, 30 Nov 2021 09:29:51 +0800
In-Reply-To: <874k812fl8.fsf@yhuang6-desk2.ccr.corp.intel.com> (Hasan Al
        Maruf's message of "Mon, 29 Nov 2021 19:28:16 -0500")
Message-ID: <87ee6yv3ao.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hasan,

Hasan Al Maruf <hasan3050@gmail.com> writes:

> Hi Huang,
>
> We find the patches in the tiering series are well thought and helpful.
> For our workloads, we initially started with that series and we find the
> whole series is too complex and some features do not benefit as
> expected. Therefore, we have come up with the current basic patches which
> are essential and help achieve most of the intended behaviors while
> reducing complexity as much as possible.
> As we started with your tiering series (with 72 patches), there are
> overlaps between our patches and the tiering series. We adopt the
> functionalities from the tiering series, modify, and extend them to make
> page placement mechanism simpler but workable.

Thanks for the background!

> Here is the key points for
> each of the patches in our Transparent Page Placement series.
>
> Patch #1:
> We combine all the promotion and demotion related statistics in this patch
> Having statistics on both promotion, demotion, and failures help observe
> the systems behavior and reason about performance behavior. Besides, anon
> vs file breakdown in both promotion and demotion path help understand
> application behavior on a tiered memory systems. As applications may have
> different sensitivity toward the anon and file placements, this breakdown
> in the migration path is often helpful to assess the effectiveness of the
> page placement policy.
>
> Patch #2:
> This patch largely overlaps with your current series on NUMA Balancing.
> https://lore.kernel.org/lkml/20211116013522.140575-1-ying.huang@intel.com/
> This patch is a combination of your Patch #2 and Patch #3 except the
> static 10MB free space in the top-tier node to maintain a free headroom
> for new allocation and promotion. Rather, we find having a user defined
> demote watermark would make it more generic that we include in our patch#3
>
> Patch #3:
> This patch has the logic for having a separate demote watermark per node.
> In the tiering series, that demote watermark is somewhat bound to the
> cgroup and triggered on per-application basis. Besides, It only supports
> cgroup-v1. However, we think, instead of cgroup based soft reclamation,
> a global per-node demote watermark is more meaningful and should be the
> basic one to start with. In that case, the user does not have to think
> about per-application setup.
>
> Patch #4:
> This patch includes the code for kswapd based reclamation. As I mentioned
> earlier, instead of cgroup-based reclamation, here we look whether a node
> is balanced during each kswapd invocation. For top-tier node, we check
> whether kswapd reclaimed till DEMOTE_WMARK is satisfied, for other nodes
> the default mechanism continues. The differences between tiering series
> and this patch is the cgroup based reclamation vs per-node reclamation.
>
> Patch #5:
> In your patches for promotion, you consider re-fault time for promotion
> candidate selection. Although the hot-threshold is tunable, from our
> experiments, we find this not helpful to some extent. For example, if
> different subset of pages have different re-access time, time-based
> promotion should not be able to distinguish between them. If you make
> the time window long enough, then any infrequently accessed pages will
> also become the promotion candidate, and later be a candidate for the
> demotion.
>
> In this patch, we propose LRU based promotion, which would give anon and
> files different promotion paths. If pages are used sporadically at high
> frequency, irregular pages would be eventually moved from the active LRU
> list. We find that our LRU based approach can reduce up to 11x promotion
> traffic while retaining the same application throughput for multiple
> workloads.
>
> Besides, with promotion rate limit, if files largely get promoted to
> top-tier, anon promotion rate often gets hampered as files are taking the
> large portion of the total rate (which often happen for applications that
> generates huge caches). In our LRU-based approach, each type has their own
> separate LRU to check. So for workloads with smaller anons and large file
> usage, with LRU-based approach, we can see more anons are being promoted
> rather than the files.
>
> I don't mind this patchset being merged to your current patchset under
> discussion or any later ones. But, I think this series contains the very
> basic functionalities to have a workable page placement mechanism for
> tiered-memory. This can obviously be augmented by the other features in
> you future tiering series.

Thanks for detailed description!  After reading your patchset and the
description above, I found that the basic part ([1/6] - [3/6]) of the
promotion patchset as follows can be the base for your patchset too.

https://lore.kernel.org/lkml/20211116013522.140575-1-ying.huang@intel.com/

The main problem of that basic patchset is lacking review.  Can I ask
you to help to review that patchset, especially the common base [1/6] -
[3/6]?  If you think the rest of the patchset isn't good enough for you,
we can try to merge just [1/6] - [3/6] firstly.  Do you agree?

Best Regards,
Huang, Ying
