Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1424F52C3E2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242151AbiERTyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiERTyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:54:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D961C227068
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:54:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D783B821B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 19:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C90C385A5;
        Wed, 18 May 2022 19:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652903647;
        bh=NAw6yMZMyT9wtBj2t7tOiCo+kQWlnlgTWV8i+F17lww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dbNR79tjZqH5c6pKdPmFbgCGwNfdGaRV/zmkbuxH30EiUccdQrZdQUXaHEjSPcx65
         fFaYkW/LBPkHH5qnKebhNszY9bmhIm3y9Et7R/e8eoWCvqZbnjfDIlUEwx9tEy1P65
         QCu5rP4rdW60w/L4iaBGLmdZK/YYh0AIWDoNoRG4=
Date:   Wed, 18 May 2022 21:54:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoVO23+fvsNPnpKh@kroah.com>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
 <YoUR6RlzkCNG7BU0@kroah.com>
 <YoVM+KbdyJm8RSSr@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoVM+KbdyJm8RSSr@chrisdown.name>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 08:46:00PM +0100, Chris Down wrote:
> Greg Kroah-Hartman writes:
> > >  .../admin-guide/kernel-parameters.txt         |  18 +-
> > >  .../admin-guide/per-console-loglevel.rst      | 116 ++++++
> > 
> > All sysfs attributes need to be documented in Documentation/ABI/ so that
> > the automated tools can properly pick them up and check them.  Please
> > don't bury them in some other random Documentation file.
> 
> Ack.
> 
> > > +static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
> > > +			     char *buf)
> > > +{
> > > +	struct console *con = container_of(dev, struct console, classdev);
> > > +
> > > +	if (con->flags & CON_LOGLEVEL)
> > > +		return sprintf(buf, "%d\n", con->level);
> > > +	else
> > > +		return sprintf(buf, "unset\n");
> > 
> > sysfs_emit() is your friend, always use it please.  For all of the sysfs
> > attributes.
> 
> Ack.
> 
> > > +static struct attribute *console_sysfs_attrs[] = {
> > > +	&dev_attr_loglevel.attr,
> > > +	&dev_attr_effective_loglevel_source.attr,
> > > +	&dev_attr_effective_loglevel.attr,
> > > +	&dev_attr_enabled.attr,
> > > +	NULL,
> > > +};
> > > +
> > > +ATTRIBUTE_GROUPS(console_sysfs);
> > 
> > Thanks for using an attribute group properly, that's nice to see.
> 
> Hah, I have no idea what I'm doing with the device model in general, but at
> least I vaguely know how to keep the code tidy ;-)
> 
> > > +static void console_classdev_release(struct device *dev)
> > > +{
> > > +	struct console *con = container_of(dev, struct console, classdev);
> > > +
> > > +	/*
> > > +	 * `struct console' objects are statically allocated (or at the very
> > > +	 * least managed outside of our lifecycle), nothing to do. Just set a
> > > +	 * flag so that we know we are no longer waiting for anyone and can
> > > +	 * return control in unregister_console().
> > > +	 */
> > > +	con->flags &= ~CON_CLASSDEV_ACTIVE;
> > > +}
> > 
> > The old documentation rules said I could complain about this a lot, so
> > I'll be nice here just say "this is not ok at all."  You have a dynamic
> > object, properly free the memory here please.  class objects can NOT be
> > static, sorry.  If you are doing that here, it is really wrong and
> > broken and will cause problems when you try to remove the device from
> > the system.
> 
> Let me check I understand you correctly. The class is:
> 
>     static struct class *console_class;
>     [...]
>     console_class = class_create(THIS_MODULE, "console");
> 
> Which exists within printk.c. This class exists to contain all consoles
> which present themselves over the lifetime of the kernel.
> 
> console_classdev_release is the release for a single console's "classdev"
> object, rather than the release of the class itself.

Yes.

> If you're talking about properly freeing the memory, I suppose it should
> happen by doing something like the following in unregister_console():
> 
>     if (!console_drivers)
>         /* free the class object under console lock */
> 
> ...right? Let me know if I'm misunderstanding you.

You can't do that as the driver core should now be managing the
lifespace of that object.  You can't "know" when the object's memory is
to be freed EXCEPT in the release function.

So free it there please.

Or do not tie the lifepan of the console class device object to the
console object, and keep it separate.  I don't remember exactly how you
tied them together here, sorry.

> Any suggestions you have here are more than welcome, I'm definitely not that
> familiar with the device/class API.
> 
> > > +static void console_register_device(struct console *new)
> > > +{
> > > +	/*
> > > +	 * We might be called from register_console() before the class is
> > > +	 * registered. If that happens, we'll take care of it in
> > > +	 * printk_late_init.
> > 
> > If so, is the device properly registered there as well?  I missed that
> > logic...
> 
> We call console_register_device() on all previously known consoles at
> late_initcall() time. Or were you thinking of something else?

I do not know, you say the class device will be created as some other
time.  I didn't know when that time was as I only saw one place it was
created here.  And you errored out early here.

> > > +	 */
> > > +	if (IS_ERR_OR_NULL(console_class))
> > > +		return;
> > > +
> > > +	new->flags |= CON_CLASSDEV_ACTIVE;
> > > +	device_initialize(&new->classdev);
> > > +	dev_set_name(&new->classdev, "%s", new->name);
> > > +	new->classdev.release = console_classdev_release;
> > > +	new->classdev.class = console_class;
> > > +	if (WARN_ON(device_add(&new->classdev)))
> > 
> > What is with these random WARN_ON() stuff?  Don't do that, just handle
> > the error and move on properly.  Systems with panic_on_warn() should not
> > fail from stuff like this, that's rude to cause them to reboot.
> 
> Oh, that's fair enough, I hadn't thought of that. Ack.
> 
> > > +	console_class = class_create(THIS_MODULE, "console");
> > > +	if (!WARN_ON(IS_ERR(console_class)))
> > > +		console_class->dev_groups = console_sysfs_groups;
> > 
> > Do you ever free the class?
> 
> Currently no. What do you think about the above proposal to do it once the
> console driver list is exhausted?

If the code can never be unloaded, no, don't worry about it.

thanks.

greg k-h
