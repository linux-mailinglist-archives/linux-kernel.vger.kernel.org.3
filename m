Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C48C4C4DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiBYSXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiBYSXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:23:31 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ED61029E5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:22:58 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id n188-20020a6340c5000000b003747606cb0dso3054220pga.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=yJjWTGvj3xklna+YumgfwjW/70CkdMmVGz7JULQJc9w=;
        b=CQmcUVe96I5qFAe4jXJ6N24Z0ricyasxuL9MqcTlxQ9hAjj2K5BzVagYNRYvvxHXDU
         RHryQu0J0EwAqWcJ6xQ524QpN6qApH6AraFM+RRtmeZ51JPN604CQvnR6RnU5V8Jh4RM
         FtLlQ4SLJCco5XLwRzMTYTp73sE15/eYjZ0uqBkUA3cdFA38FG4iLC+dRoBixOVkjR/t
         kXMeIDO99qxMbkgRdnAVKdYm9kSstrFQbh7UpolsLsBcOZoJCZVAVLJgtUrxKPvSVJJQ
         j9WRUPkxwqU+/YEmmsiWMZQ+lt5O3vitEpjhyqm41PhfcRdodpnz7ihoFJaMS850sNz5
         FGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=yJjWTGvj3xklna+YumgfwjW/70CkdMmVGz7JULQJc9w=;
        b=g9R2nxD+RRCQY8yIDs0kIxYD58JeoqXRsszh5JTrPCeuGlDdt3qCsvEJLPOcsDYSRg
         CMG+T5PoyWnq0VUMbE3Gv5GvmuvPURn/xu3dKDyU4BI6D2PuH9sssYpbgHuJyoyQ4HIT
         IN9eIpTKXh0Oar33i8l+lIx0s0hU9Q9F57WavBwBg1uTPPNdT66+HsmxZPAjMxTQKxmx
         O1ZH3RyCY5dgLquUmSZ4Qsh9oEJ+gb3apXU14KMmUKat4NQlXJVkvV858Am3vq5Sy46S
         qrRRjX1i2FT373o8ab1yAXK4jCxVuN3k10GKRj4q9u9ejezqqbHGeiT6Zkf9jw9Zs5CP
         VPzQ==
X-Gm-Message-State: AOAM532IoP0H9gU0LGBiQw1fZyMRtpur2n13nBc9rY8dCumjrQd4vLDN
        P9VhUVoVFz+RHdKyHKxu2A4p/tt9Lbo=
X-Google-Smtp-Source: ABdhPJwqiIRfaVu24g/26s1NG9RDLXkL5Soz2O1/mDxe1b9k+mFjwrTrkF1v4W13AzJ6xBLpa8bZDPY/cKc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:67c1:b0:1bc:f062:62e8 with SMTP id
 g1-20020a17090a67c100b001bcf06262e8mr3951454pjm.86.1645813378248; Fri, 25 Feb
 2022 10:22:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 25 Feb 2022 18:22:46 +0000
In-Reply-To: <20220225182248.3812651-1-seanjc@google.com>
Message-Id: <20220225182248.3812651-6-seanjc@google.com>
Mime-Version: 1.0
References: <20220225182248.3812651-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 5/7] KVM: s390: Replace KVM_REQ_MMU_RELOAD usage with arch
 specific request
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an arch request, KVM_REQ_REFRESH_GUEST_PREFIX, to deal with guest
prefix changes instead of piggybacking KVM_REQ_MMU_RELOAD.  This will
allow for the removal of the generic KVM_REQ_MMU_RELOAD, which isn't
actually used by generic KVM.

No functional change intended.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/s390/include/asm/kvm_host.h | 2 ++
 arch/s390/kvm/kvm-s390.c         | 8 ++++----
 arch/s390/kvm/kvm-s390.h         | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index a22c9266ea05..766028d54a3e 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -45,6 +45,8 @@
 #define KVM_REQ_START_MIGRATION KVM_ARCH_REQ(3)
 #define KVM_REQ_STOP_MIGRATION  KVM_ARCH_REQ(4)
 #define KVM_REQ_VSIE_RESTART	KVM_ARCH_REQ(5)
+#define KVM_REQ_REFRESH_GUEST_PREFIX	\
+	KVM_ARCH_REQ_FLAGS(6, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 
 #define SIGP_CTRL_C		0x80
 #define SIGP_CTRL_SCN_MASK	0x3f
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 577f1ead6a51..db8c113562cf 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3394,7 +3394,7 @@ static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
 		if (prefix <= end && start <= prefix + 2*PAGE_SIZE - 1) {
 			VCPU_EVENT(vcpu, 2, "gmap notifier for %lx-%lx",
 				   start, end);
-			kvm_s390_sync_request(KVM_REQ_MMU_RELOAD, vcpu);
+			kvm_s390_sync_request(KVM_REQ_REFRESH_GUEST_PREFIX, vcpu);
 		}
 	}
 }
@@ -3796,19 +3796,19 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 	if (!kvm_request_pending(vcpu))
 		return 0;
 	/*
-	 * We use MMU_RELOAD just to re-arm the ipte notifier for the
+	 * If the guest prefix changed, re-arm the ipte notifier for the
 	 * guest prefix page. gmap_mprotect_notify will wait on the ptl lock.
 	 * This ensures that the ipte instruction for this request has
 	 * already finished. We might race against a second unmapper that
 	 * wants to set the blocking bit. Lets just retry the request loop.
 	 */
-	if (kvm_check_request(KVM_REQ_MMU_RELOAD, vcpu)) {
+	if (kvm_check_request(KVM_REQ_REFRESH_GUEST_PREFIX, vcpu)) {
 		int rc;
 		rc = gmap_mprotect_notify(vcpu->arch.gmap,
 					  kvm_s390_get_prefix(vcpu),
 					  PAGE_SIZE * 2, PROT_WRITE);
 		if (rc) {
-			kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
+			kvm_make_request(KVM_REQ_REFRESH_GUEST_PREFIX, vcpu);
 			return rc;
 		}
 		goto retry;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 098831e815e6..45b7c1edd85f 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -105,7 +105,7 @@ static inline void kvm_s390_set_prefix(struct kvm_vcpu *vcpu, u32 prefix)
 		   prefix);
 	vcpu->arch.sie_block->prefix = prefix >> GUEST_PREFIX_SHIFT;
 	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
-	kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
+	kvm_make_request(KVM_REQ_REFRESH_GUEST_PREFIX, vcpu);
 }
 
 static inline u64 kvm_s390_get_base_disp_s(struct kvm_vcpu *vcpu, u8 *ar)
-- 
2.35.1.574.g5d30c73bfb-goog

