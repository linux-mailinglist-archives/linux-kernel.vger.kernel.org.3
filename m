Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBBC59069C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbiHKTAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 15:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiHKTAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 15:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 137899FAB9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660244406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B88pGo3O+YbvLJ09vCpFE07wPH++ZWPZRQy2v2c4GQU=;
        b=HHy/PiaQWDPF7ZhKfriyNwfKuM7yyBWXCqyO1lmYWOQuwkQgwDWLYL5gBrj9wGyJGvJaO2
        FNsCRw3aCsERDgr9A6VA0QQ4dxj2eSlqC/fUY1igFs5gyMEn5kaIO6fmHcDgO82UvicWUp
        BqgtL573h1+yL+kwJlwNkzxj2g0zy1E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-2hqieocjPOOaA6iN4c6yOw-1; Thu, 11 Aug 2022 15:00:03 -0400
X-MC-Unique: 2hqieocjPOOaA6iN4c6yOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0DEB18A6524;
        Thu, 11 Aug 2022 19:00:01 +0000 (UTC)
Received: from [10.22.18.117] (unknown [10.22.18.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAAB61121314;
        Thu, 11 Aug 2022 19:00:00 +0000 (UTC)
Message-ID: <60867fd6-f6c1-cdd3-d355-073d26588d0e@redhat.com>
Date:   Thu, 11 Aug 2022 15:00:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] locking/lockdep: add debug_show_all_lock_holders()
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@sifive.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        John Ogness <john.ogness@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <82af40cc-bf85-2b53-b8f9-dfc12e66a781@I-love.SAKURA.ne.jp>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <82af40cc-bf85-2b53-b8f9-dfc12e66a781@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 07:32, Tetsuo Handa wrote:
> Currently, check_hung_uninterruptible_tasks() reports details of locks
> held in the system. Also, lockdep_print_held_locks() does not report
> details of locks held by a thread if that thread is in TASK_RUNNING state.
> Several years of experience of debugging without vmcore tells me that
> these limitations have been a barrier for understanding what went wrong
> in syzbot's "INFO: task hung in" reports.
>
> I initially thought that the cause of "INFO: task hung in" reports is
> due to over-stressing. But I understood that over-stressing is unlikely.
> I now consider that there likely is a deadlock/livelock bug where lockdep
> cannot report as a deadlock when "INFO: task hung in" is reported.
>
> A typical case is that thread-1 is waiting for something to happen (e.g.
> wait_event_*()) with a lock held. When thread-2 tries to hold that lock
> using e.g. mutex_lock(), check_hung_uninterruptible_tasks() reports that
> thread-2 is hung and thread-1 is holding a lock which thread-2 is trying
> to hold. But currently check_hung_uninterruptible_tasks() cannot report
> the exact location of thread-1 which gives us an important hint for
> understanding why thread-1 is holding that lock for so long period.
>
> When check_hung_uninterruptible_tasks() reports a thread waiting for a
> lock, it is important to report backtrace of threads which already held
> that lock. Therefore, allow check_hung_uninterruptible_tasks() to report
> the exact location of threads which is holding any lock.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> I wish that lockdep continues tracking locks even after something went
> wrong (i.e. debug_locks remains 1), for recently I sometimes encounter
> problems that disable lockdep during boot stage.
>
> It would be noisy to report possibility of e.g. circular locking dependency
> every time due to keeping debug_locks enabled. But tracking locks even
> after something went wrong will help debug_show_all_lock_holders() to
> survive problems during boot stage.
>
> Changing debug_locks behavior is a future patch. For now, this patch alone
> will help debugging Greg's usb.git#usb-testing tree which is generating
> many "INFO: task hung in" reports.
>
>   include/linux/debug_locks.h |  5 +++++
>   kernel/hung_task.c          |  2 +-
>   kernel/locking/lockdep.c    | 32 ++++++++++++++++++++++++++++++++
>   3 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
> index dbb409d77d4f..0567d5ce5b4a 100644
> --- a/include/linux/debug_locks.h
> +++ b/include/linux/debug_locks.h
> @@ -50,6 +50,7 @@ extern int debug_locks_off(void);
>   #ifdef CONFIG_LOCKDEP
>   extern void debug_show_all_locks(void);
>   extern void debug_show_held_locks(struct task_struct *task);
> +extern void debug_show_all_lock_holders(void);
>   extern void debug_check_no_locks_freed(const void *from, unsigned long len);
>   extern void debug_check_no_locks_held(void);
>   #else
> @@ -61,6 +62,10 @@ static inline void debug_show_held_locks(struct task_struct *task)
>   {
>   }
>   
> +static inline void debug_show_all_lock_holders(void)
> +{
> +}
> +
>   static inline void
>   debug_check_no_locks_freed(const void *from, unsigned long len)
>   {
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index bb2354f73ded..18e22bbb714f 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -205,7 +205,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>    unlock:
>   	rcu_read_unlock();
>   	if (hung_task_show_lock)
> -		debug_show_all_locks();
> +		debug_show_all_lock_holders();
>   
>   	if (hung_task_show_all_bt) {
>   		hung_task_show_all_bt = false;
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 64a13eb56078..d06254108eb7 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -55,6 +55,7 @@
>   #include <linux/rcupdate.h>
>   #include <linux/kprobes.h>
>   #include <linux/lockdep.h>
> +#include <linux/sched/debug.h>
>   
>   #include <asm/sections.h>
>   
> @@ -6509,6 +6510,37 @@ void debug_show_all_locks(void)
>   	pr_warn("=============================================\n\n");
>   }
>   EXPORT_SYMBOL_GPL(debug_show_all_locks);
> +
> +void debug_show_all_lock_holders(void)
> +{
> +	struct task_struct *g, *p;
> +
> +	if (unlikely(!debug_locks)) {
> +		pr_warn("INFO: lockdep is turned off.\n");
> +		return;
> +	}
> +	pr_warn("\nShowing all threads with locks held in the system:\n");
> +
> +	rcu_read_lock();
> +	for_each_process_thread(g, p) {
> +		if (!p->lockdep_depth)
> +			continue;
> +		/*
> +		 * Assuming that the caller of this function is in a process
> +		 * context without any locks held, skip current thread which is
> +		 * holding only RCU read lock.
> +		 */
> +		if (p == current)
> +			continue;
> +		sched_show_task(p);
> +		lockdep_print_held_locks(p);
> +		touch_nmi_watchdog();
> +		touch_all_softlockup_watchdogs();
> +	}
> +	rcu_read_unlock();
> +	pr_warn("\n");
> +	pr_warn("=============================================\n\n");
> +}
>   #endif

Your debug_show_all_lock_holders() is very similar to 
debug_show_all_locks(). Maybe you can combine the 2 into a common helper 
instead duplicating the code.

BTW, this function will produce much more verbose output. Typically how 
many line of debug outputs are going to be dumped to the console by 
calling this function?

Cheers,
Longman

