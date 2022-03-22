Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D044E3F83
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiCVN1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiCVN1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:27:39 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DCD85BF2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:26:12 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id k10so7926617oia.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRriYz3uEAWC86HBL4/jmG/6boIc75H8VkiBsRFLJyM=;
        b=VTTeySqwFAmAfQgSbqNPbBBP/uiOQUm12ZemHUgRO5jEUinVaTNB7dVFNUU8UyKCqE
         p7cs56//RZL1eRJgjvz2H7Fn8Bn8mPfa48gV6R80h9MupTyTNfTAggt5kyiSmrAFxwpw
         FdQ8gRYYORYmZ00xWLtWA1Fs5ilp2eB74xIwmSS2YiSKCC8gCGyAh1/51e6L9NhYKFQq
         UZy5G+4yYbOfq39Bxr2zGWP3QBec3+9huXD00KEs9Vs//Z9h5OLdMNsf6c1X8iKtQTOq
         lmrw82kKxDYONbnALoC81DBzLXTVhfXM/5bTGiE6rAhTUIzrfe50i6Dtrhy0unhX4LD0
         TwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRriYz3uEAWC86HBL4/jmG/6boIc75H8VkiBsRFLJyM=;
        b=L5YDrjG0Zc3h7bdhPWnzp7fwse09AG5nQ1gECeVPa5q+3I6oVCqA4xgNqijrZ5hwEF
         vj1EZ+uL9zuehA/cDlFrn2DK6G8TUSq6+xse6AT3taUVxGkMDkNd21zW3OXWfe87Vc4k
         D70sVFOo5PPctqlqi2oST/kq55XgnRYwWeOIdWSxyV9QeE2DUigqv0MI6GZ7hVsaqMMq
         QAzieMsYSDw7se6TT1fsRAQvIuFqenCQIP5bVVxW5l6TbvZ0bncGeGc/phjcsrUO0AL4
         aRky/uYp2Do2rS7lijWZCowkCO0JfUUKH4bIgt9jKW1FXN8Lb2WpaWy9jvY4TmSFyFF3
         kRkA==
X-Gm-Message-State: AOAM5309iwmpYVG/56Gp6som+ttjW2rbDwp0Mk5gu3Y/V8/JldCh5TA9
        aRjP1BuKkS9lrM1c5aP1FlIeRjj/X/IQsLRL5Fee2Q==
X-Google-Smtp-Source: ABdhPJzzERzwVSbJvoochyNR2QybnFyWeZl1KJJqfWVNf0n/EThDYvWPMHekXXjVXKYKiQ1PdInCAdiKA/BUdeKpT/M=
X-Received: by 2002:a05:6808:1709:b0:2ef:6a5b:4634 with SMTP id
 bc9-20020a056808170900b002ef6a5b4634mr2035861oib.163.1647955571134; Tue, 22
 Mar 2022 06:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <Yjmn/kVblV3TdoAq@elver.google.com>
In-Reply-To: <Yjmn/kVblV3TdoAq@elver.google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 22 Mar 2022 14:25:59 +0100
Message-ID: <CACT4Y+Zusg3dMaOZjexExcsyXUaU3Oo9MqgThWd2FG_Jzo=esQ@mail.gmail.com>
Subject: Re: RFC: Use of user space handler vs. SIG_DFL on forced signals
To:     Marco Elver <elver@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 at 11:42, Marco Elver <elver@google.com> wrote:
>
> Hello,
>
> Currently force_sig_info_to_task() will always unblock a blocked signal
> but deliver the signal to SIG_DFL:
>
>         [...]
>          * Note: If we unblock the signal, we always reset it to SIG_DFL,
>          * since we do not want to have a signal handler that was blocked
>          * be invoked when user space had explicitly blocked it.
>         [...]
>
> Is this requirement part of the POSIX spec? Or is the intent simply to
> attempt to do the least-bad thing?
>
> The reason I'm asking is that we've encountered rare crashes with the
> new SIGTRAP on perf events, due to patterns like this:
>
>         <set up SIGTRAP on a perf event>
>         ...
>         sigset_t s;
>         sigemptyset(&s);
>         sigaddset(&s, SIGTRAP | <and others>);
>         sigprocmask(SIG_BLOCK, &s, ...);
>         ...
>         <perf event triggers>
>
> When the perf event triggers, while SIGTRAP is blocked, force_sig_perf()
> will force the signal, but revert back to the default handler, thus
> terminating the task.
>
> For other types of signals, is the assumption here that if user space
> blocked the signal, it might not be able to handle it in the first
> place?
>
> For SIGTRAP on perf events we found this makes the situation worse,
> since the cause of the signal wasn't an error condition, but explicitly
> requested monitoring. In this case, we do in fact want delivery of the
> signal to user space even if the signal is blocked, i.e.
> force_sig_perf() should be an unblockable forced synchronous signal to
> user space!
>
> If there is no good reason to choose SIG_DFL, our preference would be to
> allow this kind of "unblockable forced" signal to the user space handler
> for force_sig_perf() -- with the caveat whoever requests SIGTRAP on perf
> events must be able to provide a handler that can always run safely. But
> we think that's better than crashing.
>
> The below patch would do what we want, but would like to first confirm
> if this is "within spec".
>
> Thoughts?
>
> Thanks,
> -- Marco
>
> ------ >8 ------
>
> From: Marco Elver <elver@google.com>
> Date: Mon, 21 Mar 2022 22:18:09 +0100
> Subject: [PATCH RFC] signal: Always unblock signal to user space for
>  force_sig_perf()
>
> With SIGTRAP on perf events, we have encountered termination of
> processes due to user space attempting to block delivery of SIGTRAP.
> Consider this case:
>
>         <set up SIGTRAP on a perf event>
>         ...
>         sigset_t s;
>         sigemptyset(&s);
>         sigaddset(&s, SIGTRAP | <and others>);
>         sigprocmask(SIG_BLOCK, &s, ...);
>         ...
>         <perf event triggers>
>
> When the perf event triggers, while SIGTRAP is blocked, force_sig_perf()
> will force the signal, but revert back to the default handler, thus
> terminating the task.
>
> With forced signals, the whole premise of sigprocmask() is invalidated
> since the signal is still delivered, only to the default signal handler.
> The assumption here is that if user space blocked the signal, it might
> not be able to handle it in the first place.
>
> However, for SIGTRAP on perf events we found this makes the situation
> worse, since the cause of the signal wasn't an error condition, but
> explicitly requested monitoring. In this case, we do in fact want
> delivery of the signal to user space even if the signal is blocked, i.e.
> force_sig_perf() should be an unblockable forced synchronous signal to
> user space.
>
> Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  kernel/signal.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 38602738866e..04b7a178a5f3 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1303,6 +1303,7 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
>
>  enum sig_handler {
>         HANDLER_CURRENT, /* If reachable use the current handler */
> +       HANDLER_UNBLOCK, /* Use the current handler even if blocked */
>         HANDLER_SIG_DFL, /* Always use SIG_DFL handler semantics */
>         HANDLER_EXIT,    /* Only visible as the process exit code */
>  };
> @@ -1311,9 +1312,11 @@ enum sig_handler {
>   * Force a signal that the process can't ignore: if necessary
>   * we unblock the signal and change any SIG_IGN to SIG_DFL.
>   *
> - * Note: If we unblock the signal, we always reset it to SIG_DFL,
> - * since we do not want to have a signal handler that was blocked
> - * be invoked when user space had explicitly blocked it.
> + * Note: If we unblock the signal and handler != HANDLER_UNBLOCK, we always
> + * reset it to SIG_DFL, since we do not want to have a signal handler that was
> + * blocked be invoked when user space had explicitly blocked it. If handler is
> + * HANDLER_UNBLOCK, user space will always receive the signal and is expected to
> + * provide a handler that is safe in all contexts.
>   *
>   * We don't want to have recursive SIGSEGV's etc, for example,
>   * that is why we also clear SIGNAL_UNKILLABLE.
> @@ -1332,7 +1335,8 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
>         ignored = action->sa.sa_handler == SIG_IGN;
>         blocked = sigismember(&t->blocked, sig);
>         if (blocked || ignored || (handler != HANDLER_CURRENT)) {
> -               action->sa.sa_handler = SIG_DFL;
> +               if (handler != HANDLER_UNBLOCK)
> +                       action->sa.sa_handler = SIG_DFL;
>                 if (handler == HANDLER_EXIT)
>                         action->sa.sa_flags |= SA_IMMUTABLE;
>                 if (blocked) {
> @@ -1816,7 +1820,11 @@ int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
>         info.si_perf_data = sig_data;
>         info.si_perf_type = type;
>
> -       return force_sig_info(&info);
> +       /*
> +        * Delivering SIGTRAP on perf events must unblock delivery to not
> +        * kill the task, but attempt delivery to the user space handler.
> +        */
> +       return force_sig_info_to_task(&info, current, HANDLER_UNBLOCK);

It seems that in this case we almost don't use any of the logic in
force_sig_info_to_task(). It effectively reduces to the call to
send_signal() protected by the lock. Maybe we should call something
like do_send_sig_info() directly?


>  }
>
>  /**
> --
> 2.35.1.894.gb6a874cedc-goog
>
