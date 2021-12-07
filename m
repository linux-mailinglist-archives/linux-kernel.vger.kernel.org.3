Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A746B932
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhLGKgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:36:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44514 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhLGKf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:35:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9F6171FD2F;
        Tue,  7 Dec 2021 10:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638873147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UypIpMWpJDoNNaNmzUyWIZUoGyc1B5eW06XAcW7VjPc=;
        b=VpoOVJMPfSa7Yh0Bkck0L88hjggVBNKJMMtdxlBIHA/zSQLDaFgRbWLemHaX16BgujCTXi
        soCUtyjpXL6X0InSsi4b6B1hNULqGRr8CuxjONdNmPM7lTeHkHPfUtxta3bJ+ztWPVFm/l
        zwMqT0VpgWsqmNYp045VRGjkgv5bHhY=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8306FA3B81;
        Tue,  7 Dec 2021 10:32:27 +0000 (UTC)
Date:   Tue, 7 Dec 2021 11:32:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH V2 2/2] kobject: wait until kobject is cleaned up before
 freeing module
Message-ID: <Ya84O2/nYCyNb/fp@alley>
References: <20211129034509.2646872-1-ming.lei@redhat.com>
 <20211129034509.2646872-3-ming.lei@redhat.com>
 <YaoyuzPutBjLuVNt@kroah.com>
 <Ya1x4VQymqhy9FDD@T590>
 <Ya3EGLbhNWrpTqX+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya3EGLbhNWrpTqX+@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-12-06 09:04:40, Greg Kroah-Hartman wrote:
> On Mon, Dec 06, 2021 at 10:13:53AM +0800, Ming Lei wrote:
> > On Fri, Dec 03, 2021 at 04:07:39PM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Nov 29, 2021 at 11:45:09AM +0800, Ming Lei wrote:
> > > > kobject_put() may become asynchronously because of
> > > > CONFIG_DEBUG_KOBJECT_RELEASE, so once kobject_put() returns, the caller may
> > > > expect the kobject is released after the last refcnt is dropped, however
> > > > CONFIG_DEBUG_KOBJECT_RELEASE just schedules one delayed work function
> > > > for cleaning up the kobject.
> > > 
> > > The caller should NOT expect the kobject to be released.  That's the
> > > whole point of dynamic reference counted objects, you never "know" when
> > > the last object is released.  This option just makes it obvious so that
> > > you know when to fix up code that has this assumption.
> > 
> > > > Inside the cleanup handler, kobj->ktype and kobj->ktype->release are
> > > > required.
> > > 
> > > Yes. Is that a problem?
> > 
> > Of course for CONFIG_DEBUG_KOBJECT_RELEASE, which delays to call
> > ->release after random time, when the module for storing ->ktype and
> > ->ktype->release has been unloaded.
> > 
> > As I mentioned, the issue can be triggered 100% by 'modprobe -r
> > kset-example' when CONFIG_DEBUG_KOBJECT_RELEASE is enabled if the
> > 1st patch is applied.
> 
> Is there any "real" kernel code that this causes problems on?
> 
> Again, this is for debugging, yes, this tiny example will crash that
> way, but that is fine, as we can obviously see that the kernel code here
> is correct.
> 
> And if you really want to ensure that it works properly, let's wait on
> release before allowing that module to be unloaded.

This is exactly what this patch is trying to achieve. IMHO,
we should do it another way, see below.


> But again, module unload is NOT a normal operation and is not what
> this debugging option was created to help out with.

But people do unload module and especially when testing kernel.
IMHO, we want both CONFIG_DEBUG_KOBJECT_RELEASE and module unload
enabled when testing kernel.


> Again, the confusion between kobjects (which protect data) and module
> references (which protect code) is getting mixed up here.

This is perfect description of the problem. And the problem is real.

kobjects protect data but they need to call code (callbacks) when
they are released. module unload is special because it removes the
code. CONFIG_DEBUG_KOBJECT_RELEASE always delays the code calls.
It results into a crash even when everything works as expected.


Now, back to the proposed patch. I agree that it looks weird. It
makes CONFIG_DEBUG_KOBJECT_RELEASE useless in this scenario.

I have another idea. What about adding a pointer to
struct module *mod into struct kobj_type. Some reference
counter and wait_queue into struct module. They might be
used to block the module_exit() until the reference counter
reaches zero.

I mean something like:

Let's take samples/kobject/kset-sample.c as an example.
We could define:

static struct kobj_type foo_ktype = {
	.sysfs_ops = &foo_sysfs_ops,
	.release = foo_release,
	.default_groups = foo_default_groups,
	.mod = THIS_MODULE,
};

then we might do:

static int kobject_add_internal(struct kobject *kobj)
{
[...]
	if (kobject->ktype->mod)
		module_get_kobject_referece(kobject->ktype->mod);
[...]
}

and

static void kobject_cleanup(struct kobject *kobj)
{
[...]
	if (kobject->ktype->mod)
		module_put_kobject_referece(kobject->ktype->mod);
[...]
}

where

void module_get_kobject_referece(struct module *mod)
{
	mutex_lock(&module_mutex);
	mod->kobject_ref++;
	mutex_lock(&module_mutex);
}

void module_put_kobject_referece(struct module *mod)
{
	struct wait_queue_head *module_kobject_wq;

	mutex_lock(&module_mutex);
	mod->kobject_ref--;
	if (!mod->kobject_ref)
		wake_up(mod->kobj_release_wq);
	mutex_lock(&module_mutex);
}


and

SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
		unsigned int, flags)
{
[...]
	wait_event_interruptible(mod->kobj_release_wq, !mod->kobj_ref);
[...]
}

There might be many details to be solved.

But it looks like a win-win solution. It should make module unload
much more secure. Broken modules will just get blocked in
module_cleanup forever. CONFIG_DEBUG_KOBJECT_RELEASE will still
work as designed.

Best Regards,
Petr
