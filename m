Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D20253549E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345622AbiEZUkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiEZUki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:40:38 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E10E15F7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653597637; x=1685133637;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IJdm9DSkjzkpq4cQM5uzeP+0z5TWT/S2S0U1NnQ9ajs=;
  b=cjRi6kvGiUqm3LUgzReC9mxZm/0DbYuzuEsHIPujRGiwTYk8xye+ITiS
   9DpVUkCNPwZ6rbcakUyeQ40JByfZ0YNt+NI+LXmhAMoqNeYrPtCmwxS9T
   KySyeyHfiBYjWmG/OnyZJaJK5YqUUbd7iMlAp7J70Rb61d0yotVCUpmCC
   o=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 May 2022 13:40:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 13:40:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 26 May 2022 13:40:36 -0700
Received: from ubuntu.qualcomm.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 26 May
 2022 13:40:34 -0700
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH] KVM: arm64: Fix memory leaks from stage2 pagetable
Date:   Thu, 26 May 2022 16:39:56 -0400
Message-ID: <20220526203956.143873-1-quic_qiancai@quicinc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running some SR-IOV workloads could trigger some leak reports from
kmemleak.

unreferenced object 0xffff080243cef500 (size 128):
  comm "qemu-system-aar", pid 179935, jiffies 4298359506 (age 1629.732s)
  hex dump (first 32 bytes):
    28 00 00 00 01 00 00 00 00 e0 4c 52 03 08 ff ff  (.........LR....
    e0 af a4 7f 7c d1 ff ff a8 3c b3 08 00 80 ff ff  ....|....<......
  backtrace:
     kmem_cache_alloc_trace
     kvm_init_stage2_mmu
     kvm_arch_init_vm
     kvm_create_vm
     kvm_dev_ioctl
     __arm64_sys_ioctl
     invoke_syscall
     el0_svc_common.constprop.0
     do_el0_svc
     el0_svc
     el0t_64_sync_handler
     el0t_64_sync

Since I yet to find a way to reproduce this at will, I just did a code
inspection and found this one spot that could happen. It is unlikely
that will fix my issue because I don't see mine went into the error
paths. But, we should fix it regardless.

If hardware_enable_all() or kvm_init_mmu_notifier() failed in
kvm_create_vm(), we ended up leaking stage2 pagetable memory from
kvm_init_stage2_mmu() because we will no longer call
kvm_arch_flush_shadow_all().

It seems that it is impossible to simply move kvm_free_stage2_pgd() from
kvm_arch_flush_shadow_all() into kvm_arch_destroy_vm() due to the issue
mentioned in the "Fixes" commit below. Thus, fixed it by freeing the
memory from kvm_arch_destroy_vm() only if the MMU notifier is not even
initialized.

Fixes: 293f293637b5 ("kvm-arm: Unmap shadow pagetables properly")
Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
---
 arch/arm64/kvm/arm.c | 3 +++
 arch/arm64/kvm/mmu.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 400bb0fe2745..7d12824f2034 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -180,6 +180,9 @@ vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
  */
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
+	if (!kvm->mmu_notifier.ops)
+		kvm_free_stage2_pgd(&kvm->arch.mmu);
+
 	bitmap_free(kvm->arch.pmu_filter);
 	free_cpumask_var(kvm->arch.supported_cpus);
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index f5651a05b6a8..13a527656ba7 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1739,7 +1739,8 @@ void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen)
 
 void kvm_arch_flush_shadow_all(struct kvm *kvm)
 {
-	kvm_free_stage2_pgd(&kvm->arch.mmu);
+	if (kvm->mmu_notifier.ops)
+		kvm_free_stage2_pgd(&kvm->arch.mmu);
 }
 
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
-- 
2.32.0

