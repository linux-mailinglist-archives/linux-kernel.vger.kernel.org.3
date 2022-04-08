Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C314F9C94
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiDHSZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbiDHSYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:24:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC83937C91E;
        Fri,  8 Apr 2022 11:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5DC4B82CDC;
        Fri,  8 Apr 2022 18:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFAEC385A1;
        Fri,  8 Apr 2022 18:22:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GAIaUJEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649442162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DbIus65zpzI+xHKEAM5+xHyu+CtmATmWW3aZiXwzgc4=;
        b=GAIaUJEC1HUSfuNdrnqAWUTn3284cm/0xfh3fiKI5ZuipFFMuZvPn8LjBm4e+qk0cDLs3N
        9VBsCM134dJPVZQe2Z1dOghNMM/0hI7v2FG5TdMR6v08EqeWuaCzCNYpKR7kcHopDDiZi5
        UhU8/gd1mZNEseTUYlFrm8hfIl5ta+Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 94b0c155 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 8 Apr 2022 18:22:41 +0000 (UTC)
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
Subject: [PATCH RFC v1 04/10] mips: use sched_clock() for random_get_entropy() instead of zero
Date:   Fri,  8 Apr 2022 20:21:39 +0200
Message-Id: <20220408182145.142506-5-Jason@zx2c4.com>
In-Reply-To: <20220408182145.142506-1-Jason@zx2c4.com>
References: <20220408182145.142506-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event that random_get_entropy() can't access a cycle counter or
similar, falling back to returning 0 is really not the best we can do.
Instead, at least calling sched_clock() would be preferable, because
that always needs to return _something_, even falling back to jiffies
eventually. It's not as though sched_clock() is super high precision or
guaranteed to be entropic, but basically anything that's not zero all
the time is better than returning zero all the time.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/mips/include/asm/timex.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
index b05bb70a2e46..1de8ded08bb7 100644
--- a/arch/mips/include/asm/timex.h
+++ b/arch/mips/include/asm/timex.h
@@ -12,6 +12,7 @@
 #ifdef __KERNEL__
 
 #include <linux/compiler.h>
+#include <linux/sched/clock.h>
 
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
@@ -94,7 +95,7 @@ static inline unsigned long random_get_entropy(void)
 	else if (likely(imp != PRID_IMP_R6000 && imp != PRID_IMP_R6000A))
 		return read_c0_random();
 	else
-		return 0;	/* no usable register */
+		return sched_clock();	/* no usable register */
 }
 #define random_get_entropy random_get_entropy
 
-- 
2.35.1

