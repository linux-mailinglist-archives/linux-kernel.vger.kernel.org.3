Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1181346B008
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbhLGBxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:53:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230223AbhLGBxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638841820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9rjNoN434hpO94YkIheJJyBCmOKrbbGBG/vN0iSvPPc=;
        b=ffZpUe1y2w5VMMpJyizYOGmrlWk+JO3XJwkVo7lTpJEBGAliBk+CIpZIb3t0j96NOhz8l7
        rmLuje1dRHL6OYRjgIGzo8MFpvJCqC4UakunYLmbJq5BUtn8W21deBr0sCQ1zG5vxnXBtO
        V4DbdMv84edQxNvBjVy4hlU9j1m+3tk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-KiFXgk5ZPWuR0M3Xn2I4ZA-1; Mon, 06 Dec 2021 20:50:17 -0500
X-MC-Unique: KiFXgk5ZPWuR0M3Xn2I4ZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2CB510247AC;
        Tue,  7 Dec 2021 01:50:15 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7114C5D740;
        Tue,  7 Dec 2021 01:50:08 +0000 (UTC)
Date:   Tue, 7 Dec 2021 09:50:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH V2 2/2] kobject: wait until kobject is cleaned up before
 freeing module
Message-ID: <Ya69y7hPo52V0kRy@T590>
References: <20211129034509.2646872-1-ming.lei@redhat.com>
 <20211129034509.2646872-3-ming.lei@redhat.com>
 <YaoyuzPutBjLuVNt@kroah.com>
 <Ya1x4VQymqhy9FDD@T590>
 <Ya3EGLbhNWrpTqX+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya3EGLbhNWrpTqX+@kroah.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 09:04:40AM +0100, Greg Kroah-Hartman wrote:
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
> > Yes, so CONFIG_DEBUG_KOBJECT_RELEASE needs to be fixed.
> 
> What is broken with it today?  It is there for you to find problems in
> your kernel code that uses kobjects.  What oops/crash/whatever is it
> causing that you feel it should not be causing?
> 
> A module's kobject is "owned" by the module core, not the module code

No, this patch is nothing to do with module's kobject, we are talking
about any kobjects allocated/released from one driver built as module.

> that is being unloaded, so I don't see the problem here.  More details
> please.

If CONFIG_DEBUG_KOBJECT_RELEASE is enabled, kobject_release() will
schedule a (random time)delay work to run kobject_cleanup(), and the delay
work may be run after the module which allocates/frees the kobject is
unloaded.

kobject_cleanup():

	struct kobj_type *t = get_ktype(kobj);

	...
	if (t && t->release) {
                pr_debug("kobject: '%s' (%p): calling ktype release\n",
                         kobject_name(kobj), kobj);
                t->release(kobj);
	}

Both kobj_type and ->release are allocated in the module data/text section,
so kernel panic is triggered when 't && t->release' is run from the
delay work context.

> 
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

Nothing is wrong with kset-example, the issue is just that foo_ktype and
foo_release are allocated in code/data section of the module 'kset-example'.

There are ~150 such uses:

[linux]$ git grep -n "static struct kobj_type" ./  | grep "{" | wc
    153     923   11676

Most of the code can be built as module, so all should have such problem,
that is why I think it as one generic issue, not kset-example specific.
Here kset-example is referred just for showing the issue easily.

> 
> And if you really want to ensure that it works properly, let's wait on
> release before allowing that module to be unloaded.  But again, module

Then all modules which uses kobject need such change.

> unload is NOT a normal operation and is not what this debugging option
> was created to help out with.

But CONFIG_MODULE and CONFIG_DEBUG_KOBJECT_RELEASE can be enabled at the
same time.

> 
> Again, the confusion between kobjects (which protect data) and module
> references (which protect code) is getting mixed up here.
> 
> > > > It is supposed that no activity is on kobject itself any more since
> > > > module_exit() is started, so it is reasonable for the kobject user or
> > > > driver to expect that kobject can be really released in the last run of
> > > > kobject_put() in module_exit() code path. Otherwise, it can be thought as
> > > > one driver's bug since the module is going away.
> > > 
> > > Why is module_exit() somehow special here?  What is so odd about that?
> > 
> > After module_exit() is done, the module will be unloaded, then any code
> > or data stored in the module can't be referred.
> > 
> > > 
> > > > When the ->ktype and ->ktype->release are allocated as module static
> > > > variable, it can cause trouble because the delayed cleanup handler may
> > > > be run after the module is unloaded.
> > > 
> > > Why is ktype and release part of module code?
> > 
> > Lots of driver defines ktype and ktype->release in its module static
> > variable.
> 
> They do?  Where?
> 
> > > What module kobject is causing this problem?
> > 
> > Any modules which defines its ktype and ktype->release in its module
> > static variable, which is pretty common.
> 
> What non-example code does this?  Let's fix that.
> 
> > > > Fixes the issue by flushing scheduled kobject cleanup work before
> > > > freeing module.
> > > 
> > > Why are modules special here?
> > > 
> > > And if you enable this option, and then start unloading kernel modules,
> > > yes, things can go wrong, but that's not what this kernel option is for
> > > at all.
> > > 
> > > This feels like a hack for not a real problem.
> > 
> > I think it is caused by CONFIG_DEBUG_KOBJECT_RELEASE, that is why this
> > patch is posted. Otherwise I'd suggest to remove
> > CONFIG_DEBUG_KOBJECT_RELEASE, which supposes to not panic kernel since
> > there isn't anything wrong from driver side.
> 
> Perhaps just put a nice warning in that debug option that says "beware
> of unloading modules with this option enabled."
> 
> Or better yet, forbid it if that option is enabled :)

You mean disabling CONFIG_DEBUG_KOBJECT_RELEASE if CONFIG_MODULE is
enabled?


Thanks,
Ming

