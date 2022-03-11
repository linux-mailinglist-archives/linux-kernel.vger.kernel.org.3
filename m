Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15954D5B43
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346949AbiCKGCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346768AbiCKFzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:09 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0331017F9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:48 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id h69-20020a628348000000b004f769e5b4bdso2827815pfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ik8aZKQiVh0KHQbr87ubLxwNVrAP3Y5BKOg9RURF8F4=;
        b=mjOO+xp7DwVMQPq2fKDbBmtTDW/Bu8dUEwPrLqBds1noEDa77ZKAOxw4n/6SUHgQ41
         IQxOaaif25LQJyrs2bsPHXUfYw5fXnVlcQaOiAfZoKhGdUcrm4RRo8wlim5uWctAbB2d
         Qn3UvwwBk0jpNeOVOF+hOHppV9aXbyJ2fOybhpJIx63rvHp2BXBcxeo8ONHoE+fLal7C
         WIABNrIPxhIeavnq+yNl1H2XAaumNq82Ze6GQsyCjm1Z/qEl3bF3N0A8DGwW7+Dui/+i
         Xt5eAMJER7cPeZNB+Msp2l92bybEsST7KkeSKQOAmtgOjYwFNelr4P5Q75Z+k4MqiIVt
         d+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ik8aZKQiVh0KHQbr87ubLxwNVrAP3Y5BKOg9RURF8F4=;
        b=Jb271hf4GLwTfwdniRIVY17Tr/xomEQ6zvxciRLBqZ7Yj4FrKNXxuQWKeXR+2nxAxq
         3QGkvD2J+qD5E6Yv4KALCd0YdNj3Box44Ec3JxNmhGKlTQXlb4L8k9EWorbAtvUJoUiX
         fdGSsAk5QQZ3QkJysW6SKlS4aZEuMro1wjuQoyypLgzU38zXzNuvZccu7ZSIWtdmYWoF
         kCglV1z6S2UJ4ZGzT+0ztYUIjGOYQGhC1G8MQPvm/3ckD4WThMe+mixHt1Uc/EBuv+44
         EB7AF7s7GGhAc13SGOmZVaCbO8BcZIKsn/2Q5yFfKCWGSc85ZaMqRMVvPEtS0OgvPg5r
         FjjQ==
X-Gm-Message-State: AOAM530A5ZugmVhU7OEn/0P5UkzMjtORc77vxSxWq+Hle1kIRrc5v8RB
        dloDrembHbf7wiRHaiVqv+bs2ya+/ZRQMWc3OUhJhzMfNBEW+4Y6OyidajVP+l0Dpkk9nZKopLM
        v+fGmQbyl6K6yXmJ6R4GUI327lxTcTrBT3LaX46WTdnWGDrjR3QeUcUyNiFQ1SYq+OjeJqw==
X-Google-Smtp-Source: ABdhPJx4KnPfQN5NHHK4QhPpBVi2K73b5cxXJ7iG159FSiDZnmHrWeV8vzLa9fYm8qfqBUW0p2P3ZDk0rHQ=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4d81:b0:1bf:8ce4:4f51 with SMTP id
 oj1-20020a17090b4d8100b001bf8ce44f51mr461891pjb.0.1646978027765; Thu, 10 Mar
 2022 21:53:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:47 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-97-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 096/105] KVM: selftests: Convert kvm_page_table_test away
 from reliance on vcpu_id
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
 .../selftests/kvm/kvm_page_table_test.c       | 61 +++++++------------
 1 file changed, 21 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index a3e3957f67fa..2c92aef163f9 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -46,11 +46,6 @@ static const char * const test_stage_string[] = {
 	"KVM_ADJUST_MAPPINGS",
 };
 
-struct vcpu_args {
-	int vcpu_id;
-	bool vcpu_write;
-};
-
 struct test_args {
 	struct kvm_vm *vm;
 	uint64_t guest_test_virt_mem;
@@ -60,7 +55,7 @@ struct test_args {
 	uint64_t large_num_pages;
 	uint64_t host_pages_per_lpage;
 	enum vm_mem_backing_src_type src_type;
-	struct vcpu_args vcpu_args[KVM_MAX_VCPUS];
+	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 };
 
 /*
@@ -92,17 +87,13 @@ static uint64_t guest_test_phys_mem;
  */
 static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
 
-static void guest_code(int vcpu_id)
+static void guest_code(bool do_write)
 {
 	struct test_args *p = &test_args;
-	struct vcpu_args *vcpu_args = &p->vcpu_args[vcpu_id];
 	enum test_stage *current_stage = &guest_test_stage;
 	uint64_t addr;
 	int i, j;
 
-	/* Make sure vCPU args data structure is not corrupt */
-	GUEST_ASSERT(vcpu_args->vcpu_id == vcpu_id);
-
 	while (true) {
 		addr = p->guest_test_virt_mem;
 
@@ -123,7 +114,7 @@ static void guest_code(int vcpu_id)
 		 */
 		case KVM_CREATE_MAPPINGS:
 			for (i = 0; i < p->large_num_pages; i++) {
-				if (vcpu_args->vcpu_write)
+				if (do_write)
 					*(uint64_t *)addr = 0x0123456789ABCDEF;
 				else
 					READ_ONCE(*(uint64_t *)addr);
@@ -193,17 +184,15 @@ static void guest_code(int vcpu_id)
 
 static void *vcpu_worker(void *data)
 {
-	int ret;
-	struct vcpu_args *vcpu_args = data;
 	struct kvm_vm *vm = test_args.vm;
-	int vcpu_id = vcpu_args->vcpu_id;
-	struct kvm_run *run;
+	struct kvm_vcpu *vcpu = data;
+	bool do_write = !(vcpu->id % 2);
 	struct timespec start;
 	struct timespec ts_diff;
 	enum test_stage stage;
+	int ret;
 
-	vcpu_args_set(vm, vcpu_id, 1, vcpu_id);
-	run = vcpu_state(vm, vcpu_id);
+	vcpu_args_set(vm, vcpu->id, 1, do_write);
 
 	while (!READ_ONCE(host_quit)) {
 		ret = sem_wait(&test_stage_updated);
@@ -213,15 +202,15 @@ static void *vcpu_worker(void *data)
 			return NULL;
 
 		clock_gettime(CLOCK_MONOTONIC_RAW, &start);
-		ret = _vcpu_run(vm, vcpu_id);
+		ret = _vcpu_run(vm, vcpu->id);
 		ts_diff = timespec_elapsed(start);
 
 		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
-		TEST_ASSERT(get_ucall(vm, vcpu_id, NULL) == UCALL_SYNC,
+		TEST_ASSERT(get_ucall(vm, vcpu->id, NULL) == UCALL_SYNC,
 			    "Invalid guest sync status: exit_reason=%s\n",
-			    exit_reason_str(run->exit_reason));
+			    exit_reason_str(vcpu->run->exit_reason));
 
-		pr_debug("Got sync event from vCPU %d\n", vcpu_id);
+		pr_debug("Got sync event from vCPU %d\n", vcpu->id);
 		stage = READ_ONCE(*current_stage);
 
 		/*
@@ -230,7 +219,7 @@ static void *vcpu_worker(void *data)
 		 */
 		pr_debug("vCPU %d has completed stage %s\n"
 			 "execution time is: %ld.%.9lds\n\n",
-			 vcpu_id, test_stage_string[stage],
+			 vcpu->id, test_stage_string[stage],
 			 ts_diff.tv_sec, ts_diff.tv_nsec);
 
 		ret = sem_post(&test_stage_completed);
@@ -250,7 +239,6 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
 {
 	int ret;
 	struct test_params *p = arg;
-	struct vcpu_args *vcpu_args;
 	enum vm_mem_backing_src_type src_type = p->src_type;
 	uint64_t large_page_size = get_backing_src_pagesz(src_type);
 	uint64_t guest_page_size = vm_guest_mode_params[mode].page_size;
@@ -260,7 +248,6 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
 	uint64_t alignment;
 	void *host_test_mem;
 	struct kvm_vm *vm;
-	int vcpu_id;
 
 	/* Align up the test memory size */
 	alignment = max(large_page_size, guest_page_size);
@@ -269,7 +256,8 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
 	/* Create a VM with enough guest pages */
 	guest_num_pages = test_mem_size / guest_page_size;
 	vm = __vm_create_with_vcpus(mode, nr_vcpus, DEFAULT_GUEST_PHY_PAGES,
-				    guest_num_pages, 0, guest_code, NULL);
+				    guest_num_pages, 0, guest_code,
+				    test_args.vcpus);
 
 	/* Align down GPA of the testing memslot */
 	if (!p->phys_offset)
@@ -292,12 +280,6 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
 	test_args.host_pages_per_lpage = large_page_size / host_page_size;
 	test_args.src_type = src_type;
 
-	for (vcpu_id = 0; vcpu_id < KVM_MAX_VCPUS; vcpu_id++) {
-		vcpu_args = &test_args.vcpu_args[vcpu_id];
-		vcpu_args->vcpu_id = vcpu_id;
-		vcpu_args->vcpu_write = !(vcpu_id % 2);
-	}
-
 	/* Add an extra memory slot with specified backing src type */
 	vm_userspace_mem_region_add(vm, src_type, guest_test_phys_mem,
 				    TEST_MEM_SLOT_INDEX, guest_num_pages, 0);
@@ -363,12 +345,11 @@ static void vcpus_complete_new_stage(enum test_stage stage)
 
 static void run_test(enum vm_guest_mode mode, void *arg)
 {
-	int ret;
 	pthread_t *vcpu_threads;
 	struct kvm_vm *vm;
-	int vcpu_id;
 	struct timespec start;
 	struct timespec ts_diff;
+	int ret, i;
 
 	/* Create VM with vCPUs and make some pre-initialization */
 	vm = pre_init_before_test(mode, arg);
@@ -379,9 +360,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	host_quit = false;
 	*current_stage = KVM_BEFORE_MAPPINGS;
 
-	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
-		pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
-			       &test_args.vcpu_args[vcpu_id]);
+	for (i = 0; i < nr_vcpus; i++) {
+		pthread_create(&vcpu_threads[i], NULL, vcpu_worker,
+			       &test_args.vcpus[i]);
 	}
 
 	vcpus_complete_new_stage(*current_stage);
@@ -424,13 +405,13 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	/* Tell the vcpu thread to quit */
 	host_quit = true;
-	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
+	for (i = 0; i < nr_vcpus; i++) {
 		ret = sem_post(&test_stage_updated);
 		TEST_ASSERT(ret == 0, "Error in sem_post");
 	}
 
-	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++)
-		pthread_join(vcpu_threads[vcpu_id], NULL);
+	for (i = 0; i < nr_vcpus; i++)
+		pthread_join(vcpu_threads[i], NULL);
 
 	ret = sem_destroy(&test_stage_updated);
 	TEST_ASSERT(ret == 0, "Error in sem_destroy");
-- 
2.35.1.723.g4982287a31-goog

