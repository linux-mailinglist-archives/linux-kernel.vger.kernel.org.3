Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A625F4D5B12
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347691AbiCKF7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346686AbiCKFyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:06 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC430939BC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:01 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id q8-20020a170902f78800b00151cc484688so3990099pln.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=BA/9wv0f77CQq9BIsQx7F9vfIHz6iVe/678SmR1+8tE=;
        b=WQF0KgysDaaJu9Y3mx+KOlWf0ZVKyEj3J6Yn37Z1WDSBbXs0Wr6wBHwlQgXe8qFULo
         AJWJXIT/r/VILG7HoZF/D1lEUWkA1o1mDXA6kwRcXMv2uSxSuPbAxxJq1yxsHzH3uOeS
         dssXE0Ry2xZMKNFOaIpoezS9O1J93nnzg+qtYDKV/PSYwIueaIVROCGFdKCZ5uLG4egM
         FhkkxTh10f0DigiUdfYidO6grQV/pEaho01RK+t/yRiM8rN5eL6I5ugy4ZDgWwVd7RP+
         g53m63bybBML5s8IJy26KN2ZDjfD2xoGDV2poQEW2EFrQSvQcBS1fc1PMfuDOq4rLC06
         pQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=BA/9wv0f77CQq9BIsQx7F9vfIHz6iVe/678SmR1+8tE=;
        b=K42/yRZKKcYd8zsJW0ZOc9I9G4gbKcRywYZKC5MfWuXvJWONCXI2D6uu/rxRkqXC0S
         4TMmnjDhxzKBtBTJ7O2nLb7+rDunpQXMrbMDENiOEyifMZzFaFCpV24eCo7+d1QE8Hr9
         1gvvgpVfeTpH4riSU7TxHFIkAThtaNP7NpJgDnghMiLSHZipZWSJx+3SnmQW2kdYMNGk
         WfYeEGnjHtYn9wARO0tWoMvYhlzmThXRRnyTdpe5Syv/0Uki2qaMPyxF7DxUllUMczx6
         J3e3zFiuaZL/F6SyxufDmm3zfwXwRqC2lvlxTfTlsaNBcE0zn0FX/8mZry/XPW6iv5cb
         LeqA==
X-Gm-Message-State: AOAM5318yMm6oDHi+d1fH48oXLdH5mNZCOximSxeeveHaJQSFatvc1lS
        gPkjGp1HOKr/OZyJSww/o/YQXX1WeyxVrp0QOmJxeDmuOKAmcKqqMrpwzflgMCHsiDKEGJMFXrw
        paCplpBB1v8lrBz1P+vKkh3xEa7EMchLTvoYtSrqqUmahkpssAyAp0TVumgtfvXoJAqcwvA==
X-Google-Smtp-Source: ABdhPJyO64b4YYiRZ6am1T9W0ltMlJVXEu1ZlQDof+yx1PjYN3s/VQ5OMluVlq7lpxdVg7A/EO4tQw8BTCE=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:e3c5:b0:153:3022:4fb8 with SMTP id
 r5-20020a170902e3c500b0015330224fb8mr3168241ple.106.1646977980948; Thu, 10
 Mar 2022 21:53:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:19 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-69-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 068/105] KVM: selftests: Convert vmx_invalid_nested_guest_state
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
 .../x86_64/vmx_invalid_nested_guest_state.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c
index 489fbed4ca6f..ba534be498f9 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c
@@ -9,7 +9,6 @@
 
 #include "kselftest.h"
 
-#define VCPU_ID	0
 #define ARBITRARY_IO_PORT 0x2000
 
 static struct kvm_vm *vm;
@@ -55,20 +54,21 @@ int main(int argc, char *argv[])
 {
 	vm_vaddr_t vmx_pages_gva;
 	struct kvm_sregs sregs;
+	struct kvm_vcpu *vcpu;
 	struct kvm_run *run;
 	struct ucall uc;
 
 	nested_vmx_check_supported();
 
-	vm = vm_create_default(VCPU_ID, 0, (void *) l1_guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
 	/* Allocate VMX pages and shared descriptors (vmx_pages). */
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
+	vcpu_args_set(vm, vcpu->id, 1, vmx_pages_gva);
 
-	vcpu_run(vm, VCPU_ID);
+	vcpu_run(vm, vcpu->id);
 
-	run = vcpu_state(vm, VCPU_ID);
+	run = vcpu->run;
 
 	/*
 	 * The first exit to L0 userspace should be an I/O access from L2.
@@ -88,13 +88,13 @@ int main(int argc, char *argv[])
 	 * emulating invalid guest state for L2.
 	 */
 	memset(&sregs, 0, sizeof(sregs));
-	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	vcpu_sregs_get(vm, vcpu->id, &sregs);
 	sregs.tr.unusable = 1;
-	vcpu_sregs_set(vm, VCPU_ID, &sregs);
+	vcpu_sregs_set(vm, vcpu->id, &sregs);
 
-	vcpu_run(vm, VCPU_ID);
+	vcpu_run(vm, vcpu->id);
 
-	switch (get_ucall(vm, VCPU_ID, &uc)) {
+	switch (get_ucall(vm, vcpu->id, &uc)) {
 	case UCALL_DONE:
 		break;
 	case UCALL_ABORT:
-- 
2.35.1.723.g4982287a31-goog

