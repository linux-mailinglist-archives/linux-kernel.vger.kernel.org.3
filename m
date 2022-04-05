Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8AC4F4931
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391294AbiDEWFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573644AbiDET3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:29:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1877BE9FD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:27:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m30so46642wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cdfNSB6YwdBXtAmOKuoC0/E9rKkP4kgD9S848WBSXfk=;
        b=TY9NnIjO74oo7WlNQT9PsMoPMF5h6+xPLyA5QO8u/SDXFqziaZNnfUKRiqoeA8Og/Y
         c0hJc+DN6HLWln+Z3pTzPn1INJbxqR4wtsIzBusThLzzz4PDcDvp/rKzDgD3rgTug077
         vvijomlCeAKBAFYVnsTbYxNVL8kc7xE7fcCd83hxWjt91i4Lcdk7PNu2SVXbA5IRCkTL
         uCtrabBwbsZ4aPZKxmy/EPzvFQSd35CHbgUcVQ7xr4p7zJHqux5W57aNopjFe3lMGcZ9
         aGQ8boDfBdBSGhs1VZhmLJet1o0YgdmZQxDjy/bnXfCJWBLf7WN/bsgX5K4TYfbE/+JD
         yf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cdfNSB6YwdBXtAmOKuoC0/E9rKkP4kgD9S848WBSXfk=;
        b=RHXvltthTFY+Mo7TUDfi14uWKukMTicf6ikruIVHsSEbT0x4keTx+0YcoF/Z9kGsF4
         yu+JiO8stZREV3wwewfo7ibReHYJMtAfYZ1YELaQlsqe2iR0lhUDvEBdT7gPs3DKO9UM
         3jbGiDTH9VQqkGJ/xo0cXdPar87SpGI0l9CwlviTVYxRRicvqtrU82WKI8CUxoS76jsB
         aDjIJFpnIPBPtYK3lSEzL6kwJNITYxFxSi9sabn1pWbBfCK+7wtYnyMIxj6258lpsrNS
         CU7b59dcT7kj/9FR1ehsgeo6raD37kHaK47r9KewFcb4jh0Iz8QuzdYFIG9kRb6/tIyx
         31Kw==
X-Gm-Message-State: AOAM5337SpzlWDLPLm7VyJqVe1051dfYHerg/lz3Cvek67JXmkZ5FLLa
        BpbpGMjZstAU4tDNMDnZFC0=
X-Google-Smtp-Source: ABdhPJwSpYrybt/LKrk+e+G2/yVBvSQ/dfsd/p4YAUxA/fL6DDsFBICWmp82dWhBXFhqIna0r19rzg==
X-Received: by 2002:adf:910d:0:b0:1e3:9484:1601 with SMTP id j13-20020adf910d000000b001e394841601mr3619875wrj.419.1649186833125;
        Tue, 05 Apr 2022 12:27:13 -0700 (PDT)
Received: from [192.168.0.149] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id d14-20020a056000186e00b0020405198faasm14555866wri.52.2022.04.05.12.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 12:27:12 -0700 (PDT)
Message-ID: <ae2cbf67-aace-bc40-418e-7b41873f814a@gmail.com>
Date:   Tue, 5 Apr 2022 21:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: vfork(2) behavior not consistent with fork(2) (was: vfork(2) fails
 after unshare(CLONE_NEWTIME) (was: [Bug 215769] man 2 vfork() does not
 document corner case when PID == 1))
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?0JrQvtGA0LXQvdCx0LXRgNCzINCc0LDRgNC6?= 
        <socketpair@gmail.com>, Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Serge Hallyn <serge@hallyn.com>,
        bugzilla-daemon@kernel.org
References: <bug-215769-216477@https.bugzilla.kernel.org/>
 <bug-215769-216477-to2O9X1Knw@https.bugzilla.kernel.org/>
 <4fb02f5f-60f9-42af-ddd5-fe5af877231f@gmail.com>
 <20220404080519.pi6izyuop3mmdg2g@wittgenstein>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220404080519.pi6izyuop3mmdg2g@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, Christian!

On 4/4/22 10:05, Christian Brauner wrote:
> On Sat, Apr 02, 2022 at 11:15:52PM +0200, Alejandro Colomar (man-pages) wrote:
>> [Added some kernel CCs that may know what's going on]
[...]
>> Maybe someone in the kernel can send some patch for the clone(2) and/or
>> vfork(2) manual pages that explains the reason (if it's intended).
> 
> Hey Alejandro,
> 
> I won't be able to send a patch very soon but I can at least explain why
> you see EINVAL. :)

Don't hurry, we're not planning to release any soon :)

> 
> This is intended.
> 
> vfork() suspends the parent process and the child process will share the
> same vm as the parent process. If the child process is in a new time
> namespace different from its parent process it is not allowed to be in
> the same threadgroup or share virtual memory with the parent process.
> That's why you see EINVAL.

That makes a lot of sense to me.

> 
> Note, the unshare(CLONE_NEWTIME) call will _not_ cause the calling
> process to be moved into a different time namespace. Only the newly
> created child process will be after a subsequent
> fork()/vfork()/clone()/clone3()...
> 
> The semantics are equivalent to that of CLONE_NEWPID in this regard. You
> can see this via /proc/<pid>/ns/ where you see two entries for pid
> namespaces and also two entries for time namespaces:
> 
> * CLONE_NEWTIME
>    * /proc/<pid>/ns/time			// current time namespace
>    * /proc/<pid>/ns/time_for_children	// time namespace for the new child process

Also makes sense.  Michael taught me that a few weeks ago :)

This also triggers some doubt:  will the same problem happen with 
CLONE_NEWPID since it also moves the child into a new ns (in this case a 
PID one)?  See test program below.

> 
> If during fork:
> 
> parent_process->time != parent_process->time_for_children
> 
> and either CLONE_VM or CLONE_THREAD is set you see EINVAL.
> 
> You can thus replicate the same error via:
> 
> unshare(CLONE_NEWTIME)
> 
> and a
> 
> clone() or clone3() call with CLONE_VM or CLONE_THREAD.

So, to test my doubts, I wrote this similar program (and also similar 
programs where only the CLONE_NEW* flag was changed, one with 
CLONE_NEWTIME, and one with CLONE_NEWNS)):

$ cat vfork_newpid.c
#define _GNU_SOURCE
#include <err.h>
#include <errno.h>
#include <linux/sched.h>
#include <sched.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/syscall.h>
#include <unistd.h>

static char *const child_argv[] = {
	"print_pid",
	NULL
};

static char *const child_envp[] = {
	NULL
};

int
main(void)
{
	pid_t pid;

	printf("%s: PID: %ld\n", program_invocation_short_name, (long) getpid());

	if (unshare(CLONE_NEWPID) == -1)
		err(EXIT_FAILURE, "unshare(2)");
	if (signal(SIGCHLD, SIG_IGN) == SIG_ERR)
		err(EXIT_FAILURE, "signal(2)");

	pid = syscall(SYS_vfork);
	//pid = vfork();  // This behaves differently.
	switch (pid) {
	case 0:
		execve("/home/alx/tmp/print_pid", child_argv, child_envp);
		err(EXIT_SUCCESS, "PID %jd exiting after execve(2)",
		    (long) getpid());
	case -1:
		err(EXIT_FAILURE, "vfork(2)");
	default:
		errx(EXIT_SUCCESS, "Parent exiting after vfork(2).");
	}
}

$ cat print_pid.c
#include <err.h>
#include <stdlib.h>
#include <unistd.h>

int
main(void)
{
	errx(EXIT_SUCCESS, "PID %jd exiting.", (long) getpid());
}

$ cc -Wall -Wextra -Werror -o print_pid print_pid.c
$ cc -Wall -Wextra -Werror -o vfork_newpid vfork_newpid.c
$
$
$ sudo ./vfork_newpid
vfork_newpid: PID: 8479
vfork_newpid: PID 8479 exiting after execve(2): Success
print_pid: PID 1 exiting.
$
$
$ sudo ./vfork_newtime
vfork_newtime: PID: 8484
vfork_newtime: vfork(2): Invalid argument
$
$
$ sudo ./vfork_newns
vfork_newns: PID: 8486
vfork_newns: PID 8486 exiting after execve(2): Success
print_pid: PID 8487 exiting.


The first thing I noted is that usage of vfork(2) differs considerably 
from fork(2), and that's something that's not clear by reading the 
manual page.  It sais that the parent process is suspended until the 
child calls execve(2), but I expected it to mean that vfork(2) doesn't 
return to the parent until that happened, but was otherwise transparent. 
  I was wrong and my tests showed me that.

I was going to propose an example program for the manual page, when I 
decided to try a slightly different thing: call vfork() instead of 
syscall(SYS_vfork);  that changed the behavior to the same one as with 
fork(2) (i.e., the parent resumes after vfork(2) returns the PID of the 
child.

Is that also intended?  I couldn't find the glibc wrapper source code, 
so I don't know what is glibc doing here, but I straced the processes, 
and they're all calling vfork(), so the behavior should be consistent; 
it's quite weird.  I'm very confused at this point.


I'm also wondering why it's okay to have processes in different PID ns 
share the same vm, but I guess that's implementation details that I 
don't need to care that much.


Thanks for the details!

Cheers,

Alex
