Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2902251773D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387076AbiEBTRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387066AbiEBTRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:17:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFA7DECC
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 12:14:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g26-20020a25b11a000000b0064984a4ffb7so2855324ybj.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=kctQu0Q+rBx9IOI1jVYX1kCsToTQ9FXaErspFG8A+BM=;
        b=PUaFQEUXTVeO3j8UqhdilVFBoS8MQyXXLOdKDTrAxE3OYq/faQPkSJWo8e7me1GEfx
         6PsNj1xxLGPhdzYlihe1rWIfDUcGXvJXU10tkvtxr6B/1FN7NalgVecXju0dhY3zvC3z
         Wn9cP13pNuedWp+KZQejkmkLKJWMyilvnVCZCeigqzu7y0HNaezqXPUdmoMOtc+bcbZg
         iGVOT37xPO8vnZ857v/bBUTDGk0QN0BZCLo8QSwtH1V7yUaedGw7RwWpenSonKMyFTwi
         MaX/+nPpNpve5ilD2cuRr96xbl7NBZ2cJyokJ9Cl3NLX6dlXkrvqfAJBFp8SZMNQPpEZ
         jtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=kctQu0Q+rBx9IOI1jVYX1kCsToTQ9FXaErspFG8A+BM=;
        b=hc5qJIrrzBy0uRmIGV4UR/SV27aYUB5VzD44UI8ofi61uTlOvjuZgErORzHn+W/Pca
         Fb3hBLrY2Y+Ediia4KP5UmjSp8SzFHPI31KevRclAUO7VcbadmTytQLJfr/EazL3DNU3
         xvqYd7gzeTF02iYhI63SDhO0ItGqNmGhGzcpwnJV906XP9JGN9hdirT4SwNtR/cbCe72
         CPd9LkB967wRPAW3FO1LPSBeYFmgKowmQxpQ2u9k9vYsgQizAosh9ltEuGbjQfUOWLln
         4DxaHSU+2RLhnCQET2SoCHzTTTilsfKl62KQIUVkvlDbj83ZXma0xBq2OJqNauQ10ja5
         2C4A==
X-Gm-Message-State: AOAM5327olPCe1o9iajQpT8nBNIkqqpN3UeKrmb0XeAZ2YkT23ILQzcD
        J0E/ZVA97lJHpAmi4PX8QEFDAxbyzyaAogo2jg==
X-Google-Smtp-Source: ABdhPJxJbanbmKIqaVzeagTqMg3TVUzh6s0fqdiC3NI5Unq1sq+s6VeUa3qJVINa7kZWA+10cnCzYiMEVqhMJfYwMg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:55c:7548:7073:c14f])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:50c:b0:648:67e5:f160 with
 SMTP id x12-20020a056902050c00b0064867e5f160mr11569415ybs.22.1651518850044;
 Mon, 02 May 2022 12:14:10 -0700 (PDT)
Date:   Mon,  2 May 2022 12:12:04 -0700
In-Reply-To: <20220502191222.4192768-1-kaleshsingh@google.com>
Message-Id: <20220502191222.4192768-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220502191222.4192768-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 4/5] KVM: arm64: Allocate shared stacktrace pages
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     mark.rutland@arm.com, broonie@kernel.org, will@kernel.org,
        maz@kernel.org, qperret@google.com, tabba@google.com,
        surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Jones <drjones@redhat.com>,
        Marco Elver <elver@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Keir Fraser <keirf@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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
index d300def44f5c..26005182da20 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -50,6 +50,7 @@ DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stacktrace_page);
 unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
 DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
@@ -1484,6 +1485,7 @@ static void cpu_prepare_hyp_mode(int cpu)
 	tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
 	params->tcr_el2 = tcr;
 
+	params->stacktrace_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stacktrace_page, cpu));
 	params->pgd_pa = kvm_mmu_get_httbr();
 	if (is_protected_kvm_enabled())
 		params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
@@ -1777,6 +1779,7 @@ static void teardown_hyp_mode(void)
 	free_hyp_pgds();
 	for_each_possible_cpu(cpu) {
 		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
+		free_page(per_cpu(kvm_arm_hyp_stacktrace_page, cpu));
 		free_pages(kvm_arm_hyp_percpu_base[cpu], nvhe_percpu_order());
 	}
 }
@@ -1868,6 +1871,23 @@ static int init_hyp_mode(void)
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
@@ -1975,6 +1995,20 @@ static int init_hyp_mode(void)
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
2.36.0.464.gb9c8b46e94-goog

