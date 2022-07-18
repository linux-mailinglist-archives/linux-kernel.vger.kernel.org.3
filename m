Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BA45785D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiGROvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiGROvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:51:49 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767C2167C8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:51:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 16F124236CE;
        Mon, 18 Jul 2022 10:51:45 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HDNqdZxSNBJq; Mon, 18 Jul 2022 10:51:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C9BA54235D3;
        Mon, 18 Jul 2022 10:51:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C9BA54235D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1658155903;
        bh=6wc4jDdr/nRGR4CnyuxVut1gitBpW68DftKLdpT/Vyg=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=bT+SRkFWlOsWyht0kjECRWMIurxz72ePYkXl6Hi+0RdL1Yjx7RkuPOZImZj3yeUj+
         qQTClZBsRe6luHO5agHZRarKRDyJE3ilO2/yXIxzuCQZv5sU08oLjae0oEj9pT2mco
         eBJOj7bn+vPbiv+qz00eE+WfTrhyLq2gulTi3q2KNNEfxTX8A9RsxMx/K9H7qspJG/
         k5Rqe3T0hmp43JMw32yU2QMcyrflj0G8QNSY+nexkEJ+CfYwoxE7z4HK7JEnjRkT93
         fs6RHS2U0nekRl1uK/qX+pZALOHFCb7BWxinurtUb5smf2IrelXffTMsKEdzIUMRQl
         KQo6gpY0vNMYQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G2k2I5Vs2UUZ; Mon, 18 Jul 2022 10:51:43 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 67A6C42315B;
        Mon, 18 Jul 2022 10:51:43 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Michael Jeanson <mjeanson@efficios.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH] arm: i.MX6 Cortex-A9: Fix memory ordering inconsistency by disabling prefetch instructions
Date:   Mon, 18 Jul 2022 10:51:50 -0400
Message-Id: <20220718145150.3344778-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Observed issue
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

On a Wandboard i.MX6 Quad Board revD1 (Cortex-A9 r2p10), spurious hangs
have been experienced in sys_futex in a few scenarios with liburcu
rwlock stress-tests [1]. The test run in a loop is:

for a in $(seq 1 100000); do echo $a; tests/benchmark/.libs/test_rwlock 2=
 2 1 || exit 1; done

This runs a 1 second test with 2 reader and 2 writer threads.

The hangs show up in the following scenarios:

- glibc nptl rwlock,
- glibc nptl pthread_join.

Another simpler test-case that reproduces the pthread join hang is as fol=
lows:

/*
 * Build with:
 *   gcc -O2 -pthread -o test-pthread-join test-pthread-join.c
 * Run in a loop:
 *   for a in $(seq 500000); do echo $a; ./test-pthread-join || exit 1; d=
one
 */

void *testmemthread(void *arg)
{
        printf("thread id : %lu, pid %lu\n", pthread_self(), getpid());
        return ((void*)0);
}

int main()
{
        int err, i;
        pthread_t testmemid[NR_THREADS];
        void *tret;

        for (i =3D 0; i < NR_THREADS; i++) {
                err =3D pthread_create(&testmemid[i], NULL, testmemthread=
,
                        (void *)(long)i);
                if (err !=3D 0)
                        exit(1);
        }
        for (i =3D 0; i < NR_THREADS; i++) {
                err =3D pthread_join(testmemid[i], &tret);
                if (err !=3D 0)
                        exit(1);
        }
        return 0;
}

In all cases a FUTEX_WAIT is stuck waiting for a state change that can
be validated to be present in user memory by inspecting the hung process
with a debugger.

This can be reproduced with a Debian bullseye config-5.18.0-0.bpo.1-armmp
configuration. The config-5.18.0-0.bpo.1-armmp configuration applied to
a vanilla 5.18.2 kernel tree reproduces this issue when compiled with
gcc version 10.2.1 20210110 (Debian 10.2.1-6). The U-Boot version is
2021.01+dfsg-4.

Note that this either does not appear to reproduce or takes longer to
reproduce as soon as the configuration varies significantly enough to
change the kernel code generated for futex wait.

- It takes longer to hit the hang when running on a 5.18.2 kernel
  compiled with gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04).

- The issue is not reproduced with a kernel built from a
  imx_v6_v7_defconfig configuration with gcc 10.2.1.
  One important effect of this configuration change is that it targets
  __LINUX_ARM_ARCH__ =3D 6 rather than __LINUX_ARM_ARCH__ =3D 7.

Root Cause Analysis
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Instrumentation of the futex system call FUTEX_WAKE and FUTEX_WAIT code
with tracepoints, and tracing with LTTng [2] in "snapshot" flight
recorder mode allows a better understanding of what is going on when the
hang reproduces.

First, a bit of context about sys_futex: it relies on a Dekker [3]
two-variables memory barrier scenario:

 * CPU 0                                 CPU 1
 * val =3D *futex;
 * sys_futex(WAIT, futex, val);
 *   futex_wait(futex, val);
 *
 *   waiters++; (a)
 *   smp_mb(); (A) <-- paired with -.
 *                                  |
 *   lock(hash_bucket(futex));      |
 *                                  |
 *   uval =3D *futex;                 |
 *                                  |        *futex =3D newval;
 *                                  |        sys_futex(WAKE, futex);
 *                                  |          futex_wake(futex);
 *                                  |
 *                                  `--------> smp_mb(); (B)
 *   if (uval =3D=3D val)
 *     queue();
 *     unlock(hash_bucket(futex));
 *     schedule();                         if (waiters)
 *                                           lock(hash_bucket(futex));
 *   else                                    wake_waiters(futex);
 *     waiters--; (b)                        unlock(hash_bucket(futex));
 *
 * Where (A) orders the waiters increment and the futex value read throug=
h
 * atomic operations (see futex_hb_waiters_inc) and where (B) orders the =
write
 * to futex and the waiters read (see futex_hb_waiters_pending()).
 *
 * This yields the following case (where X:=3Dwaiters, Y:=3Dfutex):
 *
 *      X =3D Y =3D 0
 *
 *      w[X]=3D1          w[Y]=3D1
 *      MB              MB
 *      r[Y]=3Dy          r[X]=3Dx
 *
 * Which guarantees that x=3D=3D0 && y=3D=3D0 is impossible; which transl=
ates back into
 * the guarantee that we cannot both miss the futex variable change and t=
he
 * enqueue.

When reproducing the hang, we observe the following in the userspace
stacks and in the execution trace:

  (gdb) thread apply all bt

  Thread 5 (Thread 0xb5693450 (LWP 2404) "test_rwlock"):
  #0  __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-sysc=
all.S:46
  #1  0xb6fa105c in futex_abstimed_wait (private=3D0, abstime=3D0x0, cloc=
kid=3D0, expected=3D3, futex_word=3D<optimized out>) at ../sysdeps/nptl/f=
utex-internal.h:287
  #2  __pthread_rwlock_wrlock_full (abstime=3D0x0, clockid=3D0, rwlock=3D=
0x4420d8 <lock>) at pthread_rwlock_common.c:731
  #3  __GI___pthread_rwlock_wrlock (rwlock=3Drwlock@entry=3D0x4420d8 <loc=
k>) at pthread_rwlock_wrlock.c:27
  #4  0x00430fe0 in thr_writer (_count=3D0x96e1d0) at test_rwlock.c:205
  #5  0xb6f9c98e in start_thread (arg=3D0x4d5aa9ac) at pthread_create.c:4=
77
  #6  0xb6f37bec in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:73 fr=
om /lib/arm-linux-gnueabihf/libc.so.6
  Backtrace stopped: previous frame identical to this frame (corrupt stac=
k?)

  Thread 4 (Thread 0xb5e94450 (LWP 2403) "test_rwlock"):
  #0  __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-sysc=
all.S:46
  #1  0xb6fa0ea4 in futex_abstimed_wait (private=3D0, abstime=3D0x0, cloc=
kid=3D0, expected=3D2, futex_word=3D<optimized out>) at ../sysdeps/nptl/f=
utex-internal.h:287
  #2  __pthread_rwlock_wrlock_full (abstime=3D0x0, clockid=3D0, rwlock=3D=
0x4420d8 <lock>) at pthread_rwlock_common.c:830
  #3  __GI___pthread_rwlock_wrlock (rwlock=3Drwlock@entry=3D0x4420d8 <loc=
k>) at pthread_rwlock_wrlock.c:27
  #4  0x00430fe0 in thr_writer (_count=3D0x96e1c8) at test_rwlock.c:205
  #5  0xb6f9c98e in start_thread (arg=3D0x4d5aa9ac) at pthread_create.c:4=
77
  #6  0xb6f37bec in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:73 fr=
om /lib/arm-linux-gnueabihf/libc.so.6
  Backtrace stopped: previous frame identical to this frame (corrupt stac=
k?)

  Thread 3 (Thread 0xb6695450 (LWP 2402) "test_rwlock"):
  #0  __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-sysc=
all.S:46
  #1  0xb6fa07be in futex_abstimed_wait (private=3D<optimized out>, absti=
me=3D0x0, clockid=3D0, expected=3D3, futex_word=3D<optimized out>) at ../=
sysdeps/nptl/futex-internal.h:287
  #2  __pthread_rwlock_rdlock_full (abstime=3D0x0, clockid=3D0, rwlock=3D=
0x4420d8 <lock>) at pthread_rwlock_common.c:460
  #3  __GI___pthread_rwlock_rdlock (rwlock=3Drwlock@entry=3D0x4420d8 <loc=
k>) at pthread_rwlock_rdlock.c:27
  #4  0x004311ba in thr_reader (_count=3D0x96e1b8) at test_rwlock.c:157
  #5  0xb6f9c98e in start_thread (arg=3D0x4d5aa9ac) at pthread_create.c:4=
77
  #6  0xb6f37bec in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:73 fr=
om /lib/arm-linux-gnueabihf/libc.so.6
  Backtrace stopped: previous frame identical to this frame (corrupt stac=
k?)

  Thread 2 (Thread 0xb6e96450 (LWP 2401) "test_rwlock"):
  #0  __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-sysc=
all.S:46
  #1  0xb6fa07be in futex_abstimed_wait (private=3D<optimized out>, absti=
me=3D0x0, clockid=3D0, expected=3D3, futex_word=3D<optimized out>) at ../=
sysdeps/nptl/futex-internal.h:287
  #2  __pthread_rwlock_rdlock_full (abstime=3D0x0, clockid=3D0, rwlock=3D=
0x4420d8 <lock>) at pthread_rwlock_common.c:460
  #3  __GI___pthread_rwlock_rdlock (rwlock=3Drwlock@entry=3D0x4420d8 <loc=
k>) at pthread_rwlock_rdlock.c:27
  #4  0x004311ba in thr_reader (_count=3D0x96e1b0) at test_rwlock.c:157
  #5  0xb6f9c98e in start_thread (arg=3D0x4d5aa9ac) at pthread_create.c:4=
77
  #6  0xb6f37bec in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:73 fr=
om /lib/arm-linux-gnueabihf/libc.so.6
  Backtrace stopped: previous frame identical to this frame (corrupt stac=
k?)

  Thread 1 (Thread 0xb6fe3d60 (LWP 2400) "test_rwlock"):
  #0  __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-sysc=
all.S:46
  #1  0xb6f9dafc in __pthread_clockjoin_ex (threadid=3D3068748880, thread=
_return=3Dthread_return@entry=3D0xbeb80a8c, clockid=3Dclockid@entry=3D0, =
abstime=3Dabstime@entry=3D0x0, block=3Dblock@entry=3Dtrue) at pthread_joi=
n_common.c:145
  #2  0xb6f9d8ec in __pthread_join (threadid=3D<optimized out>, thread_re=
turn=3Dthread_return@entry=3D0xbeb80a8c) at pthread_join.c:24
  #3  0x00430b20 in main (argc=3D<optimized out>, argv=3D0xbeb80c14) at t=
est_rwlock.c:367

  (gdb) print *rwlock
  $1 =3D {__data =3D {__readers =3D 19, __writers =3D 0, __wrphase_futex =
=3D 3, __writers_futex =3D 3, __pad3 =3D 0, __pad4 =3D 0, __flags =3D 0 '=
\000',
      __shared =3D 0 '\000', __pad1 =3D 0 '\000', __pad2 =3D 0 '\000', __=
cur_writer =3D 0},
    __size =3D "\023\000\000\000\000\000\000\000\003\000\000\000\003", '\=
000' <repeats 18 times>, __align =3D 19}

Thread 4 (tid=3D2403) should either have been awakened when the
__wrphase_futex state changed from 2 to 3, or should have observed a
__wrphase_futex=3D=3D3 and thus never have blocked.

Here is the relevant instrumentation. Note that the instrumentation
added aims at minimizing the impact on the fast-path timings to make
sure the issue can be reproduced under tracing. Indeed, adding too much
instrumentation either hides the problem or makes it take much longer to
reproduce.

futex_wait_end:              At each location where the function futex_wa=
it_setup() returns.
futex_wait_get_value_locked: Conditional if uval !=3D val so the timing o=
f the fast-path is not changed too much.
futex_wait_get_user:         After futex_wait_setup issues get_user() (sl=
ow path for page faults).
futex_wake_end:              At each location where the function futex_wa=
ke() returns.

Let's look at the relevant portion of the trace just before the hang:

[...]
        [16:27:34.437683527] (+0.000004666) futex_wait_end: { cpu_id =3D =
2 }, { tid =3D 2403, pid =3D 2400 }, { uaddr =3D 0x4420E0, val =3D 2, ret=
 =3D 0, msg =3D "" }
        [16:27:34.437700528] (+0.000017001) futex_wait_end: { cpu_id =3D =
0 }, { tid =3D 2402, pid =3D 2400 }, { uaddr =3D 0x4420E0, val =3D 3, ret=
 =3D 0, msg =3D "" }
        [16:27:34.437703195] (+0.000002667) futex_wake_end: { cpu_id =3D =
1 }, { tid =3D 2401, pid =3D 2400 }, { uaddr =3D 0x4420E0, ret =3D 1, msg=
 =3D "" }
        [16:27:34.437704862] (+0.000001667) futex_wait_end: { cpu_id =3D =
3 }, { tid =3D 2404, pid =3D 2400 }, { uaddr =3D 0x4420E4, val =3D 3, ret=
 =3D 0, msg =3D "" }
        [16:27:34.437708195] (+0.000003333) futex_wait_end: { cpu_id =3D =
1 }, { tid =3D 2401, pid =3D 2400 }, { uaddr =3D 0x4420E0, val =3D 3, ret=
 =3D 0, msg =3D "" }
        [16:27:34.437735863] (+0.000027668) futex_wake_end: { cpu_id =3D =
2 }, { tid =3D 2403, pid =3D 2400 }, { uaddr =3D 0x4420E0, ret =3D 2, msg=
 =3D "" }
        [16:27:34.437741863] (+0.000006000) futex_wake_end: { cpu_id =3D =
2 }, { tid =3D 2403, pid =3D 2400 }, { uaddr =3D 0x4420E4, ret =3D 1, msg=
 =3D "" }
        [16:27:34.437745863] (+0.000004000) futex_wait_end: { cpu_id =3D =
2 }, { tid =3D 2403, pid =3D 2400 }, { uaddr =3D 0x4420E0, val =3D 2, ret=
 =3D 0, msg =3D "" }
        [16:27:34.437762531] (+0.000016668) futex_wait_end: { cpu_id =3D =
1 }, { tid =3D 2401, pid =3D 2400 }, { uaddr =3D 0x4420E0, val =3D 3, ret=
 =3D 0, msg =3D "" }
        [16:27:34.437765531] (+0.000003000) futex_wake_end: { cpu_id =3D =
0 }, { tid =3D 2402, pid =3D 2400 }, { uaddr =3D 0x4420E0, ret =3D 1, msg=
 =3D "" }
        [16:27:34.437767864] (+0.000002333) futex_wait_end: { cpu_id =3D =
3 }, { tid =3D 2404, pid =3D 2400 }, { uaddr =3D 0x4420E4, val =3D 3, ret=
 =3D 0, msg =3D "" }
        [16:27:34.437770198] (+0.000002334) futex_wait_end: { cpu_id =3D =
0 }, { tid =3D 2402, pid =3D 2400 }, { uaddr =3D 0x4420E0, val =3D 3, ret=
 =3D 0, msg =3D "" }
        [16:27:34.437797865] (+0.000027667) futex_wake_end: { cpu_id =3D =
2 }, { tid =3D 2403, pid =3D 2400 }, { uaddr =3D 0x4420E0, ret =3D 2, msg=
 =3D "" }
        [16:27:34.437803866] (+0.000006001) futex_wake_end: { cpu_id =3D =
2 }, { tid =3D 2403, pid =3D 2400 }, { uaddr =3D 0x4420E4, ret =3D 1, msg=
 =3D "" }
        [16:27:34.437807866] (+0.000004000) futex_wait_end: { cpu_id =3D =
2 }, { tid =3D 2403, pid =3D 2400 }, { uaddr =3D 0x4420E0, val =3D 2, ret=
 =3D 0, msg =3D "" }
        [16:27:34.437824866] (+0.000017000) futex_wait_end: { cpu_id =3D =
0 }, { tid =3D 2402, pid =3D 2400 }, { uaddr =3D 0x4420E0, val =3D 3, ret=
 =3D 0, msg =3D "" }
        [16:27:34.437826866] (+0.000002000) futex_wake_end: { cpu_id =3D =
1 }, { tid =3D 2401, pid =3D 2400 }, { uaddr =3D 0x4420E0, ret =3D 1, msg=
 =3D "" }
        [16:27:34.437830200] (+0.000003334) futex_wait_end: { cpu_id =3D =
3 }, { tid =3D 2404, pid =3D 2400 }, { uaddr =3D 0x4420E4, val =3D 3, ret=
 =3D 0, msg =3D "" }
        [16:27:34.437831533] (+0.000001333) futex_wait_end: { cpu_id =3D =
1 }, { tid =3D 2401, pid =3D 2400 }, { uaddr =3D 0x4420E0, val =3D 3, ret=
 =3D 0, msg =3D "" }
        [16:27:34.437852868] (+0.000021335) futex_wake_end: { cpu_id =3D =
2 }, { tid =3D 2403, pid =3D 2400 }, { uaddr =3D 0x4420E0, ret =3D 2, msg=
 =3D "" }
        [16:27:34.437858534] (+0.000005666) futex_wake_end: { cpu_id =3D =
2 }, { tid =3D 2403, pid =3D 2400 }, { uaddr =3D 0x4420E4, ret =3D 1, msg=
 =3D "" }
(b)     [16:27:34.437862868] (+0.000004334) futex_wait_end: { cpu_id =3D =
2 }, { tid =3D 2403, pid =3D 2400 }, { uaddr =3D 0x4420E0, val =3D 2, ret=
 =3D 0, msg =3D "" }
(a)     [16:27:34.437879202] (+0.000016334) futex_wake_end: { cpu_id =3D =
0 }, { tid =3D 2402, pid =3D 2400 }, { uaddr =3D 0x4420E0, ret =3D 0, msg=
 =3D "!futex_hb_waiters_pending" }
        [16:27:34.437879535] (+0.000000333) futex_wait_end: { cpu_id =3D =
1 }, { tid =3D 2401, pid =3D 2400 }, { uaddr =3D 0x4420E0, val =3D 3, ret=
 =3D 0, msg =3D "" }
        [16:27:34.437884535] (+0.000005000) futex_wait_end: { cpu_id =3D =
0 }, { tid =3D 2402, pid =3D 2400 }, { uaddr =3D 0x4420E0, val =3D 3, ret=
 =3D 0, msg =3D "" }
        [16:27:34.437884535] (+0.000000000) futex_wait_end: { cpu_id =3D =
3 }, { tid =3D 2404, pid =3D 2400 }, { uaddr =3D 0x4420E4, val =3D 3, ret=
 =3D 0, msg =3D "" }
        [16:27:35.241824878] (+0.803940343) futex_wait_end: { cpu_id =3D =
2 }, { tid =3D 2400, pid =3D 2400 }, { uaddr =3D 0xB6E964B8, val =3D 2401=
, ret =3D 0, msg =3D "" }

At (a), tid=3D2402 observes waiters_pending=3D=3D0, and therefore skips
awakening any other threads on futex uaddr=3D0x4420E0.

However, at (b), tid=3D2403 returns from futex_wait_setup() on futex
uaddr=3D0x4420E0 with ret=3D0, which will cause it to block. It was calle=
d
with a val=3D2 as input argument. Considering that no
futex_wait_get_value_locked is traced, this means the observed uval
loaded by futex_get_value_locked() matches the expected val (=3D=3D2).

Considering that tid=3D2402 observes waiters_pending=3D=3D0, we have the
following ordering:

Waker                  Waiter
tid=3D2402               tid=3D2403
-------------------------------
*futex=3D3
dmb
                       load *futex
                       sys_futex
load waiters_pending
  (observe 0)
                         atomic_inc waiters_pending
                         dmb
                         load *futex
                           (observe 2, impossible!)

The fact that the waiter thread observes the futex=3D2 when the waker
observed waiters_pending=3D0 is a contradiction of the Dekker 2-variables
memory barrier scenario.

Looking more specifically at the operations involved in the loads and
stores of the futex and waiters_pending variables, we notice two things:

1) atomic_inc has a prefetchw() (PLDW) instruction, which is compiled
   out for __LINUX_ARM_ARCH__ =3D 6, which could explain why imx_v6_v7_de=
fconfig
   does not reproduce the hang.

2) the waiter thread has a pattern of load *futex; dmb; load *futex,
   which are two loads of the same variable. I have attempted to modify
   the get_user used for the second load to replace LDR by LDREX in
   case some variation of errata 761319 would be at play here, but
   the hang persists.

Solution
=3D=3D=3D=3D=3D=3D=3D=3D

The hang does not reproduce with the code that implements the arm
prefetchw() static inline function commented out.

Note that it is not the same as commenting out the entire arch-specific
prefetchw implementation (leaving ARCH_HAS_PREFETCHW undefined), which
then relies on the __builtin_prefetch() builtin.

Known Drawbacks
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Removing prefetch instructions can affect the performance of some
microbenchmarks, especially for streaming use-cases.

Unfortunately, the Cortex-A9 does not appear to have a documented
Coprocessor Access Control Register bit for disabling the PLD and PLDW
instructions, which prevents fixing it at boot-time from U-Boot.
Removing the prefetch instruction from the kernel code does not fix
similar issues that may arise in user-space.

Request for Feedback
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This fix targets all i.MX configurations, but it is likely too broad (or
too narrow). It would be great if people with access to different
Freescale i.MX test boards, and test boards from other vendors, could try
to reproduce the issue to figure out what would be the right scope for
this fix.

It would also be great if people with knowledge of the ARM CPU internals
could help understanding whether this fix really fixes an issue between
prefetch and memory barriers, or just happens to hide the issue. It
would be good to understand whether this issue only affects PLDW or if
it also affects the PLD instruction.

Link: https://liburcu.org [1]
Link: https://lttng.org [2]
Link: https://lwn.net/Articles/573436/ [3]
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: James Morse <james.morse@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: "Mark Rutland" <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: "Shawn Guo" <shawnguo@kernel.org>
Cc: "Sascha Hauer" <s.hauer@pengutronix.de>
Cc: Michael Jeanson <mjeanson@efficios.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/Kconfig                 | 3 +++
 arch/arm/include/asm/processor.h | 2 ++
 arch/arm/mach-imx/Kconfig        | 1 +
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2e8091e2d8a8..ffcc0363e171 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -239,6 +239,9 @@ config GENERIC_ISA_DMA
 config FIQ
 	bool
=20
+config ARM_DISABLE_PREFETCHW
+	bool
+
 config ARCH_MTD_XIP
 	bool
=20
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/proc=
essor.h
index bdc35c0e8dfb..8a3e0c566d1f 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -121,6 +121,7 @@ static inline void prefetch(const void *ptr)
 #define ARCH_HAS_PREFETCHW
 static inline void prefetchw(const void *ptr)
 {
+#if !defined(CONFIG_ARM_DISABLE_PREFETCHW)
 	__asm__ __volatile__(
 		".arch_extension	mp\n"
 		__ALT_SMP_ASM(
@@ -128,6 +129,7 @@ static inline void prefetchw(const void *ptr)
 			"pld\t%a0"
 		)
 		:: "p" (ptr));
+#endif
 }
 #endif
 #endif
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c5a59158722b..1bbc6d63b6ec 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -10,6 +10,7 @@ menuconfig ARCH_MXC
 	select PM_OPP if PM
 	select SOC_BUS
 	select SRAM
+	select ARM_DISABLE_PREFETCHW
 	help
 	  Support for Freescale MXC/iMX-based family of processors
=20
--=20
2.30.2

