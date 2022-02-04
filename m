Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB1A4AA27D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244224AbiBDVmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244203AbiBDVmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:42:35 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0A2C061759
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:42:21 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id z12-20020a17090a1fcc00b001b63e477f9fso4283334pjz.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 13:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=YoWYGJfioQ0uIXd5+Rw6SEDFktlGss0k/yZ4iiWeiEU=;
        b=ZOLIb3xRq1ZobBOGfSnhbYAZw1vO2h0qbhMx22jtc4XVM8r2Frq/WmbJMtoIKIDMG+
         uCsz+8PNekCH12cdRQ0bYmGKxxqdLLX0fsStT9g8tAixTUwNEXPWBZuHpxe7fWfzlSA8
         Q1upmQglx0GAtVJX2pFBPwThCqItzoY4lyvtqOQty6U0YpTvmv6FHAEHpJrw2uLnYAz9
         WPvBeCP+qvSd4VuvNKpqNx6VJemx/Vszv2ebbmnhNLkXCVZU7GqFJitLYRzGMfyNn8Px
         FdkLhcMpSLIXYewx3zcGrJQda/9mC6pZoD2YkiLq/r7E+wN4xSFPx0W5dwVqwBDrtO9S
         3Lzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=YoWYGJfioQ0uIXd5+Rw6SEDFktlGss0k/yZ4iiWeiEU=;
        b=kr80eY3S3o3ABohrzRJRYs3Mf2YfHlIcmqtBwL5uz+wu6VZJrnKq9wPywHZriqRKQq
         jdPWYXjF//IK+E7WW89x4A8CizDCalbusOn5AouswlUtgGmWfpHg6slGrob1e5epGmw3
         yRT9uxM/3Tox+ky7yhwJXU4uNHzxQfT7DT6PBeV3JTnDPwbGNdi9RK+0uSwHZvmuFEjq
         4lQeEj5HqtON376dxVER2MQAv3iChXx8qjSbH+upZG1OIBISm+I5KfoMBlKnrYtUbg99
         WIB/vc/i+cE6YhZ0CU9tzozhMh+ol+74MWiC79OvCr9EWeSXn8Sr1K1DExOjq5b7OMhP
         HbCg==
X-Gm-Message-State: AOAM532mEaFBbLRyjdIna+WvsKIyEGV/F2L1kD2uoh/jepatkrONZR6k
        6/9NNVKv/R7GpdbWMB+dVNwcr19uXjk=
X-Google-Smtp-Source: ABdhPJyWg23tc+Cb4uAt5KO7qiovKm6IvOy/ybeDEnFCEzw2igAjUj1nSqnUdSmqWaKzntfhE3sgGcfmS2g=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:22ce:: with SMTP id
 f14mr4975621pfj.60.1644010941067; Fri, 04 Feb 2022 13:42:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  4 Feb 2022 21:42:02 +0000
In-Reply-To: <20220204214205.3306634-1-seanjc@google.com>
Message-Id: <20220204214205.3306634-9-seanjc@google.com>
Mime-Version: 1.0
References: <20220204214205.3306634-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 08/11] KVM: x86: Add helpers to handle 64-bit APIC MSR read/writes
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

Add helpers to handle 64-bit APIC read/writes via MSRs to deduplicate the
x2APIC and Hyper-V code needed to service reads/writes to ICR.  Future
support for IPI virtualization will add yet another path where KVM must
handle 64-bit APIC MSR reads/write (to ICR).

Opportunistically fix the comment in the write path; ICR2 holds the
destination (if there's no shorthand), not the vector.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 59 ++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index deac73ce2de5..f72f3043134e 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2782,6 +2782,30 @@ int kvm_lapic_set_vapic_addr(struct kvm_vcpu *vcpu, gpa_t vapic_addr)
 	return 0;
 }
 
+static int kvm_lapic_msr_read(struct kvm_lapic *apic, u32 reg, u64 *data)
+{
+	u32 low, high = 0;
+
+	if (kvm_lapic_reg_read(apic, reg, 4, &low))
+		return 1;
+
+	if (reg == APIC_ICR &&
+	    WARN_ON_ONCE(kvm_lapic_reg_read(apic, APIC_ICR2, 4, &high)))
+		return 1;
+
+	*data = (((u64)high) << 32) | low;
+
+	return 0;
+}
+
+static int kvm_lapic_msr_write(struct kvm_lapic *apic, u32 reg, u64 data)
+{
+	/* For 64-bit ICR writes, set ICR2 (dest) before ICR (command). */
+	if (reg == APIC_ICR)
+		kvm_lapic_reg_write(apic, APIC_ICR2, (u32)(data >> 32));
+	return kvm_lapic_reg_write(apic, reg, (u32)data);
+}
+
 int kvm_x2apic_msr_write(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
@@ -2793,16 +2817,13 @@ int kvm_x2apic_msr_write(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 	if (reg == APIC_ICR2)
 		return 1;
 
-	/* if this is ICR write vector before command */
-	if (reg == APIC_ICR)
-		kvm_lapic_reg_write(apic, APIC_ICR2, (u32)(data >> 32));
-	return kvm_lapic_reg_write(apic, reg, (u32)data);
+	return kvm_lapic_msr_write(apic, reg, data);
 }
 
 int kvm_x2apic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
-	u32 reg = (msr - APIC_BASE_MSR) << 4, low, high = 0;
+	u32 reg = (msr - APIC_BASE_MSR) << 4;
 
 	if (!lapic_in_kernel(vcpu) || !apic_x2apic_mode(apic))
 		return 1;
@@ -2810,45 +2831,23 @@ int kvm_x2apic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 	if (reg == APIC_DFR || reg == APIC_ICR2)
 		return 1;
 
-	if (kvm_lapic_reg_read(apic, reg, 4, &low))
-		return 1;
-	if (reg == APIC_ICR)
-		kvm_lapic_reg_read(apic, APIC_ICR2, 4, &high);
-
-	*data = (((u64)high) << 32) | low;
-
-	return 0;
+	return kvm_lapic_msr_read(apic, reg, data);
 }
 
 int kvm_hv_vapic_msr_write(struct kvm_vcpu *vcpu, u32 reg, u64 data)
 {
-	struct kvm_lapic *apic = vcpu->arch.apic;
-
 	if (!lapic_in_kernel(vcpu))
 		return 1;
 
-	/* if this is ICR write vector before command */
-	if (reg == APIC_ICR)
-		kvm_lapic_reg_write(apic, APIC_ICR2, (u32)(data >> 32));
-	return kvm_lapic_reg_write(apic, reg, (u32)data);
+	return kvm_lapic_msr_write(vcpu->arch.apic, reg, data);
 }
 
 int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 reg, u64 *data)
 {
-	struct kvm_lapic *apic = vcpu->arch.apic;
-	u32 low, high = 0;
-
 	if (!lapic_in_kernel(vcpu))
 		return 1;
 
-	if (kvm_lapic_reg_read(apic, reg, 4, &low))
-		return 1;
-	if (reg == APIC_ICR)
-		kvm_lapic_reg_read(apic, APIC_ICR2, 4, &high);
-
-	*data = (((u64)high) << 32) | low;
-
-	return 0;
+	return kvm_lapic_msr_read(vcpu->arch.apic, reg, data);
 }
 
 int kvm_lapic_set_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len)
-- 
2.35.0.263.gb82422642f-goog

