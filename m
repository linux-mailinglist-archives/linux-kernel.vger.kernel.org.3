Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790015124E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbiD0WBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237763AbiD0WBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:01:05 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762ED21A1;
        Wed, 27 Apr 2022 14:57:51 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:57788)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njpfP-0010l2-WF; Wed, 27 Apr 2022 15:57:48 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35986 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njpfO-00BQOO-4X; Wed, 27 Apr 2022 15:57:47 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <20220427155335.GH17421@redhat.com>
Date:   Wed, 27 Apr 2022 16:57:39 -0500
In-Reply-To: <20220427155335.GH17421@redhat.com> (Oleg Nesterov's message of
        "Wed, 27 Apr 2022 17:53:37 +0200")
Message-ID: <87sfpy42b0.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njpfO-00BQOO-4X;;;mid=<87sfpy42b0.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX181KTp4kKYFA1nut2sJgRrZ1wCAbW/YUAA=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1330 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (0.9%), b_tie_ro: 10 (0.8%), parse: 1.05
        (0.1%), extract_message_metadata: 3.3 (0.2%), get_uri_detail_list:
        1.00 (0.1%), tests_pri_-1000: 4.1 (0.3%), tests_pri_-950: 1.35 (0.1%),
        tests_pri_-900: 1.09 (0.1%), tests_pri_-90: 87 (6.6%), check_bayes: 86
        (6.4%), b_tokenize: 6 (0.4%), b_tok_get_all: 5 (0.4%), b_comp_prob:
        2.0 (0.2%), b_tok_touch_all: 69 (5.2%), b_finish: 1.04 (0.1%),
        tests_pri_0: 1195 (89.9%), check_dkim_signature: 0.56 (0.0%),
        check_dkim_adsp: 2.9 (0.2%), poll_dns_idle: 1.07 (0.1%), tests_pri_10:
        3.1 (0.2%), tests_pri_500: 12 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/21, Peter Zijlstra wrote:
>>
>> @@ -1329,8 +1337,7 @@ SYSCALL_DEFINE4(ptrace, long, request, l
>>  		goto out_put_task_struct;
>>  
>>  	ret = arch_ptrace(child, request, addr, data);
>> -	if (ret || request != PTRACE_DETACH)
>> -		ptrace_unfreeze_traced(child);
>> +	ptrace_unfreeze_traced(child);
>
> Forgot to mention... whatever we do this doesn't look right.
>
> ptrace_unfreeze_traced() must not be called if the tracee was untraced,
> anothet debugger can come after that. I agree, the current code looks
> a bit confusing, perhaps it makes sense to re-write it:
>
> 	if (request == PTRACE_DETACH && ret == 0)
> 		; /* nothing to do, no longer traced by us */
> 	else
> 		ptrace_unfreeze_traced(child);

This was a bug in my original JOBCTL_DELAY_WAITKILL patch and it was
just cut and pasted here.  I thought it made sense when I was throwing
things together but when I looked more closely I realized that it is
not safe.

Eric

