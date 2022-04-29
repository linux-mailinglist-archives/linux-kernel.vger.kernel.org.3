Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7605158A3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377907AbiD2Wqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiD2Wqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:46:38 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702A7DC9A4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:43:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y14so8029514pfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+OtZcub1RhFmibAlx0L9IR2e0KQSLJB6GLsOG4WarlA=;
        b=Uh8VucIvyx7fYouDKn0NIeZi4Jd4jiRIuUr9bGcgaIn2h9rqghkqXHE/eAvcONH0ox
         nD6H5cFq6x3oeWmtztkTDYdDiKtAoTfOUkVP6Nw6Vnjpe4w/Wa6NS/kSkfawO8rXWZnP
         qGUflBSDTvC6WNZSvjsYgDbZmv7yE7Gqx3MA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+OtZcub1RhFmibAlx0L9IR2e0KQSLJB6GLsOG4WarlA=;
        b=pUV9EPVQKnelCZBTiolJUYojfNe2TLokHIDFg/A2gMCxcEiUKzMqpNssP8PytN4AIo
         cIABk/59/X2WZBaRXI76WfrgP6p5B+R74nqCKMxhJf+Xb0+adjNj2vDGaiQ1xDGRDeBi
         +ZqEvO7JcJdEHSm1NoBDeKyO+SpDv/YoFMsg5oze3v8aVp5J2NfrglGWVLXHCeJ3w/bG
         f0P4y8g5vmnQFZGIocd1Q3B9myXAwp74gjSPFjpC8LHtIhubRS7gzTNCRcBqlIlSVOpL
         K1BCl0xc98Wc6gL1BlgcX5amJkAIdNI1npHPPNk90m9rArQmJIC6+xhT3XsvEqZh8wej
         riiw==
X-Gm-Message-State: AOAM531ZPOZArODvCMcd81BLoTKbNm0P3FBKuWQOnDE9tAya9DrIfkkK
        WOz7BsaD3HutCvvXoO7ibr7MoQ==
X-Google-Smtp-Source: ABdhPJw9E1JT53+jWSaSkIedGe+aUYLpkAcQAdaWHGIYm7RXbAaA7uKIjm2HVH09AwRNc9PeQFoybg==
X-Received: by 2002:a63:1c2:0:b0:3aa:be7c:cfd9 with SMTP id 185-20020a6301c2000000b003aabe7ccfd9mr1097040pgb.521.1651272198924;
        Fri, 29 Apr 2022 15:43:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e16-20020a62aa10000000b0050dc7628151sm193479pff.43.2022.04.29.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:43:18 -0700 (PDT)
Date:   Fri, 29 Apr 2022 15:43:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH v3 2/2] selftests/seccomp: Add test for wait killable
 notifier
Message-ID: <202204291541.4438B18A@keescook>
References: <20220429023113.74993-1-sargun@sargun.me>
 <20220429023113.74993-3-sargun@sargun.me>
 <202204291053.E04A367@keescook>
 <20220429223557.GB1267404@ircssh-3.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429223557.GB1267404@ircssh-3.c.rugged-nimbus-611.internal>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:35:57PM +0000, Sargun Dhillon wrote:
> On Fri, Apr 29, 2022 at 11:19:33AM -0700, Kees Cook wrote:
> > On Thu, Apr 28, 2022 at 07:31:13PM -0700, Sargun Dhillon wrote:
> > > +
> > > +	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
> > > +
> > > +	listener = user_notif_syscall(__NR_getppid,
> > > +				      SECCOMP_FILTER_FLAG_NEW_LISTENER |
> > > +				      SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV);
> > > +	ASSERT_GE(listener, 0);
> > > +
> > > +	pid = fork();
> > > +	ASSERT_GE(pid, 0);
> > > +
> > > +	if (pid == 0) {
> > > +		close(sk_pair[0]);
> > > +		handled = sk_pair[1];
> > > +
> > > +		/* Setup the sigaction without SA_RESTART */
> > > +		if (sigaction(SIGUSR1, &new_action, NULL)) {
> > > +			perror("sigaction");
> > > +			exit(1);
> > > +		}
> > > +
> > > +		/* Make sure that the syscall is completed (no EINTR) */
> > > +		ret = syscall(__NR_getppid);
> > > +		exit(ret != USER_NOTIF_MAGIC);
> > > +	}
> > > +
> > > +	while (get_proc_syscall(pid) != __NR_getppid &&
> > > +	       get_proc_stat(pid) != 'S')
> > > +		nanosleep(&delay, NULL);
> > > +
> > > +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
> > > +	/* Kill the process to make sure it enters the wait_killable state */
> > > +	EXPECT_EQ(kill(pid, SIGUSR1), 0);
> > > +
> > > +	/* TASK_KILLABLE is considered D (Disk Sleep) state */
> > > +	while (get_proc_stat(pid) != 'D')
> > > +		nanosleep(&delay, NULL);
> > 
> > Should a NOWAIT waitpid() happen in this loop to make sure this doesn't
> > spin forever?
> > 
> > i.e. running these tests on a kernel that doesn't have the support
> > shouldn't hang -- yes it'll time out eventually but that's annoying. ;)
> > 
> Wouldn't this bail already because user_notif_syscall would assert out
> since the kernel would reject the unknown flag?

Oh yeah, duh. :P

> I might make this a little helper function, something like:
> static void wait_for_state(struct __test_metadata *_metadata, pid_t pid, char wait_for) {
> 	/* 100 ms */
> 	struct timespec delay = { .tv_nsec = 100000000 };
> 	int status;
> 
> 	while (get_proc_stat(pid) != wait_for) {
> 		ASSERT_EQ(waitpid(pid, &status, WNOHANG), 0) {
> 			if (WIFEXITED(status))
> 				TH_LOG("Process %d exited with error code %d", pid, WEXITSTATUS(status));
> 			else if (WIFSIGNALED(status))
> 				TH_LOG("Process %d exited due to signal %d", pid, WTERMSIG(status));
> 			else
> 				TH_LOG("Process %d exited due to unknown reason", pid);
> 		}
> 		nanosleep(&delay, NULL);
> 	}
> }

Yeah, though as you point out, that is likely overkill. :)

> > > +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
> > > +	/* Kill the process with a fatal signal */
> > > +	EXPECT_EQ(kill(pid, SIGTERM), 0);
> > > +
> > > +	EXPECT_EQ(waitpid(pid, &status, 0), pid);
> > > +	EXPECT_EQ(true, WIFSIGNALED(status));
> > > +	EXPECT_EQ(SIGTERM, WTERMSIG(status));
> > > +}
> > 
> > Should there be a test validating the inverse of this, as in _without_
> > SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV, how should the above tests
> > behave?
> Don't we roughly get that from the user_notification_kill_in_middle
> and user_notification_signal?

Yeah, I guess that's true. Cool, cool.

> Although, I might cleanup the user_notification_signal test to disable
> SA_RESTART like these tests.

Sounds good, though maybe that can be a separate patch?

-- 
Kees Cook
