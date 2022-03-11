Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058484D5B47
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244836AbiCKGBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346750AbiCKFzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:05 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E318490260
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:31 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id r11-20020a63440b000000b0038068f34b0cso4256442pga.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=4cqRUT39er837P1PsE20nSgl01JijnWfe+nU7XJK38c=;
        b=tShz/GWTl4ypK3JmY1jyn63jX5pcTsMZ+dLuXRQ3oTtU6wjJWxQrIY88MjUVjnonCT
         NUYIwXCqyG1Fbpzv6GjWEYK2LQ8W805hq3hLuT90OThTFaVzInrYsEkOn1h+kEXkAUnk
         12T4pgd3UJjuruP8itmyiovxp9Uqw92slFiShBYJwwqKcs62/rra41LVGEOfAdJop4Ko
         P1ll1+ojzMb/CnhLQwpR9hXFx49SO6iTK8VIIKy2QLd9qfPo2RocixmlDEZgRJFtSjp/
         ptk/G5JDtbvGB5bwQctUOg8Ak3xDupQYs+nAy5pNOhafMI0IWqR/th33e5ZUvMdKW2sR
         65WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=4cqRUT39er837P1PsE20nSgl01JijnWfe+nU7XJK38c=;
        b=so3tRCTIwACI2oY9LTGwXAAL2RYlww7QtoFvnL1HR02bZ+TLlPeoQIsFayRi2z2i8h
         7+pXTITH9vOI07FRDqasGIHnVj4/4RDssKKMQRozpkztBHQ4VO/gm8HxgdFdyvXpRZsz
         gcB3XKLSYZo1WG5KcmMsvwgCsD6cT6Nm3LutxoGWrZyfoSy4ZjRidigxCglOhDySwCHo
         UqX1ywjePxHZkb8e5TxwCY9j1+JWeDOR2rp1Q7Y5KevaDEg25chTko1Yf5jkPT9MDyOf
         +Jh9NJdENtRgPfT1xcXYZEIaS9R09IG5pSiGoeLFW1lB+Il5o0RzKsDPql6BlJ3fUDBV
         hmew==
X-Gm-Message-State: AOAM533bSL0W17vmV9jXMoIzVheO69CRwpPNsoupGyjHSd1+ELj1boV4
        C4f4Z1rcv6j75Ug/f6R2PgMSb5ejmcrV9d24S3sAMntcqgE5RLr0MR7Uq/ONPczLGFWw+qAfxfM
        a24vUNC4/j5xEfb/LjVGx7corI2BeTnjoYW/xUydgdhJCDjYlTt6RWpF1Ni3blsZWB4cGVQ==
X-Google-Smtp-Source: ABdhPJzWUn6HxaW6lqim3t0X9zOtfeonq8fe40eFR76AFWm8v9kr+jm/dw5EtrGTEaHGhQPL4z/mdHJb9lI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:e5c2:b0:151:cc18:9ea9 with SMTP id
 u2-20020a170902e5c200b00151cc189ea9mr8469774plf.24.1646978011338; Thu, 10 Mar
 2022 21:53:31 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:37 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-87-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 086/105] KVM: selftests: Convert arch_timer away from VCPU_ID
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
 .../selftests/kvm/aarch64/arch_timer.c        | 62 ++++++++-----------
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 127fb4f0c335..de9b5ecea54e 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -76,13 +76,8 @@ struct test_vcpu_shared_data {
 	uint64_t xcnt;
 };
 
-struct test_vcpu {
-	uint32_t vcpuid;
-	pthread_t pt_vcpu_run;
-	struct kvm_vm *vm;
-};
-
-static struct test_vcpu test_vcpu[KVM_MAX_VCPUS];
+static struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
+static pthread_t pt_vcpu_run[KVM_MAX_VCPUS];
 static struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
 
 static int vtimer_irq, ptimer_irq;
@@ -217,20 +212,20 @@ static void guest_code(void)
 
 static void *test_vcpu_run(void *arg)
 {
+	unsigned int vcpu_idx = (unsigned long)arg;
 	struct ucall uc;
-	struct test_vcpu *vcpu = arg;
+	struct kvm_vcpu *vcpu = vcpus[vcpu_idx];
 	struct kvm_vm *vm = vcpu->vm;
-	uint32_t vcpuid = vcpu->vcpuid;
-	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[vcpuid];
+	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[vcpu_idx];
 
-	vcpu_run(vm, vcpuid);
+	vcpu_run(vm, vcpu->id);
 
 	/* Currently, any exit from guest is an indication of completion */
 	pthread_mutex_lock(&vcpu_done_map_lock);
-	set_bit(vcpuid, vcpu_done_map);
+	set_bit(vcpu_idx, vcpu_done_map);
 	pthread_mutex_unlock(&vcpu_done_map_lock);
 
-	switch (get_ucall(vm, vcpuid, &uc)) {
+	switch (get_ucall(vm, vcpu->id, &uc)) {
 	case UCALL_SYNC:
 	case UCALL_DONE:
 		break;
@@ -238,7 +233,7 @@ static void *test_vcpu_run(void *arg)
 		sync_global_from_guest(vm, *shared_data);
 		TEST_FAIL("%s at %s:%ld\n\tvalues: %lu, %lu; %lu, vcpu: %u; stage: %u; iter: %u",
 			(const char *)uc.args[0], __FILE__, uc.args[1],
-			uc.args[2], uc.args[3], uc.args[4], vcpuid,
+			uc.args[2], uc.args[3], uc.args[4], vcpu_idx,
 			shared_data->guest_stage, shared_data->nr_iter);
 		break;
 	default:
@@ -265,7 +260,7 @@ static uint32_t test_get_pcpu(void)
 	return pcpu;
 }
 
-static int test_migrate_vcpu(struct test_vcpu *vcpu)
+static int test_migrate_vcpu(unsigned int vcpu_idx)
 {
 	int ret;
 	cpu_set_t cpuset;
@@ -274,15 +269,15 @@ static int test_migrate_vcpu(struct test_vcpu *vcpu)
 	CPU_ZERO(&cpuset);
 	CPU_SET(new_pcpu, &cpuset);
 
-	pr_debug("Migrating vCPU: %u to pCPU: %u\n", vcpu->vcpuid, new_pcpu);
+	pr_debug("Migrating vCPU: %u to pCPU: %u\n", vcpu_idx, new_pcpu);
 
-	ret = pthread_setaffinity_np(vcpu->pt_vcpu_run,
-					sizeof(cpuset), &cpuset);
+	ret = pthread_setaffinity_np(pt_vcpu_run[vcpu_idx],
+				     sizeof(cpuset), &cpuset);
 
 	/* Allow the error where the vCPU thread is already finished */
 	TEST_ASSERT(ret == 0 || ret == ESRCH,
-			"Failed to migrate the vCPU:%u to pCPU: %u; ret: %d\n",
-			vcpu->vcpuid, new_pcpu, ret);
+		    "Failed to migrate the vCPU:%u to pCPU: %u; ret: %d\n",
+		    vcpu_idx, new_pcpu, ret);
 
 	return ret;
 }
@@ -305,7 +300,7 @@ static void *test_vcpu_migration(void *arg)
 				continue;
 			}
 
-			test_migrate_vcpu(&test_vcpu[i]);
+			test_migrate_vcpu(i);
 		}
 	} while (test_args.nr_vcpus != n_done);
 
@@ -314,16 +309,17 @@ static void *test_vcpu_migration(void *arg)
 
 static void test_run(struct kvm_vm *vm)
 {
-	int i, ret;
 	pthread_t pt_vcpu_migration;
+	unsigned int i;
+	int ret;
 
 	pthread_mutex_init(&vcpu_done_map_lock, NULL);
 	vcpu_done_map = bitmap_zalloc(test_args.nr_vcpus);
 	TEST_ASSERT(vcpu_done_map, "Failed to allocate vcpu done bitmap\n");
 
-	for (i = 0; i < test_args.nr_vcpus; i++) {
-		ret = pthread_create(&test_vcpu[i].pt_vcpu_run, NULL,
-				test_vcpu_run, &test_vcpu[i]);
+	for (i = 0; i < (unsigned long)test_args.nr_vcpus; i++) {
+		ret = pthread_create(&pt_vcpu_run[i], NULL, test_vcpu_run,
+				     (void *)(unsigned long)i);
 		TEST_ASSERT(!ret, "Failed to create vCPU-%d pthread\n", i);
 	}
 
@@ -338,7 +334,7 @@ static void test_run(struct kvm_vm *vm)
 
 
 	for (i = 0; i < test_args.nr_vcpus; i++)
-		pthread_join(test_vcpu[i].pt_vcpu_run, NULL);
+		pthread_join(pt_vcpu_run[i], NULL);
 
 	if (test_args.migration_freq_ms)
 		pthread_join(pt_vcpu_migration, NULL);
@@ -349,9 +345,9 @@ static void test_run(struct kvm_vm *vm)
 static void test_init_timer_irq(struct kvm_vm *vm)
 {
 	/* Timer initid should be same for all the vCPUs, so query only vCPU-0 */
-	vcpu_device_attr_get(vm, 0, KVM_ARM_VCPU_TIMER_CTRL,
+	vcpu_device_attr_get(vm, vcpus[0]->id, KVM_ARM_VCPU_TIMER_CTRL,
 			     KVM_ARM_VCPU_TIMER_IRQ_PTIMER, &ptimer_irq);
-	vcpu_device_attr_get(vm, 0, KVM_ARM_VCPU_TIMER_CTRL,
+	vcpu_device_attr_get(vm, vcpus[0]->id, KVM_ARM_VCPU_TIMER_CTRL,
 			     KVM_ARM_VCPU_TIMER_IRQ_VTIMER, &vtimer_irq);
 
 	sync_global_to_guest(vm, ptimer_irq);
@@ -366,17 +362,13 @@ static struct kvm_vm *test_vm_create(void)
 	unsigned int i;
 	int nr_vcpus = test_args.nr_vcpus;
 
-	vm = vm_create_default_with_vcpus(nr_vcpus, 0, 0, guest_code, NULL);
+	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
 
 	vm_init_descriptor_tables(vm);
 	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT, guest_irq_handler);
 
-	for (i = 0; i < nr_vcpus; i++) {
-		vcpu_init_descriptor_tables(vm, i);
-
-		test_vcpu[i].vcpuid = i;
-		test_vcpu[i].vm = vm;
-	}
+	for (i = 0; i < nr_vcpus; i++)
+		vcpu_init_descriptor_tables(vm, vcpus[i]->id);
 
 	ucall_init(vm, NULL);
 	test_init_timer_irq(vm);
-- 
2.35.1.723.g4982287a31-goog

