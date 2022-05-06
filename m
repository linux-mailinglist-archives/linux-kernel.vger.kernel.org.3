Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D83051DF4F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388759AbiEFSxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358215AbiEFSxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:53:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAFC5F8E6;
        Fri,  6 May 2022 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651862974; x=1683398974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nnhTQrn/n8wXYGGAnnv+5UhLFqN2/i3wFlqp15Gr6rQ=;
  b=K20JMJqNJ8AAdfUpgzIDmRWgnVCqPrsP11s05l6OIZULn9wGJlr5DlBC
   Ul9mSQZtxlOZgYajuxSUvhzmtVsWqxn8YKc2DSJ2gp6ssgMMe6L5Fe6c+
   07ON0c9tS3cLBd81qz93tqSkApkkHAfNupCHm49o+huu86OfvtpDCPt00
   bhbIX5fMJp8WLtIb9KNWdmQjH8bdUTXxT+Fk1PbTbdKU/98dfVLEP2DJq
   JDdJqjxT7AliK9zZJrE1R9j+sEU4SZRjEYeDjhiU6glrDsv+tsW/rDHv7
   xM1dmFzTY94OzAH4xerqbWzrDHu0MOoIX2EkSVdUVsO1KPHxvptBEVAdi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="329093587"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="329093587"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 11:49:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="538012312"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 11:49:33 -0700
Date:   Fri, 6 May 2022 11:49:32 -0700
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
Subject: Re: [PATCH v6 08/11] platform/x86/intel/ifs: Add scan test support
Message-ID: <YnVtvJgWU5KDnGSl@agluck-desk3.sc.intel.com>
References: <20220428153849.295779-1-tony.luck@intel.com>
 <20220506014035.1173578-1-tony.luck@intel.com>
 <20220506014035.1173578-9-tony.luck@intel.com>
 <87r156hjpl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r156hjpl.ffs@tglx>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 03:30:30PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 18:40, Tony Luck wrote:
> > +/*
> > + * Note all code and data in this file is protected by
> > + * ifs_sem. On HT systems all threads on a core will
> > + * execute together, but only the first thread on the
> > + * core will update results of the test.
> > + */
> > +struct workqueue_struct *ifs_wq;
> 
> Seems to be unused.

Missed deleting the definition after dropping all the users.
Deleted now.

> > +static bool oscan_enabled = true;
> 
> What changes this?

Code that changed this has been deleted (was to deal with a "can't
happen" case where the kernel threads didn't set completion).

Variable (and the remaing place that checked it) now deleted.

> > +static void message_not_tested(struct device *dev, int cpu, union ifs_status status)
> > +{
> > +	if (status.error_code < ARRAY_SIZE(scan_test_status))
> 
> Please add curly brackets as these are not one-line statements.

Done.

> > +		dev_info(dev, "CPU(s) %*pbl: SCAN operation did not start. %s\n",
> > +			 cpumask_pr_args(topology_sibling_cpumask(cpu)),
> > +			 scan_test_status[status.error_code]);
> > +/*
> > + * Execute the scan. Called "simultaneously" on all threads of a core
> > + * at high priority using the stop_cpus mechanism.
> > + */
> > +static int doscan(void *data)
> > +{
> > +	int cpu = smp_processor_id();
> > +	u64 *msrs = data;
> > +	int first;
> > +
> > +	/* Only the first logical CPU on a core reports result */
> > +	first = cpumask_first(topology_sibling_cpumask(cpu));
> 
> Shouldn't that be cpu_smt_mask()?

I guess so. It seems part of a maze of CONFIG options and #defines.
The code worked because (except on power) cpu_smt_mask() is just
an inline funtion that calls topology_sibling_cpumask().

I've changed this (and the other places that use
topology_sibling_cpumask() to cpu_smt_mask(). Will probably save
me from a randconfig build error some time in the future.

> > +	/*
> > +	 * This WRMSR will wait for other HT threads to also write
> > +	 * to this MSR (at most for activate.delay cycles). Then it
> > +	 * starts scan of each requested chunk. The core scan happens
> > +	 * during the "execution" of the WRMSR. This instruction can
> > +	 * take up to 200 milliseconds before it retires.
> 
> 200ms per test chunk?

Updated comment to say that 200 ms is the time for all chunks.

Note that the loop that calls here tries to do all (remaining)
chunks on each iteration. Doing them 1 at a time would reduce
the time each spends in stomp_machine(), but not as much as you'd
like. Each WRMSR(ACTIVATE_SCAN)) has to save/restore the whole
state of the core (similar to a C6 entry+exit). 

> > +	 */
> > +	wrmsrl(MSR_ACTIVATE_SCAN, msrs[0]);
> > +
> 
> > +	while (activate.start <= activate.stop) {
> > +		if (time_after(jiffies, timeout)) {
> > +			status.error_code = IFS_SW_TIMEOUT;
> > +			break;
> > +		}
> > +
> > +		msrvals[0] = activate.data;
> > +		stop_core_cpuslocked(cpu, doscan, msrvals);
> > +
> > +		status.data = msrvals[1];
> > +
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
> 
> Looks way better now.

Thanks to you!

> > +}
> > +/*
> > + * Initiate per core test. It wakes up work queue threads on the target cpu and
> > + * its sibling cpu. Once all sibling threads wake up, the scan test gets executed and
> > + * wait for all sibling threads to finish the scan test.
> > + */
> > +int do_core_test(int cpu, struct device *dev)
> > +{
> > +	int ret = 0;
> > +
> > +	if (!scan_enabled)
> > +		return -ENXIO;
> > +
> > +	/* Prevent CPUs from being taken offline during the scan test */
> > +	cpus_read_lock();
> > +
> > +	if (!cpu_online(cpu)) {
> > +		dev_info(dev, "cannot test on the offline cpu %d\n", cpu);
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> 
> Coming back to my points from the previous round:
> 
> 1) How is that supposed to work on a system which has HT enabled in BIOS,
>    but disabled on the kernel command line or via /sys/..../smt/control or
>    when a HT sibling is offlined temporarily?
> 
>    I assume it cannot work, but I can't see anything which handles those
>    cases.

Correct. If HT is disabled in BIOS, then there is no other thread, so
core tests just use a single thread.

If a logical CPU is "offline" due to Linux actions, then core test will
fail. In an earlier version we did attempt to detect this before trying
to run the test. But we didn't find a simple way to determine that a
core has one thread online, and another offline. Rather than a bunch of
code to detect an operator error it seemed better to let it run & fail.

Here is what the user will see:

# echo 45 > run_test
# cat status
untested
# cat details
0x100008000

Console will see this message:
misc intel_ifs_0: CPU(s) 45: SCAN operation did not start. Other thread could not join.

If the user debugs using the trace point I included in the code they will see:

              sh-411499  [067] ..... 61260.698969: ifs_status: cpu: 45, start: 00, stop: 80, status: 100008000
              sh-411499  [067] ..... 61260.699968: ifs_status: cpu: 45, start: 00, stop: 80, status: 100008000
              sh-411499  [067] ..... 61260.700076: ifs_status: cpu: 45, start: 00, stop: 80, status: 100008000
              sh-411499  [067] ..... 61260.700187: ifs_status: cpu: 45, start: 00, stop: 80, status: 100008000
              sh-411499  [067] ..... 61260.700334: ifs_status: cpu: 45, start: 00, stop: 80, status: 100008000
              sh-411499  [067] ..... 61260.700437: ifs_status: cpu: 45, start: 00, stop: 80, status: 100008000

Hmmm ... looks like I have an off-by one error in the retry check.

/* Max retries on the same chunk */
#define MAX_IFS_RETRIES  5

But it tried SIX times before giving up.  Will fix.

> 2) That documentation for the admin/user got eaten by the gremlins in
>    the intertubes again.

GregKH wasn't a fan of this itty bitty driver cluttering up
Documentation/x86. He said:

   I don't know which is better, it's just that creating a whole new
   documentation file for a single tiny driver feels very odd as it will
   get out of date and is totally removed from the driver itself.

   I'd prefer that drivers be self-contained, including the documentation,
   as it is much more obvious what is happening with that.  Spreading stuff
   around the tree only causes stuff to get out of sync easier.

So the documentation patch was dropped after v3. Last version here:

https://lore.kernel.org/r/20220419163859.2228874-3-tony.luck@intel.com

That doc would need pathnames updated to match the move from a platform
device to a virtual misc device. But otherwise seems still accurate.

Does that cover what you want from documentation for this driver
(wherever it gets located in the tree)? Are you looking for more?

-Tony
