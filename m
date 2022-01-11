Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC0848BB52
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 00:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346772AbiAKXRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 18:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiAKXRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 18:17:02 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AFFC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 15:17:02 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id v6so1093884iom.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 15:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+BNyhiKbMm4RyIg8JNrtqDxZgbHGdo0J7XNrf0piRew=;
        b=iskzbXe5xMvIxCUIg2oP1wUuouDfhgLnCC+sQJPAAAZEHx/x1j5Al9PEfKyyAXPPL0
         8cv4uckuhLYcffGBt04dCVj17g9Bx9b3LLN4XH14iZtpWuxjHsDC+6fM5paFu0GZ7ZOc
         OPSe0TwDLDOQBnMk5VrrS2x7TJvIhgv9+SOESCKNl0sM50g+kb8sjRU9VXmsCgSlB7Pk
         Sq0yuZLlWA/XbIf4jLqEv9rrIPGbRiXCNb/WHEkTua98LZ7UGm7jeNIauz9xcODpbM38
         ONSBKKdQR8MmmejnouArJBl/1Vl4tiNj2Lkr5VwJyJE0IoBNbgSbtK2hLXLSf3//qmTk
         nv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+BNyhiKbMm4RyIg8JNrtqDxZgbHGdo0J7XNrf0piRew=;
        b=7DwISMqcmggpGiYFYrZsGxZi4KXb/7EQ798kveroQJ08hL2ymRQ1ePZXhfsThtY1g/
         XQpBVEAeLYIwgOrLBA6t8Uu+IeIldHJrnuvgHilNUcJweTYSyQ6WAi08ofuB0Ln73TV+
         zo17alkb2xai5qmad14ZXDFFkg3ibimoHAg49dPiMEt4z7ciHC+Q27Sc5Lxme1+CJKJh
         +EYRNpi/gP8DiMTXLKEOxvtV5pU9yYocH2gjTFGm0Fz+FnJpdyXn2seF918eCfxB5/i+
         TJmNuN8iWsKPyPi2/SHHJ/yUU+wRhoV5iP7sYPo8l4xGkeyQGXHFmC7Hl+JtXLpoddW4
         f+TQ==
X-Gm-Message-State: AOAM5300NBOHV2P4tWvWj4vtCq02DvHYc0HWAjQjTzoB6u4OSbYxE1Nn
        VyVo1OY3He0uGLXhMLFG2LZiUw==
X-Google-Smtp-Source: ABdhPJyF9jePSeHs9NHaVjjmJYEtoTSK60Y5oIKEaaIgZtxgs/ZSrSvwH+4hyESidsEw5kW2XjQauQ==
X-Received: by 2002:a02:aa10:: with SMTP id r16mr3590702jam.36.1641943021690;
        Tue, 11 Jan 2022 15:17:01 -0800 (PST)
Received: from google.com ([2620:15c:183:200:b6b6:70f4:b540:6383])
        by smtp.gmail.com with ESMTPSA id o12sm6722264ilu.86.2022.01.11.15.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 15:17:01 -0800 (PST)
Date:   Tue, 11 Jan 2022 16:16:57 -0700
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
Message-ID: <Yd4P6bEJI8YlXq0H@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdcU4P+XWkbDUUoO@dhcp22.suse.cz>
 <YdxKORU9OWCv114O@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdxKORU9OWCv114O@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:01:13PM +0100, Michal Hocko wrote:
> On Thu 06-01-22 17:12:18, Michal Hocko wrote:
> > On Tue 04-01-22 13:22:25, Yu Zhao wrote:
> > > +static struct lru_gen_mm_walk *alloc_mm_walk(void)
> > > +{
> > > +	if (!current->reclaim_state || !current->reclaim_state->mm_walk)
> > > +		return kvzalloc(sizeof(struct lru_gen_mm_walk), GFP_KERNEL);
> 
> One thing I have overlooked completely.

I appreciate your attention to details but GFP_KERNEL is legit in the
reclaim path. It's been used many years in our production, e.g.,
  page reclaim
    swap_writepage()
      frontswap_store()
        zswap_frontswap_store()
          zswap_entry_cache_alloc(GFP_KERNEL)

(And I always test my changes with lockdep, kasan, DEBUG_VM, etc., no
 warnings ever seen from using GFP_KERNEL in the reclaim path.)

> You cannot really use GFP_KERNEL
> allocation here because the reclaim context can be constrained (e.g.
> GFP_NOFS). This allocation will not do any reclaim as it is PF_MEMALLOC
> but I suspect that the lockdep will complain anyway.
> 
> Also kvmalloc is not really great here. a) vmalloc path is never
> executed for small objects and b) we do not really want to make a
> dependency between vmalloc and the reclaim (by vmalloc -> reclaim ->
> vmalloc).
> 
> Even if we rule out vmalloc and look at kmalloc alone. Is this really
> safe? I do not see any recursion prevention in the SL.B code. Maybe this
> just happens to work but the dependency should be really documented so
> that future SL.B changes won't break the whole scheme. 

Affirmative, as Vlastimil has clarified.

Thanks!
