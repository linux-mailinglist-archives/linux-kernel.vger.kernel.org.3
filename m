Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F2C46BBC7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhLGMzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:55:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229463AbhLGMzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638881496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQV1xzWOEOwb9RfCG2y/1CHxMXP75lI2nbve1UdiEQk=;
        b=UeM+9ZYDBRcy5ML/9qElCpR5YIe5QzQKwuI4LXn5U70Odz3IGK2GkFLmEgONqdjPcDGvUh
        EtS8cj126jy4Z9r5cZwPwkdWs1lDd00TY6U4Xjb8rHJHdd2uRuhZVvK4Gg6YVfp8aaLXxe
        ULK2rdVMqzZI2CkRunxVECR3s1XH+UY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-24-8ytB88oHN0SIKla8OL9z0A-1; Tue, 07 Dec 2021 07:51:33 -0500
X-MC-Unique: 8ytB88oHN0SIKla8OL9z0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADBD534837;
        Tue,  7 Dec 2021 12:51:32 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 945C510016F5;
        Tue,  7 Dec 2021 12:51:29 +0000 (UTC)
Date:   Tue, 7 Dec 2021 20:51:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH V2 2/2] kobject: wait until kobject is cleaned up before
 freeing module
Message-ID: <Ya9YzNhHpZ5VpAI4@T590>
References: <20211129034509.2646872-1-ming.lei@redhat.com>
 <20211129034509.2646872-3-ming.lei@redhat.com>
 <YaoyuzPutBjLuVNt@kroah.com>
 <Ya1x4VQymqhy9FDD@T590>
 <Ya3EGLbhNWrpTqX+@kroah.com>
 <Ya84O2/nYCyNb/fp@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya84O2/nYCyNb/fp@alley>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 11:32:27AM +0100, Petr Mladek wrote:
> On Mon 2021-12-06 09:04:40, Greg Kroah-Hartman wrote:
> > On Mon, Dec 06, 2021 at 10:13:53AM +0800, Ming Lei wrote:
> > > On Fri, Dec 03, 2021 at 04:07:39PM +0100, Greg Kroah-Hartman wrote:
> > > > On Mon, Nov 29, 2021 at 11:45:09AM +0800, Ming Lei wrote:
> > > > > kobject_put() may become asynchronously because of
> > > > > CONFIG_DEBUG_KOBJECT_RELEASE, so once kobject_put() returns, the caller may
> > > > > expect the kobject is released after the last refcnt is dropped, however
> > > > > CONFIG_DEBUG_KOBJECT_RELEASE just schedules one delayed work function
> > > > > for cleaning up the kobject.
> > > > 
> > > > The caller should NOT expect the kobject to be released.  That's the
> > > > whole point of dynamic reference counted objects, you never "know" when
> > > > the last object is released.  This option just makes it obvious so that
> > > > you know when to fix up code that has this assumption.
> > > 
> > > > > Inside the cleanup handler, kobj->ktype and kobj->ktype->release are
> > > > > required.
> > > > 
> > > > Yes. Is that a problem?
> > > 
> > > Of course for CONFIG_DEBUG_KOBJECT_RELEASE, which delays to call
> > > ->release after random time, when the module for storing ->ktype and
> > > ->ktype->release has been unloaded.
> > > 
> > > As I mentioned, the issue can be triggered 100% by 'modprobe -r
> > > kset-example' when CONFIG_DEBUG_KOBJECT_RELEASE is enabled if the
> > > 1st patch is applied.
> > 
> > Is there any "real" kernel code that this causes problems on?
> > 
> > Again, this is for debugging, yes, this tiny example will crash that
> > way, but that is fine, as we can obviously see that the kernel code here
> > is correct.
> > 
> > And if you really want to ensure that it works properly, let's wait on
> > release before allowing that module to be unloaded.
> 
> This is exactly what this patch is trying to achieve. IMHO,
> we should do it another way, see below.
> 
> 
> > But again, module unload is NOT a normal operation and is not what
> > this debugging option was created to help out with.
> 
> But people do unload module and especially when testing kernel.
> IMHO, we want both CONFIG_DEBUG_KOBJECT_RELEASE and module unload
> enabled when testing kernel.
> 
> 
> > Again, the confusion between kobjects (which protect data) and module
> > references (which protect code) is getting mixed up here.
> 
> This is perfect description of the problem. And the problem is real.
> 
> kobjects protect data but they need to call code (callbacks) when
> they are released. module unload is special because it removes the
> code. CONFIG_DEBUG_KOBJECT_RELEASE always delays the code calls.
> It results into a crash even when everything works as expected.
> 
> 
> Now, back to the proposed patch. I agree that it looks weird. It
> makes CONFIG_DEBUG_KOBJECT_RELEASE useless in this scenario.

Can you explain how this patch makes CONFIG_DEBUG_KOBJECT_RELEASE useless?
The kobject is still cleaned up with random delay.

> 
> I have another idea. What about adding a pointer to
> struct module *mod into struct kobj_type. Some reference
> counter and wait_queue into struct module. They might be
> used to block the module_exit() until the reference counter
> reaches zero.
> 
> I mean something like:
> 
> Let's take samples/kobject/kset-sample.c as an example.
> We could define:
> 
> static struct kobj_type foo_ktype = {
> 	.sysfs_ops = &foo_sysfs_ops,
> 	.release = foo_release,
> 	.default_groups = foo_default_groups,
> 	.mod = THIS_MODULE,
> };
> 
> then we might do:
> 
> static int kobject_add_internal(struct kobject *kobj)
> {
> [...]
> 	if (kobject->ktype->mod)
> 		module_get_kobject_referece(kobject->ktype->mod);
> [...]
> }
> 
> and
> 
> static void kobject_cleanup(struct kobject *kobj)
> {
> [...]
> 	if (kobject->ktype->mod)
> 		module_put_kobject_referece(kobject->ktype->mod);
> [...]
> }
> 
> where
> 
> void module_get_kobject_referece(struct module *mod)
> {
> 	mutex_lock(&module_mutex);
> 	mod->kobject_ref++;
> 	mutex_lock(&module_mutex);
> }
> 
> void module_put_kobject_referece(struct module *mod)
> {
> 	struct wait_queue_head *module_kobject_wq;
> 
> 	mutex_lock(&module_mutex);
> 	mod->kobject_ref--;
> 	if (!mod->kobject_ref)
> 		wake_up(mod->kobj_release_wq);
> 	mutex_lock(&module_mutex);

The question is why kobject is so special for taking one extra
module ref here.

> }
> 
> 
> and
> 
> SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
> 		unsigned int, flags)
> {
> [...]
> 	wait_event_interruptible(mod->kobj_release_wq, !mod->kobj_ref);
> [...]
> }
> 
> There might be many details to be solved.
> 
> But it looks like a win-win solution. It should make module unload
> much more secure. Broken modules will just get blocked in
> module_cleanup forever. CONFIG_DEBUG_KOBJECT_RELEASE will still
> work as designed.

The above approach might work, but it needs every driver with kobjects
to be changed, so it is more complicated.


Thanks
Ming

