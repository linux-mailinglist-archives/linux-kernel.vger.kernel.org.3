Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E894708F6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245462AbhLJSkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:40:32 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40952 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242116AbhLJSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:40:32 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id A9D0520B7179;
        Fri, 10 Dec 2021 10:36:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A9D0520B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639161416;
        bh=OpqQ41JyVafBp3DvkBZxII60kxNqelzO+DyYetDXZig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8JpLIBgM7vdGBNKWQk/u54y5CMiIulv0ATrzoEsmjldxXM5wPBaJmMIRKbrSkhQ+
         mIr/4bQqImtL8hKKsMNYQgYmJzRIASZqfoo0PnZi0Wt6PbnSmcwBl5aijyn/0DQqJ3
         XdetyP2NgDOaa6xw+idK5BJ0HsfVhxILnCzf+OUE=
Date:   Fri, 10 Dec 2021 10:36:51 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/13] user_events: Optimize writing events by only
 copying data once
Message-ID: <20211210183651.GA2242@kbox>
References: <20211209223210.1818-1-beaub@linux.microsoft.com>
 <20211209223210.1818-10-beaub@linux.microsoft.com>
 <20211210235110.f674dd81e27bdedb231826a2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210235110.f674dd81e27bdedb231826a2@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 11:51:10PM +0900, Masami Hiramatsu wrote:
> Hi Beau,
> 
> On Thu,  9 Dec 2021 14:32:06 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > Pass iterator through to probes to allow copying data directly to the
> > probe buffers instead of taking multiple copies. Enables eBPF user and
> > raw iterator types out to programs for no-copy scenarios.
> > 
> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> > ---

[..]

> > @@ -1009,32 +1059,28 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
> >  	if (likely(atomic_read(&tp->key.enabled) > 0)) {
> >  		struct tracepoint_func *probe_func_ptr;
> >  		user_event_func_t probe_func;
> > +		struct iov_iter copy;
> >  		void *tpdata;
> > -		void *kdata;
> > -		u32 datalen;
> >  
> > -		kdata = kmalloc(i->count, GFP_KERNEL);
> > -
> > -		if (unlikely(!kdata))
> > -			return -ENOMEM;
> > -
> > -		datalen = copy_from_iter(kdata, i->count, i);
> > +		if (unlikely(iov_iter_fault_in_readable(i, i->count)))
> > +			return -EFAULT;
> >  
> >  		rcu_read_lock_sched();
> > +		pagefault_disable();
> 
> Since the pagefault_disable() may have unexpected side effect,
> I think it should be used really limited area, e.g. around
> actual memory access function.
> Can we move this around the copy_nofault()?
> 

Sure thing.

> Thank you,
> >  
> >  		probe_func_ptr = rcu_dereference_sched(tp->funcs);
> >  
> >  		if (probe_func_ptr) {
> >  			do {
> > +				copy = *i;
> >  				probe_func = probe_func_ptr->func;
> >  				tpdata = probe_func_ptr->data;
> > -				probe_func(user, kdata, datalen, tpdata);
> > +				probe_func(user, &copy, tpdata);
> >  			} while ((++probe_func_ptr)->func);
> >  		}
> >  
> > +		pagefault_enable();
> >  		rcu_read_unlock_sched();
> > -
> > -		kfree(kdata);
> >  	}
> >  
> >  	return ret;
> > -- 
> > 2.17.1
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

Thanks,
-Beau
