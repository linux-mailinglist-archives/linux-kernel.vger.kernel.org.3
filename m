Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5D053EC46
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbiFFQGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241596AbiFFQG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:06:26 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501551A04AD;
        Mon,  6 Jun 2022 09:06:25 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:51234)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nyFF4-003oNe-A8; Mon, 06 Jun 2022 10:06:10 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36080 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nyFF3-0064GU-5Q; Mon, 06 Jun 2022 10:06:09 -0600
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
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
        <20220518225355.784371-5-ebiederm@xmission.com>
        <20220524114250.GB14347@redhat.com> <20220525143303.GB2687@redhat.com>
Date:   Mon, 06 Jun 2022 11:06:01 -0500
In-Reply-To: <20220525143303.GB2687@redhat.com> (Oleg Nesterov's message of
        "Wed, 25 May 2022 16:33:03 +0200")
Message-ID: <87ee014w0m.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nyFF3-0064GU-5Q;;;mid=<87ee014w0m.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/bCD521uCeNyMK1sI9HAcjhaI84gTloTc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 544 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.6 (0.7%), b_tie_ro: 2.4 (0.4%), parse: 0.83
        (0.2%), extract_message_metadata: 2.8 (0.5%), get_uri_detail_list:
        1.39 (0.3%), tests_pri_-1000: 4.0 (0.7%), tests_pri_-950: 1.07 (0.2%),
        tests_pri_-900: 0.87 (0.2%), tests_pri_-90: 157 (28.9%), check_bayes:
        156 (28.6%), b_tokenize: 8 (1.5%), b_tok_get_all: 10 (1.8%),
        b_comp_prob: 2.1 (0.4%), b_tok_touch_all: 132 (24.3%), b_finish: 0.72
        (0.1%), tests_pri_0: 360 (66.2%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.78 (0.1%), tests_pri_10:
        1.79 (0.3%), tests_pri_500: 6 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 05/16] ptrace: Remove dead code from __ptrace_detach
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/24, Oleg Nesterov wrote:
>>
>> Sorry for delay.
>>
>> On 05/18, Eric W. Biederman wrote:
>> >
>> > Ever since commit 28d838cc4dfe ("Fix ptrace self-attach rule") it has
>> > been impossible to attach another thread in the same thread group.
>> >
>> > Remove the code from __ptrace_detach that was trying to support
>> > detaching from a thread in the same thread group.
>>
>> may be I am totally confused, but I think you misunderstood this code
>> and thus this patch is very wrong.
>>
>> The same_thread_group() check does NOT try to check if debugger and
>> tracee is in the same thread group, this is indeed impossible.
>>
>> We need this check to know if the tracee was ptrace_reparented() before
>> __ptrace_unlink() or not.
>>
>>
>> > -static int ignoring_children(struct sighand_struct *sigh)
>> > -{
>> > -	int ret;
>> > -	spin_lock(&sigh->siglock);
>> > -	ret = (sigh->action[SIGCHLD-1].sa.sa_handler == SIG_IGN) ||
>> > -	      (sigh->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT);
>> > -	spin_unlock(&sigh->siglock);
>> > -	return ret;
>> > -}
>>
>> ...
>>
>> > @@ -565,14 +552,9 @@ static bool __ptrace_detach(struct task_struct *tracer, struct task_struct *p)
>> >
>> >  	dead = !thread_group_leader(p);
>> >
>> > -	if (!dead && thread_group_empty(p)) {
>> > -		if (!same_thread_group(p->real_parent, tracer))
>> > -			dead = do_notify_parent(p, p->exit_signal);
>> > -		else if (ignoring_children(tracer->sighand)) {
>> > -			__wake_up_parent(p, tracer);
>> > -			dead = true;
>> > -		}
>> > -	}
>>
>> So the code above does:
>>
>> 	- if !same_thread_group(p->real_parent, tracer), then the tracee was
>> 	  ptrace_reparented(), and now we need to notify its natural parent
>> 	  to let it know it has a zombie child.
>>
>> 	- otherwise, the tracee is our natural child, and it is actually dead.
>> 	  however, since we are going to reap this task, we need to wake up our
>> 	  sub-threads possibly sleeping on ->wait_chldexit wait_queue_head_t.
>>
>> See?
>>
>> > +	if (!dead && thread_group_empty(p))
>> > +		dead = do_notify_parent(p, p->exit_signal);
>>
>> No, this looks wrong. Or I missed something?
>
> Yes, but...
>
> That said, it seems that we do not need __wake_up_parent() if it was our
> natural child?

Agreed on both counts.

Hmm.  I see where the logic comes from.  The ignoring_children test and
the __wake_up_parent are what do_notify_parent does when the parent
ignores children.  Hmm.  I even see all of this document in the comment
above __ptrace_detach.

So I am just going to drop this change.

> I'll recheck. Eric, I'll continue to read this series tomorrow, can't
> concentrate on ptrace today.

No worries.  This was entirely too close to the merge window so I
dropped it all until today.

Eric

