Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B68C50C716
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 06:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiDWDv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiDWDvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:51:21 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227CA1C58ED
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:48:25 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 64-20020a630843000000b0039d909676d5so6041435pgi.16
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=nIl4luVOJWFkIclprxcKdIn+QCEjsjA9FteQ7s7ZGic=;
        b=Jks/1SdRI93xyP5uwMJ6C+K0aagltFg0tPscYlPq2RulXCzDR9bwmd/2YFjWammzja
         RnmNJkbEImsLiYjDKXLFudnHmutWlf9LMoek0VRl7qtsD7Dt5gjHzM1GsTD+er3aHqe8
         MyT0brKKquYdYgfR8hs28aTTvGl/5qXrE9GpOB0UIQPx+HdOQFo5cmvsblUiIPmNMR7t
         yGpq5BqTYAM1ST6Nx38oijcHR1KOwDrkNel658nL/5Dp5prtpqXGwrmxWGW78ByFcMxs
         +cDcAPTc7KEyWzhNoETs7kOxhnjOXZE+G8XKpf1xP2kxi+DaHPPwXT03r+cn6ouNMshM
         on1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=nIl4luVOJWFkIclprxcKdIn+QCEjsjA9FteQ7s7ZGic=;
        b=rO8lU07FI3MARFW8ga2ymPS8Lgd/mpWz+MQWfeKXb0jz0IMYYeUaUJkTWpjPJSoQ80
         YG+b/Kkr9RZX9OFPPOnh3RlMh93AFhc+999iWAP86TWGuz80lJm0otO6CCDgCqlXoHvy
         NgsJ9c1jiTkkMo4Frz4ZOyS3gQMjDe/sd+A9mc8AWv5EZK4H8SZGK/6XJfSRSUhg4jaF
         iOqlSqHTvee3Hv2rEvm4pbk0qQquD7qPqHcsRBnzKdxJTfTdCnftcNduIvygRWJKjC+A
         4HafYAAaZ4fNHVBKl713OwgiW1t3rBNcyrOzhLAw044INl7EKo9GUJ4o4pGCfEPWsxa6
         npEg==
X-Gm-Message-State: AOAM530YE5k9Gd6d2IV+axwnKstwE68Ig5TiOU8BZzVqiDHGuNPEP2to
        ffLp7AUBDXDDFNXdR2bNlvx8qIGEVPc=
X-Google-Smtp-Source: ABdhPJz28rMsOFWsoRfGTKdC9uqo+Oi0ikmXtSwLqUR7BvCyXYi01bop8+pSXl7ackmkhJjqc0UalBUIsOE=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:14c4:b0:50a:9524:67bf with SMTP id
 w4-20020a056a0014c400b0050a952467bfmr8129386pfu.55.1650685704656; Fri, 22 Apr
 2022 20:48:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 23 Apr 2022 03:47:48 +0000
In-Reply-To: <20220423034752.1161007-1-seanjc@google.com>
Message-Id: <20220423034752.1161007-9-seanjc@google.com>
Mime-Version: 1.0
References: <20220423034752.1161007-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH 08/12] KVM: x86/mmu: Use IS_ENABLED() to avoid RETPOLINE for
 TDP page faults
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IS_ENABLED() instead of an #ifdef to activate the anti-RETPOLINE fast
path for TDP page faults.  The generated code is identical, and the #ifdef
makes it dangerously difficult to extend the logic (guess who forgot to
add an "else" inside the #ifdef and ran through the page fault handler
twice).

No functional or binary change intented.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu_internal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index c0c85cbfa159..9caa747ee033 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -248,10 +248,10 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		.req_level = PG_LEVEL_4K,
 		.goal_level = PG_LEVEL_4K,
 	};
-#ifdef CONFIG_RETPOLINE
-	if (fault.is_tdp)
+
+	if (IS_ENABLED(CONFIG_RETPOLINE) && fault.is_tdp)
 		return kvm_tdp_page_fault(vcpu, &fault);
-#endif
+
 	return vcpu->arch.mmu->page_fault(vcpu, &fault);
 }
 
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

