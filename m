Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9536353C21D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbiFCA5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbiFCAqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:46:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D929537A12
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:45:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i17-20020a259d11000000b0064cd3084085so5600569ybp.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=dtKn/1s6u0G58r1neb2YaJY76UbcP9qLfe4/PWDPKHo=;
        b=QFictB3WUVf3oY4ZmSCgbstv+sdSwlhQ5B7U1hGi/9zuadjzT1Xx5n94oX/koHEYlZ
         whqOnKEMmeHpb4hcvnVhgWQOusinfN3KSiYJDrhaJbEOQ9wSIZC/6KjuB0I/699VoHB5
         KK1MOWomPfMYVg1R2GpYOvsjiJ9IVSBvFQU6qNPm+LmQMxtTXonntAVFirhDscxJfrtf
         gOf0BK2IebQJWInCgl+LoJaDHrlOK8bprkJIbE5jrI8bpsODzivg9QKgRbSIU/Ukx1N9
         nJy0fnWfTs4modFsPpor1iW9aqdvO8LQOfb9Dy+HLuegZy3UImsKZLHjPlLSSrYoLKYL
         at4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=dtKn/1s6u0G58r1neb2YaJY76UbcP9qLfe4/PWDPKHo=;
        b=wEV4C8RFz465/RFsSe2i9yoeO5prtnt9ldEetqpwtRc297YDBM+7+4bB2hONHFt0Gg
         SUJ0cCyf1+SXluWstt/n2rnv+NiIJ5n1ro47bBCgiuvA8zYkuyk+c5ZyAlx2CF4ZPOmU
         lGcwJ27gPsDB2gokZi49N7ZN7OYvnQEUsUi7yeUMr4TBv7KsFAvDd6dhMSA1jXzIFWPi
         +725bhA29I54t+KDjXvEAidvlUqVGC00MVK8qvXYWPlj7XCholJ3i44aidmOeZmZmu+B
         OYuqVTtMk/8/FCjlLwy3ul4nmEdXdF/H5d154b8oVV6EUVdqACyMB3GBCia0n+YcFZ1F
         oMDw==
X-Gm-Message-State: AOAM532MTdH43g368YoUmtxLQGERnr6gAMQbFoUtjnOX1qQYLjAIZeBO
        YWKzrll+wfGiaVwoFL80+Ow0ZAtPor8=
X-Google-Smtp-Source: ABdhPJxHTnxlNfUb+1pMM1jvfC18BkySL94v0dyAd23wbuLKDoSwUam9Q8WUem1lRxG9QhNBAZv+X37cFUs=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:5f50:0:b0:65c:bf1d:25fa with SMTP id
 h16-20020a255f50000000b0065cbf1d25famr8919268ybm.60.1654217155121; Thu, 02
 Jun 2022 17:45:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:42:23 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-77-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 076/144] KVM: selftests: Convert hyperv_svm_test away from VCPU_ID
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
index 994b33fd8724..b6a749f5c766 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
@@ -21,7 +21,6 @@
 #include "svm_util.h"
 #include "hyperv.h"
 
-#define VCPU_ID		1
 #define L2_GUEST_STACK_SIZE 256
 
 struct hv_enlightenments {
@@ -122,6 +121,7 @@ int main(int argc, char *argv[])
 {
 	vm_vaddr_t nested_gva = 0;
 
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
 	struct ucall uc;
@@ -132,20 +132,20 @@ int main(int argc, char *argv[])
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
2.36.1.255.ge46751e96f-goog

