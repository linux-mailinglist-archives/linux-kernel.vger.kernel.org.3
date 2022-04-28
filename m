Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA142513BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351168AbiD1SlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiD1SlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:41:17 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F0BBE9E5;
        Thu, 28 Apr 2022 11:37:59 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:50494)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nk91Y-006tgx-5X; Thu, 28 Apr 2022 12:37:56 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36160 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nk91X-00GPuy-5E; Thu, 28 Apr 2022 12:37:55 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        tj@kernel.org, linux-pm@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <20220426225211.308418-6-ebiederm@xmission.com>
        <20220427141018.GA17421@redhat.com>
        <874k2ea9q4.fsf@email.froward.int.ebiederm.org>
        <87zgk67fdd.fsf@email.froward.int.ebiederm.org>
        <YmrSijTc6HIv4sAG@hirez.programming.kicks-ass.net>
Date:   Thu, 28 Apr 2022 13:37:47 -0500
In-Reply-To: <YmrSijTc6HIv4sAG@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Thu, 28 Apr 2022 19:44:42 +0200")
Message-ID: <8735hxxddw.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nk91X-00GPuy-5E;;;mid=<8735hxxddw.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18yrR4biUCy745ffIUgk1VZ5ZnVJz1nEjE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 398 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 15 (3.8%), b_tie_ro: 13 (3.3%), parse: 1.19
        (0.3%), extract_message_metadata: 14 (3.4%), get_uri_detail_list: 1.59
        (0.4%), tests_pri_-1000: 11 (2.7%), tests_pri_-950: 1.47 (0.4%),
        tests_pri_-900: 1.24 (0.3%), tests_pri_-90: 61 (15.4%), check_bayes:
        59 (14.9%), b_tokenize: 8 (1.9%), b_tok_get_all: 9 (2.3%),
        b_comp_prob: 3.3 (0.8%), b_tok_touch_all: 34 (8.5%), b_finish: 1.48
        (0.4%), tests_pri_0: 274 (68.7%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.7 (0.7%), poll_dns_idle: 2.4 (0.6%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 14 (3.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with
 siglock held
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Apr 27, 2022 at 09:47:10AM -0500, Eric W. Biederman wrote:
>
>> Hmm.  If we have the following process tree.
>> 
>>     A
>>      \
>>       B
>>        \
>>         C
>> 
>> Process A, B, and C are all in the same process group.
>> Process A and B are setup to receive SIGCHILD when
>> their process stops.
>> 
>> Process C traces process A.
>> 
>> When a sigstop is delivered to the group we can have:
>> 
>> Process B takes siglock(B) siglock(A) to notify the real_parent
>> Process C takes siglock(C) siglock(B) to notify the real_parent
>> Process A takes siglock(A) siglock(C) to notify the tracer
>> 
>> If they all take their local lock at the same time there is
>> a deadlock.
>> 
>> I don't think the restriction that you can never ptrace anyone
>> up the process tree is going to fly.  So it looks like I am back to the
>> drawing board for this one.
>
> I've not had time to fully appreciate the nested locking here, but if it
> is possible to rework things to always take both locks at the same time,
> then it would be possible to impose an arbitrary lock order on things
> and break the cycle that way.
>
> That is, simply order the locks by their heap address or something:
>
> static void double_siglock_irq(struct sighand *sh1, struct sighand2 *sh2)
> {
> 	if (sh1 > sh2)
> 		swap(sh1, sh2)
>
> 	spin_lock_irq(&sh1->siglock);
> 	spin_lock_nested(&sh2->siglock, SINGLE_DEPTH_NESTING);
> }

You know it might be.  Especially given that the existing code is
already dropping siglock and grabbing tasklist_lock.

It would take a potentially triple lock function to lock
the task it's real_parent and it's tracer (aka parent).

That makes this possible to consider is that notifying the ``parents''
is a fundamental part of the operation so we know we are going to
need the lock so we can move it up.

Throw in a pinch of lock_task_sighand and the triple lock function
gets quite interesting.

It is certainly worth trying, and I will.

Eric

