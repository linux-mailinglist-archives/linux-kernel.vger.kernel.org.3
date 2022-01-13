Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5F948DD68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiAMSEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:04:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44566 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbiAMSEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:04:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E121961D45
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 18:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2BBC36AE9;
        Thu, 13 Jan 2022 18:04:05 +0000 (UTC)
Date:   Thu, 13 Jan 2022 13:04:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
Message-ID: <20220113130404.6fa21951@gandalf.local.home>
In-Reply-To: <Yd5VTy0UW1tOcjTD@piliu.users.ipa.redhat.com>
References: <20220110115532.536088fd@gandalf.local.home>
        <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
        <20220110122436.5302128f@gandalf.local.home>
        <Yd5VTy0UW1tOcjTD@piliu.users.ipa.redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 12:13:03 +0800
Pingfan Liu <kernelfans@gmail.com> wrote:

> Hi Steven,
> 
> Sorry that I am out of office, and not reply in time.

And I've been very sick for the last few days :-p

> 
> On Mon, Jan 10, 2022 at 12:24:36PM -0500, Steven Rostedt wrote:
> > On Mon, 10 Jan 2022 17:11:52 +0000
> > David Laight <David.Laight@ACULAB.COM> wrote:
> >   
> > > From: Steven Rostedt  
> > > > Sent: 10 January 2022 16:56
> > > > 
> > > > From: Steven Rostedt <rostedt@goodmis.org>
> > > > 
> > > > Pingfan reported that the following causes a fault:
> > > > 
> > > >   echo "filename ~ \"cpu\"" > events/syscalls/sys_enter_openat/filter
> > > >   echo 1 > events/syscalls/sys_enter_at/enable
> > > > 
> > > > The reason is that trace event filter treats the user space pointer
> > > > defined by "filename" as a normal pointer to compare against the "cpu"
> > > > string. If the string is not loaded into memory yet, it will trigger a
> > > > fault in kernel space:    
> 
> For accurate commit log, the swapped-out user page is not the root cause
> of this bug is "supervisor read access in kernel mode". And it is trueth
> that swapped-out user page can trigger a bug here, but it should be a
> different a stack.

Yeah, it's true that the bug that triggered is the supervisor access, but
that's more of a security concern (and an option that triggers this, to
find bugs of this kind :-)  To me, the real bug is the random read of a
pointer. I can update the change log to be a bit more specific.

> 
> > > 
> > > If a userspace pointer can end up the kernel structure then presumably
> > > a 'dodgy' user program can supply an arbitrary kernel address instead?
> > > This may give the user the ability to read arbitrary kernel addresses
> > > (including ones that are mapped to PCIe IO addresses).
> > > Doesn't sound good at all.  
> > 
> > Only root has access to the information read here. All tracing requires
> > root or those explicitly given access to the tracing data, which pretty
> > much allows all access to kernel internals (including all memory). So
> > nothing to worry about here ;-)
> >   
> 
> I am not sure about the opposite way. Since kernel is not allowed to
> access userspace most of the time, then is it an leakage, which looks
> like:
>     use tracepoint as trampoline to uaccess.
>     read out user info from ustring_per_cpu
> 
> But any kernel code can call copy_from_user() function family freely, so
> it is not a problem caused by this patch, right? Or ustring_per_cpu
> should be zeroed out.

And you can use tracing to create a kprobe that can read user space at
almost any place in the kernel. Hence, we have API that allows root to do
this, which is why I'm not concerned about it.

> 
> For V2, feel free to add "Tested-by"
> 
> 

Thanks,

-- Steve
