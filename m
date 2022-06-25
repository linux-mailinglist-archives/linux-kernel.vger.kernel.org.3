Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF2F55AD9B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 01:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiFYXlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 19:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiFYXl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 19:41:29 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BFFF5BD
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:41:28 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:40444)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5FP5-00H1OY-Is; Sat, 25 Jun 2022 17:41:27 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57606 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5FP4-00AUwT-FE; Sat, 25 Jun 2022 17:41:27 -0600
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
Date:   Sat, 25 Jun 2022 18:41:19 -0500
In-Reply-To: <87pmiw1fy6.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Sat, 25 Jun 2022 18:28:01 -0500")
Message-ID: <87a6a01fc0.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o5FP4-00AUwT-FE;;;mid=<87a6a01fc0.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19+nfYuM5QkUmmMWqKPyESId/ALYZsS/kc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 512 ms - load_scoreonly_sql: 0.13 (0.0%),
        signal_user_changed: 12 (2.3%), b_tie_ro: 10 (1.9%), parse: 1.00
        (0.2%), extract_message_metadata: 16 (3.1%), get_uri_detail_list: 2.1
        (0.4%), tests_pri_-1000: 25 (4.9%), tests_pri_-950: 1.26 (0.2%),
        tests_pri_-900: 1.18 (0.2%), tests_pri_-90: 112 (22.0%), check_bayes:
        111 (21.6%), b_tokenize: 9 (1.8%), b_tok_get_all: 9 (1.8%),
        b_comp_prob: 3.3 (0.7%), b_tok_touch_all: 85 (16.5%), b_finish: 0.98
        (0.2%), tests_pri_0: 329 (64.4%), check_dkim_signature: 0.76 (0.1%),
        check_dkim_adsp: 2.9 (0.6%), poll_dns_idle: 1.04 (0.2%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 9 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: re. Spurious wakeup on a newly created kthread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Sat, Jun 25, 2022 at 11:25 AM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> And that's not at all what the kthread code wants. It wants to set
>>> affinity masks, it wants to create a name for the thread, it wants to
>>> do all those other things.
>>>
>>> That code really wants to just do copy_process().
>>
>> Honestly, I think kernel/kthread.c should be almost rewritten from scratch.
>>
>> I do not understand why it does all those odd keventd games at all,
>> and why kthread_create_info exists in the first place.
>
> I presume you mean kthreadd games?
>
>> Why does kthread_create() not just create the thread directly itself,
>> and instead does that odd queue it onto a work function?
>>
>> Some of that goes back to before the git history, and very little of
>> it seems to make any sense. It's as if the code is meant to be able to
>> run from interrupt context, but that can't be it: it's literally doing
>> a GFP_KERNEL kmalloc, it's doing spin-locks without irq safety etc.
>>
>> So why is it calling kthreadd_task() to create the thread? Purely for
>> some crazy odd "make that the parent" reason?
>>
>> I dunno.  The code is odd, unexplained, looks buggy, and most fo the
>> reasons are probably entirely historical.
>
> I can explain why kthreadd exists and why it creates the threads.
>
> Very long ago in the context of random userspace processes people would
> use kernel_thread to create threads and a helper function that I think
> was called something like kernel_daemonize to scrub the userspace bits
> off.
>
> It was an unending sources of problems as the scrub was never complete
> nor correct.
>
> So with the introduction of kthreadd the kernel threads were moved
> out of the userspace process tree, and userspace stopped being able to
> influence the kernel threads.
>
> AKA instead of doing the equivalent of a suid exec the code started
> going the equivalent sshing into the local box.
>
> We *need* to preserve that kind of separation.
>
> I want to say that all that is required is that copy_process copies
> from kthreadd.  Unfortunately that means that it needs to be kthreadd
> doing the work, as copy_process does always copies from current.  It
> would take quite a bit of work to untangle that mess.
>
> It does appear possible to write a parallel function to copy_process
> that is used only for creating kernel threads, and can streamline itself
> because it knows it is creating kernel threads.
>
> Short of that the code needs to keep routing through kthreadd.
>
> Using create_io_thread or a dedicated wrapper around copy_process
> certainly looks like it could simplify some of kthread creation.

Hmm.  Looking at kthread() I completely agree that kernel_thread() has
the wrong set of semantics and we really could benefit from never waking
the fledgling kernel thread in the first place.

Eric
