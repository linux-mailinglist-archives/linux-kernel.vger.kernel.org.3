Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C3B57B91F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiGTPDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGTPDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:03:32 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FB854670
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:03:30 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 34446937; Wed, 20 Jul 2022 10:03:28 -0500 (CDT)
Date:   Wed, 20 Jul 2022 10:03:28 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
Message-ID: <20220720150328.GA30749@mail.hallyn.com>
References: <Ys2PwTS0qFmGNFqy@netflix>
 <20220713175305.1327649-1-tycho@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713175305.1327649-1-tycho@tycho.pizza>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:53:05AM -0600, Tycho Andersen wrote:
> The wait_* code uses signal_pending_state() to test whether a thread has
> been interrupted, which ultimately uses __fatal_signal_pending() to detect
> if there is a fatal signal.
> 
> When a pid ns dies, it does:
> 
>     group_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);
> 
> for all the tasks in the pid ns. That calls through:
> 
>     group_send_sig_info() ->
>       do_send_sig_info() ->
>         send_signal_locked() ->
>           __send_signal_locked()
> 
> which does:
> 
>     pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
> 
> which puts sigkill in the set of shared signals, but not the individual
> pending ones. When complete_signal() is called at the end of
> __send_signal_locked(), if the task already had PF_EXITING (i.e. was
> already waiting on something in its fd closing path like a fuse flush),
> complete_signal() will not wake up the thread, since wants_signal() checks
> PF_EXITING before testing for SIGKILL.
> 
> If tasks are stuck in a killable wait (e.g. a fuse flush operation), they
> won't see this shared signal, and will hang forever, since TIF_SIGPENDING
> is set, but the fatal signal can't be detected. So, let's also look for
> PF_EXITING in __fatal_signal_pending().
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.pizza>

Cool, thanks for nailing this down!

I assume you've been running this on some boxes with no weird effects?

> ---
>  include/linux/sched/signal.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index cafbe03eed01..c20b7e1d89ef 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -402,7 +402,8 @@ static inline int signal_pending(struct task_struct *p)
>  
>  static inline int __fatal_signal_pending(struct task_struct *p)
>  {
> -	return unlikely(sigismember(&p->pending.signal, SIGKILL));
> +	return unlikely(sigismember(&p->pending.signal, SIGKILL) ||
> +			p->flags & PF_EXITING);

Looking around at the callers this does seem safe, but the name does
now seem misleading.  Should this be renamed to something like
exiting_or_fatal_signal_pending()?  

>  }
>  
>  static inline int fatal_signal_pending(struct task_struct *p)
> 
> base-commit: 32346491ddf24599decca06190ebca03ff9de7f8
> -- 
> 2.34.1
> 
