Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC18C5861F4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 01:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238532AbiGaXZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 19:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiGaXZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 19:25:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBE6615E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 16:25:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC104B80D8E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 23:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AE0C433C1;
        Sun, 31 Jul 2022 23:25:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Sf+GxBdq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659309926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8BnkrkCFg02R4zncplwluZlRdfkyzRYEaFEz1D/hs+w=;
        b=Sf+GxBdq0JlppTizg+9PvrPjt0F/B6KVMVYwkXG2OuG856KqvdxxRvuDoHH9MUNvEd66pv
        UtXfCFj94drHtj2ElOolxSH4wgZeYcZQjhHZy0KpNhbkEq3IDJ47f+MRUpDOWDj8+6Pgcy
        Y3HPyjhzv7/XTRyuqFl7anSrmSWEAuE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8dfa38fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 31 Jul 2022 23:25:25 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator updates for 6.0-rc1
Date:   Mon,  1 Aug 2022 01:24:28 +0200
Message-Id: <20220731232428.2219258-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following random number generator updates for 6.0-rc1. Though
there's been a decent amount of RNG-related development during this last
cycle, not all of it is coming through this tree, as this cycle saw a shift
toward tackling early boot time seeding issues, which took place in other
trees as well.

Here's a summary of the various patches:

- The CONFIG_ARCH_RANDOM .config option and the "nordrand" boot option have
  been removed, as they overlapped with the more widely supported and more
  sensible options, CONFIG_RANDOM_TRUST_CPU and "random.trust_cpu". This
  change allowed simplifying a bit of arch code.

  There will be a trivial whitespace merge conflict here with the powerpc
  tree, fixed up by Stephen in next some time ago.

- x86's RDRAND boot time test has been made a bit more robust, with RDRAND
  disabled if it's clearly producing bogus results. This would be a tip.git
  commit, technically, but I took it through random.git to avoid a large merge
  conflict.

- The RNG has long since mixed in a timestamp very early in boot, on the
  premise that a computer that does the same things, but does so starting at
  different points in wall time, could be made to still produce a different
  RNG state. Unfortunately, the clock isn't set early in boot on all systems,
  so now we mix in that timestamp when the time is actually set.

- User Mode Linux now uses the host OS's getrandom() syscall to generate a
  bootloader RNG seed and later on treats getrandom() as the platform's
  RDRAND-like faculty.

- The arch_get_random_{seed_,}_long() family of functions is now
  arch_get_random_{seed_,}_longs(), which enables certain platforms, such as
  s390, to exploit considerable performance advantages from requesting
  multiple CPU random numbers at once, while at the same time compiling down
  to the same code as before on platforms like x86.

  There will be another simple merge conflict here, also fixed up by Stephen
  in next some time ago.

- A small cleanup changing a cmpxchg() into a try_cmpxchg(), from Uros.

- A comment spelling fix.

- Not in this pull: on x86 and m68k, there is now a mechanism for
  bootloaders, hypervisors, and kexec to pass a random seed to the kernel for
  initializing the RNG. These platform-specific mechanisms aren't actually in
  this pull, but will come via the x86 tree and the m68k tree, but they are
  worth mentioning nonetheless.

  Device tree-based architectures have had this capability since 2019, via the
  little-used "rng-seed" parameter in the FDT, and EFI has its own similar
  thing since 2016, but platforms with neither FDT nor EFI were left out.

  These changes correspond with related work in QEMU, slated for release in
  7.1, as well as in kexec-tools, which add support for these bootloader RNG
  seed mechanisms, both the new ones for x86 and m68k, as well as finally
  making use of the "rng-seed" FDT parameter on missing applicable platforms.

  Taken together, these represent a small step toward eliminating the boot
  time entropy issue, at least from the kernel's perspective, by providing a
  means of passing the responsibility up the chain a level. Hypervisors and
  kexec are obviously in an excellent position to provide this, which is why
  I've added it there first. But also, this opens up opportunities for
  bootloaders to safely manage seed files, much like has been done on the BSDs
  and various other operating systems for a long time. And some arm64 firmware
  is already providing this through the "rng-seed" FDT parameter.

- Not in this pull: s390 and ppc had a bit of trouble providing CPU random
  numbers early enough in boot to be useful for seeding the RNG. Various fixes
  for these were taken through the respective arch trees, some during 5.19
  with a few more left for 5.20.

Thanks,
Jason

The following changes since commit 829d680e82a961c5370d9636130b43009ac36eb8:

  random: cap jitter samples per bit to factor of HZ (2022-07-16 10:42:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.0-rc1-for-linus

for you to fetch changes up to 7f637be4d46029bd7700c9f244945a42dbd976fa:

  random: correct spelling of "overwrites" (2022-07-30 01:13:02 +0200)

----------------------------------------------------------------
Random number generator updates for Linux 6.0-rc1.
----------------------------------------------------------------

Jason A. Donenfeld (6):
      random: remove CONFIG_ARCH_RANDOM
      x86/rdrand: Remove "nordrand" flag in favor of "random.trust_cpu"
      timekeeping: contribute wall clock to rng on time change
      um: seed rng using host OS rng
      random: handle archrandom with multiple longs
      random: correct spelling of "overwrites"

Uros Bizjak (1):
      random: use try_cmpxchg in _credit_init_bits

 Documentation/admin-guide/kernel-parameters.txt    |   5 -
 arch/arm/include/asm/archrandom.h                  |   2 +
 arch/arm64/Kconfig                                 |   8 --
 arch/arm64/include/asm/archrandom.h                | 112 +++++++++------------
 arch/arm64/kernel/cpufeature.c                     |   2 -
 arch/arm64/kernel/kaslr.c                          |   2 +-
 arch/powerpc/Kconfig                               |   3 -
 arch/powerpc/include/asm/archrandom.h              |  33 ++----
 arch/powerpc/include/asm/machdep.h                 |   2 -
 arch/powerpc/kvm/book3s_hv.c                       |   2 +-
 arch/powerpc/platforms/microwatt/Kconfig           |   1 -
 arch/powerpc/platforms/powernv/Kconfig             |   1 -
 arch/powerpc/platforms/pseries/Kconfig             |   1 -
 arch/s390/Kconfig                                  |  15 ---
 arch/s390/configs/zfcpdump_defconfig               |   1 -
 arch/s390/crypto/Makefile                          |   2 +-
 arch/s390/include/asm/archrandom.h                 |  32 ++----
 arch/s390/kernel/setup.c                           |   2 -
 arch/um/include/asm/archrandom.h                   |  25 +++++
 arch/um/include/shared/os.h                        |   7 ++
 arch/um/kernel/um_arch.c                           |   8 ++
 arch/um/os-Linux/util.c                            |   6 ++
 arch/x86/Kconfig                                   |   9 --
 arch/x86/include/asm/archrandom.h                  |  55 ++--------
 arch/x86/kernel/cpu/amd.c                          |   2 +-
 arch/x86/kernel/cpu/rdrand.c                       |  59 ++++-------
 arch/x86/kernel/espfix_64.c                        |   2 +-
 drivers/char/Kconfig                               |   1 -
 drivers/char/hw_random/s390-trng.c                 |   9 --
 drivers/char/random.c                              |  51 ++++++----
 include/asm-generic/Kbuild                         |   1 +
 include/asm-generic/archrandom.h                   |  15 +++
 include/linux/random.h                             |  21 ++--
 kernel/time/timekeeping.c                          |   7 +-
 .../testing/selftests/wireguard/qemu/kernel.config |   1 -
 35 files changed, 205 insertions(+), 300 deletions(-)
 create mode 100644 arch/um/include/asm/archrandom.h
 create mode 100644 include/asm-generic/archrandom.h
