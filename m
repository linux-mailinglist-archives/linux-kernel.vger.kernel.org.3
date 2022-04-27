Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E249F511F59
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244093AbiD0Reo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244082AbiD0Rel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:34:41 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B142D1BFC97;
        Wed, 27 Apr 2022 10:31:21 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:35920)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njlVX-000Gnc-23; Wed, 27 Apr 2022 11:31:19 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35954 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njlVV-00C4Y5-KZ; Wed, 27 Apr 2022 11:31:18 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <20220426225211.308418-9-ebiederm@xmission.com>
        <20220427160901.GI17421@redhat.com>
        <87o80m7afv.fsf@email.froward.int.ebiederm.org>
        <20220427171829.GJ17421@redhat.com>
        <20220427172109.GK17421@redhat.com>
Date:   Wed, 27 Apr 2022 12:31:09 -0500
In-Reply-To: <20220427172109.GK17421@redhat.com> (Oleg Nesterov's message of
        "Wed, 27 Apr 2022 19:21:10 +0200")
Message-ID: <87wnfa5t7m.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njlVV-00C4Y5-KZ;;;mid=<87wnfa5t7m.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+XoRe+WnUdHjZVGZxm2GNPI+jnxvpu6gg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 446 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 9 (1.9%), b_tie_ro: 7 (1.6%), parse: 0.95 (0.2%),
        extract_message_metadata: 3.3 (0.7%), get_uri_detail_list: 1.20 (0.3%),
         tests_pri_-1000: 4.3 (1.0%), tests_pri_-950: 1.34 (0.3%),
        tests_pri_-900: 1.09 (0.2%), tests_pri_-90: 118 (26.4%), check_bayes:
        115 (25.9%), b_tokenize: 12 (2.7%), b_tok_get_all: 25 (5.6%),
        b_comp_prob: 4.2 (0.9%), b_tok_touch_all: 69 (15.4%), b_finish: 1.35
        (0.3%), tests_pri_0: 285 (64.0%), check_dkim_signature: 0.84 (0.2%),
        check_dkim_adsp: 3.5 (0.8%), poll_dns_idle: 0.80 (0.2%), tests_pri_10:
        2.8 (0.6%), tests_pri_500: 12 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 9/9] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/27, Oleg Nesterov wrote:
>>
>> On 04/27, Eric W. Biederman wrote:
>> >
>> > Oleg Nesterov <oleg@redhat.com> writes:
>> >
>> > > On 04/26, Eric W. Biederman wrote:
>> > >>
>> > >> @@ -253,7 +252,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>> > >>  	 */
>> > >>  	if (lock_task_sighand(child, &flags)) {
>> > >>  		if (child->ptrace && child->parent == current) {
>> > >> -			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
>> > >> +			WARN_ON(child->jobctl & JOBCTL_DELAY_WAKEKILL);
>> > >
>> > > This WARN_ON() doesn't look right.
>> > >
>> > > It is possible that this child was traced by another task and PTRACE_DETACH'ed,
>> > > but it didn't clear DELAY_WAKEKILL.
>> >
>> > That would be a bug.  That would mean that PTRACE_DETACHED process can
>> > not be SIGKILL'd.
>>
>> Why? The tracee will take siglock, clear JOBCTL_DELAY_WAKEKILL and notice
>> SIGKILL after that.
>
> Not to mention that the tracee is TASK_RUNNING after PTRACE_DETACH wakes it
> up, so the pending JOBCTL_DELAY_WAKEKILL simply has no effect.

Oh.  You are talking about the window when between clearing the
traced state and when tracee resumes executing and clears
JOBCTL_DELAY_WAKEKILL.

I thought you were thinking about JOBCTL_DELAY_WAKEKILL being leaked.

That requires both ptrace_attach and ptrace_check_attach for the new
tracer to happen before the tracee is scheduled to run.

I agree.  I think the WARN_ON could reasonably be moved a bit later,
but I don't know that the WARN_ON is important. I simply kept it because
it seemed to make sense.

Eric
