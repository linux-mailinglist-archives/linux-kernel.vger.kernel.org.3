Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423B048A0B3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245671AbiAJULO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:11:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37054 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243576AbiAJULN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:11:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A38761360
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 20:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6513C36AE9;
        Mon, 10 Jan 2022 20:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641845472;
        bh=GZAW6ljpVJkW9tapkShgEyTKogVOxAa+JdKWJh/kdkY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=agy857BBV6eut+qpzva9gOOWppwNnIQwzdCgTuKCCwr3YmKV8k2RSiZo6T2oZ32nZ
         zRFBckXZE7uOsCAOM2D5kAbngpYXXomgYeqxyjLwyh6mloJRfzx9pK0Y08tqXt7SSS
         kiWl36LQ2HuUXwix7ahN2wsbggOWbd5av4GjSFl0xYHZ2e2pLXGTvqh7DnyKPU0tlX
         eKHT9nerJ5dSrYwVG09jMeY4bGCdj4tXP53PdnuFVZIUjsOPsY4vdecF4cmmQzRlPr
         21XL6ZPlw/DJH4Ni/nptqB6zMulaLOqyQwsqau6IPl7XSQuDpMQlU79tFuLLPJyX+j
         MCNo5Yy5HdPuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3A4BC5C03AE; Mon, 10 Jan 2022 12:11:12 -0800 (PST)
Date:   Mon, 10 Jan 2022 12:11:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org, elver@google.com,
        andreyknvl@google.com, glider@google.com, dvyukov@google.com
Subject: [GIT PULL] KCSAN changes for v5.17
Message-ID: <20220110201112.GA1013244@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Please pull the latest KCSAN git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2022.01.09a
  # HEAD: b473a3891c46393e9c4ccb4e3197d7fb259c7100: kcsan: Only test clear_bit_unlock_is_negative_byte if arch defines it

KCSAN changes for this cycle provide KCSAN fixes and also the ability to
take memory barriers into account for weakly-ordered systems.  This last
can increase the probability of detecting certain types of data races.

----------------------------------------------------------------
Alexander Potapenko (1):
      compiler_attributes.h: Add __disable_sanitizer_instrumentation

Marco Elver (28):
      kcsan: Refactor reading of instrumented memory
      kcsan: Remove redundant zero-initialization of globals
      kcsan: Avoid checking scoped accesses from nested contexts
      kcsan: Add core support for a subset of weak memory modeling
      kcsan: Add core memory barrier instrumentation functions
      kcsan, kbuild: Add option for barrier instrumentation only
      kcsan: Call scoped accesses reordered in reports
      kcsan: Show location access was reordered to
      kcsan: Document modeling of weak memory
      kcsan: test: Match reordered or normal accesses
      kcsan: test: Add test cases for memory barrier instrumentation
      kcsan: Ignore GCC 11+ warnings about TSan runtime support
      kcsan: selftest: Add test case to check memory barrier instrumentation
      locking/barriers, kcsan: Add instrumentation for barriers
      locking/barriers, kcsan: Support generic instrumentation
      locking/atomics, kcsan: Add instrumentation for barriers
      asm-generic/bitops, kcsan: Add instrumentation for barriers
      x86/barriers, kcsan: Use generic instrumentation for non-smp barriers
      x86/qspinlock, kcsan: Instrument barrier of pv_queued_spin_unlock()
      mm, kcsan: Enable barrier instrumentation
      sched, kcsan: Enable memory barrier instrumentation
      objtool, kcsan: Add memory barrier instrumentation to whitelist
      objtool, kcsan: Remove memory barrier instrumentation from noinstr
      kcsan: Support WEAK_MEMORY with Clang where no objtool support exists
      kcsan: Make barrier tests compatible with lockdep
      kcsan: Turn barrier instrumentation into macros
      kcsan: Avoid nested contexts reading inconsistent reorder_access
      kcsan: Only test clear_bit_unlock_is_negative_byte if arch defines it

 Documentation/dev-tools/kcsan.rst                |  76 +++-
 arch/x86/include/asm/barrier.h                   |  10 +-
 arch/x86/include/asm/qspinlock.h                 |   1 +
 include/asm-generic/barrier.h                    |  54 ++-
 include/asm-generic/bitops/instrumented-atomic.h |   3 +
 include/asm-generic/bitops/instrumented-lock.h   |   3 +
 include/linux/atomic/atomic-instrumented.h       | 135 ++++++-
 include/linux/compiler_attributes.h              |  18 +
 include/linux/compiler_types.h                   |  13 +-
 include/linux/kcsan-checks.h                     |  83 ++++-
 include/linux/kcsan.h                            |  11 +-
 include/linux/sched.h                            |   3 +
 include/linux/spinlock.h                         |   2 +-
 init/init_task.c                                 |   5 -
 kernel/kcsan/Makefile                            |   2 +
 kernel/kcsan/core.c                              | 347 +++++++++++++++---
 kernel/kcsan/kcsan_test.c                        | 426 +++++++++++++++++++++--
 kernel/kcsan/report.c                            |  51 +--
 kernel/kcsan/selftest.c                          | 143 ++++++++
 kernel/sched/Makefile                            |   7 +-
 lib/Kconfig.kcsan                                |  20 ++
 mm/Makefile                                      |   2 +
 scripts/Makefile.kcsan                           |  15 +-
 scripts/Makefile.lib                             |   5 +
 scripts/atomic/gen-atomic-instrumented.sh        |  41 ++-
 tools/objtool/check.c                            |  41 ++-
 tools/objtool/include/objtool/elf.h              |   2 +-
 27 files changed, 1347 insertions(+), 172 deletions(-)
