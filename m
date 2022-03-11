Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75104D5B15
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347741AbiCKF7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346706AbiCKFyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:09 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD82492D30
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:06 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id j1-20020a170903028100b0014b1f9e0068so4005844plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=19AYdxlQF5CgqwXk1D5hC7bENj8MzASyLlm16VdNZxc=;
        b=MJdNmvvECtXKdZmpMuTVaChct4A9DCWUBsEBDSbW6HJWChoSJYaP1RwXnsTN+WmjAi
         nxbEWp/Wk+RGcsmEHMu1p+bLO5gt+fKlbE5bXz02xmV67N41FGuk/c72RbdKkzICcZ98
         gbsSTxRtk3hgQcCjHPLCW9cknOzecrUNKrxxsWTuHdIYvyWCfxX9XFNs4xnPF/8eypCh
         3El6mU38u/2jseK5bfsTW//bFXwjpN2sEdCXH8DV5D29OYMq3MRJSWuQvrpctLjVL7da
         CJGAzfsgAWC6qXoHVV5TnxVwZxYnXPghNSQJJ+hlXzDQXlwKijnVFhGdQMzovXcJHz2z
         yqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=19AYdxlQF5CgqwXk1D5hC7bENj8MzASyLlm16VdNZxc=;
        b=aXH3LWVBgeISL7/zUIJKRJlqdLJrGJhzqLc2WAdWuaXqpCVu7iJWQtuWLq8bJTUlUR
         iyHCIQj70tppX/VNm44UD6Qhtm0HSUab2kubkgopHgc/dlA5G6jLtaC6fLd23vwobyth
         +wuCdWXSDHbRxUSuFk6jR7cmoMjPHGjNTYcBn6UVOUHk4lqD0lnl3PqIlKdywiWcjBJt
         twkbkNahC50bnBaeX8fCN6FA6+tnIwyFjTRXJ1uesAZ6gIWGzkdR6MbZjg1qAOwi64Gq
         P9j56f6tEqRFnOnmGYrb2gIB19VBMpkQT99C4XrgWo4RtG4vlzc2X801jd045C51BRyp
         BsnA==
X-Gm-Message-State: AOAM530vG4bPhuZQDWe3QbN7eRfLb5d/FoTMrSz1XwxGcelACfKwXVA/
        a/4osylX+Dh1exbT3JGsu+SCZhvlL0y5g+CqclLpLO+NxCUZYnqfQaHmBvIpgmUtCD6uEbS35OL
        2C3CztlbueyfDr04PHt6HK2wI/27YzecKOjZq6R5kq6AHIomAQvWO2hEEuoO9BAiTZ9g6QQ==
X-Google-Smtp-Source: ABdhPJxT5A7kKgjNE0dIXSGTFFaWvyRTcCsyYiFb9iBCuQcuOZ5/G6eJrTlGomKiFeVopyMnXY7d6+Xn5oY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e10:b0:1bf:6c78:54a9 with SMTP id
 pg16-20020a17090b1e1000b001bf6c7854a9mr460989pjb.1.1646977986046; Thu, 10 Mar
 2022 21:53:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:22 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-72-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 071/105] KVM: selftests: Convert dirty_log_test away from VCPU_ID
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
 tools/testing/selftests/kvm/dirty_log_test.c | 59 ++++++++++----------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 5752486764c9..1c7d25bf4a5a 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -23,8 +23,6 @@
 #include "guest_modes.h"
 #include "processor.h"
 
-#define VCPU_ID				1
-
 /* The memory slot index to track dirty pages */
 #define TEST_MEM_SLOT_INDEX		1
 
@@ -229,17 +227,17 @@ static void clear_log_create_vm_done(struct kvm_vm *vm)
 	vm_enable_cap(vm, &cap);
 }
 
-static void dirty_log_collect_dirty_pages(struct kvm_vm *vm, int slot,
+static void dirty_log_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 					  void *bitmap, uint32_t num_pages)
 {
-	kvm_vm_get_dirty_log(vm, slot, bitmap);
+	kvm_vm_get_dirty_log(vcpu->vm, slot, bitmap);
 }
 
-static void clear_log_collect_dirty_pages(struct kvm_vm *vm, int slot,
+static void clear_log_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 					  void *bitmap, uint32_t num_pages)
 {
-	kvm_vm_get_dirty_log(vm, slot, bitmap);
-	kvm_vm_clear_dirty_log(vm, slot, bitmap, 0, num_pages);
+	kvm_vm_get_dirty_log(vcpu->vm, slot, bitmap);
+	kvm_vm_clear_dirty_log(vcpu->vm, slot, bitmap, 0, num_pages);
 }
 
 /* Should only be called after a GUEST_SYNC */
@@ -253,14 +251,14 @@ static void vcpu_handle_sync_stop(void)
 	}
 }
 
-static void default_after_vcpu_run(struct kvm_vm *vm, int ret, int err)
+static void default_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
 {
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	struct kvm_run *run = vcpu->run;
 
 	TEST_ASSERT(ret == 0 || (ret == -1 && err == EINTR),
 		    "vcpu run failed: errno=%d", err);
 
-	TEST_ASSERT(get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC,
+	TEST_ASSERT(get_ucall(vcpu->vm, vcpu->id, NULL) == UCALL_SYNC,
 		    "Invalid guest sync status: exit_reason=%s\n",
 		    exit_reason_str(run->exit_reason));
 
@@ -331,7 +329,7 @@ static void dirty_ring_continue_vcpu(void)
 	sem_post(&sem_vcpu_cont);
 }
 
-static void dirty_ring_collect_dirty_pages(struct kvm_vm *vm, int slot,
+static void dirty_ring_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 					   void *bitmap, uint32_t num_pages)
 {
 	/* We only have one vcpu */
@@ -351,10 +349,10 @@ static void dirty_ring_collect_dirty_pages(struct kvm_vm *vm, int slot,
 	}
 
 	/* Only have one vcpu */
-	count = dirty_ring_collect_one(vcpu_map_dirty_ring(vm, VCPU_ID),
+	count = dirty_ring_collect_one(vcpu_map_dirty_ring(vcpu->vm, vcpu->id),
 				       slot, bitmap, num_pages, &fetch_index);
 
-	cleared = kvm_vm_reset_dirty_ring(vm);
+	cleared = kvm_vm_reset_dirty_ring(vcpu->vm);
 
 	/* Cleared pages should be the same as collected */
 	TEST_ASSERT(cleared == count, "Reset dirty pages (%u) mismatch "
@@ -369,12 +367,12 @@ static void dirty_ring_collect_dirty_pages(struct kvm_vm *vm, int slot,
 	pr_info("Iteration %ld collected %u pages\n", iteration, count);
 }
 
-static void dirty_ring_after_vcpu_run(struct kvm_vm *vm, int ret, int err)
+static void dirty_ring_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
 {
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	struct kvm_run *run = vcpu->run;
 
 	/* A ucall-sync or ring-full event is allowed */
-	if (get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC) {
+	if (get_ucall(vcpu->vm, vcpu->id, NULL) == UCALL_SYNC) {
 		/* We should allow this to continue */
 		;
 	} else if (run->exit_reason == KVM_EXIT_DIRTY_RING_FULL ||
@@ -408,10 +406,10 @@ struct log_mode {
 	/* Hook when the vm creation is done (before vcpu creation) */
 	void (*create_vm_done)(struct kvm_vm *vm);
 	/* Hook to collect the dirty pages into the bitmap provided */
-	void (*collect_dirty_pages) (struct kvm_vm *vm, int slot,
+	void (*collect_dirty_pages) (struct kvm_vcpu *vcpu, int slot,
 				     void *bitmap, uint32_t num_pages);
 	/* Hook to call when after each vcpu run */
-	void (*after_vcpu_run)(struct kvm_vm *vm, int ret, int err);
+	void (*after_vcpu_run)(struct kvm_vcpu *vcpu, int ret, int err);
 	void (*before_vcpu_join) (void);
 } log_modes[LOG_MODE_NUM] = {
 	{
@@ -473,22 +471,22 @@ static void log_mode_create_vm_done(struct kvm_vm *vm)
 		mode->create_vm_done(vm);
 }
 
-static void log_mode_collect_dirty_pages(struct kvm_vm *vm, int slot,
+static void log_mode_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 					 void *bitmap, uint32_t num_pages)
 {
 	struct log_mode *mode = &log_modes[host_log_mode];
 
 	TEST_ASSERT(mode->collect_dirty_pages != NULL,
 		    "collect_dirty_pages() is required for any log mode!");
-	mode->collect_dirty_pages(vm, slot, bitmap, num_pages);
+	mode->collect_dirty_pages(vcpu, slot, bitmap, num_pages);
 }
 
-static void log_mode_after_vcpu_run(struct kvm_vm *vm, int ret, int err)
+static void log_mode_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
 {
 	struct log_mode *mode = &log_modes[host_log_mode];
 
 	if (mode->after_vcpu_run)
-		mode->after_vcpu_run(vm, ret, err);
+		mode->after_vcpu_run(vcpu, ret, err);
 }
 
 static void log_mode_before_vcpu_join(void)
@@ -510,7 +508,8 @@ static void generate_random_array(uint64_t *guest_array, uint64_t size)
 static void *vcpu_worker(void *data)
 {
 	int ret;
-	struct kvm_vm *vm = data;
+	struct kvm_vcpu *vcpu = data;
+	struct kvm_vm *vm = vcpu->vm;
 	uint64_t *guest_array;
 	uint64_t pages_count = 0;
 	struct kvm_signal_mask *sigmask = alloca(offsetof(struct kvm_signal_mask, sigset)
@@ -525,7 +524,7 @@ static void *vcpu_worker(void *data)
 	sigmask->len = 8;
 	pthread_sigmask(0, NULL, sigset);
 	sigdelset(sigset, SIG_IPI);
-	vcpu_ioctl(vm, VCPU_ID, KVM_SET_SIGNAL_MASK, sigmask);
+	vcpu_ioctl(vm, vcpu->id, KVM_SET_SIGNAL_MASK, sigmask);
 
 	sigemptyset(sigset);
 	sigaddset(sigset, SIG_IPI);
@@ -537,13 +536,13 @@ static void *vcpu_worker(void *data)
 		generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
 		pages_count += TEST_PAGES_PER_LOOP;
 		/* Let the guest dirty the random pages */
-		ret = __vcpu_run(vm, VCPU_ID);
+		ret = __vcpu_run(vm, vcpu->id);
 		if (ret == -1 && errno == EINTR) {
 			int sig = -1;
 			sigwait(sigset, &sig);
 			assert(sig == SIG_IPI);
 		}
-		log_mode_after_vcpu_run(vm, ret, errno);
+		log_mode_after_vcpu_run(vcpu, ret, errno);
 	}
 
 	pr_info("Dirtied %"PRIu64" pages\n", pages_count);
@@ -699,6 +698,7 @@ struct test_params {
 static void run_test(enum vm_guest_mode mode, void *arg)
 {
 	struct test_params *p = arg;
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	unsigned long *bmap;
 
@@ -716,9 +716,10 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	 * (e.g., 64K page size guest will need even less memory for
 	 * page tables).
 	 */
-	vm = create_vm(mode, VCPU_ID,
+	vm = create_vm(mode, 0,
 		       2ul << (DIRTY_MEM_BITS - PAGE_SHIFT_4K),
 		       guest_code);
+	vcpu = vcpu_get(vm, 0);
 
 	guest_page_size = vm_get_page_size(vm);
 	/*
@@ -779,12 +780,12 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	host_clear_count = 0;
 	host_track_next_count = 0;
 
-	pthread_create(&vcpu_thread, NULL, vcpu_worker, vm);
+	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
 
 	while (iteration < p->iterations) {
 		/* Give the vcpu thread some time to dirty some pages */
 		usleep(p->interval * 1000);
-		log_mode_collect_dirty_pages(vm, TEST_MEM_SLOT_INDEX,
+		log_mode_collect_dirty_pages(vcpu, TEST_MEM_SLOT_INDEX,
 					     bmap, host_num_pages);
 
 		/*
-- 
2.35.1.723.g4982287a31-goog

