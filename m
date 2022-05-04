Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65FC51AD55
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355689AbiEDS4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiEDS4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:56:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32921FA7B;
        Wed,  4 May 2022 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651690364; x=1683226364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g6cXVITLw5XGRVy0kM+kX0NCN2l4lKwducjAVxfFljo=;
  b=Fx9jI+wWnrFMC2QGr7GC6i7PaeNe/rK7reJZfVbMWLfSKtG3i0HjGpRi
   wZJ856pFaF5C7pEtUSbg4GuLX/aNWbj8L3qbUI/ceQe68GKNmDe9C5P7N
   55A0c+XBbVZwhQjkzU3Y/kau3vnkiaMSv7J9ZOGCg8CDi6JZfVBPsSFzx
   SAkhs1prU6gGf3nCXekpAIEwAPL0CTSj//QwXMdOmjTkfAuzx/aDmd1+R
   ahh9TpPCHRjNSOk23jLYkiYz0m5NEZNa9WXhDocoJsoRkkVVUIcFZE7my
   6nquNFGTXSYRB3q9eWg6+AQsdITFmBQiB1PVL79SjgpHUdtwD98pTVflO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="354303074"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="354303074"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 11:52:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="599661690"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 11:52:43 -0700
Date:   Wed, 4 May 2022 11:52:42 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     hdegoede@redhat.com, markgross@kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v5 07/10] platform/x86/intel/ifs: Add scan test support
Message-ID: <YnLLekoripdY2oQU@agluck-desk3.sc.intel.com>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <20220428153849.295779-8-tony.luck@intel.com>
 <87r159jxaq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r159jxaq.ffs@tglx>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 02:29:33PM +0200, Thomas Gleixner wrote:
> On Thu, Apr 28 2022 at 08:38, Tony Luck wrote:
> > +
> > +	/* wait for the sibling threads to join */
> > +	first = cpumask_first(topology_sibling_cpumask(cpu));
> > +	if (!wait_for_siblings(dev, ifsd, &siblings_in, NSEC_PER_SEC)) {
> 
> Waiting for a second with preemption disabled? Seriously?

Probably won't ever wait for a second. Any suggestions for a reasonable
timeout for how long it might take before both threads on a core begin
executing the target code after a pair of:

	queue_work_on(sibling, ifs_wq, &local_work[i].w);

that the request to check this core fired off?

Possibly this could be dropped, and just built into the allowable delay
for the threads to execute the ACTIVATE_SCAN (31 bits of TSC cycles in
the value written to the MSR). But a future scan feature doesn't include
that user tuneable value.

> 
> > +		preempt_enable();
> > +		dev_err(dev, "cpu %d sibling did not join rendezvous\n", cpu);
> > +		goto out;
> > +	}
> > +
> > +	activate.start = 0;
> > +	activate.stop = ifsd->valid_chunks - 1;
> > +	timeout = jiffies + HZ / 2;
> 
> Plus another half a second with preemption disabled. That's just insane.

Another rounded up value. Experimentally we are seeing the core scan
test take aroun 50ms. The spec (I know, we haven't published the spec)
says "up to 200ms".

> 
> > +	retries = MAX_IFS_RETRIES;
> > +
> > +	while (activate.start <= activate.stop) {
> > +		if (time_after(jiffies, timeout)) {
> > +			status.error_code = IFS_SW_TIMEOUT;
> > +			break;
> > +		}
> > +
> > +		local_irq_disable();
> > +		wrmsrl(MSR_ACTIVATE_SCAN, activate.data);
> > +		local_irq_enable();
> 
> That local_irq_disable() solves what?

An interrupt will stop the currently running "chunk" of the scan.
It is a restartable case. But the concern is that with high rate of
interrupts the scan may not complete (or even make any forward
progress).

> 
> > +		/*
> > +		 * All logical CPUs on this core are now running IFS test. When it completes
> > +		 * execution or is interrupted, the following RDMSR gets the scan status.
> > +		 */
> > +
> > +		rdmsrl(MSR_SCAN_STATUS, status.data);
> 
> Wait. Is that rdmsrl() blocking execution until the scan completes?

The comment isn't quite accurate here (my fault). The WRMSR doesn't
retire until the scan stops (either because it completed, or because
some thing happend to stop before all chunks were processed).

So the two HT threads will continue after the WRMSR pretty much in
lockstep and do the RDMSR to get the status. Both will see the same
status in most cases.

> 
> If so, what's the stall time here? If not, how is the logic below
> supposed to work?

Exact time will depend how many chunks of the scan were completed, and
how long they took. I see 50 ms total on current test system.

> 
> > +		/* Some cases can be retried, give up for others */
> > +		if (!can_restart(status))
> > +			break;
> > +
> > +		if (status.chunk_num == activate.start) {
> > +			/* Check for forward progress */
> > +			if (retries-- == 0) {
> > +				if (status.error_code == IFS_NO_ERROR)
> > +					status.error_code = IFS_SW_PARTIAL_COMPLETION;
> > +				break;
> > +			}
> > +		} else {
> > +			retries = MAX_IFS_RETRIES;
> > +			activate.start = status.chunk_num;
> > +		}
> > +	}
> > +


> > +int do_core_test(int cpu, struct device *dev)
> > +{
> > +	struct ifs_work *local_work;
> > +	int sibling;
> > +	int ret = 0;
> > +	int i = 0;
> > +
> > +	if (!scan_enabled)
> > +		return -ENXIO;
> > +
> > +	cpu_hotplug_disable();
> 
> Why cpu_hotplug_disable()? Why is cpus_read_lock() not sufficient here?

May be left from earlier version. I'll check that cpus_read_lock() is
enough.

> 
> > +	if (!cpu_online(cpu)) {
> > +		dev_info(dev, "cannot test on the offline cpu %d\n", cpu);
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	reinit_completion(&test_thread_done);
> > +	atomic_set(&siblings_in, 0);
> > +	atomic_set(&siblings_out, 0);
> > +
> > +	cpu_sibl_ct = cpumask_weight(topology_sibling_cpumask(cpu));
> > +	local_work = kcalloc(cpu_sibl_ct, sizeof(*local_work), GFP_NOWAIT);
> 
> Why does this need GFP_NOWAIT?

It doesn't. Will fix.

> 
> > +int ifs_setup_wq(void)
> > +{
> > +	/* Flags are to keep all the sibling cpu worker threads (of a core) in close sync */
> 
> I put that into the wishful thinking realm.

Can change to "... to try to keep ..."
> 
> Is there anywhere a proper specification of this mechanism? The public
> available MSR list in the SDM is uselss.
> 
> Without proper documentation it's pretty much impossible to review this
> code and to think about the approach.

Step 1 (at boot or driver load) is loading the scan tests into BIOS
reserved memory. I will fix up the bits where you pointed out problems
there.

Step 2 is the run time test of each core. That requires the near
simultaneous execution of:

	wrmsrl(MSR_ACTIVATE_SCAN, activate.data);

on all HT threads on the core. Trivial on parts that do not support
HT, or where it is disabled in BIOS. The above code is trying to
achieve this "parallel" execution.
The follow-on :

	rdmsrl(MSR_SCAN_STATUS, status.data);

doesn't have to be synchronized ... but handy to do so for when not
all chunks were processed and need to loop back to run another
activate_scan to continue starting from the interrupted chunk. In
the lab, this seems common ... when scanning all cores many of them
complete all chunks in a single bite, but several take 2-3 times around
the loop before completing.

As noted above I'm seeing a core test take around 50ms (but spec says
up to 200ms). In some environments that doesn't require any special
application or system reconfiguration.  It's not much different from
time-slicing when you are running more processes (or guests) than you
have CPUs. So sysadmins in those environments can use this driver to
cylce through cores testing each in turn without any extra steps.

You've pointed out that the driver disables preemption for insanely
long amounts of time ... to use this driver to test cores on a system
running applications where that is an issue will require additonal steps
to migrate latency critical applications to a different core while the
test is in progess, also re-direct interrupts. That seems well beyond the
scope of what is possible in a driver without all the information about
what workloads are running to pick a new temporary home for processes
and interrupts while the core is being tested.

-Tony
