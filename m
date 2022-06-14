Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0CD54BB90
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357544AbiFNUIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357153AbiFNUH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:07:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA731EAD2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:07:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 70-20020a250249000000b0065cbf886b23so8510136ybc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=A5Yqv/oATZC7iG9rkjQz5o5BXjSdlLOP6pd+ZfOPJAo=;
        b=AgVOhQGu0SLIY5ajIXV9p1vIDBjR2/ZUJNw+6fyWRAty92D2bTHaQK6z1KolqWCRkU
         WQL/3tX6ShDRgEasqeVc8tGjuRwq8kbQEyTwzx7JfyF7RsZ/TBaixjA4nebXHtaLKPrL
         sdVcYiE7xpsZIOB8DopL+O5Dgw0cDl0rJeWdBmoOdk/k/9FUmmhOZVkYRSfBEKU4DvVX
         cdMMcNvbyi9WYqci05dFIUQJ9cXEpt8yrIRhLtp45mDAkNgniwU422YQCb8UQwK74FKk
         IVdn2Bb6ELAWP61Lk3J5LaeHA0PEPTI+XZAztcGU/gZeQsf2mkhC75YWXnSWHMVJSQFe
         jhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=A5Yqv/oATZC7iG9rkjQz5o5BXjSdlLOP6pd+ZfOPJAo=;
        b=olmNKj1n+hCnOqqxCQH5pyWTAhM0bM7zmw8/WkIMuemsIhWHGMn1exUQ2Jci0JvVvo
         VNxqf8cDyfS9fAXl3ga5evNsqj9uxw3pkdJyNt5PgWJWzS2kGdvKQy1fGXydLx9BrPet
         3IByth+Nnblyab3VMHOnvh/LYzegGQsziJc9iF0PFY3A6DdiZ926qhBL4jtYBtRxjNXP
         iXIr+MEfKDRkOcSkK1IDCIyCD8veWNhQqfTM/IExdZQ6lSuDFeXC3huV80CR0afDb93u
         YtZn1g4hb897jSWENMsig8kJShkejk68CzTLPDbMMv2e5cbCRgGs01SE75QN4Oofx3US
         +/ow==
X-Gm-Message-State: AJIora88m/2pxaFFZiS6h1ntgDHHoospZFhLAnL+aM9KSNNRB+1SFfER
        gL2Oh3qPf3GBuNQwh3eEjvLqGOzWLa8=
X-Google-Smtp-Source: AGRyM1sOeU3iBT+j7fHxZMpCvarktKuhg8iqjlJ/iEqvX51llTGOjwpDec4lLKGXwU7IelXZigbq5n/S3Hc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:ca17:0:b0:664:60ce:9369 with SMTP id
 a23-20020a25ca17000000b0066460ce9369mr6537797ybg.455.1655237259955; Tue, 14
 Jun 2022 13:07:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 20:06:40 +0000
In-Reply-To: <20220614200707.3315957-1-seanjc@google.com>
Message-Id: <20220614200707.3315957-16-seanjc@google.com>
Mime-Version: 1.0
References: <20220614200707.3315957-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 15/42] KVM: selftests: Use kvm_cpu_has() for nSVM soft INT
 injection test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
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

Use kvm_cpu_has() to query for NRIPS support instead of open coding
equivalent functionality using kvm_get_supported_cpuid_entry().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h     | 3 ---
 .../selftests/kvm/x86_64/svm_nested_soft_inject_test.c     | 7 ++-----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index db8d5a2775dd..f5fa7d2e44a6 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -162,9 +162,6 @@ struct kvm_x86_cpu_feature {
 #define CPUID_XSAVE		(1ul << 26)
 #define CPUID_OSXSAVE		(1ul << 27)
 
-/* CPUID.0x8000_000A.EDX */
-#define CPUID_NRIPS		BIT(3)
-
 /* Page table bitfield declarations */
 #define PTE_PRESENT_MASK        BIT_ULL(0)
 #define PTE_WRITABLE_MASK       BIT_ULL(1)
diff --git a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
index 3c21b997fe3a..edf7f2378c76 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
@@ -195,16 +195,13 @@ static void run_test(bool is_nmi)
 
 int main(int argc, char *argv[])
 {
-	struct kvm_cpuid_entry2 *cpuid;
-
 	/* Tell stdout not to buffer its content */
 	setbuf(stdout, NULL);
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
 
-	cpuid = kvm_get_supported_cpuid_entry(0x8000000a);
-	TEST_ASSERT(cpuid->edx & CPUID_NRIPS,
-		    "KVM with nSVM is supposed to unconditionally advertise nRIP Save\n");
+	TEST_ASSERT(kvm_cpu_has(X86_FEATURE_NRIPS),
+		    "KVM with nSVM is supposed to unconditionally advertise nRIP Save");
 
 	atomic_init(&nmi_stage, 0);
 
-- 
2.36.1.476.g0c4daa206d-goog

