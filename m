Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958E94FB063
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 23:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbiDJVwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 17:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242749AbiDJVw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 17:52:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93A0F73;
        Sun, 10 Apr 2022 14:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 333E7B80D9C;
        Sun, 10 Apr 2022 21:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83A6C385A1;
        Sun, 10 Apr 2022 21:50:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pYNzQz9R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649627409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LJrd+NtDQlznIg8cc0nDb/z2OXp2bjAbSihY/d2tY4E=;
        b=pYNzQz9RQ5eqsRIdR/NtgerIdGDbtTt3I6e+oJvxWz0XaIbHPRgsz8BXjLJiHUOgL8XO/t
        LhjsNhsKY4qnkJTuwjXjSD8V1g6T66d0ibvN+V52GUS4nxDOfOUG78O4E3K8pL5Fsp7y74
        GcylDa/hG/lBRoQWJyv4JOWd/Cldcz8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 19f87fe0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 10 Apr 2022 21:50:09 +0000 (UTC)
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
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH v2 00/11] archs/random: fallback to using ktime_read_raw_clock() if no cycle counter
Date:   Sun, 10 Apr 2022 23:49:40 +0200
Message-Id: <20220410214951.55294-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
really old MIPS has the CP0 random register, which isn't a cycle
counter, but is at least something. However, some platforms don't even
have an architecture-defined fallback.

Fortunately, the timekeeping subsystem has already solved this problem
of trying to determine what the least bad clock is on constrained
systems, falling back to jiffies in the worst case. By exporting the raw
clock, we can get a decent fallback function for when there's no cycle
counter or architecture-specific function.

This series makes the RNG more useful on: m68k, RISC-V, MIPS, ARM32,
NIOS II, SPARC32, Xtensa, and Usermode Linux. Previously these platforms
would, in certain circumstances, but out of luck with regards to having
any type of event timestamping source in the RNG.

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
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: sparclinux@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: x86@kernel.org
Cc: linux-xtensa@linux-xtensa.org

Jason A. Donenfeld (11):
  timekeeping: add accessor for raw clock
  timekeeping: use ktime_read_raw_clock() for random_get_entropy() if no
    get_cycles()
  m68k: use ktime_read_raw_clock() for random_get_entropy() instead of
    zero
  riscv: use ktime_read_raw_clock() for random_get_entropy() instead of
    zero
  mips: use ktime_read_raw_clock() for random_get_entropy() instead of
    zero
  arm: use ktime_read_raw_clock() for random_get_entropy() instead of
    zero
  nios2: use ktime_read_raw_clock() for random_get_entropy() instead of
    zero
  x86: use ktime_read_raw_clock() for random_get_entropy() instead of
    zero
  um: use ktime_read_raw_clock() for random_get_entropy() instead of
    zero
  sparc: use ktime_read_raw_clock() for random_get_entropy() instead of
    zero
  xtensa: use ktime_read_raw_clock() for random_get_entropy() instead of
    zero

 arch/arm/include/asm/timex.h      |  1 +
 arch/m68k/include/asm/timex.h     |  2 +-
 arch/mips/include/asm/timex.h     |  2 +-
 arch/nios2/include/asm/timex.h    |  2 ++
 arch/riscv/include/asm/timex.h    |  2 +-
 arch/sparc/include/asm/timex_32.h |  4 +---
 arch/um/include/asm/timex.h       |  9 ++-------
 arch/x86/include/asm/tsc.h        | 10 ++++++++++
 arch/xtensa/include/asm/timex.h   |  6 ++----
 include/linux/timex.h             |  8 ++++++++
 kernel/time/timekeeping.c         |  8 ++++++++
 11 files changed, 37 insertions(+), 17 deletions(-)

-- 
2.35.1

