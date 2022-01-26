Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B4E49D0A1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243681AbiAZRWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243389AbiAZRWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:22:31 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D60EC061747
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:22:31 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t1-20020a6564c1000000b002e7f31cf59fso3655pgv.14
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=hYkVO2zJzU2HKUMXt251ttMPqrTue4mNO9B/E0HGAbg=;
        b=OjY6MPIlgT0AvmSHHDBloZJBFvlFEKIWxr2OvfHrgXZbPGrycPSLeZMq4mJalcQOUZ
         K71/SK+FnRwXgWkdTM7HgU6QwtQGjV5CVFfuSLufhVPFuFezTvFXV3R0V66RSFyVq2IL
         /S5jErs66iRJQ3aC/l88OO8qDNi3CznZ/A6ixWZnBVhwwllNk093ROnzuWES+pCWOdS/
         rtwEo4Vw7SfgyCqWVGvX6v3riOp8jXZNjVjXXdCaZ6AYrvIaxmFt8rCFnd+GbsXWhlWW
         dj0i2RYXMjhccuUAEBsL8S2j9y0GknB9A1Wwid+Nk0Z2gJqu5Obb/1+RLtQqnw6Od0t9
         MoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=hYkVO2zJzU2HKUMXt251ttMPqrTue4mNO9B/E0HGAbg=;
        b=Yb141RwKWoQi4ezBawab86feXyYsXAH1WdCcrHatmOXVC0bgsPNVZvL5CTZWFIjTnc
         BXcI9BZwqPqkZF8X85ODxrBfJDyu6X4bXOnnSH9pRcb9C60LD2IDjxkuhy8dK6hRtSCx
         YQmsd9BLBoUe97p1HMdsKndtfW9cl8jUOCGyuPqCyWW5H+vfsfWfqVKPTbJvFHbbvM7s
         6s8lt5wmPEKpsfC/zl1McR1EBivoHsNJTgMY8fOadTd9GSBQPPaHQhE4kcwK0sTKjE2B
         yqzIPTUD/YDIOcwwA4KawFz/giHBgmNIj+2+xs3OClvMv6w5gome8nJYzGlqMxM423dP
         6Lkw==
X-Gm-Message-State: AOAM533k4zbZf0RIB0DpfQE9inKW/GyaJZ9bILWelWTgAqwJTTzFZWeb
        Z01WlTZt+a6f6o7+t8tO3h+ekaRrkME=
X-Google-Smtp-Source: ABdhPJw0188OAd8XljfhkMfGIKE1QqhuMGNscBIv46I2kuXJQFG2tcnycEPD8yPR4qv6STPCmLyzT4b0OL4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:7001:b0:14a:9ab0:5d03 with SMTP id
 y1-20020a170902700100b0014a9ab05d03mr23674349plk.128.1643217750744; Wed, 26
 Jan 2022 09:22:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 26 Jan 2022 17:22:24 +0000
In-Reply-To: <20220126172226.2298529-1-seanjc@google.com>
Message-Id: <20220126172226.2298529-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220126172226.2298529-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 1/3] KVM: x86: Keep MSR_IA32_XSS unchanged for INIT
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoyao Li <xiaoyao.li@intel.com>

It has been corrected from SDM version 075 that MSR_IA32_XSS is reset to
zero on Power up and Reset but keeps unchanged on INIT.

Fixes: a554d207dc46 ("KVM: X86: Processor States following Reset or INIT")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 55518b7d3b96..c0727939684e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11257,6 +11257,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 		vcpu->arch.msr_misc_features_enables = 0;
 
 		vcpu->arch.xcr0 = XFEATURE_MASK_FP;
+		vcpu->arch.ia32_xss = 0;
 	}
 
 	/* All GPRs except RDX (handled below) are zeroed on RESET/INIT. */
@@ -11273,8 +11274,6 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	cpuid_0x1 = kvm_find_cpuid_entry(vcpu, 1, 0);
 	kvm_rdx_write(vcpu, cpuid_0x1 ? cpuid_0x1->eax : 0x600);
 
-	vcpu->arch.ia32_xss = 0;
-
 	static_call(kvm_x86_vcpu_reset)(vcpu, init_event);
 
 	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
-- 
2.35.0.rc0.227.g00780c9af4-goog

