Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96514D517C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbiCJSQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiCJSQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:16:04 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7486613858A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:15:01 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:51786)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nSNJS-00F8a5-Qx; Thu, 10 Mar 2022 11:14:58 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34804 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nSNJQ-004pU3-Go; Thu, 10 Mar 2022 11:14:58 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220310093455.15176-1-pmladek@suse.com>
Date:   Thu, 10 Mar 2022 12:14:28 -0600
In-Reply-To: <20220310093455.15176-1-pmladek@suse.com> (Petr Mladek's message
        of "Thu, 10 Mar 2022 10:34:55 +0100")
Message-ID: <871qz9brp7.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nSNJQ-004pU3-Go;;;mid=<871qz9brp7.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19tyasZu15blocjvhMTlyqAb97udrw89cE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Petr Mladek <pmladek@suse.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1704 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (0.6%), b_tie_ro: 9 (0.5%), parse: 1.52 (0.1%),
         extract_message_metadata: 17 (1.0%), get_uri_detail_list: 2.6 (0.2%),
        tests_pri_-1000: 23 (1.4%), tests_pri_-950: 1.26 (0.1%),
        tests_pri_-900: 1.00 (0.1%), tests_pri_-90: 166 (9.7%), check_bayes:
        157 (9.2%), b_tokenize: 11 (0.6%), b_tok_get_all: 9 (0.5%),
        b_comp_prob: 2.6 (0.2%), b_tok_touch_all: 131 (7.7%), b_finish: 1.00
        (0.1%), tests_pri_0: 1457 (85.5%), check_dkim_signature: 0.82 (0.0%),
        check_dkim_adsp: 3.0 (0.2%), poll_dns_idle: 0.67 (0.0%), tests_pri_10:
        4.1 (0.2%), tests_pri_500: 18 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kthread: Make it clear that create_kthread() might be
 terminated by any fatal signal
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek <pmladek@suse.com> writes:

> The comments in kernel/kthread.c create a feeling that only SIGKILL
> is able to break create_kthread().
                   ^^^^^^^^^^^^^^^^ __kthread_create_on_node

Signals can't affect create_kthread in any was as it is only called by
kthreadd.  It is __kthread_create_on_node which gets interrupted by
fatal signals.

>
> In reality, wait_for_completion_killable() might be killed by any
> fatal signal that does not have a custom handler:
>
> 	(!siginmask(signr, SIG_KERNEL_IGNORE_MASK|SIG_KERNEL_STOP_MASK) && \
> 	 (t)->sighand->action[(signr)-1].sa.sa_handler == SIG_DFL)
>
> static inline void signal_wake_up(struct task_struct *t, bool resume)
> {
> 	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
> }
>
> static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
> {
> [...]
> 	/*
> 	 * Found a killable thread.  If the signal will be fatal,
> 	 * then start taking the whole group down immediately.
> 	 */
> 	if (sig_fatal(p, sig) ...) {
> 		if (!sig_kernel_coredump(sig)) {
> 		[...]
> 			do {
> 				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
> 				sigaddset(&t->pending.signal, SIGKILL);
> 				signal_wake_up(t, 1);
> 			} while_each_thread(p, t);
> 			return;
> 		}
> 	}
> }
>
> Update the comments in kernel/kthread.c to make this more obvious.
>
> The motivation for this change was debugging why a module initialization
> failed. The module was being loaded from initrd. It "magically" failed
> when systemd was switching to the real root. The clean up operations
> sent SIGTERM to various pending processed that were started from initrd.

Except for the minor nit in the change description.
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>


> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/kthread.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 38c6dd822da8..6f994c354adb 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -341,7 +341,7 @@ static int kthread(void *_create)
>  
>  	self = to_kthread(current);
>  
> -	/* If user was SIGKILLed, I release the structure. */
> +	/* Release the structure when caller killed by a fatal signal. */
>  	done = xchg(&create->done, NULL);
>  	if (!done) {
>  		kfree(create);
> @@ -399,7 +399,7 @@ static void create_kthread(struct kthread_create_info *create)
>  	/* We want our own signal handler (we take no signals by default). */
>  	pid = kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCHLD);
>  	if (pid < 0) {
> -		/* If user was SIGKILLed, I release the structure. */
> +		/* Release the structure when caller killed by a fatal signal. */
>  		struct completion *done = xchg(&create->done, NULL);
>  
>  		if (!done) {
> @@ -441,9 +441,9 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
>  	 */
>  	if (unlikely(wait_for_completion_killable(&done))) {
>  		/*
> -		 * If I was SIGKILLed before kthreadd (or new kernel thread)
> -		 * calls complete(), leave the cleanup of this structure to
> -		 * that thread.
> +		 * If I was killed by a fatal signal before kthreadd (or new
> +		 * kernel thread) calls complete(), leave the cleanup of this
> +		 * structure to that thread.
>  		 */
>  		if (xchg(&create->done, NULL))
>  			return ERR_PTR(-EINTR);
> @@ -877,7 +877,7 @@ __kthread_create_worker(int cpu, unsigned int flags,
>   *
>   * Returns a pointer to the allocated worker on success, ERR_PTR(-ENOMEM)
>   * when the needed structures could not get allocated, and ERR_PTR(-EINTR)
> - * when the worker was SIGKILLed.
> + * when the caller was killed by a fatal signal.
>   */
>  struct kthread_worker *
>  kthread_create_worker(unsigned int flags, const char namefmt[], ...)
> @@ -926,7 +926,7 @@ EXPORT_SYMBOL(kthread_create_worker);
>   * Return:
>   * The pointer to the allocated worker on success, ERR_PTR(-ENOMEM)
>   * when the needed structures could not get allocated, and ERR_PTR(-EINTR)
> - * when the worker was SIGKILLed.
> + * when the caller was killed by a fatal signal.
>   */
>  struct kthread_worker *
>  kthread_create_worker_on_cpu(int cpu, unsigned int flags,
