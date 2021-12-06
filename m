Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943F6469124
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbhLFIIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbhLFIIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:08:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43ABC0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 00:04:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40BD8611CB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D7EC341C1;
        Mon,  6 Dec 2021 08:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638777885;
        bh=nz+oJRG0+Y8KCGpz3zU0oUuVlA65tTvfQwSxEpPeWME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ys+Mu6wihtnjIL8XquRtzrLmbPi4Oswf0u39cJqu8C7oyTytl33emonJVzOzMPsdq
         A2Txob7MaWPySNFVh/vfnX6w4CGUofCcz+edGOzI+K3m3bAuXW8rI1wTGukeI2+zlL
         OlEliIUB4c57Wh2X/biframjoJXBz16txOYa2kvs=
Date:   Mon, 6 Dec 2021 09:04:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH V2 2/2] kobject: wait until kobject is cleaned up before
 freeing module
Message-ID: <Ya3EGLbhNWrpTqX+@kroah.com>
References: <20211129034509.2646872-1-ming.lei@redhat.com>
 <20211129034509.2646872-3-ming.lei@redhat.com>
 <YaoyuzPutBjLuVNt@kroah.com>
 <Ya1x4VQymqhy9FDD@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya1x4VQymqhy9FDD@T590>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 10:13:53AM +0800, Ming Lei wrote:
> On Fri, Dec 03, 2021 at 04:07:39PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Nov 29, 2021 at 11:45:09AM +0800, Ming Lei wrote:
> > > kobject_put() may become asynchronously because of
> > > CONFIG_DEBUG_KOBJECT_RELEASE, so once kobject_put() returns, the caller may
> > > expect the kobject is released after the last refcnt is dropped, however
> > > CONFIG_DEBUG_KOBJECT_RELEASE just schedules one delayed work function
> > > for cleaning up the kobject.
> > 
> > The caller should NOT expect the kobject to be released.  That's the
> > whole point of dynamic reference counted objects, you never "know" when
> > the last object is released.  This option just makes it obvious so that
> > you know when to fix up code that has this assumption.
> 
> Yes, so CONFIG_DEBUG_KOBJECT_RELEASE needs to be fixed.

What is broken with it today?  It is there for you to find problems in
your kernel code that uses kobjects.  What oops/crash/whatever is it
causing that you feel it should not be causing?

A module's kobject is "owned" by the module core, not the module code
that is being unloaded, so I don't see the problem here.  More details
please.

> > > Inside the cleanup handler, kobj->ktype and kobj->ktype->release are
> > > required.
> > 
> > Yes. Is that a problem?
> 
> Of course for CONFIG_DEBUG_KOBJECT_RELEASE, which delays to call
> ->release after random time, when the module for storing ->ktype and
> ->ktype->release has been unloaded.
> 
> As I mentioned, the issue can be triggered 100% by 'modprobe -r
> kset-example' when CONFIG_DEBUG_KOBJECT_RELEASE is enabled if the
> 1st patch is applied.

Is there any "real" kernel code that this causes problems on?

Again, this is for debugging, yes, this tiny example will crash that
way, but that is fine, as we can obviously see that the kernel code here
is correct.

And if you really want to ensure that it works properly, let's wait on
release before allowing that module to be unloaded.  But again, module
unload is NOT a normal operation and is not what this debugging option
was created to help out with.

Again, the confusion between kobjects (which protect data) and module
references (which protect code) is getting mixed up here.

> > > It is supposed that no activity is on kobject itself any more since
> > > module_exit() is started, so it is reasonable for the kobject user or
> > > driver to expect that kobject can be really released in the last run of
> > > kobject_put() in module_exit() code path. Otherwise, it can be thought as
> > > one driver's bug since the module is going away.
> > 
> > Why is module_exit() somehow special here?  What is so odd about that?
> 
> After module_exit() is done, the module will be unloaded, then any code
> or data stored in the module can't be referred.
> 
> > 
> > > When the ->ktype and ->ktype->release are allocated as module static
> > > variable, it can cause trouble because the delayed cleanup handler may
> > > be run after the module is unloaded.
> > 
> > Why is ktype and release part of module code?
> 
> Lots of driver defines ktype and ktype->release in its module static
> variable.

They do?  Where?

> > What module kobject is causing this problem?
> 
> Any modules which defines its ktype and ktype->release in its module
> static variable, which is pretty common.

What non-example code does this?  Let's fix that.

> > > Fixes the issue by flushing scheduled kobject cleanup work before
> > > freeing module.
> > 
> > Why are modules special here?
> > 
> > And if you enable this option, and then start unloading kernel modules,
> > yes, things can go wrong, but that's not what this kernel option is for
> > at all.
> > 
> > This feels like a hack for not a real problem.
> 
> I think it is caused by CONFIG_DEBUG_KOBJECT_RELEASE, that is why this
> patch is posted. Otherwise I'd suggest to remove
> CONFIG_DEBUG_KOBJECT_RELEASE, which supposes to not panic kernel since
> there isn't anything wrong from driver side.

Perhaps just put a nice warning in that debug option that says "beware
of unloading modules with this option enabled."

Or better yet, forbid it if that option is enabled :)

thanks,

greg k-h
