Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554EA4D5B02
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346822AbiCKF5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346581AbiCKFxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:48 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD182E54
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:32 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id v4-20020a63f844000000b003745fd0919aso4211744pgj.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=K0H87htZ43Oywx7CtDoyzUl7rJXnMPIXTzsnNX6ofLE=;
        b=fW3+D0jYolbKcoGiJvlm5no3+9/vaS3U33WgjDwICgUXByOVIw3eCmDpYTwxLzPrr+
         eQSVG7qe2QYimVW7aP1Ry+UYOotV4xbmj+D1lrHZvM/T8zjTuEZECSA3ytzW6XnoBR+t
         YMqQKFBUoZnNwcBL7W3WLdUVnTplt5GnqvGcNyeH4MrHUB5Subltkah9/gvpuJTcNSg5
         xNmFn8bCBvyvRlQ5odcoPCeGRGnmom4/6ARMm60LVqN46Z7DQjMAx0CpSzwa+myR4t55
         aPqhlG+krnojLkTrQoSPdcJW4bbTlublpyyPBjZCYx10kdjvvyhoWxFuv9qFp7iL/Z+Z
         kQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=K0H87htZ43Oywx7CtDoyzUl7rJXnMPIXTzsnNX6ofLE=;
        b=wUJPgDnH1UZAcqH8y+e8ahAHyoR6yUeKXcqQ/G2EPLMtLwE3b88GywmAeSXjWzIs9m
         BvoJq0DgTEhYiJkY2TjvMSA/dFatS/xaY8PyvCf3miVO5SA9UoyFL1g3img1/Gp0J8KM
         effFaepWZjI5v+1cklcuO/gsGGvHDcvYi5d4xI98SQtCt59d7LyCN6oIFrPdK0TlGz0N
         0bKKzbKIoWlkZxY3lWRmBAVQmc68mAlVdhlFAhFNtBoB80IUNKqv7YUAXGtkXRoUT2IQ
         sFbdrF5QNbhrFuir5HjIoBiQjawXV3MD2CbHFFRIOVM44x+GOOBG4Eq0LoMnWPcr87vz
         N18g==
X-Gm-Message-State: AOAM5322q6Ycx9CsW1yRdtotDa42roOSV+jyzNxDMjeNgoZ290JpcFFi
        HlCcpQMCvUzXl50I4DQlOfJ70O03RklNaihLHx4PUAf9/feY8alHOLZAiGzUa1SWWnC0ojeqUCa
        dT0ByWHEx1IHAzz0U76+EU0Jp5NecHxnnLLE4Mm5LNckbDuekmpiJfXggEwOePSCTsgV1Sw==
X-Google-Smtp-Source: ABdhPJxgk+W3Q3sy51UA3F6OsO6tyR98RX1dV9ZarvoSPTqJXOytRF2F7LZmuHn0YPmevAQ0AXm/AErBvS4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:7c58:0:b0:4f6:ebf1:e78d with SMTP id
 x85-20020a627c58000000b004f6ebf1e78dmr8893697pfc.18.1646977952022; Thu, 10
 Mar 2022 21:52:32 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:02 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-52-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 051/105] KVM: selftests: Convert vmx_close_while_nested_test
 away from VCPU_ID
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
 .../kvm/x86_64/vmx_close_while_nested_test.c    | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c b/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
index edac8839e717..da0363076fba 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
@@ -18,15 +18,10 @@
 
 #include "kselftest.h"
 
-#define VCPU_ID		5
-
 enum {
 	PORT_L0_EXIT = 0x2000,
 };
 
-/* The virtual machine object. */
-static struct kvm_vm *vm;
-
 static void l2_guest_code(void)
 {
 	/* Exit to L0 */
@@ -53,20 +48,22 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 int main(int argc, char *argv[])
 {
 	vm_vaddr_t vmx_pages_gva;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
 
 	nested_vmx_check_supported();
 
-	vm = vm_create_default(VCPU_ID, 0, (void *) l1_guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
 	/* Allocate VMX pages and shared descriptors (vmx_pages). */
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
+	vcpu_args_set(vm, vcpu->id, 1, vmx_pages_gva);
 
 	for (;;) {
-		volatile struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+		volatile struct kvm_run *run = vcpu->run;
 		struct ucall uc;
 
-		vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
 			    run->exit_reason,
@@ -75,7 +72,7 @@ int main(int argc, char *argv[])
 		if (run->io.port == PORT_L0_EXIT)
 			break;
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s", (const char *)uc.args[0]);
 			/* NOT REACHED */
-- 
2.35.1.723.g4982287a31-goog

