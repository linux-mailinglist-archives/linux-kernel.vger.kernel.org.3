Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF89747E956
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 23:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350491AbhLWWYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 17:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350502AbhLWWX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 17:23:58 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F418EC06175D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:23:57 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i12-20020a63584c000000b00330ec6e2c37so3895880pgm.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=sXTDU9i0d/5c6YP+iUCNiapzmeptsQFxGufHlkniv+A=;
        b=hWwrUNLyMCsLs7esrSH4Uv/cisnjMfrQ7QbOy6jMZvgC+LG0MpjKjc/n5GFGqRahrn
         7P8RbCZxBEPh1H1RNawS1jOUYK5xLazCvQanCUMeoZ8LW/7DpM2Nm0riBepm+oiN+8bJ
         ymbXY+PgFD2+eTASw0SfB67DCDtpiexaMQpD/o1xGLF4e7OysdebvZxrsgBfrlUkrJWs
         SthaSgIqFIHpJDRn1QX3qRhgCD9OdWmDJRodMAsyq4KtFkOZ2IYWxsGrwknnjVr4pnF3
         xPfKHm4J4QjcIAzzRitZFD5dp77CpO8MsRpaspmg3geiIOyNJeHSWjqch31+F7XhVes0
         bfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=sXTDU9i0d/5c6YP+iUCNiapzmeptsQFxGufHlkniv+A=;
        b=QgJtnoUE0fLr9HtHJgwYH1KX4vona0GHaKn61YXZX4R/oRZLLHdXGmcFERi/6WVEvm
         bjDKopRBIWYUAfiqMVkbM+0/cD3Nl5pgwmMGmttLZSeRfzymsjeoIsd0DQlLeVKRr97r
         3tNkwakbp0cfz83TQzvuo28JRG/PlGQz7pP16iL80jewT7UJTznA12xQ/APYeypupR0M
         Rw8F1L8/c/TiEpzsXhRGrEgbv9pmr6jX6ORDcp+3M/TroTegCM4PHw3OE/tl8MF5KV+6
         BlyBdLItli6jtFfv88osMBmYAXv0W9UFkEQZ1ZQZogC9KyV116tDrCGNGm0lISL14of8
         eemQ==
X-Gm-Message-State: AOAM532BAW3vszQIBa3l0ioznPHMNtf5asX1e8wtE3y2uGMxOOwaHz3N
        9QaPO/BnxhpqLHOLdO2+BcOmhhM03qo=
X-Google-Smtp-Source: ABdhPJwdb+wvVM4QODThED5gMK8PQcyWym893zTs+D9axal7tJfzv8BBpVNjp58CiBTP6yFsSmfFgqAfQbM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:228b:b0:4bb:1111:65cb with SMTP id
 f11-20020a056a00228b00b004bb111165cbmr4157476pfe.56.1640298237485; Thu, 23
 Dec 2021 14:23:57 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 23 Dec 2021 22:22:58 +0000
In-Reply-To: <20211223222318.1039223-1-seanjc@google.com>
Message-Id: <20211223222318.1039223-11-seanjc@google.com>
Mime-Version: 1.0
References: <20211223222318.1039223-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2 10/30] KVM: x86/mmu: Require mmu_lock be held for write in
 unyielding root iter
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assert that mmu_lock is held for write by users of the yield-unfriendly
TDP iterator.  The nature of a shared walk means that the caller needs to
play nice with other tasks modifying the page tables, which is more or
less the same thing as playing nice with yielding.  Theoretically, KVM
could gain a flow where it could legitimately take mmu_lock for read in
a non-preemptible context, but that's highly unlikely and any such case
should be viewed with a fair amount of scrutiny.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index cd093fa73d14..3b13249bbbe1 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -29,13 +29,16 @@ bool kvm_mmu_init_tdp_mmu(struct kvm *kvm)
 	return true;
 }
 
-static __always_inline void kvm_lockdep_assert_mmu_lock_held(struct kvm *kvm,
+/* Arbitrarily returns true so that this may be used in if statements. */
+static __always_inline bool kvm_lockdep_assert_mmu_lock_held(struct kvm *kvm,
 							     bool shared)
 {
 	if (shared)
 		lockdep_assert_held_read(&kvm->mmu_lock);
 	else
 		lockdep_assert_held_write(&kvm->mmu_lock);
+
+	return true;
 }
 
 void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
@@ -187,11 +190,17 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 #define for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared)		\
 	__for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, ALL_ROOTS)
 
-#define for_each_tdp_mmu_root(_kvm, _root, _as_id)				\
-	list_for_each_entry_rcu(_root, &_kvm->arch.tdp_mmu_roots, link,		\
-				lockdep_is_held_type(&kvm->mmu_lock, 0) ||	\
-				lockdep_is_held(&kvm->arch.tdp_mmu_pages_lock))	\
-		if (kvm_mmu_page_as_id(_root) != _as_id) {		\
+/*
+ * Iterate over all TDP MMU roots.  Requires that mmu_lock be held for write,
+ * the implication being that any flow that holds mmu_lock for read is
+ * inherently yield-friendly and should use the yielf-safe variant above.
+ * Holding mmu_lock for write obviates the need for RCU protection as the list
+ * is guaranteed to be stable.
+ */
+#define for_each_tdp_mmu_root(_kvm, _root, _as_id)			\
+	list_for_each_entry(_root, &_kvm->arch.tdp_mmu_roots, link)	\
+		if (kvm_lockdep_assert_mmu_lock_held(_kvm, false) &&	\
+		    kvm_mmu_page_as_id(_root) != _as_id) {		\
 		} else
 
 static union kvm_mmu_page_role page_role_for_level(struct kvm_vcpu *vcpu,
-- 
2.34.1.448.ga2b2bfdf31-goog

