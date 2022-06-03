Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A1753C31C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbiFCA5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiFCArQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:47:16 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C4E37BC4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:46:24 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id f9-20020a636a09000000b003c61848e622so3069445pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=tGuVl6tntArh2tnG7FnL2hXy/yuRZwiGeL9ZM9ylpR0=;
        b=kY0iuNBBiBxX/R5KFQAmMyvcdrQryiVuHG5Vgb1KP+hN1UZ2Y82vCLyrpAYQyEP1W0
         uOWn6c9NKDISCL270I5EFeLw6oI7/dig3TJVoSD89xIBfFHI0tBoqcHX7Rlu7gvzxhR8
         J4QlzLbGjFc/ty/QA5VQmtDs4meo/WuprMNCQCT4hOLo/zIlOueBVhRIi7U/nUwOZlGV
         9UpFX1O+jIYwbSJI8dnzrch6sIusTBA9ge9AFbXycJS6mEvF5Kg2aUfqCKIRW9c63+kt
         1Z0oLus0MUC5D+5xIzBUO9UfCTJlVAsuXAa1liDPVEFWkE2FxqMLQdcrbbo8/2VrtY7P
         5Q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=tGuVl6tntArh2tnG7FnL2hXy/yuRZwiGeL9ZM9ylpR0=;
        b=q7Cu/xphT70ey5wmgtEIAvHl005mSM1cU2aqtUHLG0q9hpd9BtXGs5F/uKRQkZXtKL
         ia/mUDPK+6BmQ4ngZWMcMaYib7C88a2xqtwGPNL1OHJTxS2MdfFY7/Jr1EbgeuOiJSKu
         e457oY21Luf1dr3XYrIoPObbyqL//0cEZUL1B+giK0Sb5B6tCSkYOOxOWWs8qnD7uG9b
         yiKhFV2IIbPNNoGpb+ZkR/kAOr/nikZgbH1HJmCrDGBm3yZ1acRHoG6CpJDOPlgU8nek
         4YqjMZfBRu4C0N+IDKWO/kgf3xFmeblt1gTEpP3zH7vNbdNRhhXKFfzwCE2DkVwIc5eP
         b4tg==
X-Gm-Message-State: AOAM5324xnPk0Ytu17gguJYHYogkzkgMHXn0j62wSwIptst9dodz9rXu
        CSDf328cpHUsriq/RGADkD3ZuHAMCtM=
X-Google-Smtp-Source: ABdhPJxz82JgSIO4gwDa7BZPvKzVGqA7M4Jd00ovnGR5lwwWg3Kryf0NBbRF85uJ6Kv0OfWIMAbU8El8R3E=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:6505:b0:163:b040:829b with SMTP id
 b5-20020a170902650500b00163b040829bmr7499907plk.173.1654217183604; Thu, 02
 Jun 2022 17:46:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:42:39 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-93-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 092/144] KVM: selftests: Convert system_counter_offset_test
 away from VCPU_ID
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

Convert system_counter_offset_test to use vm_create_with_one_vcpu() and
pass around a 'struct kvm_vcpu' object instead of using a global VCPU_ID.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/system_counter_offset_test.c          | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/system_counter_offset_test.c b/tools/testing/selftests/kvm/system_counter_offset_test.c
index 5dd9d28efb97..0690ce0ae4fa 100644
--- a/tools/testing/selftests/kvm/system_counter_offset_test.c
+++ b/tools/testing/selftests/kvm/system_counter_offset_test.c
@@ -14,8 +14,6 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID 0
-
 #ifdef __x86_64__
 
 struct test_case {
@@ -28,18 +26,19 @@ static struct test_case test_cases[] = {
 	{ -180 * NSEC_PER_SEC },
 };
 
-static void check_preconditions(struct kvm_vm *vm)
+static void check_preconditions(struct kvm_vcpu *vcpu)
 {
-	if (!__vcpu_has_device_attr(vm, VCPU_ID, KVM_VCPU_TSC_CTRL, KVM_VCPU_TSC_OFFSET))
+	if (!__vcpu_has_device_attr(vcpu->vm, vcpu->id, KVM_VCPU_TSC_CTRL,
+				    KVM_VCPU_TSC_OFFSET))
 		return;
 
 	print_skip("KVM_VCPU_TSC_OFFSET not supported; skipping test");
 	exit(KSFT_SKIP);
 }
 
-static void setup_system_counter(struct kvm_vm *vm, struct test_case *test)
+static void setup_system_counter(struct kvm_vcpu *vcpu, struct test_case *test)
 {
-	vcpu_device_attr_set(vm, VCPU_ID, KVM_VCPU_TSC_CTRL,
+	vcpu_device_attr_set(vcpu->vm, vcpu->id, KVM_VCPU_TSC_CTRL,
 			     KVM_VCPU_TSC_OFFSET, &test->tsc_offset);
 }
 
@@ -91,7 +90,7 @@ static void handle_abort(struct ucall *uc)
 		  __FILE__, uc->args[1]);
 }
 
-static void enter_guest(struct kvm_vm *vm)
+static void enter_guest(struct kvm_vcpu *vcpu)
 {
 	uint64_t start, end;
 	struct ucall uc;
@@ -100,12 +99,12 @@ static void enter_guest(struct kvm_vm *vm)
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
 		struct test_case *test = &test_cases[i];
 
-		setup_system_counter(vm, test);
+		setup_system_counter(vcpu, test);
 		start = host_read_guest_system_counter(test);
-		vcpu_run(vm, VCPU_ID);
+		vcpu_run(vcpu->vm, vcpu->id);
 		end = host_read_guest_system_counter(test);
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vcpu->vm, vcpu->id, &uc)) {
 		case UCALL_SYNC:
 			handle_sync(&uc, start, end);
 			break;
@@ -114,19 +113,20 @@ static void enter_guest(struct kvm_vm *vm)
 			return;
 		default:
 			TEST_ASSERT(0, "unhandled ucall %ld\n",
-				    get_ucall(vm, VCPU_ID, &uc));
+				    get_ucall(vcpu->vm, vcpu->id, &uc));
 		}
 	}
 }
 
 int main(void)
 {
+	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	vm = vm_create_default(VCPU_ID, 0, guest_main);
-	check_preconditions(vm);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
+	check_preconditions(vcpu);
 	ucall_init(vm, NULL);
 
-	enter_guest(vm);
+	enter_guest(vcpu);
 	kvm_vm_free(vm);
 }
-- 
2.36.1.255.ge46751e96f-goog

