Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2D253C2EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbiFCA7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241216AbiFCAu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:50:29 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C0531DFC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:47:44 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id c14-20020a17090a1d0e00b001e328238e7eso3406519pjd.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=JJS7EyD4erb5GYrLtMTUJ302sBwmrMBdLGpv7BVItVo=;
        b=Iy4M77D5zRQ+X7yvDk85qz8ddQRERn6/M+k9sn27vjJcwWJh7DebcVqtZpcMrfLVON
         5W2ltZlycjbKAoMr0wATB45LUg05Jt62ZC676Nl4NK6ZqyScUy9qE9osGplFy3LqIzZq
         2yxp6978qZThNFMXRh0RGzNkCVnj/IeFVCcIcmctoM5BzQHltT8EDq6fKbB53tRgbvol
         o2n1gUJ8c1csFB+JHAa6+k9KMgiOO6Dk2+vKviukqe8Jx6p1MTZg/VfSbyAGzDFeXmsM
         vV1BS9R6jDJNjYLTkPAaAnhvNXUC9eRyTJFG12wJHJ2/b7QRYJ9h7J9E+5d8ADWN54td
         Cleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=JJS7EyD4erb5GYrLtMTUJ302sBwmrMBdLGpv7BVItVo=;
        b=VT9U8n2smuvUVsV7pwhboqFY+zJlGJkePJuChbucwC0QoOY7kjtAKMZwmVSJkut+Em
         QERQmCue7w/rcWJZwZHdTV43O+795LNzOtRa8nd9Vy5+R46scDkEpUu0r8Ci8JfUnebM
         n0ViOcWU/3agOFcFH4j7GngXB+D87vg7DzdWhAms5+9tisyKkaNO6hGC4sXiupp7oHwJ
         fW+q9qR5oVh22GNZ6Rksvx4T07mtcH3w9Q5rQE5des0fjSyurDs9hn+lhkgQbSnLuvyp
         S/UP5DEXNt7AEhyrhk+bcZpCmBd1nzE3T8v7CL6amZE8JUpIgZmjxtfCp0AJS33l5+aW
         wQZA==
X-Gm-Message-State: AOAM530XWN75MNiLX+sJ57W2ABjft/juUUx3xHseU49ES3OvGNThm6Zx
        r8h06jf2Vx5nLWrDRy1TpLG3su+gdqo=
X-Google-Smtp-Source: ABdhPJzkRCWLATITIrZNUBGBs99gDKC9Rn8oUIHOLFvODyewCXSjBhlrPBIOm5jgxnMx83sI+JoY9sBiABU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4a4c:b0:1e3:3ad6:a5bd with SMTP id
 lb12-20020a17090b4a4c00b001e33ad6a5bdmr8065127pjb.172.1654217260658; Thu, 02
 Jun 2022 17:47:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:43:22 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-136-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 135/144] KVM: selftests: Open code and drop 'struct kvm_vm' accessors
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
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

Drop a variety of 'struct kvm_vm' accessors that wrap a single variable
now that tests can simply reference the variable directly.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/dirty_log_perf_test.c       |  2 +-
 tools/testing/selftests/kvm/dirty_log_test.c  |  9 +++----
 .../selftests/kvm/include/kvm_util_base.h     |  6 -----
 .../selftests/kvm/kvm_page_table_test.c       |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 25 -------------------
 .../selftests/kvm/lib/perf_test_util.c        |  7 +++---
 .../selftests/kvm/max_guest_memory_test.c     | 11 ++++----
 .../kvm/memslot_modification_stress_test.c    |  2 +-
 .../selftests/kvm/x86_64/hyperv_cpuid.c       |  2 +-
 9 files changed, 16 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index ca896da12e41..ed6d58fd1155 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -221,7 +221,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	perf_test_set_wr_fract(vm, p->wr_fract);
 
-	guest_num_pages = (nr_vcpus * guest_percpu_mem_size) >> vm_get_page_shift(vm);
+	guest_num_pages = (nr_vcpus * guest_percpu_mem_size) >> vm->page_shift;
 	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
 	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
 	pages_per_slot = host_num_pages / p->slots;
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 906e893375df..ca584b9bf5c0 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -713,21 +713,20 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	vm = create_vm(mode, &vcpu,
 		       2ul << (DIRTY_MEM_BITS - PAGE_SHIFT_4K), guest_code);
 
-	guest_page_size = vm_get_page_size(vm);
+	guest_page_size = vm->page_size;
 	/*
 	 * A little more than 1G of guest page sized pages.  Cover the
 	 * case where the size is not aligned to 64 pages.
 	 */
-	guest_num_pages = (1ul << (DIRTY_MEM_BITS -
-				   vm_get_page_shift(vm))) + 3;
+	guest_num_pages = (1ul << (DIRTY_MEM_BITS - vm->page_shift)) + 3;
 	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
 
 	host_page_size = getpagesize();
 	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
 
 	if (!p->phys_offset) {
-		guest_test_phys_mem = (vm_get_max_gfn(vm) -
-				       guest_num_pages) * guest_page_size;
+		guest_test_phys_mem = (vm->max_gfn - guest_num_pages) *
+				      guest_page_size;
 		guest_test_phys_mem = align_down(guest_test_phys_mem, host_page_size);
 	} else {
 		guest_test_phys_mem = p->phys_offset;
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 5741a999aca1..45f536f99399 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -592,13 +592,7 @@ static inline struct kvm_vm *vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 
 struct kvm_vcpu *vm_recreate_with_one_vcpu(struct kvm_vm *vm);
 
-unsigned int vm_get_page_size(struct kvm_vm *vm);
-unsigned int vm_get_page_shift(struct kvm_vm *vm);
 unsigned long vm_compute_max_gfn(struct kvm_vm *vm);
-uint64_t vm_get_max_gfn(struct kvm_vm *vm);
-int vm_get_kvm_fd(struct kvm_vm *vm);
-int vm_get_fd(struct kvm_vm *vm);
-
 unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size);
 unsigned int vm_num_host_pages(enum vm_guest_mode mode, unsigned int num_guest_pages);
 unsigned int vm_num_guest_pages(enum vm_guest_mode mode, unsigned int num_host_pages);
diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index 8706ae358444..0f8792aa0366 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -260,7 +260,7 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
 
 	/* Align down GPA of the testing memslot */
 	if (!p->phys_offset)
-		guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
+		guest_test_phys_mem = (vm->max_gfn - guest_num_pages) *
 				       guest_page_size;
 	else
 		guest_test_phys_mem = p->phys_offset;
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 2d69ac86d3fb..855ea3dbf8f1 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1827,36 +1827,11 @@ void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva)
 	return addr_gpa2hva(vm, addr_gva2gpa(vm, gva));
 }
 
-unsigned int vm_get_page_size(struct kvm_vm *vm)
-{
-	return vm->page_size;
-}
-
-unsigned int vm_get_page_shift(struct kvm_vm *vm)
-{
-	return vm->page_shift;
-}
-
 unsigned long __attribute__((weak)) vm_compute_max_gfn(struct kvm_vm *vm)
 {
 	return ((1ULL << vm->pa_bits) >> vm->page_shift) - 1;
 }
 
-uint64_t vm_get_max_gfn(struct kvm_vm *vm)
-{
-	return vm->max_gfn;
-}
-
-int vm_get_kvm_fd(struct kvm_vm *vm)
-{
-	return vm->kvm_fd;
-}
-
-int vm_get_fd(struct kvm_vm *vm)
-{
-	return vm->fd;
-}
-
 static unsigned int vm_calc_num_pages(unsigned int num_pages,
 				      unsigned int page_shift,
 				      unsigned int new_page_shift,
diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
index 7faed18f7719..f62d773eb29c 100644
--- a/tools/testing/selftests/kvm/lib/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
@@ -153,14 +153,13 @@ struct kvm_vm *perf_test_create_vm(enum vm_guest_mode mode, int nr_vcpus,
 	 * If there should be more memory in the guest test region than there
 	 * can be pages in the guest, it will definitely cause problems.
 	 */
-	TEST_ASSERT(guest_num_pages < vm_get_max_gfn(vm),
+	TEST_ASSERT(guest_num_pages < vm->max_gfn,
 		    "Requested more guest memory than address space allows.\n"
 		    "    guest pages: %" PRIx64 " max gfn: %" PRIx64
 		    " nr_vcpus: %d wss: %" PRIx64 "]\n",
-		    guest_num_pages, vm_get_max_gfn(vm), nr_vcpus,
-		    vcpu_memory_bytes);
+		    guest_num_pages, vm->max_gfn, nr_vcpus, vcpu_memory_bytes);
 
-	pta->gpa = (vm_get_max_gfn(vm) - guest_num_pages) * pta->guest_page_size;
+	pta->gpa = (vm->max_gfn - guest_num_pages) * pta->guest_page_size;
 	pta->gpa = align_down(pta->gpa, backing_src_pagesz);
 #ifdef __s390x__
 	/* Align to 1M (segment size) */
diff --git a/tools/testing/selftests/kvm/max_guest_memory_test.c b/tools/testing/selftests/kvm/max_guest_memory_test.c
index 2391d071b395..be5c632c2fd2 100644
--- a/tools/testing/selftests/kvm/max_guest_memory_test.c
+++ b/tools/testing/selftests/kvm/max_guest_memory_test.c
@@ -65,8 +65,7 @@ static void *vcpu_worker(void *data)
 	struct kvm_sregs sregs;
 	struct kvm_regs regs;
 
-	vcpu_args_set(vcpu, 3, info->start_gpa, info->end_gpa,
-		      vm_get_page_size(vm));
+	vcpu_args_set(vcpu, 3, info->start_gpa, info->end_gpa, vm->page_size);
 
 	/* Snapshot regs before the first run. */
 	vcpu_regs_get(vcpu, &regs);
@@ -104,7 +103,7 @@ static pthread_t *spawn_workers(struct kvm_vm *vm, struct kvm_vcpu **vcpus,
 	TEST_ASSERT(info, "Failed to allocate vCPU gpa ranges");
 
 	nr_bytes = ((end_gpa - start_gpa) / nr_vcpus) &
-			~((uint64_t)vm_get_page_size(vm) - 1);
+			~((uint64_t)vm->page_size - 1);
 	TEST_ASSERT(nr_bytes, "C'mon, no way you have %d CPUs", nr_vcpus);
 
 	for (i = 0, gpa = start_gpa; i < nr_vcpus; i++, gpa += nr_bytes) {
@@ -220,7 +219,7 @@ int main(int argc, char *argv[])
 
 	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
 
-	max_gpa = vm_get_max_gfn(vm) << vm_get_page_shift(vm);
+	max_gpa = vm->max_gfn << vm->page_shift;
 	TEST_ASSERT(max_gpa > (4 * slot_size), "MAXPHYADDR <4gb ");
 
 	fd = kvm_memfd_alloc(slot_size, hugepages);
@@ -230,7 +229,7 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(!madvise(mem, slot_size, MADV_NOHUGEPAGE), "madvise() failed");
 
 	/* Pre-fault the memory to avoid taking mmap_sem on guest page faults. */
-	for (i = 0; i < slot_size; i += vm_get_page_size(vm))
+	for (i = 0; i < slot_size; i += vm->page_size)
 		((uint8_t *)mem)[i] = 0xaa;
 
 	gpa = 0;
@@ -249,7 +248,7 @@ int main(int argc, char *argv[])
 		for (i = 0; i < slot_size; i += size_1gb)
 			__virt_pg_map(vm, gpa + i, gpa + i, X86_PAGE_SIZE_1G);
 #else
-		for (i = 0; i < slot_size; i += vm_get_page_size(vm))
+		for (i = 0; i < slot_size; i += vm->page_size)
 			virt_pg_map(vm, gpa + i, gpa + i);
 #endif
 	}
diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
index 1f9036cdcaa9..6ee7e1dde404 100644
--- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
+++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
@@ -75,7 +75,7 @@ static void add_remove_memslot(struct kvm_vm *vm, useconds_t delay,
 	 * Add the dummy memslot just below the perf_test_util memslot, which is
 	 * at the top of the guest physical address space.
 	 */
-	gpa = perf_test_args.gpa - pages * vm_get_page_size(vm);
+	gpa = perf_test_args.gpa - pages * vm->page_size;
 
 	for (i = 0; i < nr_modifications; i++) {
 		usleep(delay);
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
index af13c48f0f30..6df5a6356181 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -121,7 +121,7 @@ void test_hv_cpuid_e2big(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	if (vcpu)
 		ret = __vcpu_ioctl(vcpu, KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
 	else
-		ret = __kvm_ioctl(vm_get_kvm_fd(vm), KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
+		ret = __kvm_ioctl(vm->kvm_fd, KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
 
 	TEST_ASSERT(ret == -1 && errno == E2BIG,
 		    "%s KVM_GET_SUPPORTED_HV_CPUID didn't fail with -E2BIG when"
-- 
2.36.1.255.ge46751e96f-goog

