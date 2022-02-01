Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7314A6599
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiBAUWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:22:13 -0500
Received: from mail.efficios.com ([167.114.26.124]:44348 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbiBAUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:22:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 830A9348349;
        Tue,  1 Feb 2022 15:22:11 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id KY2d6z-Wntep; Tue,  1 Feb 2022 15:22:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id ECA35348346;
        Tue,  1 Feb 2022 15:22:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com ECA35348346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643746931;
        bh=v91rrTgNrdyWSt2/uNOesVvcG4ff1f/IjsdFmDxvw2I=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qXDonx4SjnLlO4MImf6cNmrj80Nwepd2KokiMjD/223eJJGtgq084HwGVdsTgQXGa
         KeGbbKsygZW0/JYwMvPZw+9uKunJ4KgD3JKudeh/qyPYWTin7SgsGL6AKUJDhb848N
         5oOfQw2j2zllCGbeROQLvVby6mavG/0o6cgkp+QQXnQhdRXTL3FRAXW7ZxPxQWso0/
         ysxBWfpwQ/U3zQaAXRVEPHZU1wPA5k470XdCNKrlvVadg5/mghxu3ncO+iTW2QheNo
         dKbNYKF+f3VK+ZxZBk9D1l9nrofznik1Cg2caQuG+WOviwImGwiym++YrbQpzNdK3Z
         3RetqtxLYa4CQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C06nrz-eLqu1; Tue,  1 Feb 2022 15:22:10 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D9D0F348063;
        Tue,  1 Feb 2022 15:22:10 -0500 (EST)
Date:   Tue, 1 Feb 2022 15:22:10 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Laight <David.Laight@ACULAB.COM>,
        carlos <carlos@redhat.com>, Peter Oskolkov <posk@posk.io>
Message-ID: <1075473571.25688.1643746930751.JavaMail.zimbra@efficios.com>
In-Reply-To: <87bkzqz75q.fsf@mid.deneb.enyo.de>
References: <20220201192540.10439-1-mathieu.desnoyers@efficios.com> <20220201192540.10439-2-mathieu.desnoyers@efficios.com> <87bkzqz75q.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH 2/3] rseq: extend struct rseq with per thread group
 vcpu id
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: rseq: extend struct rseq with per thread group vcpu id
Thread-Index: uYaG4pyeANMXZzoDJBt8q438TTkSZw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 1, 2022, at 3:03 PM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
>=20
>> If a thread group has fewer threads than cores, or is limited to run on
>> few cores concurrently through sched affinity or cgroup cpusets, the
>> virtual cpu ids will be values close to 0, thus allowing efficient use
>> of user-space memory for per-cpu data structures.
>=20
> From a userspace programmer perspective, what's a good way to obtain a
> reasonable upper bound for the possible tg_vcpu_id values?

Some effective upper bounds:

- sysconf(3) _SC_NPROCESSORS_CONF,
- the number of threads which exist concurrently in the process,
- the number of cpus in the cpu affinity mask applied by sched_setaffinity,
  except in corner-case situations such as cpu hotplug removing all cpus fr=
om
  the affinity set,
- cgroup cpuset "partition" limits,

Note that AFAIR non-partition cgroup cpusets allow a cgroup to "borrow"
additional cores from the rest of the system if they are idle, therefore
allowing the number of concurrent threads to go beyond the specified limit.

>=20
> I believe not all users of cgroup cpusets change the affinity mask.

AFAIR the sched affinity mask is tweaked independently of the cgroup cpuset=
.
Those are two mechanisms both affecting the scheduler task placement.

I would expect the user-space code to use some sensible upper bound as a
hint about how many per-vcpu data structure elements to expect (and how man=
y
to pre-allocate), but have a "lazy initialization" fall-back in case the
vcpu id goes up to the number of configured processors - 1. And I suspect
that even the number of configured processors may change with CRIU.

>=20
>> diff --git a/kernel/rseq.c b/kernel/rseq.c
>> index 13f6d0419f31..37b43735a400 100644
>> --- a/kernel/rseq.c
>> +++ b/kernel/rseq.c
>> @@ -86,10 +86,14 @@ static int rseq_update_cpu_node_id(struct task_struc=
t *t)
>>  =09struct rseq __user *rseq =3D t->rseq;
>>  =09u32 cpu_id =3D raw_smp_processor_id();
>>  =09u32 node_id =3D cpu_to_node(cpu_id);
>> +=09u32 tg_vcpu_id =3D task_tg_vcpu_id(t);
>> =20
>>  =09if (!user_write_access_begin(rseq, t->rseq_len))
>>  =09=09goto efault;
>>  =09switch (t->rseq_len) {
>> +=09case offsetofend(struct rseq, tg_vcpu_id):
>> +=09=09unsafe_put_user(tg_vcpu_id, &rseq->tg_vcpu_id, efault_end);
>> +=09=09fallthrough;
>>  =09case offsetofend(struct rseq, node_id):
>>  =09=09unsafe_put_user(node_id, &rseq->node_id, efault_end);
>>  =09=09fallthrough;
>=20
> Is the switch really useful?  I suspect it's faster to just write as
> much as possible all the time.  The switch should be well-predictable
> if running uniform userspace, but still =E2=80=A6

The switch ensures the kernel don't try to write to a memory area beyond
the rseq size which has been registered by user-space. So it seems to be
useful to ensure we don't corrupt user-space memory. Or am I missing your
point ?

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
