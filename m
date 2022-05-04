Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84D551B3B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382231AbiEDXrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381094AbiEDXSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:18:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582DF15A22;
        Wed,  4 May 2022 16:15:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651706108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zAXVpRwwTqHPHiIb2bR3bIkusSqVy9qjv8p6mQpq15A=;
        b=rLAYGbm1+ZJXd2B/04KDHruU27nBv9Nhye24v570SNolvMoJzMfsTidnwvMCPC24vpD+4e
        SEeebHqZR9COsONQNia7rInMuBHK6iFVrBBNYve+fZIzc9joDK11Tr7QqzcMkpF8W8lNlq
        vzjdJ0qhPigJ3H5y4mEVXY7VPdd856701ydYsv8UP6CyxMJE9yOQ3VIU6Fy2Up28jSeEd3
        vK8v25HMbz+6YTRKiAIyouB+r4ulmwuscxuLbq4Fqe95sA65LzrBJ+pITTRaElZyNEpgD7
        wvh8U9wGMg26dSXmI09FFDwxIOUYNtocauCjcEOGiw2HoRO/dVVBtsCvK+5crQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651706108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zAXVpRwwTqHPHiIb2bR3bIkusSqVy9qjv8p6mQpq15A=;
        b=Q8qTftolWduXH9XEUHghzXb2MC+xyZwQ0qbLByxJXrz/YKAavb4F4TSVrhu3MWag4gh0g0
        4Q/gQaCvR+rwXkAw==
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 07/10] platform/x86/intel/ifs: Add scan test support
In-Reply-To: <YnLLekoripdY2oQU@agluck-desk3.sc.intel.com>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <20220428153849.295779-8-tony.luck@intel.com> <87r159jxaq.ffs@tglx>
 <YnLLekoripdY2oQU@agluck-desk3.sc.intel.com>
Date:   Thu, 05 May 2022 01:15:07 +0200
Message-ID: <87tua4j3es.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04 2022 at 11:52, Luck, Tony wrote:
> On Wed, May 04, 2022 at 02:29:33PM +0200, Thomas Gleixner wrote:
>> On Thu, Apr 28 2022 at 08:38, Tony Luck wrote:
>> > +
>> > +	/* wait for the sibling threads to join */
>> > +	first = cpumask_first(topology_sibling_cpumask(cpu));
>> > +	if (!wait_for_siblings(dev, ifsd, &siblings_in, NSEC_PER_SEC)) {
>> 
>> Waiting for a second with preemption disabled? Seriously?
>
> Probably won't ever wait for a second. Any suggestions for a reasonable
> timeout for how long it might take before both threads on a core begin
> executing the target code after a pair of:
>
> 	queue_work_on(sibling, ifs_wq, &local_work[i].w);
>
> that the request to check this core fired off?

The real question is why you try to rendevouz CPUs via work queues.

The kernel has a well established mechanism to do CPU rendevouz already:

    stomp_machine()

We all hate it with a passion, but it is already doing what you are
trying to achieve and as the stopper threads run with high priority they
are not subject to arbitrary scheduling delays which make one CPU wait
for a long time with preemption disabled.

>> Plus another half a second with preemption disabled. That's just insane.
>
> Another rounded up value. Experimentally we are seeing the core scan
> test take aroun 50ms. The spec (I know, we haven't published the spec)
> says "up to 200ms".

That's daft. Both the 200ms and the non-published spec, though the latter
is worse because it's wasting everyones time.

>> > +	retries = MAX_IFS_RETRIES;
>> > +
>> > +	while (activate.start <= activate.stop) {
>> > +		if (time_after(jiffies, timeout)) {
>> > +			status.error_code = IFS_SW_TIMEOUT;
>> > +			break;
>> > +		}
>> > +
>> > +		local_irq_disable();
>> > +		wrmsrl(MSR_ACTIVATE_SCAN, activate.data);
>> > +		local_irq_enable();
>> 
>> That local_irq_disable() solves what?
>
> An interrupt will stop the currently running "chunk" of the scan.
> It is a restartable case. But the concern is that with high rate of
> interrupts the scan may not complete (or even make any forward
> progress).

What about NMI/MCE? What happens if the scan triggers an MCE?

If the scan is stopped, will it be stopped on both hyperthreads?

What happens in the case, when one of the CPUs is slightly behind the
other:

     CPU A                      CPU B
     local_irq_disable()
     wrmsrl(...);
                                <- Interrupt
                                   handle_irq();
                                local_irq_disable();
                                wrmsrl(...);

Will the interrupt which hit CPU B _after_ CPU A issued the MSR write
stop the operation on CPU A and make it return?

If not, then how long is CPU A waiting for CPU B to join the party?

>> > +		/*
>> > +		 * All logical CPUs on this core are now running IFS test. When it completes
>> > +		 * execution or is interrupted, the following RDMSR gets the scan status.
>> > +		 */
>> > +
>> > +		rdmsrl(MSR_SCAN_STATUS, status.data);
>> 
>> Wait. Is that rdmsrl() blocking execution until the scan completes?
>
> The comment isn't quite accurate here (my fault). The WRMSR doesn't
> retire until the scan stops (either because it completed, or because
> some thing happend to stop before all chunks were processed).

I suspected that due to the non-commented local_irq_disable() ...

>> If so, what's the stall time here? If not, how is the logic below
>> supposed to work?
>
> Exact time will depend how many chunks of the scan were completed, and
> how long they took. I see 50 ms total on current test system.

Per chunk or for all chunks? The interresting part is not the total
time, the interresting part is the time per chunk.

>> Is there anywhere a proper specification of this mechanism? The public
>> available MSR list in the SDM is uselss.
>> 
>> Without proper documentation it's pretty much impossible to review this
>> code and to think about the approach.

...

> Step 2 is the run time test of each core. That requires the near
> simultaneous execution of:
>
> 	wrmsrl(MSR_ACTIVATE_SCAN, activate.data);
>
> on all HT threads on the core. Trivial on parts that do not support
> HT, or where it is disabled in BIOS. The above code is trying to
> achieve this "parallel" execution.

How is that supposed to work on a system which has HT enabled in BIOS,
but disabled on the kernel command line or via /sys/..../smt/control or
when a HT sibling is offlined temporarily?

I assume it cannot work, but I can't see anything which handles those
cases.

> The follow-on :
>
> 	rdmsrl(MSR_SCAN_STATUS, status.data);
>
> doesn't have to be synchronized ... but handy to do so for when not
> all chunks were processed and need to loop back to run another
> activate_scan to continue starting from the interrupted chunk. In
> the lab, this seems common ... when scanning all cores many of them
> complete all chunks in a single bite, but several take 2-3 times around
> the loop before completing.

Is there a timeout for restarting an interrupted chunk?

> As noted above I'm seeing a core test take around 50ms (but spec says
> up to 200ms). In some environments that doesn't require any special
> application or system reconfiguration.  It's not much different from
> time-slicing when you are running more processes (or guests) than you
> have CPUs. So sysadmins in those environments can use this driver to
> cylce through cores testing each in turn without any extra steps.
>
> You've pointed out that the driver disables preemption for insanely
> long amounts of time ... to use this driver to test cores on a system
> running applications where that is an issue will require additonal steps
> to migrate latency critical applications to a different core while the
> test is in progess, also re-direct interrupts. That seems well beyond the
> scope of what is possible in a driver without all the information about
> what workloads are running to pick a new temporary home for processes
> and interrupts while the core is being tested.

I assume that's all described in Documentation/x86/intel-ifs.rst, which
was in patch 11/10 and unfortunately got lost in the intertubes.

Coming back to that rendevouz mechanism.

As far as I understand it, but of course my implementation of

   # pdforacle --remote=tony --condense sekrit-ifs-spec.pdf

might be suboptimal, the only hard requirement is to start the
scan for a particular chunk on all HT threads roughly at the same
time.

But there is no hard requirement that the individual chunks are started
right after each other or that a restart of an for whatever reason
interrupted chunk happens 'immediately'.

If that's the case and anything else would be an insanity, then you can
do something like this:

static DEFINE_PER_CPU(struct ifs_status, ifs_status);

int do_test(int cpu, struct device *dev)
{
        const struct cpumask *mask;
        struct ifsdata data;

        cpus_read_lock();
        mask = topology_sibling_cpumask(cpu);
        if (!sane(mask))
        	goto fail;

        for_each_cpu(sibling, mask)
        	init_ifs_status(sibling);

        init_data(data, dev);

        while (data.chunk < data.max_chunks) {
        	ret = stomp_cpumask(mask, doscan, data);

                if (!ret) {
                        data.chunk++;
                	continue;
                }

                // Analyze per CPU ifs_status to either
                // restart or abort with proper information
                // about the reason to abort
                .....
        }
        ....

We don't have stomp_cpumask() today, but that's trivial enough to
implement. Yes, we want to avoid expanding stomp_machine(), but trying
to resemble stomp_machine() with work queues is worse by several orders
of magnitude.

doscan() will boil down to:

    wrmsrl(RUN_SCAM, data->chunk);
    rdmsrl(STA_SCAM, status);
    this_cpu_write(ifs_status, status);
    return status ? -ECRAP : 0;

plus the required commentry which will be an order of magnitude more
lines than the actual code above.

Thanks,

        tglx
