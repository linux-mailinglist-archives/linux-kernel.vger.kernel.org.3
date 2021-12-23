Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772C847E96E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 23:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbhLWWZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 17:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350728AbhLWWY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 17:24:26 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B201C0613A1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:24:11 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i203-20020a2554d4000000b0060a529902b3so3024381ybb.21
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=hi15fkGhTPSKWg6xnBWyGTdHInFiOYLMR2QZxH+BCyM=;
        b=tV8xL3tDgDWPtfKAnLLJ9aMprxvrR8pzIXGPXy65phS75CA+Zasdrj0BFZdR+hrAmp
         6qrsRJJoKEHZih5zMkJ8pMmdZtylmwvntAWefZogtB7YNZ00Aq5RT5hD/LB8LqFObeIU
         clcsY749fZf2Az67uWjoklCNEoXdL7WAO3pRiXSHe1L9kWTDz+ggbRbzHt4ipBdioI4G
         a7yJS+nlQYOo+Gvbmn3ZEYoLnwr0xB1XZ8VlNlcNuggHArJZy0j2V3xKhYFIGZbNaPkK
         g0sppACPwYYiVxnBwDuymuIbszW3wz7f61hooKdRHLCcYFWgaoaLWv/bw8aLkvbPT/eF
         4W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=hi15fkGhTPSKWg6xnBWyGTdHInFiOYLMR2QZxH+BCyM=;
        b=x5KMKJ9+g11arzTInuw1vwOP7gt6xFUEgcJieILy+5WZ9VMYfU2I32/eEow3AIUlEa
         HPorE3sAel+qH7r3kfBcMnF92jvLiDppsRF+cTRQB+8W8Thrz5wTwF320ZaSUbN1ZFVI
         GHCWac2GARNniwHL5p2DB89sPjpmXRsS+87uzO4Qhld/TpNaMhl4vJ4CZN63/NB5n407
         wlkY2/aCQj3EqIYh22wF1MPY+YkxyHhTjcz1XUHwMAuC8qiTcGs5fhDN1ZlBHst5pl8Y
         ARYSIUuytNno099r6zD6mq/18wocXyVKKXfIaD8IrIYqqFV5mMl2Sg11hkMUVh00VRrv
         lCvA==
X-Gm-Message-State: AOAM530ssoZ4iwxH5B1/mF345AVxKU93UysyjkKhg/VJKdGqaomEuHVu
        pg4fmVlEBWPi8w0EzWpahGOWGSxQqb0=
X-Google-Smtp-Source: ABdhPJz7aPgmvGfRlYLct3l0udDKcXntDEZJSyDbK0UMyC+yQCMJ/vgjWw6/jUNmPpbrxEbhTjlkQc0soPY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:d4c:: with SMTP id 73mr5728847ybn.74.1640298250584;
 Thu, 23 Dec 2021 14:24:10 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 23 Dec 2021 22:23:06 +0000
In-Reply-To: <20211223222318.1039223-1-seanjc@google.com>
Message-Id: <20211223222318.1039223-19-seanjc@google.com>
Mime-Version: 1.0
References: <20211223222318.1039223-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2 18/30] KVM: x86/mmu: Skip remote TLB flush when zapping all
 of TDP MMU
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

Don't flush the TLBs when zapping all TDP MMU pages, as the only time KVM
uses the slow version of "zap everything" is when the VM is being
destroyed or the owning mm has exited.  In either case, KVM_RUN is
unreachable for the VM, i.e. the guest TLB entries cannot be consumed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index d23c2d42ad60..e9232ef2194e 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -871,14 +871,15 @@ bool __kvm_tdp_mmu_zap_gfn_range(struct kvm *kvm, int as_id, gfn_t start,
 
 void kvm_tdp_mmu_zap_all(struct kvm *kvm)
 {
-	bool flush = false;
 	int i;
 
+	/*
+	 * A TLB flush is unnecessary, KVM zaps everything if and only the VM
+	 * is being destroyed or the userspace VMM has exited.  In both cases,
+	 * KVM_RUN is unreachable, i.e. no vCPUs will ever service the request.
+	 */
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
-		flush = kvm_tdp_mmu_zap_gfn_range(kvm, i, 0, -1ull, flush);
-
-	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+		(void)kvm_tdp_mmu_zap_gfn_range(kvm, i, 0, -1ull, false);
 }
 
 /*
-- 
2.34.1.448.ga2b2bfdf31-goog

