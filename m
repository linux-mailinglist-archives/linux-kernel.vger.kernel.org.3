Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7D94DD129
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiCQX3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCQX3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:29:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFA4D3738
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFF0CB8204A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA96C340E9;
        Thu, 17 Mar 2022 23:28:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ka04jWG8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647559704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E+PvMxWcS3ApAYnp0Ppxv3cA5ntFGWMLNNnCr55gGEM=;
        b=ka04jWG8tHwiwpxCLH3hj1y8aKPbUW8Ohp8qh4kcJPa1R8BnTbhpxMDfeLa/uBYiDxhlea
        jFnTS+qAwOvKshFsuz2emu1oZN3awC2uqJn021c+zfJ8IOhgvoeOjR1V5WZHHm7tGOYsw0
        QE6BtfC5qMo/ySZ0rw/fx9Ub1UjDv2M=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 57e948a2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 17 Mar 2022 23:28:23 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator updates for 5.18-rc1
Date:   Thu, 17 Mar 2022 17:28:04 -0600
Message-Id: <20220317232804.931702-1-Jason@zx2c4.com>
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

Please pull the following updates for 5.18-rc1. Since 5.17, there have been a
few important changes to the RNG's crypto, but the intent for 5.18 has been to
shore up the existing design as much as possible with modern cryptographic
functions and proven constructions, rather than actually changing up anything
fundamental to the RNG's design. So it's still the same old RNG at its core as
before: it still counts entropy bits, and collects from the various sources
with the same heuristics as before, and so forth. However, the cryptographic
algorithms that transform that entropic data into safe random numbers have
been modernized.

Just as important, if not more, is that the code has been cleaned up and
re-documented. As one of the first drivers in Linux, going back to 1.3.30, its
general style and organization was showing its age and becoming both a
maintenance burden and an auditability impediment. Hopefully this provides a
more solid foundation to build on for the future. I encourage you to open up
the file in full, and maybe you'll remark, "oh, that's what it's doing," and
enjoy reading it. That, at least, is the eventual goal, which this pull
begins working toward.

Here's a summary of the various patches in this pull:

  1) /dev/urandom and /dev/random now do the same thing, per the patch we
     discussed on the list. I think this is worth trying out. If it does
     appear problematic, I've made sure to keep it standalone and revertible
     without any conflicts.

  2) Fixes and cleanups for numerous integer type problems, locking issues,
     and general code quality concerns.

  3) The input pool's LFSR has been replaced with a cryptographically secure
     hash function, which has security and performance benefits alike, and
     consequently allows us to count entropy bits linearly.

  4) The pre-init injection now uses a real hash function too, instead of an
     LFSR or vanilla xor.

  5) The interrupt handler's fast_mix() function now uses one round of SipHash,
     rather than the fake crypto that was there before.

  6) All additions of RDRAND and RDSEED now go through the input pool's hash
     function, in part to mitigate ridiculous hypothetical CPU backdoors, but
     more so to have a consistent interface for ingesting entropy that's easy
     to analyze, making everything happen one way, instead of a potpourri of
     different ways.

  7) The crng now works on per-cpu data, while also being in accordance with
     the actual "fast key erasure RNG" design. This allows us to fix several
     boot-time race complications associated with the prior dynamically
     allocated model, eliminates much locking, and makes our backtrack
     protection more robust.

  8) Batched entropy now erases doled out values so that it's backtrack
     resistant.

  9) Working closely with Sebastian, the interrupt handler no longer needs to
     take any locks at all, as we punt the synchronized/expensive operations
     to a workqueue. This is especially nice for PREEMPT_RT, where taking
     spinlocks in irq context is problematic. It also makes the handler faster
     for the rest of us.

  10) Also working with Sebastian, we now do the right thing on CPU hotplug,
      so that we don't use stale entropy or fail to accumulate new entropy
      when CPUs come back online.

  11) We handle virtual machines that fork / clone / snapshot, using the
      "vmgenid" ACPI specification for retrieving a unique new RNG seed, which
      we can use to also make WireGuard (and in the future, other things) safe
      across VM forks.

  12) Around boot time, we now try to reseed more often if enough entropy is
      available, before settling on the usual 5 minute schedule.

  13) Last, but certainly not least, the documentation in the file has been
      updated considerably.

Please pull!

Thanks,
Jason

----------------------------------------------------------------

The following changes since commit cfb92440ee71adcc2105b0890bb01ac3cddb8507:

  Linux 5.17-rc5 (2022-02-20 13:07:20 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.18-rc1-for-linus

for you to fetch changes up to 3e504d2026eb6c8762cd6040ae57db166516824a:

  random: check for signal and try earlier when generating entropy (2022-03-12 20:51:39 -0700)

----------------------------------------------------------------

Alexander Graf (1):
      ACPI: allow longer device IDs

Dominik Brodowski (2):
      random: fix locking in crng_fast_load()
      random: fix locking for crng_init in crng_reseed()

Eric Biggers (1):
      random: remove use_input_pool parameter from crng_reseed()

Jason A. Donenfeld (56):
      random: use computational hash for entropy extraction
      random: simplify entropy debiting
      random: use linear min-entropy accumulation crediting
      random: always wake up entropy writers after extraction
      random: make credit_entropy_bits() always safe
      random: remove batched entropy locking
      random: use RDSEED instead of RDRAND in entropy extraction
      random: get rid of secondary crngs
      random: inline leaves of rand_initialize()
      random: ensure early RDSEED goes through mixer on init
      random: do not xor RDRAND when writing into /dev/random
      random: absorb fast pool into input pool after fast load
      random: use simpler fast key erasure flow on per-cpu keys
      random: use hash function for crng_slow_load()
      random: make more consistent use of integer types
      random: remove outdated INT_MAX >> 6 check in urandom_read()
      random: zero buffer after reading entropy from userspace
      random: tie batched entropy generation to base_crng generation
      random: remove ifdef'd out interrupt bench
      random: remove unused tracepoints
      random: add proper SPDX header
      random: deobfuscate irq u32/u64 contributions
      random: introduce drain_entropy() helper to declutter crng_reseed()
      random: remove useless header comment
      random: remove whitespace and reorder includes
      random: group initialization wait functions
      random: group crng functions
      random: group entropy extraction functions
      random: group entropy collection functions
      random: group userspace read/write functions
      random: group sysctl functions
      random: rewrite header introductory comment
      random: defer fast pool mixing to worker
      random: do not take pool spinlock at boot
      random: unify early init crng load accounting
      random: check for crng_init == 0 in add_device_randomness()
      random: pull add_hwgenerator_randomness() declaration into random.h
      random: clear fast pool, crng, and batches in cpuhp bring up
      random: round-robin registers as ulong, not u32
      random: only wake up writers after zap if threshold was passed
      random: cleanup UUID handling
      random: unify cycles_t and jiffies usage and types
      random: do crng pre-init loading in worker rather than irq
      random: block in /dev/urandom
      random: give sysctl_random_min_urandom_seed a more sensible value
      random: don't let 644 read-only sysctls be written to
      random: add mechanism for VM forks to reinitialize crng
      virt: vmgenid: notify RNG of VM fork and supply generation ID
      random: do not export add_vmfork_randomness() unless needed
      random: replace custom notifier chain with standard one
      random: provide notifier for VM fork
      wireguard: device: clear keys on VM fork
      random: use SipHash as interrupt entropy accumulator
      random: make consistent usage of crng_ready()
      random: reseed more often immediately after booting
      random: check for signal and try earlier when generating entropy

 Documentation/admin-guide/sysctl/kernel.rst |   16 +-
 MAINTAINERS                                 |    1 +
 drivers/char/hw_random/core.c               |    1 +
 drivers/char/mem.c                          |    2 +-
 drivers/char/random.c                       | 2939 +++++++++++----------------
 drivers/net/wireguard/device.c              |   38 +-
 drivers/virt/Kconfig                        |   11 +
 drivers/virt/Makefile                       |    1 +
 drivers/virt/vmgenid.c                      |  100 +
 include/linux/cpuhotplug.h                  |    2 +
 include/linux/hw_random.h                   |    2 -
 include/linux/mod_devicetable.h             |    2 +-
 include/linux/random.h                      |   43 +-
 include/trace/events/random.h               |  233 ---
 kernel/cpu.c                                |   11 +
 lib/random32.c                              |   14 +-
 lib/vsprintf.c                              |   10 +-
 17 files changed, 1419 insertions(+), 2007 deletions(-)
 create mode 100644 drivers/virt/vmgenid.c
 delete mode 100644 include/trace/events/random.h
