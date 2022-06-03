Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFD153C249
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbiFCAuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240209AbiFCApG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:45:06 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BE5344E2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:45:03 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p2-20020a170902e74200b00164081f682cso3462451plf.16
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=jq9pNploHeAvg/UddQpk5d85u31dFgaOzcoTh6udOQU=;
        b=Jg8rN+GHlEdnNK/0B4sNaDz8y9OO/VPdf/6haRaU9bJ8Ix+FHWsK4h6GA0OtExBftp
         bDPhj/kMwXgpZIkYLewYK/F9vMmz/7V5FD0AHNsSnoGqJQjUUp6CQnEFakJDIjhz27hu
         mPvoiffi8YvdtsJwvoY8/MXFyQ8A5STQRzN2UvvnSJVvqSzL8on53SZevgLdSlRJDCqm
         P62MOKmkORk2o0EAiuoWaMMy27WqGhkXtt7jgNGaxxjdglJssvnJDL+j670BmJ3DOyGP
         Fd+nPdyjiNF/37Z/ODryDCnavICjKk/ZAyxcEQr6AVUbG6u4yZwpUHpB26jTvpJj+Rn1
         9TLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=jq9pNploHeAvg/UddQpk5d85u31dFgaOzcoTh6udOQU=;
        b=gsYXfCo5YycRtIY5wTFcPS4j98uRIAUfXayTJMOIJR6wJimYfPuIgQe6H2xqAw2qhV
         PECPBabOcQQdc+5gKnLE+95GnuyI5vawKqz3k5kc5di0uQC7srcS9bfhvfvP2LBjQk9N
         V4gm/EKMEFl4+hS+SXpTq/+F+VmCFo2iulzoM2TPKutn5aEgNxpMB6UsPBwfld+2Dh54
         pH+I2thR7vnDFHiq0IEzt+kyhjz21ItgVoCYj4akM3FbLRstaRNGgZziRCNA66OaP3lz
         3QbOpkT0u4boZNxQMHeI+yCbKmWMI8fKKZmo1/72Adortj6L8MbwVWYU8VKoeVn7Zcwm
         ff+w==
X-Gm-Message-State: AOAM531OW7SEt1JkBvpaiA+KH+gvTzMorzLl1RIyaAabJZkTRiQrkKIN
        w5oJJpl3R2hv1yW1+MJ8G5z1KAVXZXA=
X-Google-Smtp-Source: ABdhPJyf8LqwHHBzONfKrFXvNWn9YZjwgfmJigx5eK5Gk2aZzdJ75NiztHyNEAJJbYikE14m0ME6Eld6jRQ=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:2344:b0:163:ce0a:4655 with SMTP id
 c4-20020a170903234400b00163ce0a4655mr7646407plh.122.1654217102764; Thu, 02
 Jun 2022 17:45:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:41:54 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-48-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 047/144] KVM: selftests: Rename vcpu.state => vcpu.run
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the "state" field of 'struct vcpu' to "run".  KVM calls it "run",
the struct name is "kvm_run", etc...

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 24 +++++++------------
 .../selftests/kvm/lib/s390x/processor.c       |  2 +-
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 6418b1c04bc0..b83c3327d0e4 100644
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
index 76ac1c50c3e7..aca9ebffdc0e 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -514,7 +514,7 @@ static void vm_vcpu_rm(struct kvm_vm *vm, struct vcpu *vcpu)
 		vcpu->dirty_gfns = NULL;
 	}
 
-	ret = munmap(vcpu->state, vcpu_mmap_sz());
+	ret = munmap(vcpu->run, vcpu_mmap_sz());
 	TEST_ASSERT(!ret, __KVM_SYSCALL_ERROR("munmap()", ret));
 
 	ret = close(vcpu->fd);
@@ -1081,13 +1081,7 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
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
@@ -1098,12 +1092,12 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
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
-	TEST_ASSERT(vcpu->state != MAP_FAILED,
+	TEST_ASSERT(vcpu->run != MAP_FAILED,
 		    __KVM_SYSCALL_ERROR("mmap()", (int)(unsigned long)MAP_FAILED));
 
 	/* Add to linked-list of VCPUs. */
@@ -1460,7 +1454,7 @@ struct kvm_run *vcpu_state(struct kvm_vm *vm, uint32_t vcpuid)
 {
 	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
 
-	return vcpu->state;
+	return vcpu->run;
 }
 
 /*
@@ -1502,9 +1496,9 @@ void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid)
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
2.36.1.255.ge46751e96f-goog

