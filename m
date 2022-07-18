Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC252578C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiGRVGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiGRVGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:06:34 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E48D165BC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:06:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 87AC34268FB;
        Mon, 18 Jul 2022 17:06:30 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id P8xbM9zmr0qY; Mon, 18 Jul 2022 17:06:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 43223426BDC;
        Mon, 18 Jul 2022 17:06:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 43223426BDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1658178389;
        bh=lmDWQXFiEFQSj0DEVeLyrbbJQRTUsaE6TMcnQ9zNW4w=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Uj9JIta17FTjK2xjeq9PKgQE7Mewaayj4bFOWxKOLiCZJz+nLvQmTNqhrcj2DpFvR
         0bIbBbH/J2Es86H2nqLh6whRaEaOUZy2nzT8tf7TdJg0j36eYQy1hTh5+u4woRYebB
         F59HtLmcbQ/3myGQvH/SgS24zYSihnMh38sOmxIwy4ysN+un0b+59qoldQEnwb8uBT
         r6mKvakT1V/M/i067CQFy2IM1GsjiETjQawk63eVvNuXhWgyw6G1TohpV1fxyeuEuW
         bHiAXg2AwfjGsIl01W6M/fjfludivGuQwobkIzrVkf8zgZneDmsJuYEnOMLC8OPXwQ
         SWi6VwwhItBMQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fMCQ9Rf2SMWx; Mon, 18 Jul 2022 17:06:29 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1DD05426D92;
        Mon, 18 Jul 2022 17:06:29 -0400 (EDT)
Date:   Mon, 18 Jul 2022 17:06:29 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Jeanson <mjeanson@efficios.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <1180889253.72782.1658178389032.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220718145150.3344778-1-mathieu.desnoyers@efficios.com>
References: <20220718145150.3344778-1-mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH] arm: i.MX6 Cortex-A9: Fix memory ordering
 inconsistency by disabling prefetch instructions
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4304)
Thread-Topic: i.MX6 Cortex-A9: Fix memory ordering inconsistency by disabling prefetch instructions
Thread-Index: 0OwLJJauFuvC0CIgZ+pDWbbk0Dv0EA==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 18, 2022, at 10:51 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Observed issue
> ==============
> 
> On a Wandboard i.MX6 Quad Board revD1 (Cortex-A9 r2p10), spurious hangs
> have been experienced in sys_futex in a few scenarios with liburcu
> rwlock stress-tests [1]. The test run in a loop is:
> 
> for a in $(seq 1 100000); do echo $a; tests/benchmark/.libs/test_rwlock 2 2 1 ||
> exit 1; done
> 
> This runs a 1 second test with 2 reader and 2 writer threads.
> 
> The hangs show up in the following scenarios:
> 
> - glibc nptl rwlock,
> - glibc nptl pthread_join.
> 
> Another simpler test-case that reproduces the pthread join hang is as follows:
> 
> /*
> * Build with:
> *   gcc -O2 -pthread -o test-pthread-join test-pthread-join.c
> * Run in a loop:
> *   for a in $(seq 500000); do echo $a; ./test-pthread-join || exit 1; done
> */

Of course git removed the following from the commit message. Those are useful
to build the reproducer program:

#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

#define NR_THREADS 2

Thanks,

Mathieu

> 
> void *testmemthread(void *arg)
> {
>        printf("thread id : %lu, pid %lu\n", pthread_self(), getpid());
>        return ((void*)0);
> }
> 
> int main()
> {
>        int err, i;
>        pthread_t testmemid[NR_THREADS];
>        void *tret;
> 
>        for (i = 0; i < NR_THREADS; i++) {
>                err = pthread_create(&testmemid[i], NULL, testmemthread,
>                        (void *)(long)i);
>                if (err != 0)
>                        exit(1);
>        }
>        for (i = 0; i < NR_THREADS; i++) {
>                err = pthread_join(testmemid[i], &tret);
>                if (err != 0)
>                        exit(1);
>        }
>        return 0;
> }
> 
> In all cases a FUTEX_WAIT is stuck waiting for a state change that can
> be validated to be present in user memory by inspecting the hung process
> with a debugger.
> 
> This can be reproduced with a Debian bullseye config-5.18.0-0.bpo.1-armmp
> configuration. The config-5.18.0-0.bpo.1-armmp configuration applied to
> a vanilla 5.18.2 kernel tree reproduces this issue when compiled with
> gcc version 10.2.1 20210110 (Debian 10.2.1-6). The U-Boot version is
> 2021.01+dfsg-4.
> 
> Note that this either does not appear to reproduce or takes longer to
> reproduce as soon as the configuration varies significantly enough to
> change the kernel code generated for futex wait.
> 
> - It takes longer to hit the hang when running on a 5.18.2 kernel
>  compiled with gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04).
> 
> - The issue is not reproduced with a kernel built from a
>  imx_v6_v7_defconfig configuration with gcc 10.2.1.
>  One important effect of this configuration change is that it targets
>  __LINUX_ARM_ARCH__ = 6 rather than __LINUX_ARM_ARCH__ = 7.
> 
> Root Cause Analysis
> ===================
> 
> Instrumentation of the futex system call FUTEX_WAKE and FUTEX_WAIT code
> with tracepoints, and tracing with LTTng [2] in "snapshot" flight
> recorder mode allows a better understanding of what is going on when the
> hang reproduces.
> 
> First, a bit of context about sys_futex: it relies on a Dekker [3]
> two-variables memory barrier scenario:
> 
> * CPU 0                                 CPU 1
> * val = *futex;
> * sys_futex(WAIT, futex, val);
> *   futex_wait(futex, val);
> *
> *   waiters++; (a)
> *   smp_mb(); (A) <-- paired with -.
> *                                  |
> *   lock(hash_bucket(futex));      |
> *                                  |
> *   uval = *futex;                 |
> *                                  |        *futex = newval;
> *                                  |        sys_futex(WAKE, futex);
> *                                  |          futex_wake(futex);
> *                                  |
> *                                  `--------> smp_mb(); (B)
> *   if (uval == val)
> *     queue();
> *     unlock(hash_bucket(futex));
> *     schedule();                         if (waiters)
> *                                           lock(hash_bucket(futex));
> *   else                                    wake_waiters(futex);
> *     waiters--; (b)                        unlock(hash_bucket(futex));
> *
> * Where (A) orders the waiters increment and the futex value read through
> * atomic operations (see futex_hb_waiters_inc) and where (B) orders the write
> * to futex and the waiters read (see futex_hb_waiters_pending()).
> *
> * This yields the following case (where X:=waiters, Y:=futex):
> *
> *      X = Y = 0
> *
> *      w[X]=1          w[Y]=1
> *      MB              MB
> *      r[Y]=y          r[X]=x
> *
> * Which guarantees that x==0 && y==0 is impossible; which translates back into
> * the guarantee that we cannot both miss the futex variable change and the
> * enqueue.
> 
> When reproducing the hang, we observe the following in the userspace
> stacks and in the execution trace:
> 
>  (gdb) thread apply all bt
> 
>  Thread 5 (Thread 0xb5693450 (LWP 2404) "test_rwlock"):
>  #0  __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-syscall.S:46
>  #1  0xb6fa105c in futex_abstimed_wait (private=0, abstime=0x0, clockid=0,
>  expected=3, futex_word=<optimized out>) at ../sysdeps/nptl/futex-internal.h:287
>  #2  __pthread_rwlock_wrlock_full (abstime=0x0, clockid=0, rwlock=0x4420d8
>  <lock>) at pthread_rwlock_common.c:731
>  #3  __GI___pthread_rwlock_wrlock (rwlock=rwlock@entry=0x4420d8 <lock>) at
>  pthread_rwlock_wrlock.c:27
>  #4  0x00430fe0 in thr_writer (_count=0x96e1d0) at test_rwlock.c:205
>  #5  0xb6f9c98e in start_thread (arg=0x4d5aa9ac) at pthread_create.c:477
>  #6  0xb6f37bec in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:73 from
>  /lib/arm-linux-gnueabihf/libc.so.6
>  Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> 
>  Thread 4 (Thread 0xb5e94450 (LWP 2403) "test_rwlock"):
>  #0  __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-syscall.S:46
>  #1  0xb6fa0ea4 in futex_abstimed_wait (private=0, abstime=0x0, clockid=0,
>  expected=2, futex_word=<optimized out>) at ../sysdeps/nptl/futex-internal.h:287
>  #2  __pthread_rwlock_wrlock_full (abstime=0x0, clockid=0, rwlock=0x4420d8
>  <lock>) at pthread_rwlock_common.c:830
>  #3  __GI___pthread_rwlock_wrlock (rwlock=rwlock@entry=0x4420d8 <lock>) at
>  pthread_rwlock_wrlock.c:27
>  #4  0x00430fe0 in thr_writer (_count=0x96e1c8) at test_rwlock.c:205
>  #5  0xb6f9c98e in start_thread (arg=0x4d5aa9ac) at pthread_create.c:477
>  #6  0xb6f37bec in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:73 from
>  /lib/arm-linux-gnueabihf/libc.so.6
>  Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> 
>  Thread 3 (Thread 0xb6695450 (LWP 2402) "test_rwlock"):
>  #0  __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-syscall.S:46
>  #1  0xb6fa07be in futex_abstimed_wait (private=<optimized out>, abstime=0x0,
>  clockid=0, expected=3, futex_word=<optimized out>) at
>  ../sysdeps/nptl/futex-internal.h:287
>  #2  __pthread_rwlock_rdlock_full (abstime=0x0, clockid=0, rwlock=0x4420d8
>  <lock>) at pthread_rwlock_common.c:460
>  #3  __GI___pthread_rwlock_rdlock (rwlock=rwlock@entry=0x4420d8 <lock>) at
>  pthread_rwlock_rdlock.c:27
>  #4  0x004311ba in thr_reader (_count=0x96e1b8) at test_rwlock.c:157
>  #5  0xb6f9c98e in start_thread (arg=0x4d5aa9ac) at pthread_create.c:477
>  #6  0xb6f37bec in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:73 from
>  /lib/arm-linux-gnueabihf/libc.so.6
>  Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> 
>  Thread 2 (Thread 0xb6e96450 (LWP 2401) "test_rwlock"):
>  #0  __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-syscall.S:46
>  #1  0xb6fa07be in futex_abstimed_wait (private=<optimized out>, abstime=0x0,
>  clockid=0, expected=3, futex_word=<optimized out>) at
>  ../sysdeps/nptl/futex-internal.h:287
>  #2  __pthread_rwlock_rdlock_full (abstime=0x0, clockid=0, rwlock=0x4420d8
>  <lock>) at pthread_rwlock_common.c:460
>  #3  __GI___pthread_rwlock_rdlock (rwlock=rwlock@entry=0x4420d8 <lock>) at
>  pthread_rwlock_rdlock.c:27
>  #4  0x004311ba in thr_reader (_count=0x96e1b0) at test_rwlock.c:157
>  #5  0xb6f9c98e in start_thread (arg=0x4d5aa9ac) at pthread_create.c:477
>  #6  0xb6f37bec in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:73 from
>  /lib/arm-linux-gnueabihf/libc.so.6
>  Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> 
>  Thread 1 (Thread 0xb6fe3d60 (LWP 2400) "test_rwlock"):
>  #0  __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-syscall.S:46
>  #1  0xb6f9dafc in __pthread_clockjoin_ex (threadid=3068748880,
>  thread_return=thread_return@entry=0xbeb80a8c, clockid=clockid@entry=0,
>  abstime=abstime@entry=0x0, block=block@entry=true) at pthread_join_common.c:145
>  #2  0xb6f9d8ec in __pthread_join (threadid=<optimized out>,
>  thread_return=thread_return@entry=0xbeb80a8c) at pthread_join.c:24
>  #3  0x00430b20 in main (argc=<optimized out>, argv=0xbeb80c14) at
>  test_rwlock.c:367
> 
>  (gdb) print *rwlock
>  $1 = {__data = {__readers = 19, __writers = 0, __wrphase_futex = 3,
>  __writers_futex = 3, __pad3 = 0, __pad4 = 0, __flags = 0 '\000',
>      __shared = 0 '\000', __pad1 = 0 '\000', __pad2 = 0 '\000', __cur_writer = 0},
>    __size = "\023\000\000\000\000\000\000\000\003\000\000\000\003", '\000' <repeats
>    18 times>, __align = 19}
> 
> Thread 4 (tid=2403) should either have been awakened when the
> __wrphase_futex state changed from 2 to 3, or should have observed a
> __wrphase_futex==3 and thus never have blocked.
> 
> Here is the relevant instrumentation. Note that the instrumentation
> added aims at minimizing the impact on the fast-path timings to make
> sure the issue can be reproduced under tracing. Indeed, adding too much
> instrumentation either hides the problem or makes it take much longer to
> reproduce.
> 
> futex_wait_end:              At each location where the function
> futex_wait_setup() returns.
> futex_wait_get_value_locked: Conditional if uval != val so the timing of the
> fast-path is not changed too much.
> futex_wait_get_user:         After futex_wait_setup issues get_user() (slow path
> for page faults).
> futex_wake_end:              At each location where the function futex_wake()
> returns.
> 
> Let's look at the relevant portion of the trace just before the hang:
> 
> [...]
>        [16:27:34.437683527] (+0.000004666) futex_wait_end: { cpu_id = 2 }, { tid =
>        2403, pid = 2400 }, { uaddr = 0x4420E0, val = 2, ret = 0, msg = "" }
>        [16:27:34.437700528] (+0.000017001) futex_wait_end: { cpu_id = 0 }, { tid =
>        2402, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>        [16:27:34.437703195] (+0.000002667) futex_wake_end: { cpu_id = 1 }, { tid =
>        2401, pid = 2400 }, { uaddr = 0x4420E0, ret = 1, msg = "" }
>        [16:27:34.437704862] (+0.000001667) futex_wait_end: { cpu_id = 3 }, { tid =
>        2404, pid = 2400 }, { uaddr = 0x4420E4, val = 3, ret = 0, msg = "" }
>        [16:27:34.437708195] (+0.000003333) futex_wait_end: { cpu_id = 1 }, { tid =
>        2401, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>        [16:27:34.437735863] (+0.000027668) futex_wake_end: { cpu_id = 2 }, { tid =
>        2403, pid = 2400 }, { uaddr = 0x4420E0, ret = 2, msg = "" }
>        [16:27:34.437741863] (+0.000006000) futex_wake_end: { cpu_id = 2 }, { tid =
>        2403, pid = 2400 }, { uaddr = 0x4420E4, ret = 1, msg = "" }
>        [16:27:34.437745863] (+0.000004000) futex_wait_end: { cpu_id = 2 }, { tid =
>        2403, pid = 2400 }, { uaddr = 0x4420E0, val = 2, ret = 0, msg = "" }
>        [16:27:34.437762531] (+0.000016668) futex_wait_end: { cpu_id = 1 }, { tid =
>        2401, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>        [16:27:34.437765531] (+0.000003000) futex_wake_end: { cpu_id = 0 }, { tid =
>        2402, pid = 2400 }, { uaddr = 0x4420E0, ret = 1, msg = "" }
>        [16:27:34.437767864] (+0.000002333) futex_wait_end: { cpu_id = 3 }, { tid =
>        2404, pid = 2400 }, { uaddr = 0x4420E4, val = 3, ret = 0, msg = "" }
>        [16:27:34.437770198] (+0.000002334) futex_wait_end: { cpu_id = 0 }, { tid =
>        2402, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>        [16:27:34.437797865] (+0.000027667) futex_wake_end: { cpu_id = 2 }, { tid =
>        2403, pid = 2400 }, { uaddr = 0x4420E0, ret = 2, msg = "" }
>        [16:27:34.437803866] (+0.000006001) futex_wake_end: { cpu_id = 2 }, { tid =
>        2403, pid = 2400 }, { uaddr = 0x4420E4, ret = 1, msg = "" }
>        [16:27:34.437807866] (+0.000004000) futex_wait_end: { cpu_id = 2 }, { tid =
>        2403, pid = 2400 }, { uaddr = 0x4420E0, val = 2, ret = 0, msg = "" }
>        [16:27:34.437824866] (+0.000017000) futex_wait_end: { cpu_id = 0 }, { tid =
>        2402, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>        [16:27:34.437826866] (+0.000002000) futex_wake_end: { cpu_id = 1 }, { tid =
>        2401, pid = 2400 }, { uaddr = 0x4420E0, ret = 1, msg = "" }
>        [16:27:34.437830200] (+0.000003334) futex_wait_end: { cpu_id = 3 }, { tid =
>        2404, pid = 2400 }, { uaddr = 0x4420E4, val = 3, ret = 0, msg = "" }
>        [16:27:34.437831533] (+0.000001333) futex_wait_end: { cpu_id = 1 }, { tid =
>        2401, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>        [16:27:34.437852868] (+0.000021335) futex_wake_end: { cpu_id = 2 }, { tid =
>        2403, pid = 2400 }, { uaddr = 0x4420E0, ret = 2, msg = "" }
>        [16:27:34.437858534] (+0.000005666) futex_wake_end: { cpu_id = 2 }, { tid =
>        2403, pid = 2400 }, { uaddr = 0x4420E4, ret = 1, msg = "" }
> (b)     [16:27:34.437862868] (+0.000004334) futex_wait_end: { cpu_id = 2 }, {
> tid = 2403, pid = 2400 }, { uaddr = 0x4420E0, val = 2, ret = 0, msg = "" }
> (a)     [16:27:34.437879202] (+0.000016334) futex_wake_end: { cpu_id = 0 }, {
> tid = 2402, pid = 2400 }, { uaddr = 0x4420E0, ret = 0, msg =
> "!futex_hb_waiters_pending" }
>        [16:27:34.437879535] (+0.000000333) futex_wait_end: { cpu_id = 1 }, { tid =
>        2401, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>        [16:27:34.437884535] (+0.000005000) futex_wait_end: { cpu_id = 0 }, { tid =
>        2402, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>        [16:27:34.437884535] (+0.000000000) futex_wait_end: { cpu_id = 3 }, { tid =
>        2404, pid = 2400 }, { uaddr = 0x4420E4, val = 3, ret = 0, msg = "" }
>        [16:27:35.241824878] (+0.803940343) futex_wait_end: { cpu_id = 2 }, { tid =
>        2400, pid = 2400 }, { uaddr = 0xB6E964B8, val = 2401, ret = 0, msg = "" }
> 
> At (a), tid=2402 observes waiters_pending==0, and therefore skips
> awakening any other threads on futex uaddr=0x4420E0.
> 
> However, at (b), tid=2403 returns from futex_wait_setup() on futex
> uaddr=0x4420E0 with ret=0, which will cause it to block. It was called
> with a val=2 as input argument. Considering that no
> futex_wait_get_value_locked is traced, this means the observed uval
> loaded by futex_get_value_locked() matches the expected val (==2).
> 
> Considering that tid=2402 observes waiters_pending==0, we have the
> following ordering:
> 
> Waker                  Waiter
> tid=2402               tid=2403
> -------------------------------
> *futex=3
> dmb
>                       load *futex
>                       sys_futex
> load waiters_pending
>  (observe 0)
>                         atomic_inc waiters_pending
>                         dmb
>                         load *futex
>                           (observe 2, impossible!)
> 
> The fact that the waiter thread observes the futex=2 when the waker
> observed waiters_pending=0 is a contradiction of the Dekker 2-variables
> memory barrier scenario.
> 
> Looking more specifically at the operations involved in the loads and
> stores of the futex and waiters_pending variables, we notice two things:
> 
> 1) atomic_inc has a prefetchw() (PLDW) instruction, which is compiled
>   out for __LINUX_ARM_ARCH__ = 6, which could explain why imx_v6_v7_defconfig
>   does not reproduce the hang.
> 
> 2) the waiter thread has a pattern of load *futex; dmb; load *futex,
>   which are two loads of the same variable. I have attempted to modify
>   the get_user used for the second load to replace LDR by LDREX in
>   case some variation of errata 761319 would be at play here, but
>   the hang persists.
> 
> Solution
> ========
> 
> The hang does not reproduce with the code that implements the arm
> prefetchw() static inline function commented out.
> 
> Note that it is not the same as commenting out the entire arch-specific
> prefetchw implementation (leaving ARCH_HAS_PREFETCHW undefined), which
> then relies on the __builtin_prefetch() builtin.
> 
> Known Drawbacks
> ===============
> 
> Removing prefetch instructions can affect the performance of some
> microbenchmarks, especially for streaming use-cases.
> 
> Unfortunately, the Cortex-A9 does not appear to have a documented
> Coprocessor Access Control Register bit for disabling the PLD and PLDW
> instructions, which prevents fixing it at boot-time from U-Boot.
> Removing the prefetch instruction from the kernel code does not fix
> similar issues that may arise in user-space.
> 
> Request for Feedback
> ====================
> 
> This fix targets all i.MX configurations, but it is likely too broad (or
> too narrow). It would be great if people with access to different
> Freescale i.MX test boards, and test boards from other vendors, could try
> to reproduce the issue to figure out what would be the right scope for
> this fix.
> 
> It would also be great if people with knowledge of the ARM CPU internals
> could help understanding whether this fix really fixes an issue between
> prefetch and memory barriers, or just happens to hide the issue. It
> would be good to understand whether this issue only affects PLDW or if
> it also affects the PLD instruction.
> 
> Link: https://liburcu.org [1]
> Link: https://lttng.org [2]
> Link: https://lwn.net/Articles/573436/ [3]
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: "Mark Rutland" <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: "Shawn Guo" <shawnguo@kernel.org>
> Cc: "Sascha Hauer" <s.hauer@pengutronix.de>
> Cc: Michael Jeanson <mjeanson@efficios.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
> arch/arm/Kconfig                 | 3 +++
> arch/arm/include/asm/processor.h | 2 ++
> arch/arm/mach-imx/Kconfig        | 1 +
> 3 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2e8091e2d8a8..ffcc0363e171 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -239,6 +239,9 @@ config GENERIC_ISA_DMA
> config FIQ
> 	bool
> 
> +config ARM_DISABLE_PREFETCHW
> +	bool
> +
> config ARCH_MTD_XIP
> 	bool
> 
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index bdc35c0e8dfb..8a3e0c566d1f 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -121,6 +121,7 @@ static inline void prefetch(const void *ptr)
> #define ARCH_HAS_PREFETCHW
> static inline void prefetchw(const void *ptr)
> {
> +#if !defined(CONFIG_ARM_DISABLE_PREFETCHW)
> 	__asm__ __volatile__(
> 		".arch_extension	mp\n"
> 		__ALT_SMP_ASM(
> @@ -128,6 +129,7 @@ static inline void prefetchw(const void *ptr)
> 			"pld\t%a0"
> 		)
> 		:: "p" (ptr));
> +#endif
> }
> #endif
> #endif
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index c5a59158722b..1bbc6d63b6ec 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -10,6 +10,7 @@ menuconfig ARCH_MXC
> 	select PM_OPP if PM
> 	select SOC_BUS
> 	select SRAM
> +	select ARM_DISABLE_PREFETCHW
> 	help
> 	  Support for Freescale MXC/iMX-based family of processors
> 
> --
> 2.30.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
