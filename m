Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60203519F6F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349526AbiEDMdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347936AbiEDMdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:33:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F2F24BE4;
        Wed,  4 May 2022 05:29:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651667373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B2VY1pBCHecUOk5t/5XaUHPp27OaBx7YYYmupaRwS+A=;
        b=zdznyDCSDehnyX/b0QFmsj2JVN5/n99CsO5EFO+/CCG/+E1TjEQ2bgcdGG0deAKbf3xEJS
        uOZwf/IxxHbe7wV8Q1AFizSFsFLv925fZnu7sd2gJqn0HSI5uH9kA/QW4PbPOC3Z4ifO5S
        YbL2LSMILOw3J4wQDfKuUEND7wy3N6bHhSwZO8n03inujIDA8/ska9h4W90rFoahqgyEnR
        kHl+4YHzuHp3tGYN79MWlrffO53Wh1mDX07L9fvHunCFh+YOqRBRYph4ZB1SswZqMwXBTA
        9MIK2CJ4FtpoYWxO9lYtnXeE82a3tTb9YVQomsk2mFpqPLZ0ysTEo3g3qkzvow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651667373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B2VY1pBCHecUOk5t/5XaUHPp27OaBx7YYYmupaRwS+A=;
        b=uDUwSXu/Lh+hMmMAi1uwqvrO9ZBzsl5U9wICOYYSbVL1NYk1IAG604Z/MquO+3gwwn2t8P
        UsmEFtu+Jq+yETDA==
To:     Tony Luck <tony.luck@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v5 07/10] platform/x86/intel/ifs: Add scan test support
In-Reply-To: <20220428153849.295779-8-tony.luck@intel.com>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <20220428153849.295779-8-tony.luck@intel.com>
Date:   Wed, 04 May 2022 14:29:33 +0200
Message-ID: <87r159jxaq.ffs@tglx>
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

On Thu, Apr 28 2022 at 08:38, Tony Luck wrote:
> +static bool wait_for_siblings(struct device *dev, struct ifs_data *ifsd, atomic_t *t, long long timeout)
> +{
> +	atomic_inc(t);
> +	while (atomic_read(t) < cpu_sibl_ct) {
> +		if (timeout < SPINUNIT) {
> +			dev_err(dev,
> +				"Timeout while waiting for CPUs rendezvous, remaining: %d\n",
> +				cpu_sibl_ct - atomic_read(t));
> +			return false;
> +		}
> +
> +		ndelay(SPINUNIT);
> +		timeout -= SPINUNIT;
> +
> +		touch_nmi_watchdog();
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * When a Scan test (for a particular core) is triggered by the user, worker threads
> + * for each sibling cpus(belonging to that core) are queued to execute this function in
> + * the Workqueue (ifs_wq) context.
> + * Wait for the sibling thread to join before the execution.
> + * Execute the scan test by running wrmsr(MSR_ACTIVATE_SCAN).
> + */
> +static void ifs_work_func(struct work_struct *work)
> +{
> +	struct ifs_work *local_work = container_of(work, struct ifs_work, w);
> +	int cpu = smp_processor_id();
> +	union ifs_scan activate;
> +	union ifs_status status;
> +	unsigned long timeout;
> +	struct ifs_data *ifsd;
> +	struct device *dev;
> +	int retries;
> +	u32 first;
> +
> +	dev = local_work->dev;
> +	ifsd = ifs_get_data(dev);
> +
> +	activate.rsvd = 0;
> +	activate.delay = msec_to_tsc(THREAD_WAIT);
> +	activate.sigmce = 0;
> +
> +	/*
> +	 * Need to get (and keep) the threads on this core executing close together
> +	 * so that the writes to MSR_ACTIVATE_SCAN below will succeed in entering
> +	 * IFS test mode on this core. Interrupts on each thread are expected to be
> +	 * brief. But preemption would be a problem.
> +	 */
> +	preempt_disable();
> +
> +	/* wait for the sibling threads to join */
> +	first = cpumask_first(topology_sibling_cpumask(cpu));
> +	if (!wait_for_siblings(dev, ifsd, &siblings_in, NSEC_PER_SEC)) {

Waiting for a second with preemption disabled? Seriously?

> +		preempt_enable();
> +		dev_err(dev, "cpu %d sibling did not join rendezvous\n", cpu);
> +		goto out;
> +	}
> +
> +	activate.start = 0;
> +	activate.stop = ifsd->valid_chunks - 1;
> +	timeout = jiffies + HZ / 2;

Plus another half a second with preemption disabled. That's just insane.

> +	retries = MAX_IFS_RETRIES;
> +
> +	while (activate.start <= activate.stop) {
> +		if (time_after(jiffies, timeout)) {
> +			status.error_code = IFS_SW_TIMEOUT;
> +			break;
> +		}
> +
> +		local_irq_disable();
> +		wrmsrl(MSR_ACTIVATE_SCAN, activate.data);
> +		local_irq_enable();

That local_irq_disable() solves what?

> +		/*
> +		 * All logical CPUs on this core are now running IFS test. When it completes
> +		 * execution or is interrupted, the following RDMSR gets the scan status.
> +		 */
> +
> +		rdmsrl(MSR_SCAN_STATUS, status.data);

Wait. Is that rdmsrl() blocking execution until the scan completes?

If so, what's the stall time here? If not, how is the logic below
supposed to work?

> +		/* Some cases can be retried, give up for others */
> +		if (!can_restart(status))
> +			break;
> +
> +		if (status.chunk_num == activate.start) {
> +			/* Check for forward progress */
> +			if (retries-- == 0) {
> +				if (status.error_code == IFS_NO_ERROR)
> +					status.error_code = IFS_SW_PARTIAL_COMPLETION;
> +				break;
> +			}
> +		} else {
> +			retries = MAX_IFS_RETRIES;
> +			activate.start = status.chunk_num;
> +		}
> +	}
> +
> +	preempt_enable();
> +
> +	if (cpu == first) {
> +		/* Update status for this core */
> +		ifsd->scan_details = status.data;
> +
> +		if (status.control_error || status.signature_error) {
> +			ifsd->status = SCAN_TEST_FAIL;
> +			message_fail(dev, cpu, status);
> +		} else if (status.error_code) {
> +			ifsd->status = SCAN_NOT_TESTED;
> +			message_not_tested(dev, cpu, status);
> +		} else {
> +			ifsd->status = SCAN_TEST_PASS;
> +		}
> +	}
> +
> +	if (!wait_for_siblings(dev, ifsd, &siblings_out, NSEC_PER_SEC))
> +		dev_err(dev, "cpu %d sibling did not exit rendezvous\n", cpu);
> +
> +out:
> +	if (cpu == first)
> +		complete(&test_thread_done);
> +}
> +
> +/*
> + * Initiate per core test. It wakes up work queue threads on the target cpu and
> + * its sibling cpu. Once all sibling threads wake up, the scan test gets executed and
> + * wait for all sibling threads to finish the scan test.
> + */
> +int do_core_test(int cpu, struct device *dev)
> +{
> +	struct ifs_work *local_work;
> +	int sibling;
> +	int ret = 0;
> +	int i = 0;
> +
> +	if (!scan_enabled)
> +		return -ENXIO;
> +
> +	cpu_hotplug_disable();

Why cpu_hotplug_disable()? Why is cpus_read_lock() not sufficient here?

> +	if (!cpu_online(cpu)) {
> +		dev_info(dev, "cannot test on the offline cpu %d\n", cpu);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	reinit_completion(&test_thread_done);
> +	atomic_set(&siblings_in, 0);
> +	atomic_set(&siblings_out, 0);
> +
> +	cpu_sibl_ct = cpumask_weight(topology_sibling_cpumask(cpu));
> +	local_work = kcalloc(cpu_sibl_ct, sizeof(*local_work), GFP_NOWAIT);

Why does this need GFP_NOWAIT?

> +int ifs_setup_wq(void)
> +{
> +	/* Flags are to keep all the sibling cpu worker threads (of a core) in close sync */

I put that into the wishful thinking realm.

Is there anywhere a proper specification of this mechanism? The public
available MSR list in the SDM is uselss.

Without proper documentation it's pretty much impossible to review this
code and to think about the approach.

Thanks,

        tglx
