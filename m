Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5797529361
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349630AbiEPWI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238952AbiEPWI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:08:57 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3A53BFA1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:08:56 -0700 (PDT)
Date:   Mon, 16 May 2022 15:08:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652738934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AzwHC12xjer9Ig+ea0Xvx8LodsMoE3YZd88jEGNk3hU=;
        b=XS6eR1qE5Av1Flrhjy4lsyvXpKirt7flwE3g7l1chuZDgJ+C8qmWOD2Yn/3Bdk1M5oPMs7
        zKKDa6iCReM2bd2aEyyV7XETDdLlZTF81rx0FBWFGdAhkEbHng5roiyLVByRRFBi8X5Yfv
        xaGPBB3ola+UMgkCgfn2uMSts1ie8jY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Shakeel Butt <shakeelb@google.com>, Vasily Averin <vvs@openvz.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, kernel@openvz.org,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH] tracing: add ACCOUNT flag for allocations from marked
 slab caches
Message-ID: <YoLLcFFi5UXFEIYg@carbon>
References: <1fd21e25-b095-e055-fc2e-abda640a0575@openvz.org>
 <CALvZod6wmxxigoLVg8Q+upqOkyoh+nPuVT0yx_XTbu8RXYYFgA@mail.gmail.com>
 <8eccb3bc-e6b1-354b-e1de-bd3d896dcb35@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eccb3bc-e6b1-354b-e1de-bd3d896dcb35@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:41:27PM +0200, Vlastimil Babka wrote:
> On 5/16/22 21:10, Shakeel Butt wrote:
> > On Mon, May 16, 2022 at 11:53 AM Vasily Averin <vvs@openvz.org> wrote:
> >>
> >> Slab caches marked with SLAB_ACCOUNT force accounting for every
> >> allocation from this cache even if __GFP_ACCOUNT flag is not passed.
> >> Unfortunately, at the moment this flag is not visible in ftrace output,
> >> and this makes it difficult to analyze the accounted allocations.
> >>
> >> This patch adds the __GFP_ACCOUNT flag for allocations from slab caches
> >> marked with SLAB_ACCOUNT to the ftrace output.
> >>
> >> Signed-off-by: Vasily Averin <vvs@openvz.org>
> >> ---
> >>  mm/slab.c | 3 +++
> >>  mm/slub.c | 3 +++
> >>  2 files changed, 6 insertions(+)
> >>
> >> diff --git a/mm/slab.c b/mm/slab.c
> >> index 0edb474edef1..4c3da8dfcbdb 100644
> >> --- a/mm/slab.c
> >> +++ b/mm/slab.c
> >> @@ -3492,6 +3492,9 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
> > 
> > What about kmem_cache_alloc_node()?
> > 
> >>  {
> >>         void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
> >>
> >> +       if (cachep->flags & SLAB_ACCOUNT)
> > 
> > Should this 'if' be unlikely() or should we trace cachep->flags
> > explicitly to avoid this branch altogether?
> 
> Hm I think ideally the tracepoint accepts cachep instead of current
> cachep->*size parameters and does the necessary extraction and
> modification in its fast_assign.

+1 for fast_assign

Changing flags just for tracing looks a bit excessive.
