Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCAA5121F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiD0TCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiD0TCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:02:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096263B56B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:49:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d7eaa730d9so24402337b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=Niw+TDgV2KxWJ6fEGzYEc3H0fJbmY41W2p5431uZWR8=;
        b=H5K4dvngFXeGToSiwJyc5gDMiauBTyAgTQcKNgijqRH4fda+ZalAnwFobgqTFx5m95
         07PESfGxsSypAvapcr9tVD1Dv5o7rLLVvBo/jR0R6LXTRctJIeTqK614GBBJ7Xs1iS25
         CY+xTyd2ftGYZh42x0clk4C/Bd/F8zBbHQ621AQ+E6V2xC8gGfH7/9MLLQKlnYkkUb/n
         LT7qd9n3S9QukrbaySOFwUwrig26yKbRGD/TnCYnSAqsDS3VhHTCZDVjsyAiuQjkV/VF
         +4z8HcP9gGcur7U6uJKwMpqRHKql3EVYLOGSUMYxAaBTcuIG3mHlfWRs4GZo8Gb7ivJE
         yEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=Niw+TDgV2KxWJ6fEGzYEc3H0fJbmY41W2p5431uZWR8=;
        b=08kmK3DaftjBbQ1LgDsFUmcwXm5hgIKieO6HVzFe0RWXkqFySyc35u4ZZTMnAi6tzA
         hEeO/VPZR00yVECKBmeQAngsVWdB3nRRnoCBGFrl+UgXPsDoAGGS6/RUgXLIXctqW43R
         M+Ga8+noeuP0v6UuFZaeetiP5F4XjLnuRgTANYOUMP1nsLpraG/hzTaeYi6BMozX8IAs
         qRJ90Bghi1A/i1K/nYR/bWC/Awie+/DGgz5HOe4f9QpWBosufOsxcux6epSIobwWvfld
         ymKieWKRiPNr4k5aTJXlctlTYsE+42r3ZDRa5VSBvWG70Phj5fQjDnEsC7ldMyllWBRb
         id5Q==
X-Gm-Message-State: AOAM531sPjDb8U035nhPwtVEfzaL8cL7eyVZsxUScFMOGIxioKWfmNmQ
        LJg7RrYZLDVUvpsIyBJS/NZgHYf4o5nQzl0Kjw==
X-Google-Smtp-Source: ABdhPJwQ9wuOJWR/zy4bZTJ2QdVCC1H5SyRAsiNowolDxo1lYvW9cV81p5PcXpipjoSEMhqkjHq4UkjNMEefFsqN/Q==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:16ec:6da0:8cc5:5f24])
 (user=kaleshsingh job=sendgmr) by 2002:a25:d44e:0:b0:648:3d5b:fbd5 with SMTP
 id m75-20020a25d44e000000b006483d5bfbd5mr20470009ybf.363.1651085374068; Wed,
 27 Apr 2022 11:49:34 -0700 (PDT)
Date:   Wed, 27 Apr 2022 11:46:58 -0700
In-Reply-To: <20220427184716.1949239-1-kaleshsingh@google.com>
Message-Id: <20220427184716.1949239-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220427184716.1949239-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH 3/4] KVM: arm64: Allocate shared stacktrace pages
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     mark.rutland@arm.com, will@kernel.org, maz@kernel.org,
        qperret@google.com, tabba@google.com, surenb@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Jones <drjones@redhat.com>,
        Marco Elver <elver@google.com>, Keir Fraser <keirf@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
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
index dd257d9f21a2..1b21d5a99bfc 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -50,6 +50,7 @@ DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stacktrace_page);
 unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
 DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
@@ -1483,6 +1484,7 @@ static void cpu_prepare_hyp_mode(int cpu)
 	tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
 	params->tcr_el2 = tcr;
 
+	params->stacktrace_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stacktrace_page, cpu));
 	params->pgd_pa = kvm_mmu_get_httbr();
 	if (is_protected_kvm_enabled())
 		params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
@@ -1776,6 +1778,7 @@ static void teardown_hyp_mode(void)
 	free_hyp_pgds();
 	for_each_possible_cpu(cpu) {
 		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
+		free_page(per_cpu(kvm_arm_hyp_stacktrace_page, cpu));
 		free_pages(kvm_arm_hyp_percpu_base[cpu], nvhe_percpu_order());
 	}
 }
@@ -1867,6 +1870,23 @@ static int init_hyp_mode(void)
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
@@ -1974,6 +1994,20 @@ static int init_hyp_mode(void)
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
2.36.0.rc2.479.g8af0fa9b8e-goog

