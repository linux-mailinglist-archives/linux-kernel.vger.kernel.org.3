Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1011D55CDFE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbiF0TQm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Jun 2022 15:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbiF0TQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:16:39 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E5A643D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:16:37 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:36704)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5uDr-002ZMj-1Q; Mon, 27 Jun 2022 13:16:35 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57800 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5uDp-00EjTC-VG; Mon, 27 Jun 2022 13:16:34 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
References: <YrnEvjcG8tmF3dRV@zx2c4.com>
        <20220627145716.641185-1-Jason@zx2c4.com>
Date:   Mon, 27 Jun 2022 14:16:08 -0500
In-Reply-To: <20220627145716.641185-1-Jason@zx2c4.com> (Jason A. Donenfeld's
        message of "Mon, 27 Jun 2022 16:57:16 +0200")
Message-ID: <877d51udc7.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1o5uDp-00EjTC-VG;;;mid=<877d51udc7.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18bmgF3preGwA4Fr2372PDG8RnAQBRdNBM=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;"Jason A. Donenfeld" <Jason@zx2c4.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 525 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 4.3 (0.8%), b_tie_ro: 3.1 (0.6%), parse: 1.35
        (0.3%), extract_message_metadata: 19 (3.7%), get_uri_detail_list: 3.2
        (0.6%), tests_pri_-1000: 22 (4.3%), tests_pri_-950: 1.02 (0.2%),
        tests_pri_-900: 0.79 (0.2%), tests_pri_-90: 89 (17.0%), check_bayes:
        88 (16.7%), b_tokenize: 8 (1.6%), b_tok_get_all: 8 (1.5%),
        b_comp_prob: 2.7 (0.5%), b_tok_touch_all: 66 (12.5%), b_finish: 0.78
        (0.1%), tests_pri_0: 374 (71.2%), check_dkim_signature: 0.43 (0.1%),
        check_dkim_adsp: 6 (1.1%), poll_dns_idle: 0.13 (0.0%), tests_pri_10:
        1.91 (0.4%), tests_pri_500: 8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] signal: break out of wait loops on kthread_stop()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> I was recently surprised to learn that msleep_interruptible(),
> wait_for_completion_interruptible_timeout(), and related functions
> simply hung when I called kthread_stop() on kthreads using them. The
> solution to fixing the case with msleep_interruptible() was more simply
> to move to schedule_timeout_interruptible(). Why?
>
> The reason is that msleep_interruptible(), and many functions just like
> it, has a loop like this:
>
>         while (timeout && !signal_pending(current))
>                 timeout = schedule_timeout_interruptible(timeout);
>
> The call to kthread_stop() woke up the thread, so schedule_timeout_
> interruptible() returned early, but because signal_pending() returned
> true, it went back into another timeout, which was never woken up.
>
> This wait loop pattern is common to various pieces of code, and I
> suspect that subtle misuse in a kthread that caused a deadlock in the
> code I looked at last week is also found elsewhere.
>
> So this commit causes signal_pending() to return true when
> kthread_stop() is called. This is already what's done for
> TIF_NOTIFY_SIGNAL, for these same purposes of breaking out of wait
> loops, so a similar KTHREAD_SHOULD_STOP check isn't too much
> different.

Semantically this makes a lot of sense.

Bloating up signal_pending which is mainly called in non-kthread
contexts is undesirable.

Instead could you modify kthread_stop to call set_notify_signal().

That is exactly what set_notify_signal is there for.  When you don't
actually have a signal but you want to break out of an interruptible
loop.  My last round of work in the area decoupled set_notify_signal
from any other semantics.


It would be nice to get everything down so that we only need to test
TIF_NOTIFY_SIGNAL in signal_pending.  Unfortunately to do that I need
to do something with task_sigpending, and it hasn't been important
enough to weed through all of those details yet.

Eric



> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  include/linux/kthread.h      | 1 +
>  include/linux/sched/signal.h | 9 +++++++++
>  kernel/kthread.c             | 8 ++++++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index 30e5bec81d2b..7061dde23237 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -87,6 +87,7 @@ void kthread_bind(struct task_struct *k, unsigned int cpu);
>  void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
>  int kthread_stop(struct task_struct *k);
>  bool kthread_should_stop(void);
> +bool __kthread_should_stop(struct task_struct *k);
>  bool kthread_should_park(void);
>  bool __kthread_should_park(struct task_struct *k);
>  bool kthread_freezable_should_stop(bool *was_frozen);
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index cafbe03eed01..08700c65b806 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -11,6 +11,7 @@
>  #include <linux/refcount.h>
>  #include <linux/posix-timers.h>
>  #include <linux/mm_types.h>
> +#include <linux/kthread.h>
>  #include <asm/ptrace.h>
>  
>  /*
> @@ -397,6 +398,14 @@ static inline int signal_pending(struct task_struct *p)
>  	 */
>  	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
>  		return 1;
> +
> +	/*
> +	 * Likewise, KTHREAD_SHOULD_STOP isn't really a signal, but it also
> +	 * requires the same behavior, lest wait loops go forever.
> +	 */
> +	if (unlikely(__kthread_should_stop(p)))
> +		return 1;
> +
>  	return task_sigpending(p);
>  }
>  
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 3c677918d8f2..80f6ba323060 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -145,6 +145,14 @@ void free_kthread_struct(struct task_struct *k)
>  	kfree(kthread);
>  }
>  
> +bool __kthread_should_stop(struct task_struct *k)
> +{
> +	struct kthread *kthread = __to_kthread(k);
> +
> +	return kthread && test_bit(KTHREAD_SHOULD_STOP, &kthread->flags);
> +}
> +EXPORT_SYMBOL_GPL(__kthread_should_stop);
> +
>  /**
>   * kthread_should_stop - should this kthread return now?
>   *
