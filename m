Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEA248BF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351419AbiALIIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351418AbiALIIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:08:20 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F1BC061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:08:20 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id w9so2422113iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WFX0A5hPtLq2y+4vv8Glr1WeFBcLpToPaecrV540Urk=;
        b=OBoRktJAv2XSBOFIYv6FTRsogQts1376KLhe7+5DMuFh7zRq5yAzGpqqXyDHj9Xjlb
         zotg52mPLRjGo6JHqs8a8N3MNFQXCWj/igX/71yKCdvHpQKVu0yd31fWY1gSFmUlwJ6X
         ZMSVBsO2CuLPHnyELp6xcWP2DErwfVG70j4xM2qnfBrXMI1aRbbazUqGDTiqtRrpqTbZ
         9xV45uFJmSmfaJmdQKyEP3ks97tS5WK6/jLQ+x9FEdirZ2JWpo0rTci8disi/gFeyrJf
         CPpop5aA7QFRTB9cPJm4sFRxoK1R67hphj6jIur2TBzKWeY8Gj0aZAFIrw6WPXx6O3z5
         WdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WFX0A5hPtLq2y+4vv8Glr1WeFBcLpToPaecrV540Urk=;
        b=pJ0sl8JFHE5R6BUsAKEZGPEu03PjLa4Tf6kUu+wHdVPOu5mpgwhgxsKCG3A0poWZCm
         bZ2uonflIkqVNgzsEPHluTDP/Zc2SuAVZHcxjZ+qCMBUHWYic3VtI5QDKNrnEAJbgj8h
         inniG6XQ0eJ3xhABVZTq4AInb5l3lt088UADmwpxt4iCS3cpXolJ5CkzW74RFSOEOeaB
         wI5x27bULHZi5JB6OtbGxrhgh0kT9jZyE79tuG7naWmeN8uXJHnjP04gThp3cX+VPiCI
         +XRmmVbhHySVjS4wQ9RTPpoxxgCCQw/QYRFesw3VuhKQnKJijTe6PXIb9pxaGjz12Fa+
         R/og==
X-Gm-Message-State: AOAM530jAmsvIp+NtSqrObdqb5zx9DhFLwrWh2Xvyb6DmgcTZzRKSDsl
        fwPrlk1PjG1VGcKeWqcReA9XCw==
X-Google-Smtp-Source: ABdhPJxO3An+3xlKK9bsJDfMFJ5VcX2bkSlQ27yXvyOjxBnpGUi93F7uIIXHnwXvCww63eGPNQJTkQ==
X-Received: by 2002:a05:6638:35a3:: with SMTP id v35mr3884475jal.137.1641974899399;
        Wed, 12 Jan 2022 00:08:19 -0800 (PST)
Received: from google.com ([2620:15c:183:200:b6b6:70f4:b540:6383])
        by smtp.gmail.com with ESMTPSA id d11sm7352276ilv.6.2022.01.12.00.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:08:18 -0800 (PST)
Date:   Wed, 12 Jan 2022 01:08:14 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Michal Hocko <mhocko@suse.com>
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
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 5/9] mm: multigenerational lru: mm_struct list
Message-ID: <Yd6MbsVkU7fChCrc@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-6-yuzhao@google.com>
 <YdgChw4vNb43XsU/@dhcp22.suse.cz>
 <YdjYkFmtMdrYg736@google.com>
 <YdxPEdsfl771Z7IX@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdxPEdsfl771Z7IX@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:21:53PM +0100, Michal Hocko wrote:
> On Fri 07-01-22 17:19:28, Yu Zhao wrote:
> > On Fri, Jan 07, 2022 at 10:06:15AM +0100, Michal Hocko wrote:
> > > On Tue 04-01-22 13:22:24, Yu Zhao wrote:
> > > > To exploit spatial locality, the aging prefers to walk page tables to
> > > > search for young PTEs. And this patch paves the way for that.
> > > > 
> > > > An mm_struct list is maintained for each memcg, and an mm_struct
> > > > follows its owner task to the new memcg when this task is migrated.
> > > 
> > > How does this work actually for the memcg reclaim? I can see you
> > > lru_gen_migrate_mm on the task migration. My concern is, though, that
> > > such a task leaves all the memory behind in the previous memcg (in
> > > cgroup v2, in v1 you can opt in for charge migration). If you move the
> > > mm to a new memcg then you age it somewhere where the memory is not
> > > really consumed.
> > 
> > There are two options to gather the accessed bit: page table walks and
> > rmap walks. Page table walks sweep dense hotspots that are NOT
> > misplaced in terms of reclaim scope (lruvec); rmap walks cover what
> > page table walks miss, e.g., misplaced dense hotspots or sparse ones.
> > 
> > Dense hotspots are stored in Bloom filters for each lruvec.
> > 
> > If an mm leaves everything in the old memcg, page table walks in the
> > new memcg reclaim path basically ignore this mm after the first scan,
> > because everything is misplaced.
> 
> OK, so do I get it right that pages mapped from a different memcg than
> the reclaimed one are considered effectivelly non-present from the the
> reclaim logic POV? This would be worth mentioning in the migration
> callback because it is not really that straightforward to put those two
> together.

That's correct. Will document this in detail.

> > In the old memcg reclaim path, page table walks won't see this mm
> > at all. But rmap walks will catch everything later in the eviction
> > path, i.e., lru_gen_look_around(). This function is less efficient
> > compared with page table walks because, for each rmap walk of a
> > non-shared page, it only can gather the accessed bit from 64 PTEs at
> > most. But it's still a lot faster than the original rmap, which only
> > gathers the accessed bit from a single PTE, for each walk of a
> > non-shared page.
> 
> Again, something that should be really documented.

Noted.
