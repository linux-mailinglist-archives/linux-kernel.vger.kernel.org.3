Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00657F4FD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 14:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbiGXMZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 08:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiGXMZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 08:25:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B79511143;
        Sun, 24 Jul 2022 05:25:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACAFD61044;
        Sun, 24 Jul 2022 12:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044BFC3411E;
        Sun, 24 Jul 2022 12:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658665529;
        bh=VOfIGOKOIXbu6EDdNFw/8vizu/PSUWKWc6UVcQMVnGE=;
        h=From:To:Cc:Subject:Date:From;
        b=efLfBEYZsSFKPN6u5/CEpHEVMsFM8IMrsdKMwhaZenOXF4ytT2A9He34zJ0Ug3KtO
         AoCRH3/HLhkVF9aD6zoM0+jKnaNYfuqTemOx/6C+Vt6YiCA4RCAxGYwmNaNjXptH/T
         vbgSJQodLjJyYFwfC3kNrY9lqzkeF61ShwdWIAQ7LfN3qIW5WPRb0r/zGGP47kQfMX
         +hCc1kZRGoJ3RjUqiLbxi2uqCyPmWQzY+g5nRzUslpLOw3hP8706XLsTJOy0GDbssb
         DvX18uFS2wqmYlSL1fvXUgyP4nB2UL+0BV4Hpv+yYmoGbTG4odbj/xA2qXGOpygOpd
         IFu4GllAi2uWg==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, heiko@sntech.de, hch@infradead.org,
        arnd@arndb.de, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, mingo@redhat.com,
        philipp.tomsich@vrull.eu, cmuellner@linux.com,
        linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM
Cc:     linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V8 00/10] arch: Add qspinlock support with combo style
Date:   Sun, 24 Jul 2022 08:25:07 -0400
Message-Id: <20220724122517.1019187-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Enable qspinlock and meet the requirements mentioned in a8ad07e5240c9
("asm-generic: qspinlock: Indicate the use of mixed-size atomics").

RISC-V LR/SC pairs could provide a strong/weak forward guarantee that
depends on micro-architecture. And RISC-V ISA spec has given out
several limitations to let hardware support strict forward guarantee
(RISC-V User ISA - 8.3 Eventual Success of Store-Conditional
Instructions):
We restricted the length of LR/SC loops to fit within 64 contiguous
instruction bytes in the base ISA to avoid undue restrictions on
instruction cache and TLB size and associativity. Similarly, we
disallowed other loads and stores within the loops to avoid restrictions
on data-cache associativity in simple implementations that track the
reservation within a private cache. The restrictions on branches and
jumps limit the time that can be spent in the sequence. Floating-point
operations and integer multiply/divide were disallowed to simplify the
operating system’s emulation of these instructions on implementations
lacking appropriate hardware support.
Software is not forbidden from using unconstrained LR/SC sequences, but
portable software must detect the case that the sequence repeatedly
fails, then fall back to an alternate code sequence that does not rely
on an unconstrained LR/SC sequence. Implementations are permitted to
unconditionally fail any unconstrained LR/SC sequence.

eg:
Some riscv hardware such as BOOMv3 & XiangShan could provide strict &
strong forward guarantee (The cache line would be kept in an exclusive
state for Backoff cycles, and only this core's interrupt could break
the LR/SC pair).
Qemu riscv give a weak forward guarantee by wrong implementation
currently [1].

Add combo spinlock (ticket & queued) support
Some architecture has a flexible requirement on the type of spinlock.
Some LL/SC architectures of ISA don't force micro-arch to give a strong
forward guarantee. Thus different kinds of memory model micro-arch would
come out in one ISA. The ticket lock is suitable for exclusive monitor
designed LL/SC micro-arch with limited cores and "!NUMA". The
queue-spinlock could deal with NUMA/large-scale scenarios with a strong
forward guarantee designed LL/SC micro-arch.

The first try of qspinlock for riscv was made in 2019.1 [2].

[1] https://github.com/qemu/qemu/blob/master/target/riscv/insn_trans/trans_rva.c.inc
[2] https://lore.kernel.org/linux-riscv/20190211043829.30096-1-michaeljclark@mac.com/#r

Changes in V8:
 - Coding convention ticket fixup
 - Move combo spinlock into riscv and simply asm-generic/spinlock.h
 - Fixup xchg16 with wrong return value
 - Add csky qspinlock
 - Add combo & qspinlock & ticket-lock comparison
 - Clean up unnecessary riscv acquire and release definitions
 - Enable ARCH_INLINE_READ*/WRITE*/SPIN* for riscv & csky

Changes in V7:
 - Add combo spinlock (ticket & queued) support
 - Rename ticket_spinlock.h
 - Remove unnecessary atomic_read in ticket_spin_value_unlocked  

Changes in V6:
 - Fixup Clang compile problem Reported-by: kernel test robot
   <lkp@intel.com>
 - Cleanup asm-generic/spinlock.h
 - Remove changelog in patch main comment part, suggested by
   Conor.Dooley@microchip.com
 - Remove "default y if NUMA" in Kconfig

Changes in V5:
 - Update comment with RISC-V forward guarantee feature.
 - Back to V3 direction and optimize asm code.

Changes in V4:
 - Remove custom sub-word xchg implementation
 - Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32 in locking/qspinlock

Changes in V3:
 - Coding convention by Peter Zijlstra's advices

Changes in V2:
 - Coding convention in cmpxchg.h
 - Re-implement short xchg
 - Remove char & cmpxchg implementations

---

Guo Ren (2):
  asm-generic: spinlock: Move qspinlock & ticket-lock into generic spinlock.h
  riscv: Add qspinlock support

Guo Ren (5):
  asm-generic: ticket-lock: Remove unnecessary atomic_read
  asm-generic: ticket-lock: Use the same struct definitions with qspinlock
  asm-generic: ticket-lock: Move into ticket_spinlock.h
  asm-generic: spinlock: Add combo spinlock (ticket & queued)
  riscv: Add qspinlock support


Guo Ren (10):
  asm-generic: ticket-lock: Remove unnecessary atomic_read
  asm-generic: ticket-lock: Use the same struct definitions with qspinlock
  asm-generic: ticket-lock: Move into ticket_spinlock.h
  asm-generic: spinlock: Add queued spinlock support in common header
  riscv: Enable ARCH_INLINE_READ*/WRITE*/SPIN*
  riscv: atomic: Clean up unnecessary acquire and release definitions
  riscv: Add qspinlock support
  riscv: Add combo spinlock support
  csky: Enable ARCH_INLINE_READ*/WRITE*/SPIN*
  csky: Add qspinlock support

 arch/csky/Kconfig                     |  42 +++++++++
 arch/csky/include/asm/Kbuild          |   2 +
 arch/csky/include/asm/cmpxchg.h       |  20 ++++
 arch/riscv/Kconfig                    |  49 ++++++++++
 arch/riscv/include/asm/Kbuild         |   3 +-
 arch/riscv/include/asm/atomic.h       |  19 ----
 arch/riscv/include/asm/cmpxchg.h      | 129 +++-----------------------
 arch/riscv/include/asm/spinlock.h     |  77 +++++++++++++++
 arch/riscv/kernel/setup.c             |  22 +++++
 include/asm-generic/spinlock.h        |  89 +-----------------
 include/asm-generic/spinlock_types.h  |  12 +--
 include/asm-generic/ticket_spinlock.h | 103 ++++++++++++++++++++
 12 files changed, 339 insertions(+), 228 deletions(-)
 create mode 100644 arch/riscv/include/asm/spinlock.h
 create mode 100644 include/asm-generic/ticket_spinlock.h

-- 
2.36.1

