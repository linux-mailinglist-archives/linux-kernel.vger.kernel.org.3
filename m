Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFFB558A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiFWUkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiFWUkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:40:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964B8609D4;
        Thu, 23 Jun 2022 13:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 366AA61DEB;
        Thu, 23 Jun 2022 20:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE59CC341C0;
        Thu, 23 Jun 2022 20:40:45 +0000 (UTC)
Date:   Thu, 23 Jun 2022 16:40:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V4 02/20] rv: Add runtime reactors interface
Message-ID: <20220623164044.5a863843@rorschach.local.home>
In-Reply-To: <83874ccd86a34f6f2a4e6a8ca1fbe474685d6ba9.1655368610.git.bristot@kernel.org>
References: <cover.1655368610.git.bristot@kernel.org>
        <83874ccd86a34f6f2a4e6a8ca1fbe474685d6ba9.1655368610.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 10:44:44 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 205e65f57637..1e48c6bb74bf 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -8,6 +8,13 @@
>   */
>  #ifndef _LINUX_RV_H
>  #define _LINUX_RV_H
> +
> +struct rv_reactor {
> +	char			*name;
> +	char			*description;
> +	void			(*react)(char *msg);
> +};
> +
>  struct rv_monitor {
>  	const char		*name;
>  	const char		*description;
> @@ -15,9 +22,15 @@ struct rv_monitor {
>  	int			(*start)(void);
>  	void			(*stop)(void);
>  	void			(*reset)(void);
> +	void			(*react)(char *msg);
> +
>  };
>  
>  extern bool monitoring_on;
>  int rv_unregister_monitor(struct rv_monitor *monitor);
>  int rv_register_monitor(struct rv_monitor *monitor);
> +
> +extern bool reacting_on;
> +int rv_unregister_reactor(struct rv_reactor *reactor);
> +int rv_register_reactor(struct rv_reactor *reactor);
>  #endif /* _LINUX_RV_H */
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 6d127cdb00dd..560408fec0c8 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -10,3 +10,17 @@ menuconfig RV
>  	  theorem proving). RV works by analyzing the trace of the system's
>  	  actual execution, comparing it against a formal specification of
>  	  the system behavior.
> +
> +if RV

Remove the above.

> +
> +config RV_REACTORS
> +	bool "Runtime verification reactors"
> +	default y if RV

	default y
	DEPENDS ON RV

> +	help
> +	  Enables the online runtime verification reactors. A runtime
> +	  monitor can cause a reaction to the detection of an exception
> +	  on the model's execution. By default, the monitors have
> +	  tracing reactions, printing the monitor output via tracepoints,
> +	  but other reactions can be added (on-demand) via this interface.
> +
> +endif # RV
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index fd995379df67..8944274d9b41 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_RV) += rv.o
> +obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 43af7b13187e..7576d492a974 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -362,8 +362,13 @@ static int create_monitor_dir(struct rv_monitor_def *mdef)
>  		retval = -ENOMEM;
>  		goto out_remove_root;
>  	}
> +#ifdef CONFIG_RV_REACTORS

Could you move the ifdefs to a header or above, and then just make
theses functions into nops when not defined. Keeps the actual code
cleaner.

> +	retval = reactor_create_monitor_files(mdef);
> +	if (retval)
> +		goto out_remove_root;
> +#endif
>  
> -	return retval;
> +	return 0;
>  
>  out_remove_root:
>  	rv_remove(mdef->root_d);
> @@ -674,7 +679,11 @@ int rv_register_monitor(struct rv_monitor *monitor)
>  
>  	r->monitor = monitor;
>  
> -	create_monitor_dir(r);
> +	retval = create_monitor_dir(r);
> +	if (retval) {
> +		kfree(r);
> +		goto out_unlock;
> +	}
>  
>  	list_add_tail(&r->list, &rv_monitors_list);
>  
> @@ -732,6 +741,11 @@ int __init rv_init_interface(void)
>  	rv_create_file("monitoring_on", 0600, rv_root.root_dir, NULL,
>  		       &monitoring_on_fops);
>  
> +#ifdef CONFIG_RV_REACTORS
> +	init_rv_reactors(rv_root.root_dir);
> +	reacting_on = true;

Same here.

Could have init_rv_reactors() return a value and then:

	if (init_rv_reactors(...))
		reacting_on = true;


> +#endif
> +
>  	monitoring_on = true;
>  
>  	return 0;
> diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
> index 0796867a7b1e..6d43f52d72a9 100644
> --- a/kernel/trace/rv/rv.h
> +++ b/kernel/trace/rv/rv.h
> @@ -15,14 +15,28 @@ struct rv_interface {
>  #define rv_remove			tracefs_remove
>  
>  #define MAX_RV_MONITOR_NAME_SIZE	32
> +#define MAX_RV_REACTOR_NAME_SIZE	32
>  
>  extern struct mutex rv_interface_lock;
>  
> +#ifdef CONFIG_RV_REACTORS
> +struct rv_reactor_def {
> +	struct list_head list;
> +	struct rv_reactor *reactor;
> +	/* protected by the monitor interface lock */
> +	int counter;
> +};
> +#endif
> +
>  struct rv_monitor_def {
>  	struct list_head list;
>  	struct rv_monitor *monitor;
> +#ifdef CONFIG_RV_REACTORS
> +	struct rv_reactor_def *rdef;
> +#endif
>  	struct dentry *root_d;
>  	bool enabled;
> +	bool reacting;
>  	bool task_monitor;
>  };
>  
> @@ -32,3 +46,9 @@ void reset_all_monitors(void);
>  int init_rv_monitors(struct dentry *root_dir);
>  int get_task_monitor_slot(void);
>  void put_task_monitor_slot(int slot);
> +
> +#ifdef CONFIG_RV_REACTORS
> +extern bool reacting_on;
> +int reactor_create_monitor_files(struct rv_monitor_def *mdef);
> +int init_rv_reactors(struct dentry *root_dir);
> +#endif
> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
> new file mode 100644
> index 000000000000..bfe54d6996cc
> --- /dev/null
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -0,0 +1,476 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Runtime reactor interface.
> + *
> + * A runtime monitor can cause a reaction to the detection of an
> + * exception on the model's execution. By default, the monitors have
> + * tracing reactions, printing the monitor output via tracepoints.
> + * But other reactions can be added (on-demand) via this interface.
> + *
> + * == Registering reactors ==
> + *
> + * The struct rv_reactor defines a callback function to be executed
> + * in case of a model exception happens. The callback function
> + * receives a message to be (optionally) printed before executing
> + * the reaction.
> + *
> + * A RV reactor is registered via:
> + *   int rv_register_reactor(struct rv_reactor *reactor)
> + * And unregistered via:
> + *   int rv_unregister_reactor(struct rv_reactor *reactor)
> + *
> + * These functions are exported to modules, enabling reactors to be
> + * dynamically loaded.
> + *
> + * == User interface ==
> + *
> + * The user interface resembles the kernel tracing interface and
> + * presents these files:
> + *
> + *  "available_reactors"
> + *    - List the available reactors, one per line.
> + *
> + *    For example:
> + *    [root@f32 rv]# cat available_reactors
> + *    nop
> + *    panic
> + *    printk
> + *
> + *  "reacting_on"
> + *    - It is an on/off general switch for reactors, disabling
> + *    all reactions.
> + *
> + *  "monitors/MONITOR/reactors"
> + *    - List available reactors, with the select reaction for the given
> + *    MONITOR inside []. The defaul one is the nop (no operation)
> + *    reactor.
> + *    - Writing the name of an reactor enables it to the given
> + *    MONITOR.
> + *
> + *    For example:
> + *    [root@f32 rv]# cat monitors/wip/reactors
> + *    [nop]
> + *    panic
> + *    printk
> + *    [root@f32 rv]# echo panic > monitors/wip/reactors
> + *    [root@f32 rv]# cat monitors/wip/reactors
> + *    nop
> + *    [panic]
> + *    printk
> + *
> + * Copyright (C) 2019-2022 Daniel Bristot de Oliveira <bristot@kernel.org>
> + */
> +
> +#include <linux/slab.h>
> +
> +#include "rv.h"
> +
> +bool __read_mostly reacting_on;
> +
> +/*
> + * Interface for the reactor register.
> + */
> +LIST_HEAD(rv_reactors_list);
> +
> +static struct rv_reactor_def *get_reactor_rdef_by_name(char *name)
> +{
> +	struct rv_reactor_def *r;
> +
> +	list_for_each_entry(r, &rv_reactors_list, list) {
> +		if (strcmp(name, r->reactor->name) == 0)
> +			return r;
> +	}
> +	return NULL;
> +}
> +
> +/*
> + * Available reactors seq functions.
> + */
> +static int reactors_show(struct seq_file *m, void *p)
> +{
> +	struct rv_reactor_def *rea_def = p;
> +
> +	seq_printf(m, "%s\n", rea_def->reactor->name);
> +	return 0;
> +}
> +
> +static void reactors_stop(struct seq_file *m, void *p)
> +{
> +	mutex_unlock(&rv_interface_lock);
> +}
> +
> +static void *reactors_start(struct seq_file *m, loff_t *pos)
> +{
> +	mutex_lock(&rv_interface_lock);
> +	return seq_list_start(&rv_reactors_list, *pos);
> +}
> +
> +static void *reactors_next(struct seq_file *m, void *p, loff_t *pos)
> +{
> +	return seq_list_next(p, &rv_reactors_list, pos);
> +}
> +
> +/*
> + * available reactors seq definition.
> + */
> +static const struct seq_operations available_reactors_seq_ops = {
> +	.start	= reactors_start,
> +	.next	= reactors_next,
> +	.stop	= reactors_stop,
> +	.show	= reactors_show
> +};
> +
> +/*
> + * available_reactors interface.
> + */
> +static int available_reactors_open(struct inode *inode, struct file *file)
> +{
> +	return seq_open(file, &available_reactors_seq_ops);
> +};
> +
> +static const struct file_operations available_reactors_ops = {
> +	.open    = available_reactors_open,
> +	.read    = seq_read,
> +	.llseek  = seq_lseek,
> +	.release = seq_release
> +};
> +
> +/*
> + * Monitor reactor file.
> + */
> +static int monitor_reactor_show(struct seq_file *m, void *p)
> +{
> +	struct rv_monitor_def *mdef = m->private;
> +	struct rv_reactor_def *rdef = p;
> +
> +	if (mdef->rdef == rdef)
> +		seq_printf(m, "[%s]\n", rdef->reactor->name);
> +	else
> +		seq_printf(m, "%s\n", rdef->reactor->name);
> +	return 0;
> +}
> +
> +/*
> + * available reactors seq definition.
> + */
> +static const struct seq_operations monitor_reactors_seq_ops = {
> +	.start	= reactors_start,
> +	.next	= reactors_next,
> +	.stop	= reactors_stop,
> +	.show	= monitor_reactor_show
> +};
> +
> +static ssize_t
> +monitor_reactors_write(struct file *file, const char __user *user_buf,
> +		      size_t count, loff_t *ppos)
> +{
> +	char buff[MAX_RV_REACTOR_NAME_SIZE+1];
> +	struct rv_monitor_def *mdef;
> +	struct rv_reactor_def *rdef;
> +	struct seq_file *seq_f;
> +	int retval = -EINVAL;
> +	char *ptr = buff;
> +	int len;
> +
> +	if (count < 1 || count > MAX_RV_REACTOR_NAME_SIZE+1)
> +		return -EINVAL;
> +
> +	memset(buff, 0, sizeof(buff));
> +
> +	retval = simple_write_to_buffer(buff, sizeof(buff)-1, ppos, user_buf,
> +					count);
> +	if (!retval)
> +		return -EFAULT;
> +
> +	len = strlen(ptr);
> +	if (!len)
> +		return count;
> +	/*
> +	 * remove the \n
> +	 */
> +	ptr[len-1] = '\0';

Again, use strim().

> +
> +	/*
> +	 * See monitor_reactors_open()
> +	 */
> +	seq_f = file->private_data;
> +	mdef = seq_f->private;
> +
> +	mutex_lock(&rv_interface_lock);
> +
> +	retval = -EINVAL;
> +
> +	/*
> +	 * nop special case: disable reacting.
> +	 */
> +	if (strcmp(ptr, "nop") == 0) {
> +
> +		if (mdef->monitor->enabled)
> +			mdef->monitor->stop();
> +
> +		mdef->rdef = get_reactor_rdef_by_name("nop");
> +		mdef->reacting = false;
> +		mdef->monitor->react = NULL;
> +
> +		if (mdef->monitor->enabled)
> +			mdef->monitor->start();
> +
> +		retval = count;
> +		goto unlock;
> +	}
> +
> +	list_for_each_entry(rdef, &rv_reactors_list, list) {
> +		if (strcmp(ptr, rdef->reactor->name) == 0) {

Again,

		if (strcmp(ptr, rdef->reactor->name) != 0)
			continue;

Then we can remove the extra indent.

-- Steve

> +			/*
> +			 * found!
> +			 */
> +			if (mdef->monitor->enabled)
> +				mdef->monitor->stop();
> +
> +			mdef->rdef = rdef;
> +			mdef->reacting = true;
> +			mdef->monitor->react = rdef->reactor->react;
> +
> +			if (mdef->monitor->enabled)
> +				mdef->monitor->start();
> +
> +			retval = count;
> +			break;
> +		}
> +	}
> +
> +unlock:
> +	mutex_unlock(&rv_interface_lock);
> +
> +	return retval;
> +}
> +
> +/*
