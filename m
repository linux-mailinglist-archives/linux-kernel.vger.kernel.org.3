Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC69E46CA80
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbhLHB6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243313AbhLHB6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:58:36 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46916C061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:55:04 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id t8-20020a63f348000000b0032e1e775705so439265pgj.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 17:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ubKaUKBLNmscD+a3SeZQyfO/SnsUn3R2x3pqUaMRRWU=;
        b=q4lQsDkJTgHl+2yoht+vVP93CTkCaT7wE7IowKnCX3k4dPDPnMAs3X37zJQUbFaU3c
         1iCMHxZl55owo9ie7mhUk9qQ4Zj66LOwfh5wXj/X6YGoHRyUh3f1FK+NwsZTEoCb8V18
         Ov7OSrf1k5AqUoHUra7Wf/g8YNPefJgqWdUUxn9LcyjXh8DYd0GVr2qqfZmhw8Q9kYRR
         GHZOeaWcS3SgKjstJ6jA9kWWfjSMWNzYxuqhaivzcza5fFyKXi+MFSeD1pdyUP0G9ADD
         4aw7KNThSCq4y59OELcH/eh/2XBvXlf7ep28ZCvariMiVZ7oCMqO0am08ZI95LMdoCvb
         uGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ubKaUKBLNmscD+a3SeZQyfO/SnsUn3R2x3pqUaMRRWU=;
        b=AY1XqN/IlXOS8odDD0YEuSxhE2ulUHMPsqNW7ev3YXrGvQZ71F7EYNfAlSU0jixXE5
         S4noAO6OE5wDq0Qi05PZ3zLHdrQMYWx71LhBV/XTfax90b92uSJEiemlhgFonZBUqOz0
         rK8F79PITWR+yDC3i1G0T6HYGX4xRJKMe06Wiut/rTlY/4YvZqGouo4zU7PfBx7ch1RJ
         UnmQqN2ZDN8Yj5NkugJWbm/Qi01imtIbZQZZzas5qxxahIcCluoNs+WEOXCYJG6tnXlq
         MQwp4WbIhik0KA8yZ+rhNpKEWFIk/an6ParYwnMvDVuKemx/bs3+AmucBilDiwRHvurP
         3FJA==
X-Gm-Message-State: AOAM530i8Rlp3xkdIeYssM5pABxjTqJpdE6Q8pTGyST7mY3o0qr++Plw
        GG5HTceT9Se561vIPSG1GoXN7kMfFg8=
X-Google-Smtp-Source: ABdhPJx04oxzGnbwJs3aAuGW/R98Z2oolg+A8xq1n3WCg/qpbISnK5Yk2KiQTm+tvTeNHqYR7nJq0yfT7fY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:9004:0:b0:4a2:e58e:9442 with SMTP id
 m4-20020aa79004000000b004a2e58e9442mr2949977pfo.24.1638928503771; Tue, 07 Dec
 2021 17:55:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  8 Dec 2021 01:52:20 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-11-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 10/26] KVM: SVM: Signal AVIC doorbell iff vCPU is in guest mode
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        kvm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signal the AVIC doorbell iff the vCPU is running in the guest.  If the vCPU
is not IN_GUEST_MODE, it's guaranteed to pick up any pending IRQs on the
next VMRUN, which unconditionally processes the vIRR.

Add comments to document the logic.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index d7132a4551a2..e2e4e9f04458 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -672,9 +672,22 @@ int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
 		return -1;
 
 	kvm_lapic_set_irr(vec, vcpu->arch.apic);
+
+	/*
+	 * Pairs with the smp_mb_*() after setting vcpu->guest_mode in
+	 * vcpu_enter_guest() to ensure the write to the vIRR is ordered before
+	 * the read of guest_mode, which guarantees that either VMRUN will see
+	 * and process the new vIRR entry, or that the below code will signal
+	 * the doorbell if the vCPU is already running in the guest.
+	 */
 	smp_mb__after_atomic();
 
-	if (avic_vcpu_is_running(vcpu)) {
+	/*
+	 * Signal the doorbell to tell hardware to inject the IRQ if the vCPU
+	 * is in the guest.  If the vCPU is not in the guest, hardware will
+	 * automatically process AVIC interrupts at VMRUN.
+	 */
+	if (vcpu->mode == IN_GUEST_MODE) {
 		int cpu = READ_ONCE(vcpu->cpu);
 
 		/*
@@ -688,8 +701,13 @@ int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
 		if (cpu != get_cpu())
 			wrmsrl(SVM_AVIC_DOORBELL, kvm_cpu_get_apicid(cpu));
 		put_cpu();
-	} else
+	} else {
+		/*
+		 * Wake the vCPU if it was blocking.  KVM will then detect the
+		 * pending IRQ when checking if the vCPU has a wake event.
+		 */
 		kvm_vcpu_wake_up(vcpu);
+	}
 
 	return 0;
 }
-- 
2.34.1.400.ga245620fadb-goog

