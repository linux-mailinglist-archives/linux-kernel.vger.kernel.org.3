Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE79475067
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbhLOBQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbhLOBQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:16:04 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0852C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:16:03 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id j3-20020a634a43000000b00325af3ab5f0so11386182pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=m3pdJNN2ApABsoVFkg1ykwG9Oj4ulKzgpsDHr8kyrrY=;
        b=L5BbSWKiVd2735pgzeasX0nTw2agKc63YxrQEyh+3I/HWcxcT67nW2DEkuIxq/RieA
         AfFVgxBrPoP5zaON+zuwoYd73RyK+pqF45PdpHoRzGBm6YaCwDPbr0ks9Rqu4rpIf40K
         so/tGqcLTkqITreEwzP3w6QvSijUq5u6I2pLFtCRbQ3MB+3ASbm/ZoThC5dNQjan5INP
         FmaUljw9qqgSH8Q7N6trrbRaSwGFqSfxdK4KG55+3HLRv/Lm3n7zg8ujsJChxxvufwLR
         ujP5NJReisgZ/L4k80STRI4yBcOeIvqzfSXa7POzIVkisZ2yPj8xEuLVfxgJUTxzar6G
         BmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=m3pdJNN2ApABsoVFkg1ykwG9Oj4ulKzgpsDHr8kyrrY=;
        b=cL2yMxg2LpcqeohcEA9ZMfOd7Rw5aXcSopJOGLaul4cO/oK0xE1FaHJNpPq37dgKl0
         m4zeZ0lRGYJmgv1nFSrZMqugJm/Pl8SIewpjtmPjzIHXY5izy3YpjBEct1EKCDQu1dYg
         skVfOYEzuylc/2J0Nx/H7WM2EQVoLBtrEhLAkTlwm2Lho4dLCERF+aOBhK4Jb9kEPUvV
         5qmICHuxECBWLdmfPFmV01qgNb+EX3q+U2QnlKbOOrc3++WKjc27B/xq0cw4een5fMRf
         ze+nx3DhU66GY1aYcSCMFBiauvHLKnIKF//ZSctetezCNoCI8u6hu85oOQ552CCLPMvP
         vkSg==
X-Gm-Message-State: AOAM533+nMj2N3Yplmi8ImqUQbYmBo7Q5Ya6i1l2wFcpxCBQMH6Qtc5t
        r9bw3RQrd4SzItwrx8AS5ucQuRrwRw8=
X-Google-Smtp-Source: ABdhPJy7bignk9Q/sZyaM8jpslPC7vlLmVaTSsizBvdqAKnMm0Bmb23qPYX1nAkmPUeEJVar88C+vePwTnc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:c3cb:b0:148:a3ca:2d79 with SMTP id
 j11-20020a170902c3cb00b00148a3ca2d79mr1972193plj.82.1639530963145; Tue, 14
 Dec 2021 17:16:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 15 Dec 2021 01:15:55 +0000
In-Reply-To: <20211215011557.399940-1-seanjc@google.com>
Message-Id: <20211215011557.399940-3-seanjc@google.com>
Mime-Version: 1.0
References: <20211215011557.399940-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 2/4] KVM: x86/mmu: Move "invalid" check out of kvm_tdp_mmu_get_root()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the check for an invalid root out of kvm_tdp_mmu_get_root() and into
the one place it actually matters, tdp_mmu_next_root(), as the other user
already has an implicit validity check.  A future bug fix will need to
get references to invalid roots to honor mmu_notifier requests; there's
no point in forcing what will be a common path to open code getting a
reference to a root.

No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 12 ++++++++++--
 arch/x86/kvm/mmu/tdp_mmu.h |  3 ---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index d320b56d5cd7..200001190fcf 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -121,9 +121,14 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 		next_root = list_first_or_null_rcu(&kvm->arch.tdp_mmu_roots,
 						   typeof(*next_root), link);
 
-	while (next_root && !kvm_tdp_mmu_get_root(kvm, next_root))
+	while (next_root) {
+		if (!next_root->role.invalid &&
+		    kvm_tdp_mmu_get_root(kvm, next_root))
+			break;
+
 		next_root = list_next_or_null_rcu(&kvm->arch.tdp_mmu_roots,
 				&next_root->link, typeof(*next_root), link);
+	}
 
 	rcu_read_unlock();
 
@@ -200,7 +205,10 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
 
 	role = page_role_for_level(vcpu, vcpu->arch.mmu->shadow_root_level);
 
-	/* Check for an existing root before allocating a new one. */
+	/*
+	 * Check for an existing root before allocating a new one.  Note, the
+	 * role check prevents consuming an invalid root.
+	 */
 	for_each_tdp_mmu_root(kvm, root, kvm_mmu_role_as_id(role)) {
 		if (root->role.word == role.word &&
 		    kvm_tdp_mmu_get_root(kvm, root))
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index 3899004a5d91..08c917511fed 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -10,9 +10,6 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu);
 __must_check static inline bool kvm_tdp_mmu_get_root(struct kvm *kvm,
 						     struct kvm_mmu_page *root)
 {
-	if (root->role.invalid)
-		return false;
-
 	return refcount_inc_not_zero(&root->tdp_mmu_root_count);
 }
 
-- 
2.34.1.173.g76aa8bc2d0-goog

