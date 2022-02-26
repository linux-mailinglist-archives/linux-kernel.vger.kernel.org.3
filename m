Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13364C529C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 01:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241196AbiBZASe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 19:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241354AbiBZARy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 19:17:54 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B594A22559E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:50 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id bm16-20020a656e90000000b00372932b1d83so3474383pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=EjwrK4ZJChvc6iOJgG1AWxHnLn4z532gyWXr0rVG/jQ=;
        b=lDvo9S5DXUSc+JKq46AkxVaccqJHq5C6rWdkLNnSG8RB7M0LjPk1aSTbjzHeUBF2SK
         LdC8PARFCyh+yPqzV5tav9taOV6Oxa+HPg0xnKCj8GKro1Ihjk0vStC60ejtziH7Kp22
         hHSwQoe7biVA931GQdyCO+VJFwkH8jxSdWXJcPS3F3/jgFHejbPhBKfjtliBSkBeeDe1
         XTSXxP4elMA42o+QiK1nVBNWnT11jiKN3/lT6obqM9bkRm5JT9VYMLqruY0A9EvvX79K
         jiQkAs77DMMXN1I5PgcKZxVhI/ZWz5mf4sza4V1Bg3oo9vG+KmZ3q66uyPOB4qwbxkLG
         bxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=EjwrK4ZJChvc6iOJgG1AWxHnLn4z532gyWXr0rVG/jQ=;
        b=fathtZhHX+Mt1Ln0EMBagdDMVDymsXglmUPPv9oPs15obD/vq90yiXUCIfcQcEA1ec
         Z2yWQ5UT+GSvGj2WF4q2E96Iwi2MIsIw4HM6xifbEEHmIULndGljH+MGBgOBaFZXJLRr
         eyBe04Z18NwBeuPw6Cr6xL6tYJCqzsIbw8y3aa5h47NXOJ5lSEebHrNpKO31Pxgb54hT
         1IxZCbAz7Tiny3Y63PeshjuaWRXb5omlcby8iUD6ZXhOHUY66nmFo2aLFMwbX+uSqVP7
         oQa0L6cG/djDWOWBuWIA9DvNJgH4wMudq5DQY9dQBosTjKeZtrKUSaDIrBA7Q2VgBIJK
         Pr6Q==
X-Gm-Message-State: AOAM533c8sH58gvQsJ+DoSlm0sfplHXNzpCXsW1vJbzG0yvJfzA9jeN5
        9xwodpGmLt/rb1W0PY+yKS8Fh16hDr4=
X-Google-Smtp-Source: ABdhPJzhwOAheOAxV2q4FzmEjanJlp4ncefsNjpgHyJ+GuhwmxFDKtdwHVUgHSS+KmKk/lVsS3qcCikIfn8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:7f81:b0:1b9:4485:3f01 with SMTP id
 m1-20020a17090a7f8100b001b944853f01mr5573009pjl.120.1645834599991; Fri, 25
 Feb 2022 16:16:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 26 Feb 2022 00:15:41 +0000
In-Reply-To: <20220226001546.360188-1-seanjc@google.com>
Message-Id: <20220226001546.360188-24-seanjc@google.com>
Mime-Version: 1.0
References: <20220226001546.360188-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 23/28] KVM: x86/mmu: Check for a REMOVED leaf SPTE before
 making the SPTE
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
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

Explicitly check for a REMOVED leaf SPTE prior to attempting to map
the final SPTE when handling a TDP MMU fault.  Functionally, this is a
nop as tdp_mmu_set_spte_atomic() will eventually detect the frozen SPTE.
Pre-checking for a REMOVED SPTE is a minor optmization, but the real goal
is to allow tdp_mmu_set_spte_atomic() to have an invariant that the "old"
SPTE is never a REMOVED SPTE.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 4151e61245a7..1acd12bf309f 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1250,7 +1250,11 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		}
 	}
 
-	if (iter.level != fault->goal_level) {
+	/*
+	 * Force the guest to retry the access if the upper level SPTEs aren't
+	 * in place, or if the target leaf SPTE is frozen by another CPU.
+	 */
+	if (iter.level != fault->goal_level || is_removed_spte(iter.old_spte)) {
 		rcu_read_unlock();
 		return RET_PF_RETRY;
 	}
-- 
2.35.1.574.g5d30c73bfb-goog

