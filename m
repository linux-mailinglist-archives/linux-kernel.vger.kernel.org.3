Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3971E4D5ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346589AbiCKFxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346594AbiCKFwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:42 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130D6FABE6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:32 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id y193-20020a62ceca000000b004f6f5bbaf7cso4600029pfg.16
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=JZ18FvKyAgPHX4bJsnv+PWp+FVnhqOl3G32xWvFHUnA=;
        b=cCXD9CQKQa4o6Cy8J8TfGp3yHPjrpopdDOPGsraEysClIyvb0OvkAOxfugVyip6qGn
         y69AC2bl1NabaQTlUWpobE3eQGJDKoZttgU7Spzp7m75cdNsq0DXnceoL643Q/TWJWqp
         tPvktgFBmchJzVWefuvT4gUrFkrW9gR7wYQTa5iHwNCFIJrtb+OgHqE0PiNY9oK+qGKC
         eDsjyIlQQl8sWx/toEEPBfswKFPkz1jwvI+GPJaHt1UEc/gE+3A//waYaE/MkBoJKtgr
         RRxSEr28KscMNUSUU2JjODXw3bxX4OhgMWtJkNXRBeLPzpIO7LxlmKx4FfmFBre8UPcF
         pXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=JZ18FvKyAgPHX4bJsnv+PWp+FVnhqOl3G32xWvFHUnA=;
        b=b6IaEDQhqB/UtcgoIrU95UucVnwNpCV49VssqIOptqS5KnuapwFLP94vtW2Cxh+QnW
         8H68a5+3rH3nobzKFohnCrviLAfxFJ+CBS3gO8OLcCvfNKwdOZJIx7xNUUCFCN9Arbx5
         BwlFS1iQwTLaLZ9t7JbjA843uX9M3/G5kQcbxSIVu3CbMu9NciW/+pp7TO60KwdM28uH
         r2Mv9T0RwejxZiL6mQpmd1BeMgPKH+/jYB8EGS18qEbOF4vtdTyz/H7KzaydvIIbUU/r
         Wu4p16Emhkp405add/p3SlXDb0zUifOlzW0abAoMuWmiDzDY1fnjj3NWES09g5VLpOfq
         Lkng==
X-Gm-Message-State: AOAM532ay2iZvYYS6jQ7H/iGAO4apFtG73Z6apNyvF8xkAwJpWmNW4Xu
        1RJ08hB6NUR+wkSSjHQr44kGTJshAWTn+rYSA+74Cspy39yqrmxcKzPz81d7HUunA3ycRn2dt6w
        moZEN2ElxIovSs7fHgjw9P+Z4qkndDxAW+MjTEw5wEjbHZG5JboZ8T+hrz8/2tKjSDs1wCQ==
X-Google-Smtp-Source: ABdhPJx1cXVvTiNLkxFNCBhpxdqHcwfavHgc0rjvkR2vfHvRuOUUOcub/aLkP9/tnb3mhinFRXPCOszSngA=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:2287:b0:151:dbaf:564a with SMTP id
 b7-20020a170903228700b00151dbaf564amr8986209plh.110.1646977892354; Thu, 10
 Mar 2022 21:51:32 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:27 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-17-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 016/105] KVM: selftests: Use kvm_ioctl() helpers
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
 .../selftests/kvm/lib/aarch64/processor.c     |  4 +--
 tools/testing/selftests/kvm/lib/guest_modes.c |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 10 +++---
 .../selftests/kvm/lib/x86_64/processor.c      | 31 ++++++-------------
 .../kvm/x86_64/get_msr_index_features.c       | 16 +++-------
 .../selftests/kvm/x86_64/mmio_warning_test.c  |  6 ++--
 6 files changed, 24 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 9343d82519b4..06c3dafc82c4 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -469,8 +469,8 @@ void aarch64_get_supported_page_sizes(uint32_t ipa,
 	};
 
 	kvm_fd = open_kvm_dev_path_or_exit();
-	vm_fd = ioctl(kvm_fd, KVM_CREATE_VM, ipa);
-	TEST_ASSERT(vm_fd >= 0, "Can't create VM");
+	vm_fd = __kvm_ioctl(kvm_fd, KVM_CREATE_VM, ipa);
+	TEST_ASSERT(vm_fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VM, vm_fd));
 
 	vcpu_fd = ioctl(vm_fd, KVM_CREATE_VCPU, 0);
 	TEST_ASSERT(vcpu_fd >= 0, "Can't create vcpu");
diff --git a/tools/testing/selftests/kvm/lib/guest_modes.c b/tools/testing/selftests/kvm/lib/guest_modes.c
index 8784013b747c..9ab27b4169bf 100644
--- a/tools/testing/selftests/kvm/lib/guest_modes.c
+++ b/tools/testing/selftests/kvm/lib/guest_modes.c
@@ -65,7 +65,7 @@ void guest_modes_append_default(void)
 		struct kvm_s390_vm_cpu_processor info;
 
 		kvm_fd = open_kvm_dev_path_or_exit();
-		vm_fd = ioctl(kvm_fd, KVM_CREATE_VM, 0);
+		vm_fd = __kvm_ioctl(kvm_fd, KVM_CREATE_VM, 0);
 		kvm_device_access(vm_fd, KVM_S390_VM_CPU_MODEL,
 				  KVM_S390_VM_CPU_PROCESSOR, &info, false);
 		close(vm_fd);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1b120c7a7845..76f8b924fb31 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -76,9 +76,8 @@ int kvm_check_cap(long cap)
 	int kvm_fd;
 
 	kvm_fd = open_kvm_dev_path_or_exit();
-	ret = ioctl(kvm_fd, KVM_CHECK_EXTENSION, cap);
-	TEST_ASSERT(ret >= 0, "KVM_CHECK_EXTENSION IOCTL failed,\n"
-		"  rc: %i errno: %i", ret, errno);
+	ret = __kvm_ioctl(kvm_fd, KVM_CHECK_EXTENSION, cap);
+	TEST_ASSERT(ret >= 0, KVM_IOCTL_ERROR(KVM_CHECK_EXTENSION, ret));
 
 	close(kvm_fd);
 
@@ -104,9 +103,8 @@ static void vm_open(struct kvm_vm *vm)
 		exit(KSFT_SKIP);
 	}
 
-	vm->fd = ioctl(vm->kvm_fd, KVM_CREATE_VM, vm->type);
-	TEST_ASSERT(vm->fd >= 0, "KVM_CREATE_VM ioctl failed, "
-		"rc: %i errno: %i", vm->fd, errno);
+	vm->fd = __kvm_ioctl(vm->kvm_fd, KVM_CREATE_VM, vm->type);
+	TEST_ASSERT(vm->fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VM, vm->fd));
 }
 
 const char *vm_guest_mode_string(uint32_t i)
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 4065fc4daada..64dd2acb2ab7 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -677,7 +677,7 @@ void vm_xsave_req_perm(int bit)
 	};
 
 	kvm_fd = open_kvm_dev_path_or_exit();
-	rc = ioctl(kvm_fd, KVM_GET_DEVICE_ATTR, &attr);
+	rc = __kvm_ioctl(kvm_fd, KVM_GET_DEVICE_ATTR, &attr);
 	close(kvm_fd);
 	if (rc == -1 && (errno == ENXIO || errno == EINVAL))
 		exit(KSFT_SKIP);
@@ -777,7 +777,6 @@ static struct kvm_cpuid2 *allocate_kvm_cpuid2(void)
 struct kvm_cpuid2 *kvm_get_supported_cpuid(void)
 {
 	static struct kvm_cpuid2 *cpuid;
-	int ret;
 	int kvm_fd;
 
 	if (cpuid)
@@ -786,9 +785,7 @@ struct kvm_cpuid2 *kvm_get_supported_cpuid(void)
 	cpuid = allocate_kvm_cpuid2();
 	kvm_fd = open_kvm_dev_path_or_exit();
 
-	ret = ioctl(kvm_fd, KVM_GET_SUPPORTED_CPUID, cpuid);
-	TEST_ASSERT(ret == 0, "KVM_GET_SUPPORTED_CPUID failed %d %d\n",
-		    ret, errno);
+	kvm_ioctl(kvm_fd, KVM_GET_SUPPORTED_CPUID, cpuid);
 
 	close(kvm_fd);
 	return cpuid;
@@ -818,7 +815,7 @@ uint64_t kvm_get_feature_msr(uint64_t msr_index)
 	buffer.entry.index = msr_index;
 	kvm_fd = open_kvm_dev_path_or_exit();
 
-	r = ioctl(kvm_fd, KVM_GET_MSRS, &buffer.header);
+	r = __kvm_ioctl(kvm_fd, KVM_GET_MSRS, &buffer.header);
 	TEST_ASSERT(r == 1, "KVM_GET_MSRS IOCTL failed,\n"
 		"  rc: %i errno: %i", r, errno);
 
@@ -990,9 +987,9 @@ static int kvm_get_num_msrs_fd(int kvm_fd)
 	int r;
 
 	nmsrs.nmsrs = 0;
-	r = ioctl(kvm_fd, KVM_GET_MSR_INDEX_LIST, &nmsrs);
-	TEST_ASSERT(r == -1 && errno == E2BIG, "Unexpected result from KVM_GET_MSR_INDEX_LIST probe, r: %i",
-		r);
+	r = __kvm_ioctl(kvm_fd, KVM_GET_MSR_INDEX_LIST, &nmsrs);
+	TEST_ASSERT(r == -1 && errno == E2BIG,
+		    "Unexpected result from KVM_GET_MSR_INDEX_LIST probe, r: %i", r);
 
 	return nmsrs.nmsrs;
 }
@@ -1005,19 +1002,16 @@ static int kvm_get_num_msrs(struct kvm_vm *vm)
 struct kvm_msr_list *kvm_get_msr_index_list(void)
 {
 	struct kvm_msr_list *list;
-	int nmsrs, r, kvm_fd;
+	int nmsrs, kvm_fd;
 
 	kvm_fd = open_kvm_dev_path_or_exit();
 
 	nmsrs = kvm_get_num_msrs_fd(kvm_fd);
 	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
 	list->nmsrs = nmsrs;
-	r = ioctl(kvm_fd, KVM_GET_MSR_INDEX_LIST, list);
+	kvm_ioctl(kvm_fd, KVM_GET_MSR_INDEX_LIST, list);
 	close(kvm_fd);
 
-	TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_MSR_INDEX_LIST, r: %i",
-		r);
-
 	return list;
 }
 
@@ -1063,9 +1057,7 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
 	nmsrs = kvm_get_num_msrs(vm);
 	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
 	list->nmsrs = nmsrs;
-	r = ioctl(vm->kvm_fd, KVM_GET_MSR_INDEX_LIST, list);
-	TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_MSR_INDEX_LIST, r: %i",
-		    r);
+	kvm_ioctl(vm->kvm_fd, KVM_GET_MSR_INDEX_LIST, list);
 
 	state = malloc(sizeof(*state) + nmsrs * sizeof(state->msrs.entries[0]));
 	r = ioctl(vcpu->fd, KVM_GET_VCPU_EVENTS, &state->events);
@@ -1373,7 +1365,6 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(void)
 {
 	static struct kvm_cpuid2 *cpuid;
-	int ret;
 	int kvm_fd;
 
 	if (cpuid)
@@ -1382,9 +1373,7 @@ struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(void)
 	cpuid = allocate_kvm_cpuid2();
 	kvm_fd = open_kvm_dev_path_or_exit();
 
-	ret = ioctl(kvm_fd, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
-	TEST_ASSERT(ret == 0, "KVM_GET_SUPPORTED_HV_CPUID failed %d %d\n",
-		    ret, errno);
+	kvm_ioctl(kvm_fd, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
 
 	close(kvm_fd);
 	return cpuid;
diff --git a/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c b/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c
index 8aed0db1331d..4ef60adbe108 100644
--- a/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c
+++ b/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c
@@ -34,7 +34,7 @@ static int kvm_num_index_msrs(int kvm_fd, int nmsrs)
 
 static void test_get_msr_index(void)
 {
-	int old_res, res, kvm_fd, r;
+	int old_res, res, kvm_fd;
 	struct kvm_msr_list *list;
 
 	kvm_fd = open_kvm_dev_path_or_exit();
@@ -50,11 +50,8 @@ static void test_get_msr_index(void)
 
 	list = malloc(sizeof(*list) + old_res * sizeof(list->indices[0]));
 	list->nmsrs = old_res;
-	r = ioctl(kvm_fd, KVM_GET_MSR_INDEX_LIST, list);
+	kvm_ioctl(kvm_fd, KVM_GET_MSR_INDEX_LIST, list);
 
-	TEST_ASSERT(r == 0,
-		    "Unexpected result from KVM_GET_MSR_FEATURE_INDEX_LIST, r: %i",
-		    r);
 	TEST_ASSERT(list->nmsrs == old_res, "Expecting nmsrs to be identical");
 	free(list);
 
@@ -68,7 +65,7 @@ static int kvm_num_feature_msrs(int kvm_fd, int nmsrs)
 
 	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
 	list->nmsrs = nmsrs;
-	r = ioctl(kvm_fd, KVM_GET_MSR_FEATURE_INDEX_LIST, list);
+	r = __kvm_ioctl(kvm_fd, KVM_GET_MSR_FEATURE_INDEX_LIST, list);
 	TEST_ASSERT(r == -1 && errno == E2BIG,
 		"Unexpected result from KVM_GET_MSR_FEATURE_INDEX_LIST probe, r: %i",
 				r);
@@ -81,15 +78,10 @@ static int kvm_num_feature_msrs(int kvm_fd, int nmsrs)
 struct kvm_msr_list *kvm_get_msr_feature_list(int kvm_fd, int nmsrs)
 {
 	struct kvm_msr_list *list;
-	int r;
 
 	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
 	list->nmsrs = nmsrs;
-	r = ioctl(kvm_fd, KVM_GET_MSR_FEATURE_INDEX_LIST, list);
-
-	TEST_ASSERT(r == 0,
-		"Unexpected result from KVM_GET_MSR_FEATURE_INDEX_LIST, r: %i",
-		r);
+	kvm_ioctl(kvm_fd, KVM_GET_MSR_FEATURE_INDEX_LIST, list);
 
 	return list;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
index 9f55ccd169a1..31ae837fedb1 100644
--- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
@@ -59,10 +59,10 @@ void test(void)
 
 	kvm = open("/dev/kvm", O_RDWR);
 	TEST_ASSERT(kvm != -1, "failed to open /dev/kvm");
-	kvmvm = ioctl(kvm, KVM_CREATE_VM, 0);
-	TEST_ASSERT(kvmvm != -1, "KVM_CREATE_VM failed");
+	kvmvm = __kvm_ioctl(kvm, KVM_CREATE_VM, 0);
+	TEST_ASSERT(kvmvm > 0, KVM_IOCTL_ERROR(KVM_CREATE_VM, kvmvm));
 	kvmcpu = ioctl(kvmvm, KVM_CREATE_VCPU, 0);
-	TEST_ASSERT(kvmcpu != -1, "KVM_CREATE_VCPU failed");
+	TEST_ASSERT(kvmcpu != -1, KVM_IOCTL_ERROR(KVM_CREATE_VCPU, kvmcpu));
 	run = (struct kvm_run *)mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_SHARED,
 				    kvmcpu, 0);
 	tc.kvmcpu = kvmcpu;
-- 
2.35.1.723.g4982287a31-goog

