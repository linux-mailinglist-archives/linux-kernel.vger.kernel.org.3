Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1FB4615DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377213AbhK2NMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:12:22 -0500
Received: from foss.arm.com ([217.140.110.172]:38416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377443AbhK2NKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:10:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E81F31042;
        Mon, 29 Nov 2021 05:07:01 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94F153F766;
        Mon, 29 Nov 2021 05:06:58 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, efuller@redhat.com,
        elver@google.com, ink@jurassic.park.msu.ru, jonas@southpole.se,
        juri.lelli@redhat.com, linux@armlinux.org.uk, luto@kernel.org,
        mark.rutland@arm.com, mattst88@gmail.com, michal.simek@xilinx.com,
        mingo@redhat.com, mpe@ellerman.id.au, npiggin@gmail.com,
        paulmck@kernel.org, paulus@samba.org, peterz@infradead.org,
        rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, vincent.guittot@linaro.org,
        will@kernel.org
Subject: [PATCH v8 00/11] thread_info: use helpers to snapshot thread flags
Date:   Mon, 29 Nov 2021 13:06:42 +0000
Message-Id: <20211129130653.2037928-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a trivial fixup and resend of v7 due to a typo breaking the build on
powerpc, as spotted by the kernel test robot:

  https://lore.kernel.org/r/202111271105.v7pE3REd-lkp@intel.com

I've fixed that, and I've double-checked the series, build testing a few
configs for all architectures for chieck the kernel.org crosstool page
provides a GCC 10.3.0 binary. That hit some (unrelated) latent issues,
but there are no new failrues introduced by this series.

Thomas, I'm hoping you'd be happy to pick this again.

As thread_info::flags scan be manipulated by remote threads, it is
necessary to use atomics or READ_ONCE() to ensure that code manipulates
a consistent snapshot, but we open-code plain accesses to
thread_info::flags across the kernel tree.

Generally we get away with this, but tools like KCSAN legitimately warn
that there is a data-race, and this is potentially fragile with compiler
optimizations, LTO, etc.

These patches introduce new helpers to snapshot the thread flags, with the
intent being that these should replace all plain accesses.

Since v1 [1]:
* Drop RFC
* Make read_ti_thread_flags() __always_inline
* Clarify commit messages
* Fix typo in arm64 patch
* Accumulate Reviewed-by / Acked-by tags
* Drop powerpc patch to avoid potential conflicts (per [2])

Since v2 [3]:
* Rebase to v5.14-rc1
* Reinstate powerpc patch

Since v3 [4]:
* Rebase to v5.14-rc4

Since v4 [5]:
* Rebase to v5.15-rc1
* Apply Acked-by / Tested-by tags

Since v5 [6]:
* Fix trivial whitespace bug in x86 patch

Since v6 [7]:
* Rebase to v5.16-rc1
* Fix new issue on PPC where thread flags could be discarded

Since v7 [8]:
* Add missing `&` to use of set_bits()

[1] https://lore.kernel.org/r/20210609122001.18277-1-mark.rutland@arm.com
[2] https://lore.kernel.org/r/87k0mvtgeb.fsf@mpe.ellerman.id.au
[3] https://lore.kernel.org/r/20210621090602.16883-1-mark.rutland@arm.com
[4] https://lore.kernel.org/r/20210713113842.2106-1-mark.rutland@arm.com
[5] https://lore.kernel.org/r/20210803095428.17009-1-mark.rutland@arm.com
[6] https://lore.kernel.org/r/20210914103027.53565-1-mark.rutland@arm.com
[7] https://lore.kernel.org/lkml/20211022135643.7442-1-mark.rutland@arm.com
[8] https://lore.kernel.org/lkml/20211117163050.53986-1-mark.rutland@arm.com/

Thanks,
Mark.

Mark Rutland (11):
  thread_info: add helpers to snapshot thread flags
  entry: snapshot thread flags
  sched: snapshot thread flags
  alpha: snapshot thread flags
  arm: snapshot thread flags
  arm64: snapshot thread flags
  microblaze: snapshot thread flags
  openrisc: snapshot thread flags
  powerpc: avoid discarding flags in system_call_exception()
  powerpc: snapshot thread flags
  x86: snapshot thread flags

 arch/alpha/kernel/signal.c          |  2 +-
 arch/arm/kernel/signal.c            |  2 +-
 arch/arm/mm/alignment.c             |  2 +-
 arch/arm64/kernel/entry-common.c    |  2 +-
 arch/arm64/kernel/ptrace.c          |  4 ++--
 arch/arm64/kernel/signal.c          |  2 +-
 arch/arm64/kernel/syscall.c         |  4 ++--
 arch/microblaze/kernel/signal.c     |  2 +-
 arch/openrisc/kernel/signal.c       |  2 +-
 arch/powerpc/kernel/interrupt.c     | 15 +++++++--------
 arch/powerpc/kernel/ptrace/ptrace.c |  3 +--
 arch/x86/kernel/process.c           |  8 ++++----
 arch/x86/kernel/process.h           |  4 ++--
 arch/x86/mm/tlb.c                   |  2 +-
 include/linux/entry-kvm.h           |  2 +-
 include/linux/thread_info.h         | 14 ++++++++++++++
 kernel/entry/common.c               |  4 ++--
 kernel/entry/kvm.c                  |  4 ++--
 kernel/sched/core.c                 |  2 +-
 19 files changed, 46 insertions(+), 34 deletions(-)

-- 
2.30.2

