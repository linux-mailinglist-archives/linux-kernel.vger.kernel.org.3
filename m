Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420674B921F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiBPUMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:12:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiBPUMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:12:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF55F213F;
        Wed, 16 Feb 2022 12:12:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB961618EB;
        Wed, 16 Feb 2022 20:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA76DC004E1;
        Wed, 16 Feb 2022 20:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645042354;
        bh=4+4sG9jrtWmb23C1jXUCHo82K3eCfhHwLEUMPi8hHB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hx2okl9vu2Ys6rffyRxIZPhe3lFcePUc+TYLutGA6QTnOvWF5Eh235S2xEqySfKIc
         /Z0jDYUB+SF/nq8MWkHWF8xt/rb8Fu2tNXoFAHIyhS67/9iX8r/6pjAlQxMYxkPBeJ
         dWC2sIcyD+M3XJtnLcvuu2nEiSGqAN94p0VYkDGv5o3DTz1bnai+uJSyuVPd9hUOlH
         933Os4ukzJM5OI7o0EuZnLg6u9i+bINi8RsiWQx6jELIZWlHjE5VWukK2VDb6Xsw84
         Z/O+o2JrWH8X0KebclLw9H3FJJs5c5RU0oD372Sa0Qp/W6TWBLvPfmB8pEA/9GWPhs
         Du9hqWxRbmX6A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 981F4400FE; Wed, 16 Feb 2022 17:12:31 -0300 (-03)
Date:   Wed, 16 Feb 2022 17:12:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>, eranian@google.com
Subject: Re: [PATCH v3 12/22] perf maps: Remove rb_node from struct map
Message-ID: <Yg1ar4/RCCWwQmJ0@kernel.org>
References: <20220211103415.2737789-1-irogers@google.com>
 <20220211103415.2737789-13-irogers@google.com>
 <Yg0FXbzNVpsIpS45@kernel.org>
 <CAP-5=fWkF+J30ixh1iDVGhBBASTgLY9nWbd9ibguRYeyLvpsew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWkF+J30ixh1iDVGhBBASTgLY9nWbd9ibguRYeyLvpsew@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 16, 2022 at 09:36:20AM -0800, Ian Rogers escreveu:
> On Wed, Feb 16, 2022 at 6:08 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Fri, Feb 11, 2022 at 02:34:05AM -0800, Ian Rogers escreveu:
> > > struct map is reference counted, having it also be a node in an
> > > red-black tree complicates the reference counting.
> >
> > In what way?
> >
> > If I have some refcounted data structure and I want to add it to some
> > container (an rb_tree, a list, etc) all I have to do is to grab a
> > refcount when adding and dropping it after removing it from the list.
> >
> > IOW, in other words it is refcounted so that we can add it to a
> > red-black tree, amongst other uses.
> 
> Thanks Arnaldo. So I'm not disputing that you can make reference
> counted collections. With reference counting every reference should
> have a count associated with it. So when symbol.c is using the list, a
> node may be referenced from a prev and a next pointer, so being in the
> list requires a reference count of 2. When you find something in the

Humm, just one reference is needed for being in a list, removing from
the list needs locking the access to the list, removing the object,
unlocking the list and then dropping the access for the then out of the
list refcounted object, no?

> list which reference count is that associated with? It doesn't matter
> normally as you'd increment the reference count again and return that.
> In the perf code find doesn't increment a reference count so I want to

I'd say point that out and fix the bug, if you will return an object
from a list that is refcounted, grab the refcount before dropping the
list lock and then return it, knowing the lookup user will have a
refcount that will keep that object alive.

> return the "get" that belongs to the list. That's "get" singular,
> hence wanting to add in the pointer indirection that incurs cost. To
> make insertion and deletion work properly on list with a reference
> count means reworking list.h.
> 
> The rbtree is the same problem only more-so, as you need pointers for
> parent, left and right child.
> 
> > > Switch to having a map_rb_node which is a red-block tree node but
> > > points at the reference counted struct map. This reference is
> > > responsible for a single reference count.
> >
> > This makes every insertion incur in an allocation that has to be
> > checked, etc, when we know that maps will live in rb_trees, so having
> > the node structure allocated at the same time as the map is
> > advantageous.

perf tries to mimic kernel code, but multithreading didn't come at the
very beginning, so, yeah, there are bugs and inconsistencies, which we
should fix.

This discussion is how to do it, attempts like Masami's years ago
uncovered problems that got fixed, your current attempt is also
uncovering bugs and those are getting fixed, which is super cool.

> So this pattern is common in other languages, the default kernel style
> is what at Google gets called invasive - you put the storage for list
> nodes, reference counts, etc. into the referenced object itself. This
> lowers the overhead within the struct, and I don't disagree it adds a
> cost to insertion, unless maps are shared which isn't a use-case we
> have at the moment. So this change is backing out an optimization, but
> frankly fixing this properly is a much bigger overhaul than this
> already big overhaul and I don't think losing the optimization is
> really costing that much performance - a memory allocation costs in
> the region of 40 cycles with an optimized implementation like
> tcmalloc. We also don't use the invasive style for maps_by_name, it is
> just a sorted array.
> 
> A side note, I see a lot of overhead in symbol allocation and part of
> that is the size of the two invasive rbtree nodes (2 * 3 * 8 bytes =
> 48bytes). Were the symbols just referenced by a sorted array, like
> maps_by_name, insertion and sorting would still be O(n*log(n)) but
> we'd reduce the memory usage to a third. rbtree is a cool data
> structure, but I think we could be over using it.

Right, numbers talk, so it would be really nice to use, humm, perf to
measure these changes, to help assess the impact and sometimes accept
things at first "ugly" versus performance improvements.
 
> > We don't have to check if adding a data structure to a rbtree works, as
> > all that is needed is already preallocated.
> 
> The issue here is that a find, or similar, wants to pass around
> something that is owned by a list or an rbtree. We can have the idea
> of ownership by adding a token/cookie and passing that around
> everywhere, it gets problematic then to spot use after put and I think
> that approach is overall more invasive to the APIs than what is in
> these changes.

> A better solution can be to keep the rbtree being invasive and at all
> the find and similar routines, make sure a getted version is returned
> - so the code outside of maps is never working with the rbtree's
> reference counted version. The problem with this is that it is an
> overhaul to all the uses of map. The reference count checker would
> find misuse but again it'd be a far large patch series than what is
> here - that is trying to fix the code base as it is.

I've been trailing on the discussion with Masami, so what you want is to
somehow match a get with a put by passing a token returned by a get to
the put?

Wrt patch queue size, we can try to reduce it to series of at most 10
patches, that do leg work, rinse, repeat, I recently saw a discussion on
netdev, with Jakub Kicinski asking for patchsets to be limited to under
10 patches for this exact same reason.

I usually try to cherry pick as much as possible from a series, while it
being discussed, so that the patch submitter don't have to suffer too
much with keeping a long series building.

I'm now willing and able to process things faster, that should help too,
I hope.
 
> I think the having our cake and eating solution (best performance +
> checking) is that approach, but we need to get to a point where
> checking is working. So if we focus on (1) checking and fixing those
> bugs (the changes here), then (2) change the APIs so that everything
> is getted and fix the leaks that introduces, then (3) go back to being
> invasive I think we get to that solution. I like step (2) from a
> cleanliness point-of-view, I'm fine with (3) I'm just not sure anybody
> would notice the performance difference.

I'll continue looking at what you guys did to try to get up to speed and
contribute more to this effort, please bear with me a bit more.

- Arnaldo
