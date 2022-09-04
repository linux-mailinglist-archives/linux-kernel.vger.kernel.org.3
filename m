Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9B25AC496
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 15:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiIDNzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 09:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiIDNzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 09:55:42 -0400
X-Greylist: delayed 911 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 04 Sep 2022 06:55:40 PDT
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D159813EAB
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=tF31H
        YNBq9FEgUfHe2lhN7dhYzjH0fiHkuXz0eoXuZc=; b=FWYyyObcnG3BL8OQd43pV
        20mqhI0KQw6TqAeeoTpa88KP0GpMcxr9Ey6TfU4o4nO4LnZxNbYkmAxdW3thnDy+
        YI+8moT+PGWYUhynl1UDtfgYY9bsTOtQZjuUvukOy2s9W5VH+jPM/4vIm7LH5V0c
        ofBE9WHLHwYkOqcD8kuB5o=
Received: from whoami-VirtualBox.. (unknown [223.72.91.155])
        by smtp14 (Coremail) with SMTP id EsCowAAHgf8IqhRjP+7qDg--.32759S2;
        Sun, 04 Sep 2022 21:37:12 +0800 (CST)
From:   Jinyu Tang <tjytimi@163.com>
To:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexandre.ghiti@canonical.com,
        guoren@kernel.org, heiko@sntech.de, akpm@linux-foundation.org,
        panqinglin2020@iscas.ac.cn, tongtiangen@huawei.com,
        sunnanyong@huawei.com, anshuman.khandual@arm.com,
        atishp@rivosinc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org, tjytimi@163.com
Subject: [PATCH v2] riscv: make update_mmu_cache to support asid
Date:   Sun,  4 Sep 2022 21:37:10 +0800
Message-Id: <20220904133710.117263-1-tjytimi@163.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAAHgf8IqhRjP+7qDg--.32759S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFy7Cw1rtrWUWr47tw1xGrg_yoW5ZryUpF
        srCws5K3yfGrn3Gry7Zr9I9r13Xw4qg3WayFWav3yYqrsIgFyjgr9xK340vr1rJFyrWFWS
        kayayr15u3yYywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pKLvugUUUUU=
X-Originating-IP: [223.72.91.155]
X-CM-SenderInfo: xwm13xlpl6il2tof0z/1tbiYwhyeFaEK+FoogAAsz
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `update_mmu_cache` function in riscv flush tlb cache without asid
information now, which will flush tlbs in other tasks' address space
even if processor supports asid. So add a new function
`flush_tlb_local_one_page` to flush local one page whether processor
supports asid or not,for cases that need to flush local one page like
function `update_mmu_cache`.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
---
RFC V1 -> V2 : 
1.Rebased on PATCH9 of IPI imporvement series as Anup Patel
suggestion. 
2.Make commit log more clear.

 arch/riscv/include/asm/pgtable.h  |  2 +-
 arch/riscv/include/asm/tlbflush.h |  2 ++
 arch/riscv/mm/tlbflush.c          | 11 +++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7ec936910a96..09ccefa6b6c7 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -415,7 +415,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 	 * Relying on flush_tlb_fix_spurious_fault would suffice, but
 	 * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
 	 */
-	local_flush_tlb_page(address);
+	flush_tlb_local_one_page(vma, address);
 }
 
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 801019381dea..120aeb1c6ecf 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -30,6 +30,7 @@ static inline void local_flush_tlb_page(unsigned long addr)
 #if defined(CONFIG_SMP) && defined(CONFIG_MMU)
 void flush_tlb_all(void);
 void flush_tlb_mm(struct mm_struct *mm);
+void flush_tlb_local_one_page(struct vm_area_struct *vma, unsigned long addr);
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end);
@@ -42,6 +43,7 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 
 #define flush_tlb_all() local_flush_tlb_all()
 #define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
+#define flush_tlb_local_one_page(vma, addr) local_flush_tlb_page(addr)
 
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end)
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 27a7db8eb2c4..0843e1baaf34 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -41,6 +41,17 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
 		local_flush_tlb_all_asid(asid);
 }
 
+void flush_tlb_local_one_page(struct vm_area_struct *vma, unsigned long addr)
+{
+	if (static_branch_unlikely(&use_asid_allocator)) {
+		unsigned long asid = atomic_long_read(&vma->vm_mm->context.id);
+
+		local_flush_tlb_page_asid(addr, asid);
+	} else {
+		local_flush_tlb_page(addr);
+	}
+}
+
 static void __ipi_flush_tlb_all(void *info)
 {
 	local_flush_tlb_all();
-- 
2.30.2

