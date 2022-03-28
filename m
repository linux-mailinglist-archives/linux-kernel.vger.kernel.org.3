Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6304E9771
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbiC1NIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbiC1NHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:07:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E70333E0D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:05:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id u26so16808287eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h3LEdgAHA4dEu7o/Z8LMit4USCOTHbj/jRe7pP0QZXU=;
        b=gPWnNF73b+3D/surkKx1tPd0kPBLvrgfQLpJy8jJnR/trJ9KLHAAbMyCeI0BCGMMWM
         DpjKX++C+7VaLcmY3UcqSSrucGNnR6NHxTmnh99tIaTaDuQuDmrFtU/PLJ+Hm//Bwgbv
         LR/Xx+SGtYkkpd5QcvaHbEr0tFumjUhaT7PFaqDSvk2CQJxkEGKPSpj8nQkUoxk9kx2M
         CYYxT9gKE/pB57zWuTI7N7MDyGXYVLYz0dLvWvPm/nFUX9T2QFXf12SSNMVeC43ebS6l
         UD8nNU94C8BzOsC2D2UzYmJsqXxZknNhH7Z5+abjIuh5/APZl0Yts/Rc8cameB2wrOMz
         kkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h3LEdgAHA4dEu7o/Z8LMit4USCOTHbj/jRe7pP0QZXU=;
        b=2ZH7A5l68h5ttKttAhaWrKk8gUmMdzrO6T+ec70g4AgDrq1wDxtL84Q7g1d6zrNew9
         aTlHC4/lTrJyihG3pZ8/ePKKWzfM4N4yGPbJdaxrO0IPZee3hHde5cnSim0bVcaEde96
         IJPau4lzEjPzoJhKcbkPMl1QhGAjROqpeIJl155VfdZdPao4SqL8/gmahziGdh7Bl2Dp
         WW+QC5xvkVRJg9RgRh4WZ7OKV4OXieDLKgL+7WuYONbze1PT1lfy+cjIBM7vjXixYie4
         lCro57et3UfPpJ+Wk7BZCNf5eScyDV6tvtTscMDeDwjfFYE3kgK5FvW5VCgeh3LFoM5h
         uwqw==
X-Gm-Message-State: AOAM530g1UVkpPsMr167HaxMEW7hWLGJQc/LtyeTzhjCCQgH9xiKP3Cw
        6lHC8B+Iel1koUe+5t07343Cdg==
X-Google-Smtp-Source: ABdhPJzGmcUodqdDGn0NPNIMasxnU0486mgBpKAzatztuzAkjtyDJBGHESujh2SCl8B+WP+NWJYBdg==
X-Received: by 2002:a05:6402:4254:b0:419:245b:8051 with SMTP id g20-20020a056402425400b00419245b8051mr16041385edb.295.1648472755279;
        Mon, 28 Mar 2022 06:05:55 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id y17-20020a056402359100b0041926ea1e12sm6987459edc.53.2022.03.28.06.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 06:05:54 -0700 (PDT)
Date:   Mon, 28 Mar 2022 21:05:47 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     Nick.Forrington@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 2/4] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <20220328130547.GA360814@leoy-ThinkPad-X240s>
References: <20220326194327.32239-1-alisaidi@amazon.com>
 <20220328030805.14175-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328030805.14175-1-alisaidi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ali,

On Mon, Mar 28, 2022 at 03:08:05AM +0000, Ali Saidi wrote:

[...]

> > > > > +	case ARM_SPE_NV_PEER_CORE:
> > > > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > > > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > > > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> > > > 
> > > > Peer core contains its local L1 cache, so I think we can set the
> > > > memory level L1 to indicate this case.
> > > It could be either the L1 or the L2. All the neoverse cores have private L2
> > > caches and we don't know. 
> > 
> > How about set both L1 and L2 cache together for this case?
> > 
> > Although 'L1 | L2' cannot tell the exact cache level, I think it's
> > better than use ANY_CACHE, at least this can help us to distinguish
> > from other data source types if we avoid to use ANY_CACHE for all of
> > them.
> 
> This seems much more confusing then the ambiguity of where the line came from
> and is only possible with the deprecated mem_lvl enconding.  It will make
> perf_mem__lvl_scnprintf() print the wrong thing and anyone who is trying to
> attribute a line to a single cache will find that the sum of the number of hits
> is greater than the number of accesses which also seems terribly confusing.

Understand.  I considered the potential issue for
perf_mem__lvl_scnprintf(), actually it supports printing multipl cache
levels for 'mem_lvl', by conjuncting with 'or' it composes the multiple
cache levels.  We might need to extend a bit for another field
'mem_lvlnum'.

Agreed that there would have inaccurate issue for statistics, it's fine
for me to use ANY_CACHE in this patch set.

I still think we should consider to extend the memory levels to
demonstrate clear momory hierarchy on Arm archs, I personally like the
definitions for "PEER_CORE", "LCL_CLSTR", "PEER_CLSTR" and "SYS_CACHE",
though these cache levels are not precise like L1/L2/L3 levels, they can
help us to map very well for the cache topology on Arm archs and without
any confusion.  We could take this as an enhancement if you don't want
to bother the current patch set's upstreaming.

> > > > For this data source type and below types, though they indicate
> > > > the snooping happens, but it doesn't mean the data in the cache line
> > > > is in 'modified' state.  If set flag PERF_MEM_SNOOP_HITM, I personally
> > > > think this will mislead users when report the result.
> > > 
> > > I'm of the opposite opinion. If the data wasn't modified, it will likely be
> > > found in the lower-level shared cache and the transaction wouldn't require a
> > > cache-to-cache transfer of the modified data, so the most common case when we
> > > source a line out of another cores cache will be if it was "modifiable" in that
> > > cache. 
> > 
> > Let's still use MOSI protocol as example.  I think there have two
> > cases: on case is the peer cache line is in 'Shared' state and another
> > case is the peer cache line is in 'Owned' state.
> > 
> > Quotes the wiki page for these two cases:
> > 
> > "When the cache block is in the Shared (S) state and there is a
> > snooped bus read (BusRd) transaction, then the block stays in the same
> > state and generates no more transactions as all the cache blocks have
> > the same value including the main memory and it is only being read,
> > not written into."
> > 
> > "While in the Owner (O) state and there is a snooped read request
> > (BusRd), the block remains in the same state while flushing (Flush)
> > the data for the other processor to read from it."
> > 
> > Seems to me, it's reasonable to set HTIM flag when the snooping happens
> > for the cache line line is in the Modified (M) state.
> > 
> > Again, my comment is based on the literal understanding; so please
> > correct if have any misunderstanding at here.
> 
> Per the CMN TRM, "The SLC allocation policy is exclusive for data lines, except
> where sharing patterns are detected," so if a line is shared among caches it
> will likely also be in the SLC (and thus we'd get an L3 hit). 
> 
> If there is one copy of the cache line and that cache line needs to transition
> from one core to another core, I don't believe it matters if it was truly
> modified or not because the core already had permission to modify it and the
> transaction is just as costly (ping ponging between core caches). This is the
> one thing I really want to be able to uniquely identify as any cacheline doing
> this that isn't a lock is a place where optimization is likely possible. 

I understood that your point that if big amount of transitions within
multiple cores hit the same cache line, it would be very likely caused
by the cache line's Modified state so we set PERF_MEM_SNOOP_HITM flag
for easier reviewing.

Alternatively, I think it's good to pick up the patch series "perf c2c:
Sort cacheline with all loads" [1], rather than relying on HITM tag, the
patch series extends a new option "-d all" for perf c2c, so it displays
the suspecious false sharing cache lines based on load/store ops and
thread infos.  The main reason for holding on th patch set is due to we
cannot verify it with Arm SPE at that time point, as the time being Arm
SPE trace data was absent both store ops and data source packets.

I perfer to set PERF_MEM_SNOOP_HIT flag in this patch set and we can
upstream the patch series "perf c2c: Sort cacheline with all loads"
(only needs upstreaming patches 01, 02, 03, 10, 11, the rest patches
have been merged in the mainline kernel).

If this is fine for you, I can respin the patch series for "perf c2c".
Or any other thoughts?

[1] https://lore.kernel.org/lkml/20201213133850.10070-1-leo.yan@linaro.org/

> > > > I prefer we set below fields for ARM_SPE_NV_PEER_CORE:
> > > > 
> > > >         data_src->mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L1;
> > > >         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> > > >         data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> > > > 
> > > > > +		break;
> > > > > +	/*
> > > > > +	 * We don't know if this is L1, L2 but we do know it was a cache-2-cache
> > > > > +	 * transfer, so set SNOOP_HITM
> > > > > +	 */
> > > > > +	case ARM_SPE_NV_LCL_CLSTR:
> > > > 
> > > > For ARM_SPE_NV_LCL_CLSTR, it fetches the data from the shared cache in
> > > > the cluster level, it should happen in L2 cache:
> > > > 
> > > >         data_src->mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L2;
> > > >         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> > > >         data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> > > 
> > > We don't know if this is coming from the cluster cache, or the private L1 or L2
> > > core caches. The description above about why we'll be transferring the line from
> > > cache-to-cache applies here too. 
> > 
> > I think a minor difference between PEER_CORE and LCL_CLSTR is:
> > if data source is PEER_CORE, the snooping happens on the peer core's
> > local cache (Core's L1 or Core's L2 when core contains L2); for the data
> > source LCL_CLSTR, the snooping occurs on the cluster level's cache
> > (cluster's L2 cache or cluster's L3 cache when cluster contains L3).
> > 
> > So can we set both 'L2 | L3' for LCL_CLSTR case?
> 
> Just as above, I believe setting two options will lead to more confusion.
> Additionally, we agreed in the previous discussion that the system cache shall
> be the L3, so i don't see how this helps alleviate any confusion. That said, the
> systems I'm most familiar with never set LCL_CLSTR as a source. 

Okay, let's rollback to PERF_MEM_LVLNUM_ANY_CACHE as cache level for
LCL_CLSTR and PEER_CLSTR.

Thanks,
Leo
