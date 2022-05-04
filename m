Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8016351B30E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiEDXAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379601AbiEDWy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:54:58 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184D053A43
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:51:18 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x23-20020a170902b41700b0015ea144789fso1368881plr.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=IrbcZ5mK2QD6IysigFqMLPTajcE5FF9g9KheO2xv8m0=;
        b=YnMTDmxgYPnGsWFuFaJ8/FOjCIpHIdCcI/0q37AwInmD7Zqq5l1weYR6KI8fpjMNWP
         NkyoRT8Vo9AJI4sXIwV6DDpkU5HhbhIFX2Qjd7S1LXXei+Zb9L+dYv6PgtiSR/TZkSqT
         E+IP58uXcp2MSxf8rBwNMGvT59xyCzOksnBPX22AYhJmiHfAIfvy+YNaxltfhdg50GOn
         uyqmGcAZ6ukrU6JwDDwnwQ0tBKplZgnGLaqWoaO75Tp0bWcWqTfOdbXfUCe916VdMPRS
         w0vUinHuO8ApvlyIrF3CnOq1ntobyBFhR9yb7ljfk7a6voGWVTkKLwz/eu11zWV4XBJT
         +wjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=IrbcZ5mK2QD6IysigFqMLPTajcE5FF9g9KheO2xv8m0=;
        b=szI2XUypYZ3PSiF+x9fX2N9GXyvWoqc7OL/vSArjQspsYQacTfQC01VF3wwpOT2SNN
         KR8hEmUmO0orvdz3N9oJZv4nE0GOm6GSiExEfdJznQ/puhUyn5tn31jVaXCJlX2Ce2Lk
         onvMY9DiesWsKrQ3xc8ETOOEdboRPtotgkhzctujO78VPzNVnMmJTxuSYVlF015snHoe
         9Jhbs5W0ISp5ekpAPLoPCZo8p/IM9gF6FUt2NbkUaB9YEIOHqgf0gL51BQ/H0gYdXv43
         EZvkHe5OI8MZ9BIgm3hxuwdq/kHlHQXIoXshkXYMJThkVQZwHug8ZpPXn2yj/p8W98Xy
         W/tA==
X-Gm-Message-State: AOAM5328PlElEKS09jLMv6nOZrSLzWfWbST6x6DfLpWN7WC8SDQsxt/i
        NfpogJA6onhwAPmLdlD9RcgVY5AW5mQ=
X-Google-Smtp-Source: ABdhPJyDaRiGLOPTKEcAwhXlU1mIU+dh9loJlSRJj1hWcmfLKoiW3BjbwwlrcWXd1NqX+1vTT4EbVHydFME=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e510:b0:1d9:ee23:9fa1 with SMTP id
 t16-20020a17090ae51000b001d9ee239fa1mr140241pjy.0.1651704678082; Wed, 04 May
 2022 15:51:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:48:08 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-63-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 062/128] KVM: selftests: Convert vmx_close_while_nested_test
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

Convert vmx_close_while_nested_test to use vm_create_with_one_vcpu() and
pass around a 'struct kvm_vcpu' object instead of using a global VCPU_ID.
Note, this is a "functional" change in the sense that the test now
creates a vCPU with vcpu_id==0 instead of vcpu_id==5.  The non-zero
VCPU_ID was 100% arbitrary and added little to no validation coverage.
If testing non-zero vCPU IDs is desirable for generic tests, that can be
done in the future by tweaking the VM creation helpers.

Opportunistically make the "vm" variable local, it is unused outside of
main().

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
2.36.0.464.gb9c8b46e94-goog

