Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8E4525BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377404AbiEMGhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377387AbiEMGhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:37:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C79969B47
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KAHLDr1Q/w2FNHreQXjS9VMKVRbPGfl4DI6ipsPBBHs=; b=Rc5soRIu94PFCK89NHxJNNhGVL
        3dkojjFFcK/XsWC9AQKDs6hQyI9RSE9PDRnqa/kdbqP4ccn+gYmrItosEivuos5I2JhI+aqVXUnIk
        mU/F14bk9JuwZq8I2G1nFvE3aa5NL0oBZSwl38vEErkjXIHTxXdaXkS5demTfTdznWeHktJ/6jYQE
        4a0TIInknMX0zQBmWhBrr+AhDGe3Xsd3DUp2XC+IL9Ik7x3waVoIyFbftdNgE8yfgBBqdp3X1beOs
        mo1f7UTQIvE95WwFaiaht893B/ppVxFrIMYs5eusYFfky+kYAQ+o6NLBlD6bO1kOuLg/yrrFSRm0i
        /4xN5KnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npOvc-00774O-60; Fri, 13 May 2022 06:37:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FBAA980F9A; Fri, 13 May 2022 08:37:29 +0200 (CEST)
Date:   Fri, 13 May 2022 08:37:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched: Queue task on wakelist in the same llc if the
 wakee cpu is idle
Message-ID: <20220513063729.GF76023@worktop.programming.kicks-ass.net>
References: <20220513062427.2375743-1-dtcccc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513062427.2375743-1-dtcccc@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 02:24:27PM +0800, Tianchen Ding wrote:
> We notice the commit 518cd6234178 ("sched: Only queue remote wakeups
> when crossing cache boundaries") disabled queuing tasks on wakelist when
> the cpus share llc. This is because, at that time, the scheduler must
> send IPIs to do ttwu_queue_wakelist.

No; this was because of cache bouncing.

> Nowadays, ttwu_queue_wakelist also
> supports TIF_POLLING, so this is not a problem now when the wakee cpu is
> in idle polling.
> 
> Benefits:
>   Queuing the task on idle cpu can help improving performance on waker cpu
>   and utilization on wakee cpu, and further improve locality because
>   the wakee cpu can handle its own rq. This patch helps improving rt on
>   our real java workloads where wakeup happens frequently.
> 
> Does this patch bring IPI flooding?
>   For archs with TIF_POLLING_NRFLAG (e.g., x86), there will be no
>   difference if the wakee cpu is idle polling. If the wakee cpu is idle
>   but not polling, the later check_preempt_curr() will send IPI too.
> 
>   For archs without TIF_POLLING_NRFLAG (e.g., arm64), the IPI is
>   unavoidable, since the later check_preempt_curr() will send IPI when
>   wakee cpu is idle.
> 
> Benchmark:
> running schbench -m 2 -t 8 on 8269CY:
> 
> without patch:
> Latency percentiles (usec)
>         50.0000th: 10
>         75.0000th: 14
>         90.0000th: 16
>         95.0000th: 16
>         *99.0000th: 17
>         99.5000th: 20
>         99.9000th: 23
>         min=0, max=28
> 
> with patch:
> Latency percentiles (usec)
>         50.0000th: 6
>         75.0000th: 8
>         90.0000th: 9
>         95.0000th: 9
>         *99.0000th: 10
>         99.5000th: 10
>         99.9000th: 14
>         min=0, max=16
> 
> We've also tested unixbench and see about 10% improvement on Pipe-based
> Context Switching, and no performance regression on other test cases.
> 
> For arm64, we've tested schbench and unixbench on Kunpeng920, the
> results show that,

What is a kunpeng and how does it's topology look?

> the improvement is not as obvious as on x86, and
> there's no performance regression.

x86 is wide and varied; what x86 did you test?
