Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA2154BB31
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357978AbiFNUKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357577AbiFNUJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:09:09 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD7B4F452
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:08:16 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id c4-20020a170902d48400b001640bfb2b4fso5328237plg.20
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=4mAB76+I05WmZi+6YBbeLTbS4pzwCUEDOF/e/K6fR38=;
        b=BKqFVQj/ojsssYjh5WI51oMSrT0pRP/P38wzQsQVhxLze0+KuZcL91yBZ/NsVnJIk+
         67C/OCnj2rZW1JEM2ONXM4Eutq+Tptm/mrF9is+LKeJqpDGZwakgiCSFd+PFDLcx6MqZ
         2v7qhbTX2XYNm0O4LCJP+UyfMyknn7Tat87VQMi7oVDznpIpTF3TUTMCK9+GiCJStyfO
         o9BVlcpe3lrcUph8ciwVsmacSiS61h9ZZUaQ0cf4LOIOVqi4f4FRYGjwyrrtrydOwASu
         L4HTAK+Gusd4Yg59tf5DytWEyX7X4dnTrFtRyMrGCZpXRAbyDQV/kw6KYiYvFGczPaz9
         orJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=4mAB76+I05WmZi+6YBbeLTbS4pzwCUEDOF/e/K6fR38=;
        b=pNywPH76L7zTHGKCDoiWoE1SToGwFXxIUCcQZ1U4AvesY771hn4jEBC/1O67FALp92
         JQuw95plm8ojXiA9yDDFQZEXKl00GQhHKQwUasBPJnVapSiHJ2pt61kVnCobdrUKpM2J
         t8hj3ZIyzoZmH5vLUA8F+xgWtTyYw4dkf6zp/9i5UP+B1z3nSh2vvpksPsfMVuc0iq0c
         if2QT5+3tbF+uxmcMJDQKsKDmTOzprENKrNPkZQO5mMlbAMm7B209NSFYYfq29o/XZ+q
         BHe4sdy2uV5Nu5xFR3CZAwV1Xo/nOj4Sdwc8BnVXSyCW2aH3b0SxxEqpOF/CwkkMvueG
         7Y5w==
X-Gm-Message-State: AOAM530h9XIf2fuvT4PsJkjsnaLlwraQ4Xu93lwUhpIsOMxI9YpxWx/G
        7doUlK4xavlVuVCwFsToXKM4f/ahQ+8=
X-Google-Smtp-Source: ABdhPJwLiFRNhyIb9FkHjj5TKdIOPnnGCc1Ubp8Aaww8I0LviFsV6ZedkJd8Hpv0I0Ijc32w2ZpfL8NQzl8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:483:0:b0:3fc:9128:60a5 with SMTP id
 125-20020a630483000000b003fc912860a5mr6021762pge.606.1655237290104; Tue, 14
 Jun 2022 13:08:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 20:06:57 +0000
In-Reply-To: <20220614200707.3315957-1-seanjc@google.com>
Message-Id: <20220614200707.3315957-33-seanjc@google.com>
Mime-Version: 1.0
References: <20220614200707.3315957-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 32/42] KVM: selftests: Add this_cpu_has() to query
 X86_FEATURE_* via cpuid()
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

Add this_cpu_has() to query an X86_FEATURE_* via cpuid(), i.e. to query a
feature from L1 (or L2) guest code.  Arbitrarily select the AMX test to
be the first user.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/x86_64/processor.h | 12 +++++++++++-
 tools/testing/selftests/kvm/x86_64/amx_test.c        |  9 ++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index ed148607a813..be2ce21926db 100644
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
2.36.1.476.g0c4daa206d-goog

