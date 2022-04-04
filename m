Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE8D4F107D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377912AbiDDIHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiDDIHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:07:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D4F31DF2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:05:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A55BA6113A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D832DC2BBE4;
        Mon,  4 Apr 2022 08:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649059525;
        bh=eXz1vXQQHy3LnBmYW+RlyT42NH7KLxitiuQOPs1BwB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e54igkF5nmIASNIiX7srrvXfqOErS9pgrNsMfimn3l0DrdgCgZ5J01ufJ+0Ki0sJB
         GQEsl8Vly0YXxDIpZZLibibTXL0lKaqNu8lhYJNWcSy7k1mKbrBvkUnpYUrX5v86Nj
         ZU2N52g6h+K+2DNH87DKC1xjjDFR6dwKLNUpd7fToa3kLe5QXaHh6cLVFUlvtCHP2G
         6Ibvzp26Bf0dVM2EmVQp17a37OsjhDqs3DgYzB+uukmz0WCNUPrwApi6yzcuiL56DY
         hI9TJ66jbC5osRJZ4dhbzVXT9lHxS8yu02twlQaJkJK/bOhGf1yOFYkcLiwYZrqENG
         2J4GC7jyivEag==
Date:   Mon, 4 Apr 2022 10:05:19 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     bugzilla-daemon@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?0JrQvtGA0LXQvdCx0LXRgNCzINCc0LDRgNC6?= 
        <socketpair@gmail.com>, Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Serge Hallyn <serge@hallyn.com>
Subject: Re: vfork(2) fails after unshare(CLONE_NEWTIME) (was: [Bug 215769]
 man 2 vfork() does not document corner case when PID == 1)
Message-ID: <20220404080519.pi6izyuop3mmdg2g@wittgenstein>
References: <bug-215769-216477@https.bugzilla.kernel.org/>
 <bug-215769-216477-to2O9X1Knw@https.bugzilla.kernel.org/>
 <4fb02f5f-60f9-42af-ddd5-fe5af877231f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fb02f5f-60f9-42af-ddd5-fe5af877231f@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 11:15:52PM +0200, Alejandro Colomar (man-pages) wrote:
> [Added some kernel CCs that may know what's going on]
> 
> Hi,
> 
> On 3/31/22 09:53, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=215769
> > 
> > --- Comment #3 from Коренберг Марк (socketpair@gmail.com) ---
> > Hi,
> > I appreciate depth of information validation. Actually, you are right. vfork()
> > DOES work with pid=1 processes. I figured out the cause in my case. In order to
> > reproduce -- add unshare(CLONE_NEWTIME) just before vfork(). Now, I don't know
> > if it's a bug in vfork() or in fork(). Yes, both are clone() actually.
> > 
> > In any case, they should either both give EINVAL or both don't fail. But it's
> > definitely bug in the kernel around CLONE_NEWTIME.
> > 
> 
> On 3/31/22 10:12, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=215769
> >
> > --- Comment #4 from Коренберг Марк (socketpair@gmail.com) ---
> > #define _GNU_SOURCE 1
> > #include <stdio.h>
> > #include <sched.h>
> > #include <stdlib.h>
> > #include <unistd.h>
> > #include <sys/types.h>
> > #include <sys/wait.h>
> > #include <err.h>
> >
> > #ifndef CLONE_NEWTIME
> > #define CLONE_NEWTIME   0x00000080
> > #endif
> >
> > int main (void)
> > {
> >   if (unshare (CLONE_NEWTIME))  err (EXIT_FAILURE, "UNSHARE_NEWTIME");
> >
> >   pid_t pid;
> >   switch (pid=vfork ())
> >   {
> >   case 0:
> >     _exit(0);
> >   case -1:
> >     err(EXIT_FAILURE, "vfork BUG");
> >   default:
> >     waitpid(pid, NULL, 0);
> >   }
> >   return 0;
> > }
> >
> 
> I could reproduce it with the following code.  I tried
> syscall(SYS_vfork) to make sure it's not a problem in the libc wrapper,
> and to make sure I do call vfork(2).  If I replace vfork(2) with
> fork(2), I don't get the error.
> 
> 
> $ cat vfork.c
> #define _GNU_SOURCE
> #include <err.h>
> #include <linux/sched.h>
> #include <sched.h>
> #include <signal.h>
> #include <stdlib.h>
> #include <sys/syscall.h>
> #include <unistd.h>
> 
> int main(void)
> {
> 	pid_t pid;
> 
> 	if (unshare(CLONE_NEWTIME) == -1)
> 		err(EXIT_FAILURE, "unshare(2)");
> 	if (signal(SIGCHLD, SIG_IGN) == SIG_ERR)
> 		err(EXIT_FAILURE, "sigaction(2)");
> 	pid = syscall(SYS_vfork);
> 	switch (pid) {
> 	case 0:
> 		errx(EXIT_SUCCESS, "Grandchild exiting normally.");
> 	case -1:
> 		/* If we got here, the report is confirmed. */
> 		err(EXIT_FAILURE, "vfork(2)");
> 	default:
> 		errx(EXIT_SUCCESS, "Child exiting normally.");
> 	}
> }
> 
> $ cc -Wall -Wextra -Werror vfork.c
> $ sudo ./a.out
> a.out: vfork(2): Invalid argument
> 
> 
> 
> $ grep_syscall_def vfork
> kernel/fork.c:2711:
> SYSCALL_DEFINE0(vfork)
> {
> 	struct kernel_clone_args args = {
> 		.flags		= CLONE_VFORK | CLONE_VM,
> 		.exit_signal	= SIGCHLD,
> 	};
> 
> 	return kernel_clone(&args);
> }
> 
> 
> Maybe someone in the kernel can send some patch for the clone(2) and/or
> vfork(2) manual pages that explains the reason (if it's intended).

Hey Alejandro,

I won't be able to send a patch very soon but I can at least explain why
you see EINVAL. :)

This is intended. 

vfork() suspends the parent process and the child process will share the
same vm as the parent process. If the child process is in a new time
namespace different from its parent process it is not allowed to be in
the same threadgroup or share virtual memory with the parent process.
That's why you see EINVAL.

Note, the unshare(CLONE_NEWTIME) call will _not_ cause the calling
process to be moved into a different time namespace. Only the newly
created child process will be after a subsequent
fork()/vfork()/clone()/clone3()...

The semantics are equivalent to that of CLONE_NEWPID in this regard. You
can see this via /proc/<pid>/ns/ where you see two entries for pid
namespaces and also two entries for time namespaces:

* CLONE_NEWTIME
  * /proc/<pid>/ns/time			// current time namespace
  * /proc/<pid>/ns/time_for_children	// time namespace for the new child process

If during fork:

parent_process->time != parent_process->time_for_children

and either CLONE_VM or CLONE_THREAD is set you see EINVAL.

You can thus replicate the same error via:

unshare(CLONE_NEWTIME)

and a

clone() or clone3() call with CLONE_VM or CLONE_THREAD.

Christian
