Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DAD4D5AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346937AbiCKF5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346660AbiCKFxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:05 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78064ED94F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:02 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id m22-20020a628c16000000b004f6f1b43114so4634929pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=EhgwfY2UJZoSUoAPo4cv0aFfvTRiXncKd75c7iQYd44=;
        b=DQqw9mAji/tvBOBByWFZtBchIFJK0AAdTTk2rqd3QOPT5/20f90UtcPPgLiCJjpUVP
         tKjfNTLGOgsq/amhT7f8B50kQ2/JhQumkvpHpfNmthd8tEsUlLXNHAqk0gTj7K0oa12t
         1DXrJUB9Dz/KEZAAdyqG+xhBOPjKJMC1mTlA8J0HRlqQKEk3sg5v4FDbqlVouGozcmYV
         IixbY29mV+EsO/As91kG1p6GObLa+pPPNg1wvf9qfQqrvvlrPoGqdeg6gN8FoIRKejXx
         0lSBtVd9H/KEhJ9HGQy3yj44qJVrVEOEInVao8BP1xdnYydIphCep7VVBMiRari9SWcT
         5rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=EhgwfY2UJZoSUoAPo4cv0aFfvTRiXncKd75c7iQYd44=;
        b=s+ALd8KE6nR+yRl97C1ms9Vb8kW56MdDyDGAI9HfChzSQfQeDS/9G4Ho/1UDQbM0JW
         NC5SdOu9Fx4rSnm7IFhQxnUK4M68LABX96kfkiSNbY0ZSTTgBlfbWNi7F3c5MKRLA40f
         S0I0cQa9zycvsxcO0Sl8Huj9Re7apHLf7Del1zKbPW4AHjIuo9TyjAwNohfO+yO0JjTF
         oX++Nc0nonga4VsbNag8ySlZUhRtaR85cSh3zVwuse/7zHKCJnVnC8s9egRUz5DlfzSe
         nMq7mr8J0QyfjHKsp+zGlFFsCPPW1SEr45dAPM2qXF/9I+lm6V0pM8FxRKJd6DLAjh03
         tnbw==
X-Gm-Message-State: AOAM5335aqCIWb0jRh3xeRQWuEK6/WIhJ5luKV0D+R43xAItpiClOvls
        uUIXdZ3jbD2yc7NadiXPquNJH62rZkdOskdRmkZ4ET2oFYSf3PPBZh+I9WlHLE/Q2KhlUurB9y9
        R0+ZoFtDpB/oqjVPwicHg/+CPJzR4OhmNtvo24rLuqz4Ccd8FgQ1I6msoEPFNLul9jaKAdg==
X-Google-Smtp-Source: ABdhPJxpuBnBwg6sJcTNEtDa7JsqTjL18p22Kvc8PCEir7ZMtK+uV8MuY4kYVeUHvWUbSgb22B0kTwzzl/w=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:5291:b0:1bb:ef4d:947d with SMTP id
 w17-20020a17090a529100b001bbef4d947dmr19910328pjh.243.1646977921812; Thu, 10
 Mar 2022 21:52:01 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:44 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-34-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 033/105] KVM: selftests: Convert xss_msr_test away from VCPU_ID
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
 tools/testing/selftests/kvm/x86_64/xss_msr_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xss_msr_test.c b/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
index 3529376747c2..c5672d2949db 100644
--- a/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
@@ -12,7 +12,6 @@
 #include "kvm_util.h"
 #include "vmx.h"
 
-#define VCPU_ID	      1
 #define MSR_BITS      64
 
 #define X86_FEATURE_XSAVES	(1<<3)
@@ -40,11 +39,12 @@ int main(int argc, char *argv[])
 	struct kvm_cpuid_entry2 *entry;
 	bool xss_supported = false;
 	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
 	uint64_t xss_val;
 	int i, r;
 
 	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, 0);
+	vm = vm_create_with_one_vcpu(&vcpu, NULL);
 
 	if (kvm_get_cpuid_max_basic() >= 0xd) {
 		entry = kvm_get_supported_cpuid_index(0xd, 1);
@@ -55,11 +55,11 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 	}
 
-	xss_val = vcpu_get_msr(vm, VCPU_ID, MSR_IA32_XSS);
+	xss_val = vcpu_get_msr(vm, vcpu->id, MSR_IA32_XSS);
 	TEST_ASSERT(xss_val == 0,
 		    "MSR_IA32_XSS should be initialized to zero\n");
 
-	vcpu_set_msr(vm, VCPU_ID, MSR_IA32_XSS, xss_val);
+	vcpu_set_msr(vm, vcpu->id, MSR_IA32_XSS, xss_val);
 	/*
 	 * At present, KVM only supports a guest IA32_XSS value of 0. Verify
 	 * that trying to set the guest IA32_XSS to an unsupported value fails.
@@ -67,7 +67,7 @@ int main(int argc, char *argv[])
 	 * IA32_XSS is in the KVM_GET_MSR_INDEX_LIST.
 	 */
 	for (i = 0; i < MSR_BITS; ++i) {
-		r = _vcpu_set_msr(vm, VCPU_ID, MSR_IA32_XSS, 1ull << i);
+		r = _vcpu_set_msr(vm, vcpu->id, MSR_IA32_XSS, 1ull << i);
 		TEST_ASSERT(r == 0 || is_supported_msr(MSR_IA32_XSS),
 			    "IA32_XSS was able to be set, but was not found in KVM_GET_MSR_INDEX_LIST.\n");
 	}
-- 
2.35.1.723.g4982287a31-goog

