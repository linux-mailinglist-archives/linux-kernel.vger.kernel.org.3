Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A16D4E44AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiCVRIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiCVRIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:08:04 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361B363BF4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:06:36 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:36584)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nWhxq-00Be9o-HU; Tue, 22 Mar 2022 11:06:34 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:39048 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nWhxp-0006YH-5j; Tue, 22 Mar 2022 11:06:34 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Yjmn/kVblV3TdoAq@elver.google.com>
        <87ee2uyr4z.fsf@email.froward.int.ebiederm.org>
        <CANpmjNN4UjUTB5x6-2T-+b7MY=oAYn37MKvQy-4jYh6JDeJuKg@mail.gmail.com>
Date:   Tue, 22 Mar 2022 12:06:06 -0500
In-Reply-To: <CANpmjNN4UjUTB5x6-2T-+b7MY=oAYn37MKvQy-4jYh6JDeJuKg@mail.gmail.com>
        (Marco Elver's message of "Tue, 22 Mar 2022 17:44:31 +0100")
Message-ID: <87k0clvrwh.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nWhxp-0006YH-5j;;;mid=<87k0clvrwh.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18zZgVo2V4Ymywh3u9tzrBhXMZipJ3gZDQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 778 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 11 (1.4%), b_tie_ro: 10 (1.2%), parse: 1.03
        (0.1%), extract_message_metadata: 13 (1.7%), get_uri_detail_list: 2.6
        (0.3%), tests_pri_-1000: 13 (1.7%), tests_pri_-950: 1.17 (0.2%),
        tests_pri_-900: 0.98 (0.1%), tests_pri_-90: 226 (29.1%), check_bayes:
        225 (28.9%), b_tokenize: 9 (1.1%), b_tok_get_all: 10 (1.3%),
        b_comp_prob: 3.1 (0.4%), b_tok_touch_all: 199 (25.6%), b_finish: 0.85
        (0.1%), tests_pri_0: 497 (63.8%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.6 (0.3%), poll_dns_idle: 0.83 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 9 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: RFC: Use of user space handler vs. SIG_DFL on forced signals
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Elver <elver@google.com> writes:

> On Tue, 22 Mar 2022 at 15:54, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Marco Elver <elver@google.com> writes:
>>
>> > Hello,
>> >
>> > Currently force_sig_info_to_task() will always unblock a blocked signal
>> > but deliver the signal to SIG_DFL:
>> >
>> >       [...]
>> >        * Note: If we unblock the signal, we always reset it to SIG_DFL,
>> >        * since we do not want to have a signal handler that was blocked
>> >        * be invoked when user space had explicitly blocked it.
>> >       [...]
>> >
>> > Is this requirement part of the POSIX spec? Or is the intent simply to
>> > attempt to do the least-bad thing?
>>
>> I have not found any POSIX language about this.
>>
>> The options are either we terminate the application, or the application
>> spins forever re-triggering the trap.
>
> Is this in case of things like SEGV? I think this doesn't quite apply
> to us. The cause of the signal (perf event) is rather benign, and the
> signal handler can deal with recursion.

Yes. Signals like SIGSEGV are what force_sig_info_to_task is used for.

Signals where a userspace instruction causes a fault and the signal
is delivered immediately (synchronously) with that fault.


> [...]
>> > For SIGTRAP on perf events we found this makes the situation worse,
>> > since the cause of the signal wasn't an error condition, but explicitly
>> > requested monitoring. In this case, we do in fact want delivery of the
>> > signal to user space even if the signal is blocked, i.e.
>> > force_sig_perf() should be an unblockable forced synchronous signal to
>> > user space!
>>
>> Which is exactly what we have.  If you block it you get terminated.
>
> Right, however, in this case we want to monitor/trace memory accesses
> etc, and some 3rd party code such as a library being traced isn't
> under our control.
>
> What we can do instead is to intercept sigprocmask() and work around
> the issue, but libc interception is brittle. :-/
> We do just want to receive the signal, all the time.
>
> [...]
>> I think HANDLER_UNBLOCK is pretty much nonsense.
>>
>> A block signal very much means that userspace is not prepared to handle
>> the signal.  So calling something that is not ready to be called can't
>> work.  That is common sense, and I expect in POSIX as well.
>
> The fundamental question is, if we have a valid signal handler, but
> sigprocmask() is called, how do we still keep receiving signals for
> SIGTRAP despite sigprocmask()?
>
> Perhaps this is impossible without intercepting sigprocmask() in user
> space, in which we'll need to find a different solution.

Or adding some kind of feature to the kernel where you can report that
some signal is unblockable.

>> I expect that either you are looking for something like what ptrace does
>> with signal interruptions where another process is notified, and
>> userspace does not need to be involved, or that this is a don't do that
>> then.
>>
>> Or possibly you have some weird asynchronous signal thing happening and
>> you are calling it synchronous.
>
> Not quite. We need it to be synchronous, because we need to know the
> precise instruction and potentially do some other stuff _before_
> subsequent instructions.
>
> A compromise might be to deliver synchronously normally, but when
> blocked deliver asynchronously. But if the signal was delivered
> asynchronously, we need to let the signal handler know delivery was
> asynchronous, so that our tracing logic can recover and give up at
> that point.
>
> To do this indication if it was asynchronous, we probably need to
> extend siginfo_t once more. Would that be reasonable?

So the idea is to use normal signal delivery but to set a flag
to indicate that the signal was blocked at the time it was sent?

It should be possible to add another field that takes a non-zero
value.  On older kernels it should always have a value of zero so it
should be safe.

It might also be possible to simply ignore the signal if it is blocked.

In either case it will probably take a little bit of care to get the
races out.

Eric
