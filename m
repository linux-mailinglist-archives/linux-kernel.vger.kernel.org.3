Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84EE4FE6F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358171AbiDLRdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358275AbiDLRc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:32:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AE756422;
        Tue, 12 Apr 2022 10:30:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 53882CE199D;
        Tue, 12 Apr 2022 17:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F87EC385A1;
        Tue, 12 Apr 2022 17:29:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IGqH+Yt+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649784593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cpbrBqankh2fsmUUGS4FsleJ1lhokYXdTSW/sLYtQ34=;
        b=IGqH+Yt+TH/awWcML7+P4pTZAJ7vUKOoeTjgS80fkMNvRIanyEye8oWsTtwOEO/JteClTZ
        cNL6BWsiDaAhrLKgDy/7ihZyCJBRzKbJbE+/8XImGQoXwazt1CybSDia84OUDubwKS2Gt2
        /vtAxFfC+bBVKO5EodD+RrfNWWRpG2I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5f9f93aa (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 12 Apr 2022 17:29:53 +0000 (UTC)
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
Subject: [PATCH v3 05/10] arm: use fallback for random_get_entropy() instead of zero
Date:   Tue, 12 Apr 2022 19:27:49 +0200
Message-Id: <20220412172754.149498-6-Jason@zx2c4.com>
In-Reply-To: <20220412172754.149498-1-Jason@zx2c4.com>
References: <20220412172754.149498-1-Jason@zx2c4.com>
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

In the event that random_get_entropy() can't access a cycle counter or
similar, falling back to returning 0 is really not the best we can do.
Instead, at least calling random_get_entropy_fallback() would be
preferable, because that always needs to return _something_, even
falling back to jiffies eventually. It's not as though
random_get_entropy_fallback() is super high precision or guaranteed to
be entropic, but basically anything that's not zero all the time is
better than returning zero all the time.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/arm/include/asm/timex.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/timex.h b/arch/arm/include/asm/timex.h
index 7c3b3671d6c2..6d1337c169cd 100644
--- a/arch/arm/include/asm/timex.h
+++ b/arch/arm/include/asm/timex.h
@@ -11,5 +11,6 @@
 
 typedef unsigned long cycles_t;
 #define get_cycles()	({ cycles_t c; read_current_timer(&c) ? 0 : c; })
+#define random_get_entropy() (((unsigned long)get_cycles()) ?: random_get_entropy_fallback())
 
 #endif
-- 
2.35.1

