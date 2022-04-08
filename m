Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893A44F9C85
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbiDHSYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238550AbiDHSYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:24:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1428B36FB48;
        Fri,  8 Apr 2022 11:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E43CB6220B;
        Fri,  8 Apr 2022 18:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1447C385A3;
        Fri,  8 Apr 2022 18:22:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dfKB5qQm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649442124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZAwWpf2mSTFfhh0jtk2ioJcnGUl1ovRW108xPWCiP1A=;
        b=dfKB5qQmsNNVKpwxv9Cbr2s7qEWtNQzkgJC2RD/cQl+Kg5yaPqQUUxVrp4hQsx7Gr34f8r
        QDaPPI2uQBsYvxEeqkoO1FDW72vygWpLLLY0z7DPDI7fQP2fMh2qAq13X+NIGhh5UufkXE
        UHg7p8K+xKHRdLFGuG+/VvaayEztZPI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4b54fd79 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 8 Apr 2022 18:22:04 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        arnd@arndb.de
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH RFC v1 00/10] archs/random: fallback to using sched_clock() if no cycle counter
Date:   Fri,  8 Apr 2022 20:21:35 +0200
Message-Id: <20220408182145.142506-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
have an architecture-defined fallback. In that case, what are we left
with?

By my first guess, we have ktime_get_boottime_ns(), jiffies, and
sched_clock(). It seems like sched_clock() has already done a lot of
work in being always available with some incrementing value, falling
back to jiffies as necessary. So this series goes with that as a
fallback, for when the architecture doesn't define random_get_entropy in
its own way and when there's no working cycle counter.

Another option would be falling back to different things on different
platforms. For example, Arnd mentioned to me that on m68k,
ktime_get_ns() might be better than sched_clock(), because it doesn't
use CONFIG_GENERIC_SCHED_CLOCK and therefore is only as good as jiffies.
Maybe there are other considerations there as well.

This is a bit involved with plumbing asm/ headers, which is why this is
an RFC. There are a few ways of skinning that cat. The patchset also
tries to fill in the various cases where an arch only sometimes has a
cycle counter and sometimes doesn't. When possible, it tries to make the
decisions at compile time, but sometimes runtime decisions are
necessary.

Please let me know if you think this is sane. And if you have a
different candidate than sched_clock(), I'd be interested to learn about
that. In particular, I'd value input here from Thomas or somebody else
who has looked at timekeeping across less common platforms.

Finally, note that this series isn't about "jitter entropy" or other
ways of initializing the RNG. That's a different topic for a different
thread. Please don't let this discussion veer off into that. Here, I'm
just trying to find a good fallback counter/timer for platforms without
get_cycles(), a question with limited scope.

Thanks,
Jason

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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: sparclinux@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: x86@kernel.org
Cc: linux-xtensa@linux-xtensa.org

Jason A. Donenfeld (10):
  random: use sched_clock() for random_get_entropy() if no get_cycles()
  m68k: use sched_clock() for random_get_entropy() instead of zero
  riscv: use sched_clock() for random_get_entropy() instead of zero
  mips: use sched_clock() for random_get_entropy() instead of zero
  arm: use sched_clock() for random_get_entropy() instead of zero
  x86: use sched_clock() for random_get_entropy() instead of zero
  arm64: use sched_clock() for random_get_entropy() instead of zero
  um: use sched_clock() for random_get_entropy() instead of zero
  sparc: use sched_clock() for random_get_entropy() instead of zero
  xtensa: use sched_clock() for random_get_entropy() instead of zero

 arch/arm/include/asm/timex.h      | 11 +++++++++++
 arch/arm64/include/asm/timex.h    |  9 +++++++++
 arch/m68k/include/asm/timex.h     |  4 +++-
 arch/mips/include/asm/timex.h     |  3 ++-
 arch/riscv/include/asm/timex.h    |  3 ++-
 arch/sparc/include/asm/timex_32.h |  4 +---
 arch/um/include/asm/timex.h       |  9 ++-------
 arch/x86/include/asm/tsc.h        | 11 +++++++++++
 arch/xtensa/include/asm/timex.h   |  6 ++----
 include/linux/timex.h             |  6 ++++++
 10 files changed, 49 insertions(+), 17 deletions(-)

-- 
2.35.1

