Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B5846F7A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhLIXpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhLIXpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:45:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D61C061746;
        Thu,  9 Dec 2021 15:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NQOkz+58iIwh074kD5OkKJo4F6+sW4mgDBTSjwuk9Xw=; b=fNpoCaPuk7AjINfB/4pcInCRI1
        tTUjrnqw4YM1Sz+1JYv0Z7TD/M0d027ULhbyAGxlusT/q3rhLL1wanyKYYj7rpwIuY3e/ggE4vH47
        y9RqkwMI4vulwLgq6ciTEkbZL1bRbSFKySlYLN+VmrOTgL/ZpC6BfmdS7aaOII7gf8tIffPhE74is
        bB/zhRPwQaB1hH1x8J4fwa1OAtOuYoaDVe2MhIUdGpIzOHsHocHRVU+VtsmWerhAAQ4H1Bya0odRq
        jZjAOvXkxwoxKUBtjaR9UMtCRAXb2xU3zJWKnX4z2T6+KXys5Y8BrtQSgIBbxTBx1TToz/fF933mz
        k3zbqTaw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvT3A-000PjW-90; Thu, 09 Dec 2021 23:42:08 +0000
Date:   Thu, 9 Dec 2021 15:42:08 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>, Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com
Subject: Re: [RFC PATCH] module: Introduce module unload taint tracking
Message-ID: <YbKUUJUtjBk/n913@bombadil.infradead.org>
References: <20211124173327.3878177-1-atomlin@redhat.com>
 <YbEZ4HgSYQEPuRmS@bombadil.infradead.org>
 <20211209153131.a54fdfbci4qnyy6h@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209153131.a54fdfbci4qnyy6h@ava.usersys.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 04:49:17PM +0000, Aaron Tomlin wrote:
> On Wed 2021-12-08 12:47 -0800, Luis Chamberlain wrote:
> > > If the previously unloaded module is loaded once again it will be removed
> > > from the list only if the taints bitmask is the same.
> > 
> > That doesn't seem to be clear. What if say a user loads a module which
> > taints the kernel, and then unloads it, and then tries to load a similar
> > module with the same name but that it does not taint the kernel?
> > 
> > Would't we loose visibility that at one point the tainting module was
> > loaded? OK I see after reviewing the patch that we keep track of each
> > module instance unloaded with an attached unsigned long taints. So if
> > a module was unloaded with a different taint, we'd see it twice. Is that
> > right?
> 
> Indeed - is this acceptable to you? I prefer this approach rather than
> remove it from the aforementioned list solely based on the module name.

Sure, it makes sense to keep all the stupid ways we are harming the
kernel. Makes sense. The other point I made about count though would
be good, in case the taint was the same.

> > wc -l kernel/*.c| sort -r -n -k 1| head
> > 84550 total
> > 6143 kernel/workqueue.c
> > 4810 kernel/module.c
> > 4789 kernel/signal.c
> > 3170 kernel/fork.c
> > 2997 kernel/auditsc.c
> > 2902 kernel/kprobes.c
> > 2857 kernel/sysctl.c
> > 2760 kernel/sys.c
> > 2712 kernel/cpu.c
> > 
> > I think it is time we start splitting module.c out into components,
> > and here we might have a good opportunity to do that. There are tons
> > of nasty cob webs I'd like to start cleaning up from module.c. So
> > how about we start by moving module stuff out to kernel/modules/main.c
> > and then you can bring in your taint friend into that directory.
> > 
> > That way we can avoid the #ifdefs, which seem to attract huge spiders.
> 
> Agreed. This makes sense. I'll work on it.

Wonderful, thanks!

> > Maybe live patch stuff go in its own file too?
> 
> At first glance, I believe this is possible too.

Great! Thanks for being willing to doing this!

> > Loading and unloading modules... to keep track of *which ones are
> > tainted*. I'd find it extremely hard to believe this is such a common
> > thing and hot path that we need this.
> > 
> > In any case, since a linked list is used, I'm curious why did you
> > decide to bound this to an arbitrary limit of say 20? If this
> > feature is enabled why not make this boundless?
> 
> It can be, once set to 0. Indeed, the limit specified above is arbitrary.
> Personally, I prefer to have some limit that can be controlled by the user.
> In fact, if agreed, I can incorporate the limit [when specified] into the
> output generated via print_modules().

If someone enables this feature I can't think of a reason why they
would want to limit this to some arbitrary number. So my preference
is to remove that limitation completely. I see no point to it.

> > > @@ -3703,6 +3778,16 @@ static noinline int do_init_module(struct module *mod)
> > >  	mod->state = MODULE_STATE_LIVE;
> > >  	blocking_notifier_call_chain(&module_notify_list,
> > >  				     MODULE_STATE_LIVE, mod);
> > > +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> > > +	mutex_lock(&module_mutex);
> > > +	old = find_mod_unload_taint(mod->name, strlen(mod->name),
> > > +				mod->taints);
> > > +	if (old) {
> > > +		list_del_rcu(&old->list);
> > > +		synchronize_rcu();
> > > +	}
> > > +	mutex_unlock(&module_mutex);
> > 
> > But here we seem to delete an old instance of the module taint
> > history if it is loaded again and has the same taint properties.
> > Why?
> 
> At first glance, in this particular case, I believe this makes sense to
> avoid duplication

If you just bump the count then its not duplication, it just adds
more information that the same module name with the same taint flag
has been unloaded now more than once.

> i.e. the taint module would be stored in the 'modules'
> list thus should be shown once via print_modules(). So, the initial
> objective was to only track a "tainted" module when unloaded and once
> added/or loaded again [with the same taint(s)] further tracking cease.

This makes me wonder, why not just grow the list at driver insertion
time, rather than removal.

> > I mean, if a taint happened once, and our goal is to keep track
> > of them, I'd imagine I'd want to know that this had happened
> > before, so instead how about just an increment counter for this,
> > so know how many times this has happened? Please use u64 for that.
> > I have some test environments where module unloaded happens *a lot*.
> 
> If I understand correctly, I do not like this approach but indeed it could
> work.

I'm a bit confused, because here you seem to suggest you don't like the
idea, and then...

> Personally, I would like to incorporate the above idea i.e. track
> the unload count, into the initial goal.

Here you say you'd like to keep the unloud count.

> > Please see kernel/sysctl.c changes on linux-next, we're moving away
> > from everyone stuffing their sysclts in kernel/sysctl.c and there
> > you can find helpers and examples of how *not* to do this. Its
> > on the kernel table so you should be able to just
> > register_sysctl_init("kernel", modules_sysctls) and while at it,
> > if you spot any sysctls for module under the kern_table, please
> > move those over and then your patch would be adding just one new
> > entry to that new local modules_sysctls table.
> > 
> > We'll have to coordinate with Andrew given that if your changes
> > depend on those changes then we might as well get all your
> > changes through Andrew for the next release cycle.
> 
> All right. I will make the required changes. Thanks once again.

Sure, so hey just one more thing. Can you add a simple selftest
lib/test_taint.c which can be used to test tainting and you new
tracker ? You can add a new selftest on

tools/testing/selftests/module/

I had already written some module based testing on
tools/testing/selftests/kmod/kmod.sh so you can borrow stuff
from there if you find it useful. But I think we need to start
doing basic testing for module. I know Lucas has tons of test
on kmod, so we should also look at what is there and what needs
testing outside of that.

Then there is the question of what should be tested using kunit and
or selftests. From my experience, if you need a shell, use selftests.
Also, if you need parallelization, use selftests, given kunit by
default uses a uniprocessor architecture, user-mode-linux. I'll let
you figure out what is the best place to add the test for this. It
could just be its a better place to add these tests to kmod upstream
as there are tons of tests there already. But kunit test can't be
added there.

Live patching already has its own set of selftests.

  Luis
