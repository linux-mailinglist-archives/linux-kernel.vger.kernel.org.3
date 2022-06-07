Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E055954042A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345253AbiFGQ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiFGQ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:56:02 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208381021DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:56:01 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o8-20020a17090a9f8800b001dc9f554c7fso9547278pjp.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0VHqSpYj40pidwvqadPpnWxx4OZYKsR2ZljfrIJfKyE=;
        b=BeaU0wAa2g0Kiu5D1gmb5uJ76d5AlU9rIdKN+WKMfPZXCRaPDOZBeHGCb2YXAwixzI
         OCBny7z0nInd3F0lowOxrNMPOTwmqhRt9oX2f6UGqzs8Oen4JP8iVFII0AS/WKCB7LqD
         jIsycA3VZfWRs5Fm2yn5GtlJfWCb8qQJGPwObJYjk4GDn3r8aa9TSi+529JuJeETKo3/
         84fYQv31ibh/BGHYCOmG57ssI0vQEjktcHUHxnCJUxTUih+7EdUXIXmgq3d33ilfDCbA
         JFh/tPiGwAvstxtB5QdVm4cVf74EAJvixcorLVxLr1Bor3M/N6AqphbawD+oB21uPfm/
         PlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0VHqSpYj40pidwvqadPpnWxx4OZYKsR2ZljfrIJfKyE=;
        b=2WQdOXFm3PrHOJOIg367V4Hgwzyjim8jOSAOOpycw7hRaDrJnpjmix7hv99NPtzuSi
         JKaPE9KOQ1KEPXTPCvJ3aUBzi+hIei4+NLT/Qs2zrUXUuF2GmNTVmNyh95PaFURnAc3x
         6FoKH20IhqJU5RHB8wCX7modUZny2Lc67xbNwL5pRdFqXM4mmBXQDu4DpI4cHcjemhM/
         PuBCAfZpvm6KRZuVOnenZ2rIqXcrBMwZ8D2CgQ+hoENmZqi5n4qLnMLVQmXiHDSuQ6aU
         Iqm2cw+ra70F9SmuGIwrq7T3hAJwPdg0MV44U288p2c7Lm44/Zga7L7v45Q2ig0NZB4G
         FTYw==
X-Gm-Message-State: AOAM531Yaese43Est5yGmAXvXeAcejpOD880bmFn521wDWla2RuwxDEc
        JGe7Y3kdNJZKpVmLzWKa/7mmzGOrZJAeVYdFhQ==
X-Google-Smtp-Source: ABdhPJxgwIRDwveYRMn6jZYEppdEHf6zMGiXAbdouv/bN5rkU0F3Reqsgn5ZoRJJoWKi0KbuJ4cps8DTxTVzu+nyrA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:7091:8518:ec1e:93dc])
 (user=kaleshsingh job=sendgmr) by 2002:a17:90a:1f4c:b0:1e6:6f77:c573 with
 SMTP id y12-20020a17090a1f4c00b001e66f77c573mr34893288pjy.17.1654620960558;
 Tue, 07 Jun 2022 09:56:00 -0700 (PDT)
Date:   Tue,  7 Jun 2022 09:50:46 -0700
In-Reply-To: <20220607165105.639716-1-kaleshsingh@google.com>
Message-Id: <20220607165105.639716-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220607165105.639716-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v3 4/5] KVM: arm64: Allocate shared stacktrace pages
From:   Kalesh Singh <kaleshsingh@google.com>
To:     mark.rutland@arm.com, broonie@kernel.org, maz@kernel.org
Cc:     will@kernel.org, qperret@google.com, tabba@google.com,
        surenb@google.com, tjmercier@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Jones <drjones@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Keir Fraser <keirf@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
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

The nVHE hypervisor can use this shared area to dump its stacktrace
addresses on hyp_panic(). Symbolization and printing the stacktrace can
then be handled by the host in EL1 (done in a later patch in this series).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/kvm_asm.h |  1 +
 arch/arm64/kvm/arm.c             | 34 ++++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/setup.c  | 11 +++++++++++
 3 files changed, 46 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 2e277f2ed671..ad31ac68264f 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -174,6 +174,7 @@ struct kvm_nvhe_init_params {
 	unsigned long hcr_el2;
 	unsigned long vttbr;
 	unsigned long vtcr;
+	unsigned long stacktrace_hyp_va;
 };
 
 /* Translate a kernel address @ptr into its equivalent linear mapping */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 400bb0fe2745..c0a936a7623d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -50,6 +50,7 @@ DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stacktrace_page);
 unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
 DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
@@ -1554,6 +1555,7 @@ static void cpu_prepare_hyp_mode(int cpu)
 	tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
 	params->tcr_el2 = tcr;
 
+	params->stacktrace_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stacktrace_page, cpu));
 	params->pgd_pa = kvm_mmu_get_httbr();
 	if (is_protected_kvm_enabled())
 		params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
@@ -1845,6 +1847,7 @@ static void teardown_hyp_mode(void)
 	free_hyp_pgds();
 	for_each_possible_cpu(cpu) {
 		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
+		free_page(per_cpu(kvm_arm_hyp_stacktrace_page, cpu));
 		free_pages(kvm_arm_hyp_percpu_base[cpu], nvhe_percpu_order());
 	}
 }
@@ -1936,6 +1939,23 @@ static int init_hyp_mode(void)
 		per_cpu(kvm_arm_hyp_stack_page, cpu) = stack_page;
 	}
 
+	/*
+	 * Allocate stacktrace pages for Hypervisor-mode.
+	 * This is used by the hypervisor to share its stacktrace
+	 * with the host on a hyp_panic().
+	 */
+	for_each_possible_cpu(cpu) {
+		unsigned long stacktrace_page;
+
+		stacktrace_page = __get_free_page(GFP_KERNEL);
+		if (!stacktrace_page) {
+			err = -ENOMEM;
+			goto out_err;
+		}
+
+		per_cpu(kvm_arm_hyp_stacktrace_page, cpu) = stacktrace_page;
+	}
+
 	/*
 	 * Allocate and initialize pages for Hypervisor-mode percpu regions.
 	 */
@@ -2043,6 +2063,20 @@ static int init_hyp_mode(void)
 		params->stack_hyp_va = hyp_addr + (2 * PAGE_SIZE);
 	}
 
+	/*
+	 * Map the hyp stacktrace pages.
+	 */
+	for_each_possible_cpu(cpu) {
+		char *stacktrace_page = (char *)per_cpu(kvm_arm_hyp_stacktrace_page, cpu);
+
+		err = create_hyp_mappings(stacktrace_page, stacktrace_page + PAGE_SIZE,
+					  PAGE_HYP);
+		if (err) {
+			kvm_err("Cannot map hyp stacktrace page\n");
+			goto out_err;
+		}
+	}
+
 	for_each_possible_cpu(cpu) {
 		char *percpu_begin = (char *)kvm_arm_hyp_percpu_base[cpu];
 		char *percpu_end = percpu_begin + nvhe_percpu_size();
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index e8d4ea2fcfa0..9b81bf2d40d7 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -135,6 +135,17 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 
 		/* Update stack_hyp_va to end of the stack's private VA range */
 		params->stack_hyp_va = hyp_addr + (2 * PAGE_SIZE);
+
+		/*
+		 * Map the stacktrace pages as shared and transfer ownership to
+		 * the hypervisor.
+		 */
+		prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_SHARED_OWNED);
+		start = (void *)params->stacktrace_hyp_va;
+		end = start + PAGE_SIZE;
+		ret = pkvm_create_mappings(start, end, prot);
+		if (ret)
+			return ret;
 	}
 
 	/*
-- 
2.36.1.255.ge46751e96f-goog

