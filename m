Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF9451B2EF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240153AbiEDXBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379475AbiEDWzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:55:15 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A13254180
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:51:24 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q14-20020a17090a178e00b001dc970bf587so1943841pja.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=VfF+qu4NBn2WU10IrpaRgWEMCJ3uSkBYIlbisDqeCTU=;
        b=BQQwTh22N5a2BCrol9MzuIpKxSzSmRgbQYgoefbnNP4rkxJeOiiWuGT06a1BmPtNN/
         niiSCabObYe6G3aRLzILXi4N1AA5oiDng7zAVBuJ9HMuxha6Mj01SB7G8MJz05muJ9o0
         U9JJDULdoUElIaRGGxOrtw750C4UxOzhK6FnWBggAo4XKaMhtfYwf6lvfb/pGu3fnS5t
         HRZ/IkIaqvaf7CzLLDkLEy8tKLXnfTpCnwYdrfKTtbUR1sJtcUun9dYcm6wIUL93M2xc
         AkQ2Sa+ykLx+rggE8FLD2tv7LhioLZNXS5aBR/VG6EWgUVEzfC/utW3Kc6z0lLOTAjb+
         GIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=VfF+qu4NBn2WU10IrpaRgWEMCJ3uSkBYIlbisDqeCTU=;
        b=Ki1k1gIWt+t2Q20XUN+lW7tkOfxkFFzNrC2yVgvPTARKc/nGizO/ASl6MkH8W4y2Fe
         OC+HsCMT5ZHwkUFi5OyKQC8plGz3uPoIrXQncUWEB+Pakjkoh02D0ucDDTMh1R7EGJdU
         3FF9zGzVGNfz4JuH78yOr5BU+E6VsN+/MpJKCraS5rwRKQ4eNbRCej+p+75XIdgVp4bP
         vZ/6Nn3oq57MGHyp8pBPB5U5YTM1ozEwgUDGqDUHdJB6MTaf7UOz0c/WtMWcTye1Q+hB
         /DGe2yP9uHG3tYy8YA1h21GCFzvDDexYzhccCRp6zLcw4zRm9O7WcCJyovaRiKeB+u/v
         ZPRQ==
X-Gm-Message-State: AOAM531V1zTxDscFPGsoe7/9niRkZb/4RO8N4rJzr2H5uYBPjLkZ3ION
        cYbEMsePEpg64deIniTZHOkTMTjwDF0=
X-Google-Smtp-Source: ABdhPJwKAjHvkXGwDJzSyVYavQh0IQUj+ob3hyNrc9umVOEUOPHulxsMvBFzbEQpHscz5PDAnt1WXXF5Xd0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:88d2:0:b0:50a:cf7d:6ff1 with SMTP id
 k18-20020aa788d2000000b0050acf7d6ff1mr23417886pff.67.1651704683611; Wed, 04
 May 2022 15:51:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:48:11 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-66-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 065/128] KVM: selftests: Convert vmx_exception_with_invalid_guest_state
 away from VCPU_ID
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert vmx_exception_with_invalid_guest_state to use
vm_create_with_one_vcpu() and pass around a 'struct kvm_vcpu' object
instead of using a global VCPU_ID.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../vmx_exception_with_invalid_guest_state.c  | 62 +++++++++++--------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
index 27a850f3d7ce..70b30583e50d 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
@@ -10,10 +10,6 @@
 
 #include "kselftest.h"
 
-#define VCPU_ID	0
-
-static struct kvm_vm *vm;
-
 static void guest_ud_handler(struct ex_regs *regs)
 {
 	/* Loop on the ud2 until guest state is made invalid. */
@@ -24,11 +20,11 @@ static void guest_code(void)
 	asm volatile("ud2");
 }
 
-static void __run_vcpu_with_invalid_state(void)
+static void __run_vcpu_with_invalid_state(struct kvm_vcpu *vcpu)
 {
-	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	struct kvm_run *run = vcpu->run;
 
-	vcpu_run(vm, VCPU_ID);
+	vcpu_run(vcpu->vm, vcpu->id);
 
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_INTERNAL_ERROR,
 		    "Expected KVM_EXIT_INTERNAL_ERROR, got %d (%s)\n",
@@ -38,15 +34,15 @@ static void __run_vcpu_with_invalid_state(void)
 		    run->emulation_failure.suberror);
 }
 
-static void run_vcpu_with_invalid_state(void)
+static void run_vcpu_with_invalid_state(struct kvm_vcpu *vcpu)
 {
 	/*
 	 * Always run twice to verify KVM handles the case where _KVM_ queues
 	 * an exception with invalid state and then exits to userspace, i.e.
 	 * that KVM doesn't explode if userspace ignores the initial error.
 	 */
-	__run_vcpu_with_invalid_state();
-	__run_vcpu_with_invalid_state();
+	__run_vcpu_with_invalid_state(vcpu);
+	__run_vcpu_with_invalid_state(vcpu);
 }
 
 static void set_timer(void)
@@ -59,33 +55,43 @@ static void set_timer(void)
 	ASSERT_EQ(setitimer(ITIMER_REAL, &timer, NULL), 0);
 }
 
-static void set_or_clear_invalid_guest_state(bool set)
+static void set_or_clear_invalid_guest_state(struct kvm_vcpu *vcpu, bool set)
 {
 	static struct kvm_sregs sregs;
 
 	if (!sregs.cr0)
-		vcpu_sregs_get(vm, VCPU_ID, &sregs);
+		vcpu_sregs_get(vcpu->vm, vcpu->id, &sregs);
 	sregs.tr.unusable = !!set;
-	vcpu_sregs_set(vm, VCPU_ID, &sregs);
+	vcpu_sregs_set(vcpu->vm, vcpu->id, &sregs);
 }
 
-static void set_invalid_guest_state(void)
+static void set_invalid_guest_state(struct kvm_vcpu *vcpu)
 {
-	set_or_clear_invalid_guest_state(true);
+	set_or_clear_invalid_guest_state(vcpu, true);
 }
 
-static void clear_invalid_guest_state(void)
+static void clear_invalid_guest_state(struct kvm_vcpu *vcpu)
 {
-	set_or_clear_invalid_guest_state(false);
+	set_or_clear_invalid_guest_state(vcpu, false);
+}
+
+static struct kvm_vcpu *get_set_sigalrm_vcpu(struct kvm_vcpu *__vcpu)
+{
+	static struct kvm_vcpu *vcpu = NULL;
+
+	if (__vcpu)
+		vcpu = __vcpu;
+	return vcpu;
 }
 
 static void sigalrm_handler(int sig)
 {
+	struct kvm_vcpu *vcpu = get_set_sigalrm_vcpu(NULL);
 	struct kvm_vcpu_events events;
 
 	TEST_ASSERT(sig == SIGALRM, "Unexpected signal = %d", sig);
 
-	vcpu_events_get(vm, VCPU_ID, &events);
+	vcpu_events_get(vcpu->vm, vcpu->id, &events);
 
 	/*
 	 * If an exception is pending, attempt KVM_RUN with invalid guest,
@@ -93,8 +99,8 @@ static void sigalrm_handler(int sig)
 	 * between KVM queueing an exception and re-entering the guest.
 	 */
 	if (events.exception.pending) {
-		set_invalid_guest_state();
-		run_vcpu_with_invalid_state();
+		set_invalid_guest_state(vcpu);
+		run_vcpu_with_invalid_state(vcpu);
 	} else {
 		set_timer();
 	}
@@ -102,15 +108,19 @@ static void sigalrm_handler(int sig)
 
 int main(int argc, char *argv[])
 {
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
 	if (!is_intel_cpu() || vm_is_unrestricted_guest(NULL)) {
 		print_skip("Must be run with kvm_intel.unrestricted_guest=0");
 		exit(KSFT_SKIP);
 	}
 
-	vm = vm_create_default(VCPU_ID, 0, (void *)guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	get_set_sigalrm_vcpu(vcpu);
 
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, VCPU_ID);
+	vcpu_init_descriptor_tables(vm, vcpu->id);
 
 	vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
 
@@ -119,8 +129,8 @@ int main(int argc, char *argv[])
 	 * KVM_RUN should induce a TRIPLE_FAULT in L2 as KVM doesn't support
 	 * emulating invalid guest state for L2.
 	 */
-	set_invalid_guest_state();
-	run_vcpu_with_invalid_state();
+	set_invalid_guest_state(vcpu);
+	run_vcpu_with_invalid_state(vcpu);
 
 	/*
 	 * Verify KVM also handles the case where userspace gains control while
@@ -129,11 +139,11 @@ int main(int argc, char *argv[])
 	 * guest with invalid state when the handler interrupts KVM with an
 	 * exception pending.
 	 */
-	clear_invalid_guest_state();
+	clear_invalid_guest_state(vcpu);
 	TEST_ASSERT(signal(SIGALRM, sigalrm_handler) != SIG_ERR,
 		    "Failed to register SIGALRM handler, errno = %d (%s)",
 		    errno, strerror(errno));
 
 	set_timer();
-	run_vcpu_with_invalid_state();
+	run_vcpu_with_invalid_state(vcpu);
 }
-- 
2.36.0.464.gb9c8b46e94-goog

