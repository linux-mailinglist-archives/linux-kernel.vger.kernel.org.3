Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BCD4683DC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384618AbhLDJ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384606AbhLDJ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:56:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802D5C061A83
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 01:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tGLykp+au5CIOdzd9b7iCV0CmczZY2uWhRKYlki/d5g=; b=SN36zahzPc2pT9PNSrf7j993VT
        CbVWHPNPg8PD64+3Qrj8jX+81FmKNg88hb8AH+QSChqZ/jdX+NIlg9CKiaaVov+6ndjVTsOQr2iW/
        sN8AqQIdyLNOneqidiZIIW7kJBiT1qGRVYETYxayXXZkcvRBkfj1zFuYVTQ8BgzWUpExgt/BLiGRj
        FG3kMklMnacuAcfsepqqDZmCvl/+R0pWGgJUuO13WSxhDXJK7ormKQiphUiOGUWB1fuqCqImXYykw
        Q12f/SJ7/gMr7dsZeVYOqjba6Oxo5VJmeucd8Tm1ZHk5FSJXwKBPt9SWr8TQnJutMmzKvOJCkayC6
        D5rjrHCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtRjH-00CWMn-SL; Sat, 04 Dec 2021 09:53:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3649098106D; Sat,  4 Dec 2021 10:53:16 +0100 (CET)
Date:   Sat, 4 Dec 2021 10:53:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com, valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/fair: Fix detection of per-CPU kthreads waking
 a task
Message-ID: <20211204095316.GQ16608@worktop.programming.kicks-ass.net>
References: <20211201143450.479472-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201143450.479472-1-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 02:34:50PM +0000, Vincent Donnefort wrote:
> select_idle_sibling() has a special case for tasks woken up by a per-CPU
> kthread, where the selected CPU is the previous one. However, the current
> condition for this exit path is incomplete. A task can wake up from an
> interrupt context (e.g. hrtimer), while a per-CPU kthread is running. A
> such scenario would spuriously trigger the special case described above.
> Also, a recent change made the idle task like a regular per-CPU kthread,
> hence making that situation more likely to happen
> (is_per_cpu_kthread(swapper) being true now).
> 
> Checking for task context makes sure select_idle_sibling() will not
> interpret a wake up from any other context as a wake up by a per-CPU
> kthread.
> 
> Fixes: 52262ee567ad ("sched/fair: Allow a per-CPU kthread waking a task to stack on the same CPU, to fix XFS performance regression")
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> ---

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 945d987246c5..56db4ae85995 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6399,6 +6399,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	 * pattern is IO completions.
>  	 */
>  	if (is_per_cpu_kthread(current) &&
> +	    in_task() &&
>  	    prev == smp_processor_id() &&
>  	    this_rq()->nr_running <= 1) {
>  		return prev;

Hurmph, so now I have two 'trivial' patches from you that touch this
same function and they's conflicting. I've fixed it up, but perhaps it
would've been nice to have them combined in a series or somesuch :-)

