Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2422654BE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357845AbiFNXGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357981AbiFNXF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:05:57 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AD8532F8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:05:56 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id t11-20020a17090a2f8b00b001ea6a226d21so150637pjd.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=x+rg0+A6Uvzv4O8bM/KpC5UOBIeWkz1gC/gNgA/d0ks=;
        b=XFTfkEarEGnyykkOT0u0agNc/6QpqWNtnqb9/RKSiEtwGP8BKrXAsWy+hU/1yehVXR
         oRtT3j15BCcJBCZ3E9ZvxtyMZ9nx1piGZ72rlxNY3o1llI8eC07PMpkX7IWLYduAxS6i
         9vqGCNOQaM0MXcyIBc+2s1VoJBK/syksHErOrNe1hMnNWilr1qaEMX1bxiQwuOTn129H
         wPXbeKnSJlv+QkPh/vBICpkgIARmLgr7itKtSSTm+7HZvDM6UUxbzYaqQPGt78Z33Olk
         +BAhgpVdLzQG6DBzmMNxPrX/wKOivd0SWleDRfi0MOitmJjxn8my1BMMZlhgRggGufSs
         89Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=x+rg0+A6Uvzv4O8bM/KpC5UOBIeWkz1gC/gNgA/d0ks=;
        b=1hKjrHqKherxUACOUUNmZQzyDEa+XckZFG4WbyN69kwqFRtxzfrsgzqfQw5JFxKaAQ
         fyrFuEQEuH1nZ4UxIYsm/V8/zVAjLMZ0TGGguUItlkwk9GeZoFSufJ+JSx0nwpW6PvgZ
         t/07TmzfKuIJUIdG8ceZ7en0ym5CPPR+EOj67vZ/uTIgx+Y2eptdkcHhbQpLNWGxyrGw
         v5BNJ6Mb6zywIAEjK73xytZzGCVGcTSF2iJW/Mll8LPNxhCALn+BitWgWDwUcLQbgabK
         Zf0uaNIgw4mL0wKrAmtl9lpAXgjZNyqa4cJvHH5O1sd56fwVRdbI//qG78yP1iImgElM
         TQiA==
X-Gm-Message-State: AOAM5336G0Ffxs5FGb0Fd4mXq4Ra76DxAnm7v3Kiv3z8kL22zeqSgp4J
        L3YU2pwdp7oZsJvSY+8x8CbjDEAlYFk=
X-Google-Smtp-Source: ABdhPJy5VbrZHfaAAh6R1wY2dPzoNT6FYr+2b31ONeNPOhZXZdZVHBF4dat+mSDiL0l51ntrw462jxpVsTo=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:be14:0:b0:505:a43b:cf6e with SMTP id
 l20-20020a62be14000000b00505a43bcf6emr7006035pff.33.1655247955887; Tue, 14
 Jun 2022 16:05:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 23:05:46 +0000
In-Reply-To: <20220614230548.3852141-1-seanjc@google.com>
Message-Id: <20220614230548.3852141-4-seanjc@google.com>
Mime-Version: 1.0
References: <20220614230548.3852141-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 3/5] KVM: x86: Check for in-kernel xAPIC when querying APICv
 for directed yield
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_apicv_active() to check if APICv is active when seeing if a
vCPU is a candidate for directed yield due to a pending ACPIv interrupt.
This will allow moving apicv_active into kvm_lapic without introducing a
potential NULL pointer deref (kvm_vcpu_apicv_active() effectively adds a
pre-check on the vCPU having an in-kernel APIC).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2318a99139fa..cd554a62eb0f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12375,7 +12375,8 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 
 bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->arch.apicv_active && static_call(kvm_x86_dy_apicv_has_pending_interrupt)(vcpu))
+	if (kvm_vcpu_apicv_active(vcpu) &&
+	    static_call(kvm_x86_dy_apicv_has_pending_interrupt)(vcpu))
 		return true;
 
 	return false;
-- 
2.36.1.476.g0c4daa206d-goog

