Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2FB46F42D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhLITqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:46:16 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41482 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhLITqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:46:14 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id E4F7820B7179;
        Thu,  9 Dec 2021 11:42:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E4F7820B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639078960;
        bh=6PokUtcrP8KaG1TthajLFz7CIoTEDjJzdERcPkSHxGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m77HHe42K3ru8HroTMydjd5Jbi5EUtmh3VdO182mFkN6lLIjoIx+ZTnEPESWrEy5w
         i8z+wtwRsLJlSpuxpiDqHq+UkWymvfMitwLe/6L++a6XQK2C1Lr5sLe1+YUJfuZE4A
         in7D3GFESQXfmIZVaYU2YIJd1bl1P/4meQRZ5mQw=
Date:   Thu, 9 Dec 2021 11:42:35 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/13] user_events: Add minimal support for
 trace_event into ftrace
Message-ID: <20211209194235.GA21676@kbox>
References: <20211201182515.2446-1-beaub@linux.microsoft.com>
 <20211201182515.2446-3-beaub@linux.microsoft.com>
 <20211208181905.62f8f999@gandalf.local.home>
 <20211209005823.GA21399@kbox>
 <20211208210336.40c7741b@yoga.local.home>
 <20211209174050.GA21553@kbox>
 <20211209124735.3d1a9707@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209124735.3d1a9707@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 12:47:35PM -0500, Steven Rostedt wrote:
> On Thu, 9 Dec 2021 09:40:50 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > No, this is not a fast path, and I don't have a problem moving to a
> > mutex if you feel that is better. I've likely become too close to this
> > code to know when things are confusing for others.
> 
> Yeah. I really dislike the "protection by algorithms" then protection by
> locking unless it is a fast path.
> 
> If this was a fast path then I'd be more concerned. I dislike global locks
> as well, but unless contention becomes a concern, I don't think we should
> worry about it.

Sure thing.

> 
> Also, for this comment:
> 
> +static int user_events_release(struct inode *node, struct file *file)
> +{
> +	struct user_event_refs *refs;
> +	struct user_event *user;
> +	int i;
> +
> +	/*
> +	 * refs is protected by RCU and could in theory change immediately
> +	 * before this call on another core. To ensure we read the latest
> +	 * version of refs we acquire the RCU read lock again.
> +	 */
> +	rcu_read_lock_sched();
> +	refs = rcu_dereference_sched(file->private_data);
> +	rcu_read_unlock_sched();
> 
> How do you see refs changing on another core if this can only be called
> when nothing has a reference to it?
> 
> I think this comment and grabbing the rcu locks is what is causing me
> concern.
> 
> -- Steve

User program task:
CPU0: ioctl(fd, REG)
CPU1: close(fd)

IE: Some program registers and then immediately calls close on the file.
If the CPU migrates right between the 2 and the close swaps, it is
possible this could occur.

This could be attempted in tight loops maliciously as well.

I assume with a mutex there that some barrier is imposed to ensure
correct reads in this condition? (By virtue of the mutex acquire/check)

Thanks,
-Beau
