Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A2051B2E5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380507AbiEDXAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379604AbiEDWy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:54:58 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C1D53B44
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:51:20 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id s5-20020a17090aa10500b001d9a8e99e3aso1318121pjp.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=osVuhXRP0WpbN1nCJPDkaCVv1O6gRN/LXAvmrR54Xzk=;
        b=T681/jwu9yBl3Lym18iRwfxu/mvlBunXjcSO1k+a3QFwhoro9nstBRk0JzsgFmntby
         qgtMHN9idy4eGluc5UTVM6hJgvz84vMuhEuIMlXBU1Cp1op16zF5TqUDm+7iTosArlwK
         WzsyemWuXAcDvTbpJXhCWWsYy7y0rkUCakqEC85+9fgb/HYdtRlOkSGYCuqqEEc+N+hw
         +uBJqpz3cyxxrb2IWA/pfCi1qPjJjvBUvJQMI6Ic9fx3n4s8nTkBp7iNzfUKqmZG+i+O
         TsMOkLBdVsNjWs7YD5sinq+JcHP2Wv7vI6juusGO9QDrk86p73l3MuMkIbq/fIHv7Zlh
         5aqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=osVuhXRP0WpbN1nCJPDkaCVv1O6gRN/LXAvmrR54Xzk=;
        b=MSu/KTAcQ4UuStPcMzCIz2c/3JSftyvhd//1+tASJ18ISNzt9XJvGETKjiTvDSft/S
         0ycixO6whj6GpK9vSni/OC5BsWy5W5trDePSVfs/rPFr/RC3NDiP2dwVqLGHhqiID7J2
         gUgVGrmKgd4Lujw/iMvZzVc8rFibGxFB4YiBIoDv13pkTjrKJnmYZvH0abszqLJAyqMM
         ElI+880l6CjTy/fn70orSVsZk5hX7aPKkRMQi2rOWa3V5KlSX9NcCE0Ho2uU7eAQb9Rb
         MFBmH8mJPTRY1hwolAH3s/n65Z5rknfRXxza0sAs5mqSEYGndRdpA8LOToAnFLUcHFA/
         dNPA==
X-Gm-Message-State: AOAM532HrZtIAOmBL11NXco9v7359tj+ovDz/c8Z2f3ItOZcY0teI/tk
        QvAnJQa10doOY/K493EgJDlzgCPinWA=
X-Google-Smtp-Source: ABdhPJzCCE6NHESL4hS1WDVmKh8WJJnLzejWEqNTuaDbovLT34EI9rHfFn8/t+LKl0cgDc9BQxwJSUUq7gY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2353:b0:50e:15cf:268c with SMTP id
 j19-20020a056a00235300b0050e15cf268cmr8643657pfj.5.1651704680191; Wed, 04 May
 2022 15:51:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:48:09 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-64-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 063/128] KVM: selftests: Convert vmx_apic_access_test away
 from VCPU_ID
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

Convert vmx_apic_access_test to use vm_create_with_one_vcpu() and pass
around a 'struct kvm_vcpu' object instead of using a global VCPU_ID.

Opportunistically make the "vm" variable local, it is unused outside of
main().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86_64/vmx_apic_access_test.c          | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
index d438c4d3228a..10f9c86029e6 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
@@ -28,11 +28,6 @@
 
 #include "kselftest.h"
 
-#define VCPU_ID		0
-
-/* The virtual machine object. */
-static struct kvm_vm *vm;
-
 static void l2_guest_code(void)
 {
 	/* Exit to L1 */
@@ -84,9 +79,12 @@ int main(int argc, char *argv[])
 	struct vmx_pages *vmx;
 	bool done = false;
 
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
 	nested_vmx_check_supported();
 
-	vm = vm_create_default(VCPU_ID, 0, (void *) l1_guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
 	kvm_get_cpu_address_width(&paddr_width, &vaddr_width);
 	high_gpa = (1ul << paddr_width) - getpagesize();
@@ -97,13 +95,13 @@ int main(int argc, char *argv[])
 
 	vmx = vcpu_alloc_vmx(vm, &vmx_pages_gva);
 	prepare_virtualize_apic_accesses(vmx, vm);
-	vcpu_args_set(vm, VCPU_ID, 2, vmx_pages_gva, high_gpa);
+	vcpu_args_set(vm, vcpu->id, 2, vmx_pages_gva, high_gpa);
 
 	while (!done) {
-		volatile struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+		volatile struct kvm_run *run = vcpu->run;
 		struct ucall uc;
 
-		vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 		if (apic_access_addr == high_gpa) {
 			TEST_ASSERT(run->exit_reason ==
 				    KVM_EXIT_INTERNAL_ERROR,
@@ -121,7 +119,7 @@ int main(int argc, char *argv[])
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
 				  __FILE__, uc.args[1]);
-- 
2.36.0.464.gb9c8b46e94-goog

