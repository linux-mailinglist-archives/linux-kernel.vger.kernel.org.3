Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E85C513CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 22:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351917AbiD1Uw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 16:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiD1Uw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 16:52:58 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6D6C0D35;
        Thu, 28 Apr 2022 13:49:42 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:50108)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkB51-00GPjo-1R; Thu, 28 Apr 2022 14:49:39 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36210 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkB4z-00H69k-Dg; Thu, 28 Apr 2022 14:49:38 -0600
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
        <8735hxxddw.fsf@email.froward.int.ebiederm.org>
Date:   Thu, 28 Apr 2022 15:49:11 -0500
In-Reply-To: <8735hxxddw.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Thu, 28 Apr 2022 13:37:47 -0500")
Message-ID: <87ilqtvsqg.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nkB4z-00H69k-Dg;;;mid=<87ilqtvsqg.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18FsIJPS4HixtOCLuAhCgdZZJJtBZvrxxg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 495 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (0.8%), b_tie_ro: 2.6 (0.5%), parse: 0.81
        (0.2%), extract_message_metadata: 11 (2.3%), get_uri_detail_list: 1.92
        (0.4%), tests_pri_-1000: 19 (3.9%), tests_pri_-950: 1.02 (0.2%),
        tests_pri_-900: 0.85 (0.2%), tests_pri_-90: 67 (13.4%), check_bayes:
        65 (13.2%), b_tokenize: 8 (1.6%), b_tok_get_all: 6 (1.3%),
        b_comp_prob: 1.95 (0.4%), b_tok_touch_all: 46 (9.2%), b_finish: 0.69
        (0.1%), tests_pri_0: 381 (77.0%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.98 (0.2%), tests_pri_10:
        1.76 (0.4%), tests_pri_500: 6 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with
 siglock held
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Peter Zijlstra <peterz@infradead.org> writes:
>
>> On Wed, Apr 27, 2022 at 09:47:10AM -0500, Eric W. Biederman wrote:
>>
>>> Hmm.  If we have the following process tree.
>>> 
>>>     A
>>>      \
>>>       B
>>>        \
>>>         C
>>> 
>>> Process A, B, and C are all in the same process group.
>>> Process A and B are setup to receive SIGCHILD when
>>> their process stops.
>>> 
>>> Process C traces process A.
>>> 
>>> When a sigstop is delivered to the group we can have:
>>> 
>>> Process B takes siglock(B) siglock(A) to notify the real_parent
>>> Process C takes siglock(C) siglock(B) to notify the real_parent
>>> Process A takes siglock(A) siglock(C) to notify the tracer
>>> 
>>> If they all take their local lock at the same time there is
>>> a deadlock.
>>> 
>>> I don't think the restriction that you can never ptrace anyone
>>> up the process tree is going to fly.  So it looks like I am back to the
>>> drawing board for this one.
>>
>> I've not had time to fully appreciate the nested locking here, but if it
>> is possible to rework things to always take both locks at the same time,
>> then it would be possible to impose an arbitrary lock order on things
>> and break the cycle that way.
>>
>> That is, simply order the locks by their heap address or something:
>>
>> static void double_siglock_irq(struct sighand *sh1, struct sighand2 *sh2)
>> {
>> 	if (sh1 > sh2)
>> 		swap(sh1, sh2)
>>
>> 	spin_lock_irq(&sh1->siglock);
>> 	spin_lock_nested(&sh2->siglock, SINGLE_DEPTH_NESTING);
>> }
>
> You know it might be.  Especially given that the existing code is
> already dropping siglock and grabbing tasklist_lock.
>
> It would take a potentially triple lock function to lock
> the task it's real_parent and it's tracer (aka parent).
>
> That makes this possible to consider is that notifying the ``parents''
> is a fundamental part of the operation so we know we are going to
> need the lock so we can move it up.
>
> Throw in a pinch of lock_task_sighand and the triple lock function
> gets quite interesting.
>
> It is certainly worth trying, and I will.

To my surprise it doesn't look too bad.  The locking simplifications and
not using a lock as big as tasklist_lock probably make it even worth
doing.

I need to sleep on it and look at everything again.  In the
meantime here is my function that comes in with siglock held,
possibly drops it, and grabs the other two locks all in
order.

static void lock_parents_siglocks(bool lock_tracer)
	__releases(&current->sighand->siglock)
	__acquires(&current->sighand->siglock)
	__acquires(&current->real_parent->sighand->siglock)
	__acquires(&current->parent->sighand->siglock)
{
	struct task_struct *me = current;
	struct sighand_struct *m_sighand = me->sighand;

	lockdep_assert_held(&m_sighand->siglock);

	rcu_read_lock();
	for (;;) {
		struct task_struct *parent, *tracer;
		struct sighand_struct *p_sighand, *t_sighand, *s1, *s2, *s3;

		parent = me->real_parent;
		tracer = lock_tracer? me->parent : parent;

		p_sighand = rcu_dereference(parent->sighand);
		t_sighand = rcu_dereference(tracer->sighand);

		/* Sort the sighands so that s1 >= s2 >= s3 */
		s1 = m_sighand;
		s2 = p_sighand;
		s3 = t_sighand;
		if (s1 > s2)
			swap(s1, s2);
		if (s1 > s3)
			swap(s1, s3);
		if (s2 > s3)
			swap(s2, s3);

		if (s1 != m_sighand) {
			spin_unlock(&m_sighand->siglock);
			spin_lock(&s1->siglock);
		}

		if (s1 != s2)
			spin_lock_nested(&s2->siglock, SIGLOCK_LOCK_SECOND);
		if (s2 != s3)
			spin_lock_nested(&s3->siglock, SIGLOCK_LOCK_THIRD);

		if (likely((me->real_parent == parent) &&
			   (me->parent == tracer) &&
			   (parent->sighand == p_sighand) &&
			   (tracer->sighand == t_sighand))) {
			break;
		}
		spin_unlock(&p_sighand->siglock);
                if (t_sighand != p_sighand)
			spin_unlock(&t_sighand->siglock);
		continue;
	}
	rcu_read_unlock();
}

Eric
