Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35949570E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiGLAAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGLAAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:00:53 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BB92C656
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:00:52 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38988)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oB3Kd-0074lG-8v; Mon, 11 Jul 2022 18:00:51 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:53010 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oB3Kc-00CKvD-1j; Mon, 11 Jul 2022 18:00:50 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
References: <87h73n9ufn.fsf@email.froward.int.ebiederm.org>
        <20220711232123.136330-1-Jason@zx2c4.com>
Date:   Mon, 11 Jul 2022 19:00:25 -0500
In-Reply-To: <20220711232123.136330-1-Jason@zx2c4.com> (Jason A. Donenfeld's
        message of "Tue, 12 Jul 2022 01:21:23 +0200")
Message-ID: <87sfn76vza.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oB3Kc-00CKvD-1j;;;mid=<87sfn76vza.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+5A1MTUWd8MHViaku53bYc2QNGIFeP2Co=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;"Jason A. Donenfeld" <Jason@zx2c4.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 445 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.6 (0.8%), b_tie_ro: 2.5 (0.6%), parse: 0.84
        (0.2%), extract_message_metadata: 14 (3.1%), get_uri_detail_list: 1.72
        (0.4%), tests_pri_-1000: 18 (4.0%), tests_pri_-950: 1.19 (0.3%),
        tests_pri_-900: 0.97 (0.2%), tests_pri_-90: 164 (36.9%), check_bayes:
        163 (36.6%), b_tokenize: 5 (1.1%), b_tok_get_all: 5 (1.1%),
        b_comp_prob: 1.65 (0.4%), b_tok_touch_all: 148 (33.2%), b_finish: 0.79
        (0.2%), tests_pri_0: 232 (52.1%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 2.4 (0.5%), poll_dns_idle: 1.04 (0.2%), tests_pri_10:
        1.73 (0.4%), tests_pri_500: 6 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v5] signal: break out of wait loops on kthread_stop()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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
> suspect that the subtle misuse in a kthread that caused a deadlock in
> the code I looked at last week is also found elsewhere.
>
> So this commit causes signal_pending() to return true when
> kthread_stop() is called, by setting TIF_NOTIFY_SIGNAL.
>
> The same also probably applies to the similar kthread_park()
> functionality, but that can be addressed later, as its semantics are
> slightly different.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Do I need to pick this up and put it on a topic branch?
Or does this patch have another patch to get merged?


Eric

> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v4->v5:
> - Use set_tsk_thread_flag instead of test_and_set_tsk_thread_flag. Must
>   have been a copy and paste mistarget.
> Changes v3->v4:
> - Don't address park() for now.
> - Don't bother clearing the flag, since the task is about to be freed
>   anyway.
>
>  kernel/kthread.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 3c677918d8f2..7243a010f433 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -704,6 +704,7 @@ int kthread_stop(struct task_struct *k)
>  	kthread = to_kthread(k);
>  	set_bit(KTHREAD_SHOULD_STOP, &kthread->flags);
>  	kthread_unpark(k);
> +	set_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
>  	wake_up_process(k);
>  	wait_for_completion(&kthread->exited);
>  	ret = kthread->result;
