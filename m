Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C3548B418
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344293AbiAKRfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:35:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35210 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344944AbiAKRe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:34:57 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C388D1F3B8;
        Tue, 11 Jan 2022 17:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641922495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VE6dnqfaUn3R40sODHdx81iTMjOF1gEB2Id1XsRVNY0=;
        b=mLq2MfeQFuGSSIPHJP4/6ckjMlkO+SeNMpH8JC4iOMDHV2d5mYExFijzvLiDB6dc1faMlX
        usKXhbn6OphlCjCYZbLxAS3Ja2ZmxPuhJcZDDh6bl5Jno2BOh4uCsQEjaPo0XQlsChBegR
        cWr+GoecpWkvQPxd31JDz2A5CM6ZsL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641922495;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VE6dnqfaUn3R40sODHdx81iTMjOF1gEB2Id1XsRVNY0=;
        b=DBUQScVSGMUCSDpvDh+/tKiuiX/9cpWeYKB8DIcPTLDcT/pk64QhwciwBCdC1Bgt5PgcmY
        2KIoOfdAihhnMIBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACBBE13AE7;
        Tue, 11 Jan 2022 17:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KtPLKL+/3WFDVAAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 11 Jan 2022 17:34:55 +0000
Date:   Tue, 11 Jan 2022 18:35:04 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/core for v5.17
Message-ID: <Yd2/yMnHa8zHe02U@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull locking/core updates for v5.17.

Thx.

---

The following changes since commit 8f556a326c93213927e683fc32bbf5be1b62540a:

  locking/rtmutex: Fix incorrect condition in rtmutex_spin_on_owner() (2021-12-18 10:55:51 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_core_for_v5.17_rc1

for you to fetch changes up to f16cc980d649e664b8f41e1bbaba50255d24e5d1:

  Merge branch 'locking/urgent' into locking/core (2021-12-18 10:57:03 +0100)

----------------------------------------------------------------
Peter Zijlstra says:

"Lots of cleanups and preparation; highlights:

 - futex: Cleanup and remove runtime futex_cmpxchg detection

 - rtmutex: Some fixes for the PREEMPT_RT locking infrastructure

 - kcsan: Share owner_on_cpu() between mutex,rtmutex and rwsem and
   annotate the racy owner->on_cpu access *once*.

 - atomic64: Dead-Code-Elemination"

----------------------------------------------------------------
Arnd Bergmann (4):
      futex: Ensure futex_atomic_cmpxchg_inatomic() is present
      futex: Remove futex_cmpxchg detection
      futex: Fix sparc32/m68k/nds32 build regression
      futex: Fix additional regressions

Ingo Molnar (1):
      Merge tag 'v5.16-rc5' into locking/core, to pick up fixes

Kefeng Wang (1):
      locking: Make owner_on_cpu() into <linux/sched.h>

Marco Elver (1):
      locking: Mark racy reads of owner->on_cpu

Mark Rutland (1):
      locking/atomic: atomic64: Remove unusable atomic ops

Peter Zijlstra (1):
      locking/rtmutex: Squash self-deadlock check for ww_rt_mutex.

Sebastian Andrzej Siewior (10):
      kernel/locking: Use a pointer in ww_mutex_trylock().
      sched: Trigger warning if ->migration_disabled counter underflows.
      locking: Remove rt_rwlock_is_contended().
      locking/rtmutex: Add rt_mutex_lock_nest_lock() and rt_mutex_lock_killable().
      lockdep/selftests: Avoid using local_lock_{acquire|release}().
      lockdep/selftests: Unbalanced migrate_disable() & rcu_read_lock().
      lockdep/selftests: Skip the softirq related tests on PREEMPT_RT
      lockdep/selftests: Adapt ww-tests for PREEMPT_RT
      x86/mm: Include spinlock_t definition in pgtable.
      locking: Allow to include asm/spinlock_types.h from linux/spinlock_types_raw.h

Thomas Gleixner (2):
      lockdep: Remove softirq accounting on PREEMPT_RT.
      Merge branch 'locking/urgent' into locking/core

 arch/alpha/include/asm/spinlock_types.h          |   2 +-
 arch/arc/Kconfig                                 |   1 -
 arch/arm/Kconfig                                 |   1 -
 arch/arm/include/asm/spinlock_types.h            |   2 +-
 arch/arm64/Kconfig                               |   1 -
 arch/arm64/include/asm/spinlock_types.h          |   2 +-
 arch/csky/Kconfig                                |   1 -
 arch/csky/include/asm/spinlock_types.h           |   2 +-
 arch/hexagon/include/asm/spinlock_types.h        |   2 +-
 arch/ia64/include/asm/spinlock_types.h           |   2 +-
 arch/m68k/Kconfig                                |   1 -
 arch/mips/include/asm/futex.h                    |  27 ++--
 arch/powerpc/include/asm/simple_spinlock_types.h |   2 +-
 arch/powerpc/include/asm/spinlock_types.h        |   2 +-
 arch/riscv/Kconfig                               |   1 -
 arch/riscv/include/asm/spinlock_types.h          |   2 +-
 arch/s390/Kconfig                                |   1 -
 arch/s390/include/asm/spinlock_types.h           |   2 +-
 arch/sh/Kconfig                                  |   1 -
 arch/sh/include/asm/spinlock_types.h             |   2 +-
 arch/um/Kconfig                                  |   1 -
 arch/um/kernel/skas/uaccess.c                    |   1 -
 arch/x86/include/asm/pgtable.h                   |   1 +
 arch/xtensa/Kconfig                              |   1 -
 arch/xtensa/include/asm/futex.h                  |   8 +-
 arch/xtensa/include/asm/spinlock_types.h         |   2 +-
 include/asm-generic/futex.h                      |  31 ++--
 include/linux/irqflags.h                         |  23 +--
 include/linux/ratelimit_types.h                  |   2 +-
 include/linux/rtmutex.h                          |   9 ++
 include/linux/sched.h                            |   9 ++
 include/linux/spinlock_types_up.h                |   2 +-
 init/Kconfig                                     |   9 +-
 kernel/futex/core.c                              |  35 -----
 kernel/futex/futex.h                             |   6 -
 kernel/futex/syscalls.c                          |  22 ---
 kernel/locking/lockdep.c                         |   2 +
 kernel/locking/mutex.c                           |  11 +-
 kernel/locking/rtmutex.c                         |  10 +-
 kernel/locking/rtmutex_api.c                     |  30 +++-
 kernel/locking/rwsem.c                           |   9 --
 kernel/locking/spinlock_rt.c                     |   6 -
 kernel/locking/ww_rt_mutex.c                     |   2 +-
 kernel/sched/core.c                              |   3 +
 lib/atomic64.c                                   |   2 -
 lib/locking-selftest.c                           | 172 ++++++++++++++++-------
 46 files changed, 241 insertions(+), 225 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
