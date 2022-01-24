Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00074987F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245123AbiAXSMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:12:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244948AbiAXSLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643047915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rrz6UI3xSsLw/DE7ozvY7fnwNoHGO5KrM0lo7TGMrsU=;
        b=EosHXEGjTVLzHFhS+E6rQGpRNaxX1LZdPgobO/FTeLDPGzk7vR3jW6SiKnBaoI6hE1ODeZ
        VJKJUv07wAuIdoiZrX5nCJu8+wvM0uFpG/IJlYn4X/8qMjsTjHx0XQjGrS6rei06dEpjea
        5U0xNGPOrf+dQP59AEuDjB6USe6u4ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-vTAzpVWsNGCOptdNQkbIsA-1; Mon, 24 Jan 2022 13:11:51 -0500
X-MC-Unique: vTAzpVWsNGCOptdNQkbIsA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B1631091DBE;
        Mon, 24 Jan 2022 18:11:40 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0949E7ED90;
        Mon, 24 Jan 2022 18:11:01 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 809A04188583; Mon, 24 Jan 2022 15:10:42 -0300 (-03)
Date:   Mon, 24 Jan 2022 15:10:42 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v8 02/10] add prctl task isolation prctl docs and samples
Message-ID: <Ye7roobHDqVogulr@fuller.cnet>
References: <20211208161000.684779248@fuller.cnet>
 <20220106234956.GA1321256@lothringen>
 <20220107113001.GA105857@fuller.cnet>
 <20220108000308.GB1337751@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108000308.GB1337751@lothringen>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 01:03:08AM +0100, Frederic Weisbecker wrote:
> On Fri, Jan 07, 2022 at 08:30:01AM -0300, Marcelo Tosatti wrote:
> > On Fri, Jan 07, 2022 at 12:49:56AM +0100, Frederic Weisbecker wrote:
> > > On Wed, Dec 08, 2021 at 01:09:08PM -0300, Marcelo Tosatti wrote:
> > > > Add documentation and userspace sample code for prctl
> > > > task isolation interface.
> > > > 
> > > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > > 
> > > Acked-by: Frederic Weisbecker <frederic@kernel.org>
> > > 
> > > Thanks a lot! Time for me to look at the rest of the series.
> > > 
> > > Would be nice to have Thomas's opinion as well at least on
> > > the interface (this patch).
> > 
> > Yes. AFAIAW most of his earlier comments on what the 
> > interface should look like have been addressed (or at
> > least i've tried to)... including the ability for
> > the system admin to configure the isolation options.
> > 
> > The one thing missing is to attempt to enter nohz_full
> > on activation (which Christoph asked for).
> > 
> > Christoph, have a question on that. At
> > https://lkml.org/lkml/2021/12/14/346, you wrote:
> > 
> > "Applications running would ideally have no performance penalty and there
> > is no  issue with kernel activity unless the application is in its special
> > low latency loop. NOHZ is currently only activated after spinning in that
> > loop for 2 seconds or so. Would be best to be able to trigger that
> > manually somehow."
> > 
> > So was thinking of something similar to what the full task isolation
> > patchset does (with the behavior of returning an error as option...):
> > 
> > +int try_stop_full_tick(void)
> > +{
> > +	int cpu = smp_processor_id();
> > +	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
> > +
> > +	/* For an unstable clock, we should return a permanent error code. */
> > +	if (atomic_read(&tick_dep_mask) & TICK_DEP_MASK_CLOCK_UNSTABLE)
> > +		return -EINVAL;
> > +
> > +	if (!can_stop_full_tick(cpu, ts))
> > +		return -EAGAIN;
> > +
> > +	tick_nohz_stop_sched_tick(ts, cpu);
> > +	return 0;
> > +}
> > 
> > Is that sufficient? (note it might still be possible 
> > for a failure to enter nohz_full due to a number of 
> > reasons), see tick_nohz_stop_sched_tick.
> 
> Well, I guess we can simply make tick_nohz_full_update_tick() an API, then
> it could be a QUIESCE feature.
> 
> But keep in mind we may not only fail to enter into nohz_full mode, we
> may also enter it but, instead of completely stopping the tick, it can
> be delayed to some future if there is still a timer callback queued somewhere.
> 
> Make sure you test "ts->next_tick == KTIME_MAX" after stopping the tick.
> 
> This raise the question: what do we do if a quiescing fails? At least if it's a
> oneshot, we can return an -EBUSY from the prctl() but otherwise, subsequent kernel
> entry/exit are a problem.

Well, maybe two modes can be specified for the NOHZ_FULL task isolation
feature. On activation of task isolation:

	- Hint (default). Attempt to enter nohz_full mode,
	  continue if unable to do so.

	- Mandatory. Return an error if unable to enter nohz_full mode
	  (tracing required to determine actual reason. is that OK?)

static bool check_tick_dependency(atomic_t *dep)
{
        int val = atomic_read(dep);

        if (val & TICK_DEP_MASK_POSIX_TIMER) {
                trace_tick_stop(0, TICK_DEP_MASK_POSIX_TIMER);
                return true;
        }

        if (val & TICK_DEP_MASK_PERF_EVENTS) {
                trace_tick_stop(0, TICK_DEP_MASK_PERF_EVENTS);
                return true;
        }

        if (val & TICK_DEP_MASK_SCHED) {
                trace_tick_stop(0, TICK_DEP_MASK_SCHED);
                return true;
        }

        if (val & TICK_DEP_MASK_CLOCK_UNSTABLE) {
                trace_tick_stop(0, TICK_DEP_MASK_CLOCK_UNSTABLE);
                return true;
        }

        if (val & TICK_DEP_MASK_RCU) {
                trace_tick_stop(0, TICK_DEP_MASK_RCU);
                return true;
        }

        return false;
}

One thing that can be done on the handlers is to execute any pending irq_work, which
would fix:

https://lkml.org/lkml/2021/6/18/1174

How about that ?

