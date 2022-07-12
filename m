Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9256571A00
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiGLMas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiGLMal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:30:41 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6351437FB8;
        Tue, 12 Jul 2022 05:30:40 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP9Jnac1icVQZAA--.16223S2;
        Tue, 12 Jul 2022 20:30:38 +0800 (CST)
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongchen Zhang <zhanghongchen@loongson.cn>
Subject: [PATCH v2] MIPS: fix pmd_mkinvalid
Date:   Tue, 12 Jul 2022 20:30:29 +0800
Message-Id: <1657629029-27799-1-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9DxP9Jnac1icVQZAA--.16223S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur43Zry7GF45ZF15tw1UJrb_yoW5Ww4Dpa
        n7AF9Y9rWYg34IyayYyr92gr15ArsxKFZ0gryDWr1jva43XrZ7Xrn3KwnIyFy8XayvyFy8
        WrWSqan8GrWIv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  There is a problem now:
	    CPU 0		CPU 1
	pmdp_invalidate		do_page_fault
	...			  __handle_mm_fault
				    is_swap_pmd == true
				    trigger VM_BUG_ON() ?
	set_pmd_at
  the reason is when a pmd entry is invalidated by pmd_mkinvalid,
  pmd_present should return true but now pmd_present return false.

  Like arm64 does in
  commit b65399f6111b ("arm64/mm: Change THP helpers to comply with
  generic MM semantics"). we introduce a _PMD_PRESENT_INVALID_SHIFT
  bit to check if a pmd is present but invalidated by pmd_mkinvalid.

  After this commit pmd_present will return the correct value and
  the VM_BUG_ON will not be triggered.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 arch/mips/include/asm/pgtable-64.h   | 2 +-
 arch/mips/include/asm/pgtable-bits.h | 2 ++
 arch/mips/include/asm/pgtable.h      | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 41921ac..050cf66 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -265,7 +265,7 @@ static inline int pmd_present(pmd_t pmd)
 {
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
-		return pmd_val(pmd) & _PAGE_PRESENT;
+		return pmd_val(pmd) & (_PAGE_PRESENT | _PMD_PRESENT_INVALID);
 #endif
 
 	return pmd_val(pmd) != (unsigned long) invalid_pte_table;
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index 2362842..72cd88a 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -130,6 +130,7 @@ enum pgtable_bits {
 	_PAGE_MODIFIED_SHIFT,
 #if defined(CONFIG_MIPS_HUGE_TLB_SUPPORT)
 	_PAGE_HUGE_SHIFT,
+	_PMD_PRESENT_INVALID_SHIFT,
 #endif
 #if defined(CONFIG_ARCH_HAS_PTE_SPECIAL)
 	_PAGE_SPECIAL_SHIFT,
@@ -157,6 +158,7 @@ enum pgtable_bits {
 #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
 #if defined(CONFIG_MIPS_HUGE_TLB_SUPPORT)
 # define _PAGE_HUGE		(1 << _PAGE_HUGE_SHIFT)
+#define _PMD_PRESENT_INVALID	(1 << _PMD_PRESENT_INVALID_SHIFT)
 #endif
 #if defined(CONFIG_ARCH_HAS_PTE_SPECIAL)
 # define _PAGE_SPECIAL		(1 << _PAGE_SPECIAL_SHIFT)
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 374c632..a75f461 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -696,12 +696,15 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 	return pmd;
 }
 
+#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 {
+	pmd_val(pmd) |= _PMD_PRESENT_INVALID;
 	pmd_val(pmd) &= ~(_PAGE_PRESENT | _PAGE_VALID | _PAGE_DIRTY);
 
 	return pmd;
 }
+#endif
 
 /*
  * The generic version pmdp_huge_get_and_clear uses a version of pmd_clear() with a
-- 
1.8.3.1

