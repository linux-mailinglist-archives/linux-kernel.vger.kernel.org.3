Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEA05A1D24
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 01:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244599AbiHYX0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 19:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244467AbiHYXZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 19:25:37 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F2A57556
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 16:25:35 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a14-20020a056a001d0e00b00537c2c8f4c6so115704pfx.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 16:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=wdNV3+ho8idBWBHEEqE6kDcvd40fMYS/EbUHyIfKU5Q=;
        b=CKYBiYHJ82pvfrOtFxkSctUztyjBv9QzfL1QBjz6wSUJxFTA8yh9SzsSFGbntnf4od
         F/Oat7ZSbk5gO/5Gc4ghTVtAXAApqJC9rLu13N1YWI6pUNXE5G7grgUuQ8eC2Vi3MT+m
         rNe8mKwzTjUCNqf9bdnIBNXlIbKc1pCjgLRoeUkTKm3Fi9lyT0BhXoKg1lBBytmPTewf
         tWwG953CduQlb5wTuKMWnx98K1AENt6ZHvnWASztowlf5Au9swQHbjSJXKVxEZBn3VeE
         d84id4aNO9q2L/4a4LXD0Ox2bh9l7so+brK3JthsVa+Sap3JQnnZZhuXUFLQKGwAz6AU
         aGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=wdNV3+ho8idBWBHEEqE6kDcvd40fMYS/EbUHyIfKU5Q=;
        b=7GDsFs0SG8BFnv63Q+wGtWK9jWxp+L5E8qJ0qFIxyNujtJIdFxvWQ/YjXqw9BrUWl5
         fA1l5nlwsFY1OKoI0prpDHS6pdctPtWT+94eN18zg1Iu5kYh9c18b/CcdNESWy3NguEw
         NBEiUL3aNPU19+ZI0V/1kUfL+kXhxUDBi8XIrjpTbyA0y2pCUAXT84T4mBIkBZJYENVE
         XpCXqDhE5M/H8w150CY2Ao70Ctyl+S61Lciav0y6+JCGd9HFly5i0B8zg3GNZdQQfRZH
         knLqqmGsiBDo0Y777gz/v4zZ07bAUsvCWzbgGNLZU/zXisusYrRpMrhJjeKww0xAKOAJ
         n7Xw==
X-Gm-Message-State: ACgBeo2sCrNhe4ZeGSqogDMcrVPgqUy5yScQ3Lv4Ao9WNxMyRYDgRm8Y
        ZOoomEIPUEOtv+gx8Y/uJiOxnjbkAgQ=
X-Google-Smtp-Source: AA6agR7i+ffJeGpr9+4H53W6fHkE29qzEvwZt9BQq1rOlKBXsxs1PkrupmUW6HxqMLCe/4BQMYmFP7WNDK8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:4c92:b0:536:ac94:e8b0 with SMTP id
 eb18-20020a056a004c9200b00536ac94e8b0mr1327350pfb.13.1661469934983; Thu, 25
 Aug 2022 16:25:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 25 Aug 2022 23:25:21 +0000
In-Reply-To: <20220825232522.3997340-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220825232522.3997340-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220825232522.3997340-7-seanjc@google.com>
Subject: [PATCH v5 6/7] KVM: selftest: Drop now-unnecessary ucall_uninit()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>,
        Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Colton Lewis <coltonlewis@google.com>,
        Peter Gonda <pgonda@google.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Sean Christopherson <seanjc@google.com>
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

Drop ucall_uninit() and ucall_arch_uninit() now that ARM doesn't modify
the host's copy of ucall_exit_mmio_addr, i.e. now that there's no need to
reset the pointer before potentially creating a new VM.  The few calls to
ucall_uninit() are all immediately followed by kvm_vm_free(), and that is
likely always going to hold true, i.e. it's extremely unlikely a test
will want to effectively disable ucall in the middle of a test.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c       |  1 -
 tools/testing/selftests/kvm/include/ucall_common.h |  6 ------
 tools/testing/selftests/kvm/kvm_page_table_test.c  |  1 -
 tools/testing/selftests/kvm/lib/aarch64/ucall.c    | 14 ++------------
 tools/testing/selftests/kvm/lib/perf_test_util.c   |  1 -
 tools/testing/selftests/kvm/lib/riscv/ucall.c      |  4 ----
 tools/testing/selftests/kvm/lib/s390x/ucall.c      |  4 ----
 tools/testing/selftests/kvm/lib/x86_64/ucall.c     |  4 ----
 8 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 583b46250d07..d418fef1653b 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -809,7 +809,6 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	free(bmap);
 	free(host_bmap_track);
-	ucall_uninit(vm);
 	kvm_vm_free(vm);
 }
 
diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index 8077a6d8b1ba..2662a4352a8c 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -25,7 +25,6 @@ struct ucall {
 };
 
 void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa);
-void ucall_arch_uninit(struct kvm_vm *vm);
 void ucall_arch_do_ucall(vm_vaddr_t uc);
 void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu);
 
@@ -37,11 +36,6 @@ static inline void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
 	ucall_arch_init(vm, mmio_gpa);
 }
 
-static inline void ucall_uninit(struct kvm_vm *vm)
-{
-	ucall_arch_uninit(vm);
-}
-
 #define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
 				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
 #define GUEST_SYNC(stage)	ucall(UCALL_SYNC, 2, "hello", stage)
diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index 20533c48ba3d..d77b1f634f29 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -416,7 +416,6 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	TEST_ASSERT(ret == 0, "Error in sem_destroy");
 
 	free(vcpu_threads);
-	ucall_uninit(vm);
 	kvm_vm_free(vm);
 }
 
diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
index 1c38bd260f90..21d73afcb14f 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
@@ -12,23 +12,13 @@
  */
 static vm_vaddr_t *ucall_exit_mmio_addr;
 
-static void ucall_set_mmio_addr(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
-{
-	vm->ucall_mmio_addr = mmio_gpa;
-
-	write_guest_global(vm, ucall_exit_mmio_addr, (vm_vaddr_t *)mmio_gpa);
-}
-
 void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
 {
 	virt_pg_map(vm, mmio_gpa, mmio_gpa);
 
-	ucall_set_mmio_addr(vm, mmio_gpa);
-}
+	vm->ucall_mmio_addr = mmio_gpa;
 
-void ucall_arch_uninit(struct kvm_vm *vm)
-{
-	ucall_set_mmio_addr(vm, (vm_paddr_t)NULL);
+	write_guest_global(vm, ucall_exit_mmio_addr, (vm_vaddr_t *)mmio_gpa);
 }
 
 void ucall_arch_do_ucall(vm_vaddr_t uc)
diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
index 5161fa68cdf3..78e5be2c7f1a 100644
--- a/tools/testing/selftests/kvm/lib/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
@@ -217,7 +217,6 @@ struct kvm_vm *perf_test_create_vm(enum vm_guest_mode mode, int nr_vcpus,
 
 void perf_test_destroy_vm(struct kvm_vm *vm)
 {
-	ucall_uninit(vm);
 	kvm_vm_free(vm);
 }
 
diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
index c58ecb8a0981..78acdb084ab0 100644
--- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
+++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
@@ -14,10 +14,6 @@ void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
 {
 }
 
-void ucall_arch_uninit(struct kvm_vm *vm)
-{
-}
-
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
 			unsigned long arg3, unsigned long arg4,
diff --git a/tools/testing/selftests/kvm/lib/s390x/ucall.c b/tools/testing/selftests/kvm/lib/s390x/ucall.c
index 208f0f04299b..cbee520a26f2 100644
--- a/tools/testing/selftests/kvm/lib/s390x/ucall.c
+++ b/tools/testing/selftests/kvm/lib/s390x/ucall.c
@@ -10,10 +10,6 @@ void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
 {
 }
 
-void ucall_arch_uninit(struct kvm_vm *vm)
-{
-}
-
 void ucall_arch_do_ucall(vm_vaddr_t uc)
 {
 	/* Exit via DIAGNOSE 0x501 (normally used for breakpoints) */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/ucall.c b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
index 016a0487cf72..eb8bf55b359a 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
@@ -12,10 +12,6 @@ void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
 {
 }
 
-void ucall_arch_uninit(struct kvm_vm *vm)
-{
-}
-
 void ucall_arch_do_ucall(vm_vaddr_t uc)
 {
 	asm volatile("in %[port], %%al"
-- 
2.37.2.672.g94769d06f0-goog

