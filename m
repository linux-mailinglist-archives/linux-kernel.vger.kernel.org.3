Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E835334C5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbiEYBeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243261AbiEYBel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:34:41 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8BB5AA6D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:34:39 -0700 (PDT)
Date:   Tue, 24 May 2022 18:34:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653442477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B8/phnaKtgKfDvOcCiOCXJv5gwM8GpnHUsSY0v6DfKc=;
        b=kARluN89TOJjD7EJevJu0OEhB9U23y/a/Jw2fQ3+kAEkiPAfOu4BPrr9H9Rx84bZPgzEP4
        Se3bhNkmY+y3CJ3Dwhc9+B2HuRPoxr/YJfo5ep+Yy9mWqpQgsYIwoamnj6gG5ylq1GW9JT
        znPtMJSpmvkXoOnur1aCdODKHkIfMso=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v4] tracing: add 'accounted' entry into output of
 allocation tracepoints
Message-ID: <Yo2Hply/oWWhnpan@carbon>
References: <0c73ce5c-3625-6187-820e-1277e168b3bc@openvz.org>
 <a1e54672-d824-3ee1-cb68-9ceaa46fc70f@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1e54672-d824-3ee1-cb68-9ceaa46fc70f@openvz.org>
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

On Sat, May 21, 2022 at 09:36:54PM +0300, Vasily Averin wrote:
> Slab caches marked with SLAB_ACCOUNT force accounting for every
> allocation from this cache even if __GFP_ACCOUNT flag is not passed.
> Unfortunately, at the moment this flag is not visible in ftrace output,
> and this makes it difficult to analyze the accounted allocations.
> 
> This patch adds boolean "accounted" entry into trace output,
> and set it to 'true' for calls used __GFP_ACCOUNT flag and
> for allocations from caches marked with SLAB_ACCOUNT.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> ---
> v4:
>  1) replaced in patch descripion: "accounted" instead of "allocated"
>  2) added "Acked-by" from Shakeel,
>  3) re-addressed to akpm@
> 
> v3:
>  1) rework kmem_cache_alloc* tracepoints once again,
>     added struct kmem_cache argument into existing templates,
> 	thanks to Matthew Wilcox
>  2) updated according trace_* calls
>  3) added boolean "allocated" entry into trace output,
> 	thanks to Roman
>  4) updated patch subject and description
> 
> v2:
>  1) handle kmem_cache_alloc_node(), thanks to Shakeel
>  2) rework kmem_cache_alloc* tracepoints to use cachep instead
>     of current cachep->*size parameters.
>     NB: kmem_cache_alloc_node tracepoint in SLOB cannot use cachep,
>         and therefore it was replaced by kmalloc_node.
> ---
>  include/trace/events/kmem.h | 38 +++++++++++++++++++++++--------------
>  mm/slab.c                   | 10 +++++-----
>  mm/slab_common.c            |  9 ++++-----
>  mm/slob.c                   |  8 ++++----
>  mm/slub.c                   | 20 +++++++++----------
>  5 files changed, 47 insertions(+), 38 deletions(-)

LGTM

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
