Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078094EF863
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350084AbiDAQyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349948AbiDAQyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:54:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9988A41F81
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 09:45:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8062211FB;
        Fri,  1 Apr 2022 09:45:05 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5C0AD3F66F;
        Fri,  1 Apr 2022 09:45:05 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     gcc@gcc.gnu.org, catalin.marinas@arm.com, will@kernel.org,
        marcan@marcan.st, maz@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, szabolcs.nagy@arm.com, f.fainelli@gmail.com,
        opendmb@gmail.com, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] arm64/io: Remind compiler that there is a memory side effect
Date:   Fri,  1 Apr 2022 11:44:06 -0500
Message-Id: <20220401164406.61583-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The relaxed variants of read/write macros are only declared
as `asm volatile()` which forces the compiler to generate the
instruction in the code path as intended. The only problem
is that it doesn't also tell the compiler that there may
be memory side effects. Meaning that if a function is comprised
entirely of relaxed io operations, the compiler may think that
it only has register side effects and doesn't need to be called.

For an example function look at bcmgenet_enable_dma(), before the
relaxed variants were removed. When built with gcc12 the code
contains the asm blocks as expected, but then the function is
never called.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 7fd836bea7eb..3cceda7948a0 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -24,25 +24,25 @@
 #define __raw_writeb __raw_writeb
 static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
 {
-	asm volatile("strb %w0, [%1]" : : "rZ" (val), "r" (addr));
+	asm volatile("strb %w0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
 }
 
 #define __raw_writew __raw_writew
 static inline void __raw_writew(u16 val, volatile void __iomem *addr)
 {
-	asm volatile("strh %w0, [%1]" : : "rZ" (val), "r" (addr));
+	asm volatile("strh %w0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
 }
 
 #define __raw_writel __raw_writel
 static __always_inline void __raw_writel(u32 val, volatile void __iomem *addr)
 {
-	asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
+	asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
 }
 
 #define __raw_writeq __raw_writeq
 static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
 {
-	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
+	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
 }
 
 #define __raw_readb __raw_readb
-- 
2.35.1

