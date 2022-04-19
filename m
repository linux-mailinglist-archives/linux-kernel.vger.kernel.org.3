Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F38C50699F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351058AbiDSLWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351082AbiDSLVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:21:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE3932EC0;
        Tue, 19 Apr 2022 04:18:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A022461314;
        Tue, 19 Apr 2022 11:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D114EC385A5;
        Tue, 19 Apr 2022 11:18:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JKEj0xI+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650367084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7p5oHb98nLdh6t5NcfZrOaqAb3m72hJEeYR+oH8QlM8=;
        b=JKEj0xI+gufvmlxqB2NUKU/G3eRiVch/IszY50deFO6RmQiIbw+hpQw+M0R10WZ2insQtM
        J+O5rJVLFk7hw+zhL0+Yo3CCeisiOSufwj5E62QzjfOUFJbQwgbKkov/GcrYHVpnqTDWZg
        b8B1YfmVK6/UX58FLygvJnorbRH59fM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 73c357cd (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 19 Apr 2022 11:18:04 +0000 (UTC)
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
Subject: [PATCH v5 07/11] x86: use fallback for random_get_entropy() instead of zero
Date:   Tue, 19 Apr 2022 13:16:46 +0200
Message-Id: <20220419111650.1582274-8-Jason@zx2c4.com>
In-Reply-To: <20220419111650.1582274-1-Jason@zx2c4.com>
References: <20220419111650.1582274-1-Jason@zx2c4.com>
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

In the event that random_get_entropy() can't access a cycle counter or
similar, falling back to returning 0 is really not the best we can do.
Instead, at least calling random_get_entropy_fallback() would be
preferable, because that always needs to return _something_, even
falling back to jiffies eventually. It's not as though
random_get_entropy_fallback() is super high precision or guaranteed to
be entropic, but basically anything that's not zero all the time is
better than returning zero all the time.

If CONFIG_X86_TSC=n, then it's possible that we're running on a 486 with
no RDTSC, so we only need the fallback code for that case.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/include/asm/timex.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/timex.h b/arch/x86/include/asm/timex.h
index a4a8b1b16c0c..fac180359693 100644
--- a/arch/x86/include/asm/timex.h
+++ b/arch/x86/include/asm/timex.h
@@ -5,6 +5,16 @@
 #include <asm/processor.h>
 #include <asm/tsc.h>
 
+static inline unsigned long random_get_entropy(void)
+{
+#ifndef CONFIG_X86_TSC
+	if (!boot_cpu_has(X86_FEATURE_TSC))
+		return random_get_entropy_fallback();
+#endif
+	return rdtsc();
+}
+#define random_get_entropy random_get_entropy
+
 /* Assume we use the PIT time source for the clock tick */
 #define CLOCK_TICK_RATE		PIT_TICK_RATE
 
-- 
2.35.1

