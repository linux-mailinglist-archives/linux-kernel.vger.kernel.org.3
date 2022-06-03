Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49D353C2B8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbiFCAz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbiFCArQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:47:16 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5270837A30
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:46:15 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id x16-20020a63f710000000b003f6082673afso3042370pgh.15
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=MHxkJrz/MSjh/hMO43Bbdcoy8hxCU2glVn9aZNJZ+oU=;
        b=UwV0Z0NA1cmEm6kxjcYIDmC0zAwG3FXUWXIvIzdjAc/vRfPZIDywRPDBLxM3Ks4A+t
         8MmwIXGngR/JZNDsBE6uw9FkSfJpmp8av7bCIpBQ0L6UWOHtk/OOXAMIgfL7RuaJuEvG
         YpFWVXIofMSoZBUBMGNLPmQaIzOI1hu9Y1tBKh/KUpek3wH6qyfesOHHz8Eyv3BU8i84
         TxmEujQuVp2gTyRijTiA/n5LsoA1UWt9NUBdgQfVPwiGKZDuf540zMSnvifEVGC6V3nY
         uo1ObWl9F9WLb2JIQm1FhAYNKMTocf0lRSocRM/SHGcj+U/AP20BXDU1LkUcKyGE2Heq
         jq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=MHxkJrz/MSjh/hMO43Bbdcoy8hxCU2glVn9aZNJZ+oU=;
        b=6lZJ1HpBkZ3xSEeYgdzUXvkLe5rdOjul93VRkz6ViiilEubEa229ZzVug9Yuktc3ah
         VAZPsTHEtRDnUQfFIc9jhraUR960dsc07/VUjsx6qtaiCU4s2P0S3h5+5lVF+dVuAoAl
         FbHcWbBy2IPaTWt4IyycTpCw9kcOLZp6wqkPQXuZrAQS88JjqytxcbXu8CW5qKSBVSLs
         o2R5MORGkVZfljq7ieGMbo+rRv99I39RWdG+n4tVIiyr2mNnFD9ZnPNngU3pd9uxZmTE
         F6mJSG49nD8vdlaCrUvZ2xDS6dJOPFBmSwavIN3JIh+I1dnzm8nPJP7DXe4IhZF36Hl5
         R/bw==
X-Gm-Message-State: AOAM532FBMv1tJoeKKmDt2TE4B3PFZ8Yt70v714WFPGeV6Lkqvqc+EA9
        3hZtvXCDnyh3/Svja91f7PfNFJRVX1k=
X-Google-Smtp-Source: ABdhPJyQuEfkb0agAK/MxDppyJF7O1kot8Efh9XlXHnP2j2bZzQshRH+553ZTsXlPzW/5eVXJqwnz/UCLEk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:ab90:b0:1da:375f:2f44 with SMTP id
 n16-20020a17090aab9000b001da375f2f44mr8169560pjq.33.1654217174553; Thu, 02
 Jun 2022 17:46:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:42:34 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-88-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 087/144] KVM: selftests: Convert vmx_invalid_nested_guest_state
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

Convert vmx_invalid_nested_guest_state to use vm_create_with_one_vcpu() and
pass around a 'struct kvm_vcpu' object instead of using a global VCPU_ID.

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
2.36.1.255.ge46751e96f-goog

