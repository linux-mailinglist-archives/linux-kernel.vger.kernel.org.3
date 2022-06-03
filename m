Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4EF53C211
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbiFCAxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbiFCApn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:45:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D1B34642
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:45:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i4-20020a25f204000000b006607ca067baso866852ybe.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=bVy0dX1ZUTfd9vrrkHebjrVzn4QXyuxCkdC2rRe3KKM=;
        b=bo/5JK60VCxC3R2KDhzod1eg56nDxftmEhIp0b3u0/4/o3GGn0CYB6Flgy1gl0Ry4N
         KHtOf6lh61vD7IQs3D8WCn9cZE2FVRM8Cg360WYXMD+RjVahE6/DXt04f455IgAmj5mA
         XX7MDQ5SK03rBupnIdCUheDeVH9Mg+tH07H4DlrNW5YOH0LlGc9U3fmF5kHzGls5hYbh
         R2hovDmsFUrgOlKFQJ9eX774LStw5u6XBViP+KzdP9aiHZKh/e2/S1nykzqgMZxz2Fbm
         aQJ9r01Jy5EfalwV3RI5zR53O52feOCrlBgoU3538W/QT7UkdUyAghgF0KqRDwzuUPyp
         TnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=bVy0dX1ZUTfd9vrrkHebjrVzn4QXyuxCkdC2rRe3KKM=;
        b=f3zwc0G8auyosSFgFeMPCm4reL/foc+oxYf2muoL0bnyEGnlaHAFXLdbEq6GYdkRDi
         oyuB3A7QyXgovAubyn5SCq+TmT1SOtG5U+fg+IXEdocjFS0TWoBYJzFno7qlvGAsz7N0
         JFOQbZphdogWMSPuBuWY3Q/NTngXneUU7GtaO/DE2dzyHSmk/nMix33fF783Z43G1/tQ
         2/4NLH2O0o/D/+tWIysZlzbWDLicQpj2R6O0TgBQIja5MaXGyH90UxYH0xG+BQb9bt/s
         1FbTVG+qu5o2ib0ojaB6ILDzeM2j9wd7i3N+sgjk1I73oBvyGBEhDYu3wuhjbCOTguaQ
         DGSQ==
X-Gm-Message-State: AOAM531Xpunfx0jophMIH4qeYhm1LKmnSWfQoxK+bMDJBWM+PNTUClZp
        PjtQNjCeWjJ9MoLWzqqbTBNSbl9SOos=
X-Google-Smtp-Source: ABdhPJxcjxO857QrAMOM7la57Q1KZcjXyW9JtYsF+YI0Yyxqn29B5yWFo0Ay8+Xie01KkHqTdCzFZ8xp3ac=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:7611:0:b0:65c:b595:2822 with SMTP id
 r17-20020a257611000000b0065cb5952822mr8030927ybc.228.1654217133973; Thu, 02
 Jun 2022 17:45:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:42:11 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-65-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 064/144] KVM: selftests: Convert hyperv_cpuid away from VCPU_ID
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

Convert hyperv_cpuid to use vm_create_with_one_vcpu() and pass around a
'struct kvm_vcpu' object instead of using a global VCPU_ID.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/hyperv_cpuid.c       | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
index 896e1e7c1df7..d1a22ee98cf3 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -20,8 +20,6 @@
 #include "processor.h"
 #include "vmx.h"
 
-#define VCPU_ID 0
-
 static void guest_code(void)
 {
 }
@@ -115,25 +113,26 @@ static void test_hv_cpuid(struct kvm_cpuid2 *hv_cpuid_entries,
 	}
 }
 
-void test_hv_cpuid_e2big(struct kvm_vm *vm, bool system)
+void test_hv_cpuid_e2big(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 {
 	static struct kvm_cpuid2 cpuid = {.nent = 0};
 	int ret;
 
-	if (!system)
-		ret = __vcpu_ioctl(vm, VCPU_ID, KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
+	if (vcpu)
+		ret = __vcpu_ioctl(vm, vcpu->id, KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
 	else
 		ret = __kvm_ioctl(vm_get_kvm_fd(vm), KVM_GET_SUPPORTED_HV_CPUID, &cpuid);
 
 	TEST_ASSERT(ret == -1 && errno == E2BIG,
 		    "%s KVM_GET_SUPPORTED_HV_CPUID didn't fail with -E2BIG when"
-		    " it should have: %d %d", system ? "KVM" : "vCPU", ret, errno);
+		    " it should have: %d %d", !vcpu ? "KVM" : "vCPU", ret, errno);
 }
 
 int main(int argc, char *argv[])
 {
 	struct kvm_vm *vm;
 	struct kvm_cpuid2 *hv_cpuid_entries;
+	struct kvm_vcpu *vcpu;
 
 	/* Tell stdout not to buffer its content */
 	setbuf(stdout, NULL);
@@ -143,12 +142,12 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 	}
 
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
 	/* Test vCPU ioctl version */
-	test_hv_cpuid_e2big(vm, false);
+	test_hv_cpuid_e2big(vm, vcpu);
 
-	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vm, VCPU_ID);
+	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vm, vcpu->id);
 	test_hv_cpuid(hv_cpuid_entries, false);
 	free(hv_cpuid_entries);
 
@@ -157,8 +156,8 @@ int main(int argc, char *argv[])
 		print_skip("Enlightened VMCS is unsupported");
 		goto do_sys;
 	}
-	vcpu_enable_evmcs(vm, VCPU_ID);
-	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vm, VCPU_ID);
+	vcpu_enable_evmcs(vm, vcpu->id);
+	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vm, vcpu->id);
 	test_hv_cpuid(hv_cpuid_entries, true);
 	free(hv_cpuid_entries);
 
@@ -169,7 +168,7 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
-	test_hv_cpuid_e2big(vm, true);
+	test_hv_cpuid_e2big(vm, NULL);
 
 	hv_cpuid_entries = kvm_get_supported_hv_cpuid();
 	test_hv_cpuid(hv_cpuid_entries, nested_vmx_supported());
-- 
2.36.1.255.ge46751e96f-goog

