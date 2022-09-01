Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B330B5A9E11
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbiIARdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiIARdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:33:12 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A08694134
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:33:08 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id p18-20020a170902a41200b00172b0dc71e0so12136122plq.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=bQAGklJeyQtfbSP1sQy4j5NLftSXbGdRMGCxjEjeZBE=;
        b=PdkvWuh4lRJLlzLZBbjbzpy37xR6IQu9kwQz7qrAqd239iRTSJWykjxRYMmBimg3/Q
         xa4hrx7YMgkWl3jCAPCOdRSeu0/JVNri+7Acm6pWFis0pIPsjXO8IIk5GsLceQzgNiGH
         SRnMZArYW5WcVrbKZmCy+oXc5zexH/PAbnV8Y28bcsxVy7Wgb8GT93cAZ4+Kkn59cD0t
         +UsGw1gYCbHh6rj+1p2IZyVlNom+ZQuDpfFFWYhmEIM7K7A9tIpJWdQUYxw0rKd+aVRs
         synctq1mDKakYzMMdNZU2QjzenjaxjsnYPIVW33uxBJ/YquqpxS9IK4yoZnwSJZLyfIX
         /Gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=bQAGklJeyQtfbSP1sQy4j5NLftSXbGdRMGCxjEjeZBE=;
        b=EXJXNbaUC2MxIruBOtpfhsO8y8LjYqFXl9zLb0w2a08+E4DwbE61tRC1ntu8JTeUDr
         zvPApXeVs8mdI2uC+kFI3VQaTtXp2UZPrLdSJR07uqUr18F6epmMegVuzfhhn5hQUAy7
         4CeZ5g91ThwpvwCavrdjro8i+apE0Q2lsVHJpqOvDdOt7Py6CM0N54tQyOX+MR2LsG68
         XENkZz1BHpHxxjXM2J5kx+TIZ/kWTX55FMGHVPurSR3kXRlq0HvAGqXfOQI52Gsfgcr1
         h6rw0EVDfrjmKgeQZzi0HFfAe5OWSuRCaS4tbexhD4uDiDcrcaOj2bO//jbGrCiK+lbX
         3b9Q==
X-Gm-Message-State: ACgBeo3myxurAh19IJObbxm/x185SzK2tnhhQMt/X8AFEePnXDPPo/df
        fL5SJKEZEUObdl042ja7oUdqsW/n0Vg=
X-Google-Smtp-Source: AA6agR7I1859m8VZecCthmcgmvZYjzJM9cufmEyvv83W0quJFOCpP/gF1zvOWMDumK4rb5c+eAU4R1rl3t0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:a90:b0:530:2f3c:da43 with SMTP id
 b16-20020a056a000a9000b005302f3cda43mr32164396pfl.50.1662053587846; Thu, 01
 Sep 2022 10:33:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Sep 2022 17:32:57 +0000
In-Reply-To: <20220901173258.925729-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220901173258.925729-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173258.925729-5-seanjc@google.com>
Subject: [PATCH v4 4/5] KVM: VMX: Fold vmx_supported_debugctl() into vcpu_supported_debugctl()
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Like Xu <like.xu.linux@gmail.com>
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

Fold vmx_supported_debugctl() into vcpu_supported_debugctl(), its only
caller.  Setting bits only to clear them a few instructions later is
rather silly, and splitting the logic makes things seem more complicated
than they actually are.

Opportunistically drop DEBUGCTLMSR_LBR_MASK now that there's a single
reference to the pair of bits.  The extra layer of indirection provides
no meaningful value and makes it unnecessarily tedious to understand
what KVM is doing.

No functional change.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/capabilities.h | 15 ---------------
 arch/x86/kvm/vmx/vmx.c          | 12 +++++++-----
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 23dca5ebae16..189a64a6e139 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -24,8 +24,6 @@ extern int __read_mostly pt_mode;
 #define PMU_CAP_FW_WRITES	(1ULL << 13)
 #define PMU_CAP_LBR_FMT		0x3f
 
-#define DEBUGCTLMSR_LBR_MASK		(DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI)
-
 struct nested_vmx_msrs {
 	/*
 	 * We only store the "true" versions of the VMX capability MSRs. We
@@ -403,19 +401,6 @@ static inline bool vmx_pebs_supported(void)
 	return boot_cpu_has(X86_FEATURE_PEBS) && kvm_pmu_cap.pebs_ept;
 }
 
-static inline u64 vmx_supported_debugctl(void)
-{
-	u64 debugctl = 0;
-
-	if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
-		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
-
-	if (vmx_get_perf_capabilities() & PMU_CAP_LBR_FMT)
-		debugctl |= DEBUGCTLMSR_LBR_MASK;
-
-	return debugctl;
-}
-
 static inline bool cpu_has_notify_vmexit(void)
 {
 	return vmcs_config.cpu_based_2nd_exec_ctrl &
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 657fa9908bf9..a5e3c1e6aa2b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2030,13 +2030,15 @@ static u64 nested_vmx_truncate_sysenter_addr(struct kvm_vcpu *vcpu,
 
 static u64 vcpu_supported_debugctl(struct kvm_vcpu *vcpu)
 {
-	u64 debugctl = vmx_supported_debugctl();
+	u64 debugctl = 0;
 
-	if (!intel_pmu_lbr_is_enabled(vcpu))
-		debugctl &= ~DEBUGCTLMSR_LBR_MASK;
+	if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT) &&
+	    guest_cpuid_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
+		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
 
-	if (!guest_cpuid_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
-		debugctl &= ~DEBUGCTLMSR_BUS_LOCK_DETECT;
+	if ((vmx_get_perf_capabilities() & PMU_CAP_LBR_FMT) &&
+	    intel_pmu_lbr_is_enabled(vcpu))
+		debugctl |= DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
 
 	return debugctl;
 }
-- 
2.37.2.789.g6183377224-goog

