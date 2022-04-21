Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8AD50992A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385789AbiDUHfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343901AbiDUHf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:35:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD38D11A21
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nWKrOVONxRO0WSObJee+zFs6W4ugiC3GFnYlyVVnV4Y=; b=IMvNMRuK6bK24C75DGnVR8yDTe
        L1C3xGGpNCkk7cE9PZWy0E9MJ468LszeOST4RZIzmVQiRG3vb5N08oD1KLttCoXCIXiJmZfPd6RK0
        4eFy8+l5CZCx+LWEbzPX6IYMnVvdi7GEh49y9u+gONsNulmf+DX4g4HRo6i7edF0DgyTcYt8bssNM
        nt85+OS3Z897K8z7ZreZpPMldBppnlxsauvrSUzlrVMv6/d1xDVaoc3iFMGmOxprkPxCbRb7nOnJa
        kjZYOdLFIb2OgHx/DrNIakRIYy6je3kWwb2+nNu+WLbbr/s5r7F576CBFgh9pT4qaygybEW3yWFdv
        84UU8Jzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhRIS-004rlh-2H; Thu, 21 Apr 2022 07:32:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 98EC59861A4; Thu, 21 Apr 2022 09:32:11 +0200 (CEST)
Date:   Thu, 21 Apr 2022 09:32:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe de Dinechin <dinechin@redhat.com>,
        trivial@kernel.org, Ben Segall <bsegall@google.com>,
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
Message-ID: <20220421073211.GJ2731@worktop.programming.kicks-ass.net>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-2-dinechin@redhat.com>
 <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
 <20220414133050.b820fa45d42de4cfc24db82b@linux-foundation.org>
 <20220417155205.GI2731@worktop.programming.kicks-ass.net>
 <202204201117.F44DCF9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204201117.F44DCF9@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 11:45:05AM -0700, Kees Cook wrote:

> > -Wno-array-bounds
> 
> Please no; we just spent two years fixing all the old non-flexible array
> definitions and so many other things fixed for this to be enable because
> it finds actual flaws (but we turned it off when it was introduced
> because of how much sloppy old code we had).
> 
> > Is the obvious fix-all cure. The thing is, I want to hear if this new
> > warning has any actual use or is just crack induced madness like many of
> > the warnings we turn off.
> 
> Yes, it finds real flaws. And also yes, it is rather opinionated about
> some "tricks" that have worked in C, but frankly, most of those tricks
> end up being weird/accidentally-correct and aren't great for long-term
> readability or robustness. Though I'm not speaking specifically to this
> proposed patch; I haven't looked closely at it yet.

So the whole access outside object is UB thing in C is complete rubbish
from an OS perspective. The memory is there and there are geniune uses
for it.

And so far, the patches I've seen for it make the code actively worse.
So we need a sane annotation to tell the compiler to shut up already
without making the code an unreadable mess.
