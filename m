Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA8347E965
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 23:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350826AbhLWWZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 17:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350653AbhLWWYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 17:24:12 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527A2C0617A1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:24:06 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id w5-20020a17090a380500b001b112521410so4207636pjb.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=S9jL8LBJWDSO1EwBcm6bNP8GuX6QWRTMXtWDTQ0GzAo=;
        b=i1m9kNDo4lVbMKKMJ7noTQCVlV3rFRnpbwW5J7eBAQQPmfGVNRgPfQBPDoRb1Ui5y2
         KYxDCaTU2lwHc08gaE/rqtAxLDrTeqm80ZNH7WvWCMyYs81zGzFgowjDFgmU88xrLgLg
         2Dvm8rQ52rYuwfXnf2c/wiI2pecS49FLZIgoc7FuwdApv+HH4WEuZVLXy4yGgUFhkmu4
         fcYG+xN+po6iQzh/2vHnvyX/C0sYpJhBYfZ/B3szzJakAbN0UAspYVPVp+fnqdqBUxjM
         4RqNPN+GELSi2uwFEnKy0QaqslvNHc+0WxfR5F7DJIsZ83D56N3zXV8wlr149IfrojHr
         x+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=S9jL8LBJWDSO1EwBcm6bNP8GuX6QWRTMXtWDTQ0GzAo=;
        b=Z48LIbTLiN12A5N6G346j1Q1uB8MM1D843+SlQEj6Wg+dLajcgof1khnk4MNYZl6Pz
         83+38mQkmkxL524uPLJo3lHBSYkClJhh/odxJynSo2pe/Snfrn2cni0aX7cP466uXzgh
         dZbeVwMgUu4pCiJLvqIfLCcLl3A6CJTkWIYEqGlmCr4OszjSAM3fVvU0EmlP/d/PsUqI
         2K+NxMcvSCGIp16qwM1BI1cUgd1BYrQO5c1lVP4J4cMGFNKQVtcfI7jBxyXydJYsE4hm
         LliaG/shztEw9EVjCsuvREAKJe6XwCJiuQN87NYpSoJ7Sbe1G8gyvP6Ve9wuOaAl2gmJ
         mkYQ==
X-Gm-Message-State: AOAM531Oc0CM/O4YcNR5bIieFP151TvyiCdntrrnPD6zKVDnF9za4kbZ
        FBUJg9vRy+abUOJzRayiSQjITJZmPpM=
X-Google-Smtp-Source: ABdhPJx4FSrwOTm1Aq60tRpUbAfQrDZRF2v7lCJ9pqZVoyCOxQHrcpb5/oFfRApzth+Q+noEmq2CmgpsFHY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c203:: with SMTP id
 e3mr739899pjt.0.1640298245502; Thu, 23 Dec 2021 14:24:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 23 Dec 2021 22:23:03 +0000
In-Reply-To: <20211223222318.1039223-1-seanjc@google.com>
Message-Id: <20211223222318.1039223-16-seanjc@google.com>
Mime-Version: 1.0
References: <20211223222318.1039223-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2 15/30] KVM: x86/mmu: WARN if old _or_ new SPTE is REMOVED
 in non-atomic path
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

WARN if the new_spte being set by __tdp_mmu_set_spte() is a REMOVED_SPTE,
which is called out by the comment as being disallowed but not actually
checked.  Keep the WARN on the old_spte as well, because overwriting a
REMOVED_SPTE in the non-atomic path is also disallowed (as evidence by
lack of splats with the existing WARN).

Fixes: 08f07c800e9d ("KVM: x86/mmu: Flush TLBs after zap in TDP MMU PF handler")
Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 41c3a1cff3e7..e2d217cbeca3 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -634,13 +634,13 @@ static inline void __tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
 	/*
-	 * No thread should be using this function to set SPTEs to the
+	 * No thread should be using this function to set SPTEs to or from the
 	 * temporary removed SPTE value.
 	 * If operating under the MMU lock in read mode, tdp_mmu_set_spte_atomic
 	 * should be used. If operating under the MMU lock in write mode, the
 	 * use of the removed SPTE should not be necessary.
 	 */
-	WARN_ON(is_removed_spte(iter->old_spte));
+	WARN_ON(is_removed_spte(iter->old_spte) || is_removed_spte(new_spte));
 
 	kvm_tdp_mmu_write_spte(iter->sptep, new_spte);
 
-- 
2.34.1.448.ga2b2bfdf31-goog

