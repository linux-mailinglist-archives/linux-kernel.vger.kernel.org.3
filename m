Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967535686B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiGFL3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiGFL3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:29:50 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C550925C49
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:29:48 -0700 (PDT)
Received: from lingfengzhe-ms7c94.loongson.cn (unknown [192.168.200.1])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxKeEicsViT60MAA--.38242S2;
        Wed, 06 Jul 2022 19:29:39 +0800 (CST)
From:   huqi <huqi@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Qi Hu <huqi@loongson.cn>
Subject: [PATCH v3] LoongArch: Remove vcsr in loongarch_fpu
Date:   Wed,  6 Jul 2022 19:29:37 +0800
Message-Id: <20220706112937.1218573-1-huqi@loongson.cn>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxKeEicsViT60MAA--.38242S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr47uw4rZr13Aw15XF1xGrg_yoW5GF15pF
        ZrZrn7GF4rWFn3JFyDt34kWrWkJ3ZrGw1aga4aka4fCr47Xw1UWrWktFyDZFyjqa1rK3y0
        gF1rGw1SqF1DJ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pkxtxqxorr0wxvrqhubq/1tbiAQATCV3QvPxZJgAmsP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qi Hu <huqi@loongson.cn>

The `vcsr` is not used anymore. Remove this member from `loongarch_fpu`.

From 3A5000(LoongArch), `vcsr` is removed in hardware. FP and LSX/LASX
both use `fcsr` as their csr.

Particularly, fcsr from $r16 to $r31 are reserved for LSX/LASX, an
using the registers in this area will cause SXD/ASXD if LSX/LASX is
not enabled.

Signed-off-by: Qi Hu <huqi@loongson.cn>
---
V3:
- Modify commit message to conform to the format.
V2:
- Add more details in the commit message.
---
 arch/loongarch/include/asm/fpregdef.h  |  1 -
 arch/loongarch/include/asm/processor.h |  2 --
 arch/loongarch/kernel/asm-offsets.c    |  1 -
 arch/loongarch/kernel/fpu.S            | 10 ----------
 4 files changed, 14 deletions(-)

diff --git a/arch/loongarch/include/asm/fpregdef.h b/arch/loongarch/include/asm/fpregdef.h
index adb16e4b43b0..b6be527831dd 100644
--- a/arch/loongarch/include/asm/fpregdef.h
+++ b/arch/loongarch/include/asm/fpregdef.h
@@ -48,6 +48,5 @@
 #define fcsr1	$r1
 #define fcsr2	$r2
 #define fcsr3	$r3
-#define vcsr16	$r16
 
 #endif /* _ASM_FPREGDEF_H */
diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
index 1d63c934b289..57ec45aa078e 100644
--- a/arch/loongarch/include/asm/processor.h
+++ b/arch/loongarch/include/asm/processor.h
@@ -80,7 +80,6 @@ BUILD_FPR_ACCESS(64)
 
 struct loongarch_fpu {
 	unsigned int	fcsr;
-	unsigned int	vcsr;
 	uint64_t	fcc;	/* 8x8 */
 	union fpureg	fpr[NUM_FPU_REGS];
 };
@@ -161,7 +160,6 @@ struct thread_struct {
 	 */							\
 	.fpu			= {				\
 		.fcsr		= 0,				\
-		.vcsr		= 0,				\
 		.fcc		= 0,				\
 		.fpr		= {{{0,},},},			\
 	},							\
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index bfb65eb2844f..20cd9e16a95a 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -166,7 +166,6 @@ void output_thread_fpu_defines(void)
 
 	OFFSET(THREAD_FCSR, loongarch_fpu, fcsr);
 	OFFSET(THREAD_FCC,  loongarch_fpu, fcc);
-	OFFSET(THREAD_VCSR, loongarch_fpu, vcsr);
 	BLANK();
 }
 
diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
index 75c6ce0682a2..a631a7137667 100644
--- a/arch/loongarch/kernel/fpu.S
+++ b/arch/loongarch/kernel/fpu.S
@@ -146,16 +146,6 @@
 	movgr2fcsr	fcsr0, \tmp0
 	.endm
 
-	.macro sc_save_vcsr base, tmp0
-	movfcsr2gr	\tmp0, vcsr16
-	EX	st.w \tmp0, \base, 0
-	.endm
-
-	.macro sc_restore_vcsr base, tmp0
-	EX	ld.w \tmp0, \base, 0
-	movgr2fcsr	vcsr16, \tmp0
-	.endm
-
 /*
  * Save a thread's fp context.
  */
-- 
2.36.1

