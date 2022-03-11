Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A824D5AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346741AbiCKFzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346635AbiCKFw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:57 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508D2F70DE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:53 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id j5-20020a63e745000000b00378c359fac3so4232964pgk.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=/fD5fP1bBRjGYsCEvIQqE65KVxkB7d1EdaEIshLLAnc=;
        b=hALZtKu88Pa5lD/VM36J8Q/f8WjAp9G7Xh27mORL4MlD0nYNPEriHZyU/mQxbpZ0F7
         FUvjcQHjUmwTcnUjmn0ysCJpP3N4UZwIST5LsZZFerF+6I8OPyxoVpwDYi3Bi6PmrW2s
         +h1vGzz8nuqsuO3GisBMw+nDR/Qan2undr7XR8LRoAiJ3GcnddITFzVyjxOb5Emqch+c
         18hdSeP99b/9Z2WM3RoFSZTDjEoQxZJZ11G+VzUtVCXp6iKxkUHS6h7fnMDjWSxKdQXI
         2GyY8Isn5Tl2GMnlEL4nqQyijDbdYhfEjD+fOG+dkmBZKv5718Bu62X5c4rlUWCWwjXE
         lQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=/fD5fP1bBRjGYsCEvIQqE65KVxkB7d1EdaEIshLLAnc=;
        b=JdIllKLug6R+VqqdEnjf5iMtFnhfboqUetPRPc/XajYoNO6D540Q702Nr0OZr/jdT2
         4QI2TrZvtv/jKeHDDdJvk9pKNw6eg9kBJ1XbiaVYNzEVMrLzPUXXrGN66vZQfxpLBBft
         WEbbeojVpvEVi1CmTKGJoeQ7Y+RmHw/rKFav8MUUWth8pMyg71E9ZLZ95Fc+JVh/oOTf
         m1fmghJpmeJ9Xn4a4BR2V0+8814x2sVNzL+lW9qf+8JV5U6+oXg85EsP6CVGMjVmhAUH
         l0o3IXjMuvpmRqwMun5E78+uz++y3JxT6pFpxSgLe7pPnvG3PrwXHjuaYiVYOiB662sR
         u5+g==
X-Gm-Message-State: AOAM531r9o1xt6SGT9WakxzDPpVPXaz4wz5enbUwvhcvS15SSKfMzRTm
        Cxzsj6hcqo39qm2hT3P1IEicv8XVlnj967RqYJ1ifYi8oL8Shs21+i6jHgjKUgd2QY2T8vkwfS5
        nUq7Kfp6F+Pnsx1K5NLUCcHdh3q/Mc6knh939eQp5IAmotACA2oXitb4D0ZRdeCWfvKDIjw==
X-Google-Smtp-Source: ABdhPJx8xGlqyA9WArTMplO5X+kLZRO3ZhPxt9MhjnRwUECw+j9LdT0Umqp/EtJkoi9PXr+U8YKQ29saZP0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1907:b0:4f7:945:14cf with SMTP id
 y7-20020a056a00190700b004f7094514cfmr3364844pfi.47.1646977913250; Thu, 10 Mar
 2022 21:51:53 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:39 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-29-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 028/105] KVM: selftests: Rename vcpu.state => vcpu.run
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
 .../selftests/kvm/include/kvm_util_base.h     |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 24 +++++++------------
 .../selftests/kvm/lib/s390x/processor.c       |  2 +-
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index e87988665607..a71b532f07b2 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -48,7 +48,7 @@ struct vcpu {
 	uint32_t id;
 	int fd;
 	struct kvm_vm *vm;
-	struct kvm_run *state;
+	struct kvm_run *run;
 	struct kvm_dirty_gfn *dirty_gfns;
 	uint32_t fetch_index;
 	uint32_t dirty_gfns_count;
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 0c088454e600..d164b3962bb7 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -531,7 +531,7 @@ static void vm_vcpu_rm(struct kvm_vm *vm, struct vcpu *vcpu)
 		vcpu->dirty_gfns = NULL;
 	}
 
-	ret = munmap(vcpu->state, vcpu_mmap_sz());
+	ret = munmap(vcpu->run, vcpu_mmap_sz());
 	TEST_ASSERT(ret == 0, "munmap of VCPU fd failed, rc: %i "
 		"errno: %i", ret, errno);
 	ret = close(vcpu->fd);
@@ -1076,13 +1076,7 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
 	struct vcpu *vcpu;
 
 	/* Confirm a vcpu with the specified id doesn't already exist. */
-	vcpu = vcpu_find(vm, vcpuid);
-	if (vcpu != NULL)
-		TEST_FAIL("vcpu with the specified id "
-			"already exists,\n"
-			"  requested vcpuid: %u\n"
-			"  existing vcpuid: %u state: %p",
-			vcpuid, vcpu->id, vcpu->state);
+	TEST_ASSERT(!vcpu_find(vm, vcpuid), "vCPU%d already exists\n", vcpuid);
 
 	/* Allocate and initialize new vcpu structure. */
 	vcpu = calloc(1, sizeof(*vcpu));
@@ -1093,12 +1087,12 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
 	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpuid);
 	TEST_ASSERT(vcpu->fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VCPU, vcpu->fd));
 
-	TEST_ASSERT(vcpu_mmap_sz() >= sizeof(*vcpu->state), "vcpu mmap size "
+	TEST_ASSERT(vcpu_mmap_sz() >= sizeof(*vcpu->run), "vcpu mmap size "
 		"smaller than expected, vcpu_mmap_sz: %i expected_min: %zi",
-		vcpu_mmap_sz(), sizeof(*vcpu->state));
-	vcpu->state = (struct kvm_run *) mmap(NULL, vcpu_mmap_sz(),
+		vcpu_mmap_sz(), sizeof(*vcpu->run));
+	vcpu->run = (struct kvm_run *) mmap(NULL, vcpu_mmap_sz(),
 		PROT_READ | PROT_WRITE, MAP_SHARED, vcpu->fd, 0);
-	TEST_ASSERT(vcpu->state != MAP_FAILED, "mmap vcpu_state failed, "
+	TEST_ASSERT(vcpu->run != MAP_FAILED, "mmap vcpu_state failed, "
 		"vcpu id: %u errno: %i", vcpuid, errno);
 
 	/* Add to linked-list of VCPUs. */
@@ -1456,7 +1450,7 @@ struct kvm_run *vcpu_state(struct kvm_vm *vm, uint32_t vcpuid)
 {
 	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
 
-	return vcpu->state;
+	return vcpu->run;
 }
 
 /*
@@ -1498,9 +1492,9 @@ void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid)
 	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
 	int ret;
 
-	vcpu->state->immediate_exit = 1;
+	vcpu->run->immediate_exit = 1;
 	ret = __vcpu_run(vm, vcpuid);
-	vcpu->state->immediate_exit = 0;
+	vcpu->run->immediate_exit = 0;
 
 	TEST_ASSERT(ret == -1 && errno == EINTR,
 		    "KVM_RUN IOCTL didn't exit immediately, rc: %i, errno: %i",
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index 53c413932f64..df9d9650d916 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -210,7 +210,7 @@ void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
 	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
 
 	fprintf(stream, "%*spstate: psw: 0x%.16llx:0x%.16llx\n",
-		indent, "", vcpu->state->psw_mask, vcpu->state->psw_addr);
+		indent, "", vcpu->run->psw_mask, vcpu->run->psw_addr);
 }
 
 void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid)
-- 
2.35.1.723.g4982287a31-goog

