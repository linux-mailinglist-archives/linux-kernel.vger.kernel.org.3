Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8EB50483E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 17:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiDQPz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 11:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiDQPzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 11:55:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD69BBF41
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R2Xc6IsXJOaCLPhfJTDhaB1kmhsuBGq5W8QH4gGbQhQ=; b=OXRIEoC7ocBq6Cjdn/TbQPxDcf
        KcXOZy3URWB6FLiCrSAyVbbjJq8K4m52yp8qWBdZYMK9LKjhnMmRcC4DpkFJT5jSmPIxSAuo1eAN6
        tL9Nd6ch5N7bLOYcEX4vKnKA34g4gfCZwoFID9nEuoQNM6pDoR4nmrepVAd+RD+CrvzkBRnZK0vhV
        B0o6Amp5RNoftyko0KZ6lRj4ljNlUNB0qG15DdIHNZEIue3WT+oJHCbBE+p7Wzz6ELiFeNMN2Oydt
        zKAWR194H6pzIsMrSz7b3Hfw2PhEpE18gEtwFLLAODZVcgZehKYKzUVvrr/25/86OdX5x+lkHluEr
        cxTEKvKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ng7C4-006C0j-Ow; Sun, 17 Apr 2022 15:52:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 070B09861C1; Sun, 17 Apr 2022 17:52:06 +0200 (CEST)
Date:   Sun, 17 Apr 2022 17:52:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christophe de Dinechin <dinechin@redhat.com>, trivial@kernel.org,
        Ben Segall <bsegall@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
Message-ID: <20220417155205.GI2731@worktop.programming.kicks-ass.net>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-2-dinechin@redhat.com>
 <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
 <20220414133050.b820fa45d42de4cfc24db82b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414133050.b820fa45d42de4cfc24db82b@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 01:30:50PM -0700, Andrew Morton wrote:
> On Thu, 14 Apr 2022 17:21:01 +0200 Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > +/* The + 1 below places the pointers within the range of their array */
> > >  #define for_class_range(class, _from, _to) \
> > > -	for (class = (_from); class != (_to); class--)
> > > +	for (class = (_from); class + 1 != (_to) + 1; class--)
> > 
> > Urgh, so now we get less readable code, just because GCC is being
> > stupid?
> > 
> > What's wrong with negative array indexes? memory is memory, stuff works.
> 
> What's more, C is C.  Glorified assembly language in which people do odd
> stuff.
> 
> But this is presumably a released gcc version and we need to do
> something.  And presumably, we need to do a backportable something, so
> people can compile older kernels with gcc-12.
> 
> Is it possible to suppress just this warning with a gcc option?  And if
> so, are we confident that this warning will never be useful in other
> places in the kernel?
> 
> If no||no then we'll need to add workarounds such as these?

-Wno-array-bounds

Is the obvious fix-all cure. The thing is, I want to hear if this new
warning has any actual use or is just crack induced madness like many of
the warnings we turn off.
