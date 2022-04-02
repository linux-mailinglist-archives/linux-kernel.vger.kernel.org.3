Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9144F0662
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 23:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbiDBVRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 17:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbiDBVRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 17:17:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94861CB24
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 14:15:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m30so8968937wrb.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 14:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=PRT8NrovPsISh5Psd6i6W0q2XevnObDjaAcnqujaODE=;
        b=XAeOYVHWOlUB7qIKxjWjAuZXvYTZbcJcqT2j/X8qYMY6BcixoSxSWa4GKdRdSEnK5b
         L7ePvvCclWVLc/LayzbzCI1vUo1rp3whwWUkUa1aOtJVAzIyHXvM18NW2/W4iYTsb0Nv
         fEfRlIIEoteXfRdRpeOGdDJy79sm+CqRBMb4v1QP4s0GmAsfG6jt4onPGSVW3Fh37+o4
         UqFgLOMeFky4upkJ+cBZRjg1L9wHzkDujeZAmWC7OBsx1fUPWA5cgCwfDs4z8C11cCJh
         hvvxMMt7eVQvkeROBhSUnGy/no92p/HmK/Lo3YWqE3V4zVNcbxsdvH/9ybXE/fRaxsl5
         icYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=PRT8NrovPsISh5Psd6i6W0q2XevnObDjaAcnqujaODE=;
        b=pM+QoVHC3K4tcMqwfqA0/vRK1i3iP8zJZWzM+mZMJLMrQFkwnTTUUrM0U/M00iTVJL
         GQCrTaHfppQg5RdISj8u5/NNsI6Gwb+tj6jv/zG1eUlsman5noQoys91H8eSJRCnq74u
         5+hth24+vw6CV08/VBb/b2g721OtZ/5rDINnuXNR8+7NTm7eMo/pXea5XNiEG2jgbtoq
         vKu/j4DtFn8DQN3gsT3q5EqrSdF0earKr8DUMGaoj9GpTb2W+l2J4Gm7HkM62tplRpRs
         8CT0Nfrq2Y37hKCDMrcmWwmsMOgbnkvP5nQFAz/Sg5yGcQHmVV1CKq598xfpCPXwpSTF
         5RKA==
X-Gm-Message-State: AOAM533P4eRXjArngbchy5jR5yWM9oR5KcXlZwyUoZtiR+cOA8YtKF1b
        wd9+vArnuERtOK4yVLmpukw=
X-Google-Smtp-Source: ABdhPJwWlcEjr8rpBe7FQKRJtsrRdQInIy4ePZdtG2FoMNXjMjRdRthVRBorVkqeRzMK1sIcCG6/vw==
X-Received: by 2002:a05:6000:18a2:b0:203:d2f5:28a0 with SMTP id b2-20020a05600018a200b00203d2f528a0mr12370963wri.355.1648934154224;
        Sat, 02 Apr 2022 14:15:54 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d53c2000000b0020604b2667asm3446507wrw.81.2022.04.02.14.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 14:15:53 -0700 (PDT)
Message-ID: <4fb02f5f-60f9-42af-ddd5-fe5af877231f@gmail.com>
Date:   Sat, 2 Apr 2022 23:15:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: vfork(2) fails after unshare(CLONE_NEWTIME) (was: [Bug 215769] man 2
 vfork() does not document corner case when PID == 1)
Content-Language: en-US
To:     bugzilla-daemon@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?0JrQvtGA0LXQvdCx0LXRgNCzINCc0LDRgNC6?= 
        <socketpair@gmail.com>, Christian Brauner <brauner@kernel.org>
References: <bug-215769-216477@https.bugzilla.kernel.org/>
 <bug-215769-216477-to2O9X1Knw@https.bugzilla.kernel.org/>
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Serge Hallyn <serge@hallyn.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <bug-215769-216477-to2O9X1Knw@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Added some kernel CCs that may know what's going on]

Hi,

On 3/31/22 09:53, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=215769
> 
> --- Comment #3 from Коренберг Марк (socketpair@gmail.com) ---
> Hi,
> I appreciate depth of information validation. Actually, you are right. vfork()
> DOES work with pid=1 processes. I figured out the cause in my case. In order to
> reproduce -- add unshare(CLONE_NEWTIME) just before vfork(). Now, I don't know
> if it's a bug in vfork() or in fork(). Yes, both are clone() actually.
> 
> In any case, they should either both give EINVAL or both don't fail. But it's
> definitely bug in the kernel around CLONE_NEWTIME.
> 

On 3/31/22 10:12, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=215769
>
> --- Comment #4 from Коренберг Марк (socketpair@gmail.com) ---
> #define _GNU_SOURCE 1
> #include <stdio.h>
> #include <sched.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <err.h>
>
> #ifndef CLONE_NEWTIME
> #define CLONE_NEWTIME   0x00000080
> #endif
>
> int main (void)
> {
>   if (unshare (CLONE_NEWTIME))  err (EXIT_FAILURE, "UNSHARE_NEWTIME");
>
>   pid_t pid;
>   switch (pid=vfork ())
>   {
>   case 0:
>     _exit(0);
>   case -1:
>     err(EXIT_FAILURE, "vfork BUG");
>   default:
>     waitpid(pid, NULL, 0);
>   }
>   return 0;
> }
>

I could reproduce it with the following code.  I tried
syscall(SYS_vfork) to make sure it's not a problem in the libc wrapper,
and to make sure I do call vfork(2).  If I replace vfork(2) with
fork(2), I don't get the error.


$ cat vfork.c
#define _GNU_SOURCE
#include <err.h>
#include <linux/sched.h>
#include <sched.h>
#include <signal.h>
#include <stdlib.h>
#include <sys/syscall.h>
#include <unistd.h>

int main(void)
{
	pid_t pid;

	if (unshare(CLONE_NEWTIME) == -1)
		err(EXIT_FAILURE, "unshare(2)");
	if (signal(SIGCHLD, SIG_IGN) == SIG_ERR)
		err(EXIT_FAILURE, "sigaction(2)");
	pid = syscall(SYS_vfork);
	switch (pid) {
	case 0:
		errx(EXIT_SUCCESS, "Grandchild exiting normally.");
	case -1:
		/* If we got here, the report is confirmed. */
		err(EXIT_FAILURE, "vfork(2)");
	default:
		errx(EXIT_SUCCESS, "Child exiting normally.");
	}
}

$ cc -Wall -Wextra -Werror vfork.c
$ sudo ./a.out
a.out: vfork(2): Invalid argument



$ grep_syscall_def vfork
kernel/fork.c:2711:
SYSCALL_DEFINE0(vfork)
{
	struct kernel_clone_args args = {
		.flags		= CLONE_VFORK | CLONE_VM,
		.exit_signal	= SIGCHLD,
	};

	return kernel_clone(&args);
}


Maybe someone in the kernel can send some patch for the clone(2) and/or
vfork(2) manual pages that explains the reason (if it's intended).


Thanks,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
