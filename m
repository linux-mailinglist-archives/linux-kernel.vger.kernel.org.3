Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40B159B137
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 03:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiHUBlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 21:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHUBlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 21:41:07 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22AA8248EF
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 18:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VBrnM
        6CuTzIPpHE+rhpaLE/CGSehyrDcRVlK4nUbzIE=; b=Mb9kOg0kJpdQYOePnhJGp
        UlEbwdcMer7mb3X3KIODhbIv7XCGkeSF+eMTjYlQqteZZ3IYsh6b9QIYhQ9MrRxy
        84QFZy/cFtdqgNhl4YGuRIrpWJaUVIxpyKGneRcI2/Q2fESloPXD4pkxdzrf11lW
        KQR+tiD+ueIgNyIOBEjVP0=
Received: from whoami-VirtualBox.. (unknown [223.72.91.40])
        by smtp10 (Coremail) with SMTP id DsCowAAHhNjQjAFj1eUbCw--.40452S2;
        Sun, 21 Aug 2022 09:39:29 +0800 (CST)
From:   Jinyu Tang <tjytimi@163.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexandre.ghiti@canonical.com,
        guoren@kernel.org, akpm@linux-foundation.org, heiko@sntech.de,
        panqinglin2020@iscas.ac.cn, unnanyong@huawei.com,
        tongtiangen@huawei.com, anshuman.khandual@arm.com,
        anup@brainfault.org
Cc:     atishp@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, falcon@tinylab.org,
        Jinyu Tang <tjytimi@163.com>
Subject: [RFC PATCH v1] riscv: make update_mmu_cache to support asid
Date:   Sun, 21 Aug 2022 09:39:26 +0800
Message-Id: <20220821013926.8968-1-tjytimi@163.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAAHhNjQjAFj1eUbCw--.40452S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFyxGrW8AFyxtr48ZF1UWrg_yoW5Aw4kpF
        srCws5K3yfGrn3Gry2vrZrur1aqw1vg3WSyFWav390qrsIgFyjgF9xK340vr1rJFyrWFWS
        kayayr15u3yYv3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zM6wunUUUUU=
X-Originating-IP: [223.72.91.40]
X-CM-SenderInfo: xwm13xlpl6il2tof0z/1tbiYxFkeFaEKrCgNAAAsy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `update_mmu_cache` function in riscv flush tlb cache without asid
information now, which will flush tlbs in other tasks' address space
even if processor support asid. So add a new function
`flush_tlb_local_one_page` to flush local one page whether processor
supports asid or not. If asid is supported, this function will use it.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
---
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
index 37ed760d007c..a2634ce55626 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -64,6 +64,17 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
 	put_cpu();
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
 void flush_tlb_mm(struct mm_struct *mm)
 {
 	__sbi_tlb_flush_range(mm, 0, -1, PAGE_SIZE);
-- 
2.30.2

