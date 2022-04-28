Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D150851314A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiD1Ka4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiD1Kaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:30:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFF649C8F;
        Thu, 28 Apr 2022 03:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=39bYJZ1yrDJNMDn/aX063F9Jn6M2z3AydqcJ0Ax4Cek=; b=AU4Hc6WJRxDBT3Z2XgPMH/3xIB
        SqLp057cjQGHsuq13Z3QFhOkjs/KT6Sysa6d1iHl4AFa3vraX171VHKNyZaLCM8ti5zIARL7uYI8h
        UZ9WYH2uJFwhB+hNzzablZd4hW6I0goAz7YAhVYpnz1KRO/Q+WRFQBDL1+uZgxXu8K6iGE7iFIr+v
        ptBV34hak3xJFDheSShKtWVbUD3bMz3tXZh12L2DG/gUJhl9fqQkv+ETxKbXzhXXgX1w+vHOaBXBH
        oDSu6U+fYtGgeslHhOFd26Ftei/YhhGVXuwTucMlVSz+5xsNLNIAPvhIAcMGV3yU2Kg/SOJ61LwTj
        6qMNOCqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk1Mf-009Jtp-WB; Thu, 28 Apr 2022 10:27:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C99A830031D;
        Thu, 28 Apr 2022 12:27:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B45312029F872; Thu, 28 Apr 2022 12:27:11 +0200 (CEST)
Date:   Thu, 28 Apr 2022 12:27:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/9] signal: Rename send_signal send_signal_locked
Message-ID: <Ympr/+PX4XgT/UKU@hirez.programming.kicks-ass.net>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426225211.308418-1-ebiederm@xmission.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 05:52:03PM -0500, Eric W. Biederman wrote:
> Rename send_signal send_signal_locked and make to make
> it usable outside of signal.c.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  include/linux/signal.h |  2 ++
>  kernel/signal.c        | 24 ++++++++++++------------
>  2 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index a6db6f2ae113..55605bdf5ce9 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -283,6 +283,8 @@ extern int do_send_sig_info(int sig, struct kernel_siginfo *info,
>  extern int group_send_sig_info(int sig, struct kernel_siginfo *info,
>  			       struct task_struct *p, enum pid_type type);
>  extern int __group_send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
> +extern int send_signal_locked(int sig, struct kernel_siginfo *info,
> +			      struct task_struct *p, enum pid_type type);
>  extern int sigprocmask(int, sigset_t *, sigset_t *);
>  extern void set_current_blocked(sigset_t *);
>  extern void __set_current_blocked(const sigset_t *);
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 30cd1ca43bcd..b0403197b0ad 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1071,8 +1071,8 @@ static inline bool legacy_queue(struct sigpending *signals, int sig)
>  	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
>  }
>  
> -static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struct *t,
> -			enum pid_type type, bool force)
> +static int __send_signal_locked(int sig, struct kernel_siginfo *info,
> +				struct task_struct *t, enum pid_type type, bool force)
>  {
>  	struct sigpending *pending;
>  	struct sigqueue *q;

While there, could you please replace that assert_spin_locked() with
lockdep_assert_held(&t->sighand->siglock) ?

The distinction being that assert_spin_locked() checks if the lock is
held *by*anyone* whereas lockdep_assert_held() asserts the current
context holds the lock.  Also, the check goes away if you build without
lockdep.
