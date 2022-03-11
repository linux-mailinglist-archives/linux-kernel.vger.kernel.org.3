Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C23E4D5B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346960AbiCKGB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346803AbiCKFzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:13 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC11F107087
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:54:03 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d4-20020a170902f14400b001518350e5c7so4003729plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Gh9b7yGh71XESe9+XJf/ZpDDs0MzOvk/6zKTOSCjZ2o=;
        b=bi09KmRsZELpB1WnhRIg7A6s2byKUhPKkBYC8hIGM/0yRMW4uzG7OTg8SVx+WVlNeD
         m+EZTzbRrA8o1TDY0G8JVYzOiB1UdJeHtSXyOPCPwxXh7AEVWoTqDi1SaH2XvhgI6Mv1
         r/ha11ToX4GOl9clpa+/9s9DT1EhKjyuGZkmfSsUeHlBs8TT+CZFFszuqmPtioW1KL0k
         7G5TuJG8DuEVPtRWjTUsav+Xyu6pfsAtykIeX+9xfGav+HRRWSvc2N2ZNKa2tkG8eIOm
         CKcUXzlV2jvHgKh+VUyqXx5ZlVl+m3/gp5jm7qPyg686FVyX62qD80L2Kw/Bho2vQfOf
         yNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Gh9b7yGh71XESe9+XJf/ZpDDs0MzOvk/6zKTOSCjZ2o=;
        b=cksTQJZyDd7e3P3+UIeMRDAzUKnQwOqyb+CG1iGVCWZqejkxkl5pkwnEcxUziPYURX
         EamF47+vk3O647nAZSAdUhpRKSXVEOA1fJSz7rjlEOAhpaln44nKFpaZEqjfdPWzK3o8
         bUMeOa8v7HA0r1pw2d9O9qwbCQaXSX2Z1JtR8GA6rAlrp4SvrkWHgw9IlRjlh6w1SuGi
         8k0Nh2tOckwNrCErxmfWUmxRgirTWKSvA9fbLiNmToJFPloRR5AmImGjmRkqWp3T7p5b
         lThhCTHH80l2e1wIitygcO+oDW0i52CTvW9ZRFDU0eSe0pJTzBCICtAEh3Erm0wX97AP
         dMhg==
X-Gm-Message-State: AOAM530SNCA3JgZE0oINla5SKtGp9VZoUmHw9ZZK9efRcNybb+BLM+2/
        JzEf5ybYccYWAEMrczrwTpWq0mbEAQH+zlmKos1cf/hPiRpmZyRkewCjIqaL2lXMn3tYHBG/ZfY
        19z1TLClICT4UPtDmYA6y604Nq2ex2wjh9NzaHb5D6wUVks4KgTrPY7B5qQflkAljGspwGg==
X-Google-Smtp-Source: ABdhPJzLkGRFjJZj+AM4mYNXbt9RR5JLlYixtGiL8Y0iPuA+6ut2aG2nUoCBR5N3SAfGI9juXnyyfZPheXY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4d81:b0:1bf:8ce4:4f51 with SMTP id
 oj1-20020a17090b4d8100b001bf8ce44f51mr461979pjb.0.1646978042280; Thu, 10 Mar
 2022 21:54:02 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:56 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-106-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 105/105] KVM: selftests: Open code and drop kvm_vm accessors
From:   Sean Christopherson <seanjc@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>
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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/dirty_log_perf_test.c       |  2 +-
 tools/testing/selftests/kvm/dirty_log_test.c  |  9 +++----
 .../selftests/kvm/include/kvm_util_base.h     |  6 -----
 .../selftests/kvm/kvm_page_table_test.c       |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 25 -------------------
 .../selftests/kvm/lib/perf_test_util.c        |  7 +++---
 .../kvm/memslot_modification_stress_test.c    |  2 +-
 .../selftests/kvm/x86_64/hyperv_cpuid.c       |  2 +-
 8 files changed, 11 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 4d021f1ae479..d06c684664c3 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -187,7 +187,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	perf_test_set_wr_fract(vm, p->wr_fract);
 
-	guest_num_pages = (nr_vcpus * guest_percpu_mem_size) >> vm_get_page_shift(vm);
+	guest_num_pages = (nr_vcpus * guest_percpu_mem_size) >> vm->page_shift;
 	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
 	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
 	pages_per_slot = host_num_pages / p->slots;
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index d8a5e45520fb..116c6bf0e6b1 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -719,21 +719,20 @@ static void run_test(enum vm_guest_mode mode, void *arg)
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
index f6926ab277d3..2f06eecfbb78 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -551,13 +551,7 @@ static inline struct kvm_vm *vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 
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
index cb7ffe9671bc..e6acae147d44 100644
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
index 7f82c6ba2a37..a028d3705cf5 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1814,36 +1814,11 @@ void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva)
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
2.35.1.723.g4982287a31-goog

