Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD9951C602
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382657AbiEERZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243602AbiEERZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:25:49 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002D55C351;
        Thu,  5 May 2022 10:22:08 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:54302)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmfB1-004NL6-4O; Thu, 05 May 2022 11:22:07 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37076 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmfB0-001ruM-3z; Thu, 05 May 2022 11:22:06 -0600
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
References: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <20220504224058.476193-8-ebiederm@xmission.com>
        <20220505150158.GB13929@redhat.com>
Date:   Thu, 05 May 2022 12:21:58 -0500
In-Reply-To: <20220505150158.GB13929@redhat.com> (Oleg Nesterov's message of
        "Thu, 5 May 2022 17:01:59 +0200")
Message-ID: <87a6bv7v49.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nmfB0-001ruM-3z;;;mid=<87a6bv7v49.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/R0B4YBqqFn6+USIbxA22SrHX567vNL3g=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 426 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.3%), b_tie_ro: 8 (1.9%), parse: 0.98 (0.2%),
         extract_message_metadata: 3.4 (0.8%), get_uri_detail_list: 1.52
        (0.4%), tests_pri_-1000: 4.2 (1.0%), tests_pri_-950: 1.26 (0.3%),
        tests_pri_-900: 1.05 (0.2%), tests_pri_-90: 116 (27.1%), check_bayes:
        114 (26.8%), b_tokenize: 8 (1.9%), b_tok_get_all: 10 (2.4%),
        b_comp_prob: 2.4 (0.6%), b_tok_touch_all: 90 (21.1%), b_finish: 0.91
        (0.2%), tests_pri_0: 273 (64.0%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.8 (0.7%), poll_dns_idle: 0.97 (0.2%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 08/11] ptrace: Admit ptrace_stop can generate
 spuriuos SIGTRAPs
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/04, Eric W. Biederman wrote:
>>
>> With the removal of the incomplete detection of the tracer going away
>> in ptrace_stop, ptrace_stop always sleeps in schedule after
>> ptrace_freeze_traced succeeds.  Modify ptrace_check_attach to
>> warn if wait_task_inactive fails.
>
> Oh. Again, I don't understand the changelog. If we forget about RT,
> ptrace_stop() will always sleep if ptrace_freeze_traced() succeeds.
> may_ptrace_stop() has gone.
>
> IOW. Lets forget about RT
>
>> --- a/kernel/ptrace.c
>> +++ b/kernel/ptrace.c
>> @@ -266,17 +266,9 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>>  	}
>>  	read_unlock(&tasklist_lock);
>>
>> -	if (!ret && !ignore_state) {
>> -		if (!wait_task_inactive(child, __TASK_TRACED)) {
>> -			/*
>> -			 * This can only happen if may_ptrace_stop() fails and
>> -			 * ptrace_stop() changes ->state back to TASK_RUNNING,
>> -			 * so we should not worry about leaking __TASK_TRACED.
>> -			 */
>> -			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
>> -			ret = -ESRCH;
>> -		}
>> -	}
>> +	if (!ret && !ignore_state &&
>> +	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
>> +		ret = -ESRCH;
>>
>>  	return ret;
>>  }
>
> Why do you think this change would be wrong without any other changes?

For purposes of this analysis ptrace_detach and ptrace_exit (when the
tracer exits) can't happen.  So the bug you spotted in ptrace_stop does
not apply.

I was thinking that the test against !current->ptrace that replaced
the old may_ptrace_stop could trigger a failure here.  If the
ptrace_freeze_traced happens before that test that branch clearly can
not happen.

*Looks twice* Both ptrace_check_attach and ptrace_stop taking a
read_lock on tasklist_lock does not protect against concurrency by each
other, but the write_lock on tasklist_lock in ptrace_attach does
protect against a ptrace_attach coming in after the test and before
__set_current_state(TASK_RUNNING).

So yes. I should really split that part out into it's own patch.
And yes that WARN_ON_ONCE can trigger on PREEMPT_RT but that is just
because PREMPT_RT is currently broken with respect to ptrace.  Which
makes a WARN_ON_ONCE appropriate.

I will see how much of this analysis I can put in the changelog.

Thank you,
Eric

