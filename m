Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F89F46E0AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhLICHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhLICHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:07:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D453FC061746;
        Wed,  8 Dec 2021 18:03:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F5BAB82372;
        Thu,  9 Dec 2021 02:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF079C00446;
        Thu,  9 Dec 2021 02:03:37 +0000 (UTC)
Date:   Wed, 8 Dec 2021 21:03:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/13] user_events: Add minimal support for
 trace_event into ftrace
Message-ID: <20211208210336.40c7741b@yoga.local.home>
In-Reply-To: <20211209005823.GA21399@kbox>
References: <20211201182515.2446-1-beaub@linux.microsoft.com>
        <20211201182515.2446-3-beaub@linux.microsoft.com>
        <20211208181905.62f8f999@gandalf.local.home>
        <20211209005823.GA21399@kbox>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2021 16:58:23 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:
> >   
> > > +/*
> > > + * Handles the final close of the file from user mode.
> > > + */
> > > +static int user_events_release(struct inode *node, struct file
> > > *file) +{
> > > +	struct user_event_refs *refs;
> > > +	struct user_event *user;
> > > +	int i;
> > > +
> > > +	/*
> > > +	 * refs is protected by RCU and could in theory change
> > > immediately
> > > +	 * before this call on another core. To ensure we read
> > > the latest
> > > +	 * version of refs we acquire the RCU read lock again.
> > > +	 */
> > > +	rcu_read_lock_sched();
> > > +	refs = rcu_dereference_sched(file->private_data);
> > > +	rcu_read_unlock_sched();  
> > 
> > This still bothers me. Can another CPU call an ioctl here?  
> 
> Sorry :)
> 
> No, another CPU cannot call the ioctl on the file, since if another
> CPU had a reference to this file release couldn't be called.

OK, so it should be good, as the last fdput() will call this (and the
ioctl should keep that from happening until its done). But this could
also be done with less confusion and less paranoia if we simply take
the reg_mutex, as that should keep everything from changing, and we
wouldn't need to do any rcu_read_lock*() from the release function.

> 
> user_events_release is only called when the final reference to the
> file has been closed, so there cannot be another ioctl pending,
> starting or finishing for this file at the time it is called.
> 
> The last user mode program to call close() on the file will end up
> invoking user_events_release.

It doesn't work like that. There's only one close(). But you are
correct that it is protected, and that's by the fdget() and fdput()
that is done within the ioctl (and other) system call.

> 
> The user_event_refs is only accessible via the file's private_data,
> which now has zero references when release is executing. This means
> the private_data can no longer change and the rcu deref ensures we
> have the latest version.
> 
> refs is per-file, so while there can be other ioctl's occurring for
> other files, they are completely different ref objects than the one
> being cleaned up in the release of the file, it's not shared outside
> of this file lifetime, which has now ended.

Right, but I'm still paranoid ;-)

> 
> > 
> >   user_events_ioctl_reg() {
> >     user_events_ref_add() {
> >       refs = rcu_dereference_protected(file->private_data, ..);
> >       new_refs = kzalloc(size, GFP_KERNEL);
> >       rcu_assign_pointer(file->private_data, new_refs);
> >       if (refs)
> >         kfree_rcu(refs, rcu);
> > 
> > refs now freed.
> >   
> 
> If user_events_ioctl is executing for that same file,
> user_events_release could not have been called due to the file being
> in use to issue the ioctl.


The only thing protecting against this is the fdget/put logic in the
system calls.

> 
> > > +
> > > +	if (!refs)
> > > +		goto out;
> > > +
> > > +	/*
> > > +	 * Do not need RCU while enumerating the events that
> > > were used.
> > > +	 * The lifetime of refs has reached an end, it's tied to
> > > this file.
> > > +	 * The underlying user_events are ref counted, and
> > > cannot be freed.
> > > +	 * After this decrement, the user_events may be freed
> > > elsewhere.
> > > +	 */
> > > +	for (i = 0; i < refs->count; ++i) {  
> > 
> > Fault on refs->count
> > 
> > ??  
> 
> refs after rcu_dereference is checked for null before accessing.
> 
> refs cannot be changed when release is being executed, since that
> would mean the ioctl ran without a file reference (not sure how that
> could happen).
> 
> This is why it's important that release get the latest version of
> refs, an ioctl could have JUST happened before the final close() in
> user mode, and if it jumped CPUs we could (in theory) get an old
> value. If we got an old value, then yes, the fault could occur.
> 
> This code uses the file ops release method as a final sync point to
> clean up everything for that file only after there are no more
> references to it at all, so nobody can do this kind of thing.
> 
> Is there some case I am missing where an ioctl on a file can be
> performed without a reference to that file?


Well, the ioctl can be called as the close happens, but it's the
internal working of fdget/put that protects it. If the ioctl is called
at the same time as the close, the fdget in the ioctl will keep the
close from calling the release. And as soon as the ioctl is finished,
it will call the fdput() which then calls the release logic.

> 
> Are you worried about a malicious user calling close on the file and
> then immediately issuing an ioctl on the now closed file?
> 
> If so, wouldn't ioctl just reject that file reference being used as
> not in the processes file table / invalid and not let the ioctl go
> through?
> 

I think it seems less confusing and saner to just use the mutex. It's
not a fast path is it?

-- Steve
