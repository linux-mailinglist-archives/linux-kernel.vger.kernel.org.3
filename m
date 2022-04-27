Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914F85119E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbiD0ObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbiD0ObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:31:17 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14936352;
        Wed, 27 Apr 2022 07:28:02 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:48032)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njie7-00H3An-CN; Wed, 27 Apr 2022 08:27:59 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35868 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njie6-008bzq-9O; Wed, 27 Apr 2022 08:27:58 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        tj@kernel.org, linux-pm@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <20220426225211.308418-7-ebiederm@xmission.com>
        <87a6c6bq36.fsf@email.froward.int.ebiederm.org>
Date:   Wed, 27 Apr 2022 09:27:50 -0500
In-Reply-To: <87a6c6bq36.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 27 Apr 2022 08:42:05 -0500")
Message-ID: <87o80m8uu1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njie6-008bzq-9O;;;mid=<87o80m8uu1.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+QyTq7eWW6GZa8ahW1NUDzmexqHmUE7lg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 492 ms - load_scoreonly_sql: 0.13 (0.0%),
        signal_user_changed: 14 (2.8%), b_tie_ro: 12 (2.4%), parse: 1.78
        (0.4%), extract_message_metadata: 19 (3.9%), get_uri_detail_list: 2.4
        (0.5%), tests_pri_-1000: 21 (4.2%), tests_pri_-950: 1.82 (0.4%),
        tests_pri_-900: 1.53 (0.3%), tests_pri_-90: 104 (21.1%), check_bayes:
        102 (20.7%), b_tokenize: 11 (2.2%), b_tok_get_all: 10 (2.1%),
        b_comp_prob: 3.1 (0.6%), b_tok_touch_all: 73 (14.9%), b_finish: 1.22
        (0.2%), tests_pri_0: 306 (62.1%), check_dkim_signature: 0.76 (0.2%),
        check_dkim_adsp: 3.0 (0.6%), poll_dns_idle: 1.06 (0.2%), tests_pri_10:
        4.5 (0.9%), tests_pri_500: 13 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 7/9] ptrace: Simplify the wait_task_inactive call in
 ptrace_check_attach
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>
>> Asking wait_task_inactive to verify that tsk->__state == __TASK_TRACED
>> was needed to detect the when ptrace_stop would decide not to stop
>> after calling "set_special_state(TASK_TRACED)".  With the recent
>> cleanups ptrace_stop will always stop after calling set_special_state.
>>
>> Take advatnage of this by no longer asking wait_task_inactive to
>> verify the state.  If a bug is hit and wait_task_inactive does not
>> succeed warn and return -ESRCH.
>
> As Oleg noticed upthread there are more reasons than simply
> !current->ptrace for wait_task_inactive to fail.  In particular a fatal
> signal can be received any time before JOBCTL_DELAY_SIGKILL.
>
> So this change is not safe.  I will respin this one.

Bah.  I definitely need to update the description so there is going to
be a v2.

I confused myself.  This change is safe because ptrace_freeze_traced
fails if there is a pending fatal signal, and arranges that no new fatal
signals will wake up the task.

Eric

>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  kernel/ptrace.c | 14 +++-----------
>>  1 file changed, 3 insertions(+), 11 deletions(-)
>>
>> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
>> index 16d1a84a2cae..0634da7ac685 100644
>> --- a/kernel/ptrace.c
>> +++ b/kernel/ptrace.c
>> @@ -265,17 +265,9 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
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
>> +	    WARN_ON_ONCE(!wait_task_inactive(child, 0)))
>> +		ret = -ESRCH;
>>  
>>  	return ret;
>>  }
>
> Eric
