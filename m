Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1E454BC34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358457AbiFNUtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358451AbiFNUs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:48:28 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171832C65D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:48:16 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id bo24-20020a17090b091800b001ea9a916bb7so3934132pjb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=8iOtL/ALJpVJGZjBfeAifxrTvYQ7W61ugeG5Yw7Lub8=;
        b=SePQneirNrbsP48vTbR0RhtjVKyiW8nlVs9B0RTo0fzqdpXKcpFAqkVd6pt7Q6KCvx
         gSlLp7i6ynya4yMF+SSXjoXY8yMqfcAYqcKkawYgrQGfZks5kkoGqP4iq0KeYmrXd/FZ
         k2i8vQmrFNTgfg+Y6rVqYDAL9JV9ByXrq4y9qmPxZVG14I8A8xRW53IwNAiiRnM7Im+D
         Z/rHxU2RmIHpzsRVsMTzT5astVdafanLbDxWFn5k3ptduj9DDNYVx5TPfbf5MsY3KZ5m
         78LM3RuRcShfCxqnCJIEvOG/iCs9a/xT8HMk5CgAtxjPY60DwckbRBqubCTKonkARXDN
         9LDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=8iOtL/ALJpVJGZjBfeAifxrTvYQ7W61ugeG5Yw7Lub8=;
        b=Xi/5xkf2dW3OzgrEPJ/XjteuNzETPkSxcxChUJghTnxxALJz2bqtlQCtOOTmUrpqEz
         +TIh9S8FxWgXgK7UW2HZro0XW05juLPs8P9FGa/B1aTUzoa/ubsqR7dXxfSjn0XNxLG3
         hlW+b1H0CIxR8yGqPmir92slJRqxntsCbqIbIt3HAz5G35Mp2segjdRe7Zyj09jeEEWe
         d95q5NZ2ww9nluukKOZ2UWzO/42iL7PEX7ksspxzlQSvwSUNxFPlN/38dj7n59RZ0d3Y
         l1pn32xWwSocntgG1w89xq0m+KpZJLU5L4o/IIVUT+i2VSuS9oL1xH/xNdpvrsiU6vbW
         kl/g==
X-Gm-Message-State: AJIora/0fPux7ROw5gTiPfVkFpNkqHDwWWyygynZYmsetA7aL2MSiOy5
        lXBX9MlxnH/v+Gd4K5lFmAS/VAL8sPw=
X-Google-Smtp-Source: AGRyM1tHQSYc1ANFNGx+tE/faCX/axU2h/Q4o3YGeJAU7mNFZ+FCpPs974QbabJOO0RC/mDM2sLgcTXhLNI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr194574pje.0.1655239685437; Tue, 14 Jun
 2022 13:48:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 20:47:25 +0000
In-Reply-To: <20220614204730.3359543-1-seanjc@google.com>
Message-Id: <20220614204730.3359543-17-seanjc@google.com>
Mime-Version: 1.0
References: <20220614204730.3359543-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 16/21] KVM: x86: Evaluate ability to inject SMI/NMI/IRQ
 after potential VM-Exit
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
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

Determine whether or not new events can be injected after checking nested
events.  If a VM-Exit occurred during nested event handling, any previous
event that needed re-injection is gone from's KVM perspective; the event
is captured in the vmc*12 VM-Exit information, but doesn't exist in terms
of what needs to be done for entry to L1.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 930de833aa2b..1a301a1730a5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9502,7 +9502,7 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 
 static int inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit)
 {
-	bool can_inject = !kvm_event_needs_reinjection(vcpu);
+	bool can_inject;
 	int r;
 
 	/*
@@ -9567,7 +9567,13 @@ static int inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit)
 	if (r < 0)
 		goto out;
 
-	/* try to inject new event if pending */
+	/*
+	 * New events, other than exceptions, cannot be injected if KVM needs
+	 * to re-inject a previous event.  See above comments on re-injecting
+	 * for why pending exceptions get priority.
+	 */
+	can_inject = !kvm_event_needs_reinjection(vcpu);
+
 	if (vcpu->arch.exception.pending) {
 		/*
 		 * Fault-class exceptions, except #DBs, set RF=1 in the RFLAGS
-- 
2.36.1.476.g0c4daa206d-goog

