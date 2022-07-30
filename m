Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192AB585B50
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiG3RB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 13:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiG3RBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 13:01:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA531DDE;
        Sat, 30 Jul 2022 10:01:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18C4960E9B;
        Sat, 30 Jul 2022 17:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68CEC433D6;
        Sat, 30 Jul 2022 17:01:51 +0000 (UTC)
Date:   Sat, 30 Jul 2022 13:01:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
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
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V9 01/16] rv: Add Runtime Verification (RV) interface
Message-ID: <20220730130145.46f0d57c@rorschach.local.home>
In-Reply-To: <YuU7TGxm5pzmBFTx@geo.homenetwork>
References: <cover.1659052063.git.bristot@kernel.org>
        <a4bfe038f50cb047bfb343ad0e12b0e646ab308b.1659052063.git.bristot@kernel.org>
        <YuU7TGxm5pzmBFTx@geo.homenetwork>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2022 22:08:12 +0800
Tao Zhou <tao.zhou@linux.dev> wrote:

> On Fri, Jul 29, 2022 at 11:38:40AM +0200, Daniel Bristot de Oliveira wrote:
> 
> > +static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool sync)
> > +{
> > +	lockdep_assert_held(&rv_interface_lock);
> > +
> > +	if (mdef->monitor->enabled) {
> > +		mdef->monitor->enabled = 0;
> > +		mdef->monitor->disable();  
> 
> If call disable(), the @enabled is set 0 there.

Perhaps that is not a given. I'm guessing that ->disable() can not fail.

> 
> > +
> > +		/*
> > +		 * Wait for the execution of all events to finish.
> > +		 * Otherwise, the data used by the monitor could
> > +		 * be inconsistent. i.e., if the monitor is re-enabled.
> > +		 */
> > +		if (sync)
> > +			tracepoint_synchronize_unregister();
> > +		return 1;  
> 
> Return 0 indicate the actually disabling and successed.

negative is usually unsuccessful. 1 and 0 can be anything we really
choose it to be. But should be commented at the top for clarification.


> 
> > +	}
> > +	return 0;  
> 
> If disable a diabled monitor, return error(negative).
> 
> > +}
> > +
> > +/**
> > + * rv_disable_monitor - disable a given runtime monitor
> > + *
> > + * Returns 0 on success.
> > + */
> > +int rv_disable_monitor(struct rv_monitor_def *mdef)
> > +{
> > +	__rv_disable_monitor(mdef, true);
> > +	return 0;  
> 
> Always return 0 here, whatever the return value of __rv_disable_monitor().
> And this enforce me to look more here, see below.

As for now, disable can not fail. But OK to return a status in that
case that changes in the future.

> 
> > +}  
> 
> > +static ssize_t enabled_monitors_write(struct file *filp, const char __user *user_buf,
> > +				      size_t count, loff_t *ppos)
> > +{
> > +	char buff[MAX_RV_MONITOR_NAME_SIZE + 2];
> > +	struct rv_monitor_def *mdef;
> > +	int retval = -EINVAL;
> > +	bool enable = true;
> > +	char *ptr = buff;
> > +	int len;
> > +
> > +	if (count < 1 || count > MAX_RV_MONITOR_NAME_SIZE + 1)
> > +		return -EINVAL;
> > +
> > +	memset(buff, 0, sizeof(buff));
> > +
> > +	retval = simple_write_to_buffer(buff, sizeof(buff) - 1, ppos, user_buf, count);
> > +	if (retval < 0)
> > +		return -EFAULT;
> > +
> > +	ptr = strim(buff);
> > +
> > +	if (ptr[0] == '!') {
> > +		enable = false;
> > +		ptr++;
> > +	}
> > +
> > +	len = strlen(ptr);
> > +	if (!len)
> > +		return count;
> > +
> > +	mutex_lock(&rv_interface_lock);
> > +
> > +	retval = -EINVAL;
> > +
> > +	list_for_each_entry(mdef, &rv_monitors_list, list) {
> > +		if (strcmp(ptr, mdef->monitor->name) != 0)
> > +			continue;
> > +
> > +		/*
> > +		 * Monitor found!
> > +		 */
> > +		if (enable)
> > +			retval = rv_enable_monitor(mdef);
> > +		else
> > +			retval = rv_disable_monitor(mdef);  
> 
> About the retval here. If count == 1 and retval == 0, then
> `retval = count` --> retval == 1. This retval will be returned to 

Both rv_enable_monitor() and rv_disable_monitor() return either 0 on
success or negative on failure. Do not confuse the internal callers
(that start with "__") as the return values of these.

User space will only see 0 or negative.

> user space and dedicate that how many character read and success
> If retval is 1(it is not possiable, the return value of
> da_monitor_init_*() called in enable callback in rv_enable_monitor()
> will be 0, so that return value check is not needed, or any other functions
> called in enable callback need to check the return value then, so I checked
> the WARN_ONCE() called in macro rv_attach_trace_probe() which is called in
> enable callback, if the WARN_ONCE is called, it means that something go wrong.
> We need to check the return value of WARN_ONCE() in enable callback), the
> return value will be returned to user space but actually the error(warn) happened.
> User space do not know. They treat the two kind of return value 1 the same
> but one is the write count value successed and another is the write error
> value returned.
> In enable callback, check rv_attach_trace_probe():

Yes, the enable callbacks should return negative on error.

> 
> static int enable_wip(void)
> {
>       int retval = 1;

Probably want this to be "retval = 0;"

>  	  
>       /* 
>        * Delete the check of return value of da_monitor_init_wip()
>        * because it is always 0
>        */
>       da_monitor_init_wip();
> 
>       retval &= rv_attach_trace_probe("wip", preempt_enable, handle_preempt_enable);
>       retval &= rv_attach_trace_probe("wip", sched_waking, handle_sched_waking);
>       retval &= rv_attach_trace_probe("wip", preempt_disable, handle_preempt_disable);

And this to be "retval |= "

where rv_attach_trace_probe() returns 0 on success and something else on error.

> 
>       /* 
>        * If the retval is not 0, it mean at least one rv_attach_trace_probe()
>        * is WARN_ONCE(). I am not sure that if the first WARN_ONCE() happened,
>        * then return directly or at here after all rv_attach_trace_probe() is
>        * called and check the retval is 0 or 1.

Well, the above is not true. If any "succeed" and return zero, with the
"&=" it will be zero if only one succeeds and then rest fail. That's
why you want the "|=" and set the flag on error.

We could change the macro to:

#define rv_attach_trace_probe(monitor, tp, rv_handler)                                  \
        ({                                                                            \
                check_trace_callback_type_##tp(rv_handler);                             \
                WARN_ONCE(register_trace_##tp(rv_handler, NULL),                        \
                                "fail attaching " #monitor " " #tp "handler");          \
        })

Where the macro returns the result of the WARN_ONCE() which is zero on
success (no warning) and non-zero otherwise.


>        */
>       if (retval)
>              return -1;
>       return retval;
> }
> 
> > +
> > +		if (!retval)
> > +			retval = count;
> > +
> > +		break;
> > +	}  
> 
> > +/**
> > + * rv_register_monitor - register a rv monitor.
> > + * @monitor:    The rv_monitor to be registered.
> > + *
> > + * Returns 0 if successful, error otherwise.
> > + */
> > +int rv_register_monitor(struct rv_monitor *monitor)
> > +{
> > +	struct rv_monitor_def *r;
> > +	int retval = 0;
> > +
> > +	if (strlen(monitor->name) >= MAX_RV_MONITOR_NAME_SIZE) {  
> 
> s/>=/>/ no? The same check happened in patch 2. Thanks,  

Correct. Because strlen() does not include the nul byte.

> 
> > +		pr_info("Monitor %s has a name longer than %d\n", monitor->name,
> > +			MAX_RV_MONITOR_NAME_SIZE);  


-- Steve
