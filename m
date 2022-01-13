Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7A548D528
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbiAMJr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiAMJr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:47:56 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8AAC061756
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:47:56 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d14so5174035ila.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VWo9B0Tv8mi43ViWq+aiDlDVmkwKs71GLUZpT36kOp4=;
        b=OCPaMrLllRjPp0Q3sosTUuMWsMCfxUXcjgAnnv2JVOLJ7hkMIQmKJNzpLX4oeE3fWs
         lSwomygEO9uUL1/4mE4jHw8AMOvS3o+SRrDUnQw9uZD0NpLzs735YD8UIyb3YQpGYvUF
         bQsPo3MsajhcYkPhKGR8zMoyojl1NUGyD+5gW0aExAdbwMwxyjhjVOWqp7nkwGuwqM6T
         YyCFe+edDV8DL2ALzNAPvBc33BfNR4YtwNKnhDJQz6TLNDOIG4rDiE13fRgSh1uHfyqR
         wyzKz+wE/1lSZYpE5Zs8AQ0btVWIldQaceFKLCoV8hyqnKfM6YB5i8TWQgr31YUtAFcz
         xgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWo9B0Tv8mi43ViWq+aiDlDVmkwKs71GLUZpT36kOp4=;
        b=PWiUcRqujpi91//B0KW1dIfwTADWaus/43k39G6Le3vh/SnmPO0rJ8tm8DZwN0Scky
         3jTdCkZOkIQacUwuXiVF/AwEgaA87QXmDO2FGJFe2CyWOhIEAmsdaIP9hCfNmaH6gSBR
         NapRd+CDCseZKASsXFZlanuvL/VK89+k3dzgp98Ji3pggUEjt06FEzus04vmS1kKb5q4
         UgQ8f1LCqEsrrsqJe72F9+78oOOBqGPSSeowBG846Wl95PXaqUVMl8y4/CCpyoZJH6kZ
         dLd31mu9pDEEzQYJYEvVBYcOJwqfPTrOHKZWMK0+h/wrbfwcne8PoTJwhypQkG2nJ8LN
         C/9Q==
X-Gm-Message-State: AOAM533qPGuReVBJ9KIBwBGZkqxV4gQplRJmGfTz6w1PVbUP0IBvbtlY
        b8zdeTguaEZfBo7a4zjfxf0mCQ==
X-Google-Smtp-Source: ABdhPJx0pnjkze3Ecby+3gkeeznELAZw2UJxt0ED2UO8PQR+olhMLA+rgGA4hoiD3ynF6pquSaR/aA==
X-Received: by 2002:a92:c26c:: with SMTP id h12mr2016453ild.229.1642067275914;
        Thu, 13 Jan 2022 01:47:55 -0800 (PST)
Received: from google.com ([2620:15c:183:200:ac2b:c4ef:2b56:374c])
        by smtp.gmail.com with ESMTPSA id g6sm2357262iow.34.2022.01.13.01.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:47:55 -0800 (PST)
Date:   Thu, 13 Jan 2022 02:47:51 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <Yd/1Rz+ne38Mh8R9@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-9-yuzhao@google.com>
 <YdwKB3SfF7hkB9Xv@kernel.org>
 <Yd6S6Js1W4AnFFmv@google.com>
 <Yd73pDkMOMVHhXzu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd73pDkMOMVHhXzu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 05:45:40PM +0200, Mike Rapoport wrote:
> On Wed, Jan 12, 2022 at 01:35:52AM -0700, Yu Zhao wrote:
> > On Mon, Jan 10, 2022 at 12:27:19PM +0200, Mike Rapoport wrote:
> > > Hi,
> > > 
> > > On Tue, Jan 04, 2022 at 01:22:27PM -0700, Yu Zhao wrote:
> > > > Add /sys/kernel/mm/lru_gen/enabled as a runtime kill switch.
> > > > 
> > > > Add /sys/kernel/mm/lru_gen/min_ttl_ms for thrashing prevention.
> > > > Compared with the size-based approach, e.g., [1], this time-based
> > > > approach has the following advantages:
> > > > 1) It's easier to configure because it's agnostic to applications and
> > > >    memory sizes.
> > > > 2) It's more reliable because it's directly wired to the OOM killer.
> > > > 
> > > > Add /sys/kernel/debug/lru_gen for working set estimation and proactive
> > > > reclaim. Compared with the page table-based approach and the PFN-based
> > > > approach, e.g., mm/damon/[vp]addr.c, this lruvec-based approach has
> > > > the following advantages:
> > > > 1) It offers better choices because it's aware of memcgs, NUMA nodes,
> > > >    shared mappings and unmapped page cache.
> > > > 2) It's more scalable because it's O(nr_hot_evictable_pages), whereas
> > > >    the PFN-based approach is O(nr_total_pages).
> > > > 
> > > > Add /sys/kernel/debug/lru_gen_full for debugging.
> > > > 
> > > > [1] https://lore.kernel.org/lkml/20211130201652.2218636d@mail.inbox.lv/
> > > > 
> > > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > > > Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> > > > ---
> > > >  Documentation/vm/index.rst        |   1 +
> > > >  Documentation/vm/multigen_lru.rst |  62 +++++
> > > 
> > > The description of user visible interfaces should go to
> > > Documentation/admin-guide/mm
> > > 
> > > Documentation/vm/multigen_lru.rst should have contained design description
> > > and the implementation details and it would be great to actually have such
> > > document.
> > 
> > Will do, thanks.
> > 
> > > >  include/linux/nodemask.h          |   1 +
> > > >  mm/vmscan.c                       | 415 ++++++++++++++++++++++++++++++
> > > >  4 files changed, 479 insertions(+)
> > > >  create mode 100644 Documentation/vm/multigen_lru.rst
> > > > 
> > > > diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
> > > > index 6f5ffef4b716..f25e755b4ff4 100644
> > > > --- a/Documentation/vm/index.rst
> > > > +++ b/Documentation/vm/index.rst
> > > > @@ -38,3 +38,4 @@ algorithms.  If you are looking for advice on simply allocating memory, see the
> > > >     unevictable-lru
> > > >     z3fold
> > > >     zsmalloc
> > > > +   multigen_lru
> > > > diff --git a/Documentation/vm/multigen_lru.rst b/Documentation/vm/multigen_lru.rst
> > > > new file mode 100644
> > > > index 000000000000..6f9e0181348b
> > > > --- /dev/null
> > > > +++ b/Documentation/vm/multigen_lru.rst
> > > > @@ -0,0 +1,62 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +=====================
> > > > +Multigenerational LRU
> > > > +=====================
> > > > +
> > > > +Quick start
> > > > +===========
> > > > +Runtime configurations
> > > > +----------------------
> > > > +:Required: Write ``1`` to ``/sys/kernel/mm/lru_gen/enable`` if the
> > > > + feature wasn't enabled by default.
> > > 
> > > Required for what? This sentence seem to lack context. Maybe add an
> > > overview what is Multigenerational LRU so that users will have an idea what
> > > these knobs control.
> > 
> > Apparently I left an important part of this quick start in the next
> > patch, where Kconfig options are added. I'm wonder whether I should
> > squash the next patch into this one.
> 
> I think documentation deserves a separate patch.

Will do.
