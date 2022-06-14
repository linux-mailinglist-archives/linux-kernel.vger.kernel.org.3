Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9A954BE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357812AbiFNXF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344435AbiFNXFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:05:53 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03644C79C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:05:52 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id y1-20020a17090a390100b001e66bb0fcefso264577pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=3d7tD77H5O2xlb02j7y43iDUfTOkQ/XeZFOmeDGAico=;
        b=tR5DLGM9/pa1X/VPkRpGjyP5Rnk93Bm7RSfQjLOY2sNbFAo4+DUaz+VhvYZeMv15+l
         ZMimhzuqcXRgXz1jmiLiyGAPdYLgvUT9AZRNWYSojENt4OH8Ir7O8632yquqN7j5OGpF
         UVDHGhnmxG69JwO74Q940WYXAHK52i9UA9N4f7CemEYZ2TWpxckxki/9n5NOaOKItMMO
         Be5B++qiW36YDr3SUpquYrUQwJRG5EUW8QPW/21fca1JPEt2QVlTjuQj8gWTiDoFThPL
         ConxYO/fY73tlZP6GfjZOM2rczcqOMOENFX5uGvuqoA6PVzMLG/3y1Ni9/q5OOXq4bNj
         9cpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=3d7tD77H5O2xlb02j7y43iDUfTOkQ/XeZFOmeDGAico=;
        b=C3YiWJLi+S7CoFi1QOHyvHV+4jVJseFw0lKlJHrKpBuJu4WLquupqPD48XO+VDyVUs
         XK63c7AnPynmMzB3X8HaXK9eaheAsjKfYbGZADYrhSISGn8C7xPiZYxmx6HD4XeLhZ2p
         yF5lYAQO64MNor8hzKEACxcVM5OBaQbjsJVUOxyyFnJYmC6PRbsRou/VhPuB0z5m1OX1
         ttlhpGwQy0TaeaH0QtMzj0FAaWIDonnOMdO0tlr8jftIpfmmPkdw7Jf25wlHb6i0yWyQ
         tsPrgWOLhPDCW4ujDF3NLEoy9KLHoCT1gK/9VUtKTjVw1ImPZTWf5aO3GUT0z9h/GxCb
         045Q==
X-Gm-Message-State: AJIora+i0atxpQNlCdEHyh21KXS7T/cL0GFngoGD9PeFBy40bSBiECsK
        LpEDokNdK8Z/WprnOLa9pY6EXq5bHnA=
X-Google-Smtp-Source: AGRyM1tnSW/muwqIZhXYnOKJRS3lRWAomzqILjlJIGjgy36gfPaXSzFNyMBMb/S1SX6iVfNJDsd8fuf8hhY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:db0a:b0:165:1299:29ea with SMTP id
 m10-20020a170902db0a00b00165129929eamr6314130plx.15.1655247952491; Tue, 14
 Jun 2022 16:05:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 23:05:44 +0000
In-Reply-To: <20220614230548.3852141-1-seanjc@google.com>
Message-Id: <20220614230548.3852141-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220614230548.3852141-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 1/5] KVM: SVM: Drop unused AVIC / kvm_x86_ops declarations
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

Drop a handful of unused AVIC function declarations whose implementations
were removed during the conversion to optional static calls.

No functional change intended.

Fixes: abb6d479e226 ("KVM: x86: make several APIC virtualization callbacks optional")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 128993feb4c6..d51de3c9264a 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -617,12 +617,8 @@ int avic_init_vcpu(struct vcpu_svm *svm);
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void avic_vcpu_put(struct kvm_vcpu *vcpu);
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu);
-void avic_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
 void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu);
 bool avic_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason);
-void avic_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr);
-void avic_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr);
-bool avic_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu);
 int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 			uint32_t guest_irq, bool set);
 void avic_vcpu_blocking(struct kvm_vcpu *vcpu);
-- 
2.36.1.476.g0c4daa206d-goog

