Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AA950CD97
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiDWVaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbiDWVaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:30:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452C51DA54;
        Sat, 23 Apr 2022 14:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C52BFB80DA9;
        Sat, 23 Apr 2022 21:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655E8C385A5;
        Sat, 23 Apr 2022 21:27:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mxw3tXP3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650749222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pY3GCFkvaKbYFxDCcKwSdJ8N9nXdG8OE4PjRxZGLbwE=;
        b=mxw3tXP3rv19uw0WGrfNZ5vKeN9vdScLNhpiHdV1D7EpFAVPuUI2t27mnVwIz+EPXhdc0N
        DxsrccWIpl1bhZSnO0NPOVu65nNxex7ViVlm3T1mRaL18DWAN+oQeZyXO+p1apZw+pyUO5
        OdzcbE/GPAE1xJDfBMeAuCkH5KtnstM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5c3eede4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 23 Apr 2022 21:27:02 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 00/17] archs/random: fallback to best raw ktime when no cycle counter
Date:   Sat, 23 Apr 2022 23:26:06 +0200
Message-Id: <20220423212623.1957011-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Preface for v6: if you're an arch maintainer, a simple Acked-by would
 be appreciated if this looks okay.]

Hi folks,

The RNG uses a function called random_get_entropy() basically anytime
that it needs to timestamp an event. For example, an interrupt comes in,
and we mix a random_get_entropy() into the entropy pool somehow.
Somebody mashes their keyboard or moves their mouse around? We mix a
random_get_entropy() into the entropy pool. It's one of the main
varieties of input.

Unfortunately, it's always 0 on a few platforms. The RNG has accumulated
various hacks to deal with this, but in general it's not great. Surely
we can do better than 0. In fact, *anything* that's not the same exact
value all the time would be better than 0. Even a counter that
increments once per hour would be better than 0! I think you get the
idea.

On most platforms, random_get_entropy() is aliased to get_cycles(),
which makes sense for platforms where get_cycles() is defined. RDTSC,
for example, has all the characteristics we care about for this
function: it's fast to acquire (i.e. acceptable in an irq handler),
pretty high precision, available, forms a 2-monotone distribution, etc.
But for platforms without that, what is the next best thing?

Sometimes the next best thing is architecture-defined. For example,
really old MIPS has the C0 random register, which isn't quite a cycle
counter, but is at least something. However, some platforms don't even
have an architecture-defined fallback.

Fortunately, the timekeeping subsystem has already solved this problem
of trying to determine what the least bad clock is on constrained
systems, falling back to jiffies in the worst case. By exporting the raw
clock, we can get a decent fallback function for when there's no cycle
counter or architecture-specific function.

This series makes the RNG more useful on: m68k, RISC-V, MIPS, ARM32,
NIOS II, SPARC32, Xtensa, OpenRISC, and Usermode Linux. Previously these
platforms would, in certain circumstances, but out of luck with regards to
having any type of event timestamping source in the RNG.

Finally, note that this series isn't about "jitter entropy" or other
ways of initializing the RNG. That's a different topic for a different
thread. Please don't let this discussion veer off into that. Here, I'm
just trying to find a good fallback counter/timer for platforms without
get_cycles(), a question with limited scope.

If this (or a future revision) looks good to you all and receives the
requisite acks, my plan was to take these through the random.git tree
for 5.19, so that I can then build on top of it.

Thanks,
Jason

Changes v5->v6:
- Use cpu_feature_enabled() instead of boot_cpu_has() on x86.
- OpenRISC support.
- Define missing `#define get_cycles get_cycles` on various platforms.

Changes v4->v5:
- Do not prototype symbol with 'extern', according to style guide.
- On MIPS, combine random_get_entropy_fallback() with the c0 random
  register in a way that matches the format of the c0 random value, so
  that we get the best of a high precision cycle counter and of larger
  period timer, joined together. As a result, Thomas Bogendoerfer's
  ack on v4 of patch 4 has been dropped, since this is a substantial
  change.

Changes v3->v4:
- Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL.

Changes v2->v3:
- Name the fallback function random_get_entropy_fallback(), so that it
  can be changed out as needed.
- Include header with prototype in timekeeping.c to avoid compiler
  warning.
- Export fallback function symbol.

Changes v1->v2:
- Use ktime_read_raw_clock() instead of sched_clock(), per Thomas'
  suggestion.
- Drop arm64 change.
- Cleanup header inclusion ordering problem.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: David S. Miller <davem@davemloft.net>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: sparclinux@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: x86@kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: openrisc@lists.librecores.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org

Jason A. Donenfeld (17):
  ia64: define get_cycles macro for arch-override
  s390: define get_cycles macro for arch-override
  parisc: define get_cycles macro for arch-override
  alpha: define get_cycles macro for arch-override
  powerpc: define get_cycles macro for arch-override
  timekeeping: add raw clock fallback for random_get_entropy()
  m68k: use fallback for random_get_entropy() instead of zero
  riscv: use fallback for random_get_entropy() instead of zero
  mips: use fallback for random_get_entropy() instead of just c0 random
  arm: use fallback for random_get_entropy() instead of zero
  openrisc: use fallback for random_get_entropy() instead of zero
  nios2: use fallback for random_get_entropy() instead of zero
  x86: use fallback for random_get_entropy() instead of zero
  um: use fallback for random_get_entropy() instead of zero
  sparc: use fallback for random_get_entropy() instead of zero
  xtensa: use fallback for random_get_entropy() instead of zero
  random: insist on random_get_entropy() existing in order to simplify

 arch/alpha/include/asm/timex.h    |  1 +
 arch/arm/include/asm/timex.h      |  1 +
 arch/ia64/include/asm/timex.h     |  1 +
 arch/m68k/include/asm/timex.h     |  2 +-
 arch/mips/include/asm/timex.h     | 17 +++---
 arch/nios2/include/asm/timex.h    |  3 ++
 arch/openrisc/include/asm/timex.h |  3 ++
 arch/parisc/include/asm/timex.h   |  3 +-
 arch/powerpc/include/asm/timex.h  |  1 +
 arch/riscv/include/asm/timex.h    |  2 +-
 arch/s390/include/asm/timex.h     |  1 +
 arch/sparc/include/asm/timex_32.h |  4 +-
 arch/um/include/asm/timex.h       |  9 +---
 arch/x86/include/asm/timex.h      | 10 ++++
 arch/x86/include/asm/tsc.h        |  4 +-
 arch/xtensa/include/asm/timex.h   |  6 +--
 drivers/char/random.c             | 89 ++++++++++---------------------
 include/linux/timex.h             |  8 +++
 kernel/time/timekeeping.c         | 10 ++++
 19 files changed, 87 insertions(+), 88 deletions(-)

-- 
2.35.1

