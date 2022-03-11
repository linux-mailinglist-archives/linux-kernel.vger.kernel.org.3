Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC614D5B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346704AbiCKGAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346688AbiCKFzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:08 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4136FFF9C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:41 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id y3-20020a1709029b8300b0014c8bcb70a1so4019570plp.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=3kN0MYjfZR0BF6JbBsye3XJksluYj8f6Xh8iEcuCoNk=;
        b=Al1dQ7JRLtGWo/GJ2RefXVayagFQinXXM6EvQUf/l3Sahfl1bT4v6P/Pxr0mtssCKK
         6WyaL8H24o0nqZQEVAr1KC8YdSXT3JXLO5PwHs8jT7M+oJrRSKKsblCDeRd/ZjlTO6tJ
         h/lT2Syp/xbV4f+SgxZSRCE+kERoPQ+IBA/rCD/Au9P3G2hhvCBFv7bZBZm+16Wu4PMe
         4h4X42/2LkSc/0/ldSaxikunEb8hfdSM+8cmk4T0KOtVp7Hfy5xqmY0PDpYPNn/kZxI/
         5dSjJCKCcl4Y4gYUHYnn2TNgPhA+TCTMbdrLnx0zMw1j6s8SDYOZIqxRsP9ECI+Mgg6B
         8H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=3kN0MYjfZR0BF6JbBsye3XJksluYj8f6Xh8iEcuCoNk=;
        b=jYA3As/SGavdM045VHWmVhl2IPwA9gZ+2uQvN1tUmH1/8IKdXbo6NtQcVdjZWrNk3y
         gNkwsgEnRVcrXK1/UsY1XykLrkS2ggx4IY63Ea3ejgllGGLpI66Ou2YVv4MWCg63Bgnq
         NsWVj/R8OUbbK9SSUZITKmC+U8OWRH4k9zEyXAClE3rWcCPcWeLefuG2Kwibn6FB9RQq
         pLVx+b8HFtn0DmToqqwy25A4Ag8jPlCXanPLCY8CF4CjrIwno8ibwtKHaBnsvtvYO+Tn
         JMcwSmtWlsuANozg7IHXdV5EaG5LPJE1D5yjvPjC1gS6QSwMT1hmK3ZWiROebU7yAQFg
         g2ww==
X-Gm-Message-State: AOAM530Uf9CdQz3TOR6ICA/TMHlE26dytBn9Mmykk6YwpxOaO1zsALKu
        XKL2CsEGFtCEe8FsqKLXyS5I8C7qmt/ifka9wS3U1jLwwk/MHxFYqFdFJEcdKBcfF6qLqufmdcq
        nzK7K5WfQTao+6lziTEavhrNJ+Az1F3Zmqc+Ha3/G44FzbWQG+5Ex8tcgyRy9gEpM/n8G7g==
X-Google-Smtp-Source: ABdhPJxRcyBVNMtn377xng1PjvGXjhHyMQLleIdIKIJ9OG5at0dMqPIfAvhWDyUELyH9qerIRwgztYvAmYI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:7bc4:0:b0:4f6:aaa1:91f8 with SMTP id
 w187-20020a627bc4000000b004f6aaa191f8mr8704511pfc.48.1646978021357; Thu, 10
 Mar 2022 21:53:41 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:43 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-93-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 092/105] KVM: selftests: Convert memop away from VCPU_ID
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
 tools/testing/selftests/kvm/s390x/memop.c | 31 +++++++++++------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 460799cc2098..a09b1b654d7f 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -13,8 +13,6 @@
 #include "test_util.h"
 #include "kvm_util.h"
 
-#define VCPU_ID 1
-
 static uint8_t mem1[65536];
 static uint8_t mem2[65536];
 
@@ -31,6 +29,7 @@ static void guest_code(void)
 
 int main(int argc, char *argv[])
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
 	struct kvm_s390_mem_op ksmo;
@@ -47,8 +46,8 @@ int main(int argc, char *argv[])
 		maxsize = sizeof(mem1);
 
 	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
-	run = vcpu_state(vm, VCPU_ID);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	run = vcpu->run;
 
 	for (i = 0; i < sizeof(mem1); i++)
 		mem1[i] = i * i + i;
@@ -60,10 +59,10 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	vcpu_ioctl(vm, vcpu->id, KVM_S390_MEM_OP, &ksmo);
 
 	/* Let the guest code copy the first array to the second */
-	vcpu_run(vm, VCPU_ID);
+	vcpu_run(vm, vcpu->id);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
 		    "Unexpected exit reason: %u (%s)\n",
 		    run->exit_reason,
@@ -78,7 +77,7 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_READ;
 	ksmo.buf = (uintptr_t)mem2;
 	ksmo.ar = 0;
-	vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	vcpu_ioctl(vm, vcpu->id, KVM_S390_MEM_OP, &ksmo);
 
 	TEST_ASSERT(!memcmp(mem1, mem2, maxsize),
 		    "Memory contents do not match!");
@@ -90,7 +89,7 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	rv = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = __vcpu_ioctl(vm, vcpu->id, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == E2BIG, "ioctl allows insane sizes");
 
 	/* Zero size: */
@@ -100,7 +99,7 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	rv = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = __vcpu_ioctl(vm, vcpu->id, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && (errno == EINVAL || errno == ENOMEM),
 		    "ioctl allows 0 as size");
 
@@ -111,7 +110,7 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	rv = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = __vcpu_ioctl(vm, vcpu->id, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows all flags");
 
 	/* Bad operation: */
@@ -121,7 +120,7 @@ int main(int argc, char *argv[])
 	ksmo.op = -1;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	rv = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = __vcpu_ioctl(vm, vcpu->id, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows bad operations");
 
 	/* Bad guest address: */
@@ -131,7 +130,7 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 0;
-	rv = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = __vcpu_ioctl(vm, vcpu->id, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory access");
 
 	/* Bad host address: */
@@ -141,24 +140,24 @@ int main(int argc, char *argv[])
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = 0;
 	ksmo.ar = 0;
-	rv = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = __vcpu_ioctl(vm, vcpu->id, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == EFAULT,
 		    "ioctl does not report bad host memory address");
 
 	/* Bad access register: */
 	run->psw_mask &= ~(3UL << (63 - 17));
 	run->psw_mask |= 1UL << (63 - 17);  /* Enable AR mode */
-	vcpu_run(vm, VCPU_ID);              /* To sync new state to SIE block */
+	vcpu_run(vm, vcpu->id);              /* To sync new state to SIE block */
 	ksmo.gaddr = (uintptr_t)mem1;
 	ksmo.flags = 0;
 	ksmo.size = maxsize;
 	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
 	ksmo.buf = (uintptr_t)mem1;
 	ksmo.ar = 17;
-	rv = __vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	rv = __vcpu_ioctl(vm, vcpu->id, KVM_S390_MEM_OP, &ksmo);
 	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows ARs > 15");
 	run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
-	vcpu_run(vm, VCPU_ID);                  /* Run to sync new state */
+	vcpu_run(vm, vcpu->id);                  /* Run to sync new state */
 
 	kvm_vm_free(vm);
 
-- 
2.35.1.723.g4982287a31-goog

