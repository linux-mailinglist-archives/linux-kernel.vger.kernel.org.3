Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC2478106
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhLPX5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhLPX5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:57:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0555FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 15:57:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 987F061C27
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 23:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FB5C36AE7;
        Thu, 16 Dec 2021 23:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639699033;
        bh=JZJfoLbTC68aZv89phVexMv9cz0WBCcce9mqpglW4ls=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=dei2kj6qoIXZieLVpZDbgEeWOGTk4byT0tWhqLqA3cppgcwYT6mnE2/ae/bCVqihC
         wcT5W3PM1MebJaYJ2sqp2NbNMhLAXfIH74uBeU1ugpFEuy+dgR1DGVzPaoEa//CxyU
         6gwmzVoD2omFgLVL2U6JEXD3D4SQ48rRBmJqZ6tnfmUkY3aT3/d4mMSXPqNCCXCyp3
         V5k2WBFP6T71zdNzQXJEYErTkk1s7vd5A1t3uqPXkH0i7XQeDJE4mk2fv/SImGTpQL
         C/O1fkdzWmDI6bo7TD9O6J9FpXutd/FwI5MafVwKfC3h9WcPVDd5hnIscF01xwQQz5
         RzNXPdilw+tOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B3B995C0556; Thu, 16 Dec 2021 15:57:12 -0800 (PST)
Date:   Thu, 16 Dec 2021 15:57:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, elver@google.com, glider@google.com
Subject: [GIT PULL kcsan] KCSAN commits for v5.17
Message-ID: <20211216235712.GA2991567@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo,

This pull request contains updates for the Kernel concurrency sanitizer
(KCSAN).  Perhaps the most notable addition is added support for weak
memory ordering, as described here: https://lwn.net/Articles/877200/

These updats have been posted on LKML:

https://lore.kernel.org/all/20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1/

These changes are based on v5.16-rc1, have been exposed to -next and to
kbuild test robot, and are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git kcsan

for you to fetch changes up to b473a3891c46393e9c4ccb4e3197d7fb259c7100:

  kcsan: Only test clear_bit_unlock_is_negative_byte if arch defines it (2021-12-09 16:42:29 -0800)

If I don't hear from you by Friday of the week prior to the merge window
opening, I will assume that you would prefer that I push this directly
to Linus.

Have a great holiday season!

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
