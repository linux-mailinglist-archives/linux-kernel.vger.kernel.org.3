Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEA4581AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 22:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbiGZUBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 16:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGZUBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:01:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B7A326ED;
        Tue, 26 Jul 2022 13:01:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C51D615ED;
        Tue, 26 Jul 2022 20:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A976C433D6;
        Tue, 26 Jul 2022 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658865663;
        bh=6NJeN+D2hyZGUBQf9aBrKUNEkQeh2q4YMWMFPDmf+TI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RI4bN6mG8As74Nv4gtBr+NSqX5qQBew+CJzVVUxZW2dHI3/+FJiCpXFsiodCD1ih1
         OIiCMhq7uHZ609/bupE8cYfUE84R9PKf0nO2Q3oEfMuYl9n7PZZVtAInMyDOXm9zRI
         /6Dh8C0gLvX6ypcZ0wiFKeV8NkVsNiniNEYL59tnosbeP7ukaYHKxg40IgpHXlTsxB
         TLT4JK8QY+h7k4IfDtArNpTM6QGn/pDLXo7UbkRP2jLUuKXEVVcn99BltQOJOUe3X+
         78M1hDTXGRGmuXps/HXXx8NpaXs7yjuRy59Lladov9DPcX1QWcr/n8G/gwaLBas8zY
         JZSAezSbxljPw==
Message-ID: <1e03adf9-2aea-63ab-93ae-a73836a7081a@kernel.org>
Date:   Tue, 26 Jul 2022 22:00:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V7 01/16] rv: Add Runtime Verification (RV) interface
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
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
        Tao Zhou <tao.zhou@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1658778484.git.bristot@kernel.org>
 <2aa3b18239f170ba23263f18d166d08634ed65dd.1658778484.git.bristot@kernel.org>
 <20220726122237.44386359@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220726122237.44386359@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 18:22, Steven Rostedt wrote:
> On Mon, 25 Jul 2022 22:11:13 +0200
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
> 
>> +/**
>> + * rv_disable_monitor - disable a given runtime monitor
>> + *
>> + * Returns 0 on success.
>> + */
>> +int rv_disable_monitor(struct rv_monitor_def *mdef)
>> +{
>> +	int enabled;
>> +
>> +	enabled = __rv_disable_monitor(mdef);
>> +
> 
> Does this function need to be holding any locks when called?
> 
> Because it is not static, and that means something can call it without
> locks. If needed, you need to add a lockdep_assert() helper.

Ooops, yes, it needs!

I reworked this function so it gets the lock, and __rv_disabled_monitor() now checks
lockdep_assert().

>> +	if (enabled) {
>> +		/*
>> +		 * Wait for the execution of all previous events.
>> +		 */
>> +		tracepoint_synchronize_unregister();
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * rv_enable_monitor - enable a given runtime monitor
>> + *
>> + * Returns 0 on success, error otherwise.
>> + */
>> +int rv_enable_monitor(struct rv_monitor_def *mdef)
>> +{
>> +	int retval;
>> +
>> +	if (mdef->monitor->enabled)
>> +		return 0;
>> +
>> +	retval = mdef->monitor->enable();
>> +
>> +	if (!retval)
>> +		mdef->monitor->enabled = 1;
>> +
>> +	return retval;
>> +}
>> +
>> +/*
>> + * interface for enabling/disabling a monitor.
>> + */
>> +static ssize_t monitor_enable_write_data(struct file *filp, const char __user *user_buf,
>> +					 size_t count, loff_t *ppos)
>> +{
>> +	struct rv_monitor_def *mdef = filp->private_data;
>> +	int retval;
>> +	bool val;
>> +
>> +	retval = kstrtobool_from_user(user_buf, count, &val);
>> +	if (retval)
>> +		return retval;
>> +
>> +	retval = count;
>> +
>> +	mutex_lock(&rv_interface_lock);
>> +
>> +	if (val)
>> +		retval = rv_enable_monitor(mdef);
>> +	else
>> +		retval = rv_disable_monitor(mdef);

and these call __rv_disabled/__rv_enable... as the lock is taken.

>> +
>> +	mutex_unlock(&rv_interface_lock);
>> +
>> +	return retval ? : count;
>> +}
>> +
> 
> [..]
> 
>> +
>> +/*
>> + * enabled_monitors interface.
>> + */
>> +static void disable_all_monitors(void)
>> +{
>> +	struct rv_monitor_def *mdef;
>> +	int enabled = 0;
>> +
>> +	mutex_lock(&rv_interface_lock);
>> +
>> +	list_for_each_entry(mdef, &rv_monitors_list, list)
>> +		enabled += __rv_disable_monitor(mdef);
>> +
>> +	if (enabled) {
>> +		/*
>> +		 * Wait for the execution of all current events.
>> +		 */
> 
> And do we really need to hold the locks when calling the synchronization?
> 
> I think we only care if the caller sees a synchronized view of changes, the
> locks will help synchronize the internal code.

I think we need. For instance:

CPU 0:				CPU 1:
disable_monitor(x)              enable_monitor(x)
   lock()
	disable()
   unlock()      		lock()
   wait without the lock  	    enable()
   	
        <old preempted events with inconsistent data>

so by holding the lock we avoid this case...

no?

>> +		tracepoint_synchronize_unregister();
>> +	}
>> +
>> +	mutex_unlock(&rv_interface_lock);
>> +}
>> +
> 
> [..]
> 
>> +/**
>> + * rv_monitoring_on - checks if monitoring is on
>> + *
>> + * Returns 1 if on, 0 otherwise.
>> + */
>> +bool rv_monitoring_on(void)
>> +{
>> +	/* monitoring_on */
> 
> You need a better comment than that.
> 
> What is this synchronizing?


like:
	/* Ensures that concurrent monitors reads a consistent data */

But I wonder if it is needed, given that we now wait for all the events
to be processed before switching it back again, e.g., having the
monitoring_on as old data is not a problem.

>> +	smp_rmb();
>> +	return READ_ONCE(monitoring_on);
>> +}
>> +
>> +/*
>> + * monitoring_on general switcher.
>> + */
>> +static ssize_t monitoring_on_read_data(struct file *filp, char __user *user_buf,
>> +				       size_t count, loff_t *ppos)
>> +{
>> +	const char *buff;
>> +
>> +	buff = rv_monitoring_on() ? "1\n" : "0\n";
>> +
>> +	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff) + 1);
>> +}
>> +
>> +static void turn_monitoring_off(void)
>> +{
>> +	WRITE_ONCE(monitoring_on, false);
>> +	/* monitoring_on */
> 
> Same here.
> 
>> +	smp_wmb();
>> +}
>> +
>> +static void reset_all_monitors(void)
>> +{
>> +	struct rv_monitor_def *mdef;
>> +
>> +	list_for_each_entry(mdef, &rv_monitors_list, list) {
>> +		if (mdef->monitor->enabled)
>> +			mdef->monitor->reset();
>> +	}
>> +}
>> +
>> +static void turn_monitoring_on(void)
>> +{
>> +	reset_all_monitors();
> 
> Why does this reset all monitors but turn_monitoring_off() does not?

When we turn monitoring off, the monitors will stop monitoring while yet
in sync with the events generated by the system, i.e., all the events after
the start were processed.

But if we disabled the monitor, and some events get ignored, the monitors
will be out of sync with the system. Thus, resetting the monitor to
for a synchronization between the monitors and the system is needed, before
enabling monitoring back.

> You should keep that out.

did not get :-(

>> +	WRITE_ONCE(monitoring_on, true);
>> +	/* monitoring_on */
>> +	smp_wmb();
>> +}
>> +
>> +static ssize_t monitoring_on_write_data(struct file *filp, const char __user *user_buf,
>> +					size_t count, loff_t *ppos)
>> +{
>> +	int retval;
>> +	bool val;
>> +
>> +	retval = kstrtobool_from_user(user_buf, count, &val);
>> +	if (retval)
>> +		return retval;
>> +
>> +	mutex_lock(&rv_interface_lock);
>> +
>> +	if (val)
>> +		turn_monitoring_on();
>> +	else
>> +		turn_monitoring_off();
>> +
>> +	/*
>> +	 * Wait for the execution of all current events to notice
>> +	 * the change before returning to user-space.
>> +	 */
>> +	tracepoint_synchronize_unregister();
> 
> Again, I think we want this outside the lock.

I fear a problem similar to the one I said before could happen. For
instance, turning monitoring off and on could result on monitors with
old data being back enable with "reseted" data...

>> +
>> +	mutex_unlock(&rv_interface_lock);
>> +
>> +	return count;
>> +}
>> +
>> +static const struct file_operations monitoring_on_fops = {
>> +	.open   = simple_open,
>> +	.llseek = no_llseek,
>> +	.write  = monitoring_on_write_data,
>> +	.read   = monitoring_on_read_data,
>> +};
>> +
>> +static void destroy_monitor_dir(struct rv_monitor_def *mdef)
>> +{
>> +	rv_remove(mdef->root_d);
>> +}
>> +
>> +/**
>> + * rv_register_monitor - register a rv monitor.
>> + * @monitor:    The rv_monitor to be registered.
>> + *
>> + * Returns 0 if successful, error otherwise.
>> + */
>> +int rv_register_monitor(struct rv_monitor *monitor)
>> +{
>> +	struct rv_monitor_def *r;
>> +	int retval = 0;
>> +
>> +	if (strlen(monitor->name) >= MAX_RV_MONITOR_NAME_SIZE) {
>> +		pr_info("Monitor %s has a name longer than %d\n", monitor->name,
>> +			MAX_RV_MONITOR_NAME_SIZE);
>> +		return -1;
>> +	}
>> +
>> +	mutex_lock(&rv_interface_lock);
>> +
>> +	list_for_each_entry(r, &rv_monitors_list, list) {
>> +		if (strcmp(monitor->name, r->monitor->name) == 0) {
>> +			pr_info("Monitor %s is already registered\n", monitor->name);
>> +			retval = -1;
>> +			goto out_unlock;
>> +		}
>> +	}
>> +
>> +	r = kzalloc(sizeof(struct rv_monitor_def), GFP_KERNEL);
>> +	if (!r) {
>> +		retval = -ENOMEM;
>> +		goto out_unlock;
>> +	}
>> +
>> +	r->monitor = monitor;
>> +
>> +	retval = create_monitor_dir(r);
>> +	if (retval) {
>> +		kfree(r);
>> +		goto out_unlock;
>> +	}
>> +
>> +	list_add_tail(&r->list, &rv_monitors_list);
>> +
>> +out_unlock:
>> +	mutex_unlock(&rv_interface_lock);
>> +	return retval;
>> +}
>> +
>> +/**
>> + * rv_unregister_monitor - unregister a rv monitor.
>> + * @monitor:    The rv_monitor to be unregistered.
>> + *
>> + * Returns 0 if successful, error otherwise.
>> + */
>> +int rv_unregister_monitor(struct rv_monitor *monitor)
>> +{
>> +	struct rv_monitor_def *ptr, *next;
>> +
>> +	mutex_lock(&rv_interface_lock);
>> +
>> +	list_for_each_entry_safe(ptr, next, &rv_monitors_list, list) {
>> +		if (strcmp(monitor->name, ptr->monitor->name) == 0) {
>> +			rv_disable_monitor(ptr);
>> +			list_del(&ptr->list);
>> +			destroy_monitor_dir(ptr);
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&rv_interface_lock);
>> +	return 0;
>> +}
>> +
>> +int __init rv_init_interface(void)
>> +{
>> +	struct dentry *tmp;
>> +
>> +	rv_root.root_dir = rv_create_dir("rv", NULL);
>> +	if (!rv_root.root_dir)
>> +		goto out_err;
>> +
>> +	rv_root.monitors_dir = rv_create_dir("monitors", rv_root.root_dir);
>> +	if (!rv_root.monitors_dir)
>> +		goto out_err;
>> +
>> +	tmp = rv_create_file("available_monitors", RV_MODE_READ, rv_root.root_dir, NULL,
>> +			     &available_monitors_ops);
>> +	if (!tmp)
>> +		goto out_err;
>> +
>> +	tmp = rv_create_file("enabled_monitors", RV_MODE_WRITE, rv_root.root_dir, NULL,
>> +			     &enabled_monitors_ops);
>> +	if (!tmp)
>> +		goto out_err;
>> +
>> +	tmp = rv_create_file("monitoring_on", RV_MODE_WRITE, rv_root.root_dir, NULL,
>> +			     &monitoring_on_fops);
>> +	if (!tmp)
>> +		goto out_err;
>> +
> 
> This should call "turn_monitoriing_on()" instead of open coding it,
> especially since it includes a memory barrier (another reason to not
> reset the monitors in that function.

Here we do not need to reset monitors... but monitors would not be enabled anyway as
they are not loaded yet.... and so I wonder if we need the barrier here...

-- Daniel
> 
> -- Steve
> 
> 
>> +	WRITE_ONCE(monitoring_on, true);
>> +	/* monitoring_on */
>> +	smp_wmb();
>> +
>> +	return 0;
>> +
>> +out_err:
>> +	rv_remove(rv_root.root_dir);
>> +	printk(KERN_ERR "RV: Error while creating the RV interface\n");
>> +	return 1;
>> +}

