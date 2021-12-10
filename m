Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBB146FE58
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbhLJKE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:04:29 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34066 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbhLJKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:04:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 56F1B1F387;
        Fri, 10 Dec 2021 10:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639130452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IcWeCIhgKkKzP2YbORGi9bJuxALgb0b3tzuG4XaRiaE=;
        b=mqr5bgyvgkfQIa8g2c2yreQmf+HF7k6XcvlITBJNx/59vsawgt/GWuIgeTICcssF9LV7AA
        5vk9qnuMP8CUR1MxKyDnROtNtShvUrVtBQ1PCLjg1B5fttiT1/a9EKLrQ8OmVtUnlRyb03
        hGxP1C5tznr4yE4Lyc0Ktj03n6z/EEE=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 34B92A3B92;
        Fri, 10 Dec 2021 10:00:52 +0000 (UTC)
Date:   Fri, 10 Dec 2021 11:00:52 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com
Subject: Re: [RFC PATCH] module: Introduce module unload taint tracking
Message-ID: <YbMlVFwBiRujKdEX@alley>
References: <20211124173327.3878177-1-atomlin@redhat.com>
 <YbEZ4HgSYQEPuRmS@bombadil.infradead.org>
 <20211209153131.a54fdfbci4qnyy6h@ava.usersys.com>
 <YbKUUJUtjBk/n913@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbKUUJUtjBk/n913@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-12-09 15:42:08, Luis Chamberlain wrote:
> On Thu, Dec 09, 2021 at 04:49:17PM +0000, Aaron Tomlin wrote:
> > On Wed 2021-12-08 12:47 -0800, Luis Chamberlain wrote:
> > > Loading and unloading modules... to keep track of *which ones are
> > > tainted*. I'd find it extremely hard to believe this is such a common
> > > thing and hot path that we need this.
> > > 
> > > In any case, since a linked list is used, I'm curious why did you
> > > decide to bound this to an arbitrary limit of say 20? If this
> > > feature is enabled why not make this boundless?
> > 
> > It can be, once set to 0. Indeed, the limit specified above is arbitrary.
> > Personally, I prefer to have some limit that can be controlled by the user.
> > In fact, if agreed, I can incorporate the limit [when specified] into the
> > output generated via print_modules().
> 
> If someone enables this feature I can't think of a reason why they
> would want to limit this to some arbitrary number. So my preference
> is to remove that limitation completely. I see no point to it.

I agree with Luis here. We could always add the limit later when
people report some real life problems with too long list. It is
always good to know that someone did some heavy lifting in
the system.

It might be even interesting to remember timestamp of the removal
to match it with another events reported in the system log.

> > > > @@ -3703,6 +3778,16 @@ static noinline int do_init_module(struct module *mod)
> > > >  	mod->state = MODULE_STATE_LIVE;
> > > >  	blocking_notifier_call_chain(&module_notify_list,
> > > >  				     MODULE_STATE_LIVE, mod);
> > > > +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> > > > +	mutex_lock(&module_mutex);
> > > > +	old = find_mod_unload_taint(mod->name, strlen(mod->name),
> > > > +				mod->taints);
> > > > +	if (old) {
> > > > +		list_del_rcu(&old->list);
> > > > +		synchronize_rcu();
> > > > +	}
> > > > +	mutex_unlock(&module_mutex);
> > > 
> > > But here we seem to delete an old instance of the module taint
> > > history if it is loaded again and has the same taint properties.
> > > Why?
> > 
> > At first glance, in this particular case, I believe this makes sense to
> > avoid duplication
> 
> If you just bump the count then its not duplication, it just adds
> more information that the same module name with the same taint flag
> has been unloaded now more than once.

Please, do not remove records that a module was removed. IMHO, it
might be useful to track all removed module, including the non-tainted
ones. Module removal is always tricky and not much tested. The tain
flags might be just shown as extra information in the output.

Best Regards,
Petr
