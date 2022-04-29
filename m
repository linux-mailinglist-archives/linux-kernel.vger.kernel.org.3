Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFC8515880
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244398AbiD2Wj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381527AbiD2WjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:39:21 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19FF9E9FA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:36:00 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f2so10935058ioh.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EDOuoYXHoGxnieFk2fEYP66QuIIs/XWtzyfs+ZhcFc4=;
        b=CvSq3TWRkP3Z6I0+KB0q45I2oKvcw/b8urISPbGr6JOGYOg7a3um3HHgB3pSxSnkeE
         48PZUOTUOAn/9euGdTcuH6F2HsVqdcNZ0ZHOIMfdQxXCfExTyafmXHnbIExGubddRgKO
         YpcG6fWGsv0z7PjmVUU1nAw6znrPs6lZj0XtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EDOuoYXHoGxnieFk2fEYP66QuIIs/XWtzyfs+ZhcFc4=;
        b=kDfXOKrxFbP6HMEDPJ0QpJoABD6vQ0ZYKGjIFF49b47S40EQLIKqq7qKh9AgLK8mmo
         Gw0ieqsugGnwxkl9u0U73ylaHI1eDNbwUi90pHE46Dfk8JB1XwovFwyaBNK11iD0MRLM
         2OzQFzmD6TrBBLwAnQ4duYTXlmEsPuPaqZD5Alnd8uY5AivYwmZEX2nsxn1n0dKSm00K
         9V8xQI6wVb9dofncmMZb513Ot70eSXZTVM5bBUQcd1UlAYGL7H30rNFxgTRbyGyX1/sX
         pji3ZgpGljMMjnAuUkkxI4qUUdEI27LNBq2PneUnaBuIZp/9j3cr9vdKjNvLsxvGfqto
         YDYw==
X-Gm-Message-State: AOAM533PyW2S2UWZP3F6x47J8/TO7cUiJWc30Z2vRDHEN4Vz7IsrIxSz
        f7OonTvY5DT1GbP7R+VZO0veSg==
X-Google-Smtp-Source: ABdhPJy5GyIF1Eh2kLWivr69QRYveuZFPcWiQsBaGZzUR83emo25OkEeL6dOiy2VdORxmlgc8jlA+Q==
X-Received: by 2002:a05:6638:3795:b0:32a:f753:fd92 with SMTP id w21-20020a056638379500b0032af753fd92mr606719jal.102.1651271759591;
        Fri, 29 Apr 2022 15:35:59 -0700 (PDT)
Received: from ircssh-3.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id 5-20020a921805000000b002cde6e35306sm826030ily.80.2022.04.29.15.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:35:58 -0700 (PDT)
Date:   Fri, 29 Apr 2022 22:35:57 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>
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
Message-ID: <20220429223557.GB1267404@ircssh-3.c.rugged-nimbus-611.internal>
References: <20220429023113.74993-1-sargun@sargun.me>
 <20220429023113.74993-3-sargun@sargun.me>
 <202204291053.E04A367@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204291053.E04A367@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 11:19:33AM -0700, Kees Cook wrote:
> On Thu, Apr 28, 2022 at 07:31:13PM -0700, Sargun Dhillon wrote:
> > +
> > +	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
> > +
> > +	listener = user_notif_syscall(__NR_getppid,
> > +				      SECCOMP_FILTER_FLAG_NEW_LISTENER |
> > +				      SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV);
> > +	ASSERT_GE(listener, 0);
> > +
> > +	pid = fork();
> > +	ASSERT_GE(pid, 0);
> > +
> > +	if (pid == 0) {
> > +		close(sk_pair[0]);
> > +		handled = sk_pair[1];
> > +
> > +		/* Setup the sigaction without SA_RESTART */
> > +		if (sigaction(SIGUSR1, &new_action, NULL)) {
> > +			perror("sigaction");
> > +			exit(1);
> > +		}
> > +
> > +		/* Make sure that the syscall is completed (no EINTR) */
> > +		ret = syscall(__NR_getppid);
> > +		exit(ret != USER_NOTIF_MAGIC);
> > +	}
> > +
> > +	while (get_proc_syscall(pid) != __NR_getppid &&
> > +	       get_proc_stat(pid) != 'S')
> > +		nanosleep(&delay, NULL);
> > +
> > +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
> > +	/* Kill the process to make sure it enters the wait_killable state */
> > +	EXPECT_EQ(kill(pid, SIGUSR1), 0);
> > +
> > +	/* TASK_KILLABLE is considered D (Disk Sleep) state */
> > +	while (get_proc_stat(pid) != 'D')
> > +		nanosleep(&delay, NULL);
> 
> Should a NOWAIT waitpid() happen in this loop to make sure this doesn't
> spin forever?
> 
> i.e. running these tests on a kernel that doesn't have the support
> shouldn't hang -- yes it'll time out eventually but that's annoying. ;)
> 
Wouldn't this bail already because user_notif_syscall would assert out
since the kernel would reject the unknown flag?

I might make this a little helper function, something like:
static void wait_for_state(struct __test_metadata *_metadata, pid_t pid, char wait_for) {
	/* 100 ms */
	struct timespec delay = { .tv_nsec = 100000000 };
	int status;

	while (get_proc_stat(pid) != wait_for) {
		ASSERT_EQ(waitpid(pid, &status, WNOHANG), 0) {
			if (WIFEXITED(status))
				TH_LOG("Process %d exited with error code %d", pid, WEXITSTATUS(status));
			else if (WIFSIGNALED(status))
				TH_LOG("Process %d exited due to signal %d", pid, WTERMSIG(status));
			else
				TH_LOG("Process %d exited due to unknown reason", pid);
		}
		nanosleep(&delay, NULL);
	}
}
	
}

> > +
> > +	resp.id = req.id;
> > +	resp.val = USER_NOTIF_MAGIC;
> > +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
> > +
> > +	/*
> > +	 * Make sure that the signal handler does get called once we're back in
> > +	 * userspace.
> > +	 */
> > +	EXPECT_EQ(read(sk_pair[0], &c, 1), 1);
> > +	EXPECT_EQ(waitpid(pid, &status, 0), pid);
> > +	EXPECT_EQ(true, WIFEXITED(status));
> > +	EXPECT_EQ(0, WEXITSTATUS(status));
> > +}
> > +
> > +TEST(user_notification_wait_killable_fatal)
> > +{
> > +	struct seccomp_notif req = {};
> > +	int listener, status;
> > +	pid_t pid;
> > +	long ret;
> > +	/* 100 ms */
> > +	struct timespec delay = { .tv_nsec = 100000000 };
> > +
> > +	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> > +	ASSERT_EQ(0, ret) {
> > +		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
> > +	}
> > +
> > +	listener = user_notif_syscall(__NR_getppid,
> > +				      SECCOMP_FILTER_FLAG_NEW_LISTENER |
> > +				      SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV);
> > +	ASSERT_GE(listener, 0);
> > +
> > +	pid = fork();
> > +	ASSERT_GE(pid, 0);
> > +
> > +	if (pid == 0) {
> > +		/* This should never complete */
> > +		syscall(__NR_getppid);
> > +		exit(1);
> > +	}
> > +
> > +	while (get_proc_stat(pid) != 'S')
> > +		nanosleep(&delay, NULL);
> > +
> > +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
> > +	/* Kill the process with a fatal signal */
> > +	EXPECT_EQ(kill(pid, SIGTERM), 0);
> > +
> > +	EXPECT_EQ(waitpid(pid, &status, 0), pid);
> > +	EXPECT_EQ(true, WIFSIGNALED(status));
> > +	EXPECT_EQ(SIGTERM, WTERMSIG(status));
> > +}
> 
> Should there be a test validating the inverse of this, as in _without_
> SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV, how should the above tests
> behave?
Don't we roughly get that from the user_notification_kill_in_middle
and user_notification_signal?

Although, I might cleanup the user_notification_signal test to disable
SA_RESTART like these tests.

> 
> Otherwise, looks good! Yay tests!
> 
> -- 
> Kees Cook
