Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D46453D45F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350361AbiFDBYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350117AbiFDBWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:22:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1F49FE3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:21:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30047b94aa8so80842897b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=btNvlb67FRxWt/N67wV+X94puj6fGYAVKhOck9gaL8c=;
        b=UoZ9ymY2moYpaQqxy6WubTCRdWEX2xixmR8oQSY4AqGmDeWP4/+I+T6JpT6ipzLDsO
         wdCZaDORvp8L3ZjxLvRqgMLuN8TbMiooku04mdVeJJHZnHrr1btqJkM8k5PCw1+o48z0
         pgLqk4mKiP6Isk4r1wcgStzGCsf5lWXePtf7Ry4+w8CdOWtkrwA9IPnEyFgus9xsW3ET
         3cuzVwdtz0/NWd9Cwtppm+bwzsLMrcwGmOK8C0Ku5D6oextdHvADZevlEczm9dT6RjZJ
         1mnalkxuKQpHXrbtJ5ISVKM94DgipYYVw1BRbRF63ONqp14thgQhtMQsqV9oTOfIHvY9
         lI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=btNvlb67FRxWt/N67wV+X94puj6fGYAVKhOck9gaL8c=;
        b=OquaaP133ZwJt6ou3sq5LwwSLj+AToCelQgfgehrN8cayarxGEQ7j7rlCl3EmVgxX7
         JXMNuFY8wSYhm2tSsHI3AoHMObv75pA1CbxhBsK4e1eHNJ3QmpCOwLU5T35fS4OeOEMr
         GjuThzy2KcIAFUj8HnzZkT8Dxt6LAJZzNciKW3CvjiK6YBDoeKjgHrPxys5PYT4xNGya
         tnID+0VjHbLI7IONJoP9xXWAw0gDeixMNd84+UCYr8l0fMAy1LH+nzD+YIeiVzcEN4Mx
         Lh0rBVYoMieS2bUEFZ/QWisb9jTjgdIl4eNZM6XbogjhCtSZmipNTBvGBCaIwGZVVg1D
         hZgw==
X-Gm-Message-State: AOAM5317YGjGtHhl3eztjcifFnalbWsMJlyabOFfgmkTkAlsRrJvAk5r
        IER8ne7MuC+Q/DbcseDGkUb4Ggtzdek=
X-Google-Smtp-Source: ABdhPJyKYMvagsyZ+ivnLnJrKpiQpTQSkMagnJr59o8ovG/QztKDoBUD4k9HVwRH1Sue7MCmWfLPdrZNvv8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a81:3a93:0:b0:2ff:a0f1:53fe with SMTP id
 h141-20020a813a93000000b002ffa0f153femr14287013ywa.352.1654305717259; Fri, 03
 Jun 2022 18:21:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Jun 2022 01:20:48 +0000
In-Reply-To: <20220604012058.1972195-1-seanjc@google.com>
Message-Id: <20220604012058.1972195-33-seanjc@google.com>
Mime-Version: 1.0
References: <20220604012058.1972195-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 32/42] KVM: selftests: Add this_cpu_has() to query
 X86_FEATURE_* via cpuid()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
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

Add this_cpu_has() to query an X86_FEATURE_* via cpuid(), i.e. to query a
feature from L1 (or L2) guest code.  Arbitrarily select the AMX test to
be the first user.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/x86_64/processor.h | 12 +++++++++++-
 tools/testing/selftests/kvm/x86_64/amx_test.c        |  9 ++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index eb4730bf4e77..d79060f55307 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -159,7 +159,6 @@ struct kvm_x86_cpu_feature {
 #define X86_FEATURE_KVM_MIGRATION_CONTROL	KVM_X86_CPU_FEATURE(0x40000001, 0, EAX, 17)
 
 /* CPUID.1.ECX */
-#define CPUID_XSAVE		(1ul << 26)
 #define CPUID_OSXSAVE		(1ul << 27)
 
 /* Page table bitfield declarations */
@@ -425,6 +424,17 @@ static inline void cpuid(uint32_t function,
 	return __cpuid(function, 0, eax, ebx, ecx, edx);
 }
 
+static inline bool this_cpu_has(struct kvm_x86_cpu_feature feature)
+{
+	uint32_t gprs[4];
+
+	__cpuid(feature.function, feature.index,
+		&gprs[KVM_CPUID_EAX], &gprs[KVM_CPUID_EBX],
+		&gprs[KVM_CPUID_ECX], &gprs[KVM_CPUID_EDX]);
+
+	return gprs[feature.reg] & BIT(feature.bit);
+}
+
 #define SET_XMM(__var, __xmm) \
 	asm volatile("movq %0, %%"#__xmm : : "r"(__var) : #__xmm)
 
diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 866a42d07d75..a886c9e81b87 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -120,13 +120,8 @@ static inline void __xsavec(struct xsave_data *data, uint64_t rfbm)
 
 static inline void check_cpuid_xsave(void)
 {
-	uint32_t eax, ebx, ecx, edx;
-
-	cpuid(1, &eax, &ebx, &ecx, &edx);
-	if (!(ecx & CPUID_XSAVE))
-		GUEST_ASSERT(!"cpuid: no CPU xsave support!");
-	if (!(ecx & CPUID_OSXSAVE))
-		GUEST_ASSERT(!"cpuid: no OS xsave support!");
+	GUEST_ASSERT(this_cpu_has(X86_FEATURE_XSAVE));
+	GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));
 }
 
 static bool check_xsave_supports_xtile(void)
-- 
2.36.1.255.ge46751e96f-goog

