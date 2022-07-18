Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEBA577F02
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiGRJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiGRJvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:51:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D141B794
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kon/fK8BPMtzsiOELbKXX7wncmQ1JKZ9esMnfRs7OVU=; b=oeox66L7hcw60Qn7lR+ZZ/Nyu7
        nq4vJxZY9YpriZJrDsig4wNzbCdb2VM96E2x60y6KJIoPrKiXadpk7gw5ap9wLsE0ty0PGq6ABf2r
        u0QR+hDQBqFJtZFb4aSgTqN8ITrzk8RQ/v/CPT7PUZI43dR6jroQ+TVYcTVtqRJgyQ255jCwW7Wuv
        ncM7KS/XX9CWMS0DkUPS4B7HfjaH6mZEbKLsx+ScNTb/VG/HS+vbVMi+hPI/DyLUN1Q0RYW2X/lqZ
        JN8Bp5xaNwykdXiwjDSftZfJadZ8spdMfzPMGwmQG8OhdJwYTyNtAyMcgdGDSDKGvfCMh6KCDbCTd
        I2AOuqeA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDNPT-004nc3-AM; Mon, 18 Jul 2022 09:51:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC717980166; Mon, 18 Jul 2022 11:51:26 +0200 (CEST)
Date:   Mon, 18 Jul 2022 11:51:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: schedstat false counting of domain load_balance() tried to move
 one or more tasks failed
Message-ID: <YtUtHqig/SNka/XO@worktop.programming.kicks-ass.net>
References: <20220712215259.6cb28bed@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712215259.6cb28bed@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 09:52:59PM -0400, Steven Rostedt wrote:
> I've been tasked to analyze the /proc/schedstat file to determine
> appropriate metrics to look after in production. So I'm looking at both the
> documentation and the code that generates it.
> 
> From the documentation at https://docs.kernel.org/scheduler/sched-stats.html
> 
> (and Documentation/scheduler/sched-stats.rst for those of you that are
> allergic to html)

I'm allergic to both, it's plain text or bust.

>        3)  # of times in this domain load_balance() tried to move one or
>            more tasks and failed, when the cpu was idle

> Thus, if we get to that check for (busiest->nr_running > 1) and fail, then
> we will increment that counter incorrectly.
> 
> Do we care? Should it be fixed? Should it be documented?

*shrug*, I suppose we can fix. People using this stuff are the sort that
are likely to read documentation instead of code.

At the same time; I suspect it's been 'broken' like forever, so who
knows what people are actually expecting today.
