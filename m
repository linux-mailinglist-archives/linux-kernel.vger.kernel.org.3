Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997CF4C3C80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbiBYDk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbiBYDk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:40:57 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CEB2023BF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:40:26 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d07ae1145aso19899687b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=crLC6KNPSW6pjgkY7QG68MqSuOvzKzstw/mmXuRH0uQ=;
        b=eMACZV7Ulgx7cpO0c0twpxn/qhqjJw2zVig3i+P7saVXlXADzihFwDG1AYC5zvgZWn
         mNe85tgfJeyqyRM6l3SarGtFKFIpVugzsd/xhQdc0U0VCoHhDtKrXHdt2lKagz2QB4WK
         vNWuKwFAcN6rYAL39YUrOkSDOWwtP1m31bpK1hfR/FE2trbiIWOY1ehGd9eQUk4/jQRs
         NGJsqCj9Y6904z2Ztz5PWXVW5W7Xo+clWqBDdn6bW0HRlMK1SpSKCwgYloVC23KXYV7i
         OJOo4hUh7s0PhDrHE+xo4khiI09oZwLFYmNvgE0a5jdJkDWsC3zDE9JxGGuoOzxsilsR
         rJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=crLC6KNPSW6pjgkY7QG68MqSuOvzKzstw/mmXuRH0uQ=;
        b=skMB/++SBBCXrVvjOSekpnIv33222YAX08wVu0DLofiJilieBHpGGyEMGiguf8wUWA
         /BNcJmGrTOeMNbPuKk1Cf40hWm8ElQvadvIEHxm9QPR7BeMyAkE5RVH1EwJ3wCBQO7oB
         U0qEFl8SUWVFhvBiJLyPxQgDjItXACHwhtT0zck7+5h03wS/6ALaIi6vO+JybgoiRSbP
         XNZ2EZIMeY1dkO1OKqxXlY/x30LWwYZvOBdtLJ7OZpMnuaN167kY5D7WSXeV72+AGSRU
         zV7z9SMV6SnAbv3vyciqgfDt0aLJAipSurlRyBpDY4wBMon40W1RC5CKLDqfL9TYHzj7
         Wwhw==
X-Gm-Message-State: AOAM532gySaqNYfczCY2Pu6/I1qaUM0ed/VcsQTxYHUFW92KatMbN9sq
        hAvFK2xzPNxU6P0jWLBZOZuOvtT9nStk9iiCjA==
X-Google-Smtp-Source: ABdhPJwOno2FbkMIPrVxa3r/Jv3jyWkFh+CTqMQaXEkKcA6CWeuJZGCXA3mA7lF2W+OMJmTOcLVCDYV3FJvU1Uwfjg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:3a50:90b2:e6a2:9060])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:ed1:0:b0:624:4085:cd0c with SMTP
 id a17-20020a5b0ed1000000b006244085cd0cmr5397836ybs.574.1645760425872; Thu,
 24 Feb 2022 19:40:25 -0800 (PST)
Date:   Thu, 24 Feb 2022 19:34:47 -0800
In-Reply-To: <20220225033548.1912117-1-kaleshsingh@google.com>
Message-Id: <20220225033548.1912117-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220225033548.1912117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v4 2/8] KVM: arm64: Introduce pkvm_alloc_private_va_range()
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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

pkvm_hyp_alloc_private_va_range() can be used to reserve private VA ranges
in the pKVM nVHE hypervisor (). Also update __pkvm_create_private_mapping()
to allow specifying an alignment for the private VA mapping.

These will be used to implement stack guard pages for pKVM nVHE hypervisor
(in a subsequent patch in the series).

Credits to Quentin Perret <qperret@google.com> for the idea of moving
private VA allocation out of __pkvm_create_private_mapping()

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v4:
  - Handle null ptr in pkvm_alloc_private_va_range() and replace
    IS_ERR_OR_NULL checks in callers with IS_ERR checks, per Fuad
  - Fix kernel-doc comments format, per Fuad
  - Format __pkvm_create_private_mapping() prototype args (< 80 col), per Fuad

Changes in v3:
  - Handle null ptr in IS_ERR_OR_NULL checks, per Mark

Changes in v2:
  - Allow specifying an alignment for the private VA allocations, per Marc

 arch/arm64/kvm/hyp/include/nvhe/mm.h |  3 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c   |  5 ++-
 arch/arm64/kvm/hyp/nvhe/mm.c         | 60 +++++++++++++++++-----------
 arch/arm64/kvm/mmu.c                 |  2 +-
 4 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index 2d08510c6cc1..76d6fcf1d4f4 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -20,7 +20,8 @@ int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
 int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
 int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
 unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
-					    enum kvm_pgtable_prot prot);
+				size_t align, enum kvm_pgtable_prot prot);
+unsigned long pkvm_alloc_private_va_range(size_t size, size_t align);
 
 static inline void hyp_vmemmap_range(phys_addr_t phys, unsigned long size,
 				     unsigned long *start, unsigned long *end)
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 5e2197db0d32..96b2312a0f1d 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -158,9 +158,10 @@ static void handle___pkvm_create_private_mapping(struct kvm_cpu_context *host_ct
 {
 	DECLARE_REG(phys_addr_t, phys, host_ctxt, 1);
 	DECLARE_REG(size_t, size, host_ctxt, 2);
-	DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 3);
+	DECLARE_REG(size_t, align, host_ctxt, 3);
+	DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 4);
 
-	cpu_reg(host_ctxt, 1) = __pkvm_create_private_mapping(phys, size, prot);
+	cpu_reg(host_ctxt, 1) = __pkvm_create_private_mapping(phys, size, align, prot);
 }
 
 static void handle___pkvm_prot_finalize(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index 526a7d6fa86f..e6355180aa49 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -37,38 +37,53 @@ static int __pkvm_create_mappings(unsigned long start, unsigned long size,
 	return err;
 }
 
-unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
-					    enum kvm_pgtable_prot prot)
+/**
+ * pkvm_alloc_private_va_range - Allocates a private VA range.
+ * @size:	The size of the VA range to reserve.
+ * @align:	The required alignment for the allocation.
+ *
+ * The private VA range is allocated above __io_map_base.
+ */
+unsigned long pkvm_alloc_private_va_range(size_t size, size_t align)
 {
-	unsigned long addr;
-	int err;
+	unsigned long base, addr;
 
 	hyp_spin_lock(&pkvm_pgd_lock);
 
-	size = PAGE_ALIGN(size + offset_in_page(phys));
-	addr = __io_map_base;
-	__io_map_base += size;
+	addr = ALIGN(__io_map_base, align);
+
+	/* The allocated size is always a multiple of PAGE_SIZE */
+	base = addr + PAGE_ALIGN(size);
 
 	/* Are we overflowing on the vmemmap ? */
-	if (__io_map_base > __hyp_vmemmap) {
-		__io_map_base -= size;
+	if (!addr || base > __hyp_vmemmap)
 		addr = (unsigned long)ERR_PTR(-ENOMEM);
-		goto out;
-	}
-
-	err = kvm_pgtable_hyp_map(&pkvm_pgtable, addr, size, phys, prot);
-	if (err) {
-		addr = (unsigned long)ERR_PTR(err);
-		goto out;
-	}
+	else
+		__io_map_base = base;
 
-	addr = addr + offset_in_page(phys);
-out:
 	hyp_spin_unlock(&pkvm_pgd_lock);
 
 	return addr;
 }
 
+unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
+				size_t align, enum kvm_pgtable_prot prot)
+{
+	unsigned long addr;
+	int err;
+
+	size += offset_in_page(phys);
+	addr = pkvm_alloc_private_va_range(size, align);
+	if (IS_ERR((void *)addr))
+		return addr;
+
+	err = __pkvm_create_mappings(addr, size, phys, prot);
+	if (err)
+		return  (unsigned long)ERR_PTR(err);
+
+	return addr + offset_in_page(phys);
+}
+
 int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot)
 {
 	unsigned long start = (unsigned long)from;
@@ -152,10 +167,9 @@ int hyp_map_vectors(void)
 		return 0;
 
 	phys = __hyp_pa(__bp_harden_hyp_vecs);
-	bp_base = (void *)__pkvm_create_private_mapping(phys,
-							__BP_HARDEN_HYP_VECS_SZ,
-							PAGE_HYP_EXEC);
-	if (IS_ERR_OR_NULL(bp_base))
+	bp_base = (void *)__pkvm_create_private_mapping(phys, __BP_HARDEN_HYP_VECS_SZ,
+							PAGE_SIZE, PAGE_HYP_EXEC);
+	if (IS_ERR(bp_base))
 		return PTR_ERR(bp_base);
 
 	__hyp_bp_vect_base = bp_base;
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index a4868a6fa1c3..433c49766671 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -506,7 +506,7 @@ int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
 
 	if (!kvm_host_owns_hyp_mappings()) {
 		addr = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
-					 phys_addr, size, prot);
+					 phys_addr, size, align, prot);
 		if (IS_ERR((void *)addr))
 			return PTR_ERR((void *)addr);
 		*haddr = addr;
-- 
2.35.1.574.g5d30c73bfb-goog

