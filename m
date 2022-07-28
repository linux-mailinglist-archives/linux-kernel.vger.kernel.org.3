Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97F75845EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiG1StD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiG1StB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:49:01 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D7D71BDE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:49:00 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:36148)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oH8Z9-00E1aV-0m; Thu, 28 Jul 2022 12:48:59 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:48830 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oH8Z7-00BYV8-ND; Thu, 28 Jul 2022 12:48:58 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
References: <Ys2PwTS0qFmGNFqy@netflix>
        <20220713175305.1327649-1-tycho@tycho.pizza>
        <20220720150328.GA30749@mail.hallyn.com>
        <YthsgqAZYnwHZLn+@tycho.pizza> <20220721015459.GA4297@mail.hallyn.com>
        <YuFdUj5X4qckC/6g@tycho.pizza>
        <871qu6bjp3.fsf@email.froward.int.ebiederm.org>
        <YuF8H3ZVNugbLtFC@tycho.pizza>
Date:   Thu, 28 Jul 2022 13:48:17 -0500
In-Reply-To: <YuF8H3ZVNugbLtFC@tycho.pizza> (Tycho Andersen's message of "Wed,
        27 Jul 2022 11:55:43 -0600")
Message-ID: <8735elhy4u.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oH8Z7-00BYV8-ND;;;mid=<8735elhy4u.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18zLJB9EbXzeH/7OXoXVAdVtkdREDgofKw=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Tycho Andersen <tycho@tycho.pizza>
X-Spam-Relay-Country: 
X-Spam-Timing: total 750 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.5%), b_tie_ro: 2.7 (0.4%), parse: 0.88
        (0.1%), extract_message_metadata: 11 (1.4%), get_uri_detail_list: 3.2
        (0.4%), tests_pri_-1000: 3.8 (0.5%), tests_pri_-950: 1.03 (0.1%),
        tests_pri_-900: 0.80 (0.1%), tests_pri_-90: 214 (28.6%), check_bayes:
        202 (26.9%), b_tokenize: 10 (1.3%), b_tok_get_all: 12 (1.6%),
        b_comp_prob: 2.9 (0.4%), b_tok_touch_all: 172 (23.0%), b_finish: 0.80
        (0.1%), tests_pri_0: 501 (66.8%), check_dkim_signature: 0.46 (0.1%),
        check_dkim_adsp: 2.5 (0.3%), poll_dns_idle: 0.85 (0.1%), tests_pri_10:
        2.7 (0.4%), tests_pri_500: 8 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tycho Andersen <tycho@tycho.pizza> writes:

> On Wed, Jul 27, 2022 at 11:32:08AM -0500, Eric W. Biederman wrote:
>> Tycho Andersen <tycho@tycho.pizza> writes:
>> 
>> > Hi all,
>> >
>> > On Wed, Jul 20, 2022 at 08:54:59PM -0500, Serge E. Hallyn wrote:
>> >> Oh - I didn't either - checking the sigkill in shared signals *seems*
>> >> legit if they can be put there - but since you posted the new patch I
>> >> assumed his reasoning was clear to you.  I know Eric's busy, cc:ing Oleg
>> >> for his interpretation too.
>> >
>> > Any thoughts on this?
>> 
>> Having __fatal_signal_pending check SIGKILL in shared signals is
>> completely and utterly wrong.
>> 
>> What __fatal_signal_pending reports is if a signal has gone through
>> short cirucuit delivery after determining that the delivery of the
>> signal will terminate the process.
>
> This short-circuiting you're talking about happens in __send_signal()?
> The problem here is that __send_signal() will add things to the shared
> queue:
>
>     pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
>
> and indeed we add it to the shared set because of the way
> zap_pid_ns_processes() calls it:
>
>     roup_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);
>
>> Using "sigismember(&tsk->pending.signal, SIGKILL)" to report that a
>> fatal signal has experienced short circuit delivery is a bit of an
>> abuse, but essentially harmless as tkill of SIGKILL to a thread will
>> result in every thread in the process experiencing short circuit
>> delivery of the fatal SIGKILL.  So a pending SIGKILL can't really mean
>> anything else.
>
> This is the part I don't follow. If it's ok to send a signal to this
> set, why is it not ok to also look there (other than that it was a
> slight hack in the first place)? Maybe it will short circuit
> more threads, but that seems ok.

Let me see if I can help, now that I have the code and the backtrace
the details are becoming clearer.

In zap_pid_ns_processes group_send_signal sets some signal bits.
Then the processes notices those bits and deals with them in get_signal.
Then get_signal calls do_exit.
Then do_exit flushes the file descriptors.


So the reason __fatal_signal_pending fails is that the signal has been
dealt with by calling do_exit and it is no longer pending.

Frankly that there are some left over SIGKILL bits in the pending mask
is a misfeature, and it is definitely not something you should count on.


>> After having looked at the code a little more I can unfortunately also
>> say that testing PF_EXITING in __fatal_signal_pending will cause
>> kernel_wait4 in zap_pid_ns_processes to not sleep, and instead to return
>> 0.  Which will cause zap_pid_ns_processes to busy wait.  That seems very
>> unfortunate.
>> 
>> I hadn't realized it at the time I wrote zap_pid_ns_processes but I
>> think anything called from do_exit that cares about signal pending state
>> is pretty much broken and needs to be fixed.
>
>> So the question is how do we fix the problem in fuse that shows up
>> during a pid namespace exit without having interruptible sleeps we need
>> to wake up?
>> 
>> What are the code paths that experience the problem?
>
> [<0>] request_wait_answer+0x282/0x710 [fuse]
> [<0>] fuse_simple_request+0x502/0xc10 [fuse]
> [<0>] fuse_flush+0x431/0x630 [fuse]
> [<0>] filp_close+0x96/0x120
> [<0>] put_files_struct+0x15c/0x2c0
> [<0>] do_exit+0xa00/0x2450
> [<0>] do_group_exit+0xb2/0x2a0
> [<0>] get_signal+0x1eed/0x2090
> [<0>] arch_do_signal_or_restart+0x89/0x1bc0
> [<0>] exit_to_user_mode_prepare+0x11d/0x1b0
> [<0>] syscall_exit_to_user_mode+0x19/0x50
> [<0>] do_syscall_64+0x50/0x90
> [<0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

This is half of the hang thank you.

> is the full call stack, I have a reproducer here (make check will run
> it): https://github.com/tych0/kernel-utils/tree/master/fuse2


Thank you for this I can almost trace what is going on.

There is a server and it is accessing the filesystem it servers.
Plus the process staying alive keeps the filesystem mounted and
active because it is acessing the filesystem it serves.


The filesystem access hanging appears to be because fc->connected != 0.

If fuse_abort_conn could successfully run that should successfully
shut everything down.

The server when it is killed should call fuse_abort_conn from
fuse_dev_release, but the code appears to never get there because it is
blocked in fuse_flush from closing the file descriptor open to the fuse
file system.

So this looks like one process hanging and waiting on itself.


I suspect the solution is do use something like task_wake in the
fuse_flush calls to allow the server file descriptor to be close
resulting in fuse_dev_release calling fuse_abort_conn.


>
> In addition to fuse, it looks like nfs_file_flush() eventually ends up
> in __fatal_signal_pending(), and probably a few others that want to
> synchronize with something outside the local kernel.

Yes, my thinking there about not calling __fatal_signal_pending during
do_exit seems to have been confused.  Rather what can't be done is
depending upon __fatal_signal_pending to ever returning true.

What needs to happen is to make certain we don't have the loops where
one part of the shutdown depends upon another.  I don't know if there
is a way to shutdown the nfs connection why a client is waiting or not.

>> Will refactoring zap_pid_ns_processes as I have proposed so that it does
>> not use kernel_wait4 help sort this out?  AKA make it work something
>> like thread group leader of a process and not allow wait to reap the
>> init process of a pid namespace until all of the processes in a pid
>> namespaces have been gone.  Not that I see the problem in using
>> kernel_wait4 it looks like zap_pid_ns_processes needs to stop calling
>> kernel_wait4 regardless of the fuse problem.
>
> I can look at this, but I really don't think it will help: in this
> brave new world, what wakes up tasks stuck like the above? They're
> still looking at the wrong signal set.

This is probably a wild goose chase.  There are some funny namespace
bits like the pid namespace closing that we need to rule out of
the picture, but overall I don't think the pid namespace has
anything to do with this.

I was thinking removing the kernel_wait would simplify things by
removing one place where a process waits on another process during
shutdown.  With the right problem it probably will help.  In this case
since everything is in a single process I don't see that happening.

I spent a little time and tried to get this to reproduce without the
pid namespace and it initially it looked like it was working but
after a bunch of time those attempts exited on their own.  So I haven't
mastered all of what is going on in your fuse test case yet.

Eric

