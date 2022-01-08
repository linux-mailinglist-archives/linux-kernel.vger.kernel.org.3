Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C6E487FCF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiAHADP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiAHADN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:03:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAAFC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 16:03:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C30461FAD
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 00:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A42C36AE5;
        Sat,  8 Jan 2022 00:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641600192;
        bh=I1RE0CAYdqfqkrIQHATpl4qU99Y7HFm//09IbfqvcB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ey5Iy0qfHQGiFHFV0qPis3tBMmiizR3q8uQEK43TrqEGBTutEh1d028uHBe4TsPgj
         adkK/dxhvQRJQygsqTe1FfXOLY4f/NtEnE4ELB1RXkx6LptZMvHfIIcBxV/+30n+YN
         X57l+WszviCoW1bUiBZUQMLiIWL20o09NShTP9hOi2hWxxPLvod1Fp4sQfFxsOYHc2
         oyQMMUTIiRS1tg38iKDauMG90Uv5gnPA3ysSL/wl9p6QG6VMOY07i3Qe5sW0Q7lwv6
         bawSKIBFO5iBQcg8f1pUSNT7NS5MSVTeoyxEsEXvs7hspPEIm6AMFwdmgZZPR9EIn4
         A/7f7kuUP2CSg==
Date:   Sat, 8 Jan 2022 01:03:08 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v8 02/10] add prctl task isolation prctl docs and samples
Message-ID: <20220108000308.GB1337751@lothringen>
References: <20211208161000.684779248@fuller.cnet>
 <20220106234956.GA1321256@lothringen>
 <20220107113001.GA105857@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107113001.GA105857@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 08:30:01AM -0300, Marcelo Tosatti wrote:
> On Fri, Jan 07, 2022 at 12:49:56AM +0100, Frederic Weisbecker wrote:
> > On Wed, Dec 08, 2021 at 01:09:08PM -0300, Marcelo Tosatti wrote:
> > > Add documentation and userspace sample code for prctl
> > > task isolation interface.
> > > 
> > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > Acked-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Thanks a lot! Time for me to look at the rest of the series.
> > 
> > Would be nice to have Thomas's opinion as well at least on
> > the interface (this patch).
> 
> Yes. AFAIAW most of his earlier comments on what the 
> interface should look like have been addressed (or at
> least i've tried to)... including the ability for
> the system admin to configure the isolation options.
> 
> The one thing missing is to attempt to enter nohz_full
> on activation (which Christoph asked for).
> 
> Christoph, have a question on that. At
> https://lkml.org/lkml/2021/12/14/346, you wrote:
> 
> "Applications running would ideally have no performance penalty and there
> is no  issue with kernel activity unless the application is in its special
> low latency loop. NOHZ is currently only activated after spinning in that
> loop for 2 seconds or so. Would be best to be able to trigger that
> manually somehow."
> 
> So was thinking of something similar to what the full task isolation
> patchset does (with the behavior of returning an error as option...):
> 
> +int try_stop_full_tick(void)
> +{
> +	int cpu = smp_processor_id();
> +	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
> +
> +	/* For an unstable clock, we should return a permanent error code. */
> +	if (atomic_read(&tick_dep_mask) & TICK_DEP_MASK_CLOCK_UNSTABLE)
> +		return -EINVAL;
> +
> +	if (!can_stop_full_tick(cpu, ts))
> +		return -EAGAIN;
> +
> +	tick_nohz_stop_sched_tick(ts, cpu);
> +	return 0;
> +}
> 
> Is that sufficient? (note it might still be possible 
> for a failure to enter nohz_full due to a number of 
> reasons), see tick_nohz_stop_sched_tick.

Well, I guess we can simply make tick_nohz_full_update_tick() an API, then
it could be a QUIESCE feature.

But keep in mind we may not only fail to enter into nohz_full mode, we
may also enter it but, instead of completely stopping the tick, it can
be delayed to some future if there is still a timer callback queued somewhere.

Make sure you test "ts->next_tick == KTIME_MAX" after stopping the tick.

This raise the question: what do we do if a quiescing fails? At least if it's a
oneshot, we can return an -EBUSY from the prctl() but otherwise, subsequent kernel
entry/exit are a problem.

