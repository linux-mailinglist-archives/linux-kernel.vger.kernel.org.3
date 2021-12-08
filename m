Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED90746DB7D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbhLHStm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Dec 2021 13:49:42 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:38878 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhLHStk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:49:40 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:45286)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv1x5-00GqlP-JT; Wed, 08 Dec 2021 11:46:03 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:33982 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv1x3-0079ps-Rj; Wed, 08 Dec 2021 11:46:03 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Newsome <jnewsome@torproject.org>,
        Alexey Gladkov <legion@kernel.org>, Tejun Heo <tj@kernel.org>,
        <security@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>
References: <20211208180501.11969-1-mkoutny@suse.com>
Date:   Wed, 08 Dec 2021 12:45:54 -0600
In-Reply-To: <20211208180501.11969-1-mkoutny@suse.com> ("Michal
 \=\?utf-8\?Q\?Koutn\=C3\=BD\=22's\?\=
        message of "Wed, 8 Dec 2021 19:05:01 +0100")
Message-ID: <87sfv3540t.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1mv1x3-0079ps-Rj;;;mid=<87sfv3540t.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19UXDB5ozFkLrGhCCmfZKj78W2E3XviWUE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong,XM_B_SpammyWords,XM_B_Unicode
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?*;Michal Koutn=c3=bd <mkoutny@suse.com>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 1141 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 9 (0.8%), b_tie_ro: 8 (0.7%), parse: 1.16 (0.1%),
        extract_message_metadata: 17 (1.5%), get_uri_detail_list: 3.1 (0.3%),
        tests_pri_-1000: 23 (2.0%), tests_pri_-950: 1.27 (0.1%),
        tests_pri_-900: 1.11 (0.1%), tests_pri_-90: 166 (14.5%), check_bayes:
        158 (13.8%), b_tokenize: 12 (1.0%), b_tok_get_all: 13 (1.2%),
        b_comp_prob: 6 (0.5%), b_tok_touch_all: 121 (10.6%), b_finish: 1.06
        (0.1%), tests_pri_0: 906 (79.4%), check_dkim_signature: 1.03 (0.1%),
        check_dkim_adsp: 3.5 (0.3%), poll_dns_idle: 0.83 (0.1%), tests_pri_10:
        2.4 (0.2%), tests_pri_500: 11 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exit: Retain nsproxy for exit_task_work() work entries
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adding the security list and a couple of other people because I feel
like I just opened pandora's box, and I don't know how bad this issue
is.

TL;DR the cgroup file system is checking permissions at write time.

Michal Koutný <mkoutny@suse.com> writes:

> The reported issue is an attempted write in a cgroup file, by a zombie
> who has/had acct(2) enabled. Such a write needs cgroup_ns for access
> checking. Ordinary acct_process() would not be affected by this as it is
> called well before exit_task_namespaces(). However, the reported NULL
> dereference is a different acct data writer:
>
> 	Call Trace:
> 	 <TASK>
> 	 kernfs_fop_write_iter+0x3b6/0x510 fs/kernfs/file.c:296
> 	 __kernel_write+0x5d1/0xaf0 fs/read_write.c:535
> 	 do_acct_process+0x112a/0x17b0 kernel/acct.c:518
> 	 acct_pin_kill+0x27/0x130 kernel/acct.c:173
> 	 pin_kill+0x2a6/0x940 fs/fs_pin.c:44
> 	 mnt_pin_kill+0xc1/0x170 fs/fs_pin.c:81
> 	 cleanup_mnt+0x4bc/0x510 fs/namespace.c:1130
> 	 task_work_run+0x146/0x1c0 kernel/task_work.c:164
> 	 exit_task_work include/linux/task_work.h:32 [inline]
> 	 do_exit+0x705/0x24f0 kernel/exit.c:832
> 	 do_group_exit+0x168/0x2d0 kernel/exit.c:929
> 	 get_signal+0x16b0/0x2090 kernel/signal.c:2820
> 	 arch_do_signal_or_restart+0x9c/0x730 arch/x86/kernel/signal.c:868
> 	 handle_signal_work kernel/entry/common.c:148 [inline]
> 	 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
> 	 exit_to_user_mode_prepare+0x191/0x220 kernel/entry/common.c:207
> 	 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
> 	 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:300
> 	 do_syscall_64+0x53/0xd0 arch/x86/entry/common.c:86
> 	 entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> i.e. called as one of task_work_run() entries.
>
> The historical commit 8aac62706ada ("move exit_task_namespaces() outside
> of exit_notify()") argues that exit_task_namespaces() must come before
> exit_task_work() because ipc_ns cleanup calls fput/task_work_add.
>
> There is accompanying commit e7b2c4069252 ("fput: task_work_add() can
> fail if the caller has passed exit_task_work()") in the original series
> that makes fput() robust in situations when task_work_add() cannot be
> used anymore.
>
> So in order to ensure that task_work_run() entries of the exiting task
> have the nsproxy still available, swap the order of
> exit_task_namespaces() and exit_task_work().
>
> This change may appear like a partial revert of 8aac62706ada but this
> particular ordering change shouldn't matter with the fix from
> e7b2c4069252 and the other reason for 8aac62706ada (keeping exit_notify
> simpler) still holds.

I think I follow your reasoning and I think it will even fix the issue
but no.  That is completely very much not the correct fix.

That permission check in cgroup_file_write is just plain wrong.

Permission checks on files need to happen at open time, not at
write time.  It is all too easy to confuse something that writes
to stdout to write to a file of your choosing to make permission
checking at write time a good idea.

It looks like the this issue was introduced in commit 5136f6365ce3
("cgroup: implement "nsdelegate" mount option").

I wish I knew where I was when that patch was posted for review so
I could suggest a better implementation. 

That said I can't quite tell if the test should be moved into
cgroup_file_open or if there is a permission entry that would work.

Oh bleep!

The likely named cgroup_procs_write_permission isn't a permission method
at all.  It is called from cgroup_procs_write which I believe is
called from cgroup_file_write.

I may be wrong but at first glance this looks like the cgroup code is
going to need significant surgery to get the permission checks happening
at open time where they belong.

Please don't apply this patch.

exit_task_work running after exit_task_namespaces is the messenger
that just told us about something ugly.

Eric

> Reported-by: syzbot+50f5cf33a284ce738b62@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/00000000000048c15c05d0083397@google.com
> Cc: Oleg Nesterov <oleg@redhat.com>
> Fixes: 5136f6365ce3 ("cgroup: implement "nsdelegate" mount option")
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  kernel/exit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I wasn't able to reproduce the syzbot's crash manually so the effectiveness of
> the fix is only based on the reasoning.
>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index f702a6a63686..0c2abdebb87c 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -828,8 +828,8 @@ void __noreturn do_exit(long code)
>  	exit_fs(tsk);
>  	if (group_dead)
>  		disassociate_ctty(1);
> -	exit_task_namespaces(tsk);
>  	exit_task_work(tsk);
> +	exit_task_namespaces(tsk);
>  	exit_thread(tsk);
>  
>  	/*
