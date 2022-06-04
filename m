Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404CA53D478
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350310AbiFDBYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350205AbiFDBXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:23:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BED2CDE0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:22:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 70-20020a250249000000b0065cbf886b23so8231341ybc.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=yfkUMsmDGGeH3M/FWDGodyCRiaziEFV/NXR4VZp8ZC8=;
        b=iAq/uHVPCDq8tx1UFOGN/hYZl8mPJVdCgCs3IbdeW1sBr9HKchdKNWw57cPlTCMLJ4
         YN/J67fIOY8F6vc+Uq+NSmcEbAZ3BZTuTXs9fIy/fQrZweo0p0aA+ncSvPs1+BNeJkIC
         dMwVuIL5f/MWZv4nPjztpuyZc5VwIo9Jgs5buQjW98j82RZKO8X+v/lDBd80suitxdPj
         ofyx2UKi5fXFKecS+smX+rAd+JSYxd1kL/qAy3oqo9SYnJcdH8/4UkHfyY+D2sUgN1wf
         Ds3srqZ725SvZOAlDc6wShwngMYV6UCjlNWLl7OpFVUqgBILpHTe+3KvGoqjh5y5eh+a
         Cd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=yfkUMsmDGGeH3M/FWDGodyCRiaziEFV/NXR4VZp8ZC8=;
        b=kb1KRw1m/rgU+aX55Js3ekayCKPjWq/lQF6Rh8bCFos8zqVqsvwyg2UgN1W3SlIPB/
         39iRRrzO9iDArUj4pnyQr7QiHs/Hc9EUFXigUAzvWvGFTWLtJzh+jLLlFNkpSsIIANpt
         Dwk+Mz+nGBMUunv29IJFCJPmn3jvLaspIGYV5T33nta85VLJLKP0rqwfJR/osBZLC/kP
         8by7274PppTthdd9euPqz53xUb3MrDL3LgZlWLIh+3hXgIFHqrXyUSu+cjWHzYFKtIhZ
         2H5P/MAh08WUNehYNLBevMIyHlWG3B0uMTjHCTqtTLr3obFjxtkYCwNmnRv+VX/8nBME
         O5XQ==
X-Gm-Message-State: AOAM532yJeNcyVJ/ERqk08oGH5cn4A7HmClcEEvcXOgSMmfHE6kYo+35
        t5+n3aHtUpDAJ1/tkYvHOvBuYa8BgkI=
X-Google-Smtp-Source: ABdhPJzCKpTfCklgdTqBWfC/JE0O73kzE6vZintXmtJ8GikPR/z3QX41BuCSC4WMaRtPeur8DO/uCRcZGq4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a5b:c0e:0:b0:65c:bfb5:2acf with SMTP id
 f14-20020a5b0c0e000000b0065cbfb52acfmr14300899ybq.216.1654305720843; Fri, 03
 Jun 2022 18:22:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Jun 2022 01:20:50 +0000
In-Reply-To: <20220604012058.1972195-1-seanjc@google.com>
Message-Id: <20220604012058.1972195-35-seanjc@google.com>
Mime-Version: 1.0
References: <20220604012058.1972195-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 34/42] KVM: selftests: Use this_cpu_has() to detect SVM
 support in L1
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
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

Replace an evil open coded instance of querying CPUID from L1 with
this_cpu_has(X86_FEATURE_SVM).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/x86_64/svm_util.h | 13 -------------
 tools/testing/selftests/kvm/x86_64/smm_test.c       |  4 ++--
 tools/testing/selftests/kvm/x86_64/state_test.c     |  2 +-
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/svm_util.h b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
index f48806d26989..a339b537a575 100644
--- a/tools/testing/selftests/kvm/include/x86_64/svm_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
@@ -13,9 +13,6 @@
 #include "svm.h"
 #include "processor.h"
 
-#define CPUID_SVM_BIT		2
-#define CPUID_SVM		BIT_ULL(CPUID_SVM_BIT)
-
 #define SVM_EXIT_EXCP_BASE	0x040
 #define SVM_EXIT_HLT		0x078
 #define SVM_EXIT_MSR		0x07c
@@ -52,16 +49,6 @@ struct svm_test_data *vcpu_alloc_svm(struct kvm_vm *vm, vm_vaddr_t *p_svm_gva);
 void generic_svm_setup(struct svm_test_data *svm, void *guest_rip, void *guest_rsp);
 void run_guest(struct vmcb *vmcb, uint64_t vmcb_gpa);
 
-static inline bool cpu_has_svm(void)
-{
-	u32 eax = 0x80000001, ecx;
-
-	asm("cpuid" :
-	    "=a" (eax), "=c" (ecx) : "0" (eax) : "ebx", "edx");
-
-	return ecx & CPUID_SVM;
-}
-
 int open_sev_dev_path_or_exit(void);
 
 #endif /* SELFTEST_KVM_SVM_UTILS_H */
diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
index 40581704f129..7937db5b1037 100644
--- a/tools/testing/selftests/kvm/x86_64/smm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
@@ -83,7 +83,7 @@ static void guest_code(void *arg)
 	sync_with_host(4);
 
 	if (arg) {
-		if (cpu_has_svm()) {
+		if (this_cpu_has(X86_FEATURE_SVM)) {
 			generic_svm_setup(svm, l2_guest_code,
 					  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
 		} else {
@@ -99,7 +99,7 @@ static void guest_code(void *arg)
 
 		sync_with_host(7);
 
-		if (cpu_has_svm()) {
+		if (this_cpu_has(X86_FEATURE_SVM)) {
 			run_guest(svm->vmcb, svm->vmcb_gpa);
 			run_guest(svm->vmcb, svm->vmcb_gpa);
 		} else {
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index 35e96d7a6ba1..d37e25229fe5 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -142,7 +142,7 @@ static void __attribute__((__flatten__)) guest_code(void *arg)
 	GUEST_SYNC(2);
 
 	if (arg) {
-		if (cpu_has_svm())
+		if (this_cpu_has(X86_FEATURE_SVM))
 			svm_l1_guest_code(arg);
 		else
 			vmx_l1_guest_code(arg);
-- 
2.36.1.255.ge46751e96f-goog

