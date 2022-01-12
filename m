Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9683348C77D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354762AbiALPp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:45:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45270 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbiALPpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:45:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22279B81F71;
        Wed, 12 Jan 2022 15:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC018C36AEB;
        Wed, 12 Jan 2022 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642002352;
        bh=qvNUE+XEvrVFgXHoMNSmjIwIHFkv7dTUFs/H0UfnT7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gtQzJzJSziO7bzJCT8MJwa1ic1D49bD/T9hoh/GkUFvIH5EsAmwjkls73JMEfn8Y2
         arb3u+tbfhy/+t4b/D0LdH0/j7MAcY80iguSoYMP+2V7LxZd53scEMHVEEJ5ez+6Md
         ldcwiJtsMKCs5kXV5jajxoM8RAOcDnww/iEnGpSt/FpuPniEaYcJJ2Ixh3JqacaCtK
         ikt0yS2T2tvjFpstNn9i+dcmHWKCEPVgGTv2oxWjHSKdk7Cmx/pp7dfH1aTS0jDd3i
         F9PSP/p3CDnmpLif7jtzGB5zG1MFtl4LUg0O5O8NcGrmJF1IgYer3TkukHbIaAmujy
         NV5MEIPsdMuPQ==
Date:   Wed, 12 Jan 2022 17:45:40 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 8/9] mm: multigenerational lru: user interface
Message-ID: <Yd73pDkMOMVHhXzu@kernel.org>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-9-yuzhao@google.com>
 <YdwKB3SfF7hkB9Xv@kernel.org>
 <Yd6S6Js1W4AnFFmv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd6S6Js1W4AnFFmv@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 01:35:52AM -0700, Yu Zhao wrote:
> On Mon, Jan 10, 2022 at 12:27:19PM +0200, Mike Rapoport wrote:
> > Hi,
> > 
> > On Tue, Jan 04, 2022 at 01:22:27PM -0700, Yu Zhao wrote:
> > > Add /sys/kernel/mm/lru_gen/enabled as a runtime kill switch.
> > > 
> > > Add /sys/kernel/mm/lru_gen/min_ttl_ms for thrashing prevention.
> > > Compared with the size-based approach, e.g., [1], this time-based
> > > approach has the following advantages:
> > > 1) It's easier to configure because it's agnostic to applications and
> > >    memory sizes.
> > > 2) It's more reliable because it's directly wired to the OOM killer.
> > > 
> > > Add /sys/kernel/debug/lru_gen for working set estimation and proactive
> > > reclaim. Compared with the page table-based approach and the PFN-based
> > > approach, e.g., mm/damon/[vp]addr.c, this lruvec-based approach has
> > > the following advantages:
> > > 1) It offers better choices because it's aware of memcgs, NUMA nodes,
> > >    shared mappings and unmapped page cache.
> > > 2) It's more scalable because it's O(nr_hot_evictable_pages), whereas
> > >    the PFN-based approach is O(nr_total_pages).
> > > 
> > > Add /sys/kernel/debug/lru_gen_full for debugging.
> > > 
> > > [1] https://lore.kernel.org/lkml/20211130201652.2218636d@mail.inbox.lv/
> > > 
> > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > > Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> > > ---
> > >  Documentation/vm/index.rst        |   1 +
> > >  Documentation/vm/multigen_lru.rst |  62 +++++
> > 
> > The description of user visible interfaces should go to
> > Documentation/admin-guide/mm
> > 
> > Documentation/vm/multigen_lru.rst should have contained design description
> > and the implementation details and it would be great to actually have such
> > document.
> 
> Will do, thanks.
> 
> > >  include/linux/nodemask.h          |   1 +
> > >  mm/vmscan.c                       | 415 ++++++++++++++++++++++++++++++
> > >  4 files changed, 479 insertions(+)
> > >  create mode 100644 Documentation/vm/multigen_lru.rst
> > > 
> > > diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
> > > index 6f5ffef4b716..f25e755b4ff4 100644
> > > --- a/Documentation/vm/index.rst
> > > +++ b/Documentation/vm/index.rst
> > > @@ -38,3 +38,4 @@ algorithms.  If you are looking for advice on simply allocating memory, see the
> > >     unevictable-lru
> > >     z3fold
> > >     zsmalloc
> > > +   multigen_lru
> > > diff --git a/Documentation/vm/multigen_lru.rst b/Documentation/vm/multigen_lru.rst
> > > new file mode 100644
> > > index 000000000000..6f9e0181348b
> > > --- /dev/null
> > > +++ b/Documentation/vm/multigen_lru.rst
> > > @@ -0,0 +1,62 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +=====================
> > > +Multigenerational LRU
> > > +=====================
> > > +
> > > +Quick start
> > > +===========
> > > +Runtime configurations
> > > +----------------------
> > > +:Required: Write ``1`` to ``/sys/kernel/mm/lru_gen/enable`` if the
> > > + feature wasn't enabled by default.
> > 
> > Required for what? This sentence seem to lack context. Maybe add an
> > overview what is Multigenerational LRU so that users will have an idea what
> > these knobs control.
> 
> Apparently I left an important part of this quick start in the next
> patch, where Kconfig options are added. I'm wonder whether I should
> squash the next patch into this one.

I think documentation deserves a separate patch.
 

-- 
Sincerely yours,
Mike.
