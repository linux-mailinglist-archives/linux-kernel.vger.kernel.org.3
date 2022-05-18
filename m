Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAB952BF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbiERPeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239440AbiERPeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3553C74DD2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B952C60EE8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4616C385A5;
        Wed, 18 May 2022 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652888044;
        bh=CrxDIobWqttmdT5cm4vjy6h3mdwjF9Q6VWe/epgLZHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yuh/JtqH3IR8WNMREeGR5h+IMWajPpyPTpdb/sVfMA1uWiLSWr68mZsdxA0uDxi8K
         +fi82sT4eQ0ZZOAAHecVJMrwJpsH0BakUSCyA8RCbVjvR/RpdvRqm+GJW9PrXKk4wP
         r4HiJIP/Cqt8BcvE0kATvZIKK1sYAhDR4g2lWk8M=
Date:   Wed, 18 May 2022 17:34:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoUR6RlzkCNG7BU0@kroah.com>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoUBh5BSsURDO71Z@chrisdown.name>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:24:07PM +0100, Chris Down wrote:
> [Once the goals of this patch are generally agreed upon, it can be split
> out further with more detailed changelogs if desired.]

Some driver model comments first, I'll let others argue if this is a
good idea overall or not...

> ---
>  .../admin-guide/kernel-parameters.txt         |  18 +-
>  .../admin-guide/per-console-loglevel.rst      | 116 ++++++

All sysfs attributes need to be documented in Documentation/ABI/ so that
the automated tools can properly pick them up and check them.  Please
don't bury them in some other random Documentation file.

> +static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct console *con = container_of(dev, struct console, classdev);
> +
> +	if (con->flags & CON_LOGLEVEL)
> +		return sprintf(buf, "%d\n", con->level);
> +	else
> +		return sprintf(buf, "unset\n");

sysfs_emit() is your friend, always use it please.  For all of the sysfs
attributes.

> +static struct attribute *console_sysfs_attrs[] = {
> +	&dev_attr_loglevel.attr,
> +	&dev_attr_effective_loglevel_source.attr,
> +	&dev_attr_effective_loglevel.attr,
> +	&dev_attr_enabled.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(console_sysfs);

Thanks for using an attribute group properly, that's nice to see.

> +static void console_classdev_release(struct device *dev)
> +{
> +	struct console *con = container_of(dev, struct console, classdev);
> +
> +	/*
> +	 * `struct console' objects are statically allocated (or at the very
> +	 * least managed outside of our lifecycle), nothing to do. Just set a
> +	 * flag so that we know we are no longer waiting for anyone and can
> +	 * return control in unregister_console().
> +	 */
> +	con->flags &= ~CON_CLASSDEV_ACTIVE;
> +}

The old documentation rules said I could complain about this a lot, so
I'll be nice here just say "this is not ok at all."  You have a dynamic
object, properly free the memory here please.  class objects can NOT be
static, sorry.  If you are doing that here, it is really wrong and
broken and will cause problems when you try to remove the device from
the system.


> +
> +static void console_register_device(struct console *new)
> +{
> +	/*
> +	 * We might be called from register_console() before the class is
> +	 * registered. If that happens, we'll take care of it in
> +	 * printk_late_init.

If so, is the device properly registered there as well?  I missed that
logic...

> +	 */
> +	if (IS_ERR_OR_NULL(console_class))
> +		return;
> +
> +	new->flags |= CON_CLASSDEV_ACTIVE;
> +	device_initialize(&new->classdev);
> +	dev_set_name(&new->classdev, "%s", new->name);
> +	new->classdev.release = console_classdev_release;
> +	new->classdev.class = console_class;
> +	if (WARN_ON(device_add(&new->classdev)))

What is with these random WARN_ON() stuff?  Don't do that, just handle
the error and move on properly.  Systems with panic_on_warn() should not
fail from stuff like this, that's rude to cause them to reboot.


> +		put_device(&new->classdev);
> +}
> +
>  /*
>   * This is called by register_console() to try to match
>   * the newly registered console with any of the ones selected
> @@ -2951,6 +3220,10 @@ static int try_enable_preferred_console(struct console *newcon,
>  			if (newcon->index < 0)
>  				newcon->index = c->index;
>  
> +			if (c->flags & CON_LOGLEVEL)
> +				newcon->level = c->level;
> +			newcon->flags |= c->flags;
> +
>  			if (_braille_register_console(newcon, c))
>  				return 0;
>  
> @@ -3118,6 +3391,7 @@ void register_console(struct console *newcon)
>  		console_seq = syslog_seq;
>  		mutex_unlock(&syslog_lock);
>  	}
> +	console_register_device(newcon);
>  	console_unlock();
>  	console_sysfs_notify();
>  
> @@ -3188,6 +3462,7 @@ int unregister_console(struct console *console)
>  		console_drivers->flags |= CON_CONSDEV;
>  
>  	console->flags &= ~CON_ENABLED;
> +	device_unregister(&console->classdev);
>  	console_unlock();
>  	console_sysfs_notify();
>  
> @@ -3200,6 +3475,14 @@ int unregister_console(struct console *console)
>  	console->flags &= ~CON_ENABLED;
>  	console_unlock();
>  
> +	/*
> +	 * Wait for anyone holding the classdev open to close it so that we
> +	 * don't remove the module prematurely. Once classdev refcnt is 0,
> +	 * CON_CLASSDEV_ACTIVE will be unset in console_classdev_release.
> +	 */
> +	while (console->flags & CON_CLASSDEV_ACTIVE)
> +		schedule_timeout_uninterruptible(msecs_to_jiffies(1));
> +
>  	return res;
>  }
>  EXPORT_SYMBOL(unregister_console);
> @@ -3247,6 +3530,10 @@ void __init console_init(void)
>   * To mitigate this problem somewhat, only unregister consoles whose memory
>   * intersects with the init section. Note that all other boot consoles will
>   * get unregistered when the real preferred console is registered.
> + *
> + * Early consoles will also have been registered before we had the
> + * infrastructure to put them into /sys/class/console, so make sure they get
> + * set up now that we're ready.
>   */
>  static int __init printk_late_init(void)
>  {
> @@ -3280,6 +3567,14 @@ static int __init printk_late_init(void)
>  					console_cpu_notify, NULL);
>  	WARN_ON(ret < 0);
>  	printk_sysctl_init();
> +
> +	console_class = class_create(THIS_MODULE, "console");
> +	if (!WARN_ON(IS_ERR(console_class)))
> +		console_class->dev_groups = console_sysfs_groups;

Do you ever free the class?

> +
> +	for_each_console(con)
> +		console_register_device(con);
> +
>  	return 0;
>  }
>  late_initcall(printk_late_init);
> diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
> index c228343eeb97..28660ce90453 100644
> --- a/kernel/printk/sysctl.c
> +++ b/kernel/printk/sysctl.c
> @@ -7,9 +7,12 @@
>  #include <linux/printk.h>
>  #include <linux/capability.h>
>  #include <linux/ratelimit.h>
> +#include <linux/console.h>
>  #include "internal.h"
>  
>  static const int ten_thousand = 10000;
> +static const int min_loglevel = LOGLEVEL_EMERG;
> +static const int max_loglevel = LOGLEVEL_DEBUG + 1;
>  
>  static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>  				void *buffer, size_t *lenp, loff_t *ppos)
> @@ -20,13 +23,71 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>  	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>  }
>  
> +static int printk_sysctl_deprecated(struct ctl_table *table, int write,
> +				    void __user *buffer, size_t *lenp,
> +				    loff_t *ppos)
> +{
> +	int res = proc_dointvec(table, write, buffer, lenp, ppos);
> +
> +	if (write)
> +		pr_warn_ratelimited(
> +			"printk: The kernel.printk sysctl is deprecated and will be removed soon. Use kernel.force_console_loglevel, kernel.default_message_loglevel, kernel.minimum_console_loglevel, or kernel.default_console_loglevel instead.\n"

Please define "soon".

thanks,

greg k-h
