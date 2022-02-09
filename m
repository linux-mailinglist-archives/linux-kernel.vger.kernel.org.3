Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F5B4AEB97
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbiBIH5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiBIH5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:57:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD233C05CB81
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Y7idfxjg71JcrnNlh0c96qgxdSZw0P6CmSB7ivwuYL4=; b=xYZbiWaDP9TiE5Y+w8lp1mCYiZ
        5TOHgWBgUGZu6/ZGofgEGJ7m7Ww3BK8enABXIMJOmcgAYZBDiiNfRQGdiboYBPQydv3sDzCLg4E1p
        UovDNPvgbqAp9Rx8KOipilny2ko3dUYPOotixu0f0Fktn2sDET+n0Ix9Pioo2gcA7gmn83IDSdd0f
        csqP31YknsiZZZVfdoZvnrcElavppCuqwAP3xtcCjnfzUaP094JStBXX5cv49YXbf7BbegxOo99Xx
        y8zl8zhe8rTwnWKd/j0DWLaHsCFTud0Ehsg6YHmrjtJn4xRfzYBWyggOMzbFLlRPZLWtyF/9zJzl+
        udcERr+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHhqb-00GYc1-Qj; Wed, 09 Feb 2022 07:57:05 +0000
Date:   Tue, 8 Feb 2022 23:57:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] smp: Wake ksoftirqd on PREEMPT_RT instead
 do_softirq().
Message-ID: <YgNz0caX70zhaP1F@infradead.org>
References: <YgKgL6aPj8aBES6G@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgKgL6aPj8aBES6G@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 05:54:07PM +0100, Sebastian Andrzej Siewior wrote:
> The softirq implementation on PREEMPT_RT does not provide do_softirq(). The
> softirq can not be handled directly here because migration_cpu_stop() is
> invoked with disabled preemption/ interrupts.
> 
> A known user of scheduling softirqs from a remote function call is the block
> layer. It won't happen on PREEMPT_RT because it doesn't make sense for
> latency/ performance reasons and is disabled. Nevertheless this should
> be handled in case of a new user pops up rather than simply ignoring it.
> 
> Waking ksoftirqd unconditionally can be problematic if softirqs were already
> pending but not yet handled. This can happen since the migration thread
> is running at a high priority and able to preempt a threaded-interrupt.
> The woken-up ksoftirqd would catch-up all pending (and later raised)
> softirqs which is not desired on PREEMPT_RT since it is no longer
> handled where it has been originally raised. This in turn delays the
> actual processing until a SCHED_OTHER task can run.
> 
> Wake the softirq thread on PREEMPT_RT if a remote function call raised
> softirqs. Add warning in this case since this condition is not desired.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v2…v3:
>    - Only wake ksoftirqd if the softirqs were raised wthin
>      flush_smp_call_function_queue().
>    - Add a warning in the wake case.
> v1…v2: Drop an empty line.
> 
>  kernel/smp.c |   21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> ---
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -691,10 +691,25 @@ void flush_smp_call_function_from_idle(v
>  	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->idle, CFD_SEQ_NOCPU,
>  		      smp_processor_id(), CFD_SEQ_IDLE);
>  	local_irq_save(flags);
> -	flush_smp_call_function_queue(true);
> -	if (local_softirq_pending())
> -		do_softirq();
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {

I still absolutely hate these pointless negations in simple if
statements.
