Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1374F5CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiDFLtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiDFLsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:48:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7C45A3614
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CC5EB82045
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81E9C385A3;
        Wed,  6 Apr 2022 08:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649234779;
        bh=IH8OYu4RWwPzUN5lmMvBD7N2P54Lx3me2JUlUkLn9LM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJr5w2czrnDeR0F1W4T2vcj4wF6YR1cuSFucMpxCKLP4qMzhCzstMaiiriF6a6lFu
         6ZFz4bI6sM8ZC7yl0eu6pgm0Uajg6SZqRiKFtGrcrMBXdLjIhj9e8TgsT0IcOP2AZa
         v4QVZXU3DUJ+QyNT9k85Qke7nErpfc7WIDb3TZUznQwAriOzdFZ9gS20M7fRge2yoX
         gl25KentWPBNtzGxsTdMpYRxTsy7g5l8Sxy7c6V8iR/x8/KYARtfEBlv/2wQh2sSDV
         LDgrxXN6UW2wriAi4gtqtZTfctWbD3q0kKOOtywS09rEAtt3ex5WJ4w4bpGh/Mnz3Y
         ktex3HW6qMS9w==
Date:   Wed, 6 Apr 2022 10:46:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?0JrQvtGA0LXQvdCx0LXRgNCzINCc0LDRgNC6?= 
        <socketpair@gmail.com>, Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Serge Hallyn <serge@hallyn.com>,
        bugzilla-daemon@kernel.org
Subject: Re: vfork(2) behavior not consistent with fork(2) (was: vfork(2)
 fails after unshare(CLONE_NEWTIME) (was: [Bug 215769] man 2 vfork() does not
 document corner case when PID == 1))
Message-ID: <20220406084613.3srklyt27qxcmrcx@wittgenstein>
References: <bug-215769-216477@https.bugzilla.kernel.org/>
 <bug-215769-216477-to2O9X1Knw@https.bugzilla.kernel.org/>
 <4fb02f5f-60f9-42af-ddd5-fe5af877231f@gmail.com>
 <20220404080519.pi6izyuop3mmdg2g@wittgenstein>
 <ae2cbf67-aace-bc40-418e-7b41873f814a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae2cbf67-aace-bc40-418e-7b41873f814a@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 09:28:12PM +0200, Alejandro Colomar wrote:
> Hey, Christian!
> 
> On 4/4/22 10:05, Christian Brauner wrote:
> > On Sat, Apr 02, 2022 at 11:15:52PM +0200, Alejandro Colomar (man-pages) wrote:
> > > [Added some kernel CCs that may know what's going on]
> [...]
> > > Maybe someone in the kernel can send some patch for the clone(2) and/or
> > > vfork(2) manual pages that explains the reason (if it's intended).
> > 
> > Hey Alejandro,
> > 
> > I won't be able to send a patch very soon but I can at least explain why
> > you see EINVAL. :)
> 
> Don't hurry, we're not planning to release any soon :)
> 
> > 
> > This is intended.
> > 
> > vfork() suspends the parent process and the child process will share the
> > same vm as the parent process. If the child process is in a new time
> > namespace different from its parent process it is not allowed to be in
> > the same threadgroup or share virtual memory with the parent process.
> > That's why you see EINVAL.
> 
> That makes a lot of sense to me.
> 
> > 
> > Note, the unshare(CLONE_NEWTIME) call will _not_ cause the calling
> > process to be moved into a different time namespace. Only the newly
> > created child process will be after a subsequent
> > fork()/vfork()/clone()/clone3()...
> > 
> > The semantics are equivalent to that of CLONE_NEWPID in this regard. You
> > can see this via /proc/<pid>/ns/ where you see two entries for pid
> > namespaces and also two entries for time namespaces:
> > 
> > * CLONE_NEWTIME
> >    * /proc/<pid>/ns/time			// current time namespace
> >    * /proc/<pid>/ns/time_for_children	// time namespace for the new child process
> 
> Also makes sense.  Michael taught me that a few weeks ago :)
> 
> This also triggers some doubt:  will the same problem happen with
> CLONE_NEWPID since it also moves the child into a new ns (in this case a PID
> one)?  See test program below.

No, it won't. A pid namespace places no relevant constraints on vm usage
whereas a time namespace does.
If a task joins a new time namespace it'll clean the VVAR page tables
and refault them with the new layout after the timens change. That
affects all tasks which use the same task->mm.

Since CLONE_THREAD implies CLONE_VM this would affect the whole
thread-group behind their back. All threads would suddenly change
timens.

No such issues exist for pid namespaces; they don't need to alter
task->mm.

> 
> > 
> > If during fork:
> > 
> > parent_process->time != parent_process->time_for_children
> > 
> > and either CLONE_VM or CLONE_THREAD is set you see EINVAL.
> > 
> > You can thus replicate the same error via:
> > 
> > unshare(CLONE_NEWTIME)
> > 
> > and a
> > 
> > clone() or clone3() call with CLONE_VM or CLONE_THREAD.
> 
> So, to test my doubts, I wrote this similar program (and also similar
> programs where only the CLONE_NEW* flag was changed, one with CLONE_NEWTIME,
> and one with CLONE_NEWNS)):
> 
> $ cat vfork_newpid.c
> #define _GNU_SOURCE
> #include <err.h>
> #include <errno.h>
> #include <linux/sched.h>
> #include <sched.h>
> #include <signal.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/syscall.h>
> #include <unistd.h>
> 
> static char *const child_argv[] = {
> 	"print_pid",
> 	NULL
> };
> 
> static char *const child_envp[] = {
> 	NULL
> };
> 
> int
> main(void)
> {
> 	pid_t pid;
> 
> 	printf("%s: PID: %ld\n", program_invocation_short_name, (long) getpid());
> 
> 	if (unshare(CLONE_NEWPID) == -1)
> 		err(EXIT_FAILURE, "unshare(2)");
> 	if (signal(SIGCHLD, SIG_IGN) == SIG_ERR)
> 		err(EXIT_FAILURE, "signal(2)");
> 
> 	pid = syscall(SYS_vfork);
> 	//pid = vfork();  // This behaves differently.
> 	switch (pid) {
> 	case 0:
> 		execve("/home/alx/tmp/print_pid", child_argv, child_envp);
> 		err(EXIT_SUCCESS, "PID %jd exiting after execve(2)",
> 		    (long) getpid());
> 	case -1:
> 		err(EXIT_FAILURE, "vfork(2)");
> 	default:
> 		errx(EXIT_SUCCESS, "Parent exiting after vfork(2).");
> 	}
> }
> 
> $ cat print_pid.c
> #include <err.h>
> #include <stdlib.h>
> #include <unistd.h>
> 
> int
> main(void)
> {
> 	errx(EXIT_SUCCESS, "PID %jd exiting.", (long) getpid());
> }
> 
> $ cc -Wall -Wextra -Werror -o print_pid print_pid.c
> $ cc -Wall -Wextra -Werror -o vfork_newpid vfork_newpid.c
> $
> $
> $ sudo ./vfork_newpid
> vfork_newpid: PID: 8479
> vfork_newpid: PID 8479 exiting after execve(2): Success
> print_pid: PID 1 exiting.
> $
> $
> $ sudo ./vfork_newtime
> vfork_newtime: PID: 8484
> vfork_newtime: vfork(2): Invalid argument
> $
> $
> $ sudo ./vfork_newns
> vfork_newns: PID: 8486
> vfork_newns: PID 8486 exiting after execve(2): Success
> print_pid: PID 8487 exiting.
> 
> 
> The first thing I noted is that usage of vfork(2) differs considerably from
> fork(2), and that's something that's not clear by reading the manual page.
> It sais that the parent process is suspended until the child calls
> execve(2), but I expected it to mean that vfork(2) doesn't return to the
> parent until that happened, but was otherwise transparent.  I was wrong and
> my tests showed me that.
> 
> I was going to propose an example program for the manual page, when I
> decided to try a slightly different thing: call vfork() instead of
> syscall(SYS_vfork);  that changed the behavior to the same one as with
> fork(2) (i.e., the parent resumes after vfork(2) returns the PID of the
> child.
> 
> Is that also intended?  I couldn't find the glibc wrapper source code, so I
> don't know what is glibc doing here, but I straced the processes, and
> they're all calling vfork(), so the behavior should be consistent; it's
> quite weird.  I'm very confused at this point.

glibc does vfork() via inline assembly massaging. There's probably
atfork handlers and a bunch of other stuff involved so it's difficult to
do a remote diagnosis.
(And note that calling anything other than execve() or _exit() after
vfork() is basically undefined behavior.)

> 
> 
> I'm also wondering why it's okay to have processes in different PID ns share
> the same vm, but I guess that's implementation details that I don't need to
> care that much.

See earlier in the thread.
