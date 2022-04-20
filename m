Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F41509391
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383178AbiDTX0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348970AbiDTX0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:26:07 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454821B7B4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:23:19 -0700 (PDT)
Date:   Wed, 20 Apr 2022 16:23:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650496997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jy2W+tJC4EgncPCr4pDQKFAbzSZdFCIXIUs8dOXozQY=;
        b=slSbIIONuIW5IsYAUO6/Ak9/Uy2xDxxzAglPdGlVUyne4pMkM/92eOlfHPViy6tlnZK58z
        fq9TeH04R6WXGgidq4F/lr/VQTY65o2Js/Sj+Ac7Qph0h4M8U5Gb7DstJ/CVptYaY068v8
        5QJy8+uz8fysOl5azONnmvQ5kYC2EIk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-ID: <YmCV3tZOuB3ATL8O@carbon>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
 <CAHbLzkrOS12pi8WEXyUgYEQ4gy0S9iVrEeBp-2Ypyn=1bthZRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrOS12pi8WEXyUgYEQ4gy0S9iVrEeBp-2Ypyn=1bthZRA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 03:24:49PM -0700, Yang Shi wrote:
> On Fri, Apr 15, 2022 at 5:28 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > There are 50+ different shrinkers in the kernel, many with their own bells and
> > whistles. Under the memory pressure the kernel applies some pressure on each of
> > them in the order of which they were created/registered in the system. Some
> > of them can contain only few objects, some can be quite large. Some can be
> > effective at reclaiming memory, some not.
> >
> > The only existing debugging mechanism is a couple of tracepoints in
> > do_shrink_slab(): mm_shrink_slab_start and mm_shrink_slab_end. They aren't
> > covering everything though: shrinkers which report 0 objects will never show up,
> > there is no support for memcg-aware shrinkers. Shrinkers are identified by their
> > scan function, which is not always enough (e.g. hard to guess which super
> > block's shrinker it is having only "super_cache_scan"). They are a passive
> > mechanism: there is no way to call into counting and scanning of an individual
> > shrinker and profile it.
> >
> > To provide a better visibility and debug options for memory shrinkers
> > this patchset introduces a /sys/kernel/shrinker interface, to some extent
> > similar to /sys/kernel/slab.
> >
> > For each shrinker registered in the system a folder is created. The folder
> > contains "count" and "scan" files, which allow to trigger count_objects()
> > and scan_objects() callbacks. For memcg-aware and numa-aware shrinkers
> > count_memcg, scan_memcg, count_node, scan_node, count_memcg_node
> > and scan_memcg_node are additionally provided. They allow to get per-memcg
> > and/or per-node object count and shrink only a specific memcg/node.
> >
> > To make debugging more pleasant, the patchset also names all shrinkers,
> > so that sysfs entries can have more meaningful names.
> >
> > Usage examples:
> 
> Thanks, Roman. A follow-up question, why do we have to implement this
> in kernel if we just count the objects? It seems userspace tools could
> achieve it too, for example, drgn :-). Actually I did write a drgn
> script for debugging a problem a few months ago, which iterates
> specific memcg's lru_list to count the objects by their state.

Good question! It's because not all shrinkers are lru_list-based
and even some lru_list-based are implementing a custom logic on top of it,
e.g. shadow nodes. So there is no simple way to get the count from
a generic shrinker.

Also I want to be able to reclaim individual shrinkers from userspace
(e.g. to profile how effective the shrinking is).

Thanks!
