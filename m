Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F26A4E9CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244602AbiC1QsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239181AbiC1QrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7847022B10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D83F86149A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 16:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF43C004DD;
        Mon, 28 Mar 2022 16:44:55 +0000 (UTC)
Date:   Mon, 28 Mar 2022 12:44:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [External] Re: [PATCH] sched/fair: fix broken bandwidth control
 with nohz_full
Message-ID: <20220328124454.08ab6126@gandalf.local.home>
In-Reply-To: <YkHal1m3pnxGoQ1Y@hirez.programming.kicks-ass.net>
References: <20220328110751.39987-1-zhouchengming@bytedance.com>
        <20220328132047.GD8939@worktop.programming.kicks-ass.net>
        <c0465b27-328a-1288-fb50-d4c6321c8b4d@bytedance.com>
        <YkHRmv/OcABIB0wP@hirez.programming.kicks-ass.net>
        <6fc49cff-f8a1-8b09-5a25-a64e5d07d258@bytedance.com>
        <YkHal1m3pnxGoQ1Y@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 17:56:07 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > echo $$ > test/cgroup.procs
> > taskset -c 1 bash -c "while true; do let i++; done"  --> will be throttled  
> 
> Ofcourse.. I'm arguing that bandiwdth control and NOHZ_FULL are somewhat
> mutually exclusive, use-case wise. So I really don't get why you'd want
> them both.

Is it?

One use case I can see for having both is for having a deadline task that
needs to get something done in a tight deadline. NOHZ_FULL means "do not
interrupt this task when it is the top priority task on the CPU and is
running in user space".

Why is it mutually exclusive to have a deadline task that does not want to
be interrupted by timer interrupts?

Just because the biggest pushers of NOHZ_FULL is for those that are running
RT tasks completely in user space and event want to fault if it ever goes
into the kernel, doesn't mean that's the only use case.

Chengming brought up VMs. That's a case to want to control the bandwidth,
but also not interrupt them with timer interrupts when they are running as
the top priority task on a CPU.

-- Steve
