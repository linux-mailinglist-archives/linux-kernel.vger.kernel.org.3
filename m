Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E3E585F66
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiGaPG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiGaPGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:06:54 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58FE6446;
        Sun, 31 Jul 2022 08:06:51 -0700 (PDT)
Date:   Sun, 31 Jul 2022 23:06:31 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1659280009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qZ/bYKIHyOrMtVd6T0UZtYB/PJG6wI6uH5tEp4TdlqQ=;
        b=Z80EAjbgSDd0m/DhKGXJTejECSuIBg42XO2bouhlfrZCyxIRUB5z1CbFeO9+X/bbIpok9z
        SsGrUFCbd47PmvGgzuochiykNZd7q8m9qPaVz5N9Z+nfMng1xc1a1ggVAcaMefAhpYrNNd
        kPipV2dgO/1NA4rCIyfB82OMGARtTMU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH V9 01/16] rv: Add Runtime Verification (RV) interface
Message-ID: <YuaadlzgSJLtzOUw@geo.homenetwork>
References: <cover.1659052063.git.bristot@kernel.org>
 <a4bfe038f50cb047bfb343ad0e12b0e646ab308b.1659052063.git.bristot@kernel.org>
 <YuU7TGxm5pzmBFTx@geo.homenetwork>
 <0197dd47-ea15-4d8b-5fc7-e466d8a501a7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0197dd47-ea15-4d8b-5fc7-e466d8a501a7@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 08:07:07PM +0200, Daniel Bristot de Oliveira wrote:
> On 7/30/22 16:08, Tao Zhou wrote:
> > On Fri, Jul 29, 2022 at 11:38:40AM +0200, Daniel Bristot de Oliveira wrote:
> > 
> >> +static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool sync)
> >> +{
> >> +	lockdep_assert_held(&rv_interface_lock);
> >> +
> >> +	if (mdef->monitor->enabled) {
> >> +		mdef->monitor->enabled = 0;
> >> +		mdef->monitor->disable();
> > 
> > If call disable(), the @enabled is set 0 there.
> 
> Which is correct.
> 
> > 
> >> +
> >> +		/*
> >> +		 * Wait for the execution of all events to finish.
> >> +		 * Otherwise, the data used by the monitor could
> >> +		 * be inconsistent. i.e., if the monitor is re-enabled.
> >> +		 */
> >> +		if (sync)
> >> +			tracepoint_synchronize_unregister();
> >> +		return 1;
> > 
> > Return 0 indicate the actually disabling and successed.
> 
> No, 1 indicates that *disable was called, 0 did not call disable function.
> 
> >> +	}
> >> +	return 0;
> > 
> > If disable a diabled monitor, return error(negative).
> 
> This is a "static __function", which alerts for internal aspects.
> 
> It has a specific purpose of counting if the disable function
> was actually called.
> 
> Disabling a disabled monitor is not a problem.
> 
> So all your argumentation based on this is not correct, and it is breaking
> other parts of the code... see where it is called.
> 
> >> +}
> >> +
> >> +/**
> >> + * rv_disable_monitor - disable a given runtime monitor
> >> + *
> >> + * Returns 0 on success.
> >> + */
> >> +int rv_disable_monitor(struct rv_monitor_def *mdef)
> >> +{
> >> +	__rv_disable_monitor(mdef, true);
> >> +	return 0;
> > 
> > Always return 0 here, whatever the return value of __rv_disable_monitor().
> > And this enforce me to look more here, see below.
> 
> This is not a problem. Actually, disable functions often return void.
> I am keeping an int just in case.
> 
> >> +}
> > 
> >> +static ssize_t enabled_monitors_write(struct file *filp, const char __user *user_buf,
> >> +				      size_t count, loff_t *ppos)
> >> +{
> >> +	char buff[MAX_RV_MONITOR_NAME_SIZE + 2];
> >> +	struct rv_monitor_def *mdef;
> >> +	int retval = -EINVAL;
> >> +	bool enable = true;
> >> +	char *ptr = buff;
> >> +	int len;
> >> +
> >> +	if (count < 1 || count > MAX_RV_MONITOR_NAME_SIZE + 1)
> >> +		return -EINVAL;
> >> +
> >> +	memset(buff, 0, sizeof(buff));
> >> +
> >> +	retval = simple_write_to_buffer(buff, sizeof(buff) - 1, ppos, user_buf, count);
> >> +	if (retval < 0)
> >> +		return -EFAULT;
> >> +
> >> +	ptr = strim(buff);
> >> +
> >> +	if (ptr[0] == '!') {
> >> +		enable = false;
> >> +		ptr++;
> >> +	}
> >> +
> >> +	len = strlen(ptr);
> >> +	if (!len)
> >> +		return count;
> >> +
> >> +	mutex_lock(&rv_interface_lock);
> >> +
> >> +	retval = -EINVAL;
> >> +
> >> +	list_for_each_entry(mdef, &rv_monitors_list, list) {
> >> +		if (strcmp(ptr, mdef->monitor->name) != 0)
> >> +			continue;
> >> +
> >> +		/*
> >> +		 * Monitor found!
> >> +		 */
> >> +		if (enable)
> >> +			retval = rv_enable_monitor(mdef);
> >> +		else
> >> +			retval = rv_disable_monitor(mdef);
> > 
> > About the retval here. If count == 1 and retval == 0, then
> > `retval = count` --> retval == 1. This retval will be returned to 
> > user space and dedicate that how many character read and success
> > If retval is 1(it is not possiable, the return value of
> > da_monitor_init_*() called in enable callback in rv_enable_monitor()
> > will be 0, so that return value check is not needed, or any other functions
> > called in enable callback need to check the return value then,...
> 
> All things above are misled by the first interpretation but,,,

Yeah, this is not that clear from my above words expression. I said the return
value of da_monitor_init_*() will be 0, but it is not right. Global and per-cpu
monitor will return 0, per-task monitor may return a positive value when the
slot is equal or greater than RV_PER_TASK_MONITOR_INIT(how possible this will
happen I do know yet). This is from reading the current code implementation.
I just want to say that there may be a bug here.
If rv_enable_monitor() return a positive value and the error happened(as above
said), user space will not know this is a error return value, but regard it as a
right writing. Even if the return value(the slot value not in [0..RV_PER_TASK_MONITOR_INIT))
is equal to count of charaters that are writen to the file(the string length of monitor name),
it will still be not a right writing.

> 
> so I checked
> > the WARN_ONCE() called in macro rv_attach_trace_probe() which is called in
> > enable callback,if the WARN_ONCE is called, it means that something go wrong.
> 
> The way that rv_attach_trace_probe() is attaching a probe is not different from the way
> other *in kernel* tracing does.
> 
> > We need to check the return value of WARN_ONCE() in enable callback), the
> > return value will be returned to user space but actually the error(warn) happened.
> > User space do not know. They treat the two kind of return value 1 the same
> > but one is the write count value successed and another is the write error
> > value returned.
> > In enable callback, check rv_attach_trace_probe():
> > 
> > static int enable_wip(void)
> > {
> >       int retval = 1;
> >  	  
> >       /* 
> >        * Delete the check of return value of da_monitor_init_wip()
> >        * because it is always 0
> >        */
> >       da_monitor_init_wip();
> > 
> >       retval &= rv_attach_trace_probe("wip", preempt_enable, handle_preempt_enable);
> >       retval &= rv_attach_trace_probe("wip", sched_waking, handle_sched_waking);
> >       retval &= rv_attach_trace_probe("wip", preempt_disable, handle_preempt_disable);
> 
> No, that is not the most robust way to do this. A better way is to do it like in the
> early versions of this patch set, where it was searching for the existence of the tracepoint

Even if we check the return value of rv_attach_trace_probe() in current implementation,
once error happened from one register the previous trace pointers will not be unregistered.

> from the module perspective, taking notes of the ones that were enabled, and then actually disabling
> all events that were enabled before the failure.
> 
> > 
> >       /* 
> >        * If the retval is not 0, it mean at least one rv_attach_trace_probe()
> >        * is WARN_ONCE(). I am not sure that if the first WARN_ONCE() happened,
> >        * then return directly or at here after all rv_attach_trace_probe() is
> >        * called and check the retval is 0 or 1.
> >        */
> >       if (retval)
> >              return -1;
> 
> and here the system state is even worse than WARNING and doing nothing: the monitor is
> disabled, but the tracepoints that were registered are still hooked to the system...
> and you cannot unhook them because the monitor is not enabled.
> 
> You still can unhook in current implementation.

Yes.

Thanks,
Tao
> 
> So, for the in-kernel version, the current method is equivalent to the
> the way we do on other tracers, and the monitors only compile if the
> tracepoints exist, the callback has the correct signature and WARNs
> in case of problems in the tracepoint.
> 
> There will be a more robust way to do this, and it will be included in the
> "add module support" patch set. But is its better to add it in a patch
> set because we can analyze change by change instead of adding on top
> of this initial implementation - which is quite large already.
> 
> >       return retval;
> > }
> > 
> >> +
> >> +		if (!retval)
> >> +			retval = count;
> >> +
> >> +		break;
> >> +	}
> > 
> >> +/**
> >> + * rv_register_monitor - register a rv monitor.
> >> + * @monitor:    The rv_monitor to be registered.
> >> + *
> >> + * Returns 0 if successful, error otherwise.
> >> + */
> >> +int rv_register_monitor(struct rv_monitor *monitor)
> >> +{
> >> +	struct rv_monitor_def *r;
> >> +	int retval = 0;
> >> +
> >> +	if (strlen(monitor->name) >= MAX_RV_MONITOR_NAME_SIZE) {
> > 
> > s/>=/>/ no? The same check happened in patch 2. Thanks,
> 
> Yep, this can be improved. But it is not a BUG, as it is allowing monitor
>  with (MAX_RV_MONITOR_NAME_SIZE - 1) size, which is safe.
> 
> Given that neither 'wip' or 'wwnr' are >= MAX_RV_MONITOR_NAME_SIZE, this
> problem is not happening - and no other monitor can hit it because modules
> are not yet supported.
> 
> I took note and will patch it.
> 
> >> +		pr_info("Monitor %s has a name longer than %d\n", monitor->name,
> >> +			MAX_RV_MONITOR_NAME_SIZE);
> 
> Thanks!
> -- Daniel
