Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C64486D81
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245354AbiAFXGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:06:40 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35420 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245283AbiAFXGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:06:39 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 044E120B7179;
        Thu,  6 Jan 2022 15:06:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 044E120B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641510399;
        bh=buUHP8fC9tQAxLJEEHfo/DeMAZuMPHBgfiuebL5BYUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLCKWJxGJ6mbo2t7CfsM7/thg9ax6NITGDyhrDEAbKXRGRYNHZhIJZnUHVvT96u1p
         0MYdq8AY1+lV+zAIjhavvRqZ+cM7bb96GRJihnavKSHYaR8FAY7wYVMZRtMjR7f4yO
         J0tO6nOjj5hSRxXSxD/zi3Ld5/z44V++nOd6ei0Q=
Date:   Thu, 6 Jan 2022 15:05:45 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 08/12] user_events: Optimize writing events by only
 copying data once
Message-ID: <20220106230545.GA2447@kbox>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
 <20211216173511.10390-9-beaub@linux.microsoft.com>
 <20220106171745.1496c723@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106171745.1496c723@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 05:17:45PM -0500, Steven Rostedt wrote:
> On Thu, 16 Dec 2021 09:35:07 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > @@ -1018,16 +1081,11 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
> >  	if (likely(atomic_read(&tp->key.enabled) > 0)) {
> >  		struct tracepoint_func *probe_func_ptr;
> >  		user_event_func_t probe_func;
> > +		struct iov_iter copy;
> >  		void *tpdata;
> > -		void *kdata;
> > -		u32 datalen;
> > -
> > -		kdata = kmalloc(i->count, GFP_KERNEL);
> >  
> > -		if (unlikely(!kdata))
> > -			return -ENOMEM;
> > -
> > -		datalen = copy_from_iter(kdata, i->count, i);
> > +		if (unlikely(iov_iter_fault_in_readable(i, i->count)))
> 
> Can you rebase on my tree: ftrace/core ?
> 
> That's because upstream now has:
> 
> a6294593e8a12 ("iov_iter: Turn iov_iter_fault_in_readable into fault_in_iov_iter_readable")
> 
> And it looks like you need to call fault_in_iov_iter_readable().
> 
> -- Steve
> 

Yep, will do.

Thanks,
-Beau
