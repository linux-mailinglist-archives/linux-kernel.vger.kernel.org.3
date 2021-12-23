Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F03047E983
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 23:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350990AbhLWW1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 17:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350513AbhLWWZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 17:25:49 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852B0C0698C3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:24:29 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id p2-20020a17090a2c4200b001b1866beecbso6392932pjm.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Yr+H8LBjl0djQfSMzX2wORKjmAdREQqaSzyX3BhenYw=;
        b=XmQFD7vyhq5p8trN7cLD10q9mdheW4EOLvr7SHz8EpgoyH6oda/tiRX7ZBVlJwAHwm
         pxx0c47eP51bpRUXyCWELedYY8s3KrRuvX/xhBiZqPIDn05GKwYbUTdvZxtQSRJNcxLN
         kK77GUtf7L3Chh6OYUxSTJBxhHHfyiumxfeqDNePqdI5C0bFRb7f15c2McJzFQ0Fp95K
         3JKbIWhgctO43HlTl2C0ZLUvmH5HJoTdyLkO9imR/gh6Mryu33xmQGLIzCenALuJ2lta
         kskFun16QDJJZ4g8xCW7JLFuo7WuGx2WS5vm87C3T5Hf5RgmmCuvx702nSwCrdp5oCix
         P32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Yr+H8LBjl0djQfSMzX2wORKjmAdREQqaSzyX3BhenYw=;
        b=vJi6tLgdNeG+ra8y9livYflze8KeqitFDdOgoVxYqRPcPivuPtF2obq9TlCcEJ8KKt
         CwrvfVAWd/8eaM5dPRkv8Ymsiz/vJDk2bQnhETol54gwp/zzpyvi90jZQOizlo0dpcoA
         mTgJ3HvvUzsrq+XdG7/xKc4SP+oAG1ZSuoU6x0+6uoP8j2nLlVx3CXmkcIpPlBZJWRui
         RgfOQKlg1jVH3ybL3s8LHL5uBb4v5oX1BCTpnBWtba1JOvu3OGBaHqk1ZJn7ESiDeu5T
         FgVzUPpENsXLTVGUKoT+Bv72eBpH9ZeNsyV+ovlLCaRbR600qcPukGEJy2xf7snWd1Wq
         IWpg==
X-Gm-Message-State: AOAM533+Swo48mkWdA/QDWuAxijgd/Np3WXw6dpPpVQ04LQ/RGWwN/Gj
        +GuZmweAjckFnVRTvipYKZB+65lvdFI=
X-Google-Smtp-Source: ABdhPJwUiLkdbtaG9+zrvhGoVsZmSI+nH0Nx0az82/C5LbcyzQYJaBgH11x2pnQDooEF32SEPCtIuz686jQ=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4a81:: with SMTP id
 lp1mr4969813pjb.19.1640298269028; Thu, 23 Dec 2021 14:24:29 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 23 Dec 2021 22:23:17 +0000
In-Reply-To: <20211223222318.1039223-1-seanjc@google.com>
Message-Id: <20211223222318.1039223-30-seanjc@google.com>
Mime-Version: 1.0
References: <20211223222318.1039223-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2 29/30] KVM: selftests: Define cpu_relax() helpers for s390
 and x86
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu_relax() for s390 and x86 for use in arch-agnostic tests.  arm64
already defines its own version.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/s390x/processor.h  | 8 ++++++++
 tools/testing/selftests/kvm/include/x86_64/processor.h | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/s390x/processor.h b/tools/testing/selftests/kvm/include/s390x/processor.h
index e0e96a5f608c..255c9b990f4c 100644
--- a/tools/testing/selftests/kvm/include/s390x/processor.h
+++ b/tools/testing/selftests/kvm/include/s390x/processor.h
@@ -5,6 +5,8 @@
 #ifndef SELFTEST_KVM_PROCESSOR_H
 #define SELFTEST_KVM_PROCESSOR_H
 
+#include <linux/compiler.h>
+
 /* Bits in the region/segment table entry */
 #define REGION_ENTRY_ORIGIN	~0xfffUL /* region/segment table origin	   */
 #define REGION_ENTRY_PROTECT	0x200	 /* region protection bit	   */
@@ -19,4 +21,10 @@
 #define PAGE_PROTECT	0x200		/* HW read-only bit  */
 #define PAGE_NOEXEC	0x100		/* HW no-execute bit */
 
+/* Is there a portable way to do this? */
+static inline void cpu_relax(void)
+{
+	barrier();
+}
+
 #endif
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 05e65ca1c30c..224574ee9967 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -346,6 +346,11 @@ static inline unsigned long get_xmm(int n)
 	return 0;
 }
 
+static inline void cpu_relax(void)
+{
+	asm volatile("rep; nop" ::: "memory");
+}
+
 bool is_intel_cpu(void);
 
 struct kvm_x86_state;
-- 
2.34.1.448.ga2b2bfdf31-goog

