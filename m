Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8F0474D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhLNWD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhLNWD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:03:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D08C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:03:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 816FF6171A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A42C34600;
        Tue, 14 Dec 2021 22:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519436;
        bh=vhBV0UB58aLarchcwMhDlOKOEHOzz9YOLWMMuy3eKow=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=qE8zVxADFHlfY70exVyzPUhewE1LR0A4BSs45ehH5SDYstL993kxg9qdR6aq9TJxE
         gAIBLJQmOx7d0XGXiS2scy5JCUd1sDo2VYEXlf5iCFJOo/4Cz6E463Yrk4zZAcMAau
         5jM4oW5lhmG247QoJJhNGCGyOcZKZuxXMkDTW1ZuphZPHMiSdB2RfjwL9swmM4gsmu
         TJi4Y9ZdUq2BQuZINtm4HJSqxsw9h3WiInB/7uGI4LdUcSd8XSdxRuqOAVc7uF4v52
         wTyNgXEzd5n8DAdZsmUmC6nz+ENz3ij+h2JNgrUaQJ9MNipzRrWMo8N56x5vP0kRyU
         TelyT7TVMOeYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 84BFF5C03AE; Tue, 14 Dec 2021 14:03:56 -0800 (PST)
Date:   Tue, 14 Dec 2021 14:03:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: [PATCH kcsan 0/29] Kernel Concurrency Sanitizer (KCSAN) updates for
 v5.17
Message-ID: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides KCSAN updates, courtesy of Marco Elver and Alexander
Potapenko:

1.	Refactor reading of instrumented memory, courtesy of Marco Elver.

2.	Remove redundant zero-initialization of globals, courtesy of
	Marco Elver.

3.	Avoid checking scoped accesses from nested contexts, courtesy
	of Marco Elver.

4.	Add core support for a subset of weak memory modeling, courtesy
	of Marco Elver.

5.	Add core memory barrier instrumentation functions, courtesy of
	Marco Elver.

6.	kcsan, kbuild: Add option for barrier instrumentation only,
	courtesy of Marco Elver.

7.	Call scoped accesses reordered in reports, courtesy of Marco
	Elver.

8.	Show location access was reordered to, courtesy of Marco Elver.

9.	Document modeling of weak memory, courtesy of Marco Elver.

10.	test: Match reordered or normal accesses, courtesy of Marco Elver.

11.	test: Add test cases for memory barrier instrumentation, courtesy
	of Marco Elver.

12.	Ignore GCC 11+ warnings about TSan runtime support, courtesy of
	Marco Elver.

13.	selftest: Add test case to check memory barrier instrumentation,
	courtesy of Marco Elver.

14.	locking/barriers, kcsan: Add instrumentation for barriers,
	courtesy of Marco Elver.

15.	locking/barriers, kcsan: Support generic instrumentation,
	courtesy of Marco Elver.

16.	locking/atomics, kcsan: Add instrumentation for barriers,
	courtesy of Marco Elver.

17.	asm-generic/bitops, kcsan: Add instrumentation for barriers,
	courtesy of Marco Elver.

18.	x86/barriers, kcsan: Use generic instrumentation for non-smp
	barriers, courtesy of Marco Elver.

19.	x86/qspinlock, kcsan: Instrument barrier of
	pv_queued_spin_unlock(), courtesy of Marco Elver.

20.	mm, kcsan: Enable barrier instrumentation, courtesy of Marco
	Elver.

21.	sched, kcsan: Enable memory barrier instrumentation, courtesy
	of Marco Elver.

22.	objtool, kcsan: Add memory barrier instrumentation to whitelist,
	courtesy of Marco Elver.

23.	objtool, kcsan: Remove memory barrier instrumentation from
	noinstr, courtesy of Marco Elver.

24.	compiler_attributes.h: Add __disable_sanitizer_instrumentation,
	courtesy of Alexander Potapenko.

25.	Support WEAK_MEMORY with Clang where no objtool support exists,
	courtesy of Marco Elver.

26.	Make barrier tests compatible with lockdep, courtesy of Marco
	Elver.

27.	Turn barrier instrumentation into macros, courtesy of Marco Elver.

28.	Avoid nested contexts reading inconsistent reorder_access,
	courtesy of Marco Elver.

29.	Only test clear_bit_unlock_is_negative_byte if arch defines it,
	courtesy of Marco Elver.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/dev-tools/kcsan.rst                |   76 ++-
 b/arch/x86/include/asm/barrier.h                   |   10 
 b/arch/x86/include/asm/qspinlock.h                 |    1 
 b/include/asm-generic/barrier.h                    |   29 -
 b/include/asm-generic/bitops/instrumented-atomic.h |    3 
 b/include/asm-generic/bitops/instrumented-lock.h   |    3 
 b/include/linux/atomic/atomic-instrumented.h       |  135 ++++++
 b/include/linux/compiler_attributes.h              |   18 
 b/include/linux/compiler_types.h                   |   13 
 b/include/linux/kcsan-checks.h                     |   10 
 b/include/linux/kcsan.h                            |    1 
 b/include/linux/sched.h                            |    3 
 b/include/linux/spinlock.h                         |    2 
 b/init/init_task.c                                 |    5 
 b/kernel/kcsan/Makefile                            |    2 
 b/kernel/kcsan/core.c                              |   51 --
 b/kernel/kcsan/kcsan_test.c                        |    4 
 b/kernel/kcsan/report.c                            |   16 
 b/kernel/kcsan/selftest.c                          |  141 ++++++
 b/kernel/sched/Makefile                            |    7 
 b/lib/Kconfig.kcsan                                |   20 
 b/mm/Makefile                                      |    2 
 b/scripts/Makefile.kcsan                           |    9 
 b/scripts/Makefile.lib                             |    5 
 b/scripts/atomic/gen-atomic-instrumented.sh        |   41 +
 b/tools/objtool/check.c                            |    4 
 b/tools/objtool/include/objtool/elf.h              |    2 
 include/asm-generic/barrier.h                      |   25 +
 include/linux/kcsan-checks.h                       |   95 +++-
 include/linux/kcsan.h                              |   10 
 kernel/kcsan/core.c                                |  302 ++++++++++++-
 kernel/kcsan/kcsan_test.c                          |  456 ++++++++++++++++++---
 kernel/kcsan/report.c                              |   35 +
 kernel/kcsan/selftest.c                            |   22 -
 lib/Kconfig.kcsan                                  |    2 
 scripts/Makefile.kcsan                             |    6 
 tools/objtool/check.c                              |   37 +
 37 files changed, 1389 insertions(+), 214 deletions(-)
