Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108FB54BE20
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358371AbiFNXGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240980AbiFNXGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:06:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181F55372A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:06:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q199-20020a25d9d0000000b00664af83bee9so6910832ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=H1M2DYWsU+c15TLt1rKOqiFcg/EmzWXN7tpVE5HWvKo=;
        b=hnm/tdKp9LufbwDqkyMs0iWVJf+Gw8tXJ3WDXdLICoF74ya747HGVKeg04szV2++GJ
         Bnf/AfSd/48fnuZpiS1m2wnOxdIjjrHs09jRAvNicZxLIXQtmfySs4uKTaK8o2rwOan+
         ds2Prcxy00KS3z6hMAwmUw+GW5KGMI/gsSmhp+XRisrqsRigiGOStyjlIGU/nRF1gHGh
         r9UTxBOOfCmUHeVNGFCm/i0Q9f9joIb2YgvEM5OSJsgh0G+fg88TVOx4lE+ODStf9LY9
         PNph9y63sNqjDEmh33o419vilVnuolLcf3u3rKe2nOC3uxIw5C6hTwHM1xhEC0jELNdr
         KiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=H1M2DYWsU+c15TLt1rKOqiFcg/EmzWXN7tpVE5HWvKo=;
        b=O3qNZklUPK+f0FFQ5KpI37VilDPCnj8Icl0P+E3Qxc5SViDZK+6Pxa3uXeKfn7jNN3
         laq1WpCx1hxGit7ihPLF3NL+0u7GRT/4+WvqZfFVeoGjY3+1K2rj6Ow41VxoG7YQDj27
         OyfHLOXMSgeRFDXbZ2MSg6++q9U5TOGJ2NI7CGftrqeE5qrQUuQKe93NMBw+ioa4pCJz
         GFb88CSVBVA/St7Gc7jNvg7+HXt7z58qZ6J1YOm2z1ewk7tXsMNFZU0IWXcg2X5b39ic
         c0PYBpEnVVk/emICeCF2tY8vO3+gHupDsX1aTSbeMMj8dPz9giyJKqFs3zqIN4TUiFej
         3Xvw==
X-Gm-Message-State: AJIora+/+BT53YfHagFOHLlcFL/S1t1OOe/m7NecDZtLcbCWCk0FxOZu
        GDAzqEaYbrNt3zeh07GdHUr6RAj7cJQ=
X-Google-Smtp-Source: AGRyM1uf72yhsevkLoSbOoEFneoBn6zDkIxHTWYSbWOkx+hZlvZNe06qxNyNzgTjR5AQlVipmTyw8USIA68=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:3bd0:0:b0:664:2ec8:34c0 with SMTP id
 i199-20020a253bd0000000b006642ec834c0mr7448093yba.405.1655247959351; Tue, 14
 Jun 2022 16:05:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 23:05:48 +0000
In-Reply-To: <20220614230548.3852141-1-seanjc@google.com>
Message-Id: <20220614230548.3852141-6-seanjc@google.com>
Mime-Version: 1.0
References: <20220614230548.3852141-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 5/5] KVM: x86: Use lapic_in_kernel() to query in-kernel APIC
 in APICv helper
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use lapic_in_kernel() in kvm_vcpu_apicv_active() to take advantage of the
kvm_has_noapic_vcpu static branch.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index e09ad97f3250..6207b64b1281 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -205,7 +205,7 @@ static inline int apic_x2apic_mode(struct kvm_lapic *apic)
 
 static inline bool kvm_vcpu_apicv_active(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.apic && vcpu->arch.apic->apicv_active;
+	return lapic_in_kernel(vcpu) && vcpu->arch.apic->apicv_active;
 }
 
 static inline bool kvm_apic_has_events(struct kvm_vcpu *vcpu)
-- 
2.36.1.476.g0c4daa206d-goog

