Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C96A58472A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiG1UpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiG1UpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:45:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E4D3A49A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c139so2916306pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=BFYLQBNewKFOO3/y+guhXpi4ykjZO+Pwq+zagBW55FE=;
        b=Wb1wW19HqLhehVg0fLArS6cWPVluO+n8vv+WRdAqBWU+YOiri8HLwdcSuQw7syp2Z8
         OGA9GR5mNXY5ESKuk0phBvMRqW/A7RwdoAdQkgW9VbwLyrszbo3cMWP16TqDVqxVKDFN
         lTjWwB+lk41FcrlMEoIWvq4M3TOhMkcw6E4kBUnr0Fu2p9EauRYEuxQWZCvp36fpThn/
         RvJGGKmetxKXcZ+MaFqCGfg2N3xkitKILRRf4zB6fcXd+YykpuEmj8JLhp8KIH688TlY
         HG+a2p/gvVDXMXuqnDerHwc9R/Aae7KnCEZkG5oTNj3atu+rq3NDNOvTRqjX1bOMrJpS
         IZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=BFYLQBNewKFOO3/y+guhXpi4ykjZO+Pwq+zagBW55FE=;
        b=RfxPEEsec1vD6ne2XTuSet8f2RVHazsgUmVBM7lDZOgX3o+N5Z7Z0o/EgOu6F2ov32
         NR/FQpCqz1e5Qq4pDH1CjNLttpLOzPAlaaRFEGhrzOU7NNWLwEJkXwUBOM8E3QKiKHs2
         Lzvmjiw0GC3i4f2dOSpcPELDqK++ZZbzFt+YgTQ+TNAjBsXNn4urNyxzqqhh5TYAX7rk
         f6JMIKHO/NYUMyaOmcH6JynuvtToyDWLKf0raDrR49meRYBWqC2OHIENojK6Rp/iXq4v
         +vikLp8o+2JKfNx3F8pipHxEQFMBN+znBzrc8rU2bzB3f9k0+aRrtTmjmevlUDoZ4RaN
         TP4g==
X-Gm-Message-State: AJIora8R98QJXGnC45BnQrucWHri58YhBilyJcoy7XrauHW5JaAP6d6+
        TXVgNfJdHwMkiL/i7euYDriL2nl2Aeq104zYWNo=
X-Google-Smtp-Source: AGRyM1t/3EY+tuhYeeax1lGJ/pPz1VYuriZau27GDWfFS8xzf7J8W+nbdwuYexVNcHF2OVt6KlygbA==
X-Received: by 2002:a63:b05:0:b0:41a:58f:f2ba with SMTP id 5-20020a630b05000000b0041a058ff2bamr380211pgl.543.1659041118085;
        Thu, 28 Jul 2022 13:45:18 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([114.254.3.190])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c40f8cb58sm1787304pli.81.2022.07.28.13.45.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Jul 2022 13:45:17 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 0/7] Replace per-task RSS cache with per-CPU RSS cache
Date:   Fri, 29 Jul 2022 04:45:04 +0800
Message-Id: <20220728204511.56348-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

Hi Linux MM,

This is a early RFC patch series, which trys to fix the inaccurate RSS
counting issue and also improve proformance.

The problem
===========

While reading the code in mm/memory.c, I noticed the 64 event threshold
for RSS accounting, and the per-task design seems not the best solution
for either accuracy or efficiency.

The 64 events threshold is still quite small and contention is still
there, it's not the most contented thing but still a performance hit.
And it's already too large and has negative effect on RSS accuracy.

Although RSS is not a really good standard to measure or control process
memory usage, but it's still the most common way for most users to check
the process memory usage in a system (through utils like top, read from
/proc, ps ...)

It's not hard to find many users complaining about the strange RSS
counting issue just by googling it. And I can easily 'steal' tons of
memory from the kernel without being counted by RSS with the following
code snip on x86:

#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <linux/mman.h>
#define THREAD_NUM 10000
#define PAGE_SIZE 4096
#define MAP_SIZE 4096 * 32
void* thread(void *ptr) {
	char *p = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	for (int i = 0; i < MAP_SIZE; ++i)
		p[i] = 0xff;
	sleep(1000);
	munmap(p, MAP_SIZE);
	return NULL;
}
int main(int argc, char **argv) {
	pthread_t threads[THREAD_NUM];
	for (int i = 0; i < THREAD_NUM; ++i)
		pthread_create(&threads[i], NULL, *thread, NULL);
	for (int i = 0; i < THREAD_NUM; ++i)
		pthread_join(threads[i], NULL);
	return 0;
}

And the RSS reports (using `ps`):
USER         PID %CPU  %MEM      VSZ    RSS   TTY      STAT START   TIME COMMAND
root        7278 33.1  0.1  83245376  43888   pts/0    Sl+  01:09   0:03 ./a.out

But actually 1.5G of memory is used by it, and `top` user will have no
idea about it.

RFC
===

In this RFC series, I tried to improve it by using a per-CPU cache,
instead of doing RSS caching per-task. A CPU will cache the RSS update
of it's corresponding active mm as much as possible. When an mm is
switch_to'ed to/off a CPU, flush the cached data.
I first tried to make the cache switch/flush independent of the mm
switch but turns out it is easier and more accurate to just stick
with the mm switch.

And as long as the mm is not switched, don't flush the cache. So the
atomic operation of mm counter is avoided as much as possible.
And now Instead, the RSS reader will collect the cache from each
CPU upon reading.

Since per my understanding, in most cases, RSS reading is less frequent
than RSS updating (checking all caller of
get_mm_counter/get_mm_rss/*_hiwater_rss, it's used by OOM killer, by
task numa balancer periodically, from /proc, and by sparc arch code
which seems the only hot path). This design seems to improve the
performance overall. And besides, with the previous design, high
frequency of RSS reading doesn't make much sense since there is a
64 events delay for each task.

And the overhead of iterating each CPU can be minimized, so reading will
not be much slower than before. One way is to reuse mm_cpumask, RSS reader
will only iterate CPUs that do have cached the RSS of target mm.

Without this optimzation, reader and cache invalidation may suffer a
full CPU sync. But by carefully arrange the data structure, and using
lockless reading design, the performance hit should still be acceptable.

Also removing the per-task struct cache may help save a little bit of sapce.

In this series:
Patch 1/7 - 3/7 remove the old per-task cache, and did some prepare.
Patch 4/7 implement a generic version of per-CPU RSS cache, with a
performance drop on RSS reading/invalidation, because it have to
iterate all CPUs.
Patch 6/7 and 7/7 implement and enabled reusing mm_cpumask for RSS
caching on x86_64.

Tests
=====

Based on this design and this series, I did some tests on x86_64,
and it showed a few advantages compared to the previous design:

- First, the accuracy of RSS of the demo C problem above is now fixed:
USER         PID %CPU  %MEM      VSZ    RSS   TTY      STAT START   TIME COMMAND
root        1201 40.7  4.7  83245376 1498856  pts/0    Sl+  01:11   0:03 ./a.out

Now it's excatly the amount of memory being consumed.

- Cache hit rate:
Booting up and login system (Fedora 36):
Hit/Miss (1 cache miss per 1800 events avg)::
1021027/567

Build linux kernel with tinyconfig and `make -j16`:
Hit/Miss (1 cache miss per 521 events avg):
35613357/68327

pgbench:
Hit/Miss (1 cache miss per 2543811 events avg):
35613357/14

The most common cache miss call chain here is:
 => add_mm_counter_fast
 => do_anonymous_page
 => __handle_mm_fault
 => handle_mm_fault
 => __get_user_pages
 => __get_user_pages_remote
 => get_arg_page
 => copy_string_kernel
 => do_execveat_common.isra.0
 => __x64_sys_execve
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe

With long running tasks, the hit rate is extremely high, nearly 100%
since tasks tend to have a high affinity with the local CPU.

- Some benchmark result:
(with transparent hugepage set to 'never', actuall with 'alwayse. similiar performance different is abserved, just for stabalize the result):

-- on 1 x 8 core AMD Ryzen 9 5900HX @ 3.30Ghz:
pts/pgbench (100 clients, 12 test run):
Before: 16073 TPS, 6.241 ms
After: 16829 TPS, 5.962 ms (~4% faster)

hackbench (32 process, 100 test run):
Before: 125.317
After: 123.482 (~1% faster)

Linux kernel build (tineyconfig, 20 test run)
Before: 20.9947s
After: 20.9955s (Almost identical)

-- on 2 x 48 core Intel Xeon Platinum 8255C CPU @ 2.50GHz
pts/pgbench (100 Clients, 24 test run):
Before: 22556 TPS, 4.458ms latency
After:  23025 TPS, 4.347ms latency (~2% faster)

hackbench (32 process, 100 test run):
Before: took 48.774s
AfterA: took 48.540s (~1% faster)

Linux kernel build (defconfig, 20 test run):
Before: took 42.7050s
After: took 42.7121s (Almost identical)

Overall, the performance seems slightly better than before with the
above tests. And some code paths can still be optimized (eg.
*_hiwater_rss related call site, make more RSS counting routing use
this cache etc...), and things may still get better.

This patch series is only in an early RFC state since I'm not sure if
this is an acceptable design, so I hope I can collect some discussion
from the community.

But at least this shows things definitely can be improved.

If this approach is appreciatable, I'll try to improve the following
work items:
- Arch optimzations, using mm_cpumask. (It seems sparc reads RSS on every
  page fault, not sure if sparc will conflict with this approach)
- Currently, kernel uses RSS reading helpers as a very cheap function
  call, which is no longer that cheap with this series. eg.
  *_hiwater_rss might be batched or optimized in some way to reduce the
  performance impact of slower reader.
- CPU hotplug.
- More code tweaking.

Please have my excuse if I've made any silly mistakes. Looking forward
to learn about everyone's opinion on this.

Kairui Song (7):
  mm: remove the per-task RSS counter cache
  mm: move check_mm to memory.c
  mm/headers: change emun order of MM_COUNTERS
  mm: introduce a generic per-CPU RSS cache
  mm: use fast path for pmd setting as well
  mm: introduce CONFIG_ARCH_PCP_RSS_USE_CPUMASK
  x86_64/tlb, mm: enable cpumask optimzation for RSS cache

 Documentation/filesystems/proc.rst |   7 -
 arch/Kconfig                       |   3 +
 arch/x86/Kconfig                   |   1 +
 arch/x86/mm/tlb.c                  |   5 +
 fs/exec.c                          |   2 -
 include/linux/mm.h                 |  34 +---
 include/linux/mm_types_task.h      |  49 ++++--
 include/linux/sched.h              |   3 -
 kernel/exit.c                      |   5 -
 kernel/fork.c                      |  39 +----
 kernel/kthread.c                   |   1 -
 kernel/sched/core.c                |   4 +
 mm/madvise.c                       |   7 +-
 mm/memory.c                        | 243 +++++++++++++++++++++++++----
 14 files changed, 269 insertions(+), 134 deletions(-)

-- 
2.35.2

