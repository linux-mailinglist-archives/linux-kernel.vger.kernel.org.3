Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC0E521E64
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244010AbiEJP2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345741AbiEJP11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:27:27 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656876252;
        Tue, 10 May 2022 08:17:43 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:60048)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1noRcL-00D06M-QG; Tue, 10 May 2022 09:17:41 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37644 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1noRcK-00D119-OQ; Tue, 10 May 2022 09:17:41 -0600
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
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <20220505182645.497868-10-ebiederm@xmission.com>
        <20220510142202.GB23277@redhat.com>
Date:   Tue, 10 May 2022 10:17:32 -0500
In-Reply-To: <20220510142202.GB23277@redhat.com> (Oleg Nesterov's message of
        "Tue, 10 May 2022 16:23:18 +0200")
Message-ID: <87ee11wh6b.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1noRcK-00D119-OQ;;;mid=<87ee11wh6b.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/Y8vXvnEYjPf/cn2xYcSjvlg/Nnds05MI=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 394 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (2.9%), b_tie_ro: 10 (2.5%), parse: 0.92
        (0.2%), extract_message_metadata: 3.1 (0.8%), get_uri_detail_list:
        1.13 (0.3%), tests_pri_-1000: 4.3 (1.1%), tests_pri_-950: 1.30 (0.3%),
        tests_pri_-900: 1.05 (0.3%), tests_pri_-90: 141 (35.7%), check_bayes:
        139 (35.3%), b_tokenize: 7 (1.8%), b_tok_get_all: 9 (2.2%),
        b_comp_prob: 2.4 (0.6%), b_tok_touch_all: 117 (29.8%), b_finish: 1.04
        (0.3%), tests_pri_0: 209 (53.1%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 2.7 (0.7%), poll_dns_idle: 0.93 (0.2%), tests_pri_10:
        3.0 (0.7%), tests_pri_500: 10 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 10/12] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/05, Eric W. Biederman wrote:
>>
>>  static void ptrace_unfreeze_traced(struct task_struct *task)
>>  {
>> -	if (READ_ONCE(task->__state) != __TASK_TRACED)
>> -		return;
>> -
>> -	WARN_ON(!task->ptrace || task->parent != current);
>> +	unsigned long flags;
>>  
>>  	/*
>> -	 * PTRACE_LISTEN can allow ptrace_trap_notify to wake us up remotely.
>> -	 * Recheck state under the lock to close this race.
>> +	 * The child may be awake and may have cleared
>> +	 * JOBCTL_PTRACE_FROZEN (see ptrace_resume).  The child will
>> +	 * not set JOBCTL_PTRACE_FROZEN or enter __TASK_TRACED anew.
>>  	 */
>> -	spin_lock_irq(&task->sighand->siglock);
>> -	if (READ_ONCE(task->__state) == __TASK_TRACED) {
>> +	if (lock_task_sighand(task, &flags)) {
>
> But I still think that a lockless
>
> 	if (!(task->jobctl & JOBCTL_PTRACE_FROZEN))
> 		return;
>
> check at the start of ptrace_unfreeze_traced() makes sense to avoid
> lock_task_sighand() if possible.
>
> And ptrace_resume() can probably clear JOBCTL_PTRACE_FROZEN along with
> JOBCTL_TRACED to make this optimization work better. The same for
> ptrace_signal_wake_up().

What do you have that suggests that taking siglock there is a problem?

What you propose will definitely work as an incremental change, and
in an incremental change we can explain why doing the stupid simple
thing is not good enough.

I am not really opposed on any grounds except that simplicity is good,
and hard to get wrong.

Eric

