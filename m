Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E994A71EF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344444AbiBBNsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:48:53 -0500
Received: from mail.efficios.com ([167.114.26.124]:39952 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiBBNsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:48:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 76F2034F3DA;
        Wed,  2 Feb 2022 08:48:52 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cqdK2jswhzmF; Wed,  2 Feb 2022 08:48:51 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B97F734F4E0;
        Wed,  2 Feb 2022 08:48:51 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B97F734F4E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643809731;
        bh=VQmEXGRQQIxzpVJ3876L2AMeTU75MjY0bPrjRl6cGwE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=F889MTHQl7N/Rl9ZKzoYcNwkiBv4niYRAOnn/BDD+wA2A7SloHaYNlK38A2susBGO
         DHTIE5iziNt4pGtoHsIn68RFXqIvkQt56rEqHC607KtBmGZMaL5y8A9nW0U9jeojha
         ABEc6DWL3Mh5xMrYAyaH4a8pIoGiQSEC1KSR5TQzlWxBL5zJ72awB/RRUbHZJm/A6b
         RDp36Yh+XkzulKyoxxNGV7Dsz0WkWZDUdGPNuNaUIex8TKGLTe3BPEGBMB48vgBnl9
         2Py1h7gRtvy6JRNAg3vgR7uDuPk43+ucrAzt9w0J1IDLvANkiuDP4dDuqcC51BnSrw
         QPDcAGP52HbvA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0HZQSn_vItm0; Wed,  2 Feb 2022 08:48:51 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A5D6434F454;
        Wed,  2 Feb 2022 08:48:51 -0500 (EST)
Date:   Wed, 2 Feb 2022 08:48:51 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@ACULAB.COM>,
        carlos <carlos@redhat.com>, Peter Oskolkov <posk@posk.io>
Message-ID: <465039213.27161.1643809731530.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220202112343.GZ20638@worktop.programming.kicks-ass.net>
References: <20220201192540.10439-1-mathieu.desnoyers@efficios.com> <20220202112343.GZ20638@worktop.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 1/3] Introduce per thread group current virtual cpu
 id
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: Introduce per thread group current virtual cpu id
Thread-Index: yKlWk+fUpMMdDPyl2WKE2U6dJjx55g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 2, 2022, at 6:23 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Feb 01, 2022 at 02:25:38PM -0500, Mathieu Desnoyers wrote:
> 
>> +static inline void tg_vcpu_get(struct task_struct *t)
>> +{
>> +	struct cpumask *cpumask = &t->signal->vcpu_mask;
>> +	unsigned int vcpu;
>> +
>> +	if (t->flags & PF_KTHREAD)
>> +		return;
>> +	/* Atomically reserve lowest available vcpu number. */
>> +	do {
>> +		vcpu = cpumask_first_zero(cpumask);
>> +		WARN_ON_ONCE(vcpu >= nr_cpu_ids);
>> +	} while (cpumask_test_and_set_cpu(vcpu, cpumask));
>> +	t->tg_vcpu = vcpu;
>> +}
>> +
>> +static inline void tg_vcpu_put(struct task_struct *t)
>> +{
>> +	if (t->flags & PF_KTHREAD)
>> +		return;
>> +	cpumask_clear_cpu(t->tg_vcpu, &t->signal->vcpu_mask);
>> +	t->tg_vcpu = 0;
>> +}
> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 2e4ae00e52d1..2690e80977b1 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4795,6 +4795,8 @@ prepare_task_switch(struct rq *rq, struct task_struct
>> *prev,
>>  	sched_info_switch(rq, prev, next);
>>  	perf_event_task_sched_out(prev, next);
>>  	rseq_preempt(prev);
>> +	tg_vcpu_put(prev);
>> +	tg_vcpu_get(next);
> 
> 
> URGGHHH!!! that's *2* atomics extra on the context switch path. Worse,
> that's on a line that's trivially contended with a few threads.

There is one obvious optimization that just begs to be done here: when
switching between threads belonging to the same process, we can simply
take the vcpu_id tag of the prev thread and use it for next,
without requiring any atomic operation.

This only leaves the overhead of added atomics when scheduling between
threads which belong to different processes. Does it matter as much ?
If it's the case, then we should really scratch our heads a little more
to come up with improvements.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
