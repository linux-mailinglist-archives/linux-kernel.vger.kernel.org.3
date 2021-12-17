Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11AB479430
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbhLQSnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:43:46 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:59004 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbhLQSnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:43:45 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:58040)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1myICk-00FEae-88; Fri, 17 Dec 2021 11:43:42 -0700
Received: from ip68-227-161-49.om.om.cox.net ([68.227.161.49]:42298 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1myICi-008ieW-3a; Fri, 17 Dec 2021 11:43:41 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Mike Christie <michael.christie@oracle.com>
Cc:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <20211129194707.5863-1-michael.christie@oracle.com>
        <20211129194707.5863-6-michael.christie@oracle.com>
Date:   Fri, 17 Dec 2021 12:42:54 -0600
In-Reply-To: <20211129194707.5863-6-michael.christie@oracle.com> (Mike
        Christie's message of "Mon, 29 Nov 2021 13:47:02 -0600")
Message-ID: <87lf0jdqdt.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1myICi-008ieW-3a;;;mid=<87lf0jdqdt.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.161.49;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/iGnaVviMxtTKijQlJhSfLXrjW2CoE4/w=
X-SA-Exim-Connect-IP: 68.227.161.49
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Mike Christie <michael.christie@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1554 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (0.7%), b_tie_ro: 9 (0.6%), parse: 0.81 (0.1%),
         extract_message_metadata: 3.1 (0.2%), get_uri_detail_list: 1.26
        (0.1%), tests_pri_-1000: 3.6 (0.2%), tests_pri_-950: 1.20 (0.1%),
        tests_pri_-900: 1.01 (0.1%), tests_pri_-90: 76 (4.9%), check_bayes: 74
        (4.8%), b_tokenize: 7 (0.4%), b_tok_get_all: 8 (0.5%), b_comp_prob:
        2.1 (0.1%), b_tok_touch_all: 55 (3.5%), b_finish: 0.80 (0.1%),
        tests_pri_0: 1424 (91.6%), check_dkim_signature: 0.52 (0.0%),
        check_dkim_adsp: 2.9 (0.2%), poll_dns_idle: 0.94 (0.1%), tests_pri_10:
        4.7 (0.3%), tests_pri_500: 22 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH V6 05/10] signal: Perfom autoreap for PF_USER_WORKER
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie <michael.christie@oracle.com> writes:

> Userspace doesn't know about PF_USER_WORKER threads, so it can't do wait
> to clean them up. For cases like where qemu will do dynamic/hot add/remove
> of vhost devices, then we need to auto reap the thread like was done for
> the kthread case, because qemu does not know what API the kernel/vhost
> layer is using.
>
> This has us do autoreaping for these threads similar to when the parent
> ignores SIGCHLD and for kthreads.

There is a lot wrong with this change.
1) you can just set "task->signal = SIGCHLD" to get this
   behavior so it is unnecessary.

2) This is not the autoreaping you want.  This autoreaping just kicks
   in when the parents signal handler is SIG_IGN.  Since I presume
   you are not controlling the parent this is just plain nonsense.

The autoreap you want is the autoreap in exit_notify, and you don't
want to call do_notify_parent at all.

Eric

> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  kernel/signal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index a629b11bf3e0..4ce2cc195269 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2071,9 +2071,9 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  
>  	psig = tsk->parent->sighand;
>  	spin_lock_irqsave(&psig->siglock, flags);
> -	if (!tsk->ptrace && sig == SIGCHLD &&
> +	if (!tsk->ptrace && (tsk->flags & PF_USER_WORKER || (sig == SIGCHLD &&
>  	    (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN ||
> -	     (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))) {
> +	     (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))))) {
>  		/*
>  		 * We are exiting and our parent doesn't care.  POSIX.1
>  		 * defines special semantics for setting SIGCHLD to SIG_IGN
