Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8974735ED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242859AbhLMUac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbhLMUac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:30:32 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD242C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mGLHg28WdpttdEw3VFAlEewdwvHk3gFJbvUge2MYsek=; b=d47+rQhZHU/uissNzX7MXbsPw6
        xPeILuNHMYpino5T4RcJBn2zfCBnQEg01kVwwAX9VMmcdT3UfcEHHNzevJ0CRc4iBcVNcEtVWTu9Z
        y9xllQecLB/mAkmJMzbb+6wg4otAwEmdBoK4xWeHiF1/HjO91ayBui0fkPLLSZUdWZd/rwL5/sfxV
        DucDX+Lh0DXHnj/2SgKV0n+ERIkYNWedtcBc9uLrxLnMx/FZ8uRwyfOF2TfiNeu5UVZuELzKpvOQT
        EljDG0fRmOBAxRa79TI9pTqthr+aOza/6rcFX25r0PJfJhU3BLQKaDoj5vTaXb2fhfgtni1AM9ARa
        e6LVzyfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwrxh-001BJ5-4U; Mon, 13 Dec 2021 20:30:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C206981767; Mon, 13 Dec 2021 21:30:16 +0100 (CET)
Date:   Mon, 13 Dec 2021 21:30:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        kernel test robot <lkp@intel.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v2] perf/core: Fix cgroup event list management
Message-ID: <20211213203016.GB16608@worktop.programming.kicks-ass.net>
References: <20211213065936.1965081-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213065936.1965081-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 10:59:36PM -0800, Namhyung Kim wrote:
> The active cgroup events are managed in the per-cpu cgrp_cpuctx_list.
> This list is accessed from current cpu and not protected by any locks.
> But from the commit ef54c1a476ae ("perf: Rework
> perf_event_exit_event()"), this assumption does not hold true anymore.
> 
> In the perf_remove_from_context(), it can remove an event from the
> context without an IPI when the context is not active.  I think it

"I tihnk" just doesn't cut it. That means I have to completely reverse
engineer your patch and it's assumptions. Which is more work for me :-(

> assumes task event context, but it's possible for cpu event context
> only with cgroup events can be inactive at the moment - and it might
> become active soon.
> 
> If the event is enabled when it's about to be closed, it might call
> perf_cgroup_event_disable() and list_del() with the cgrp_cpuctx_list
> on a different cpu.
> 
> This resulted in a crash due to an invalid list pointer access during
> the cgroup list traversal on the cpu which the event belongs to.
> 
> The following program can crash my box easily..

Unless that's already public, you've just given the script kiddos ammo,
surely we don't need that.

> Let's use IPI to prevent such crashes.

Let's just not do random things and hope stuff 'works'. Either it is
correct or it is not.

> Similarly, I think perf_install_in_context() should use IPI for the
> cgroup events too.

Let's be sure, ok?

> Reported-by: kernel test robot <lkp@intel.com>  # for build error

That's complete garbage, please don't do that.

> Cc: Marco Elver <elver@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v2) simply use IPI for cgroup events
> 
>  kernel/events/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 30d94f68c5bd..9460c083acd9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2388,7 +2388,7 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
>  	 * event_function_call() user.
>  	 */
>  	raw_spin_lock_irq(&ctx->lock);
> -	if (!ctx->is_active) {
> +	if (!ctx->is_active && !is_cgroup_event(event)) {
>  		__perf_remove_from_context(event, __get_cpu_context(ctx),
>  					   ctx, (void *)flags);
>  		raw_spin_unlock_irq(&ctx->lock);
> @@ -2857,11 +2857,14 @@ perf_install_in_context(struct perf_event_context *ctx,
>  	 * perf_event_attr::disabled events will not run and can be initialized
>  	 * without IPI. Except when this is the first event for the context, in
>  	 * that case we need the magic of the IPI to set ctx->is_active.
> +	 * Similarly, cgroup events for the context also needs the IPI to
> +	 * manipulate the cgrp_cpuctx_list.
>  	 *
>  	 * The IOC_ENABLE that is sure to follow the creation of a disabled
>  	 * event will issue the IPI and reprogram the hardware.
>  	 */
> -	if (__perf_effective_state(event) == PERF_EVENT_STATE_OFF && ctx->nr_events) {
> +	if (__perf_effective_state(event) == PERF_EVENT_STATE_OFF &&
> +	    ctx->nr_events && !is_cgroup_event(event)) {
>  		raw_spin_lock_irq(&ctx->lock);
>  		if (ctx->task == TASK_TOMBSTONE) {
>  			raw_spin_unlock_irq(&ctx->lock);
> 
> base-commit: 73743c3b092277febbf69b250ce8ebbca0525aa2

What's junk like that doing ?
