Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568AE47AACE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhLTOAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:00:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48224 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbhLTOAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:00:48 -0500
Date:   Mon, 20 Dec 2021 14:00:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640008846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WAcZAKtXFKtoDsVERA4s2WTs2X+uQUslzNXL6WnvQ+s=;
        b=MHveO++m4e1v7k4QAq+/Y6J6e8kC3XJm/UfAaTvOAjRglvdfUapvA1hSP+M5NrBZ+lKpmL
        817CGuTBDlneC+dxlz53/a2bF4lQHMFHXR2qnnw9yzUoVpMuL+mPV2f2dVsCIwFSirgu3B
        q1GzLa9dsGERJMUsQxClonwGn5SHG0s1mRwaa2fygOPg52FWWM7fhzBJHrdEI8nAXxpHvm
        12I56konBPrWGLW3X7L443uWue7U+6gKTZnp3++l47e9AzZEjxbeIJL6FuvlMh1N7cReJH
        lXsLosNqfOsAfyEZnc9PoHrFOoHmu7YESYhkF59rmlucSPp82dTu9dUuoDznvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640008846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WAcZAKtXFKtoDsVERA4s2WTs2X+uQUslzNXL6WnvQ+s=;
        b=Y8RRCqL43L+ndGIuIJemJod38RCfXaJpewE99e05bXI+YKa7JdiacbnPkSVCD8uxWCtKEc
        eUCrStBkYbtzpkCw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] KVM: arm64: Rework kvm_pgtable initialisation
Cc:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211129200150.351436-5-maz@kernel.org>
References: <20211129200150.351436-5-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164000884510.23020.16603905522171609302.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9d8604b28575ccab3afd8d6f56cab9a6c0d281ef
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9d8604b28575ccab3afd8d6f56cab9a6c0d281ef
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 29 Nov 2021 20:00:45 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 16 Dec 2021 17:01:05 

KVM: arm64: Rework kvm_pgtable initialisation

Ganapatrao reported that the kvm_pgtable->mmu pointer is more or
less hardcoded to the main S2 mmu structure, while the nested
code needs it to point to other instances (as we have one instance
per nested context).

Rework the initialisation of the kvm_pgtable structure so that
this assumtion doesn't hold true anymore. This requires some
minor changes to the order in which things are initialised
(the mmu->arch pointer being the critical one).

Reported-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Reviewed-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211129200150.351436-5-maz@kernel.org
---
 arch/arm64/include/asm/kvm_pgtable.h  |  9 ++++-----
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  4 ++--
 arch/arm64/kvm/hyp/pgtable.c          |  6 +++---
 arch/arm64/kvm/mmu.c                  |  4 ++--
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 0277838..8b808e7 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -270,8 +270,7 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift);
 /**
  * __kvm_pgtable_stage2_init() - Initialise a guest stage-2 page-table.
  * @pgt:	Uninitialised page-table structure to initialise.
- * @arch:	Arch-specific KVM structure representing the guest virtual
- *		machine.
+ * @mmu:	S2 MMU context for this S2 translation
  * @mm_ops:	Memory management callbacks.
  * @flags:	Stage-2 configuration flags.
  * @force_pte_cb: Function that returns true if page level mappings must
@@ -279,13 +278,13 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift);
  *
  * Return: 0 on success, negative error code on failure.
  */
-int __kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_arch *arch,
+int __kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu,
 			      struct kvm_pgtable_mm_ops *mm_ops,
 			      enum kvm_pgtable_stage2_flags flags,
 			      kvm_pgtable_force_pte_cb_t force_pte_cb);
 
-#define kvm_pgtable_stage2_init(pgt, arch, mm_ops) \
-	__kvm_pgtable_stage2_init(pgt, arch, mm_ops, 0, NULL)
+#define kvm_pgtable_stage2_init(pgt, mmu, mm_ops) \
+	__kvm_pgtable_stage2_init(pgt, mmu, mm_ops, 0, NULL)
 
 /**
  * kvm_pgtable_stage2_destroy() - Destroy an unused guest stage-2 page-table.
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index c1a90dd..7d7b703 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -103,19 +103,19 @@ int kvm_host_prepare_stage2(void *pgt_pool_base)
 
 	prepare_host_vtcr();
 	hyp_spin_lock_init(&host_kvm.lock);
+	mmu->arch = &host_kvm.arch;
 
 	ret = prepare_s2_pool(pgt_pool_base);
 	if (ret)
 		return ret;
 
-	ret = __kvm_pgtable_stage2_init(&host_kvm.pgt, &host_kvm.arch,
+	ret = __kvm_pgtable_stage2_init(&host_kvm.pgt, mmu,
 					&host_kvm.mm_ops, KVM_HOST_S2_FLAGS,
 					host_stage2_force_pte_cb);
 	if (ret)
 		return ret;
 
 	mmu->pgd_phys = __hyp_pa(host_kvm.pgt.pgd);
-	mmu->arch = &host_kvm.arch;
 	mmu->pgt = &host_kvm.pgt;
 	WRITE_ONCE(mmu->vmid.vmid_gen, 0);
 	WRITE_ONCE(mmu->vmid.vmid, 0);
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index f8ceebe..8cdbc43 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1116,13 +1116,13 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
 }
 
 
-int __kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_arch *arch,
+int __kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu,
 			      struct kvm_pgtable_mm_ops *mm_ops,
 			      enum kvm_pgtable_stage2_flags flags,
 			      kvm_pgtable_force_pte_cb_t force_pte_cb)
 {
 	size_t pgd_sz;
-	u64 vtcr = arch->vtcr;
+	u64 vtcr = mmu->arch->vtcr;
 	u32 ia_bits = VTCR_EL2_IPA(vtcr);
 	u32 sl0 = FIELD_GET(VTCR_EL2_SL0_MASK, vtcr);
 	u32 start_level = VTCR_EL2_TGRAN_SL0_BASE - sl0;
@@ -1135,7 +1135,7 @@ int __kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_arch *arch,
 	pgt->ia_bits		= ia_bits;
 	pgt->start_level	= start_level;
 	pgt->mm_ops		= mm_ops;
-	pgt->mmu		= &arch->mmu;
+	pgt->mmu		= mmu;
 	pgt->flags		= flags;
 	pgt->force_pte_cb	= force_pte_cb;
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 326cdfe..9eec548 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -516,7 +516,8 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
 	if (!pgt)
 		return -ENOMEM;
 
-	err = kvm_pgtable_stage2_init(pgt, &kvm->arch, &kvm_s2_mm_ops);
+	mmu->arch = &kvm->arch;
+	err = kvm_pgtable_stage2_init(pgt, mmu, &kvm_s2_mm_ops);
 	if (err)
 		goto out_free_pgtable;
 
@@ -529,7 +530,6 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
 	for_each_possible_cpu(cpu)
 		*per_cpu_ptr(mmu->last_vcpu_ran, cpu) = -1;
 
-	mmu->arch = &kvm->arch;
 	mmu->pgt = pgt;
 	mmu->pgd_phys = __pa(pgt->pgd);
 	WRITE_ONCE(mmu->vmid.vmid_gen, 0);
