Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B4948D4F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiAMJZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiAMJZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:25:37 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DD9C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:25:36 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id v1so7568222ioj.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=buO1MWlrsiI4ThiE8ebM/qEepT6gBkUde7jyQkyjwsk=;
        b=KMAEG9ziKENxPP1OUvgV8H9b9riW0zf1s8l6B8uIy7wERxSV6hUC7vq3U5MlfoI6SZ
         hiSVecAggVpDg6qiv5KFgTnfy7Czx0NQA/RaFx5G1DaUMLKMliLi916tEEesAq6vHJaE
         YGLSdVuRxoJGBBWUzrLdilBviof2yDJjhzavjFJawr11Nt7WhL/omEZ7LjA/7Q3+udtG
         bjJIrtPHwC66r3gB18NPzQEttfS7SKkOHYiBZdsjIACvA2WdLSqswqepyseE1KYgd4Oi
         4cJIyV8BaKn1Oi07itiSTJxh/yIJbeuP6tRmHWUfnzSyAAeDldkgqO25AknZu+VRbPGM
         bA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=buO1MWlrsiI4ThiE8ebM/qEepT6gBkUde7jyQkyjwsk=;
        b=WD8Kbj5TAvBVip02xSE1P4zvks7k0J8s85Cf5eVqznWfUTCcWqATp3/qoINZ+05erK
         +g2Nrpn9BOETNxTHLugqLdJh1Lb1QW8W+TmRPopyo2YqrK9vN+V+mQYzQKK/ZfXpl2Ni
         1evuIakFUBnFzlJ06DNcVepusTt2UX8WLDCQ2DIC0zIP4MgReAEV9Wpv14uRrIlzSPsF
         Lz2XoOClv9v3sn7SMdDCEAKlhkbtg3dW8iS6selrI96uNnvQ3sbSVljQ1+BvJ9s0ggYb
         Qe/1ICV/wXlINhoP3zFd/mzDG4+i0C6IfdHDgUnI8drFE2btoyzJVN+X24rJAh/d2BbY
         GQig==
X-Gm-Message-State: AOAM533xRCIolfQ0uCDKl//6flyZOUDtYHXTIgz0lHUo0AAgUSbsffg6
        MMpt/x4ZGOCGnbl6JFmeAJ9pEA==
X-Google-Smtp-Source: ABdhPJxpdfdhJM+DmhBp7LTkz0JGkOoR+uvxcCvDtUCxvIxN1P5mrcrBrzRFrIMyX49jOdAeRASeog==
X-Received: by 2002:a05:6638:2246:: with SMTP id m6mr1626108jas.292.1642065935899;
        Thu, 13 Jan 2022 01:25:35 -0800 (PST)
Received: from google.com ([2620:15c:183:200:ac2b:c4ef:2b56:374c])
        by smtp.gmail.com with ESMTPSA id b17sm2192509iow.6.2022.01.13.01.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:25:35 -0800 (PST)
Date:   Thu, 13 Jan 2022 02:25:31 -0700
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
Message-ID: <Yd/wC8K3+0pE+3UZ@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdcU4P+XWkbDUUoO@dhcp22.suse.cz>
 <YdxKORU9OWCv114O@dhcp22.suse.cz>
 <Yd4P6bEJI8YlXq0H@google.com>
 <Yd6tafG3CS7BoRYn@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd6tafG3CS7BoRYn@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 11:28:57AM +0100, Michal Hocko wrote:
> On Tue 11-01-22 16:16:57, Yu Zhao wrote:
> > On Mon, Jan 10, 2022 at 04:01:13PM +0100, Michal Hocko wrote:
> > > On Thu 06-01-22 17:12:18, Michal Hocko wrote:
> > > > On Tue 04-01-22 13:22:25, Yu Zhao wrote:
> > > > > +static struct lru_gen_mm_walk *alloc_mm_walk(void)
> > > > > +{
> > > > > +	if (!current->reclaim_state || !current->reclaim_state->mm_walk)
> > > > > +		return kvzalloc(sizeof(struct lru_gen_mm_walk), GFP_KERNEL);
> > > 
> > > One thing I have overlooked completely.
> > 
> > I appreciate your attention to details but GFP_KERNEL is legit in the
> > reclaim path. It's been used many years in our production, e.g.,
> >   page reclaim
> >     swap_writepage()
> >       frontswap_store()
> >         zswap_frontswap_store()
> >           zswap_entry_cache_alloc(GFP_KERNEL)
> > 
> > (And I always test my changes with lockdep, kasan, DEBUG_VM, etc., no
> >  warnings ever seen from using GFP_KERNEL in the reclaim path.)
> 
> OK, I can see it now. __need_reclaim will check for PF_MEMALLOC and skip
> the fs_reclaim tracking.
> 
> I still maintain I am not really happy about (nor in the zswap example)
> allocations from the direct reclaim context. I would really recommend
> using a pre-allocated pool of objects.

Not trying to argue anything -- there are many other places in the
reclaim path that must allocate memory to make progress, e.g.,

  add_to_swap_cache()
    xas_nomem()

  __swap_writepage()
    bio_alloc()

The only way to not allocate memory is drop clean pages. Writing dirty
pages (not swap) might require allocations as well. (But we only write
dirty pages in kswapd, not in the direct reclaim path.)

> If there are strong reasons for not doing so then at lease change that
> to kzalloc.

Consider it done.
