Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3841E51B345
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348083AbiEDXAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379577AbiEDWzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:55:36 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AAE54BE2
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:51:29 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h9-20020a631209000000b0039cc31b22aeso1346089pgl.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=v4jxCMZ0K6gzSQh9bGw6pr0cWCX+xzECczrOEjrAb+o=;
        b=QlLiKRByOEV+/iSjQQTHPQcznnnwxPBDsE7LVVNLZGKV65Atw0rSJMpWwmtMYNCCu4
         7/nOSPQ9v6MdIFKK3yU3sd58VZSeJy7uNMsz9i2koSRQrgNLeaDlyQANiC5UnM1az0wn
         3S1qP9raDCg+y7xad3W+bpdni5WGKio7i7VEoobpkEyfnww/GVAMsGb9SdT/4LB2kmmX
         K8AvhUXnS0Q+Ydss03TJx6eCLnY331gxuaQzleJXoVEKNjrH1dt8Bc+G7Eomn1GWOw86
         ZKrJZ95/LkC1PyoUniKqvB57Xog/ECoM/e2vJBHDCCsyHnLCHQTHZrmQCq8FsoS2WKtx
         dBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=v4jxCMZ0K6gzSQh9bGw6pr0cWCX+xzECczrOEjrAb+o=;
        b=Xx2NLIqBy5OlTbL90ynNS+3/DkhIoAjc4R/EfGp8FHwh5MWRE2E6J8GFkhlDSVa+bs
         97U7ZTP+2Q0URc9UTkD7MAZXO5eDUvd+EXAB6cnkFafujnUVm+p2N8sBpKWMN52lMLRj
         xrHe8XhBjo4oo7YBm3RM+oD/M6VR9WFLV3ZNE0ILxt5qTK0/28bUmISL3tS80cPFz5Cj
         raBjR/hToTg6ySN9sL0R4lzN546fnSqBHpdfpkIT81o/Dju3r5/8JuTsWzF9VGqWVkT4
         ta6uEjwYJlWOa7ISUH5Hr6rX3dXZyVFc1c4LdzBavw+wP0DjimrJ4ToM7KRr11ZXY7iA
         nDXg==
X-Gm-Message-State: AOAM533TRO/P+2WYEh0tEswp3IoGD1gI8lxN/t6ysmagoLJ7mfE5UFNh
        6MWpzMp5OkK1hWsErlDoShEaplhmr2o=
X-Google-Smtp-Source: ABdhPJzLVK+oMUWihBqCsnyFjWZDSgs7VDqx9YXrqhkn2dKNnpHQeycbe7lJzkU6QBFIITJ1BUNJux2kg4Y=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:ed0e:0:b0:4fa:11ed:2ad1 with SMTP id
 u14-20020a62ed0e000000b004fa11ed2ad1mr22813058pfh.34.1651704688940; Wed, 04
 May 2022 15:51:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:48:14 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-69-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 068/128] KVM: selftests: Convert hyperv_svm_test away from VCPU_ID
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert hyperv_svm_test to use vm_create_with_one_vcpu() and pass around a
'struct kvm_vcpu' object instead of using a global VCPU_ID.  Note, this is
a "functional" change in the sense that the test now creates a vCPU with
vcpu_id==0 instead of vcpu_id==1.  The non-zero VCPU_ID was 100% arbitrary
and added little to no validation coverage.  If testing non-zero vCPU IDs
is desirable for generic tests, that can be done in the future by tweaking
the VM creation helpers.

Opportunistically use vcpu_run() instead of _vcpu_run(), the test expects
KVM_RUN to succeed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/x86_64/hyperv_svm_test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
index 21f5ca9197da..46f1070e7297 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
@@ -21,7 +21,6 @@
 #include "svm_util.h"
 #include "hyperv.h"
 
-#define VCPU_ID		1
 #define L2_GUEST_STACK_SIZE 256
 
 struct hv_enlightenments {
@@ -127,6 +126,7 @@ int main(int argc, char *argv[])
 {
 	vm_vaddr_t nested_gva = 0;
 
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
 	struct ucall uc;
@@ -137,20 +137,20 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 	}
 	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
-	vcpu_set_hv_cpuid(vm, VCPU_ID);
-	run = vcpu_state(vm, VCPU_ID);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vcpu_set_hv_cpuid(vm, vcpu->id);
+	run = vcpu->run;
 	vcpu_alloc_svm(vm, &nested_gva);
-	vcpu_args_set(vm, VCPU_ID, 1, nested_gva);
+	vcpu_args_set(vm, vcpu->id, 1, nested_gva);
 
 	for (stage = 1;; stage++) {
-		_vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Stage %d: unexpected exit reason: %u (%s),\n",
 			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
 				  __FILE__, uc.args[1]);
-- 
2.36.0.464.gb9c8b46e94-goog

