Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10946CA96
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243510AbhLHB7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243343AbhLHB6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:58:51 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD18C061D7E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:55:17 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id d2-20020a656202000000b00325603f7d0bso432927pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 17:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=iR5gsD/RoTX7Ab+ckhbUw8O3OI7/VYiJinLA00sLWPI=;
        b=WNsSNhrKWtiZPTt79yrGjP2QXJ/zO4dHXmq3vDHqWoxkLtAw17Zd8KscsmjJ5oexGb
         kAliVyZsQqhQdPrNDF3PQfsQUXNjABbMqKTfY/BVR8fXS8Rneja+8reFa1F4jOY/pcwE
         ciNn2DfNsN5BCZfZNfVggHMXqCUKq8favBTGeLtEPSZW/WIq7X2hNEVmhRguMWaIdO9s
         syVWjmq8jby34MQJXy+NvG7hmIQPQQK0w5i4VP2C4a8r84Dfz7Xux7plAzDVBCSdKRWp
         IY0wZ1LxRDp71LCRqLSV6xYBQgPTInG/LmrBIv48mELobkYVfcjaB7HqC1PidJ96oxdN
         9/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=iR5gsD/RoTX7Ab+ckhbUw8O3OI7/VYiJinLA00sLWPI=;
        b=nW/BiJYVfnMzgyauiYDNMoMfj9Sju6fWwqcobg1SN5mY5XJEOwOUjIAP0ykwPga7uD
         LheIB9AyuQJxZttuY+CLH98YO3oiLfe6cAzgolwMcQni6aw9mY12anXlYhWuSjSxYlGP
         WDMAQq0aZO5Seno4gYK4WG8ls3Y8M5TLwm6Qoi4+wpEkEg8YS/MEgxeI9l50LT9WMWwE
         AM0jVxVs7G4Ox+acgEeMdnzX8h2CQqXTdBVQj9FVHPQVIfMAVHAlnyY+bi5V9tPs4iTh
         6Gvsv46vT/lmaRnbxe0SCLjfZo/xohK/zBveGapIfFExEk5YGykkO0SabhmbywGRWADv
         aL8g==
X-Gm-Message-State: AOAM530xx+M/TIzafW+5afYW1UIUN7NHr+1D0Lc4i7Bm+xcPIRrPkopV
        AnGx67oPaYAZjMVpYRCSszwrgJjkYGs=
X-Google-Smtp-Source: ABdhPJwcoBXXZdmSOghfbE08/EmszWpxoDmbsXidfNKiYXB2oVUXH7tNkAdX5obuN8xCpGSVDdPKRG2yOvc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:1913:: with SMTP id
 19mr3513966pjg.174.1638928516567; Tue, 07 Dec 2021 17:55:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  8 Dec 2021 01:52:28 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-19-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 18/26] KVM: VMX: Pass desired vector instead of bool for
 triggering posted IRQ
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

Refactor the posted interrupt helper to take the desired notification
vector instead of a bool so that the callers are self-documenting.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0eac98589472..ff309ebe9f2c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3890,11 +3890,9 @@ static void vmx_msr_filter_changed(struct kvm_vcpu *vcpu)
 }
 
 static inline bool kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu,
-						     bool nested)
+						     int pi_vec)
 {
 #ifdef CONFIG_SMP
-	int pi_vec = nested ? POSTED_INTR_NESTED_VECTOR : POSTED_INTR_VECTOR;
-
 	if (vcpu->mode == IN_GUEST_MODE) {
 		/*
 		 * The vector of interrupt to be delivered to vcpu had
@@ -3955,7 +3953,7 @@ static int vmx_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
 		smp_mb__after_atomic();
 
 		/* the PIR and ON have been set by L1. */
-		if (!kvm_vcpu_trigger_posted_interrupt(vcpu, true))
+		if (!kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_NESTED_VECTOR))
 			kvm_vcpu_wake_up(vcpu);
 		return 0;
 	}
@@ -3993,7 +3991,7 @@ static int vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
 	 * guaranteed to see PID.ON=1 and sync the PIR to IRR if triggering a
 	 * posted interrupt "fails" because vcpu->mode != IN_GUEST_MODE.
 	 */
-	if (!kvm_vcpu_trigger_posted_interrupt(vcpu, false))
+	if (!kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_VECTOR))
 		kvm_vcpu_wake_up(vcpu);
 
 	return 0;
-- 
2.34.1.400.ga245620fadb-goog

