Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D44B5683A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiGFJ3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiGFJ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:29:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B977A19019;
        Wed,  6 Jul 2022 02:29:49 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2669M5Bl024266;
        Wed, 6 Jul 2022 09:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=4Ga+nF4w4JO51ZrnLlGoa4bde4/pmt4umLCIL/JaSJU=;
 b=PIe1tto+fDqJiRyKPjG2s2UKBqQO3kAUz1ql9+sKKMVFGi0uTLoM1oaVlFqTBn4Lf1Cs
 dQB1mCmTwrOqfWwbirixVmLJgqAhgsz88NhQfKYqjE9FRjvtpYeTf8dGhE0PIOZ7ZHr1
 rFNMytTMJ+dCor4jrQSN+IU/uShCe1Hcx8tbUB9/7ehJgeC64wuShkJpkLbWTgFYaOL5
 JyL/75UAXFRWj1dlWkJuYArXoRxZW3fb3HzWt0StRThYtj2t926I0WAougBs/SzHnsmJ
 cAF00BEyiZ+MKcOkljba8x+EX01eTOeP5ByArxWuB+DbhVNL7pHxjojVTwuKR1efyD9j Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5464wp0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 09:27:12 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2669MLPf024840;
        Wed, 6 Jul 2022 09:27:11 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5464wnyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 09:27:11 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2669L225012779;
        Wed, 6 Jul 2022 09:27:08 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3h4v658hx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 09:27:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2669RFCd33358304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jul 2022 09:27:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 236B252050;
        Wed,  6 Jul 2022 09:27:06 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 8279E5204F;
        Wed,  6 Jul 2022 09:27:05 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <20220505182645.497868-12-ebiederm@xmission.com>
        <YrHA5UkJLornOdCz@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
        <877d5ajesi.fsf@email.froward.int.ebiederm.org>
        <YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
        <20220628191541.34a073fc@gandalf.local.home>
        <yt9d5ykbekn3.fsf@linux.ibm.com> <yt9dpmijcvu6.fsf@linux.ibm.com>
        <YsSQRmCZSIQ1ewzo@worktop.programming.kicks-ass.net>
        <yt9dsfneaczk.fsf@linux.ibm.com>
        <YsVO1NU3bXGg9YJ3@worktop.programming.kicks-ass.net>
Date:   Wed, 06 Jul 2022 11:27:05 +0200
In-Reply-To: <YsVO1NU3bXGg9YJ3@worktop.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Wed, 6 Jul 2022 10:59:00 +0200")
Message-ID: <yt9da69ma8wm.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Mb_6lVVWEFuOxehTnzJHr3IRGoQCZpsx
X-Proofpoint-ORIG-GUID: HYEd6JvoTIzmrj3QGMiPayK2cDR6gwIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_05,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Jul 06, 2022 at 09:58:55AM +0200, Sven Schnelle wrote:
>
>> >> [   86.218551] kill_chi-343805    6d.... 79990141us : ptrace_stop: JOBCTL_TRACED already set, state=0 <------ valid combination of flags?
>> >
>> > Yeah, that's not supposed to be so. JOBCTL_TRACED is supposed to follow
>> > __TASK_TRACED for now. Set when __TASK_TRACED, cleared when
>> > TASK_RUNNING.
>> >
>> > Specifically {ptrace_,}signal_wake_up() in signal.h clear JOBCTL_TRACED
>> > when they would wake a __TASK_TRACED task.
>> 
>> try_to_wake_up() clears TASK_TRACED in this case because a signal
>> (SIGKILL) has to be delivered. As a test I put the following change
>> on top, and it "fixes" the problem:
>> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index da0bf6fe9ecd..f2e0f5e70e77 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4141,6 +4149,9 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>>          * TASK_WAKING such that we can unlock p->pi_lock before doing the
>>          * enqueue, such as ttwu_queue_wakelist().
>>          */
>> +       if (p->__state & TASK_TRACED)
>> +               trace_printk("clearing TASK_TRACED 2\n");
>> +       p->jobctl &= ~JOBCTL_TRACED;
>>         WRITE_ONCE(p->__state, TASK_WAKING);
>> 
>>         /*
>> 
>> There are several places where the state is changed from TASK_TRACED to
>> something else without clearing JOBCTL_TRACED.
>
> I'm having difficulty spotting them; I find:
>
> TASK_WAKEKILL: signal_wake_up()
> __TASK_TRACED: ptrace_signal_wake_up(), ptrace_unfreeze_traced(), ptrace_resume()
>
> And all those sites dutifully clear JOBCTL_TRACED.
>
> I'd be most interested in the calstack for the 'clearing TASK_TRACED 2'
> events to see where we miss a spot.

The calltrace is:
[    9.863613] Call Trace:
[    9.863616]  [<00000000d3105f0e>] try_to_wake_up+0xae/0x620
[    9.863620] ([<00000000d3106164>] try_to_wake_up+0x304/0x620)
[    9.863623]  [<00000000d30d1e46>] ptrace_unfreeze_traced+0x9e/0xa8
[    9.863629]  [<00000000d30d2ef0>] __s390x_sys_ptrace+0xc0/0x160
[    9.863633]  [<00000000d3c5d8f4>] __do_syscall+0x1d4/0x200
[    9.863678]  [<00000000d3c6c332>] system_call+0x82/0xb0
[    9.863685] Last Breaking-Event-Address:
[    9.863686]  [<00000000d3106176>] try_to_wake_up+0x316/0x620
[    9.863688] ---[ end trace 0000000000000000 ]---

ptrace_unfreeze_traced() is:

static void ptrace_unfreeze_traced(struct task_struct *task)
{
        unsigned long flags;

        /*
         * The child may be awake and may have cleared
         * JOBCTL_PTRACE_FROZEN (see ptrace_resume).  The child will
         * not set JOBCTL_PTRACE_FROZEN or enter __TASK_TRACED anew.
         */
        if (lock_task_sighand(task, &flags)) {
                task->jobctl &= ~JOBCTL_PTRACE_FROZEN;
                if (__fatal_signal_pending(task)) {
                        task->jobctl &= ~TASK_TRACED;

Looking at this, shouldn't the line above read task->jobctl &= ~JOBCTL_TRACED?

                        wake_up_state(task, __TASK_TRACED);
                }
                unlock_task_sighand(task, &flags);
        }
}
