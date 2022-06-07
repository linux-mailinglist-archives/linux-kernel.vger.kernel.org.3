Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C522D54016A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245519AbiFGObe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244411AbiFGObc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:31:32 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A6FD106
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:31:29 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1nyaEv-0008Ra-ME; Tue, 07 Jun 2022 16:31:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, mick@ics.forth.gr,
        samuel@sholland.org, cmuellner@linux.com, philipp.tomsich@vrull.eu,
        hch@lst.de, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 1/2] riscv: introduce nops and __nops macros for NOP sequences
Date:   Tue,  7 Jun 2022 16:30:58 +0200
Message-Id: <20220607143059.1054074-2-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220607143059.1054074-1-heiko@sntech.de>
References: <20220607143059.1054074-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NOP sequences tend to get used for padding out alternative sections

This change adds macros for generating these sequences as both inline
asm blocks, but also as strings suitable for embedding in other asm
blocks directly.

It essentially mimics similar functionality from arm64 introduced by
Wil Deacon in commit f99a250cb6a3 ("arm64: barriers: introduce nops
and __nops macros for NOP sequences").

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/include/asm/asm.h     | 15 +++++++++++++++
 arch/riscv/include/asm/barrier.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 618d7c5af1a2..1b471ff73178 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -67,4 +67,19 @@
 #error "Unexpected __SIZEOF_SHORT__"
 #endif
 
+#ifdef __ASSEMBLY__
+
+/* Common assembly source macros */
+
+/*
+ * NOP sequence
+ */
+.macro	nops, num
+	.rept	\num
+	nop
+	.endr
+.endm
+
+#endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_RISCV_ASM_H */
diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index d0e24aaa2aa0..110752594228 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -13,6 +13,8 @@
 #ifndef __ASSEMBLY__
 
 #define nop()		__asm__ __volatile__ ("nop")
+#define __nops(n)	".rept	" #n "\nnop\n.endr\n"
+#define nops(n)		__asm__ __volatile__ (__nops(n))
 
 #define RISCV_FENCE(p, s) \
 	__asm__ __volatile__ ("fence " #p "," #s : : : "memory")
-- 
2.35.1

