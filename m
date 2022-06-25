Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706E255AD91
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 01:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbiFYX2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 19:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiFYX2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 19:28:31 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025CFFD0F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:28:29 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:60468)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5FCU-009Axp-PL; Sat, 25 Jun 2022 17:28:26 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57590 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5FCT-00ATuF-O5; Sat, 25 Jun 2022 17:28:26 -0600
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
Date:   Sat, 25 Jun 2022 18:28:01 -0500
In-Reply-To: <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 25 Jun 2022 11:43:15 -0700")
Message-ID: <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o5FCT-00ATuF-O5;;;mid=<87pmiw1fy6.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19kWzYTkvknmqAUnyb+6Ca2bvXSKU0vc4Q=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 482 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 13 (2.7%), b_tie_ro: 11 (2.3%), parse: 1.61
        (0.3%), extract_message_metadata: 19 (4.0%), get_uri_detail_list: 3.7
        (0.8%), tests_pri_-1000: 8 (1.7%), tests_pri_-950: 1.88 (0.4%),
        tests_pri_-900: 1.36 (0.3%), tests_pri_-90: 65 (13.5%), check_bayes:
        63 (13.1%), b_tokenize: 12 (2.4%), b_tok_get_all: 11 (2.2%),
        b_comp_prob: 3.9 (0.8%), b_tok_touch_all: 33 (6.8%), b_finish: 1.00
        (0.2%), tests_pri_0: 353 (73.2%), check_dkim_signature: 0.81 (0.2%),
        check_dkim_adsp: 5 (1.1%), poll_dns_idle: 2.6 (0.5%), tests_pri_10:
        3.9 (0.8%), tests_pri_500: 10 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: re. Spurious wakeup on a newly created kthread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Jun 25, 2022 at 11:25 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> And that's not at all what the kthread code wants. It wants to set
>> affinity masks, it wants to create a name for the thread, it wants to
>> do all those other things.
>>
>> That code really wants to just do copy_process().
>
> Honestly, I think kernel/kthread.c should be almost rewritten from scratch.
>
> I do not understand why it does all those odd keventd games at all,
> and why kthread_create_info exists in the first place.

I presume you mean kthreadd games?

> Why does kthread_create() not just create the thread directly itself,
> and instead does that odd queue it onto a work function?
>
> Some of that goes back to before the git history, and very little of
> it seems to make any sense. It's as if the code is meant to be able to
> run from interrupt context, but that can't be it: it's literally doing
> a GFP_KERNEL kmalloc, it's doing spin-locks without irq safety etc.
>
> So why is it calling kthreadd_task() to create the thread? Purely for
> some crazy odd "make that the parent" reason?
>
> I dunno.  The code is odd, unexplained, looks buggy, and most fo the
> reasons are probably entirely historical.

I can explain why kthreadd exists and why it creates the threads.

Very long ago in the context of random userspace processes people would
use kernel_thread to create threads and a helper function that I think
was called something like kernel_daemonize to scrub the userspace bits
off.

It was an unending sources of problems as the scrub was never complete
nor correct.

So with the introduction of kthreadd the kernel threads were moved
out of the userspace process tree, and userspace stopped being able to
influence the kernel threads.

AKA instead of doing the equivalent of a suid exec the code started
going the equivalent sshing into the local box.

We *need* to preserve that kind of separation.

I want to say that all that is required is that copy_process copies
from kthreadd.  Unfortunately that means that it needs to be kthreadd
doing the work, as copy_process does always copies from current.  It
would take quite a bit of work to untangle that mess.

It does appear possible to write a parallel function to copy_process
that is used only for creating kernel threads, and can streamline itself
because it knows it is creating kernel threads.

Short of that the code needs to keep routing through kthreadd.

Using create_io_thread or a dedicated wrapper around copy_process
certainly looks like it could simplify some of kthread creation.

> I'm adding Christian to this thread too, since I get the feeling that
> it really should be more tightly integrated with copy_process(), and
> that Christian might have comments.
>
> Christian, see some context in the thread here:
>
>   https://lore.kernel.org/all/CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com/
>
> for some of this.
>
>                Linus

Eric
