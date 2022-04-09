Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D296E4FA963
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbiDIP7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiDIP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:59:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA531B60BB;
        Sat,  9 Apr 2022 08:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11B5860B3D;
        Sat,  9 Apr 2022 15:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CA3C385A0;
        Sat,  9 Apr 2022 15:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649519851;
        bh=vHrf3GlPWwjvas0y0BFsbrS1upMqeKahsNTbwbLOZfA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EJ+hQ8oxkGIKACi4leHIaD5I/w08kzqdIJXVfWGvFZmEB/h2DnXtBdSl7pdLkRGPK
         FQknp/w+JLzSfClVJLEDC7yZirrDoT9sM/sFIf4AJw5/gga0PkxL+bJah0L8Mc8bcP
         grXeuJpCTpT/t4NzWM8pgFNbnBlT0Pcj4jaf8ulmVnQ3ccNBJHBZI/64PE3SddACWM
         P3Smdke5eYGlvxXmXlubd4pyGT5ElthN5EoySolyU9EgHsLRRXewqZtwy//tZ6vSpJ
         Q99yiOdu9CB+OKkY8wK0Jg7Juzl9N4E4mST220iXxGjTHQbvtY7DLOQblWaNP+Ctjj
         gHfx5JUrZh8sg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 11C515C09EF; Sat,  9 Apr 2022 08:57:31 -0700 (PDT)
Date:   Sat, 9 Apr 2022 08:57:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Helge Deller <deller@gmx.de>, Marco Elver <elver@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Phil Auld <pauld@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Wang Qing <wangqing@vivo.com>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v2 09/12] printk: add functions to prefer direct
 printing
Message-ID: <20220409155731.GP4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-10-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405132535.649171-10-john.ogness@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 03:31:32PM +0206, John Ogness wrote:
> Once kthread printing is available, console printing will no longer
> occur in the context of the printk caller. However, there are some
> special contexts where it is desirable for the printk caller to
> directly print out kernel messages. Using pr_flush() to wait for
> threaded printers is only possible if the caller is in a sleepable
> context and the kthreads are active. That is not always the case.
> 
> Introduce printk_prefer_direct_enter() and printk_prefer_direct_exit()
> functions to explicitly (and globally) activate/deactivate preferred
> direct console printing. The term "direct console printing" refers to
> printing to all enabled consoles from the context of the printk
> caller. The term "prefer" is used because this type of printing is
> only best effort. If the console is currently locked or other
> printers are already actively printing, the printk caller will need
> to rely on the other contexts to handle the printing.
> 
> This preferred direct printing is how all printing is currently
> handled (unless explicitly deferred).
> 
> When kthread printing is introduced, there may be some unanticipated
> problems due to kthreads being unable to flush important messages.
> In order to minimize such risks, preferred direct printing is
> activated for the primary important messages when the system
> experiences general types of major errors. These are:
> 
>  - emergency reboot/shutdown
>  - cpu and rcu stalls
>  - hard and soft lockups
>  - hung tasks
>  - warn
>  - sysrq
> 
> Note that since kthread printing does not yet exist, no behavior
> changes result from this commit. This is only implementing the
> counter and marking the various places where preferred direct
> printing is active.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

From an RCU perspective:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  drivers/tty/sysrq.c     |  2 ++
>  include/linux/printk.h  | 11 +++++++++++
>  kernel/hung_task.c      | 11 ++++++++++-
>  kernel/panic.c          |  4 ++++
>  kernel/printk/printk.c  | 28 ++++++++++++++++++++++++++++
>  kernel/rcu/tree_stall.h |  2 ++
>  kernel/reboot.c         | 14 +++++++++++++-
>  kernel/watchdog.c       |  4 ++++
>  kernel/watchdog_hld.c   |  4 ++++
>  9 files changed, 78 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index bbfd004449b5..2884cd638d64 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -578,6 +578,7 @@ void __handle_sysrq(int key, bool check_mask)
>  
>  	rcu_sysrq_start();
>  	rcu_read_lock();
> +	printk_prefer_direct_enter();
>  	/*
>  	 * Raise the apparent loglevel to maximum so that the sysrq header
>  	 * is shown to provide the user with positive feedback.  We do not
> @@ -619,6 +620,7 @@ void __handle_sysrq(int key, bool check_mask)
>  		pr_cont("\n");
>  		console_loglevel = orig_log_level;
>  	}
> +	printk_prefer_direct_exit();
>  	rcu_read_unlock();
>  	rcu_sysrq_end();
>  
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 091fba7283e1..cd26aab0ab2a 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -170,6 +170,9 @@ extern void __printk_safe_exit(void);
>  #define printk_deferred_enter __printk_safe_enter
>  #define printk_deferred_exit __printk_safe_exit
>  
> +extern void printk_prefer_direct_enter(void);
> +extern void printk_prefer_direct_exit(void);
> +
>  extern bool pr_flush(int timeout_ms, bool reset_on_progress);
>  
>  /*
> @@ -222,6 +225,14 @@ static inline void printk_deferred_exit(void)
>  {
>  }
>  
> +static inline void printk_prefer_direct_enter(void)
> +{
> +}
> +
> +static inline void printk_prefer_direct_exit(void)
> +{
> +}
> +
>  static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
>  {
>  	return true;
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 52501e5f7655..02a65d554340 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -127,6 +127,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  	 * complain:
>  	 */
>  	if (sysctl_hung_task_warnings) {
> +		printk_prefer_direct_enter();
> +
>  		if (sysctl_hung_task_warnings > 0)
>  			sysctl_hung_task_warnings--;
>  		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
> @@ -142,6 +144,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  
>  		if (sysctl_hung_task_all_cpu_backtrace)
>  			hung_task_show_all_bt = true;
> +
> +		printk_prefer_direct_exit();
>  	}
>  
>  	touch_nmi_watchdog();
> @@ -204,12 +208,17 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  	}
>   unlock:
>  	rcu_read_unlock();
> -	if (hung_task_show_lock)
> +	if (hung_task_show_lock) {
> +		printk_prefer_direct_enter();
>  		debug_show_all_locks();
> +		printk_prefer_direct_exit();
> +	}
>  
>  	if (hung_task_show_all_bt) {
>  		hung_task_show_all_bt = false;
> +		printk_prefer_direct_enter();
>  		trigger_all_cpu_backtrace();
> +		printk_prefer_direct_exit();
>  	}
>  
>  	if (hung_task_call_panic)
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 55b50e052ec3..7d422597403f 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -560,6 +560,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>  {
>  	disable_trace_on_warning();
>  
> +	printk_prefer_direct_enter();
> +
>  	if (file)
>  		pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
>  			raw_smp_processor_id(), current->pid, file, line,
> @@ -597,6 +599,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>  
>  	/* Just a warning, don't kill lockdep. */
>  	add_taint(taint, LOCKDEP_STILL_OK);
> +
> +	printk_prefer_direct_exit();
>  }
>  
>  #ifndef __WARN_FLAGS
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index d0369afaf365..258d02cff140 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -362,6 +362,34 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
>  static DEFINE_MUTEX(syslog_lock);
>  
>  #ifdef CONFIG_PRINTK
> +static atomic_t printk_prefer_direct = ATOMIC_INIT(0);
> +
> +/**
> + * printk_prefer_direct_enter - cause printk() calls to attempt direct
> + *                              printing to all enabled consoles
> + *
> + * Since it is not possible to call into the console printing code from any
> + * context, there is no guarantee that direct printing will occur.
> + *
> + * This globally effects all printk() callers.
> + *
> + * Context: Any context.
> + */
> +void printk_prefer_direct_enter(void)
> +{
> +	atomic_inc(&printk_prefer_direct);
> +}
> +
> +/**
> + * printk_prefer_direct_exit - restore printk() behavior
> + *
> + * Context: Any context.
> + */
> +void printk_prefer_direct_exit(void)
> +{
> +	WARN_ON(atomic_dec_if_positive(&printk_prefer_direct) < 0);
> +}
> +
>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
>  /* All 3 protected by @syslog_lock. */
>  /* the next printk record to read by syslog(READ) or /proc/kmsg */
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 0c5d8516516a..d612707c2ed0 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -619,6 +619,7 @@ static void print_cpu_stall(unsigned long gps)
>  	 * See Documentation/RCU/stallwarn.rst for info on how to debug
>  	 * RCU CPU stall warnings.
>  	 */
> +	printk_prefer_direct_enter();
>  	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
>  	pr_err("INFO: %s self-detected stall on CPU\n", rcu_state.name);
>  	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
> @@ -656,6 +657,7 @@ static void print_cpu_stall(unsigned long gps)
>  	 */
>  	set_tsk_need_resched(current);
>  	set_preempt_need_resched();
> +	printk_prefer_direct_exit();
>  }
>  
>  static void check_cpu_stall(struct rcu_data *rdp)
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 6bcc5d6a6572..4177645e74d6 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -447,9 +447,11 @@ static int __orderly_reboot(void)
>  	ret = run_cmd(reboot_cmd);
>  
>  	if (ret) {
> +		printk_prefer_direct_enter();
>  		pr_warn("Failed to start orderly reboot: forcing the issue\n");
>  		emergency_sync();
>  		kernel_restart(NULL);
> +		printk_prefer_direct_exit();
>  	}
>  
>  	return ret;
> @@ -462,6 +464,7 @@ static int __orderly_poweroff(bool force)
>  	ret = run_cmd(poweroff_cmd);
>  
>  	if (ret && force) {
> +		printk_prefer_direct_enter();
>  		pr_warn("Failed to start orderly shutdown: forcing the issue\n");
>  
>  		/*
> @@ -471,6 +474,7 @@ static int __orderly_poweroff(bool force)
>  		 */
>  		emergency_sync();
>  		kernel_power_off();
> +		printk_prefer_direct_exit();
>  	}
>  
>  	return ret;
> @@ -528,6 +532,8 @@ EXPORT_SYMBOL_GPL(orderly_reboot);
>   */
>  static void hw_failure_emergency_poweroff_func(struct work_struct *work)
>  {
> +	printk_prefer_direct_enter();
> +
>  	/*
>  	 * We have reached here after the emergency shutdown waiting period has
>  	 * expired. This means orderly_poweroff has not been able to shut off
> @@ -544,6 +550,8 @@ static void hw_failure_emergency_poweroff_func(struct work_struct *work)
>  	 */
>  	pr_emerg("Hardware protection shutdown failed. Trying emergency restart\n");
>  	emergency_restart();
> +
> +	printk_prefer_direct_exit();
>  }
>  
>  static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
> @@ -582,11 +590,13 @@ void hw_protection_shutdown(const char *reason, int ms_until_forced)
>  {
>  	static atomic_t allow_proceed = ATOMIC_INIT(1);
>  
> +	printk_prefer_direct_enter();
> +
>  	pr_emerg("HARDWARE PROTECTION shutdown (%s)\n", reason);
>  
>  	/* Shutdown should be initiated only once. */
>  	if (!atomic_dec_and_test(&allow_proceed))
> -		return;
> +		goto out;
>  
>  	/*
>  	 * Queue a backup emergency shutdown in the event of
> @@ -594,6 +604,8 @@ void hw_protection_shutdown(const char *reason, int ms_until_forced)
>  	 */
>  	hw_failure_emergency_poweroff(ms_until_forced);
>  	orderly_poweroff(true);
> +out:
> +	printk_prefer_direct_exit();
>  }
>  EXPORT_SYMBOL_GPL(hw_protection_shutdown);
>  
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 9166220457bc..40024e03d422 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -424,6 +424,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  		/* Start period for the next softlockup warning. */
>  		update_report_ts();
>  
> +		printk_prefer_direct_enter();
> +
>  		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
>  			smp_processor_id(), duration,
>  			current->comm, task_pid_nr(current));
> @@ -442,6 +444,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
>  		if (softlockup_panic)
>  			panic("softlockup: hung tasks");
> +
> +		printk_prefer_direct_exit();
>  	}
>  
>  	return HRTIMER_RESTART;
> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> index 247bf0b1582c..701f35f0e2d4 100644
> --- a/kernel/watchdog_hld.c
> +++ b/kernel/watchdog_hld.c
> @@ -135,6 +135,8 @@ static void watchdog_overflow_callback(struct perf_event *event,
>  		if (__this_cpu_read(hard_watchdog_warn) == true)
>  			return;
>  
> +		printk_prefer_direct_enter();
> +
>  		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n",
>  			 this_cpu);
>  		print_modules();
> @@ -155,6 +157,8 @@ static void watchdog_overflow_callback(struct perf_event *event,
>  		if (hardlockup_panic)
>  			nmi_panic(regs, "Hard LOCKUP");
>  
> +		printk_prefer_direct_exit();
> +
>  		__this_cpu_write(hard_watchdog_warn, true);
>  		return;
>  	}
> -- 
> 2.30.2
> 
