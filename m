Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD34474C98
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 21:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhLNUZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 15:25:22 -0500
Received: from mail.efficios.com ([167.114.26.124]:60700 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhLNUZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 15:25:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B83CA34EE98;
        Tue, 14 Dec 2021 15:25:20 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2cTWMtLKEehL; Tue, 14 Dec 2021 15:25:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A365E34EE97;
        Tue, 14 Dec 2021 15:25:19 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A365E34EE97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1639513519;
        bh=EN9QJ0nPlbVJaVN6WrjKIkBRkDZmdee9KR1q+jYVPuY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qiDlOe5xBon6dDRdsmuQA1afbR8EAY1Ps9u7Woq1MjFYuOyx4cP3IQ1Zz60lmfDqd
         X+4UbqSCIZBDPuHcl1nbdA9XbvcxiWhwnM2Kb/b3J83x0YTN1BFgEAU7oULR5m3d1G
         E8TG8U5IUK2TnQxFEr9vu43QJNsfemBVndYoVJM2YMyDFyhOzV0x4yYD1yQmJ2xxV+
         OWZbX1u9WsuVTkDA52UilKV0VblQ5kA1K7qs/SmLYrHLZpEN8nfcC8YOzqE6zxFeNH
         UeCv6JNZdA5QbcqoSKZKyEPlbga37srdWCD+85qkvNSqEnY4FGksr5/XdOPJPc7P3q
         GyIfKAMr8ULpQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id segzmSQm-96I; Tue, 14 Dec 2021 15:25:19 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 88C6D34EDB1;
        Tue, 14 Dec 2021 15:25:19 -0500 (EST)
Date:   Tue, 14 Dec 2021 15:25:19 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-api <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>
Message-ID: <1237737244.31756.1639513519417.JavaMail.zimbra@efficios.com>
In-Reply-To: <87bl1ktgbn.fsf@oldenburg.str.redhat.com>
References: <87tufctk82.fsf@oldenburg.str.redhat.com> <697825714.30478.1639423180784.JavaMail.zimbra@efficios.com> <87ilvstia9.fsf@oldenburg.str.redhat.com> <1424606270.30586.1639425414221.JavaMail.zimbra@efficios.com> <87bl1ktgbn.fsf@oldenburg.str.redhat.com>
Subject: Re: rseq + membarrier programming model
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4173 (ZimbraWebClient - FF94 (Linux)/8.8.15_GA_4177)
Thread-Topic: rseq + membarrier programming model
Thread-Index: ZkW7VafUwWlLqq9O+7HGhrw/1k6QZg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Dec 13, 2021, at 3:12 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
>=20
>> ----- On Dec 13, 2021, at 2:29 PM, Florian Weimer fweimer@redhat.com wro=
te:
>>
>>> * Mathieu Desnoyers:
>>>=20
>>>>> Could it fall back to
>>>>> MEMBARRIER_CMD_GLOBAL instead?
>>>>
>>>> No. CMD_GLOBAL does not issue the required rseq fence used by the
>>>> algorithm discussed. Also, CMD_GLOBAL has quite a few other shortcomin=
gs:
>>>> it takes a while to execute, and is incompatible with nohz_full kernel=
s.
>>>=20
>>> What about using sched_setcpu to move the current thread to the same CP=
U
>>> (and move it back afterwards)?  Surely that implies the required sort o=
f
>>> rseq barrier that MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ with
>>> MEMBARRIER_CMD_FLAG_CPU performs?
>>
>> I guess you refer to using sched_setaffinity(2) there ? There are variou=
s
>> reasons why this may fail. For one, the affinity mask is a shared global
>> resource which can be changed by external applications.
>=20
> So is process memory =E2=80=A6

Fair point.

>=20
>> Also, setting the affinity is really just a hint. In the presence of
>> cpu hotplug and or cgroup cpuset, it is known to lead to situations
>> where the kernel just gives up and provides an affinity mask including
>> all CPUs.
>=20
> How does CPU hotplug impact this negatively?

It may be OK for the rseq fence use-case specifically, but in general
relying on cpu affinity to "pin" to a specific CPU is problematic with
a hotplug scenario like this:

- Userspace thread sets affinity to CPU 3 (only)
- echo 0 > /sys/devices/system/cpu/cpu3/online  (as root)

-> scheduler will hit:

select_fallback_rq():
                        if (cpuset_cpus_allowed_fallback(p)) { -> false
                                             do_set_cpus_allowed(p, task_cp=
u_possible_mask(p));

thus setting the cpus allowed mask to "any of the possible cpus".

This can be confirmed by doing "cat /proc/${pid}/status | grep Cpus_allowed=
_list:"
before/after unplugging cpu 3. (side-note: in my test, the target applicati=
on was
"sleep 5000", which never gets picked by the scheduler unless we force some=
 activity
on it by delivering a signal. I used a SIGSTOP/SIGCONT.):

before:
Cpus_allowed_list:=093

after:
Cpus_allowed_list:=090-3

>=20
> The cgroup cpuset issue clearly is a bug.

For cgroupv2, there are cpuset.cpus (invariant wrt hotplug),
cpuset.cpus.effective (affected by hotplug) and cpuset.cpus.partition
(takes away from parent effective cpuset, invariant after creation).
cgroup controllers can be either threaded controllers or domain
controllers. Unfortunately cpuset is a threaded controller, which
means each thread can have its own cgroup cpuset.

I do not have a full understanding of the interaction between
sched_setaffinity and concurrent changes to the cgroup cpuset,
but I am concerned that scenarios where affinity is first "pinned"
to a specific cpu, and then an external process manager changes the
cpuset.cpus mask to exclude that cpu may cause issues.

I am also concerned for the rseq fence use-case (done with explicit
sched_setaffinity) about what would happen if threads belong to
different cgroup cpusets with threaded controllers. There we may
have situations where a thread fails to run on a specific CPU just
because it is not part of its cpuset, but another thread within the
same process successfully runs there while executing an rseq critical
section.

>=20
>> Therefore, using sched_setaffinity() and expecting to be pinned to
>> a specific CPU for correctness purposes seems brittle.
>=20
> I'm pretty sure it used to work reliably for some forms of concurrency
> control.

That being said, it may be OK for the specific case of an rseq-fence, consi=
dering
that if we affine to CPU A, and later discover that we run anywhere except =
on
CPU A while we explicitly requested to be pinned to that CPU, this means th=
e
kernel had to take action and move us away from CPU A's runqueue because we
are not allowed to run there. So we could consider that this CPU is "quiesc=
ent"
in terms of rseq because no other thread belonging to our process runs ther=
e.
This appears to work only for cpusets applying to the entire process though=
,
not for threaded cpusets.

>=20
>> But _if_ we'd have something like a sched_setaffinity which we can
>> trust, yes, temporarily migrating to the target CPU, and observing that
>> we indeed run there, would AFAIU provide the same guarantee as the rseq
>> fence provided by membarrier. It would have a higher overhead than
>> membarrier as well.
>=20
> Presumably a signal could do it as well.

Fair point, but then you would have to send a signal to every thread, and
wait for each signal handler to have executed. membarrier improves on this
kind of scheme by integrating with the scheduler, and leverage its knowledg=
e
of which thread is actively running or not. Therefore, if a thread is not
running, there is no need to awaken it. This makes a huge performance
difference for heavily multi-threaded applications.

>=20
>>> That is possible even without membarrier, so I wonder why registration
>>> of intent is needed for MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
>>
>> I would answer that it is not possible to do this _reliably_ today
>> without membarrier (see above discussion of cpu hotplug, cgroups, and
>> modification of cpu affinity by external processes).
>>
>> AFAIR, registration of intent for MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
>> is mainly there to provide a programming model similar to private expedi=
ted
>> plain and core-sync cmds.
>>
>> The registration of intent allows the kernel to further tweak what is
>> done internally and make tradeoffs which only impact applications
>> performing the registration.
>=20
> But if there is no strong performance argument to do so, this introduces
> additional complexity into userspace.  Surely we could say we just do
> MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ at process start and document
> failure (in case of seccomp etc.), but then why do this at all?

There are many performance gains we can get by having membarrier-expedited-=
rseq
registered. Some of those use-cases may be doable either by sending signals
to all threads, or by doing cpu affinity tricks, but using membarrier
is much more lightweight thanks to its integration with the Linux
scheduler. When a thread is not running, there is really no need to awaken
it.

In terms of use-cases, the rseq-fence is a compelling use-case enabling
various algorithms with rseq.

Other use-cases involve the "plain" memory barrier capabilities of membarri=
er.
This generally allow turning algorithms that require pairing memory
barrier instructions on fast and slow paths into even faster fast-path,
by pairing compiler barriers (asm memory clobber) on the fast paths
with membarrier system calls on the slow paths.

Finally, other use-cases involves the SYNC_CORE membarrier. This is mainly
for JITs, allowing them to issue a process-wide "fence" allowing them to
re-use memory after reclaim of JITted code.

In terms of overhead added into the process when membarrier-expedited
is registered, only specific cases are affected:

- SYNC_CORE: processes which have registered membarrier expedited sync-core
  will issue sync_core_before_usermode() after each scheduling between
  threads belonging to different processes (see membarrier_mm_sync_core_bef=
ore_usermode).
  It is a no-op for all architectures except x86, which implements its
  return to user-space with sysexit, sysrel and sysretq, which are not core
  serializing.

  Because of the runtime overhead of the sync-core registration on x86,
  I would recommend that only JITs register with
  MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE.

- Plain memory barrier and RSEQ: Registering those adds no overhead except
  on powerpc (see membarrier_arch_switch_mm). There, when context switching
  between two user-space processes, an additional memory barrier is needed
  because it is not implicitly issued by the architecture switch_mm.

  I expect that the impact of this runtime overhead will be much more
  limited than for the SYNC_CORE. Therefore having glibc auto-register
  MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ would make sense
  considering the fast-path improvements this enables.

All of the expedited membarrier commands issue inter-processor interrupts
(IPIs) to CPUs running threads belonging to the same process. This may be
unexpected for hard-real-time applications, so this may be something they
will want to opt-out from with a tunable.

There are also the "global-expedited" membarrier commands, which are
done to deal with shared memory across processes. There, the processes
wishing to receive the IPIs need to be registered explicitly. This
ensures we don't disrupt other hard-real-time processes with unexpected
IPIs. The processes registered for global-expedited membarrier also have
the same overhead discussed above for plain/rseq membarrier registration
on powerpc. I do not expect the global-expedited registration to be done
automatically, it should really be opt-in by the applications/libraries
requiring membarrier to interact with other processes across shared memory.

>=20
>>>> In order to make sure the programming model is the same for expedited
>>>> private/global plain/sync-core/rseq membarrier commands, we require th=
at
>>>> each process perform a registration beforehand.
>>>=20
>>> Hmm.  At least it's not possible to unregister again.
>>>=20
>>> But I think it would be really useful to have some of these barriers
>>> available without registration, possibly in a more expensive form.
>>
>> What would be wrong with doing a membarrier private-expedited-rseq
>> registration on libc startup, and exposing a glibc tunable to allow
>> disabling this ?
>=20
> The configurations that need to be supported go from =E2=80=9Cno rseq=E2=
=80=9C/=E2=80=9Crseq=E2=80=9D
> to =E2=80=9Cno rseq=E2=80=9C/=E2=80=9Crseq=E2=80=9D/=E2=80=9Crseq with me=
mbarrier=E2=80=9D.  Everyone now needs to
> think about implementing support for all three instead just the obvious
> two.

One thing to keep in mind is that within the Linux kernel, CONFIG_RSEQ
always selects CONFIG_MEMBARRIER. I've done this on purpose to simplify
the user-space programming model. Therefore, if the rseq system call is
implemented, membarrier is available, unless it's forbidden by seccomp.

However, MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ only appears in kernel v5.10=
.

This means that starting from kernel v5.10, glibc can rely on having
both rseq and membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ available,
or don't bother to do any of the registration.

This would simplify the programming model from a user perspective. If
glibc registers rseq, this guarantees that
MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ is available.

You can check for rseq availability with e.g.:

int rseq_available(void)
{
        int rc;

        rc =3D sys_rseq(NULL, 0, 0, 0);
        if (rc !=3D -1)
                abort();
        switch (errno) {
        case ENOSYS:
                return 0;
        case EINVAL:
                return 1;
        default:
                abort();
        }
}

and check for membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ availability
by inspecting the mask returned by MEMBARRIER_CMD_QUERY, e.g.:

int status;

status =3D sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
if (status < 0 || !(status & MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ))
        return false;
else
        return true;

I guess it all depends on how much you care about registering rseq on
kernels between 4.18 and 5.9 inclusively.

Thanks,

Mathieu


>=20
> Thanks,
> Florian

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
