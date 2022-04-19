Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807F75069A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiDSLUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349339AbiDSLUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:20:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143D42BB28;
        Tue, 19 Apr 2022 04:17:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA8CFB817FB;
        Tue, 19 Apr 2022 11:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5132CC385B0;
        Tue, 19 Apr 2022 11:17:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PcVYt9SB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650367052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lBSB+GbVW1RA54psmCySBgKeJdj9Go3YsJo3/wDGaiE=;
        b=PcVYt9SBS02h+2TTabYtYKU7t5vlZPKFqs8M/Vb8cuHc/E1ppQXO4TNkkSzcRE3nz93k5+
        jME/yQl8yd1CuV3GgvAAiuQ+My9UhE97CajBNabqwHwgu5ykIXy35+wKetjVzLz8gjZwCT
        GzNhh4up7esiOdjlpdOFpQBEE1eFh3E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 417fe66d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 19 Apr 2022 11:17:32 +0000 (UTC)
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
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH v5 01/11] timekeeping: add raw clock fallback for random_get_entropy()
Date:   Tue, 19 Apr 2022 13:16:40 +0200
Message-Id: <20220419111650.1582274-2-Jason@zx2c4.com>
In-Reply-To: <20220419111650.1582274-1-Jason@zx2c4.com>
References: <20220419111650.1582274-1-Jason@zx2c4.com>
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

The addition of random_get_entropy_fallback() provides access to
whichever time source has the highest frequency, which is useful for
gathering entropy on platforms without available cycle counters. It's
not necessarily as good as being able to quickly access a cycle counter
that the CPU has, but it's still something, even when it falls back to
being jiffies-based.

In the event that a given arch does not define get_cycles(), falling
back to the get_cycles() default implementation that returns 0 is really
not the best we can do. Instead, at least calling
random_get_entropy_fallback() would be preferable, because that always
needs to return _something_, even falling back to jiffies eventually.
It's not as though random_get_entropy_fallback() is super high precision
or guaranteed to be entropic, but basically anything that's not zero all
the time is better than returning zero all the time.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/linux/timex.h     |  8 ++++++++
 kernel/time/timekeeping.c | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/timex.h b/include/linux/timex.h
index 5745c90c8800..3871b06bd302 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -62,6 +62,8 @@
 #include <linux/types.h>
 #include <linux/param.h>
 
+unsigned long random_get_entropy_fallback(void);
+
 #include <asm/timex.h>
 
 #ifndef random_get_entropy
@@ -74,8 +76,14 @@
  *
  * By default we use get_cycles() for this purpose, but individual
  * architectures may override this in their asm/timex.h header file.
+ * If a given arch does not have get_cycles(), then we fallback to
+ * using random_get_entropy_fallback().
  */
+#ifdef get_cycles
 #define random_get_entropy()	((unsigned long)get_cycles())
+#else
+#define random_get_entropy()	random_get_entropy_fallback()
+#endif
 #endif
 
 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index dcdcb85121e4..7cd2ec239cae 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -17,6 +17,7 @@
 #include <linux/clocksource.h>
 #include <linux/jiffies.h>
 #include <linux/time.h>
+#include <linux/timex.h>
 #include <linux/tick.h>
 #include <linux/stop_machine.h>
 #include <linux/pvclock_gtod.h>
@@ -2380,6 +2381,15 @@ static int timekeeping_validate_timex(const struct __kernel_timex *txc)
 	return 0;
 }
 
+/**
+ * random_get_entropy_fallback - Returns the raw clock source value,
+ * used by random.c for platforms with no valid random_get_entropy().
+ */
+unsigned long random_get_entropy_fallback(void)
+{
+	return tk_clock_read(&tk_core.timekeeper.tkr_mono);
+}
+EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
 
 /**
  * do_adjtimex() - Accessor function to NTP __do_adjtimex function
-- 
2.35.1

