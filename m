Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5215F4EEB14
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245057AbiDAKQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbiDAKQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:16:37 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3591E3FB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:14:46 -0700 (PDT)
X-UUID: 2b37edf3aa0d4de39f017586e300f8ec-20220401
X-Spam-Fingerprint: 0
X-GW-Reason: 11101
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HNeS6uumcgOimgeWuoeaguA==
X-Content-Feature: ica/max.line-size 118
        audit/email.address 1
        meta/cnt.alert 1
X-UUID: 2b37edf3aa0d4de39f017586e300f8ec-20220401
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <xieming@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1694784454; Fri, 01 Apr 2022 17:07:47 +0800
X-ns-mid: postfix-6246C11A-3080797115
Received: from localhost.localdomain (unknown [172.20.12.223])
        by cs2c.com.cn (NSMail) with ESMTPA id 0F2E8383C640;
        Fri,  1 Apr 2022 09:08:42 +0000 (UTC)
From:   xieming <xieming@kylinos.cn>
To:     marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com,
        alex.williamson@redhat.com, sashal@kernel.org
Cc:     xieming@kylinos.cn, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: [PATCH v2] kvm/arm64: fixed passthrough gpu into vm on arm64
Date:   Fri,  1 Apr 2022 17:08:28 +0800
Message-Id: <20220401090828.614167-1-xieming@kylinos.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when passthrough some pcie device, such as gpus(including
Nvidia and AMD),kvm will report:"Unsupported FSC: EC=0x24
xFSC=0x21 ESR_EL2=0x92000061" err.the main reason is vfio
ioremap vga memory type by DEVICE_nGnRnE, and kvm setting
memory type to PAGE_S2_DEVICE(DEVICE_nGnRE), but in guestos,
all of device io memory type when ioremapping (including gpu
driver TTM memory type) is setting to MT_NORMAL_NC.

according to ARM64 stage1&stage2 conbining rules.
memory type attributes combining rules:
Normal-WB<Normal-WT<NormalNC<Device-GRE<Device-nGRE<
DevicenGnRE<Device-nGnRnE
Normal-WB is weakest,Device-nGnRnE is strongest.

refferring to 'Arm Architecture Reference Manual Armv8,
for Armv8-A architecture profile' pdf, chapter B2.8
refferring to 'ARM System Memory Management Unit Architecture
Specification SMMU architecture version 3.0 and version 3.1' pdf,
chapter 13.1.5

therefore, the I/O memory attribute of the VM is setting to
DevicenGnRE maybe is a mistake. it causes all device memory
accessing in the virtual machine must be aligned.

To summarize: stage2 memory type cannot be stronger than stage1
in arm64 archtechture.

Signed-off-by: xieming <xieming@kylinos.cn>
---
 arch/arm/include/asm/kvm_mmu.h        |  3 ++-
 arch/arm64/include/asm/kvm_mmu.h      |  3 ++-
 arch/arm64/include/asm/memory.h       |  4 +++-
 arch/arm64/include/asm/pgtable-prot.h |  2 +-
 drivers/vfio/pci/vfio_pci.c           |  7 +++++++
 virt/kvm/arm/mmu.c                    | 19 ++++++++++++++++---
 virt/kvm/arm/vgic/vgic-v2.c           |  2 +-
 7 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 523c499e42db..5c7869d25b62 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -64,7 +64,8 @@ void stage2_unmap_vm(struct kvm *kvm);
 int kvm_alloc_stage2_pgd(struct kvm *kvm);
 void kvm_free_stage2_pgd(struct kvm *kvm);
 int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
-			  phys_addr_t pa, unsigned long size, bool writable);
+			  phys_addr_t pa, unsigned long size,
+			  bool writable, bool writecombine);
 
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run);
 
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index b2558447c67d..3f98286c7498 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -158,7 +158,8 @@ void stage2_unmap_vm(struct kvm *kvm);
 int kvm_alloc_stage2_pgd(struct kvm *kvm);
 void kvm_free_stage2_pgd(struct kvm *kvm);
 int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
-			  phys_addr_t pa, unsigned long size, bool writable);
+			  phys_addr_t pa, unsigned long size,
+			  bool writable, bool writecombine);
 
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run);
 
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 56562ff01076..22565cc8ec20 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -158,13 +158,15 @@
  * Memory types for Stage-2 translation
  */
 #define MT_S2_NORMAL		0xf
+#define MT_S2_NORMAL_NC		0x5
 #define MT_S2_DEVICE_nGnRE	0x1
 
 /*
  * Memory types for Stage-2 translation when ID_AA64MMFR2_EL1.FWB is 0001
- * Stage-2 enforces Normal-WB and Device-nGnRE
+ * Stage-2 enforces Normal-WB and Device-nGnRE and Normal-NC
  */
 #define MT_S2_FWB_NORMAL	6
+#define MT_S2_FWB_NORMAL_NC	5
 #define MT_S2_FWB_DEVICE_nGnRE	1
 
 #ifdef CONFIG_ARM64_4K_PAGES
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index af547be1779b..b94e93135fea 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -88,8 +88,8 @@
 	})
 
 #define PAGE_S2			__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(NORMAL) | PTE_S2_RDONLY | PAGE_S2_XN)
+#define PAGE_S2_NC		__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(NORMAL_NC) | PTE_S2_RDONLY | PAGE_S2_XN)
 #define PAGE_S2_DEVICE		__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(DEVICE_nGnRE) | PTE_S2_RDONLY | PAGE_S2_XN)
-
 #define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
 /* shared+writable pages are clean by default, hence PTE_RDONLY|PTE_WRITE */
 #define PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 51b791c750f1..6f66efb71743 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1452,7 +1452,14 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	}
 
 	vma->vm_private_data = vdev;
+#ifdef CONFIG_ARM64
+	if (vfio_pci_is_vga(pdev))
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	else
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+#else
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+#endif
 	vma->vm_pgoff = (pci_resource_start(pdev, index) >> PAGE_SHIFT) + pgoff;
 
 	/*
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 11103b75c596..a46a58696834 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -206,6 +206,17 @@ static inline void kvm_pgd_populate(pgd_t *pgdp, pud_t *pudp)
 	dsb(ishst);
 }
 
+/**
+ * is_vma_write_combine - check if VMA is mapped with writecombine or not
+ * Return true if VMA mapped with MT_NORMAL_NC otherwise fasle
+ */
+static inline bool is_vma_write_combine(struct vm_area_struct *vma)
+{
+	pteval_t pteval = pgprot_val(vma->vm_page_prot);
+
+	return ((pteval & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_NC));
+}
+
 /*
  * Unmapping vs dcache management:
  *
@@ -1198,7 +1209,8 @@ static int stage2_pmdp_test_and_clear_young(pmd_t *pmd)
  * @size:	The size of the mapping
  */
 int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
-			  phys_addr_t pa, unsigned long size, bool writable)
+			  phys_addr_t pa, unsigned long size,
+			  bool writable, bool writecombine)
 {
 	phys_addr_t addr, end;
 	int ret = 0;
@@ -1209,7 +1221,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 	pfn = __phys_to_pfn(pa);
 
 	for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
-		pte_t pte = pfn_pte(pfn, PAGE_S2_DEVICE);
+		pte_t pte = pfn_pte(pfn, writecombine ? PAGE_S2_NC : PAGE_S2_DEVICE);
 
 		if (writable)
 			pte = kvm_s2pte_mkwrite(pte);
@@ -2135,7 +2147,8 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 
 			ret = kvm_phys_addr_ioremap(kvm, gpa, pa,
 						    vm_end - vm_start,
-						    writable);
+						    writable,
+						    is_vma_write_combine(vma));
 			if (ret)
 				break;
 		}
diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
index 91b14dfacd1d..bc9f5a9a1fd9 100644
--- a/virt/kvm/arm/vgic/vgic-v2.c
+++ b/virt/kvm/arm/vgic/vgic-v2.c
@@ -352,7 +352,7 @@ int vgic_v2_map_resources(struct kvm *kvm)
 	if (!static_branch_unlikely(&vgic_v2_cpuif_trap)) {
 		ret = kvm_phys_addr_ioremap(kvm, dist->vgic_cpu_base,
 					    kvm_vgic_global_state.vcpu_base,
-					    KVM_VGIC_V2_CPU_SIZE, true);
+					    KVM_VGIC_V2_CPU_SIZE, true, false);
 		if (ret) {
 			kvm_err("Unable to remap VGIC CPU to VCPU\n");
 			goto out;
-- 
2.27.0

