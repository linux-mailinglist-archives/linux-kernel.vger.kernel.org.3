Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40F35659F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiGDPgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiGDPg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:36:29 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4914EB48C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:36:24 -0700 (PDT)
Received: from localhost.localdomain (unknown [223.104.41.228])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX+PsCMNiS8wIAA--.26936S2;
        Mon, 04 Jul 2022 23:36:16 +0800 (CST)
From:   Qi Hu <huqi@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] LoongArch: Clean useless vcsr in loongarch_fpu.
Date:   Mon,  4 Jul 2022 23:36:12 +0800
Message-Id: <20220704153612.314112-1-huqi@loongson.cn>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxX+PsCMNiS8wIAA--.26936S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF15XF47KF43Jw17KF48JFb_yoW5JF1DpF
        ZrZrn7GF4rWrn3JryDt34kWrWkJ3ZrGw1agasIka4fCr47Xw1UWrWvyryDXFyjqa1rK3y0
        gF1rGw1SqF1DJ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_XrWl42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5XJ57UUUUU==
X-CM-SenderInfo: pkxtxqxorr0wxvrqhubq/1tbiAQARCV3QvPwzrgAkst
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `vcsr` is not used anymore. Remove this member from `loongarch_fpu`.

From 3A5000(LoongArch), `vcsr` is removed in hardware. FP and LSX/LASX
both use `fcsr` as their csr.

Particularly, fcsr from $r16 to $r31 are reserved for LSX/LASX, and
using the registers in this area will cause SXD/ASXD if LSX/LASX is
not enabled.

Signed-off-by: Qi Hu <huqi@loongson.cn>
---
V2:
- Add more details in the commit message.
---
 arch/loongarch/include/asm/fpregdef.h  |  1 -
 arch/loongarch/include/asm/processor.h |  2 --
 arch/loongarch/kernel/asm-offsets.c    |  1 -
 arch/loongarch/kernel/fpu.S            | 10 ----------
 4 files changed, 14 deletions(-)

diff --git a/arch/loongarch/include/asm/fpregdef.h b/arch/loongarch/include/asm/fpregdef.h
index adb16e4b4..b6be52783 100644
--- a/arch/loongarch/include/asm/fpregdef.h
+++ b/arch/loongarch/include/asm/fpregdef.h
@@ -48,6 +48,5 @@
 #define fcsr1	$r1
 #define fcsr2	$r2
 #define fcsr3	$r3
-#define vcsr16	$r16
 
 #endif /* _ASM_FPREGDEF_H */
diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
index 1d63c934b..57ec45aa0 100644
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
index bfb65eb28..20cd9e16a 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -166,7 +166,6 @@ void output_thread_fpu_defines(void)
 
 	OFFSET(THREAD_FCSR, loongarch_fpu, fcsr);
 	OFFSET(THREAD_FCC,  loongarch_fpu, fcc);
-	OFFSET(THREAD_VCSR, loongarch_fpu, vcsr);
 	BLANK();
 }
 
diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
index 75c6ce068..a631a7137 100644
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

