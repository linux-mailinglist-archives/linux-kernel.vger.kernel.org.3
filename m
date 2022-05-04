Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B36D51B307
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiEDW5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379527AbiEDWyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:54:22 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B9C4AE08
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:50:45 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o16-20020a17090ab89000b001d84104fc2cso2393118pjr.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=m+EPHltdynOdUR9+b1b8QS40GbbHNtfF/glWqdKc4L0=;
        b=CsTcsjOwkQ6IpTmdxWmzGO323RrXP7DtfRQIsGMpyUlMx3qZl3/869mwnr1zLw0XXK
         DrKJ6i7D1SRsGF4BYP0NtHtu08xYO74Ms+r+flzlS07PpJ6PAX4rusb5VlQt4dSzo0cV
         /swopcQtp6ewQ2XHtJ8jgUi7h9JLEVSGNlbTYBFkT1voho4Cmh7C0DAWh//uqq/AoE7R
         2hyy+AGblY1qCoKEJ9VHuMbpmV/LU9jWiA4Wf2DRSx0QRrnCsU6/zGO5rgTZ9eBAgeyC
         5ea3wXWJK5qwudLVmyr45gAb08UZPmRgavO0oowpqCNCqvrLU69loaEV8kH7N0oRdSFl
         2vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=m+EPHltdynOdUR9+b1b8QS40GbbHNtfF/glWqdKc4L0=;
        b=AKzgfKbSZF+vtNXGUzrgzZMWjmpSsgTQ+3yqzYF3PTt2t2y5sKBalomcxMYATW9EMs
         a5oIcqy+se/Rwduz4uVOqDa8bsA4hsliEXl0a0l4lZdTYrVqZkY503FpBFYSm2oC2AQk
         wFQvk9K7rX7TpQgHU74KcrHCXkhVF28Sx/o14DHJ7uDsMwFAGGlL4igwt6E8QSM2CvKY
         VdAVdEJmWFrNXcpWeuMAobUFjR1qGoFX2ExU0m/xy/hZPfjPxBlJeOrMZ0ai9qqFpnDE
         /S4Y6P7UZrDsSzE7rdBiReiv46w4ExEaumxZu9I4aPi3NaaBgBQEknqRnpcag3HO4jIE
         bSDw==
X-Gm-Message-State: AOAM532rBtZyFU8fINQRlLxdfkAek4q/ZvecjvM2AD3LkQw0igj0E2W2
        7JJkmkYcwH5khdX65h9rgge2isT2APA=
X-Google-Smtp-Source: ABdhPJz1adNbqMKVvf/fjqHzTk7Np3duENXUFtNKlfBxcgnPoWYBOCoH4jSBL6KA6eykdV5LrU8tsr+3iSw=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:690b:b0:159:65c:9044 with SMTP id
 j11-20020a170902690b00b00159065c9044mr24177158plk.47.1651704644594; Wed, 04
 May 2022 15:50:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:47:48 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-43-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 042/128] KVM: selftests: Convert memslot_perf_test away from VCPU_ID
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
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

Convert memslot_perf_test to use __vm_create_with_one_vcpu() and pass
around a 'struct kvm_vcpu' object instead of using a global VCPU_ID.
This is the first of many, many steps towards eliminating VCPU_ID from
all KVM selftests, and towards eventually purging the VM+vcpu_id mess.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/memslot_perf_test.c | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 1727f75e0c2c..009eb19b28af 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -25,8 +25,6 @@
 #include <kvm_util.h>
 #include <processor.h>
 
-#define VCPU_ID 0
-
 #define MEM_SIZE		((512U << 20) + 4096)
 #define MEM_SIZE_PAGES		(MEM_SIZE / 4096)
 #define MEM_GPA		0x10000000UL
@@ -90,6 +88,7 @@ static_assert(MEM_TEST_MOVE_SIZE <= MEM_TEST_SIZE,
 
 struct vm_data {
 	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
 	pthread_t vcpu_thread;
 	uint32_t nslots;
 	uint64_t npages;
@@ -127,29 +126,29 @@ static bool verbose;
 			pr_info(__VA_ARGS__);	\
 	} while (0)
 
-static void check_mmio_access(struct vm_data *vm, struct kvm_run *run)
+static void check_mmio_access(struct vm_data *data, struct kvm_run *run)
 {
-	TEST_ASSERT(vm->mmio_ok, "Unexpected mmio exit");
+	TEST_ASSERT(data->mmio_ok, "Unexpected mmio exit");
 	TEST_ASSERT(run->mmio.is_write, "Unexpected mmio read");
 	TEST_ASSERT(run->mmio.len == 8,
 		    "Unexpected exit mmio size = %u", run->mmio.len);
-	TEST_ASSERT(run->mmio.phys_addr >= vm->mmio_gpa_min &&
-		    run->mmio.phys_addr <= vm->mmio_gpa_max,
+	TEST_ASSERT(run->mmio.phys_addr >= data->mmio_gpa_min &&
+		    run->mmio.phys_addr <= data->mmio_gpa_max,
 		    "Unexpected exit mmio address = 0x%llx",
 		    run->mmio.phys_addr);
 }
 
-static void *vcpu_worker(void *data)
+static void *vcpu_worker(void *__data)
 {
-	struct vm_data *vm = data;
-	struct kvm_run *run;
+	struct vm_data *data = __data;
+	struct kvm_vcpu *vcpu = data->vcpu;
+	struct kvm_run *run = vcpu->run;
 	struct ucall uc;
 
-	run = vcpu_state(vm->vm, VCPU_ID);
 	while (1) {
-		vcpu_run(vm->vm, VCPU_ID);
+		vcpu_run(data->vm, vcpu->id);
 
-		switch (get_ucall(vm->vm, VCPU_ID, &uc)) {
+		switch (get_ucall(data->vm, vcpu->id, &uc)) {
 		case UCALL_SYNC:
 			TEST_ASSERT(uc.args[1] == 0,
 				"Unexpected sync ucall, got %lx",
@@ -158,7 +157,7 @@ static void *vcpu_worker(void *data)
 			continue;
 		case UCALL_NONE:
 			if (run->exit_reason == KVM_EXIT_MMIO)
-				check_mmio_access(vm, run);
+				check_mmio_access(data, run);
 			else
 				goto done;
 			break;
@@ -238,6 +237,7 @@ static struct vm_data *alloc_vm(void)
 	TEST_ASSERT(data, "malloc(vmdata) failed");
 
 	data->vm = NULL;
+	data->vcpu = NULL;
 	data->hva_slots = NULL;
 
 	return data;
@@ -278,7 +278,7 @@ static bool prepare_vm(struct vm_data *data, int nslots, uint64_t *maxslots,
 	data->hva_slots = malloc(sizeof(*data->hva_slots) * data->nslots);
 	TEST_ASSERT(data->hva_slots, "malloc() fail");
 
-	data->vm = vm_create_default(VCPU_ID, mempages, guest_code);
+	data->vm = __vm_create_with_one_vcpu(&data->vcpu, mempages, guest_code);
 	ucall_init(data->vm, NULL);
 
 	pr_info_v("Adding slots 1..%i, each slot with %"PRIu64" pages + %"PRIu64" extra pages last\n",
-- 
2.36.0.464.gb9c8b46e94-goog

