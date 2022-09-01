Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23F85A9348
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiIAJfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiIAJfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:35:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CF2DB7ED
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:35:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C10CD2246C;
        Thu,  1 Sep 2022 09:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662024934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+4Vs/VN7NJIo+fonm8WWVOp6UC0uWihBQPPo93WXeUA=;
        b=Rm3DhbdaQZYQc7iOLQKB29V2ShRTvHZqf3KpQm1knMRnveuPa/k6Mt2c+pVvwQAQ3IQn/M
        Ipz+gnuFyI+S9l7RgTnjl5EMb/tgEPkUve4qxeUDUdtngXC+KftTC940GkaCcnyi6vm7lV
        1RaOrS6vhybyEO8xOHdv/mzmdAqwNX8=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5578C2C145;
        Thu,  1 Sep 2022 09:35:34 +0000 (UTC)
Date:   Thu, 1 Sep 2022 11:35:31 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 2/2] printk: console: Support console-specific
 loglevels
Message-ID: <YxB845DNwLTEUVgw@alley>
References: <cover.1658339046.git.chris@chrisdown.name>
 <b9fa85cfed3a97ab4292daca51476e4e23da2f9a.1658339046.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9fa85cfed3a97ab4292daca51476e4e23da2f9a.1658339046.git.chris@chrisdown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-07-20 18:48:16, Chris Down wrote:
> In terms of technical implementation, this patch embeds a device pointer
> in the console struct, and registers each console using it so we can
> expose attributes in sysfs.
>
> For information on the precedence and application of the new controls,
> see Documentation/ABI/testing/sysfs-class-console and
> Documentation/admin-guide/per-console-loglevel.rst.

The overall logic looks good to me. I finally have good feeling that
the behavior is "easy" to understand.

The detailed documentation is very nice!

See below for comments about various implementation details.

> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -137,6 +138,22 @@ static inline int con_debug_leave(void)
>  #define CON_BRL		(32) /* Used for a braille device */
>  #define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
>  
> +/*
> + * The loglevel for a console can be set in many places:
> + *
> + * 1. It can be forced to emit everything (ignore_loglevel);
> + * 2. It can be set globally (sysctls kernel.printk (deprecated),
> + *    kernel.console_loglevel, magic sysrq, loglevel= on kernel command line);
> + * 3. It can be locally set for this specific console (console=...,loglevel:N on
> + *    kernel command line, /sys/class/console/.../loglevel);
> + * 4. It can be set by a compile-time default
> + *    (CONFIG_CONSOLE_LOGLEVEL_{DEFAULT,QUIET})
> + *
> + * If case 3 happens, even if another global value in effect, CON_LOGLEVEL will
> + * be set.

The last sentence is not clear to me.

Well, I suggest to keep it simple and remove this comment
completely. The meaning of the flag is simple. It is set when
the local (per-console) loglevel is set.

The precedence of the various loglevel setting is explained above
console_effective_loglevel() where it belongs.

> + */
> +#define CON_LOGLEVEL	(128) /* Level set locally for this console */

I would write:

#define CON_LOGLEVEL	(128) /* Local (per-console) loglevel is set. */

Alternatively we could avoid the flag completely. The per-console
loglevel is set when con->level > 0. A valid value must never
be below CONSOLE_MIN_LOGLEVEL which is 1. And it is perfectly fine
to say that 0 or -1 is not a valid loglevel. The same effect could
be achieved by disabling the console completely.

I do not have strong opinion. The flag has obvious meaning and might
make the code better readable. On the other hand, it adds an extra
code and complexity.

I slightly prefer to do it without the flag.

Anyway, if we add the new flag, we should also show it in
/proc/consoles, see fs/proc/consoles.c.

> +
>  struct console {
>  	char	name[16];
>  	void	(*write)(struct console *, const char *, unsigned);
> @@ -155,8 +172,15 @@ struct console {
>  	unsigned long dropped;
>  	void	*data;
>  	struct	 console *next;
> +	int	level;
> +	struct	device *classdev;
>  };
>  
> +static inline struct console *classdev_to_console(struct device *dev)
> +{
> +	return dev_get_drvdata(dev);
> +}

Please, open code this in the _show()/_store() callbacks. dev_get_drvdata()
seems to be the standard way how it is done. Hiding it into a custom
function just adds an extra step when reading the code.

> +
>  /*
>   * for_each_console() allows you to iterate on each console
>   */
> diff --git a/kernel/printk/console_cmdline.h b/kernel/printk/console_cmdline.h
> index 3ca74ad391d6..40f1a1ff0965 100644
> --- a/kernel/printk/console_cmdline.h
> +++ b/kernel/printk/console_cmdline.h
> @@ -6,6 +6,8 @@ struct console_cmdline
>  {
>  	char	name[16];			/* Name of the driver	    */
>  	int	index;				/* Minor dev. to use	    */
> +	int	level;				/* Log level to use */
> +	short	flags;				/* Initial flags */
>  	bool	user_specified;			/* Specified by command line vs. platform */
>  	char	*options;			/* Options for the driver   */
>  #ifdef CONFIG_A11Y_BRAILLE_CONSOLE
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 6094f773ad4a..6f5e29b60875 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1202,9 +1217,72 @@ module_param(ignore_loglevel, bool, S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(ignore_loglevel,
>  		 "ignore loglevel setting (prints all kernel messages to the console)");
>  
> -static bool suppress_message_printing(int level)
> +static bool __read_mostly ignore_per_console_loglevel;
> +
> +static int __init ignore_per_console_loglevel_setup(char *str)
> +{
> +	ignore_per_console_loglevel = true;
> +	return 0;
> +}
> +
> +early_param("ignore_per_console_loglevel", ignore_per_console_loglevel_setup);
> +module_param(ignore_per_console_loglevel, bool, 0644);
> +MODULE_PARM_DESC(ignore_per_console_loglevel,
> +		 "ignore per-console loglevel setting (only respect global console loglevel)");
> +
> +/*
> + * Hierarchy of loglevel authority:
> + *
> + * 1. con->level. The locally set, console-specific loglevel. Optional, only
> + *    valid if the CON_LOGLEVEL flag is set.
> + * 2. console_loglevel. The default global console loglevel, always present.
> + *
> + * The behaviour can be further changed by the following printk module
> + * parameters:
> + *
> + * 1. ignore_loglevel. Can be set at boot or at runtime with
> + *    /sys/module/printk/parameters/ignore_loglevel. Overrides absolutely
> + *    everything since it's used to debug.
> + * 2. ignore_per_console_loglevel. Existing per-console loglevel values are left
> + *    intact, but are ignored in favour of console_loglevel as long as this is
> + *    true.
> + *
> + * Callers typically only need the level _or_ the source, but they're both
> + * emitted from this function so that the effective loglevel logic can be
> + * kept in one place.
> + */
> +static int console_effective_loglevel(const struct console *con,
> +				      enum loglevel_source *source)
> +{
> +	enum loglevel_source lsource;
> +	int level;
> +
> +	if (ignore_loglevel) {
> +		lsource = LLS_IGNORE_LOGLEVEL;
> +		level = CONSOLE_LOGLEVEL_MOTORMOUTH;
> +		goto out;
> +	}
> +
> +	if (!ignore_per_console_loglevel &&
> +	    (con && (con->flags & CON_LOGLEVEL))) {
> +		lsource = LLS_LOCAL;
> +		level = con->level;
> +		goto out;
> +	}
> +
> +	lsource = LLS_GLOBAL;
> +	level = console_loglevel;
> +
> +out:
> +	*source = lsource;
> +	return level;
> +}

It might be a matter of taste. But I would probably do it the
following way (note that these would not be used in
boot_delay_msec()):

static int console_effective_loglevel(const struct console *con)
{
	enum loglevel_source source;
	int level;

	if (WARN_ON_ONCE(!con))
		return;

	source = console_effective_loglevel_source(con);

	switch (source) {
	case LLS_IGNORE_LOGLEVEL:
		level = CONSOLE_LOGLEVEL_MOTORMOUTH;
		break;
	case LSS_LOCAL:
		level = con->level;
		break;
	case LSS_GLOBAL:
		level = console_loglevel;
		break;
	default:
		pr_warn("Unhandled console loglevel source: %d,	source);
		level = default_console_loglevel;
		break;
	}

	return level;
}

static const char *console_effective_loglevel_source_str(const struct *con)
{
	enum loglevel_source source;
	const char *str;

	if (WARN_ON_ONCE(!con))
		return;

	source = console_effective_loglevel_source(con);

	switch (source) {
	case LLS_IGNORE_LOGLEVEL:
		str = "ignore_loglevel";
		break;
	case LSS_LOCAL:
		str = "local"
		break;
	case LSS_GLOBAL:
		str = "global";
		break;
	default:
		pr_warn("Unhandled console loglevel source: %d,	source);
		str = "unknown";
		break;
	}

	return str;
}

static enum loglevel_source
console_effective_loglevel_source(const struct console *con)
{
	if (WARN_ON_ONCE(!con))
		return;

	if (ignore_loglevel)
		return LLS_IGNORE_LOGLEVEL;

	if (con->flags & CON_LOGLEVEL && !ignore_per_console_loglevel))
		return LLS_LOCAL;

	return LLS_GLOBAL;
}

It looks like a bit cleaner and better separated (layered) logic.

There is no need to define "enum loglevel_source" variable when
the caller is interested only into the loglevel value.

The advantage of console_effective_loglevel_source_str() is that it
always returns a valid string. It prevents a potential out-of-bound
access to loglevel_source_names[].

> +
> +static bool suppress_message_printing(int level, struct console *con)
>  {
> -	return (level >= console_loglevel && !ignore_loglevel);
> +	enum loglevel_source source;
> +
> +	return level >= console_effective_loglevel(con, &source);
>  }
>  
>  #ifdef CONFIG_BOOT_PRINTK_DELAY
> @@ -1236,7 +1314,7 @@ static void boot_delay_msec(int level)
>  	unsigned long timeout;
>  
>  	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
> -		|| suppress_message_printing(level)) {
> +		|| suppress_message_printing(level, NULL)) {

This does not take into account per-console loglevels.
And we could not check them in vprintk_emit() because
we could not take console_lock() there.

AFAIK, the purpose of this call is to allow reading the messages
on consoles when they do not support scrolling.

A solution would be to call boot_delay_msec() in
console_flush_all(). It would need adding parameter
into console_emit_next_record() that pass information
whether it emitted or suppressed the message.
Something like:

/*
[...]
 * @emitted will be set to "true" when the message was really emitted to the
 * console. It means that it was not suppressed because of console loglevel.
[...]
*/
static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
				     char *dropped_text, bool *emitted, bool *handover)


>  		return;
>  	}
>  
> @@ -1701,12 +1806,14 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  		break;
>  	/* Disable logging to console */
>  	case SYSLOG_ACTION_CONSOLE_OFF:
> +		warn_on_local_loglevel();
>  		if (saved_console_loglevel == LOGLEVEL_DEFAULT)
>  			saved_console_loglevel = console_loglevel;
>  		console_loglevel = minimum_console_loglevel;
>  		break;

We actually could disable logging on all consoles by setting
ignore_per_console_loglevel. Something like:

	case SYSLOG_ACTION_CONSOLE_OFF:
		if (saved_console_loglevel == LOGLEVEL_DEFAULT) {
			saved_console_loglevel = console_loglevel;
			saved_ignore_per_console_loglevel = ignore_per_console_loglevel;
		}
		console_loglevel = minimum_console_loglevel;
		ignore_per_console_loglevel = true;
		break;



>  	/* Enable logging to console */
>  	case SYSLOG_ACTION_CONSOLE_ON:
> +		warn_on_local_loglevel();
>  		if (saved_console_loglevel != LOGLEVEL_DEFAULT) {
>  			console_loglevel = saved_console_loglevel;
>  			saved_console_loglevel = LOGLEVEL_DEFAULT;

and here:

	case SYSLOG_ACTION_CONSOLE_ON:
		if (saved_console_loglevel != LOGLEVEL_DEFAULT) {
			console_loglevel = saved_console_loglevel;
			ignore_per_console_loglevel = saved_ignore_per_console_loglevel;
			saved_console_loglevel = LOGLEVEL_DEFAULT;
		}


> @@ -1714,6 +1821,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  		break;
>  	/* Set level of messages printed to console */
>  	case SYSLOG_ACTION_CONSOLE_LEVEL:
> +		warn_on_local_loglevel();

I would keep it simple:

		if (!ignore_per_console_loglevel)
			pr_warn_once("SYSLOG_ACTION_CONSOLE_LEVEL is ignored by consoles with explicitely set per-console loglevel, see Documentation/admin-guide/per-console-loglevel\n");

People should know that this API has limits. The check of
ignore_per_console_loglevel allows to prevent the warning
when the users are not interested into the per-console
loglevels feature.

I think about opening discussion about obsoleting the syslog
syscall. It has many drawbacks. Everything is stored in global
variables. As a result, it supports only one reader and one
writer.


>  		if (len < 1 || len > 8)
>  			return -EINVAL;
>  		if (len < minimum_console_loglevel)
> @@ -3030,6 +3149,145 @@ static int __init keep_bootcon_setup(char *str)
>  
>  early_param("keep_bootcon", keep_bootcon_setup);
>  
> +#ifdef CONFIG_PRINTK
> +static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct console *con = classdev_to_console(dev);
> +
> +	if (con->flags & CON_LOGLEVEL)
> +		return sysfs_emit(buf, "%d\n", con->level);
> +	else
> +		return sysfs_emit(buf, "unset\n");

I can't find any other sysfs interface using this style (number or
"unset"). Or any other interface combining number or a string values.

I feel a bit uneasy to introduce a completely new semantic. Instead I
prefer using either -1 or 0 when the per-console is not set. It might
be slightly less obvious but it is a standard way so it might be
easier for users in the end.

Both 0 and -1 values are usable as explained above. I personally
prefer -1 because the meaning is more obvious. I would even
use it instead of CON_LOGLEVEL flag.


> +}
> +
> +static ssize_t loglevel_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t size)
> +{
> +	struct console *con = classdev_to_console(dev);
> +	ssize_t ret;
> +	int tmp;
> +
> +	if (!strcmp(buf, "unset") || !strcmp(buf, "unset\n")) {
> +		con->flags &= ~CON_LOGLEVEL;
> +		return size;
> +	}
> +
> +	ret = kstrtoint(buf, 10, &tmp);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (tmp < LOGLEVEL_EMERG || tmp > LOGLEVEL_DEBUG + 1)
> +		return -ERANGE;
> +
> +	if (tmp < minimum_console_loglevel)
> +		return -EINVAL;

This looks superfluous. Please, use minimum_console_loglevel
instead of LOGLEVEL_EMERG in the above range check.

Also, we should make a helper function for this. The same range check
is useful also for the global console_loglevel.

> +
> +	con->level = tmp;
> +	con->flags |= CON_LOGLEVEL;
> +
> +	return size;
> +}
> +
> +static DEVICE_ATTR_RW(loglevel);
> +
[...]
> +static struct attribute *console_sysfs_attrs[] = {
> +	&dev_attr_loglevel.attr,
> +	&dev_attr_effective_loglevel_source.attr,
> +	&dev_attr_effective_loglevel.attr,
> +	&dev_attr_enabled.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(console_sysfs);
> +
> +static void console_classdev_release(struct device *dev)
> +{
> +	kfree(dev);
> +}
> +
> +static void console_register_device(struct console *new)

Please use "con" instead of "new" like it is done in the other
API manipulating struct console. It helps when reading the code.

> +{
> +	/*
> +	 * We might be called from register_console() before the class is
> +	 * registered. If that happens, we'll take care of it in
> +	 * printk_late_init.
> +	 */
> +	if (IS_ERR_OR_NULL(console_class))
> +		return;
> +

We should check whether new->classdev is NULL to prevent double
initialization. It should not happen but better be on the safe side.


> +	new->classdev = kzalloc(sizeof(struct device), GFP_KERNEL);
> +	if (!new->classdev)
> +		return;
> +
> +	device_initialize(new->classdev);
> +	dev_set_name(new->classdev, "%s", new->name);

This should be:

	dev_set_name(new->classdev, "%s%d", con->name, con->index);

It should match console names defined on the command line
and shown by /proc/consoles. See how the name is printed in
fs/proc/consoles.c.

> +	dev_set_drvdata(new->classdev, new);
> +	new->classdev->release = console_classdev_release;
> +	new->classdev->class = console_class;
> +	if (device_add(new->classdev))
> +		put_device(new->classdev);
> +}
> +
> +static void console_setup_class(void)
> +{
> +	struct console *con;
> +
> +	/*
> +	 * printk exists for the lifetime of the kernel, it cannot be unloaded,
> +	 * so we should never end up back in here.
> +	 */
> +	if (WARN_ON(console_class))
> +		return;
> +
> +	console_class = class_create(THIS_MODULE, "console");
> +	if (!IS_ERR(console_class))
> +		console_class->dev_groups = console_sysfs_groups;
> +
> +	for_each_console(con)
> +		console_register_device(con);

This should be done under console_lock so that the list of registered
console could not get manipulated.

> +}
> +#else /* CONFIG_PRINTK */
> +static void console_register_device(struct console *new) {}
> +static void console_setup_class(void) {}
> +#endif
> +
>  /*
>   * This is called by register_console() to try to match
>   * the newly registered console with any of the ones selected
> --- a/kernel/printk/sysctl.c
> +++ b/kernel/printk/sysctl.c
> @@ -7,10 +7,14 @@
>  #include <linux/printk.h>
>  #include <linux/capability.h>
>  #include <linux/ratelimit.h>
> +#include <linux/console.h>
>  #include "internal.h"
>  
>  static const int ten_thousand = 10000;
>  
> +static int min_loglevel = LOGLEVEL_EMERG;

We should use minimum_console_loglevel instead.

> +static int max_loglevel = LOGLEVEL_DEBUG + 1;

Please, define maximum_console_loglevel in kernel/printk/printk.c
after the console_printk[4] array.

This will allow to create a function for the range check that might
be used for both sysfs and proc interface.

Also I would set the maximal value to CONSOLE_LOGLEVEL_MOTORMOUTH.

> +
>  static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>  				void *buffer, size_t *lenp, loff_t *ppos)
>  {
> @@ -76,6 +122,22 @@ static struct ctl_table printk_sysctls[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_TWO,
>  	},
> +	{
> +		.procname	= "console_loglevel",
> +		.data		= &console_loglevel,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= printk_console_loglevel,
> +	},
> +	{
> +		.procname	= "default_message_loglevel",
> +		.data		= &default_message_loglevel,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &min_loglevel,
> +		.extra2		= &max_loglevel,
> +	},

Is there any chance to add this into /sys/class/console instead?
I mean:

	/sys/class/console/loglevel
	/sys/class/console/default_message_loglevel

It would be nice to have the things are on the same place.
Especially it would be nice to have the global loglevel there.

Best Regards,
Petr
