Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F70353D47B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350395AbiFDBYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350175AbiFDBXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:23:06 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836E727160
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:22:08 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y11-20020aa7804b000000b0051ba2c16046so4697923pfm.20
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=sEiREkgq+HoUXEIbg4MsSKs5dKeKfTA3kQeTfzSdCO0=;
        b=m7ebo82OlPBn4pnob3hBfXD52cOfVY5eNoFRuzVEV80npImZfKSnpBOaK/H1KkYX+P
         s/JutEKEq4GhFSzSIbVWbDDRcMDqfri9KqMofEBYq5qGKFz6fA+v/LvGvFLVXMq5mXfi
         2jCJ3HEEbPbzBKCbO1JCG+xWjh/pjGCHS+NU0sC9fLbB0Ll3MmwCaDr5B9V8KSLa6IEF
         593vTWhF4e/rB40euYPwh5fWRzffs5jInW2+u18t154IkXQXVTZ5IudzB6ssibGz6iXH
         oXeCvDHa8unOPvYStdqHsg3BQElN4QOeQDix92O47x5NKiD3/LBAo9miZiarsIBw4wbs
         yg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=sEiREkgq+HoUXEIbg4MsSKs5dKeKfTA3kQeTfzSdCO0=;
        b=NVsgI/6mBRndb5/08ftMAvKCDiv0Ik93t8J5aFmQI/ZtRlpfjqfBZPtDcF/wgTL48J
         Mo/L8MZ/c0nTFc05+N/1w7l0jSEzURu3bVxh0dIkZbyWEEL4blxtngEK0Kbt+p5NWqew
         GGuDTicJaN60MAwr7lujS/K6mrBAg0iZwmI6omfapGS3K94UIyOwrdeBm6K2hCloOauW
         hSHYkjnnvu3zowCzoaF5fSYdYeic7eAEpk9B0GyhS4EmO5XC8WynXTMV/gm8JkpB5wHr
         vREbduKS05b35PIjuiPv4KEvb1hdx5CqZg+dpryYFH06PTNrxq+CbLW0/eKEHrdOgqvL
         vFxg==
X-Gm-Message-State: AOAM532xbvGj3lwDz45i/mj5CPqMbh8/re1ZlIWEqjhRzFdXPQdxh+um
        cvW8GetspgQns/6HsCsM6naiXX2MO7Q=
X-Google-Smtp-Source: ABdhPJySn68uGi02I64F+VtPpvY1c2MX/Oirt//NxcUlYH2bbcCwJXT0jTmLNdJMojOwb89S/HjmVteyFFM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:2c1:b0:158:f9d0:839c with SMTP id
 s1-20020a17090302c100b00158f9d0839cmr12381037plk.118.1654305713332; Fri, 03
 Jun 2022 18:21:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Jun 2022 01:20:46 +0000
In-Reply-To: <20220604012058.1972195-1-seanjc@google.com>
Message-Id: <20220604012058.1972195-31-seanjc@google.com>
Mime-Version: 1.0
References: <20220604012058.1972195-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 30/42] KVM: selftests: Make get_supported_cpuid() returns "const"
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag the returned CPUID pointers from kvm_get_supported_cpuid(),
kvm_get_supported_hv_cpuid(), and vcpu_get_supported_hv_cpuid() "const"
to prevent reintroducing the broken pattern of modifying the static
"cpuid" variable used by kvm_get_supported_cpuid() to cache the results
of KVM_GET_SUPPORTED_CPUID.

Update downstream consumers as needed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 24 ++++++++---------
 .../selftests/kvm/lib/x86_64/processor.c      | 27 ++++++-------------
 .../testing/selftests/kvm/x86_64/cpuid_test.c | 12 ++++-----
 .../selftests/kvm/x86_64/hyperv_cpuid.c       | 10 +++----
 .../kvm/x86_64/pmu_event_filter_test.c        | 10 +++----
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |  2 +-
 6 files changed, 36 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index c2e3ea55b697..6c14b34014c2 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -583,7 +583,9 @@ static inline void vcpu_xcrs_set(struct kvm_vcpu *vcpu, struct kvm_xcrs *xcrs)
 	vcpu_ioctl(vcpu, KVM_SET_XCRS, xcrs);
 }
 
-struct kvm_cpuid2 *kvm_get_supported_cpuid(void);
+const struct kvm_cpuid2 *kvm_get_supported_cpuid(void);
+const struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(void);
+const struct kvm_cpuid2 *vcpu_get_supported_hv_cpuid(struct kvm_vcpu *vcpu);
 
 bool kvm_cpuid_has(const struct kvm_cpuid2 *cpuid,
 		   struct kvm_x86_cpu_feature feature);
@@ -616,15 +618,17 @@ static inline struct kvm_cpuid2 *allocate_kvm_cpuid2(int nr_entries)
 	return cpuid;
 }
 
-struct kvm_cpuid_entry2 *get_cpuid_entry(struct kvm_cpuid2 *cpuid,
-					 uint32_t function, uint32_t index);
-void vcpu_init_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid);
+const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
+					       uint32_t function, uint32_t index);
+void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid);
+void vcpu_set_hv_cpuid(struct kvm_vcpu *vcpu);
 
 static inline struct kvm_cpuid_entry2 *__vcpu_get_cpuid_entry(struct kvm_vcpu *vcpu,
 							      uint32_t function,
 							      uint32_t index)
 {
-	return get_cpuid_entry(vcpu->cpuid, function, index);
+	return (struct kvm_cpuid_entry2 *)get_cpuid_entry(vcpu->cpuid,
+							  function, index);
 }
 
 static inline struct kvm_cpuid_entry2 *vcpu_get_cpuid_entry(struct kvm_vcpu *vcpu,
@@ -676,14 +680,13 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
 	vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
 }
 
-static inline struct kvm_cpuid_entry2 *kvm_get_supported_cpuid_index(uint32_t function,
-								     uint32_t index)
+static inline const struct kvm_cpuid_entry2 *kvm_get_supported_cpuid_index(uint32_t function,
+									   uint32_t index)
 {
 	return get_cpuid_entry(kvm_get_supported_cpuid(), function, index);
 }
 
-static inline struct kvm_cpuid_entry2 *
-kvm_get_supported_cpuid_entry(uint32_t function)
+static inline const struct kvm_cpuid_entry2 *kvm_get_supported_cpuid_entry(uint32_t function)
 {
 	return kvm_get_supported_cpuid_index(function, 0);
 }
@@ -730,9 +733,6 @@ void vm_set_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 		       uint64_t a3);
 
-struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(void);
-void vcpu_set_hv_cpuid(struct kvm_vcpu *vcpu);
-struct kvm_cpuid2 *vcpu_get_supported_hv_cpuid(struct kvm_vcpu *vcpu);
 void vm_xsave_req_perm(int bit);
 
 enum x86_page_size {
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 1812b14de3dd..41cc320d3e34 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -677,18 +677,7 @@ void vcpu_arch_free(struct kvm_vcpu *vcpu)
 		free(vcpu->cpuid);
 }
 
-/*
- * KVM Supported CPUID Get
- *
- * Input Args: None
- *
- * Output Args:
- *
- * Return: The supported KVM CPUID
- *
- * Get the guest CPUID supported by KVM.
- */
-struct kvm_cpuid2 *kvm_get_supported_cpuid(void)
+const struct kvm_cpuid2 *kvm_get_supported_cpuid(void)
 {
 	static struct kvm_cpuid2 *cpuid;
 	int kvm_fd;
@@ -746,7 +735,7 @@ uint64_t kvm_get_feature_msr(uint64_t msr_index)
 	return buffer.entry.data;
 }
 
-void vcpu_init_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid)
+void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid)
 {
 	TEST_ASSERT(cpuid != vcpu->cpuid, "@cpuid can't be the vCPU's CPUID");
 
@@ -1080,7 +1069,7 @@ uint32_t kvm_get_cpuid_max_extended(void)
 
 void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 {
-	struct kvm_cpuid_entry2 *entry;
+	const struct kvm_cpuid_entry2 *entry;
 	bool pae;
 
 	/* SDM 4.1.4 */
@@ -1192,8 +1181,8 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 	}
 }
 
-struct kvm_cpuid_entry2 *get_cpuid_entry(struct kvm_cpuid2 *cpuid,
-					 uint32_t function, uint32_t index)
+const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
+					       uint32_t function, uint32_t index)
 {
 	int i;
 
@@ -1219,7 +1208,7 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 	return r;
 }
 
-struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(void)
+const struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(void)
 {
 	static struct kvm_cpuid2 *cpuid;
 	int kvm_fd;
@@ -1239,7 +1228,7 @@ struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(void)
 void vcpu_set_hv_cpuid(struct kvm_vcpu *vcpu)
 {
 	static struct kvm_cpuid2 *cpuid_full;
-	struct kvm_cpuid2 *cpuid_sys, *cpuid_hv;
+	const struct kvm_cpuid2 *cpuid_sys, *cpuid_hv;
 	int i, nent = 0;
 
 	if (!cpuid_full) {
@@ -1269,7 +1258,7 @@ void vcpu_set_hv_cpuid(struct kvm_vcpu *vcpu)
 	vcpu_init_cpuid(vcpu, cpuid_full);
 }
 
-struct kvm_cpuid2 *vcpu_get_supported_hv_cpuid(struct kvm_vcpu *vcpu)
+const struct kvm_cpuid2 *vcpu_get_supported_hv_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid2 *cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);
 
diff --git a/tools/testing/selftests/kvm/x86_64/cpuid_test.c b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
index 694583803468..2b8ac307da64 100644
--- a/tools/testing/selftests/kvm/x86_64/cpuid_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
@@ -66,7 +66,7 @@ static void guest_main(struct kvm_cpuid2 *guest_cpuid)
 	GUEST_DONE();
 }
 
-static bool is_cpuid_mangled(struct kvm_cpuid_entry2 *entrie)
+static bool is_cpuid_mangled(const struct kvm_cpuid_entry2 *entrie)
 {
 	int i;
 
@@ -79,9 +79,10 @@ static bool is_cpuid_mangled(struct kvm_cpuid_entry2 *entrie)
 	return false;
 }
 
-static void compare_cpuids(struct kvm_cpuid2 *cpuid1, struct kvm_cpuid2 *cpuid2)
+static void compare_cpuids(const struct kvm_cpuid2 *cpuid1,
+			   const struct kvm_cpuid2 *cpuid2)
 {
-	struct kvm_cpuid_entry2 *e1, *e2;
+	const struct kvm_cpuid_entry2 *e1, *e2;
 	int i;
 
 	TEST_ASSERT(cpuid1->nent == cpuid2->nent,
@@ -175,7 +176,6 @@ static void set_cpuid_after_run(struct kvm_vcpu *vcpu)
 
 int main(void)
 {
-	struct kvm_cpuid2 *supp_cpuid;
 	struct kvm_vcpu *vcpu;
 	vm_vaddr_t cpuid_gva;
 	struct kvm_vm *vm;
@@ -183,9 +183,7 @@ int main(void)
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
 
-	supp_cpuid = kvm_get_supported_cpuid();
-
-	compare_cpuids(supp_cpuid, vcpu->cpuid);
+	compare_cpuids(kvm_get_supported_cpuid(), vcpu->cpuid);
 
 	vcpu_alloc_cpuid(vm, &cpuid_gva, vcpu->cpuid);
 
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
index c406b95cba9b..e804eb08dff9 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -43,7 +43,7 @@ static bool smt_possible(void)
 	return res;
 }
 
-static void test_hv_cpuid(struct kvm_cpuid2 *hv_cpuid_entries,
+static void test_hv_cpuid(const struct kvm_cpuid2 *hv_cpuid_entries,
 			  bool evmcs_expected)
 {
 	int i;
@@ -56,7 +56,7 @@ static void test_hv_cpuid(struct kvm_cpuid2 *hv_cpuid_entries,
 		    nent_expected, hv_cpuid_entries->nent);
 
 	for (i = 0; i < hv_cpuid_entries->nent; i++) {
-		struct kvm_cpuid_entry2 *entry = &hv_cpuid_entries->entries[i];
+		const struct kvm_cpuid_entry2 *entry = &hv_cpuid_entries->entries[i];
 
 		TEST_ASSERT((entry->function >= 0x40000000) &&
 			    (entry->function <= 0x40000082),
@@ -131,7 +131,7 @@ void test_hv_cpuid_e2big(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 int main(int argc, char *argv[])
 {
 	struct kvm_vm *vm;
-	struct kvm_cpuid2 *hv_cpuid_entries;
+	const struct kvm_cpuid2 *hv_cpuid_entries;
 	struct kvm_vcpu *vcpu;
 
 	/* Tell stdout not to buffer its content */
@@ -146,7 +146,7 @@ int main(int argc, char *argv[])
 
 	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vcpu);
 	test_hv_cpuid(hv_cpuid_entries, false);
-	free(hv_cpuid_entries);
+	free((void *)hv_cpuid_entries);
 
 	if (!kvm_cpu_has(X86_FEATURE_VMX) ||
 	    !kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS)) {
@@ -156,7 +156,7 @@ int main(int argc, char *argv[])
 	vcpu_enable_evmcs(vcpu);
 	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vcpu);
 	test_hv_cpuid(hv_cpuid_entries, true);
-	free(hv_cpuid_entries);
+	free((void *)hv_cpuid_entries);
 
 do_sys:
 	/* Test system ioctl version */
diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 66930384ef97..5321bfe8b4e9 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -358,7 +358,7 @@ static void test_pmu_config_disable(void (*guest_code)(void))
  * counter per logical processor, an EBX bit vector of length greater
  * than 5, and EBX[5] clear.
  */
-static bool check_intel_pmu_leaf(struct kvm_cpuid_entry2 *entry)
+static bool check_intel_pmu_leaf(const struct kvm_cpuid_entry2 *entry)
 {
 	union cpuid10_eax eax = { .full = entry->eax };
 	union cpuid10_ebx ebx = { .full = entry->ebx };
@@ -374,10 +374,10 @@ static bool check_intel_pmu_leaf(struct kvm_cpuid_entry2 *entry)
  */
 static bool use_intel_pmu(void)
 {
-	struct kvm_cpuid_entry2 *entry;
+	const struct kvm_cpuid_entry2 *entry;
 
 	entry = kvm_get_supported_cpuid_index(0xa, 0);
-	return is_intel_cpu() && entry && check_intel_pmu_leaf(entry);
+	return is_intel_cpu() && check_intel_pmu_leaf(entry);
 }
 
 static bool is_zen1(uint32_t eax)
@@ -406,10 +406,10 @@ static bool is_zen3(uint32_t eax)
  */
 static bool use_amd_pmu(void)
 {
-	struct kvm_cpuid_entry2 *entry;
+	const struct kvm_cpuid_entry2 *entry;
 
 	entry = kvm_get_supported_cpuid_index(1, 0);
-	return is_amd_cpu() && entry &&
+	return is_amd_cpu() &&
 		(is_zen1(entry->eax) ||
 		 is_zen2(entry->eax) ||
 		 is_zen3(entry->eax));
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index dc3869d5aff0..689517f2aae6 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -53,7 +53,7 @@ static void guest_code(void)
 
 int main(int argc, char *argv[])
 {
-	struct kvm_cpuid_entry2 *entry_a_0;
+	const struct kvm_cpuid_entry2 *entry_a_0;
 	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
 	int ret;
-- 
2.36.1.255.ge46751e96f-goog

