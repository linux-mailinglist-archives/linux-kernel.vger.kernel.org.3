Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78D35776FD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiGQPSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGQPSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:18:43 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5466C13EA5;
        Sun, 17 Jul 2022 08:18:40 -0700 (PDT)
Date:   Sun, 17 Jul 2022 23:18:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658071118; h=from:from:reply-to:subject:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=G5jyoUAm/E8GEncszOWKKn/Lw3k75lUqCK5TSSr4hYk=;
        b=OiDq4UKjSKA/T38a7lsqwldIJ8T+lxsZtRcXCTczfFQoGq6Mj9fS1jyeMy8nkf6fE0G1ZJ
        CN3ELn3PK5niA9qbDbmsxqYj2kKBPfOFudpB2BH8xSxiw0yNZ579NrKC0CaRDdD+yL6JFt
        hskOjI3kGp0kPP6M9rrS1z3jQFFZVsc=
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
Message-ID: <YtQoPxUiPLVPLs3S@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_SUBJECT,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bcc: 
Subject: Re: [PATCH V5 02/16] rv: Add runtime reactors interface
Reply-To: 
In-Reply-To: <4a66bc1c858b0a11750321696333d897677eff6b.1657745645.git.bristot@kernel.org>

On Wed, Jul 13, 2022 at 11:17:18PM +0200, Daniel Bristot de Oliveira wrote:
> A runtime monitor can cause a reaction to the detection of an
> exception on the model's execution. By default, the monitors have
> tracing reactions, printing the monitor output via tracepoints.
> But other reactions can be added (on-demand) via this interface.
> 
> The user interface resembles the kernel tracing interface and
> presents these files:
> 
> "available_reactors"
>   - Reading shows the available reactors, one per line.
> 
>    For example:
>      # cat available_reactors
>      nop
>      panic
>      printk
> 
>  "reacting_on"
>    - It is an on/off general switch for reactors, disabling
>    all reactions.
> 
>  "monitors/MONITOR/reactors"
>    - List available reactors, with the select reaction for the given
>    MONITOR inside []. The default one is the nop (no operation)
>    reactor.
>    - Writing the name of a reactor enables it to the given
>    MONITOR.
> 
>    For example:
>      # cat monitors/wip/reactors
>      [nop]
>      panic
>      printk
>      # echo panic > monitors/wip/reactors
>      # cat monitors/wip/reactors
>      nop
>      [panic]
>      printk
> 
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Gabriele Paoloni <gpaoloni@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: Tao Zhou <tao.zhou@linux.dev>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-trace-devel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  include/linux/rv.h            |  11 +
>  kernel/trace/rv/Kconfig       |  11 +
>  kernel/trace/rv/Makefile      |   1 +
>  kernel/trace/rv/rv.c          |   9 +
>  kernel/trace/rv/rv.h          |  29 ++
>  kernel/trace/rv/rv_reactors.c | 488 ++++++++++++++++++++++++++++++++++
> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c

[snip]

> new file mode 100644
> index 000000000000..27f48fec5a51
> --- /dev/null
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -0,0 +1,488 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
> + *
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
> + *      # cat available_reactors
> + *      nop
> + *      panic
> + *      printk
> + *
> + *  "reacting_on"
> + *    - It is an on/off general switch for reactors, disabling
> + *    all reactions.
> + *
> + *  "monitors/MONITOR/reactors"
> + *    - List available reactors, with the select reaction for the given
> + *    MONITOR inside []. The default one is the nop (no operation)
> + *    reactor.
> + *    - Writing the name of an reactor enables it to the given
> + *    MONITOR.
> + *
> + *    For example:
> + *      # cat monitors/wip/reactors
> + *      [nop]
> + *      panic
> + *      printk
> + *      # echo panic > monitors/wip/reactors
> + *      # cat monitors/wip/reactors
> + *      nop
> + *      [panic]
> + *      printk
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
> +	char buff[MAX_RV_REACTOR_NAME_SIZE + 2];
> +	struct rv_monitor_def *mdef;
> +	struct rv_reactor_def *rdef;
> +	struct seq_file *seq_f;
> +	int retval = -EINVAL;
> +	bool enabled;
> +	char *ptr;
> +	int len;
> +
> +	if (count < 1 || count > MAX_RV_REACTOR_NAME_SIZE + 2)
> +		return -EINVAL;

The same case as patch1. The up bound check need to be changed.

> +	memset(buff, 0, sizeof(buff));
> +
> +	retval = simple_write_to_buffer(buff, sizeof(buff) - 1, ppos, user_buf,
> +					count);
> +	if (!retval)
> +		return -EFAULT;

If simple_write_to_buffer() is error(return value < 0), no return here.
If the return value is 0, no write has happened. For this case, the code
want to return -EFAULT.

> +	ptr = strim(buff);
> +
> +	len = strlen(ptr);
> +	if (!len)
> +		return count;
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
> +		enabled = mdef->monitor->enabled;
> +		if (enabled)
> +			mdef->monitor->stop();
> +
> +		mdef->rdef = get_reactor_rdef_by_name("nop");
> +		mdef->reacting = false;
> +		mdef->monitor->react = NULL;
> +
> +		if (enabled) {
> +			mdef->monitor->start();
> +			mdef->monitor->enabled = 1;
> +		}
> +
> +		retval = count;
> +		goto unlock;
> +	}
> +
> +	list_for_each_entry(rdef, &rv_reactors_list, list) {
> +		if (strcmp(ptr, rdef->reactor->name) != 0)
> +			continue;
> +
> +		/*
> +		 * found!
> +		 */
> +		enabled = mdef->monitor->enabled;
> +		if (enabled)
> +			mdef->monitor->stop();
> +
> +		mdef->rdef = rdef;
> +		mdef->reacting = true;
> +		mdef->monitor->react = rdef->reactor->react;
> +
> +		if (enabled) {
> +			mdef->monitor->start();
> +			mdef->monitor->enabled = 1;
> +		}
> +
> +		retval = count;
> +		break;
> +	}
> +
> +unlock:
> +	mutex_unlock(&rv_interface_lock);
> +
> +	return retval;
> +}
> +
> +/*
> + * available_reactors interface.
> + */
> +static int monitor_reactors_open(struct inode *inode, struct file *file)
> +{
> +	/*
> +	 * create file "private" info is stored in the inode->i_private
> +	 */
> +	struct rv_monitor_def *mdef = inode->i_private;
> +	struct seq_file *seq_f;
> +	int ret;
> +
> +	ret = seq_open(file, &monitor_reactors_seq_ops);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * seq_open stores the seq_file on the file->private data.
> +	 */
> +	seq_f = file->private_data;
> +
> +	/*
> +	 * Copy the create file "private" data to the seq_file
> +	 * private data.
> +	 */
> +	seq_f->private = mdef;
> +
> +	return 0;
> +};
> +
> +static const struct file_operations monitor_reactors_ops = {
> +	.open    = monitor_reactors_open,
> +	.read    = seq_read,
> +	.llseek  = seq_lseek,
> +	.release = seq_release,
> +	.write = monitor_reactors_write
> +};
> +
> +static int __rv_register_reactor(struct rv_reactor *reactor)
> +{
> +	struct rv_reactor_def *r;
> +
> +	list_for_each_entry(r, &rv_reactors_list, list) {
> +		if (strcmp(reactor->name, r->reactor->name) == 0) {
> +			pr_info("Reactor %s is already registered\n",
> +				reactor->name);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	r = kzalloc(sizeof(struct rv_reactor_def), GFP_KERNEL);
> +	if (!r)
> +		return -ENOMEM;
> +
> +	r->reactor = reactor;
> +	r->counter = 0;
> +
> +	list_add_tail(&r->list, &rv_reactors_list);
> +
> +	return 0;
> +}
> +
> +/**
> + * rv_register_reactor - register a rv reactor.
> + * @reactor:    The rv_reactor to be registered.
> + *
> + * Returns 0 if successful, error otherwise.
> + */
> +int rv_register_reactor(struct rv_reactor *reactor)
> +{
> +	int retval = 0;
> +
> +	if (strlen(reactor->name) >= MAX_RV_REACTOR_NAME_SIZE) {
> +		pr_info("Reactor %s has a name longer than %d\n",
> +			reactor->name, MAX_RV_MONITOR_NAME_SIZE);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&rv_interface_lock);
> +	retval = __rv_register_reactor(reactor);
> +	mutex_unlock(&rv_interface_lock);
> +	return retval;
> +}
> +
> +/**
> + * rv_unregister_reactor - unregister a rv reactor.
> + * @reactor:    The rv_reactor to be unregistered.
> + *
> + * Returns 0 if successful, error otherwise.
> + */
> +int rv_unregister_reactor(struct rv_reactor *reactor)
> +{
> +	struct rv_reactor_def *ptr, *next;
> +
> +	mutex_lock(&rv_interface_lock);
> +
> +	list_for_each_entry_safe(ptr, next, &rv_reactors_list, list) {
> +		if (strcmp(reactor->name, ptr->reactor->name) == 0) {
> +
> +			if (!ptr->counter) {
> +				list_del(&ptr->list);
> +			} else {
> +				printk(KERN_WARNING
> +				       "rv: the rv_reactor %s is in use by %d monitor(s)\n",
> +				       ptr->reactor->name, ptr->counter);
> +				printk(KERN_WARNING "rv: the rv_reactor %s cannot be removed\n",
> +				       ptr->reactor->name);
> +				return -EBUSY;
> +			}
> +
> +		}
> +	}
> +
> +	mutex_unlock(&rv_interface_lock);
> +	return 0;
> +}
> +
> +/*
> + * reacting_on interface.
> + */
> +static ssize_t reacting_on_read_data(struct file *filp,
> +				     char __user *user_buf,
> +				     size_t count, loff_t *ppos)
> +{
> +	char *buff;
> +
> +	mutex_lock(&rv_interface_lock);
> +	buff = reacting_on ? "1\n" : "0\n";
> +	mutex_unlock(&rv_interface_lock);
> +
> +	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff)+1);
> +}
> +
> +static void turn_reacting_off(void)
> +{
> +	reacting_on = false;
> +}
> +
> +static void turn_reacting_on(void)
> +{
> +	reacting_on = true;
> +}
> +
> +static ssize_t
> +reacting_on_write_data(struct file *filp, const char __user *user_buf,
> +		       size_t count, loff_t *ppos)
> +{
> +	int retval;
> +	bool val;
> +
> +	retval = kstrtobool_from_user(user_buf, count, &val);
> +	if (retval)
> +		return retval;
> +
> +	mutex_lock(&rv_interface_lock);
> +
> +	if (val)
> +		turn_reacting_on();
> +	else
> +		turn_reacting_off();
> +
> +	mutex_unlock(&rv_interface_lock);
> +
> +	return count;
> +}
> +
> +static const struct file_operations reacting_on_fops = {
> +	.open   = simple_open,
> +	.llseek = no_llseek,
> +	.write  = reacting_on_write_data,
> +	.read   = reacting_on_read_data,
> +};
> +
> +int reactor_create_monitor_files(struct rv_monitor_def *mdef)
> +{
> +	struct dentry *tmp;
> +
> +	tmp = rv_create_file("reactors", RV_MODE_WRITE, mdef->root_d, mdef, &monitor_reactors_ops);
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Configure as the rv_nop reactor.
> +	 */
> +	mdef->rdef = get_reactor_rdef_by_name("nop");
> +	mdef->reacting = false;

Not need `mdef->monitor->react = NULL;`. The monitor->react is
not set to others that means it is set to NULL, When initializing
the specific rv_monitor structure. Note to myself. Thanks.

> +
> +	return 0;
> +}
> +
> +/*
> + * None reactor register
> + */
> +static void rv_nop_reaction(char *msg)
> +{
> +}
> +
> +struct rv_reactor rv_nop = {
> +	.name = "nop",
> +	.description = "no-operation reactor: do nothing.",
> +	.react = rv_nop_reaction
> +};
> +
> +/*
> + * This section collects the rv/ root dir files and folders.
> + */
> +int init_rv_reactors(struct dentry *root_dir)
> +{
> +	struct dentry *available, *reacting;
> +	int retval;
> +
> +	available = rv_create_file("available_reactors", RV_MODE_READ, root_dir, NULL,
> +				   &available_reactors_ops);
> +	if (!available)
> +		goto out_err;
> +
> +	reacting = rv_create_file("reacting_on", RV_MODE_WRITE, root_dir, NULL, &reacting_on_fops);
> +	if (!reacting)
> +		goto rm_available;
> +
> +	retval = __rv_register_reactor(&rv_nop);
> +	if (retval)
> +		goto rm_reacting;
> +
> +	reacting_on = 1;
> +
> +	return 0;
> +
> +rm_reacting:
> +	rv_remove(reacting);
> +rm_available:
> +	rv_remove(available);
> +out_err:
> +	return -ENOMEM;
> +}
> -- 
> 2.35.1
