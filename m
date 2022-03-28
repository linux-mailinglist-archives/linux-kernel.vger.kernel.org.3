Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92DB4E9A14
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244052AbiC1Oul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240751AbiC1Ouk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:50:40 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554703DDE4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:48:59 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:49564)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nYqfx-003VBR-Bv; Mon, 28 Mar 2022 08:48:57 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:41454 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nYqfw-00FEaN-Cl; Mon, 28 Mar 2022 08:48:56 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <Ygq5aBB/qMQw6aP5@linutronix.de>
        <8735j2xigt.fsf@email.froward.int.ebiederm.org>
Date:   Mon, 28 Mar 2022 09:48:48 -0500
In-Reply-To: <8735j2xigt.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Mon, 28 Mar 2022 09:25:06 -0500")
Message-ID: <87v8vyuo8f.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nYqfw-00FEaN-Cl;;;mid=<87v8vyuo8f.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19SlXTuwUsAZ6C//A/e5mxrBho6uQddvCc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 386 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.9%), b_tie_ro: 10 (2.5%), parse: 0.99
        (0.3%), extract_message_metadata: 12 (3.1%), get_uri_detail_list: 1.31
        (0.3%), tests_pri_-1000: 15 (3.8%), tests_pri_-950: 1.26 (0.3%),
        tests_pri_-900: 1.07 (0.3%), tests_pri_-90: 76 (19.8%), check_bayes:
        75 (19.4%), b_tokenize: 8 (2.1%), b_tok_get_all: 8 (2.0%),
        b_comp_prob: 1.95 (0.5%), b_tok_touch_all: 53 (13.9%), b_finish: 0.83
        (0.2%), tests_pri_0: 255 (66.2%), check_dkim_signature: 0.59 (0.2%),
        check_dkim_adsp: 2.8 (0.7%), poll_dns_idle: 0.98 (0.3%), tests_pri_10:
        2.3 (0.6%), tests_pri_500: 8 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal/x86: Delay calling signals in atomic
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 9b04631acde8f..cb2b28c17c0a5 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -1327,6 +1327,34 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
>>  	struct k_sigaction *action;
>>  	int sig = info->si_signo;
        ^^^^^^^^^^^^^^^^^^^^^^^^^
See info->si_signo is unconditionally dereferenced.
>>  
>> +	/*
>> +	 * On some archs, PREEMPT_RT has to delay sending a signal from a trap
>> +	 * since it can not enable preemption, and the signal code's spin_locks
>> +	 * turn into mutexes. Instead, it must set TIF_NOTIFY_RESUME which will
>> +	 * send the signal on exit of the trap.
>> +	 */
>> +#ifdef ARCH_RT_DELAYS_SIGNAL_SEND
>> +	if (in_atomic()) {
>> +		struct task_struct *t = current;
>> +
>> +		if (WARN_ON_ONCE(t->forced_info.si_signo))
>> +			return 0;
>> +
>> +		if (is_si_special(info)) {
                    ^^^^^^^^^^^^^^^^^^^
This tests to see if info is either 0 or 1 cased to as "kernel_siginfo *"

Which is a long way of saying this code already guarantees that
is_si_special is guaranteed to be false so most of this code is
completely unnecessary.


>> +			WARN_ON_ONCE(info != SEND_SIG_PRIV);
>> +			t->forced_info.si_signo = info->si_signo;
>> +			t->forced_info.si_errno = 0;
>> +			t->forced_info.si_code = SI_KERNEL;
>> +			t->forced_info.si_pid = 0;
>> +			t->forced_info.si_uid = 0;
>> +		} else {
>> +			t->forced_info = *info;
>> +		}
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
All of that can just be:

		copy_siginfo(&t->force_info, info);

Using a structure copy here that gcc is allowed to not copy bytes in the
padding is wrong in that it allows an information leak to userspace.


>> +		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
>> +		return 0;
>> +	}
>> +#endif
>>  	spin_lock_irqsave(&t->sighand->siglock, flags);
>>  	action = &t->sighand->action[sig-1];
>>  	ignored = action->sa.sa_handler == SIG_IGN;

Eric
