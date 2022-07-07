Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7144569CDD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiGGIMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiGGILx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:11:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FE1E4D176;
        Thu,  7 Jul 2022 01:11:42 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axn+I5lcZiB60OAA--.42042S2;
        Thu, 07 Jul 2022 16:11:41 +0800 (CST)
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongchen Zhang <zhanghongchen@loongson.cn>
Subject: [PATCH] MIPS: fix pmd_mkinvalid
Date:   Thu,  7 Jul 2022 16:11:35 +0800
Message-Id: <1657181495-33004-1-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9Axn+I5lcZiB60OAA--.42042S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUZF4fCFyktrW8ur4Uurg_yoW5Gr15pa
        1kAF9Y9rWYg34IyayYyr1Igr45ArsxKFZ0grWDWr1jqa43Xa97Xrn3K3sIyFy8XayvyFy8
        WrWSqan8GrWIv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
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
So introduce a _PMD_PRESENT_INVALID_SHIFT bit to check if a pmd is
present but invalidated by pmd_mkinvalid.

Reported-by: kernel test robot <lkp@intel.com>
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

