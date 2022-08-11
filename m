Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405405907CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiHKVGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbiHKVGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42A758A6F4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660251972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4RKOyHsKBxxvzJ9NkJFblXxDl280JutW3/L7Ar2PgqY=;
        b=FmNKG2FDAm2OXSscExLG0MKvXduxa72x6EtaMD0H5IeeX3jhUsOBYQCdAbMni0I3wCMsgC
        ZEvk8iIO7Ozrd8afZGeWwSPU1v/0pxRenWAzLeGTP9x4Xzzih+PBFkuakAmgaENmadQC3m
        HztWJsMDmJ4phEIyATbsCwvodos9BwY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-92xKdmgLNcSAg3dlDrfPcQ-1; Thu, 11 Aug 2022 17:06:06 -0400
X-MC-Unique: 92xKdmgLNcSAg3dlDrfPcQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74064943211;
        Thu, 11 Aug 2022 21:06:06 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DD74492C3B;
        Thu, 11 Aug 2022 21:06:06 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com, mlevitsk@redhat.com, vkuznets@redhat.com
Subject: [PATCH v2 1/9] KVM: x86: check validity of argument to KVM_SET_MP_STATE
Date:   Thu, 11 Aug 2022 17:05:57 -0400
Message-Id: <20220811210605.402337-2-pbonzini@redhat.com>
In-Reply-To: <20220811210605.402337-1-pbonzini@redhat.com>
References: <20220811210605.402337-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An invalid argument to KVM_SET_MP_STATE has no effect other than making the
vCPU fail to run at the next KVM_RUN.  Since it is extremely unlikely that
any userspace is relying on it, fail with -EINVAL just like for other
architectures.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 132d662d9713..c44348bb6ef2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10653,7 +10653,8 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
 	case KVM_MP_STATE_INIT_RECEIVED:
 		break;
 	default:
-		return -EINTR;
+		WARN_ON(1);
+		break;
 	}
 	return 1;
 }
@@ -11094,9 +11095,22 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 
 	vcpu_load(vcpu);
 
-	if (!lapic_in_kernel(vcpu) &&
-	    mp_state->mp_state != KVM_MP_STATE_RUNNABLE)
+	switch (mp_state->mp_state) {
+	case KVM_MP_STATE_UNINITIALIZED:
+	case KVM_MP_STATE_HALTED:
+	case KVM_MP_STATE_AP_RESET_HOLD:
+	case KVM_MP_STATE_INIT_RECEIVED:
+	case KVM_MP_STATE_SIPI_RECEIVED:
+		if (!lapic_in_kernel(vcpu))
+			goto out;
+		break;
+
+	case KVM_MP_STATE_RUNNABLE:
+		break;
+
+	default:
 		goto out;
+	}
 
 	/*
 	 * KVM_MP_STATE_INIT_RECEIVED means the processor is in
-- 
2.31.1


