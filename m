Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943F9486E30
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343632AbiAFX7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:59:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42318 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245708AbiAFX7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:59:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBC4261E50
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 23:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF27AC36AE3;
        Thu,  6 Jan 2022 23:59:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="g9UIUDSY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641513570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NglHtH45AlMDNEBZHIxn0ae9/6Bfw9S4CXmTkC4shGY=;
        b=g9UIUDSYh0dUSGl/1bPKaKGMVnUcNKNpoqc0sDv67pgLzzEp++TkaawLdFku7zNQUopapT
        lKeDIev/B/wnQExsHoYpUfuQP9Zaraa+b+pjo2+eFU9AeT9R5h5ZON5HYSuyDFHix9RXzh
        WbYGgGbpcxDk4BdiIyNJGhepknRpTZU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4736d637 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 6 Jan 2022 23:59:30 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [GIT PULL] random number generator updates for 5.17
Date:   Fri,  7 Jan 2022 00:59:20 +0100
Message-Id: <20220106235920.995517-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these random number generator updates for 5.17. They're a bit more
numerous than usual for the RNG, due to folks resubmitting patches that had
been pending prior and generally renewed interest. There are a few categories
of patches in this pull:

1) Dominik Brodowski and I traded a series back and forth for a some weeks
   that fixed numerous issues related to seeds being provided at extremely
   early boot by the firmware, before other parts of the kernel or of the RNG
   have been initialized, both fixing some crashes and addressing correctness
   around early boot randomness. One of these is marked for stable.

2) I replaced the RNG's usage of SHA-1 with BLAKE2s in the entropy extractor,
   and made the construction a bit safer and more standard. This was sort of a
   long overdue low hanging fruit, as we were supposed to have phased out
   SHA-1 usage quite some time ago (even if all we needed here was
   non-invertibility). Along the way it also made extraction 131% faster. This
   required a bit of Kconfig and symbol plumbing to make things work well with
   the crypto libraries, which is one of the reasons why I'm sending you this
   pull early in the cycle.

3) I got rid of a truly superfluous call to RDRAND in the hot path, which
   resulted in a whopping 370% increase in performance.

4) Sebastian Andrzej Siewior sent some patches regarding PREEMPT_RT, the full
   series of which wasn't ready yet, but the first two preparatory cleanups
   were good on their own. One of them touches files in kernel/irq/, which is
   the other reason why I'm sending you this pull early in the cycle.

5) Other assorted correctness fixes from Eric Biggers, Jann Horn, Mark Brown,
   Dominik Brodowski, and myself.

Thanks,
Jason

The following changes since commit 75acfdb6fd922598a408a0d864486aeb167c1a97:

  Merge tag 'net-5.16-final' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-01-05 14:08:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git random-5.17-for-linus

for you to fetch changes up to 6c8e11e08a5b74bb8a5cdd5cbc1e5143df0fba72:

  random: don't reset crng_init_cnt on urandom_read() (2022-01-07 00:25:25 +0100)

----------------------------------------------------------------
Dominik Brodowski (3):
      random: fix crash on multiple early calls to add_bootloader_randomness()
      random: harmonize "crng init done" messages
      random: early initialization of ChaCha constants

Eric Biggers (2):
      random: fix data race on crng_node_pool
      random: fix data race on crng init time

Jann Horn (1):
      random: don't reset crng_init_cnt on urandom_read()

Jason A. Donenfeld (9):
      MAINTAINERS: add git tree for random.c
      lib/crypto: blake2s: include as built-in
      random: use BLAKE2s instead of SHA1 in extraction
      random: do not sign extend bytes for rotation when mixing
      random: do not re-init if crng_reseed completes before primary init
      random: do not throw away excess input to crng_fast_load
      random: mix bootloader randomness into pool
      random: use IS_ENABLED(CONFIG_NUMA) instead of ifdefs
      random: avoid superfluous call to RDRAND in CRNG extraction

Mark Brown (1):
      random: document add_hwgenerator_randomness() with other input functions

Sebastian Andrzej Siewior (2):
      random: remove unused irq_flags argument from add_interrupt_randomness()
      irq: remove unused flags argument from __handle_irq_event_percpu()

 MAINTAINERS                       |   1 +
 arch/arm/crypto/Makefile          |   4 +-
 arch/arm/crypto/blake2s-core.S    |   8 +-
 arch/arm/crypto/blake2s-glue.c    |  73 +----------
 arch/arm/crypto/blake2s-shash.c   |  75 ++++++++++++
 arch/x86/crypto/Makefile          |   4 +-
 arch/x86/crypto/blake2s-glue.c    |  68 +----------
 arch/x86/crypto/blake2s-shash.c   |  77 ++++++++++++
 arch/x86/kernel/cpu/mshyperv.c    |   2 +-
 crypto/Kconfig                    |   3 +-
 drivers/char/random.c             | 248 ++++++++++++++++++++------------------
 drivers/hv/vmbus_drv.c            |   2 +-
 drivers/net/Kconfig               |   1 -
 include/crypto/chacha.h           |  15 ++-
 include/crypto/internal/blake2s.h |   6 +-
 include/linux/random.h            |   2 +-
 kernel/irq/chip.c                 |   4 +-
 kernel/irq/handle.c               |  11 +-
 kernel/irq/internals.h            |   2 +-
 lib/crypto/Kconfig                |  23 +---
 lib/crypto/Makefile               |   9 +-
 lib/crypto/blake2s-generic.c      |   6 +-
 lib/crypto/blake2s.c              |   6 -
 23 files changed, 341 insertions(+), 309 deletions(-)
 create mode 100644 arch/arm/crypto/blake2s-shash.c
 create mode 100644 arch/x86/crypto/blake2s-shash.c
