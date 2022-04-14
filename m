Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0AE501CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346315AbiDNUdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240868AbiDNUdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:33:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BB8AAC94
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 597A2B82984
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741C7C385A1;
        Thu, 14 Apr 2022 20:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649968252;
        bh=F2sUCe9gi4kdAwiM+xd38Vkiw3sg5LfikwjEod6T5no=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q5F4ba7EW90B8hMcPBLkQdGZLNF5JCeKwv0NHSuDHMXFMJEnW8CWNaqRStzcHyJUn
         3kpUYKCn7E/ZRHyMF675pgeheJvViUCQvqn6mGJ5CxSqXwAQKgK7rRXqVFkfIkzA/q
         6x3lGssjUCKjaeI0vsKoavc0sJLRCPyYhNZs+lHg=
Date:   Thu, 14 Apr 2022 13:30:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-Id: <20220414133050.b820fa45d42de4cfc24db82b@linux-foundation.org>
In-Reply-To: <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
References: <20220414150855.2407137-1-dinechin@redhat.com>
        <20220414150855.2407137-2-dinechin@redhat.com>
        <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 17:21:01 +0200 Peter Zijlstra <peterz@infradead.org> wrote:

> > +/* The + 1 below places the pointers within the range of their array */
> >  #define for_class_range(class, _from, _to) \
> > -	for (class = (_from); class != (_to); class--)
> > +	for (class = (_from); class + 1 != (_to) + 1; class--)
> 
> Urgh, so now we get less readable code, just because GCC is being
> stupid?
> 
> What's wrong with negative array indexes? memory is memory, stuff works.

What's more, C is C.  Glorified assembly language in which people do odd
stuff.

But this is presumably a released gcc version and we need to do
something.  And presumably, we need to do a backportable something, so
people can compile older kernels with gcc-12.

Is it possible to suppress just this warning with a gcc option?  And if
so, are we confident that this warning will never be useful in other
places in the kernel?

If no||no then we'll need to add workarounds such as these?
