Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D734AA286
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244578AbiBDVnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244869AbiBDVmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:42:43 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1B6C061762
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:42:24 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id u80-20020a627953000000b004c82105f20dso3562458pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 13:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=NkV3Msgch3zFwH89OWlAlvxffB+RDhruYURC7hCf3XE=;
        b=Y/9PcR2wxtQOu8vrJPWbtGwHBJoxjOl0ybS/BDNdEgRXAAcUadz2lhRl4+mrbYu8Cq
         iYrTIUq55RsxkmwX6vHqW+RujwtmEWljWDjPtgnxdlrjxVTnZYmKMEZrOhpctN4jdpS4
         cMZ2IMBM1pHffQGgQh69ajLJZlrT2z1SRXag0OtSxHDXDH8W4eo0rQewi71Hso+oFlRf
         r20xgP7PRdiaDAeuCFWBDxmW/wwGm3seZ6eDfP6RYYG9x9jD4CpBRkfzdP8fcy5ThH5F
         odZCpjmtKlWAT+srUIYofAFvBWtvFlmin1xtRhDJZdwVZ1PWHVswKGjZcZhtcxtrHdKv
         4B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=NkV3Msgch3zFwH89OWlAlvxffB+RDhruYURC7hCf3XE=;
        b=s+V9T07NXGTlTtHN8mQvcj6QfznuMONySSpTFemMzyU3WPLl1gSYITOVPI9fD96XNr
         rXAvmHKtuEHQHefVlChRT7uU9j8c0/Op7dhUTWQBLwso1hdritDG0nUfTj9iiWd0mxc7
         RANhjRJ471AQSxjH+zlFK0eMKyV8pfuJKUCw9uaW+/l3vgPcIe+MWjruUUUtYdDdmlKN
         1aBfU7Kqg3jTPnYEGU5+lehbRz4osxCpyJHRsNYP+uH58VsykbQmr2WOfxbON3jSlb58
         2C5xU8IxRJRRix87eJWy91C8kK3rMXIxdChKM9CIKWdGGu2DpwINzOghhftmGoEV5+08
         x8Pw==
X-Gm-Message-State: AOAM532R58GFvUuOFsSTf9T3atYNkIFWipnhlMFA5hRBUhc5xGlGQbqU
        MtGLI29ACjlLmIHls8E3VbkVf7gwV5w=
X-Google-Smtp-Source: ABdhPJyX6AXK89iDEI3/dyJx0hocA3ZoDVNZsc/XHIavHl7kK1gj+7CoUbQMAG404RCwBFkjlfEyjx/ZgVA=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:7a42:: with SMTP id v63mr4994448pfc.61.1644010944420;
 Fri, 04 Feb 2022 13:42:24 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  4 Feb 2022 21:42:04 +0000
In-Reply-To: <20220204214205.3306634-1-seanjc@google.com>
Message-Id: <20220204214205.3306634-11-seanjc@google.com>
Mime-Version: 1.0
References: <20220204214205.3306634-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 10/11] KVM: x86: Make kvm_lapic_set_reg() a "private" xAPIC helper
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeng Guang <guang.zeng@intel.com>,
        Chao Gao <chao.gao@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hide the lapic's "raw" write helper inside lapic.c to force non-APIC code
to go through proper helpers when modification the vAPIC state.  Keep the
read helper visible to outsiders for now, refactoring KVM to hide it too
is possible, it will just take more work to do so.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 10 ++++++++++
 arch/x86/kvm/lapic.h | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index dd185367a62c..d60eb6251bed 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -68,6 +68,16 @@ static bool lapic_timer_advance_dynamic __read_mostly;
 /* step-by-step approximation to mitigate fluctuation */
 #define LAPIC_TIMER_ADVANCE_ADJUST_STEP 8
 
+static inline void __kvm_lapic_set_reg(char *regs, int reg_off, u32 val)
+{
+	*((u32 *) (regs + reg_off)) = val;
+}
+
+static inline void kvm_lapic_set_reg(struct kvm_lapic *apic, int reg_off, u32 val)
+{
+	__kvm_lapic_set_reg(apic->regs, reg_off, val);
+}
+
 static __always_inline u64 __kvm_lapic_get_reg64(char *regs, int reg)
 {
 	BUILD_BUG_ON(reg != APIC_ICR);
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index e39e7ec5c2b4..4e4f8a22754f 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -161,16 +161,6 @@ static inline u32 kvm_lapic_get_reg(struct kvm_lapic *apic, int reg_off)
 	return __kvm_lapic_get_reg(apic->regs, reg_off);
 }
 
-static inline void __kvm_lapic_set_reg(char *regs, int reg_off, u32 val)
-{
-	*((u32 *) (regs + reg_off)) = val;
-}
-
-static inline void kvm_lapic_set_reg(struct kvm_lapic *apic, int reg_off, u32 val)
-{
-	__kvm_lapic_set_reg(apic->regs, reg_off, val);
-}
-
 DECLARE_STATIC_KEY_FALSE(kvm_has_noapic_vcpu);
 
 static inline bool lapic_in_kernel(struct kvm_vcpu *vcpu)
-- 
2.35.0.263.gb82422642f-goog

