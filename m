Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E474D5AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346608AbiCKF5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346616AbiCKFxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:36 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17152EF08D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:26 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id r64-20020a17090a43c600b001bf8e05847eso6643638pjg.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=rrEN1al/iXqLo5WYs8SKT4+jkWFFWdw4MDQg5iqhYi4=;
        b=frEC44pjOH8hf6UY4PXxBoT6F5ZGHVakMLPzRI65B5AA2JawhN+IFRyVxVWoYFeNmS
         TL6qkvJnOyTrB8jg1Do43fgfC6UZDUr4dC2Zqmma/uKQOAL+UCmfdP9+A04vjMShugW3
         Z1/s7beO5JqyHk23ql/GM1/vprTyRnIbtZeoJlRf8avhhzmUJQTQKsCW8BNS2SU6NJ8D
         3uMJRXdM1DJI/D4vlbbSNoii9Yvix1lwSqKHYMaCmnbWFs/z0N/r/UC5w5Vv3BbsL0Pn
         qvzARQh22cihu7qYmbJrp/YIpGOz27FANgRRQCFi654CF5PFMgPWc8J6SzulEADmoUoI
         4HFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=rrEN1al/iXqLo5WYs8SKT4+jkWFFWdw4MDQg5iqhYi4=;
        b=Rm7OHxxnVRxZo5+Hg98E12PkUdBAkTOwaoWv1TiMhove6Kgo4iU3coSrdoiFVm+1w5
         jaooZpFuUBJIdYOGQWMtjvKhhzFiCm6GkqXPxbnbQpbUKN1SV+NRVbXJ/XFGkEPf4YUn
         5urSRwrQi0kFwzT9f0rGVyo+0PVHxZhpSzWbwXNM0oPq+Vtvgd34qtCIJMP7UpMjcqQY
         DD77c5ky65lKR3pBjOjpKYPwBUNHFegwaa05gmgCdjYeiwNm7aFcf5lTJIyegsHfVv5A
         oHIVulYdkByncL52bCABBmr/dODWMIrBnhZ31sO/G71EYaqHHx4FNT3gYodG5CgX/3vA
         xyKA==
X-Gm-Message-State: AOAM531/fsZigv5+Z2jkAfYNcNxxBt6pLmMc93H1KfscgfeUtcPjWZSI
        Epa+opYVl4Qkdi+uwvNoKhHwzS1HeoYVRWEbmiIc7YhRoPSTCbkn/Mcey7w7/Yfy4xnyBKVVNZA
        I6dDKISVLcXAOTplyKto4NZoDJP8wE/N5h8bnF91/gu/3aw+oaHNTFmCO8T4mobKjE9mivw==
X-Google-Smtp-Source: ABdhPJz2Wm/4d5jI1jEbmfIuQrkySOfsh8ldsGOzIz/v3oijFLCVDIYF+ejwAWnuwTJaB6na4rrcaylZ8ho=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e10:b0:1bf:6c78:54a9 with SMTP id
 pg16-20020a17090b1e1000b001bf6c7854a9mr460718pjb.1.1646977945258; Thu, 10 Mar
 2022 21:52:25 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:58 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-48-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 047/105] KVM: selftests: Convert platform_info_test away
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
 .../selftests/kvm/x86_64/platform_info_test.c | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/platform_info_test.c b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
index 1e89688cbbbf..0468a51c05f6 100644
--- a/tools/testing/selftests/kvm/x86_64/platform_info_test.c
+++ b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
@@ -21,7 +21,6 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID 0
 #define MSR_PLATFORM_INFO_MAX_TURBO_RATIO 0xff00
 
 static void guest_code(void)
@@ -45,18 +44,18 @@ static void set_msr_platform_info_enabled(struct kvm_vm *vm, bool enable)
 	vm_enable_cap(vm, &cap);
 }
 
-static void test_msr_platform_info_enabled(struct kvm_vm *vm)
+static void test_msr_platform_info_enabled(struct kvm_vcpu *vcpu)
 {
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	struct kvm_run *run = vcpu->run;
 	struct ucall uc;
 
-	set_msr_platform_info_enabled(vm, true);
-	vcpu_run(vm, VCPU_ID);
+	set_msr_platform_info_enabled(vcpu->vm, true);
+	vcpu_run(vcpu->vm, vcpu->id);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			"Exit_reason other than KVM_EXIT_IO: %u (%s),\n",
 			run->exit_reason,
 			exit_reason_str(run->exit_reason));
-	get_ucall(vm, VCPU_ID, &uc);
+	get_ucall(vcpu->vm, vcpu->id, &uc);
 	TEST_ASSERT(uc.cmd == UCALL_SYNC,
 			"Received ucall other than UCALL_SYNC: %lu\n", uc.cmd);
 	TEST_ASSERT((uc.args[1] & MSR_PLATFORM_INFO_MAX_TURBO_RATIO) ==
@@ -65,12 +64,12 @@ static void test_msr_platform_info_enabled(struct kvm_vm *vm)
 		MSR_PLATFORM_INFO_MAX_TURBO_RATIO);
 }
 
-static void test_msr_platform_info_disabled(struct kvm_vm *vm)
+static void test_msr_platform_info_disabled(struct kvm_vcpu *vcpu)
 {
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	struct kvm_run *run = vcpu->run;
 
-	set_msr_platform_info_enabled(vm, false);
-	vcpu_run(vm, VCPU_ID);
+	set_msr_platform_info_enabled(vcpu->vm, false);
+	vcpu_run(vcpu->vm, vcpu->id);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_SHUTDOWN,
 			"Exit_reason other than KVM_EXIT_SHUTDOWN: %u (%s)\n",
 			run->exit_reason,
@@ -79,6 +78,7 @@ static void test_msr_platform_info_disabled(struct kvm_vm *vm)
 
 int main(int argc, char *argv[])
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	int rv;
 	uint64_t msr_platform_info;
@@ -92,14 +92,14 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 	}
 
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
-	msr_platform_info = vcpu_get_msr(vm, VCPU_ID, MSR_PLATFORM_INFO);
-	vcpu_set_msr(vm, VCPU_ID, MSR_PLATFORM_INFO,
+	msr_platform_info = vcpu_get_msr(vm, vcpu->id, MSR_PLATFORM_INFO);
+	vcpu_set_msr(vm, vcpu->id, MSR_PLATFORM_INFO,
 		msr_platform_info | MSR_PLATFORM_INFO_MAX_TURBO_RATIO);
-	test_msr_platform_info_enabled(vm);
-	test_msr_platform_info_disabled(vm);
-	vcpu_set_msr(vm, VCPU_ID, MSR_PLATFORM_INFO, msr_platform_info);
+	test_msr_platform_info_enabled(vcpu);
+	test_msr_platform_info_disabled(vcpu);
+	vcpu_set_msr(vm, vcpu->id, MSR_PLATFORM_INFO, msr_platform_info);
 
 	kvm_vm_free(vm);
 
-- 
2.35.1.723.g4982287a31-goog

