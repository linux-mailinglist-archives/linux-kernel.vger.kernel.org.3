Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C84C4E3FDA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiCVNyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbiCVNyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:54:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846CE12AB9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:53:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so2691005wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xz6ETfdcT64yZkSHXQnqh78ORnyr+ABN9mE88qOHoGU=;
        b=is1bmGSnd06eZ5RsazEt0A81TS4JorkOSV4HeoSK+EbRmfC6HaaIEzM31RabQPgHWB
         LE0sbXUGRMCFfXdcUWC5vO3YRLlU9Um+L+vAIV4Q8LY3VaJZUyJDbOxA5GohdWsFkhc6
         JQFoN4n7CGwvLcIrSNqNXRwLXuJ8sit/Isb6HgWpRcmp/0SttrRheZ/ZTRscaFDdE3LK
         w6L6cnbGtrWbaq9XoEd3l5BEWyoYEt/AlG4w5wRT4ju4+TzQBnphil2z2BqE3QXWcIuF
         GwzuS3LxOhb+1fLtgZX+ueUQS10cmiQfHZ5UobY9vfDVz/KvbB1BU2PG9vdP2CcoIA17
         9a/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xz6ETfdcT64yZkSHXQnqh78ORnyr+ABN9mE88qOHoGU=;
        b=QtdN7gfE4qZ+6ebKLfSZTazJMdeWJ2r4CK8WYtBJWbTusMI1znBxFIvOmmBfnT7Ui7
         f/9JLmLcxP72vM/UBeszou0qC4bQGA/fHu0/Z4+Q6dDKqm83mL5F4k+vKHbCUspoOB5v
         ep04zZEqKVA8aHGib+ZH2kK1uJXpgiO9mQzVngdy/5F+nwEujaXIz19MQRN0MYmHuwW8
         7oUtBsiLZEqqZV5EfX8HLiHYQcUefEmyHjsRjvIdmJSK3xKpnbSQXgAjNISpvW+yPzx9
         XQPUhK95jYBBc82ZEvGFcvjgGTCdhofVVxevcfvl/ocZHhzfurjTX+0wplQLXQkWqpTJ
         sLMw==
X-Gm-Message-State: AOAM533DypNvwuP32D3rn7d4Zu8PTXd3rk9KOUqNklal31SOIUjENW0u
        MBEDuIXGCzFJYoCGmrwDGTNTyg==
X-Google-Smtp-Source: ABdhPJzc8kXpf9OukhwcAWbyieLo7Sm+OLTBhptQ51EGYpDowm5kBt1P+hOCwz1it0wWfjn8hrw0oA==
X-Received: by 2002:a5d:47a1:0:b0:204:9f5:e72f with SMTP id 1-20020a5d47a1000000b0020409f5e72fmr10683387wrb.656.1647957197813;
        Tue, 22 Mar 2022 06:53:17 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:3aa9:ba1f:ba59:87ba])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d6d8d000000b00203d77cf7b0sm17027185wrs.74.2022.03.22.06.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 06:53:17 -0700 (PDT)
Date:   Tue, 22 Mar 2022 14:53:10 +0100
From:   Marco Elver <elver@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: Use of user space handler vs. SIG_DFL on forced signals
Message-ID: <YjnUxv4JVqGLLVNe@elver.google.com>
References: <Yjmn/kVblV3TdoAq@elver.google.com>
 <CACT4Y+Zusg3dMaOZjexExcsyXUaU3Oo9MqgThWd2FG_Jzo=esQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zusg3dMaOZjexExcsyXUaU3Oo9MqgThWd2FG_Jzo=esQ@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
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

On Tue, Mar 22, 2022 at 02:25PM +0100, Dmitry Vyukov wrote:
> On Tue, 22 Mar 2022 at 11:42, Marco Elver <elver@google.com> wrote:
> >
> > Hello,
> >
> > Currently force_sig_info_to_task() will always unblock a blocked signal
> > but deliver the signal to SIG_DFL:
> >
> >         [...]
> >          * Note: If we unblock the signal, we always reset it to SIG_DFL,
> >          * since we do not want to have a signal handler that was blocked
> >          * be invoked when user space had explicitly blocked it.
> >         [...]
> >
> > Is this requirement part of the POSIX spec? Or is the intent simply to
> > attempt to do the least-bad thing?
> >
> > The reason I'm asking is that we've encountered rare crashes with the
> > new SIGTRAP on perf events, due to patterns like this:
> >
> >         <set up SIGTRAP on a perf event>
> >         ...
> >         sigset_t s;
> >         sigemptyset(&s);
> >         sigaddset(&s, SIGTRAP | <and others>);
> >         sigprocmask(SIG_BLOCK, &s, ...);
> >         ...
> >         <perf event triggers>
> >
> > When the perf event triggers, while SIGTRAP is blocked, force_sig_perf()
> > will force the signal, but revert back to the default handler, thus
> > terminating the task.
> >
> > For other types of signals, is the assumption here that if user space
> > blocked the signal, it might not be able to handle it in the first
> > place?
> >
> > For SIGTRAP on perf events we found this makes the situation worse,
> > since the cause of the signal wasn't an error condition, but explicitly
> > requested monitoring. In this case, we do in fact want delivery of the
> > signal to user space even if the signal is blocked, i.e.
> > force_sig_perf() should be an unblockable forced synchronous signal to
> > user space!
> >
> > If there is no good reason to choose SIG_DFL, our preference would be to
> > allow this kind of "unblockable forced" signal to the user space handler
> > for force_sig_perf() -- with the caveat whoever requests SIGTRAP on perf
> > events must be able to provide a handler that can always run safely. But
> > we think that's better than crashing.
> >
> > The below patch would do what we want, but would like to first confirm
> > if this is "within spec".
> >
> > Thoughts?
> >
> > Thanks,
> > -- Marco
> >
> > ------ >8 ------
[...]
> > @@ -1332,7 +1335,8 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
> >         ignored = action->sa.sa_handler == SIG_IGN;
> >         blocked = sigismember(&t->blocked, sig);
> >         if (blocked || ignored || (handler != HANDLER_CURRENT)) {
> > -               action->sa.sa_handler = SIG_DFL;
> > +               if (handler != HANDLER_UNBLOCK)
> > +                       action->sa.sa_handler = SIG_DFL;
> >                 if (handler == HANDLER_EXIT)
> >                         action->sa.sa_flags |= SA_IMMUTABLE;
> >                 if (blocked) {
> > @@ -1816,7 +1820,11 @@ int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
> >         info.si_perf_data = sig_data;
> >         info.si_perf_type = type;
> >
> > -       return force_sig_info(&info);
> > +       /*
> > +        * Delivering SIGTRAP on perf events must unblock delivery to not
> > +        * kill the task, but attempt delivery to the user space handler.
> > +        */
> > +       return force_sig_info_to_task(&info, current, HANDLER_UNBLOCK);
> 
> It seems that in this case we almost don't use any of the logic in
> force_sig_info_to_task(). It effectively reduces to the call to
> send_signal() protected by the lock. Maybe we should call something
> like do_send_sig_info() directly?

Unfortunately not -- without this:

	[...]
	blocked = sigismember(&t->blocked, sig);
	if (blocked || ignored || (handler != HANDLER_CURRENT)) {
		[...]
		if (blocked) {
			sigdelset(&t->blocked, sig);
			recalc_sigpending_and_wake(t);
		}
	}
	[...]

, it doesn't work if blocked==true. The alternative is to introduce
another helper, force_sig_info_unblockable() or something, but don't see
the benefit.  Having it all in force_sig_info_to_task() seems cleaner
and we avoid replicating any unblock logic for forced signals.

Thanks,
-- Marco
