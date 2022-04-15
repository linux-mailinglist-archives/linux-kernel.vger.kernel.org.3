Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8449501FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348145AbiDOAqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348110AbiDOAqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:46:16 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A383996832
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:43:50 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id o190-20020a62cdc7000000b0050835e37396so1285031pfg.14
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=VDBBxbRymwn99ifXkPvrfvP8JeLntCySB5qG2FLdHGc=;
        b=FuTYBhDITxI66Qxt5+87xMlO2q0C9iJXI9s7fddQAntJKNcZhy4i5CX3Vpr1K7b1gG
         lpGYjjhgm/CKQjYxIZBLOAlu6Wf9zZOr5BTnS1Mm46MrfyyFviEAqnWwqxLbNvwWcsyf
         JvdoNGNXJ/6sDa03DP7PftstcK+dADaHLntSvUANgU/0B4isfM6BZs4hWPzvL2xkAlhB
         CUMjlksohwVrJztO8x/MgujxI4iPE/ysUfovmABWThXxb2g+rlV8zXfjr6a4wKFGQQ8A
         2BioePglRBUYrzqDp/34X5DBOonLRTI2L6fETCpuSbqRp5Wtv6N/vgi4/Y0xhSy1jDZu
         aMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=VDBBxbRymwn99ifXkPvrfvP8JeLntCySB5qG2FLdHGc=;
        b=CJlk63/TZiKTlzw/pS7DlO5BPHmQMyn2thBddZsMUaaxKR4P8f4aawxLRU9bxG4JK1
         D94/7mwUAnUWMO2p2PhoabrW+60TH/j0y7Tfjv9TC7DwXKQ0a3mmJNKag7EYj6ZfKMOu
         XJ+EVpGxpcLX2PIu6tNYjcO2qrOhHvJWxZwSZrKwe+cZWWpoNq/Wbg850VmvcNXyI69T
         3S5RJlrShQexNX8BeaIU1E+G7mrRF6DL2+UsBJTLHbtfZVytxN27GdUyJ4YqOM7365NX
         n2C460UWRAkkDVM9OFN9oepyMAWry0/MUkzRz84fzn3JYsCkYxmJGiToV93yBXTq7D+L
         TmRw==
X-Gm-Message-State: AOAM531CekqAnEUpj2ye4zzA5GeB8SJ0Yh+XRTWguzyf7plo8tbC3qEz
        zgwmmJ5PX1WJEApuD8JO3/aMDu57adE=
X-Google-Smtp-Source: ABdhPJxWvnh9vGPdu8WwNvP/XothzcdXxz8DVteSxV4BWZ39Cw9eF09ZeKITExpxjd/oejtHjB373C4/RJY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1a90:b0:506:1e27:a579 with SMTP id
 e16-20020a056a001a9000b005061e27a579mr6426109pfv.46.1649983430118; Thu, 14
 Apr 2022 17:43:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Apr 2022 00:43:42 +0000
In-Reply-To: <20220415004343.2203171-1-seanjc@google.com>
Message-Id: <20220415004343.2203171-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220415004343.2203171-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 2/3] KVM: RISC-V: Use kvm_vcpu.srcu_idx, drop RISC-V's
 unnecessary copy
From:   Sean Christopherson <seanjc@google.com>
To:     Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic kvm_vcpu's srcu_idx instead of using an indentical field
in RISC-V's version of kvm_vcpu_arch.  Generic KVM very intentionally
does not touch vcpu->srcu_idx, i.e. there's zero chance of running afoul
of common code.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/riscv/include/asm/kvm_host.h |  3 ---
 arch/riscv/kvm/vcpu.c             | 16 ++++++++--------
 arch/riscv/kvm/vcpu_exit.c        |  4 ++--
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 78da839657e5..cd4bbcecb0fb 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -193,9 +193,6 @@ struct kvm_vcpu_arch {
 
 	/* Don't run the VCPU (blocked) */
 	bool pause;
-
-	/* SRCU lock index for in-kernel run loop */
-	int srcu_idx;
 };
 
 static inline void kvm_arch_hardware_unsetup(void) {}
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 6785aef4cbd4..2f1caf23eed4 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -724,13 +724,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	/* Mark this VCPU ran at least once */
 	vcpu->arch.ran_atleast_once = true;
 
-	vcpu->arch.srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
+	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 	/* Process MMIO value returned from user-space */
 	if (run->exit_reason == KVM_EXIT_MMIO) {
 		ret = kvm_riscv_vcpu_mmio_return(vcpu, vcpu->run);
 		if (ret) {
-			srcu_read_unlock(&vcpu->kvm->srcu, vcpu->arch.srcu_idx);
+			srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 			return ret;
 		}
 	}
@@ -739,13 +739,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	if (run->exit_reason == KVM_EXIT_RISCV_SBI) {
 		ret = kvm_riscv_vcpu_sbi_return(vcpu, vcpu->run);
 		if (ret) {
-			srcu_read_unlock(&vcpu->kvm->srcu, vcpu->arch.srcu_idx);
+			srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 			return ret;
 		}
 	}
 
 	if (run->immediate_exit) {
-		srcu_read_unlock(&vcpu->kvm->srcu, vcpu->arch.srcu_idx);
+		srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 		return -EINTR;
 	}
 
@@ -784,7 +784,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 */
 		vcpu->mode = IN_GUEST_MODE;
 
-		srcu_read_unlock(&vcpu->kvm->srcu, vcpu->arch.srcu_idx);
+		srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 		smp_mb__after_srcu_read_unlock();
 
 		/*
@@ -802,7 +802,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 			vcpu->mode = OUTSIDE_GUEST_MODE;
 			local_irq_enable();
 			preempt_enable();
-			vcpu->arch.srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
+			vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 			continue;
 		}
 
@@ -846,7 +846,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		preempt_enable();
 
-		vcpu->arch.srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
+		vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 		ret = kvm_riscv_vcpu_exit(vcpu, run, &trap);
 	}
@@ -855,7 +855,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 	vcpu_put(vcpu);
 
-	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->arch.srcu_idx);
+	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 
 	return ret;
 }
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index aa8af129e4bb..2d56faddb9d1 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -456,9 +456,9 @@ static int stage2_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
 void kvm_riscv_vcpu_wfi(struct kvm_vcpu *vcpu)
 {
 	if (!kvm_arch_vcpu_runnable(vcpu)) {
-		srcu_read_unlock(&vcpu->kvm->srcu, vcpu->arch.srcu_idx);
+		srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 		kvm_vcpu_halt(vcpu);
-		vcpu->arch.srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
+		vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
 	}
 }
-- 
2.36.0.rc0.470.gd361397f0d-goog

