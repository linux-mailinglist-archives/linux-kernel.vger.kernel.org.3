Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23214D5B13
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347707AbiCKF7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346694AbiCKFyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:07 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5A2972E9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:03 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id u4-20020a63b544000000b0037c62d8b0ecso4222420pgo.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=l+5q7YcGx7JEeqQ1wJ9qxAXrZVr2O0Z2hjOe2CD1PZI=;
        b=ftuiKe+MncIe7cg/3drPTyEgNpu3YhIJH8O2iEHwzFLoU3nBJhlNP/MwrUCX+PZs5j
         /ohcz1/U/lqr7mMm504IaZEARSTkDgDJ8WB5YIzff9PRO+Pv1cmxl+WVqu8ZcbZZaJBX
         xJlPYW+DAUCpdcy6VfleX0HYk4rnEy5CwiijGVBBkbnsQ2EZXp0DYbqHGTBzluAsjKms
         yJezZrAC601zSdFISCmC7fdBk0ti/aD+NRCS3SvfBdKK5bCLT/HpSpC2RrchlzV+fCQ7
         z2wcKNgN3BTc7XakzcjqMU82w8GEVai4bg83aEiCFjg6TTSKSwMiSwBLdp95t7IKzfRH
         h5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=l+5q7YcGx7JEeqQ1wJ9qxAXrZVr2O0Z2hjOe2CD1PZI=;
        b=PnqLFyMfTJz8uBcKR2igYXz7kLV61OLtX6BWmcBSBn+HAmP6k0juEvrtKIXwO5utse
         jD+MT0IBhYwv/F/94b29nTZB+qDZNsb1Nsj5w6P7fW/FifUOj8RwG6jDUylOgq8kN7XU
         rLlgvEZpSG5dvmkGjTJfGh1LZ3GnXur5FP9ym6XiWcDon0GWvy0d0BPF58r5etPYCj+2
         zrpeixQKMmCqzQNyfr90Uc9yAuA+MksPvfTwkoZSneQJ0sTYbmosKYrAi0Km/FpnxmbK
         QROmNjgI/qX1jRgG9AHkQg/2TIcd7KKAKo49Gy05iIOSjMobwPWIgkO+Jr7VKUsP40RU
         AuRA==
X-Gm-Message-State: AOAM532tLNnnoc3JFjNG6emAFmC3wQdH+MhzV26ERAkF5lZRvmL5wIzw
        mJvOmuKs2C6mvAIxtZ2CKOIw2UsQjh2CDw4QHL9Nj+2nqMljJO0xXPvcsmdaH/FmqE2Tz3+78nO
        haYSnvs4KD1UVHkYoWGJKVnS5yDHR5GayJzrmagnvQhMinhjMkSpC8SbzsplF7JRJkSNAzQ==
X-Google-Smtp-Source: ABdhPJy3yiGaPv1AMJkXheKYfViIbnDm5xRDF+viJaPNa+3E4CxnoeBV1EI6A1+U8D4+YbeSmXxaUdcKI4o=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:148a:b0:4f7:7286:a3e8 with SMTP id
 v10-20020a056a00148a00b004f77286a3e8mr7311278pfu.15.1646977982515; Thu, 10
 Mar 2022 21:53:02 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:20 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-70-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 069/105] KVM: selftests: Convert xen_vmcall_test away from VCPU_ID
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
 .../selftests/kvm/x86_64/xen_vmcall_test.c      | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
index adc94452b57c..6badb0c8b2f7 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
@@ -11,14 +11,10 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID		5
-
 #define HCALL_REGION_GPA	0xc0000000ULL
 #define HCALL_REGION_SLOT	10
 #define PAGE_SIZE		4096
 
-static struct kvm_vm *vm;
-
 #define INPUTVALUE 17
 #define ARGVALUE(x) (0xdeadbeef5a5a0000UL + x)
 #define RETVALUE 0xcafef00dfbfbffffUL
@@ -85,14 +81,17 @@ static void guest_code(void)
 
 int main(int argc, char *argv[])
 {
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
 	if (!(kvm_check_cap(KVM_CAP_XEN_HVM) &
 	      KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL) ) {
 		print_skip("KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL not available");
 		exit(KSFT_SKIP);
 	}
 
-	vm = vm_create_default(VCPU_ID, 0, (void *) guest_code);
-	vcpu_set_hv_cpuid(vm, VCPU_ID);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vcpu_set_hv_cpuid(vm, vcpu->id);
 
 	struct kvm_xen_hvm_config hvmc = {
 		.flags = KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL,
@@ -106,10 +105,10 @@ int main(int argc, char *argv[])
 	virt_map(vm, HCALL_REGION_GPA, HCALL_REGION_GPA, 2);
 
 	for (;;) {
-		volatile struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+		volatile struct kvm_run *run = vcpu->run;
 		struct ucall uc;
 
-		vcpu_run(vm, VCPU_ID);
+		vcpu_run(vm, vcpu->id);
 
 		if (run->exit_reason == KVM_EXIT_XEN) {
 			ASSERT_EQ(run->xen.type, KVM_EXIT_XEN_HCALL);
@@ -131,7 +130,7 @@ int main(int argc, char *argv[])
 			    run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
-		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
 		case UCALL_ABORT:
 			TEST_FAIL("%s", (const char *)uc.args[0]);
 			/* NOT REACHED */
-- 
2.35.1.723.g4982287a31-goog

