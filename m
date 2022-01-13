Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC45C48D51B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiAMJnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiAMJno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:43:44 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2A7C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:43:44 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id b1so5152466ilj.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jGQBCbp3VTht0s83RWyoZNzI0eJghJWEzndcXZrspMo=;
        b=dOiEoYZZR5+Vh4TZtqnlnz56IlRAJIIf5ZM2uTXDW3TzSIcBai32MZCE/+RFY08zLL
         +vvE5O7Tk9L9KpvnioUjlxjBHvZnjZwFZ34lf5soHkEX7k6/ycviXBJNvZdKadpjfYCX
         COxH2uvQ9SgBj2be8KndYGJuP24P1k2gltNuwZ+Sq7HPEWf3rFft9n1D9MzwTIaj5v/E
         UsYcsv0qN79TMVriH6W9dSjaxNh+Orx8ylV2Z9q/JRC1Dd+PLrKvyDIcrFlH3/IG2kR9
         aotv0MTUFdp82kuTRyf8S01UkXLYauad7zxiSUBLwBD7Dp5fCcr7jxcELJ1QZ3Q303Dl
         LWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jGQBCbp3VTht0s83RWyoZNzI0eJghJWEzndcXZrspMo=;
        b=JEtpE3dhwC6bLfZToOiG24v6vIi84n3r+jS6ze+em1bBcckBFBXiRMr4drpEYP9fl2
         CreLh+RUsdRbFUNq1kGmwn11A0fLCrl5ZRbu5qQl89M60WMJhBF5deRb/F4nASxQ57q4
         /feO/Aa8wPMztPT7ngvdXa6YjSyllXftje5x9vZif7tTX3QfcNNwZl5u+PvNGMgP2r6P
         LrJksINcZGbdnD9jy1fLsTt832ING76d82w1ZyCEttCdjXJRweFUEiAi9gXZJbDXdJcf
         kzheJQ5O77y6n31xtDGwhi43IpoS8asLulFqIh/McIvfjMuqP+JGWvqSbqmkzOl3G79e
         RflA==
X-Gm-Message-State: AOAM533JKH1MCd5GnNNvWi1BH3MOPM3odhyuMoXGZg1SJra7UPSXmu/L
        mjjuO84XvptYu3qxPIR5MmeV0g==
X-Google-Smtp-Source: ABdhPJzaVVIjiSChWOEW5dyFzP9OPOrAjE5fTqnll9HOb/39p3QyrdWz9y9wBYeFXpIkoCBSkTMAww==
X-Received: by 2002:a92:c7c6:: with SMTP id g6mr2001597ilk.318.1642067023414;
        Thu, 13 Jan 2022 01:43:43 -0800 (PST)
Received: from google.com ([2620:15c:183:200:ac2b:c4ef:2b56:374c])
        by smtp.gmail.com with ESMTPSA id r9sm1957174ilh.80.2022.01.13.01.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:43:42 -0800 (PST)
Date:   Thu, 13 Jan 2022 02:43:38 -0700
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
Subject: Re: [PATCH v6 6/9] mm: multigenerational lru: aging
Message-ID: <Yd/0Sgxy+jLm5cqd@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdcU4P+XWkbDUUoO@dhcp22.suse.cz>
 <Yddh+APQGg8dKRgw@google.com>
 <Ydf/7DDu94fMs0CG@dhcp22.suse.cz>
 <YdgBL1dRk1KmyXJS@dhcp22.suse.cz>
 <Yduuyrk/AZG717Hs@google.com>
 <YdxEqFPLDf+wI0xX@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdxEqFPLDf+wI0xX@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 03:37:28PM +0100, Michal Hocko wrote:
> On Sun 09-01-22 20:58:02, Yu Zhao wrote:
> > On Fri, Jan 07, 2022 at 10:00:31AM +0100, Michal Hocko wrote:
> > > On Fri 07-01-22 09:55:09, Michal Hocko wrote:
> > > [...]
> > > > > In this case, lru_gen_mm_walk is small (160 bytes); it's per direct
> > > > > reclaimer; and direct reclaimers rarely come here, i.e., only when
> > > > > kswapd can't keep up in terms of the aging, which is similar to the
> > > > > condition where the inactive list is empty for the active/inactive
> > > > > lru.
> > > > 
> > > > Well, this is not a strong argument to be honest. Kswapd being stuck
> > > > and the majority of the reclaim being done in the direct reclaim
> > > > context is a situation I have seen many many times.
> > > 
> > > Also do not forget that memcg reclaim is effectivelly only direct
> > > reclaim. Not that the memcg reclaim indicates a global memory shortage
> > > but it can add up and race with the global reclaim as well.
> > 
> > I don't dispute any of the above, and I probably don't like this code
> > more than you do.
> > 
> > But let's not forget the purposes of PF_MEMALLOC, besides preventing
> > recursive reclaims, include letting reclaim dip into reserves so that
> > it can make more free memory. So I think it's acceptable if the
> > following conditions are met:
> > 1. The allocation size is small.
> > 2. The number of allocations is bounded.
> > 3. Its failure doesn't stall reclaim.
> > And it'd be nice if
> > 4. The allocation happens rarely, e.g., slow path only.
> 
> I would add 
>   0. The allocation should be done only if absolutely _necessary_.
> 
> Please keep in mind that whatever you allocate from that context will be
> consuming a very precious memory reserves which are shared with other
> components of the system. Even worse these can go all the way to
> depleting memory completely where other things can fall apart.

I agree but I also see a distinction:
   1,2,3 are objective;
   0,4 are subjective.

For some users, page reclaim itself could be not absolutely necessary
because they are okay with OOM kills. But for others, the situation
could be reversed.

> > The code in question meets all of them.
> > 
> > 1. This allocation is 160 bytes.
> > 2. It's bounded by the number of page table walkers which, in the
> >    worst, is same as the number of mm_struct's.
> > 3. Most importantly, its failure doesn't stall the aging. The aging
> >    will fallback to the rmap-based function lru_gen_look_around().
> >    But this function only gathers the accessed bit from at most 64
> >    PTEs, meaning it's less efficient (retains ~80% performance gains).
> > 4. This allocation is rare, i.e., only when the aging is required,
> >    which is similar to the low inactive case for the active/inactive
> >    lru.
> 
> I think this fallback behavior deserves much more detailed explanation
> in changelogs.

Will do.

> > The bottom line is I can try various optimizations, e.g., preallocate
> > a few buffers for a limited number of page walkers and if this number
> > has been reached, fallback to the rmap-based function. But I have yet
> > to see evidence that calls for additional complexity.
> 
> I would disagree here. This is not an optimization. You should be
> avoiding allocations from the memory reclaim because any allocation just
> add a runtime behavior complexity and potential corner cases.

Would __GFP_NOMEMALLOC address your concern? It prevents allocations
from accessing the reserves even under PF_MEMALLOC.
