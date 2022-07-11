Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A71570D28
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiGKWFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGKWFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:05:40 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE57852DCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:05:39 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:60254)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oB1X8-009oPi-UK; Mon, 11 Jul 2022 16:05:38 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:46764 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oB1X7-00H0OW-V3; Mon, 11 Jul 2022 16:05:38 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
References: <YsyFhfAunVfVQKci@zx2c4.com>
        <20220711202136.64458-1-Jason@zx2c4.com>
Date:   Mon, 11 Jul 2022 17:05:32 -0500
In-Reply-To: <20220711202136.64458-1-Jason@zx2c4.com> (Jason A. Donenfeld's
        message of "Mon, 11 Jul 2022 22:21:36 +0200")
Message-ID: <87h73n9ufn.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oB1X7-00H0OW-V3;;;mid=<87h73n9ufn.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19gQz22kNlXnpFbMhsmJDc8JEhzQtYbb/A=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;"Jason A. Donenfeld" <Jason@zx2c4.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 390 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 16 (4.1%), b_tie_ro: 13 (3.4%), parse: 1.10
        (0.3%), extract_message_metadata: 17 (4.3%), get_uri_detail_list: 1.85
        (0.5%), tests_pri_-1000: 15 (3.9%), tests_pri_-950: 1.41 (0.4%),
        tests_pri_-900: 1.12 (0.3%), tests_pri_-90: 129 (33.1%), check_bayes:
        126 (32.3%), b_tokenize: 6 (1.5%), b_tok_get_all: 8 (2.1%),
        b_comp_prob: 2.8 (0.7%), b_tok_touch_all: 103 (26.3%), b_finish: 1.53
        (0.4%), tests_pri_0: 195 (50.0%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 7 (1.7%), poll_dns_idle: 0.89 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 9 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4] signal: break out of wait loops on kthread_stop()
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
> suspect that the subtle misuse in a kthread that caused a deadlock in
> the code I looked at last week is also found elsewhere.
>
> So this commit causes signal_pending() to return true when
> kthread_stop() is called, by setting TIF_NOTIFY_SIGNAL.
>
> The same also probably applies to the similar kthread_park()
> functionality, but that can be addressed later, as its semantics are
> slightly different.
>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v3->v4:
> - Don't address park() for now.
> - Don't bother clearing the flag, since the task is about to be freed
>   anyway.
>
>  kernel/kthread.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 3c677918d8f2..8888987f2b25 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -704,6 +704,7 @@ int kthread_stop(struct task_struct *k)
>  	kthread = to_kthread(k);
>  	set_bit(KTHREAD_SHOULD_STOP, &kthread->flags);
>  	kthread_unpark(k);
> +	test_and_set_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
>  	wake_up_process(k);
>  	wait_for_completion(&kthread->exited);
>  	ret = kthread->result;

Minor it.  Unless I have missed something that should just be
set_tsk_thread_flag.  You aren't using the return value so I don't
think there is any point in testing the previous state of
TIF_NOTIFY_SIGNAL.

Eric

