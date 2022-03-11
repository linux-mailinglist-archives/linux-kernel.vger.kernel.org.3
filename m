Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38F54D5AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346825AbiCKFzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346646AbiCKFxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:02 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2CDF1EA7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:59 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id mz5-20020a17090b378500b001bf46a762baso4597183pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=YnadzkYyNjF+fzeB8scKl4DilzlfzfccfFXWWoIeDLc=;
        b=LDDmXTEIAYa9pHs4CxDuIN7VI9GU6liI34vFnU3k6zfF/aBCFBmQGJ8A5M4xhyC53Q
         1tJZD5x9HPo0yrIs2xFlx2t2IUqvkUBYEXaOLQ8roDwRfsDzEiUD/ljhb5n2dKYz8xR2
         YOuNmFsxfABeqgA0eJUD+nY8eEurNxAnwloneyV2hZMS4ZW/rFavyOa4plmTiBC2iZKu
         KfXnrFn2eARy2y/UKrB0SZUXJLFwfxggn0UkxVdr6arrcxLMmjsGmwlHJiKD53rOONEv
         ZpBcCqCwzsrWchOqNKFtulrcHpxSovCyf7t8cT5cfIydk1+6C23WJTOsMqjGep/VVh6I
         qhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=YnadzkYyNjF+fzeB8scKl4DilzlfzfccfFXWWoIeDLc=;
        b=xdE21jIOGpJ7xRz2qrgskCRqS0iQoy150R0K5kce58LEs//k0rSF9EdRNLUI3jpJxa
         Tzeq7WX9prGWI1RFWhTyy3lsih7fXqk16Y+uDihQJGnPRQtq9so76l6LOtlMmU2sx8yO
         tXzvs3knLzX3BuB0Y4nVxM2TSvJBvQHKqYguKwPwZs494caU6L5DebUTVMvCYKX4e6lx
         vND0OBNN/iuuto4DLlDqEjIyUf6zJXNwHkmcBWHCZv7B35HETsJ6xFSUFSKvzatjzKez
         AEj2ase47NFdCXktMXvW3nhEnAs7JC89eKEtQ8xw7yEHwBK1XFgaZf0Smh78mh7xuG3m
         e3fg==
X-Gm-Message-State: AOAM530sD2IUS+hGTq58Frgb1Mtt+gc6cfcJ4w26C59f1r2ENR+Miw6X
        MJFlTyKF8o2Z5rLYCIAojGKW951Xwk2GzmXNzAcgyNTXui9cbtixuzqYckMRMwGS8DTPi06XiaO
        MBEVHNLp94piaon03KHEg3z+euLXNZoqDHcBXfZ4nK2fM9f9SajNoUKCFcy0ESehgOeiJ+A==
X-Google-Smtp-Source: ABdhPJwxvswc6Yx2p7h+8fc+qyEzztddTjuD9WD0yQyJz78u+b8LwHy4EhFWAi7BACej6Gy/kFIlN87m2t8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:22cd:b0:151:a884:d444 with SMTP id
 y13-20020a17090322cd00b00151a884d444mr8793101plg.141.1646977918459; Thu, 10
 Mar 2022 21:51:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:42 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-32-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 031/105] KVM: selftests: Convert memslot_perf_test away
 from VCPU_ID
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
2.35.1.723.g4982287a31-goog

