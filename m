Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0021555ADC2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 02:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiFZAWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 20:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiFZAWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 20:22:02 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C09D13EAC
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 17:22:01 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37100)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5G2H-00Bdks-Ul; Sat, 25 Jun 2022 18:21:59 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57630 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5G2G-00726l-Tu; Sat, 25 Jun 2022 18:21:57 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <20220622140853.31383-1-pmladek@suse.com>
        <YraWWl+Go17uPOgR@mtj.duckdns.org>
        <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
        <874k0863x8.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
        <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
        <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
Date:   Sat, 25 Jun 2022 19:21:50 -0500
In-Reply-To: <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 25 Jun 2022 16:43:39 -0700")
Message-ID: <87sfnsw9y9.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o5G2G-00726l-Tu;;;mid=<87sfnsw9y9.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/5qEuZjbMFSnC3oEQhRe8Cw7yT3Ii1FY0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 487 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (2.7%), b_tie_ro: 12 (2.4%), parse: 1.57
        (0.3%), extract_message_metadata: 28 (5.7%), get_uri_detail_list: 3.2
        (0.7%), tests_pri_-1000: 36 (7.3%), tests_pri_-950: 1.46 (0.3%),
        tests_pri_-900: 1.15 (0.2%), tests_pri_-90: 65 (13.4%), check_bayes:
        63 (12.9%), b_tokenize: 9 (1.9%), b_tok_get_all: 9 (1.9%),
        b_comp_prob: 3.1 (0.6%), b_tok_touch_all: 38 (7.8%), b_finish: 0.96
        (0.2%), tests_pri_0: 322 (66.1%), check_dkim_signature: 0.80 (0.2%),
        check_dkim_adsp: 3.4 (0.7%), poll_dns_idle: 0.97 (0.2%), tests_pri_10:
        3.8 (0.8%), tests_pri_500: 11 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: re. Spurious wakeup on a newly created kthread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Jun 25, 2022 at 4:28 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> I presume you mean kthreadd games?
>
> Yeah, sorry.
>
>> So with the introduction of kthreadd the kernel threads were moved
>> out of the userspace process tree, and userspace stopped being able to
>> influence the kernel threads.
>
> Ahh. So essentially it's indeed just basically the parenting issue.

That is one way to look at it.  The way I described it at the time was:

> commit 73c279927f89561ecb45b2dfdf9314bafcfd9f67
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Wed May 9 02:34:32 2007 -0700
> 
>     kthread: don't depend on work queues
>     
>     Currently there is a circular reference between work queue initialization
>     and kthread initialization.  This prevents the kthread infrastructure from
>     initializing until after work queues have been initialized.
>     
>     We want the properties of tasks created with kthread_create to be as close
>     as possible to the init_task and to not be contaminated by user processes.
>     The later we start our kthreadd that creates these tasks the harder it is
>     to avoid contamination from user processes and the more of a mess we have
>     to clean up because the defaults have changed on us.
>     
>     So this patch modifies the kthread support to not use work queues but to
>     instead use a simple list of structures, and to have kthreadd start from
>     init_task immediately after our kernel thread that execs /sbin/init.
>     
>     By being a true child of init_task we only have to change those process
>     settings that we want to have different from init_task, such as our process
>     name, the cpus that are allowed, blocking all signals and setting SIGCHLD
>     to SIG_IGN so that all of our children are reaped automatically.
>     
>     By being a true child of init_task we also naturally get our ppid set to 0
>     and do not wind up as a child of PID == 1.  Ensuring that tasks generated
>     by kthread_create will not slow down the functioning of the wait family of
>     functions.
>     
>     [akpm@linux-foundation.org: use interruptible sleeps]
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>     Cc: Oleg Nesterov <oleg@tv-sign.ru>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Eric
