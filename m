Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA745568320
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiGFJLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiGFJLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:11:04 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E405E252A3;
        Wed,  6 Jul 2022 02:07:49 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axn+LbUMVi83YMAA--.37951S2;
        Wed, 06 Jul 2022 17:07:44 +0800 (CST)
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongchen Zhang <zhanghongchen@loongson.cn>
Subject: [PATCH] MIPS: fix pmd_mkinvalid
Date:   Wed,  6 Jul 2022 17:07:36 +0800
Message-Id: <1657098456-29244-1-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9Axn+LbUMVi83YMAA--.37951S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDZw1ftw4DtrW3Ww4DJwb_yoW5Cw1fp3
        WkAa9YkrW5K34IyFW3tr1ftr15ZrZrKF9Ygryqgr1jya43X397Jrn3G34ktFy8Ja1qvFy8
        Gr13XFs8GrWxZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkI14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a pmd entry is invalidated by pmd_mkinvalid,pmd_present should
return true.
So introduce a _PAGE_PRESENT_INVALID_SHIFT bit to check if a pmd is
present but invalidated by pmd_mkinvalid.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 arch/mips/include/asm/pgtable-64.h   | 2 +-
 arch/mips/include/asm/pgtable-bits.h | 5 +++++
 arch/mips/include/asm/pgtable.h      | 3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 41921ac..1c5ef41 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -265,7 +265,7 @@ static inline int pmd_present(pmd_t pmd)
 {
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
-		return pmd_val(pmd) & _PAGE_PRESENT;
+		return pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PRESENT_INVALID);
 #endif
 
 	return pmd_val(pmd) != (unsigned long) invalid_pte_table;
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 2362842..3c176a1e 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -49,6 +49,7 @@ enum pgtable_bits {
 
 	/* Used only by software (masked out before writing EntryLo*) */
 	_PAGE_PRESENT_SHIFT = 24,
+	_PAGE_PRESENT_INVALID_SHIFT,
 	_PAGE_WRITE_SHIFT,
 	_PAGE_ACCESSED_SHIFT,
 	_PAGE_MODIFIED_SHIFT,
@@ -80,6 +81,7 @@ enum pgtable_bits {
 
 	/* Used only by software (masked out before writing EntryLo*) */
 	_PAGE_PRESENT_SHIFT = _CACHE_SHIFT + 3,
+	_PAGE_PRESENT_INVALID_SHIFT,
 	_PAGE_NO_READ_SHIFT,
 	_PAGE_WRITE_SHIFT,
 	_PAGE_ACCESSED_SHIFT,
@@ -98,6 +100,7 @@ enum pgtable_bits {
 enum pgtable_bits {
 	/* Used only by software (writes to EntryLo ignored) */
 	_PAGE_PRESENT_SHIFT,
+	_PAGE_PRESENT_INVALID_SHIFT,
 	_PAGE_NO_READ_SHIFT,
 	_PAGE_WRITE_SHIFT,
 	_PAGE_ACCESSED_SHIFT,
@@ -122,6 +125,7 @@ enum pgtable_bits {
 enum pgtable_bits {
 	/* Used only by software (masked out before writing EntryLo*) */
 	_PAGE_PRESENT_SHIFT,
+	_PAGE_PRESENT_INVALID_SHIFT,
 #if !defined(CONFIG_CPU_HAS_RIXI)
 	_PAGE_NO_READ_SHIFT,
 #endif
@@ -152,6 +156,7 @@ enum pgtable_bits {
 
 /* Used only by software */
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
+#define _PAGE_PRESENT_INVALID	(1 << _PAGE_PRESENT_INVALID_SHIFT)
 #define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
 #define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
 #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 374c632..cc80211 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -698,7 +698,8 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 
 static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 {
-	pmd_val(pmd) &= ~(_PAGE_PRESENT | _PAGE_VALID | _PAGE_DIRTY);
+	pmd_val(pmd) |= _PAGE_PRESENT_INVALID;
+	pmd_val(pmd) &= ~(_PAGE_PRESENT | _PAGE_VALID);
 
 	return pmd;
 }
-- 
1.8.3.1

