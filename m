Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6654450CDA7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiDWVb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiDWVbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:31:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844FD2DA9C;
        Sat, 23 Apr 2022 14:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66E5461037;
        Sat, 23 Apr 2022 21:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EC7C385A0;
        Sat, 23 Apr 2022 21:27:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OmGmi1d7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650749247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qw7HzrLJAMiqwJWcj8fLuq9LdY+aV/VnphhmLW9agDo=;
        b=OmGmi1d7JiSHaivA2CJ+c0BDv+W3GzH48CaEnNzOrQl5hIocXEAaqq0KI3EuM1vxvAlvuy
        VRk0ifm647x23uyTztbFSgsHXXT+SppYCp1nrsSeaRzIMnOoKoCrbx5pTNn4AYkdRSVv21
        3pJUdTsMPmKkXKc6MFJtrg34u0a80Lk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c077e6e5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 23 Apr 2022 21:27:27 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH v6 09/17] mips: use fallback for random_get_entropy() instead of just c0 random
Date:   Sat, 23 Apr 2022 23:26:15 +0200
Message-Id: <20220423212623.1957011-10-Jason@zx2c4.com>
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

For situations in which we don't have a c0 counter register available,
we've been falling back to reading the c0 "random" register, which is
usually bounded by the amount of TLB entries and changes every other
cycle or so. This means it wraps extremely often. We can do better by
combining this fast-changing counter with a potentially slower-changing
counter from random_get_entropy_fallback() in the more significant bits.
This commit combines the two, taking into account that the changing bits
are in a different bit position depending on the CPU model. In addition,
we previously were falling back to 0 for ancient CPUs that Linux does
not support anyway; remove that dead path entirely.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/mips/include/asm/timex.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
index b05bb70a2e46..8cfa485d19e6 100644
--- a/arch/mips/include/asm/timex.h
+++ b/arch/mips/include/asm/timex.h
@@ -76,25 +76,24 @@ static inline cycles_t get_cycles(void)
 	else
 		return 0;	/* no usable counter */
 }
+#define get_cycles get_cycles
 
 /*
  * Like get_cycles - but where c0_count is not available we desperately
  * use c0_random in an attempt to get at least a little bit of entropy.
- *
- * R6000 and R6000A neither have a count register nor a random register.
- * That leaves no entropy source in the CPU itself.
  */
 static inline unsigned long random_get_entropy(void)
 {
-	unsigned int prid = read_c0_prid();
-	unsigned int imp = prid & PRID_IMP_MASK;
+	unsigned int c0_random;
 
-	if (can_use_mips_counter(prid))
+	if (can_use_mips_counter(read_c0_prid()))
 		return read_c0_count();
-	else if (likely(imp != PRID_IMP_R6000 && imp != PRID_IMP_R6000A))
-		return read_c0_random();
+
+	if (cpu_has_3kex)
+		c0_random = (read_c0_random() >> 8) & 0x3f;
 	else
-		return 0;	/* no usable register */
+		c0_random = read_c0_random() & 0x3f;
+	return (random_get_entropy_fallback() << 6) | (0x3f - c0_random);
 }
 #define random_get_entropy random_get_entropy
 
-- 
2.35.1

