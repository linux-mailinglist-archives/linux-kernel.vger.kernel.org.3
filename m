Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624BD490C88
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbiAQQbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:31:48 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:52348 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiAQQbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:31:47 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:46614)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9Uv3-00GwEM-QK; Mon, 17 Jan 2022 09:31:46 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:45126 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9Uv2-00FZV5-Cn; Mon, 17 Jan 2022 09:31:45 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <878rvhlvh2.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wgS865kHU=4NO=AvK07fcK7M6C6EYGdk80R1tkPKTLyhQ@mail.gmail.com>
        <87bl0aidjv.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wju6gEi3faCozsfuE07KsHsqgvfXHLeETXO0QJa7eN+fQ@mail.gmail.com>
Date:   Mon, 17 Jan 2022 10:31:36 -0600
In-Reply-To: <CAHk-=wju6gEi3faCozsfuE07KsHsqgvfXHLeETXO0QJa7eN+fQ@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 17 Jan 2022 17:44:08 +0200")
Message-ID: <875yqicoif.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n9Uv2-00FZV5-Cn;;;mid=<875yqicoif.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/NzLe6BsnYEoo2vfreyzFhm1Y9zELHXK4=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubMetaSxObfu_03,XMSubMetaSx_00,XM_B_SpammyWords autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 421 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (2.3%), b_tie_ro: 8 (2.0%), parse: 0.98 (0.2%),
         extract_message_metadata: 14 (3.4%), get_uri_detail_list: 1.89 (0.4%),
         tests_pri_-1000: 24 (5.7%), tests_pri_-950: 1.45 (0.3%),
        tests_pri_-900: 1.11 (0.3%), tests_pri_-90: 82 (19.5%), check_bayes:
        81 (19.2%), b_tokenize: 12 (2.9%), b_tok_get_all: 10 (2.4%),
        b_comp_prob: 4.0 (1.0%), b_tok_touch_all: 50 (12.0%), b_finish: 1.02
        (0.2%), tests_pri_0: 275 (65.3%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 2.6 (0.6%), poll_dns_idle: 0.80 (0.2%), tests_pri_10:
        2.0 (0.5%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] signal/exit/ptrace changes for v5.17
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Jan 17, 2022 at 5:32 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> I would like to have a version of pipe_write that sleeps in
>> TASK_KILLABLE.
>
> That would actually be horrible for another reason - now it would
> count towards the load average. That's another difference between
> interruptible waits and non-interruptible ones.
>
> Admittedly it's an entirely arbitrary one, but it's part of the whole
> semantic difference between TASK_INTERRUPTIBLE and
> TASK_UNINTERRUPTIBLE.
>
> You can play with TASK_NOLOAD of course, so it's something that can be
> worked around, but it gets a bit ugly.

Yes.  I don't want to make a change that changes the load average.

>>  I want the I/O wake-ups and I want the SIGKILL wake ups
>> but I don't want any other wake-ups.  Unfortunately the I/O wake-ups in
>> the pipe code are sent with wake_up_interruptible.  So a task sleeping
>> in TASK_KILLABLE won't get them.
>
> Yeah. The code *could* use the non-interruptible 'wake_up()', and
> everything should work - because waking things up too much doesn't
> change semantics, it's just a slight pessimization. Plus the whole
> "nested waitqueues" isn't actually any remotely normal case, so it
> doesn't really matter for performance either.
>
> But I really think it's wrong.
>
> You're trying to work around a problem the wrong way around. If a task
> is dead, and is dumping core, then signals just shouldn't matter in
> the first place, and thus the whole "TASK_INTERRUPTIBLE vs
> TASK_UNINTERRUPTIBLE" really shouldn't be an issue. The fact that it
> is an issue means there's something wrong in signaling, not in the
> pipe code.
>
> So I really think that's where the fix should be - on the signal delivery side.

The actual signaling is shutdown, (except for the special case of
SIGKILL being able to terminate the coredump).  It is io_uring and
anything else that is not a signal that causes signal_pending() to
return true.

I have not found any solution I am happy with yet, I am just
brainstorming.

Part of the problem is that I really don't want to perform process
shutdown and remove evidence of why the process crashed.  So maybe
shutting down io_uring is fine in that case but I don't like that either.

The more I look at all of the interesting corner cases the more I wonder
if the solution isn't to have the coredump code fork a kernel-only
userspace process (like the io_uring threads are kernel-only userspace
threads).  That would at least allow kernel functionality to work like
normal and greatly reduce the chance of weird feature interactions.

Hmm. A special kernel-only thread might even be enough as io_uring would
not be directing task_work at it.

You have been me some good information and I think I just need to sleep
on this problem a bit more to come up with a non-hacky solution.

Eric
