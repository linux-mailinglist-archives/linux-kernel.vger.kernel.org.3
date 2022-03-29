Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEBD4EB70D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241265AbiC2XxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241189AbiC2Xwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:52:53 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC67204C8E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:51:09 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id om8-20020a17090b3a8800b001c68e7ccd5fso292220pjb.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=oCYui+K+d0TSC1DG5I9ne/xMFV78SC7XMDQtja8p6Lk=;
        b=osZZVurOhJxG1NLStWVQcssxNu2a5OVDaZvh9gOBHWIhWM0ku9Yz9uvqF5cqkYlJQi
         0NiI5LqRaioj+nicjews9aurISSC30CoI61Cs/C7sqEXjWaqAZdJMDPAZXke4jRCHrNy
         Bz0eUsP76Oob4fqShCSh9vogUbMkfXTGQLcNxEAvkhbScluZH6AFBxt/dFtJQ5ydsO65
         LFwiwqzvjOm+AlwNMHdfHEycfoNddpPqg5opYWVCEQhRxGLsMVoe5KiWdY3b/eUwulAD
         P1K1exLKD6fCPHeqYI/gctUlCE3YO8WtTrzH+CNNOv8crZk3Cl2LbgbU5VVDugkrO8Yi
         Eq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=oCYui+K+d0TSC1DG5I9ne/xMFV78SC7XMDQtja8p6Lk=;
        b=WjO7WdzC5KkDhqDanaTdBcndUrWNraxIFPPVfo2XTG8j7iTyirDZ6pvp1L7tDF0gJJ
         uYlqiCGKECLF5U220PAKe0YdObBfNP+NG6qu3mevr5vKm2tk0IL0NyPdryV5Rhqd9ikp
         ROivEVqurcgYmW29vBwf0ZAe6/3TY2Vr6W/0YvMMB1XnfKWEfFKMkg3ZteD+YyyDWIzo
         c4x5Hvigy/Gnjdpq8pYFYip71nelx0aLwupPqgMoAn36zASZAtVGwVNR3rXR28PcK4d+
         GO+40lmn855CK4P42gj2n+2eZRk5coMY6hKyNsiDknDRrudcr0cZyhTB8phNJ+FwS0HP
         zJ4g==
X-Gm-Message-State: AOAM5301/PXJiOUj8OXPDEDojH3wUTSWPJllzaSqikZBUozyqwUQWfqv
        3EMwy43qm4nesGaVEvQk+49t6/xUYdE=
X-Google-Smtp-Source: ABdhPJzdAGuJKJuW0xfREciH6xAeAYULBy5N6X6BzKXaQe7BO12MoNSDYd2DUW0kGq66425lPOZ1v214ohs=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1a89:b0:1c6:4398:673 with SMTP id
 ng9-20020a17090b1a8900b001c643980673mr1777594pjb.40.1648597869060; Tue, 29
 Mar 2022 16:51:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 29 Mar 2022 23:50:53 +0000
In-Reply-To: <20220329235054.3534728-1-seanjc@google.com>
Message-Id: <20220329235054.3534728-4-seanjc@google.com>
Mime-Version: 1.0
References: <20220329235054.3534728-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v3.1 3/4] KVM: x86: Move .pmu_ops to kvm_x86_init_ops and tag
 as __initdata
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <likexu@tencent.com>
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

From: Like Xu <likexu@tencent.com>

The pmu_ops should be moved to kvm_x86_init_ops and tagged as __initdata.
That'll save those precious few bytes, and more importantly make
the original ops unreachable, i.e. make it harder to sneak in post-init
modification bugs.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Like Xu <likexu@tencent.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 3 +--
 arch/x86/kvm/svm/pmu.c          | 2 +-
 arch/x86/kvm/svm/svm.c          | 2 +-
 arch/x86/kvm/vmx/pmu_intel.c    | 2 +-
 arch/x86/kvm/vmx/vmx.c          | 2 +-
 arch/x86/kvm/x86.c              | 2 +-
 6 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index df4e057b0417..5bb5843d460a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1464,8 +1464,6 @@ struct kvm_x86_ops {
 	int cpu_dirty_log_size;
 	void (*update_cpu_dirty_logging)(struct kvm_vcpu *vcpu);
 
-	/* pmu operations of sub-arch */
-	const struct kvm_pmu_ops *pmu_ops;
 	const struct kvm_x86_nested_ops *nested_ops;
 
 	void (*vcpu_blocking)(struct kvm_vcpu *vcpu);
@@ -1536,6 +1534,7 @@ struct kvm_x86_init_ops {
 	unsigned int (*handle_intel_pt_intr)(void);
 
 	struct kvm_x86_ops *runtime_ops;
+	struct kvm_pmu_ops *pmu_ops;
 };
 
 struct kvm_arch_async_pf {
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 24eb935b6f85..57ab4739eb19 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -319,7 +319,7 @@ static void amd_pmu_reset(struct kvm_vcpu *vcpu)
 	}
 }
 
-struct kvm_pmu_ops amd_pmu_ops = {
+struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.pmc_perf_hw_id = amd_pmc_perf_hw_id,
 	.pmc_is_enabled = amd_pmc_is_enabled,
 	.pmc_idx_to_pmc = amd_pmc_idx_to_pmc,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6535adee3e9c..f3c9aa8624d8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4625,7 +4625,6 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.sched_in = svm_sched_in,
 
-	.pmu_ops = &amd_pmu_ops,
 	.nested_ops = &svm_nested_ops,
 
 	.deliver_interrupt = svm_deliver_interrupt,
@@ -4906,6 +4905,7 @@ static struct kvm_x86_init_ops svm_init_ops __initdata = {
 	.check_processor_compatibility = svm_check_processor_compat,
 
 	.runtime_ops = &svm_x86_ops,
+	.pmu_ops = &amd_pmu_ops,
 };
 
 static int __init svm_init(void)
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index efa172a7278e..c766c9b3083a 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -723,7 +723,7 @@ static void intel_pmu_cleanup(struct kvm_vcpu *vcpu)
 		intel_pmu_release_guest_lbr_event(vcpu);
 }
 
-struct kvm_pmu_ops intel_pmu_ops = {
+struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.pmc_perf_hw_id = intel_pmc_perf_hw_id,
 	.pmc_is_enabled = intel_pmc_is_enabled,
 	.pmc_idx_to_pmc = intel_pmc_idx_to_pmc,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 84a7500cd80c..77ba0cfe588f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7823,7 +7823,6 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.cpu_dirty_log_size = PML_ENTITY_NUM,
 	.update_cpu_dirty_logging = vmx_update_cpu_dirty_logging,
 
-	.pmu_ops = &intel_pmu_ops,
 	.nested_ops = &vmx_nested_ops,
 
 	.pi_update_irte = vmx_pi_update_irte,
@@ -8078,6 +8077,7 @@ static struct kvm_x86_init_ops vmx_init_ops __initdata = {
 	.handle_intel_pt_intr = NULL,
 
 	.runtime_ops = &vmx_x86_ops,
+	.pmu_ops = &intel_pmu_ops,
 };
 
 static void vmx_cleanup_l1d_flush(void)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6f1676fab6c5..ca48cf705917 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11610,7 +11610,7 @@ static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
 #include <asm/kvm-x86-ops.h>
 #undef __KVM_X86_OP
 
-	kvm_pmu_ops_update(ops->runtime_ops->pmu_ops);
+	kvm_pmu_ops_update(ops->pmu_ops);
 }
 
 int kvm_arch_hardware_setup(void *opaque)
-- 
2.35.1.1021.g381101b075-goog

