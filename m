Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055F750CDB9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbiDWVbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbiDWVbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:31:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289173D48C;
        Sat, 23 Apr 2022 14:27:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7775361036;
        Sat, 23 Apr 2022 21:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19344C385A0;
        Sat, 23 Apr 2022 21:27:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ptVZHkxV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650749258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+BMRMjzAy6iI4GKY+lJ3NmTXIu6VzOh08BRnkWwZfU=;
        b=ptVZHkxVKWgRv3STqbZCSIi6mmTybX+qSMCnk6dJEMv5CY6ngtMivRxDaoKBi3opd4i7Qv
        5N4CxocyorYV6gQ/iCOJYVo7HS5W6JjUsZZce5q/sBZTNOb5tCjuh24I9+RfyxnpMHzEiG
        ipBcyIncIiE76+PlLHQMU/rjZbnHASw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3c9ef2f6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 23 Apr 2022 21:27:38 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: [PATCH v6 13/17] x86: use fallback for random_get_entropy() instead of zero
Date:   Sat, 23 Apr 2022 23:26:19 +0200
Message-Id: <20220423212623.1957011-14-Jason@zx2c4.com>
In-Reply-To: <20220423212623.1957011-1-Jason@zx2c4.com>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
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

In the event that random_get_entropy() can't access a cycle counter or
similar, falling back to returning 0 is really not the best we can do.
Instead, at least calling random_get_entropy_fallback() would be
preferable, because that always needs to return _something_, even
falling back to jiffies eventually. It's not as though
random_get_entropy_fallback() is super high precision or guaranteed to
be entropic, but basically anything that's not zero all the time is
better than returning zero all the time.

If CONFIG_X86_TSC=n, then it's possible that we're running on a 486 with
no RDTSC, so we only need the fallback code for that case. While we're
at it, fix up both the new function and the get_cycles() function from
which its derived to use cpu_feature_enabled() rather than boot_cpu_has().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/include/asm/timex.h | 10 ++++++++++
 arch/x86/include/asm/tsc.h   |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/timex.h b/arch/x86/include/asm/timex.h
index a4a8b1b16c0c..2b841c39d876 100644
--- a/arch/x86/include/asm/timex.h
+++ b/arch/x86/include/asm/timex.h
@@ -5,6 +5,16 @@
 #include <asm/processor.h>
 #include <asm/tsc.h>
 
+static inline unsigned long random_get_entropy(void)
+{
+#ifndef CONFIG_X86_TSC
+	if (!cpu_feature_enabled(X86_FEATURE_TSC))
+		return random_get_entropy_fallback();
+#endif
+	return rdtsc();
+}
+#define random_get_entropy random_get_entropy
+
 /* Assume we use the PIT time source for the clock tick */
 #define CLOCK_TICK_RATE		PIT_TICK_RATE
 
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 01a300a9700b..192ea48ec80b 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -21,12 +21,12 @@ extern void disable_TSC(void);
 static inline cycles_t get_cycles(void)
 {
 #ifndef CONFIG_X86_TSC
-	if (!boot_cpu_has(X86_FEATURE_TSC))
+	if (!cpu_feature_enabled(X86_FEATURE_TSC))
 		return 0;
 #endif
-
 	return rdtsc();
 }
+#define get_cycles get_cycles
 
 extern struct system_counterval_t convert_art_to_tsc(u64 art);
 extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
-- 
2.35.1

