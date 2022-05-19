Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E9452D147
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiESLQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiESLQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:16:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032E552B37
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=fwaHgMGpyKxUjfrphlTtFfZFCA36vjc6kx8Yyplbjpk=; b=RYDCMXNpjIlJnbpR6ajxa55hj9
        BLxgLS+TW0KAVxKV4JaOWIwnjIdnLelGBL0amhS5m4Bj6RzVX88ZYv4ZnTYLQU2D2AXrBEXNbTXmE
        5UPxBttFRv++AX6J1pfNJpVRGkFI41IgVezP8l3BQ65qAPDRGY3AZChhhVCtt/FZYt8FN/YmI5mcE
        9UktynESLujWWXkmY4qq4fRUo+xa5bkKIefFafuZGBa7CHAxFJpl6jkuGN6nW7Rgs/GQ7d+UBzTFE
        aSXTOimSk22J98oidhup2X9gksk6VIYTjwwM0wx5BlnZzA93g8H6XrtmdIIBJwIA09gPKh0FyI3/P
        YS2nOp9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nre8Y-0020tX-GR; Thu, 19 May 2022 11:16:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBE9F980E0B; Thu, 19 May 2022 13:16:08 +0200 (CEST)
Date:   Thu, 19 May 2022 13:16:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe de Dinechin <christophe@dinechin.org>
Cc:     Christophe de Dinechin <dinechin@redhat.com>, trivial@kernel.org,
        Ben Segall <bsegall@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 1/3] sched/headers: Fix compilation error with GCC 12
Message-ID: <20220519111608.GF2578@worktop.programming.kicks-ass.net>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-2-dinechin@redhat.com>
 <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
 <5AEAD35F-10E2-41A3-8269-E8358160D33B@dinechin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5AEAD35F-10E2-41A3-8269-E8358160D33B@dinechin.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 04:07:43PM +0200, Christophe de Dinechin wrote:

> >> extern struct sched_class __begin_sched_classes[];
> >> extern struct sched_class __end_sched_classes[];
> >> 
> >> -#define sched_class_highest (__end_sched_classes - 1)
> >> +/*
> >> + * sched_class_highests is really __end_sched_classes - 1, but written in a way
> >> + * that makes it clear that it is within __begin_sched_classes[] and not outside
> >> + * of __end_sched_classes[].
> >> + */
> >> +#define sched_class_highest (__begin_sched_classes + \
> >> +			     (__end_sched_classes - __begin_sched_classes - 1))
> >> #define sched_class_lowest  (__begin_sched_classes - 1)
> >> 
> >> +/* The + 1 below places the pointers within the range of their array */
> >> #define for_class_range(class, _from, _to) \
> >> -	for (class = (_from); class != (_to); class--)
> >> +	for (class = (_from); class + 1 != (_to) + 1; class--)
> > 
> > Urgh, so now we get less readable code,
> 
> You consider the original code readable? 

Yeah, because: x + y - x - 1 == y - 1, so wth would you want to write it
with the x on. That's just silly.

> It actually relies on a
> precise layout that is not enforced in this code, not even documented,
> but actually enforced by the linker script.

It has a comment pointing at the linker script, and we have:

	/* Make sure the linker didn't screw up */
	BUG_ON(&idle_sched_class + 1 != &fair_sched_class ||
	       &fair_sched_class + 1 != &rt_sched_class ||
	       &rt_sched_class + 1   != &dl_sched_class);
#ifdef CONFIG_SMP
	BUG_ON(&dl_sched_class + 1 != &stop_sched_class);
#endif

On boot to verify the layout is as we expect.

> > just because GCC is being
> > stupid?
> 
> I think that GCC is actually remarkably smart there. It tells you
> that you are building pointers to A[] from B[], when there is a legit
> way to say that the pointer is in A[] (which is what my patch does)

We build with -fno-strict-aliasing, it must not assume anything like
that, unless restrict is used.

In this case, they're not two objects but the same one. Just because
linker script can't really get us a sensible array definition.

> > What's wrong with negative array indexes? memory is memory, stuff works.
> 
> What’s wrong is that the compiler cannot prove theorems anymore.
> These theorems are used to optimise code. When you write -1[B], the
> compiler cannot optimise based on knowing this refers to A[B-A-1].
> 
> While at first, you might think that disabling a warning is a win,
> what comes next is the compiler optimizing in a way you did not
> anticipate, mysterious bugs showing up, and/or having to turn off some
> potentially useful optimisation.

We're usually fairly quick to call a compiler broken if doesn't do what
we want it to. Dodgy optimizations go out the window real fast.
