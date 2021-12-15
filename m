Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F49475D17
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244633AbhLOQNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244595AbhLOQND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:13:03 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CFCC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:13:02 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id i15-20020a05600c354f00b0034566ac865bso991553wmq.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rFCgXqXfHcb53cslJUDyyHetn7RW83DsGSg8T2DxbyQ=;
        b=Xbr7DWM55kmOvaqO2GbH+6Sgs0CZAnYI3TRkt/YXsdzrrqRLR/Frivi1pl3MLM/9FO
         j32SKpbCf8SMAOreeXObyBZiz1VTWrQXYlgdUzSK3UiwwzgzmnLA68Y25V9KvNe9N0XM
         3kATi2Bbx3vrZyX/PezVQ1WnN0Gk6aVxD4zGCkhLD1gF+4QZzAYxOzBciVqN/KtL6qfr
         MFVCuO9PnWIyhUmJBVrBtkUcwW0Z5HXykLMP1ZqnW8V88b5/b0Ui7fr3FWkM7uhAOked
         VYssIEAFzkGEPZ41vDG5Cmqg5RHUxdorN+UUKPO33aMzZ3HokfsdK3D8CBYofIZozEZB
         1Dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rFCgXqXfHcb53cslJUDyyHetn7RW83DsGSg8T2DxbyQ=;
        b=GCLv4mDSWgBv9zmZTaUs4N0UeqHdA+Wt4DLqXWo7m49aMWCetOE9/kKqSDaXUsqYd1
         hFKFCB1zrC9weEwj3UtSyWLUAaQozK7CxI8QXqlB3zgaOGHs+7b5cZWFRCjTrMdxDTKB
         zfUMo6KaF21O3P9UV+Roxvf40IZBvr5WD2LWO9n82Cjd1s0rBxgAxWGtULR+4E5BzwUn
         iQLzt502gX+1ZMKZNnFN6tp5+c52W4Yej+EBPqTlnuRZmSYc516rbiG2kPbn607nYyTT
         LHPBWdX298f7E3QheS+L71qGXgvFLwgd0MeVqz1vWqcXdmH37wY0pLpWdGsgtj9Bk6pr
         sHeQ==
X-Gm-Message-State: AOAM531uo1MUTO1QTI4ybRfCzlYwqUBR2QdYCbyBeg5bFtDpkTZCoQd9
        T3eX0Ej5BBQ+qdpLjNcYHKUq1QXqDILk
X-Google-Smtp-Source: ABdhPJy2AtmIuThch2i8/F0tSR53ROmxY1v/z1N9Cj4IaXOuDPzVJjxAElkrPPF8sn6zBbpFTeC0kXQ/6Ul+
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:fc03:4f5b:4e9b:3ec1])
 (user=qperret job=sendgmr) by 2002:a5d:4804:: with SMTP id
 l4mr4979766wrq.629.1639584781079; Wed, 15 Dec 2021 08:13:01 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:12:23 +0000
In-Reply-To: <20211215161232.1480836-1-qperret@google.com>
Message-Id: <20211215161232.1480836-7-qperret@google.com>
Mime-Version: 1.0
References: <20211215161232.1480836-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 06/14] KVM: arm64: Introduce kvm_share_hyp()
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     qperret@google.com, qwandor@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The create_hyp_mappings() function can currently be called at any point
in time. However, its behaviour in protected mode changes widely
depending on when it is being called. Prior to KVM init, it is used to
create the temporary page-table used to bring-up the hypervisor, and
later on it is transparently turned into a 'share' hypercall when the
kernel has lost control over the hypervisor stage-1. In order to prepare
the ground for also unsharing pages with the hypervisor during guest
teardown, introduce a kvm_share_hyp() function to make it clear in which
places a share hypercall should be expected, as we will soon need a
matching unshare hypercall in all those places.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h |  1 +
 arch/arm64/kvm/arm.c             |  4 ++--
 arch/arm64/kvm/fpsimd.c          |  2 +-
 arch/arm64/kvm/mmu.c             | 27 +++++++++++++++++++++------
 arch/arm64/kvm/reset.c           |  2 +-
 5 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 02d378887743..185d0f62b724 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -150,6 +150,7 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 #include <asm/kvm_pgtable.h>
 #include <asm/stage2_pgtable.h>
 
+int kvm_share_hyp(void *from, void *to);
 int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
 int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 			   void __iomem **kaddr,
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 9b745d2bc89a..c202abb448b1 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -146,7 +146,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (ret)
 		return ret;
 
-	ret = create_hyp_mappings(kvm, kvm + 1, PAGE_HYP);
+	ret = kvm_share_hyp(kvm, kvm + 1);
 	if (ret)
 		goto out_free_stage2_pgd;
 
@@ -342,7 +342,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (err)
 		return err;
 
-	return create_hyp_mappings(vcpu, vcpu + 1, PAGE_HYP);
+	return kvm_share_hyp(vcpu, vcpu + 1);
 }
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 5526d79c7b47..86899d3aa9a9 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -30,7 +30,7 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 	struct user_fpsimd_state *fpsimd = &current->thread.uw.fpsimd_state;
 
 	/* Make sure the host task fpsimd state is visible to hyp: */
-	ret = create_hyp_mappings(fpsimd, fpsimd + 1, PAGE_HYP);
+	ret = kvm_share_hyp(fpsimd, fpsimd + 1);
 	if (!ret)
 		vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index ea840fa223b5..872137fb5e0f 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -299,6 +299,25 @@ static int pkvm_share_hyp(phys_addr_t start, phys_addr_t end)
 	return 0;
 }
 
+int kvm_share_hyp(void *from, void *to)
+{
+	if (is_kernel_in_hyp_mode())
+		return 0;
+
+	/*
+	 * The share hcall maps things in the 'fixed-offset' region of the hyp
+	 * VA space, so we can only share physically contiguous data-structures
+	 * for now.
+	 */
+	if (is_vmalloc_or_module_addr(from) || is_vmalloc_or_module_addr(to))
+		return -EINVAL;
+
+	if (kvm_host_owns_hyp_mappings())
+		return create_hyp_mappings(from, to, PAGE_HYP);
+
+	return pkvm_share_hyp(__pa(from), __pa(to));
+}
+
 /**
  * create_hyp_mappings - duplicate a kernel virtual address range in Hyp mode
  * @from:	The virtual kernel start address of the range
@@ -319,12 +338,8 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 	if (is_kernel_in_hyp_mode())
 		return 0;
 
-	if (!kvm_host_owns_hyp_mappings()) {
-		if (WARN_ON(prot != PAGE_HYP))
-			return -EPERM;
-		return pkvm_share_hyp(kvm_kaddr_to_phys(from),
-				      kvm_kaddr_to_phys(to));
-	}
+	if (!kvm_host_owns_hyp_mappings())
+		return -EPERM;
 
 	start = start & PAGE_MASK;
 	end = PAGE_ALIGN(end);
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index c7a0249df840..e3e2a79fbd75 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -113,7 +113,7 @@ static int kvm_vcpu_finalize_sve(struct kvm_vcpu *vcpu)
 	if (!buf)
 		return -ENOMEM;
 
-	ret = create_hyp_mappings(buf, buf + reg_sz, PAGE_HYP);
+	ret = kvm_share_hyp(buf, buf + reg_sz);
 	if (ret) {
 		kfree(buf);
 		return ret;
-- 
2.34.1.173.g76aa8bc2d0-goog

