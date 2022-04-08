Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43CB4F9C7F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbiDHSYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238574AbiDHSYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:24:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D47D375A83;
        Fri,  8 Apr 2022 11:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE6E86220D;
        Fri,  8 Apr 2022 18:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CBFC385A3;
        Fri,  8 Apr 2022 18:22:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mm79Jlmn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649442144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Azmq3qhRrdkmHljnnsXC3++LJCKNZe+lfezvnYnc39M=;
        b=mm79Jlmn+haFAeapmSSeR84SfB+kF20VVnX1H8gOS6Bf8q6dkzg7hgzuYdV6/IoFvyGhc+
        ItuQlkzFGEsb+99E3m/AyLbHKsPXgOchjLh7R8DmhjfZMauNBrFmCRpgGwBkz8XmOxov5y
        BXW3244pE066ktXzUnEWutqdW49uT2A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c95c2b8f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 8 Apr 2022 18:22:23 +0000 (UTC)
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
Subject: [PATCH RFC v1 02/10] m68k: use sched_clock() for random_get_entropy() instead of zero
Date:   Fri,  8 Apr 2022 20:21:37 +0200
Message-Id: <20220408182145.142506-3-Jason@zx2c4.com>
In-Reply-To: <20220408182145.142506-1-Jason@zx2c4.com>
References: <20220408182145.142506-1-Jason@zx2c4.com>
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

In the event that random_get_entropy() can't access a cycle counter or
similar, falling back to returning 0 is really not the best we can do.
Instead, at least calling sched_clock() would be preferable, because
that always needs to return _something_, even falling back to jiffies
eventually. It's not as though sched_clock() is super high precision or
guaranteed to be entropic, but basically anything that's not zero all
the time is better than returning zero all the time.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/m68k/include/asm/timex.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/timex.h b/arch/m68k/include/asm/timex.h
index 6a21d9358280..2cd0942097f8 100644
--- a/arch/m68k/include/asm/timex.h
+++ b/arch/m68k/include/asm/timex.h
@@ -7,6 +7,8 @@
 #ifndef _ASMm68K_TIMEX_H
 #define _ASMm68K_TIMEX_H
 
+#include <linux/sched/clock.h>
+
 #ifdef CONFIG_COLDFIRE
 /*
  * CLOCK_TICK_RATE should give the underlying frequency of the tick timer
@@ -35,7 +37,7 @@ static inline unsigned long random_get_entropy(void)
 {
 	if (mach_random_get_entropy)
 		return mach_random_get_entropy();
-	return 0;
+	return sched_clock();
 }
 #define random_get_entropy	random_get_entropy
 
-- 
2.35.1

