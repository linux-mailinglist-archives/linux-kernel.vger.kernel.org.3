Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D3F511AED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiD0Ovr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbiD0Oud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:50:33 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFA43B297;
        Wed, 27 Apr 2022 07:47:21 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:55074)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njiwo-00H7U3-OG; Wed, 27 Apr 2022 08:47:18 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35882 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njiwn-00AnmM-Hj; Wed, 27 Apr 2022 08:47:18 -0600
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
        <20220426225211.308418-6-ebiederm@xmission.com>
        <20220427141018.GA17421@redhat.com>
        <874k2ea9q4.fsf@email.froward.int.ebiederm.org>
Date:   Wed, 27 Apr 2022 09:47:10 -0500
In-Reply-To: <874k2ea9q4.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 27 Apr 2022 09:20:51 -0500")
Message-ID: <87zgk67fdd.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njiwn-00AnmM-Hj;;;mid=<87zgk67fdd.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/9mpdQTyplIkPxPVrXFUt3r9iizls3AWY=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 575 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.9%), b_tie_ro: 10 (1.7%), parse: 0.96
        (0.2%), extract_message_metadata: 12 (2.1%), get_uri_detail_list: 1.46
        (0.3%), tests_pri_-1000: 14 (2.4%), tests_pri_-950: 1.24 (0.2%),
        tests_pri_-900: 1.04 (0.2%), tests_pri_-90: 133 (23.2%), check_bayes:
        132 (22.9%), b_tokenize: 8 (1.4%), b_tok_get_all: 9 (1.5%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 108 (18.8%), b_finish: 1.03
        (0.2%), tests_pri_0: 381 (66.4%), check_dkim_signature: 0.85 (0.1%),
        check_dkim_adsp: 3.4 (0.6%), poll_dns_idle: 0.87 (0.2%), tests_pri_10:
        2.5 (0.4%), tests_pri_500: 15 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with
 siglock held
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Oleg Nesterov <oleg@redhat.com> writes:
>
>> On 04/26, Eric W. Biederman wrote:
>>>
>>> @@ -2164,7 +2166,9 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
>>>   	}
>>>
>>>  	sighand = parent->sighand;
>>> -	spin_lock_irqsave(&sighand->siglock, flags);
>>> +	lock = tsk->sighand != sighand;
>>> +	if (lock)
>>> +		spin_lock_nested(&sighand->siglock, SINGLE_DEPTH_NESTING);
>>
>> But why is it safe?
>>
>> Suppose we have two tasks, they both trace each other, both call
>> ptrace_stop() at the same time. Of course this is ugly, they both
>> will block.
>>
>> But with this patch in this case we have the trivial ABBA deadlock,
>> no?
>
> I was thinking in terms of the process tree (which is fine).
>
> The ptrace parental relationship definitely has the potential to be a
> graph with cycles.  Which as you point out is not fine.
>
>
> The result is very nice and I don't want to give it up.  I suspect
> something ptrace cycles are always a problem and can simply be
> forbidden.  That is going to take some analsysis and some additional
> code in ptrace_attach.
>
> I will go look at that.


Hmm.  If we have the following process tree.

    A
     \
      B
       \
        C

Process A, B, and C are all in the same process group.
Process A and B are setup to receive SIGCHILD when
their process stops.

Process C traces process A.

When a sigstop is delivered to the group we can have:

Process B takes siglock(B) siglock(A) to notify the real_parent
Process C takes siglock(C) siglock(B) to notify the real_parent
Process A takes siglock(A) siglock(C) to notify the tracer

If they all take their local lock at the same time there is
a deadlock.

I don't think the restriction that you can never ptrace anyone
up the process tree is going to fly.  So it looks like I am back to the
drawing board for this one.

Eric




    


