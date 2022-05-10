Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD915211A7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbiEJKGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbiEJKGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:06:30 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7769613C34F;
        Tue, 10 May 2022 03:02:32 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxOtgVOHpi0_UPAA--.222S2;
        Tue, 10 May 2022 18:02:13 +0800 (CST)
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Guo Ren <guoren@kernel.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: fix pmd_bad check for huge pmd
Date:   Tue, 10 May 2022 18:01:48 +0800
Message-Id: <1652176908-22288-1-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9AxOtgVOHpi0_UPAA--.222S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4xWF48Zw4DGw1rWF45Wrg_yoW8Gr1rpF
        srAF9YgFW2gFyfGFy5Ar93Kr13Aa9xGr90gw1q93WDJa45XF47Jrn3Kw1YvF18XayqvFW8
        WFy7XF15Cr4Ivw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a huge pmd is also a bad pmd,so make pmd_bad return 1 when
passed in a huge pmd.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 arch/mips/include/asm/pgtable-32.h | 6 ------
 arch/mips/include/asm/pgtable-64.h | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index 95df9c2..252887b 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -129,12 +129,6 @@ static inline int pmd_none(pmd_t pmd)
 
 static inline int pmd_bad(pmd_t pmd)
 {
-#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
-	/* pmd_huge(pmd) but inline */
-	if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
-		return 0;
-#endif
-
 	if (unlikely(pmd_val(pmd) & ~PAGE_MASK))
 		return 1;
 
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 41921ac..ef52812 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -249,12 +249,6 @@ static inline int pmd_none(pmd_t pmd)
 
 static inline int pmd_bad(pmd_t pmd)
 {
-#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
-	/* pmd_huge(pmd) but inline */
-	if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
-		return 0;
-#endif
-
 	if (unlikely(pmd_val(pmd) & ~PAGE_MASK))
 		return 1;
 
-- 
1.8.3.1

