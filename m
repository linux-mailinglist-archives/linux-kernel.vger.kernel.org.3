Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07A655ADD2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 02:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiFZA0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 20:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiFZA0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 20:26:23 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD9E1181F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 17:26:22 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:44156)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5G6X-009Ew9-Cu; Sat, 25 Jun 2022 18:26:21 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57634 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5G6W-00AZG4-Dq; Sat, 25 Jun 2022 18:26:21 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
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
Date:   Sat, 25 Jun 2022 19:26:13 -0500
In-Reply-To: <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 25 Jun 2022 11:25:21 -0700")
Message-ID: <87edzcw9qy.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o5G6W-00AZG4-Dq;;;mid=<87edzcw9qy.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+0Ew3aHKu/DFfK6TO/eca53o/6Gled/lY=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 366 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (3.4%), b_tie_ro: 11 (2.9%), parse: 1.24
        (0.3%), extract_message_metadata: 17 (4.7%), get_uri_detail_list: 1.65
        (0.5%), tests_pri_-1000: 25 (6.8%), tests_pri_-950: 1.26 (0.3%),
        tests_pri_-900: 1.06 (0.3%), tests_pri_-90: 74 (20.2%), check_bayes:
        73 (19.9%), b_tokenize: 7 (1.8%), b_tok_get_all: 7 (2.0%),
        b_comp_prob: 2.2 (0.6%), b_tok_touch_all: 53 (14.5%), b_finish: 0.91
        (0.2%), tests_pri_0: 219 (59.7%), check_dkim_signature: 0.60 (0.2%),
        check_dkim_adsp: 2.9 (0.8%), poll_dns_idle: 1.10 (0.3%), tests_pri_10:
        3.1 (0.8%), tests_pri_500: 9 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: re. Spurious wakeup on a newly created kthread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Jun 25, 2022 at 10:36 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Let me suggest someone create a new variant of kthread_create that takes
>> all of the parameters the workqueue code wants to set.
>
> I suspect the real issue is that that the kthread code simply
> shouldn't use the kernel_thread() helper at all.
>
> That helper is literally designed for "start a thread, run this thing".
>
> That's what it *does*.
>
> And that's not at all what the kthread code wants. It wants to set
> affinity masks, it wants to create a name for the thread, it wants to
> do all those other things.
>
> That code really wants to just do copy_process().
>
> Or maybe it really should just use create_io_thread(), which has a
> much better interface, except it has that one oddity in that it sets
> the flag that does this:
>
>         if (args->io_thread) {
>                 /*
>                  * Mark us an IO worker, and block any signal that isn't
>                  * fatal or STOP
>                  */
>                 p->flags |= PF_IO_WORKER;
>                 siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
>         }
>
> that then has special semantics.

It is worth pointing out kthreads also have special semantics for
signals and they are different.  In particular kthreads ignore all
signals by default.

The io_threads are much more userspace threads and the userspace process
handles signals, it is just the io_thread that blocks the signals so
they will go to real userspace processes.

Eric

