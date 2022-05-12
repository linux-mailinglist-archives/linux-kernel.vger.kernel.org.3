Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3278A52561C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358224AbiELTzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351922AbiELTzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:55:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E122701B2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:55:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p8so5741467pfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 12:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BrAloknBKGzWWokXz+hazBEfwUJ2O3UP9AUvih3teCk=;
        b=N4D5cWFxJXwYO+Z9SIDfcfVXYPwfj3OhyZMfpDvEAmGo+DAn/cmubjX5MKM0VhBsIn
         wU4HSjOrYVW1O/W+wXtBbA23aBek6h9o8Bx+6BBHreVLaH09/hLYumbswb2T79VUL6P6
         pGeV+TrdmMYy4XeKEgDprNkrcg3vbX4rhWELikMEt9hg0rgyPEbviQgDonAEhVXGn2dT
         nXseM+nxsKcjpzU2wi+psu7HGC7XTOSbK7ulO2Yfslb/jYTzWjVYOapwIveV5F+OFH+V
         DZRHnURF440henKLWxQGG40AVg28HKU382dttDznh6KMowlqSW+XYBwJNC5Rnkc1qpOU
         VqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BrAloknBKGzWWokXz+hazBEfwUJ2O3UP9AUvih3teCk=;
        b=Qq3On9E4wighdMZ6XnWwoU3Vm70aXKXVyF5x0hqq4d0J9OLplnw0fGOqpNlxATd8C6
         ZI5jHj0SeO+G8yvYZbPrNijh9M2yEft+5G8YMalywPGiLQmL+qIdCV0cQWxbBz/kYrOF
         1eoTYNnpDGxmpiy6ghtCWNUORLwDQsD/6SuTbSkt2k0bQH38drs4yHGWts4X5Ep+NOAA
         QHrSXBl72HH34zkMfGCyotpyC9sVJlZJtT1VKO7o5xcNasnQskPItjatSJ+TKwTIcRYA
         j/KuKPEAq9JWHzgXsRs/ZekfV/LLOHZ3q7Bkn2xWLx5MvAgGcaR8L3qBbHaIUDjcgusg
         lytw==
X-Gm-Message-State: AOAM530UVuAWC7x8j2wfx6frui/Vw7jQrHrhD0G9ALzKwstwg7AsbK7y
        PdnlLD3GqEMqSN8GUKiyo80=
X-Google-Smtp-Source: ABdhPJzmTzf76vaLA/IN6uWCznkqk2dWYfJtSSj+skNIBq99cZP8XamENPr/f/xjBoqNDoDO85MJFA==
X-Received: by 2002:a63:8741:0:b0:3c6:a7d9:5d05 with SMTP id i62-20020a638741000000b003c6a7d95d05mr966539pge.313.1652385319494;
        Thu, 12 May 2022 12:55:19 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:872f:bbca:8e23:fae5])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090332c100b0015e8d4eb21bsm307174plr.101.2022.05.12.12.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 12:55:18 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 12 May 2022 12:55:16 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Martin Liu <liumartin@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v4] mm: don't be stuck to rmap lock on reclaim path
Message-ID: <Yn1mJEjP3LH8rl3t@google.com>
References: <20220510215423.164547-1-minchan@kernel.org>
 <20220511153349.045ab3865f25920dce11ca16@linux-foundation.org>
 <Ynw/RRsEj33gq+Hf@google.com>
 <20220511190523.7d159b2e9caccbf13469e74e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511190523.7d159b2e9caccbf13469e74e@linux-foundation.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 07:05:23PM -0700, Andrew Morton wrote:
> On Wed, 11 May 2022 15:57:09 -0700 Minchan Kim <minchan@kernel.org> wrote:
> 
> > > 
> > > Could we burn much CPU time pointlessly churning though the LRU?  Could
> > > it mess up aging decisions enough to be performance-affecting in any
> > > workload?
> > 
> > Yes, correct. However, we are already churning LRUs by several
> > ways. For example, isolate and putback from LRU list for page
> > migration from several sources(typical example is compaction)
> > and trylock_page and sc->gfp_mask not allowing page to be
> > reclaimed in shrink_page_list.
> 
> Well.  "we're already doing a risky thing so it's OK to do more of that
> thing"?

I meant the aging is not rocket science.


> 
> > > 
> > > Something else?
> > 
> > One thing I am worry about was the granularity of the churning.
> > Example above was page granuarity churning so might be execuse
> > but this one is address space's churning, especically for file LRU
> > (i_mmap_rwsem) which might cause too many rotating and live-lock
> > in the end(keey rotating in small LRU with heavy memory pressure).
> > 
> > If it could be a problem, maybe we use sc->priority to stop
> > the skipping on a certain level of memory pressure.
> > 
> > Any thought? Do we really need it?
> 
> Are we able to think of a test which might demonstrate any worst case? 
> Whip that up and see what the numbers say?

Yeah, let me create a worst test case to see how it goes.

A thread keep reading a file-backed vma with 2xRAM file but other threads
keep changing other vmas mapped at the same file so heavy i_mmap_rwsem
contention in aging path.

> 
> It's a bit of a drag, but if we don't do it, our users surely will ;)
