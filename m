Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF344C4D97
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiBYSXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiBYSX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:23:27 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48555F1EB1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:22:54 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id a12-20020a65640c000000b003756296df5cso3044781pgv.19
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=VKMBlWNx4jK1iDVhpsaRZcvzkSOAxKFhhP9NDDoxkLA=;
        b=Fdd0ugG9W3f4EJeeUYsCgb8W9Ynd5MF6AKEcW9LnQwoRU3YEau0D2ZwFmpoNIOuvd1
         J6HppSKpX/QYcTmEka6QjbKpAhYpeQgkge2amIHPVjFS9MehVv+XZZd30rcmdCiItSeY
         0l6W7scfFbqHQAkX4U1MAUk+AlREKywJdodZSG3B2SIZQTZmBi9wJiPUXWioIjh7j1ya
         JnMh5Rv9Ap/QzJQDQXG1x8HwsQ92lTRv/4ln8Vo1StPl4s4CSvXq3bZmdHl7jANIHTPt
         MgOgzVCSzc4MgjTWgS8zkx+e8N0Wo/mApBy98n4knaA8odwbLo7GDc3PWVYrNry/ub6K
         cg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=VKMBlWNx4jK1iDVhpsaRZcvzkSOAxKFhhP9NDDoxkLA=;
        b=f0tdVP1c5p5SHelKJCG/pZYTVCXFZbpZfAzz/bnFYLT+WxKWhUa27+3w1fRwnfaASB
         8nLOxv7jF99dOlEf60Ly8497XfwllexW4ysxC5Fk/V6q9jRKgMEGjBv8Hi4fN652z0lH
         +uKYS4HJwDJdtPGud1VzXijjkz0JlttAhaiIn7FKF3bvgN2vJXTNYs8iFvH5bx01iiEe
         UAn6qynU/vLi0bL5lbxgY5k/THq7uxUdXSJijUPAfsMgxPd405zHflPwKZHl5ha9nqmP
         ZIhF/GiE7iKSDMreAgcEvjnEA1grOG7yhpp+ZPK1XQJBlulBKiaf/fGs0SqMcpXVqtRT
         2OmQ==
X-Gm-Message-State: AOAM533XxKYgKMYRDmNXzFc8OgY51xa5BPnfbeXnKOjWErWL5DuGkHJL
        2zQHpGPTxb2AOKMveo7H43zF8zcABOk=
X-Google-Smtp-Source: ABdhPJxoyxmqX3mxfoFgGAjyblYLJ3fu4AUs1RNVx87TMDdvK+Ro/2u7tKzWPg4caY5UCaJlP+QbMSmje30=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4f43:b0:1bc:7e5c:e024 with SMTP id
 pj3-20020a17090b4f4300b001bc7e5ce024mr26606pjb.0.1645813373353; Fri, 25 Feb
 2022 10:22:53 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 25 Feb 2022 18:22:43 +0000
In-Reply-To: <20220225182248.3812651-1-seanjc@google.com>
Message-Id: <20220225182248.3812651-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220225182248.3812651-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 2/7] KVM: x86: Invoke kvm_mmu_unload() directly on
 CR4.PCIDE change
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a KVM_REQ_MMU_RELOAD request with a direct kvm_mmu_unload() call
when the guest's CR4.PCIDE changes.  This will allow tweaking the logic
of KVM_REQ_MMU_RELOAD to free only obsolete/invalid roots, which is the
historical intent of KVM_REQ_MMU_RELOAD.  The recent PCIDE behavior is
the only user of KVM_REQ_MMU_RELOAD that doesn't mark affected roots as
obsolete, needs to unconditionally unload the entire MMU, _and_ affects
only the current vCPU.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2157284d05b0..579b26ffc124 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1077,7 +1077,7 @@ void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned lon
 	 */
 	if (!tdp_enabled &&
 	    (cr4 & X86_CR4_PCIDE) && !(old_cr4 & X86_CR4_PCIDE))
-		kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
+		kvm_mmu_unload(vcpu);
 
 	/*
 	 * The TLB has to be flushed for all PCIDs if any of the following
-- 
2.35.1.574.g5d30c73bfb-goog

