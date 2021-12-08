Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E75946CA86
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243520AbhLHB6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243363AbhLHB6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:58:37 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C07C061B38
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:55:05 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id e10-20020a17090301ca00b00141fbe2569dso268682plh.14
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 17:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=sWS8lI0gUmOyHyHSjJQNlBlA+evEhEXiCmD7ctQTR2I=;
        b=IGqaujrdw3pJA8/VhNCiiJK2demMr9npnPg8OO94u4zJussXfBB3Cqu07hb5L7vmoo
         /c6MfWai3Vea5erWwSXjPyme/mdg306Z4WzeqPKrZhYYQBJGzaKAveodHtgEkT8tGWUZ
         PcpS5xXAqfMzOfKNtBI5GkB/zi4X5qcK3VVJcB7cjBoby9q8TRWgFnv/iAXQVa0SD/En
         CozCyLTvHHATnEtLUrsJYhslqGc5KRzmC/q9aBARyhCobQnFyxrw8rUgkz6UAiq3kgzx
         Taw5NHJldSf8XzoSB8uGZbZbfhVVGSr8PCF//rfTWwBTVMqeUGHKmFD1J+qhibeA4Ou/
         sLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=sWS8lI0gUmOyHyHSjJQNlBlA+evEhEXiCmD7ctQTR2I=;
        b=TZPp7H3e2emq8WBfrKmst8R6yK77JgHa7z+vphPJfh1PO6oSVAFd6CwHridpdmp7sJ
         Bt9YT+KkUjoERezoyfzyo+e10XXl5P1ZPPipEstxD6ZrIozY9MU66X02yaRoJT9OLYww
         BbJ6P/9nZo6mg0Z+rvl3dnH0abkxqQLiumBvNiceyQg/y+hVv5jHtG32mpYy81jT97S2
         mUgub/+BHzszaBeRf648Y6DB7wuEZUfF46IajAhGNqWWuvf85rBiq0b0z9lFf1E9wT9a
         r39Twkzvi+77UZ39LPgMs5MaokTVLq4dvX4jD0DnyWNEs4L7Azwe0LFC0ODsBz2qQWop
         dWKw==
X-Gm-Message-State: AOAM530utCbB9j5NUOp4TIoRYkHJxK/TjQpabeLjI7VogffMDLalcBPc
        lwnzTWI4OoQh58AiWbEtDSmY+Pe6jjE=
X-Google-Smtp-Source: ABdhPJzthhrK0JA6NDs214v10Pktv2tAPLKbFKJ7sATCDbyBlSHPGWuwB1tBteo7rjgt3jNfMh86Ubp8Krc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:a0b:: with SMTP id 11mr27831511pgk.282.1638928505499;
 Tue, 07 Dec 2021 17:55:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  8 Dec 2021 01:52:21 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-12-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 11/26] KVM: SVM: Don't bother checking for "running" AVIC
 when kicking for IPIs
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

Drop the avic_vcpu_is_running() check when waking vCPUs in response to a
VM-Exit due to incomplete IPI delivery.  The check isn't wrong per se, but
it's not 100% accurate in the sense that it doesn't guarantee that the vCPU
was one of the vCPUs that didn't receive the IPI.

The check isn't required for correctness as blocking == !running in this
context.

From a performance perspective, waking a live task is not expensive as the
only moderately costly operation is a locked operation to temporarily
disable preemption.  And if that is indeed a performance issue,
kvm_vcpu_is_blocking() would be a better check than poking into the AVIC.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/avic.c | 15 +++++++++------
 arch/x86/kvm/svm/svm.h  | 11 -----------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index e2e4e9f04458..37575b71cdf3 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -295,13 +295,16 @@ static void avic_kick_target_vcpus(struct kvm *kvm, struct kvm_lapic *source,
 	struct kvm_vcpu *vcpu;
 	unsigned long i;
 
+	/*
+	 * Wake any target vCPUs that are blocking, i.e. waiting for a wake
+	 * event.  There's no need to signal doorbells, as hardware has handled
+	 * vCPUs that were in guest at the time of the IPI, and vCPUs that have
+	 * since entered the guest will have processed pending IRQs at VMRUN.
+	 */
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		bool m = kvm_apic_match_dest(vcpu, source,
-					     icrl & APIC_SHORT_MASK,
-					     GET_APIC_DEST_FIELD(icrh),
-					     icrl & APIC_DEST_MASK);
-
-		if (m && !avic_vcpu_is_running(vcpu))
+		if (kvm_apic_match_dest(vcpu, source, icrl & APIC_SHORT_MASK,
+					GET_APIC_DEST_FIELD(icrh),
+					icrl & APIC_DEST_MASK))
 			kvm_vcpu_wake_up(vcpu);
 	}
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 9f153c59f2c8..ca51d6dfc8e6 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -574,17 +574,6 @@ extern struct kvm_x86_nested_ops svm_nested_ops;
 
 #define VMCB_AVIC_APIC_BAR_MASK		0xFFFFFFFFFF000ULL
 
-static inline bool avic_vcpu_is_running(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm = to_svm(vcpu);
-	u64 *entry = svm->avic_physical_id_cache;
-
-	if (!entry)
-		return false;
-
-	return (READ_ONCE(*entry) & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
-}
-
 int avic_ga_log_notifier(u32 ga_tag);
 void avic_vm_destroy(struct kvm *kvm);
 int avic_vm_init(struct kvm *kvm);
-- 
2.34.1.400.ga245620fadb-goog

