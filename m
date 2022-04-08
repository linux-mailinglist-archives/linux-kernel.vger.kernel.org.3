Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817E54F9CA7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbiDHS0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbiDHSZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:25:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2E9390CD2;
        Fri,  8 Apr 2022 11:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBF71621EF;
        Fri,  8 Apr 2022 18:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E11C385A5;
        Fri,  8 Apr 2022 18:23:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jQIWOLhO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649442202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yN+amZ/gYA3bch1ZPQw4W7sQ+gf5w/y9JgysyWp/RDk=;
        b=jQIWOLhOUxBvoZusFmG6avdoNOZumfkFzlX9JI+3sz/6LcZi6fiHz50PhiH1f/pdI/MtFy
        m9sMAaUA8mqTbw1Qy+VONizn1MdUAgqLlxFGn0j+LDdVGvybZYqkC9KIQHfkrtMbsi6/b8
        O6Q/CydOHJ0sqZXSrnNhN0PBk1v565E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 28c99cda (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 8 Apr 2022 18:23:22 +0000 (UTC)
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
Subject: [PATCH RFC v1 09/10] sparc: use sched_clock() for random_get_entropy() instead of zero
Date:   Fri,  8 Apr 2022 20:21:44 +0200
Message-Id: <20220408182145.142506-10-Jason@zx2c4.com>
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

This is accomplished by just including the asm-generic code like on
other architectures, which means we can get rid of the empty stub
function here.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/sparc/include/asm/timex_32.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/timex_32.h b/arch/sparc/include/asm/timex_32.h
index 542915b46209..f86326a6f89e 100644
--- a/arch/sparc/include/asm/timex_32.h
+++ b/arch/sparc/include/asm/timex_32.h
@@ -9,8 +9,6 @@
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
 
-/* XXX Maybe do something better at some point... -DaveM */
-typedef unsigned long cycles_t;
-#define get_cycles()	(0)
+#include <asm-generic/timex.h>
 
 #endif
-- 
2.35.1

