Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6BF4ECC62
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350542AbiC3SiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349966AbiC3S0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:26:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50EA4A3F6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qPLFDdi3cflTc5afisPgbeWEWhGSsYjDiLNJOrGcx9E=; b=fpwcblBTruVVe3EHRfYq6CHBlb
        HKqEixQfOm+ogzU+N3lXf6YcxR/95c+ZJLfB3GCxX/lYy+LKJ585Cjh/noeLWG5Ymbzp0Rah7hTzA
        ZF0pQ7753hp5Dp5hZxL8UobeXQBpL5gJ2v4dHY0Z9vacIZJcwSUKpB7XKdupLXWFA9hr/zke3QxUj
        7rnAZlBOUhvdETwh4zywxwoF/CsVD88yu2Rw2IihHJtK0lQ2P8hD09KZsgNI1crJgWg7a7QUGcFKm
        TxVqFe212JNZiPIt0qw7fustFtxpxRZuHAXWS+nsMpGooCEaYU2OUjIKUK1H3/Kv5QBbn97cKWydA
        ll2nei2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZcyg-001TT6-TB; Wed, 30 Mar 2022 18:23:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5336298695C; Wed, 30 Mar 2022 20:23:27 +0200 (CEST)
Date:   Wed, 30 Mar 2022 20:23:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [External] Re: [PATCH] sched/fair: fix broken bandwidth control
 with nohz_full
Message-ID: <20220330182327.GO8939@worktop.programming.kicks-ass.net>
References: <20220328110751.39987-1-zhouchengming@bytedance.com>
 <20220328132047.GD8939@worktop.programming.kicks-ass.net>
 <c0465b27-328a-1288-fb50-d4c6321c8b4d@bytedance.com>
 <YkHRmv/OcABIB0wP@hirez.programming.kicks-ass.net>
 <6fc49cff-f8a1-8b09-5a25-a64e5d07d258@bytedance.com>
 <YkHal1m3pnxGoQ1Y@hirez.programming.kicks-ass.net>
 <20220328124454.08ab6126@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328124454.08ab6126@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 12:44:54PM -0400, Steven Rostedt wrote:
> On Mon, 28 Mar 2022 17:56:07 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > echo $$ > test/cgroup.procs
> > > taskset -c 1 bash -c "while true; do let i++; done"  --> will be throttled  
> > 
> > Ofcourse.. I'm arguing that bandiwdth control and NOHZ_FULL are somewhat
> > mutually exclusive, use-case wise. So I really don't get why you'd want
> > them both.
> 
> Is it?
> 
> One use case I can see for having both is for having a deadline task that
> needs to get something done in a tight deadline. NOHZ_FULL means "do not
> interrupt this task when it is the top priority task on the CPU and is
> running in user space".

This is absolute batshit.. It means no such thing. We'll happily wake
another task to this CPU and re-enable the tick any instant.

Worse; the use-case at hand pertains to cfs bandwidth control, which
pretty much guarantees there *will* be an interrupt.

> Why is it mutually exclusive to have a deadline task that does not want to
> be interrupted by timer interrupts?

This has absolutely nothing to do with deadline tasks, nada, noppes.

> Just because the biggest pushers of NOHZ_FULL is for those that are running
> RT tasks completely in user space and event want to fault if it ever goes
> into the kernel, doesn't mean that's the only use case.

Because there's costs associated with the whole thing. system entry/exit
get far more expensive. It just doesn't make much sense to use NOHZ_FULL
if you're not absoultely limiting system entry.

> Chengming brought up VMs. That's a case to want to control the bandwidth,
> but also not interrupt them with timer interrupts when they are running as
> the top priority task on a CPU.

It's CFS, there is nothing top priority about that.
