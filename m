Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF808530653
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 23:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345659AbiEVVqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 17:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiEVVqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 17:46:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C89F31356
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 14:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D732FB80DF1
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 21:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361DAC385B8;
        Sun, 22 May 2022 21:46:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hq0/m2W7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653255991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M+FqTUSA+ZPr4HVI5tCMJ+I6y9+mnEd6UrarCHUelXw=;
        b=hq0/m2W76ioEwhsKp07uMQQtsnhRUVumE2AS6kO+j9OhI4cZTcdnFS4Wr4vQPtWxgHvIqZ
        ee+f4bwFL2cjcelpIsEwVjQXyXOzhtrG+7KbzuAr6kBBwdnIY6I3wvm04jQ2JmRB2mmg3S
        6jIYjqyh31/GjDhriq7sQXUG/XaxwUI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d7585df9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 22 May 2022 21:46:31 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator updates for 5.19-rc1
Date:   Sun, 22 May 2022 23:44:57 +0200
Message-Id: <20220522214457.37108-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following random number generator updates for 5.19-rc1. These
updates continue to refine the work began in 5.17 and 5.18 of modernizing the
RNG's crypto and streamlining and documenting its code. New for 5.19, the
updates aim to improve entropy collection methods and make some initial
decisions regarding the "premature next" problem and our threat model. The
cloc utility now reports that random.c is 931 lines of code and 466 lines of
comments, not that basic metrics like that mean all that much, but at the very
least it tells you that this is very much a manageable driver now.

Here's a summary of the various patches in this pull:

- The random_get_entropy() function now always returns something at least
  minimally useful. This is the primary entropy source in most collectors,
  which in the best case expands to something like RDTSC, but prior to this
  change, in the worst case it would just return 0, contributing nothing. For
  5.19, additional architectures are wired up, and architectures that are
  entirely missing a cycle counter now have a generic fallback path, which
  uses the highest resolution clock available from the timekeeping subsystem.
  Some of those clocks can actually be quite good, despite the CPU not having
  a cycle counter of its own, and going off-core for a stamp is generally
  thought to increase jitter, something positive from the perspective of
  entropy gathering. Done very early on in the development cycle, this has
  been sitting in next getting some testing for a while now and has relevant
  acks from the archs, so it should be pretty well tested and fine, but is
  nonetheless the thing I'll be keeping my eye on most closely.

- Of particular note with the random_get_entropy() improvements is MIPS,
  which, on CPUs that lack the c0 count register, will now combine the
  high-speed but short-cycle c0 random register with the lower-speed but
  long-cycle generic fallback path.

- With random_get_entropy() now always returning something useful, the
  interrupt handler now collects entropy in a consistent construction.

- Rather than comparing two samples of random_get_entropy() for the jitter
  dance, the algorithm now tests many samples, and uses the amount of
  differing ones to determine whether or not jitter entropy is usable and how
  laborious it must be. The problem with comparing only two samples was that
  if the cycle counter was extremely slow, but just so happened to be on the
  cusp of a change, the slowness wouldn't be detected. Taking many samples
  fixes that to some degree. This, combined with the other improvements to
  random_get_entropy(), should make future unification of /dev/random and
  /dev/urandom maybe more possible. At the very least, were we to attempt it
  again today (we're not), it wouldn't break any of Guenter's test rigs that
  broke when we tried it with 5.18. So, not today, but perhaps down the road,
  that's something we can revisit.

- We attempt to reseed the RNG immediately upon waking up from system suspend
  or hibernation, making use of the various timestamps about suspend time and
  such available, as well as the usual inputs such as RDRAND when available.

- Batched randomness now falls back to ordinary randomness before the RNG is
  initialized. This provides more consistent guarantees to the types of random
  numbers being returned by the various accessors.

- The "pre-init injection" code is now gone for good. I suspect you in
  particular will be happy to read that, as I recall you expressing your
  distaste for it a few months ago. Instead, to avoid a "premature first"
  issue, while still allowing for maximal amount of entropy availability
  during system boot, the first 128 bits of estimated entropy are used
  immediately as it arrives, with the next 128 bits being buffered. And, as
  before, after the RNG has been fully initialized, it winds up reseeding
  anyway a few seconds later in most cases. This resulted in a pretty big
  simplification of the initialization code and let us remove various ad-hoc
  mechanisms like the ugly crng_pre_init_inject().

- The RNG no longer pretends to handle the "premature next" security model,
  something that various academics and other RNG designs have tried to care
  about in the past. After an interesting mailing list thread, these issues
  are thought to be a) mainly academic and not practical at all, and b)
  actively harming the real security of the RNG by delaying new entropy
  additions after a potential compromise, making a potentially bad situation
  even worse. As well, in the first place, our RNG never even properly handled
  the premature next issue, so removing an incomplete solution to a fake
  problem was particularly nice.  This allowed for numerous other
  simplifications in the code, which is a lot cleaner as a consequence. If you
  didn't see it before, https://lore.kernel.org/lkml/YmlMGx6+uigkGiZ0@zx2c4.com/
  may be a thread worth skimming through.

- While the interrupt handler received a separate code path years ago that
  avoids locks by using per-cpu data structures and a faster mixing algorithm,
  in order to reduce interrupt latency, input and disk events that are
  triggered in hardirq handlers were still hitting locks and more expensive
  algorithms. Those are now redirected to use the faster per-cpu data
  structures.

- Rather than having the fake-crypto almost-siphash-based random32
  implementation be used right and left, and in many places where
  cryptographically secure randomness is desirable, the batched entropy code
  is now fast enough to replace that.

- As usual, numerous code quality and documentation cleanups. For example, the
  initialization state machine now uses enum symbolic constants instead of
  just hard coding numbers everywhere.

- Since the RNG initializes once, and then is always initialized thereafter, a
  pretty heavy amount of code used during that initialization is never used
  again. It is now completely cordoned off using static branches and it winds
  up in the .text.unlikely section so that it doesn't reduce cache compactness
  after the RNG is ready.

- A variety of functions meant for waiting on the RNG to be initialized were
  only used by vsprintf, and in not a particularly optimal way. Replacing that
  usage with a more ordinary setup made it possible to remove those functions.

- A cleanup of how we warn userspace about the use of uninitialized
  /dev/urandom and uninitialized get_random_bytes() usage. Interestingly, with
  the change you merged for 5.18 that attempts to use jitter (but does not
  block if it can't), the majority of users should never see those warnings
  for /dev/urandom at all now, and the one for in-kernel usage is mainly a
  debug thing.

- The file_operations struct for /dev/[u]random now implements .read_iter and
  .write_iter instead of .read and .write, allowing it to also implement
  .splice_read and .splice_write, which makes splice(2) work again after it
  was broken here (and in many other places in the tree) during the set_fs()
  removal. This was a bit of a last minute arrival from Jens that hasn't had
  as much time to bake, so I'll be keeping my eye on this as well, but it
  seems fairly ordinary. Unfortunately, read_iter() is around 3% slower than
  read() in my tests, which I'm not thrilled about. But Jens and Al, spurred
  by this observation, seem to be making progress in removing the bottlenecks
  on the iter paths in the VFS layer in general, which should remove the
  performance gap for all drivers.

- Assorted other bug fixes, cleanups, and optimizations.

- A small SipHash cleanup. Note: Greg has an SPDX SipHash patch in his tree
  that changes the same files, which git should handle automatically, but
  heads up in case there's merge trouble.

Regards,
Jason

The following changes since commit c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a:

  Linux 5.18-rc6 (2022-05-08 13:54:17 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.19-rc1-for-linus

for you to fetch changes up to 1ce6c8d68f8ac587f54d0a271ac594d3d51f3efb:

  random: check for signals after page of pool writes (2022-05-22 22:34:31 +0200)

----------------------------------------------------------------
Random number generator updates for Linux 5.19-rc1.
----------------------------------------------------------------

Jason A. Donenfeld (46):
      random: fix sysctl documentation nits
      init: call time_init() before rand_initialize()
      ia64: define get_cycles macro for arch-override
      s390: define get_cycles macro for arch-override
      parisc: define get_cycles macro for arch-override
      alpha: define get_cycles macro for arch-override
      powerpc: define get_cycles macro for arch-override
      openrisc: start CPU timer early in boot
      timekeeping: Add raw clock fallback for random_get_entropy()
      m68k: use fallback for random_get_entropy() instead of zero
      riscv: use fallback for random_get_entropy() instead of zero
      mips: use fallback for random_get_entropy() instead of just c0 random
      arm: use fallback for random_get_entropy() instead of zero
      nios2: use fallback for random_get_entropy() instead of zero
      x86/tsc: Use fallback for random_get_entropy() instead of zero
      um: use fallback for random_get_entropy() instead of zero
      sparc: use fallback for random_get_entropy() instead of zero
      xtensa: use fallback for random_get_entropy() instead of zero
      random: insist on random_get_entropy() existing in order to simplify
      random: vary jitter iterations based on cycle counter speed
      random: mix in timestamps and reseed on system restore
      random: do not use batches when !crng_ready()
      random: use first 128 bits of input as fast init
      random: do not pretend to handle premature next security model
      random: order timer entropy functions below interrupt functions
      random: do not use input pool from hard IRQs
      random: help compiler out with fast_mix() by using simpler arguments
      siphash: use one source of truth for siphash permutations
      random32: use real rng for non-deterministic randomness
      random: use symbolic constants for crng_init states
      random: avoid initializing twice in credit race
      random: move initialization out of reseeding hot path
      random: remove ratelimiting for in-kernel unseeded randomness
      random: use proper jiffies comparison macro
      random: handle latent entropy and command line from random_init()
      random: credit architectural init the exact amount
      random: use static branch for crng_ready()
      random: remove extern from functions in header
      random: use proper return types on get_random_{int,long}_wait()
      random: make consistent use of buf and len
      random: move initialization functions out of hot pages
      random: remove get_random_bytes_arch() and add rng_has_arch_random()
      random: remove mostly unused async readiness notifier
      random: move randomize_page() into mm where it belongs
      random: unify batched entropy implementations
      random: check for signals after page of pool writes

Jens Axboe (3):
      random: convert to using fops->read_iter()
      random: convert to using fops->write_iter()
      random: wire up fops->splice_{read,write}_iter()

 Documentation/admin-guide/sysctl/kernel.rst |    8 +-
 arch/alpha/include/asm/timex.h              |    1 +
 arch/arm/include/asm/timex.h                |    1 +
 arch/ia64/include/asm/timex.h               |    1 +
 arch/m68k/include/asm/timex.h               |    2 +-
 arch/mips/include/asm/timex.h               |   17 +-
 arch/nios2/include/asm/timex.h              |    3 +
 arch/openrisc/include/asm/timex.h           |    1 +
 arch/openrisc/kernel/head.S                 |    9 +
 arch/parisc/include/asm/timex.h             |    3 +-
 arch/powerpc/include/asm/timex.h            |    1 +
 arch/riscv/include/asm/timex.h              |    2 +-
 arch/s390/include/asm/timex.h               |    1 +
 arch/sparc/include/asm/timex_32.h           |    4 +-
 arch/um/include/asm/timex.h                 |    9 +-
 arch/x86/include/asm/timex.h                |    9 +
 arch/x86/include/asm/tsc.h                  |    7 +-
 arch/xtensa/include/asm/timex.h             |    6 +-
 drivers/char/random.c                       | 1346 +++++++++++----------------
 include/linux/mm.h                          |    1 +
 include/linux/prandom.h                     |   61 +-
 include/linux/random.h                      |   90 +-
 include/linux/siphash.h                     |   28 +
 include/linux/timex.h                       |    8 +
 init/main.c                                 |   13 +-
 kernel/time/timekeeping.c                   |   15 +
 kernel/time/timer.c                         |    2 -
 lib/Kconfig.debug                           |    3 +-
 lib/random32.c                              |  347 +------
 lib/siphash.c                               |   32 +-
 lib/vsprintf.c                              |   67 +-
 mm/util.c                                   |   32 +
 net/core/dev.c                              |    3 -
 net/ipv4/devinet.c                          |    4 +-
 net/ipv6/addrconf.c                         |    2 -
 35 files changed, 784 insertions(+), 1355 deletions(-)
