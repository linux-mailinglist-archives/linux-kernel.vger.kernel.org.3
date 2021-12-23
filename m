Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1C47E94A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 23:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350413AbhLWWXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 17:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350412AbhLWWXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 17:23:44 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176C0C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:23:44 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id w23-20020a17090a15d700b001b15a89e63fso6400544pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=79VM+FjN4+gNHCbA/cPFX/DKrZdg0OUTgV3ZeDUQV64=;
        b=nlDhfoBF1UMR4zeZ2AMSsTw+2NFav++t76m5v/u01E8WX1IeLkIOgAwZxi4k8dtyD8
         DINKhA/okKbzh3Bl79w0UHPYPe+mI4qQSZBXUA7Q47lwZHbduNO4ktigSHa5Ti2t/EkP
         9kdEt9PUWiSDuPmNi2sOxizUslZ06oNOwgJg5zBRPAZNUhm5xf+Ew1gTWxeKs+A3wRS2
         LDbF9nF0FWwkIu5BMvu+ht6a0imSBbA4HP6uyTQIFXDk/edSQHkFwBMbZFIq4yFBcfyM
         +Jnkd2dtw/HibGSkH9vS+j3S8TWU1rDiX1GYc8Fia1d0AR1CpgvgnpxJMh+NbICv3H0j
         QQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=79VM+FjN4+gNHCbA/cPFX/DKrZdg0OUTgV3ZeDUQV64=;
        b=rUamxjLpqFcFYEcSu72DrgKY1EL9m/l9TzNCLYlnUT/OQZ38wvY6WoSt7BXKMKMJ0p
         PDmw4NVqGdEpCC1QnRB7kQaJkmXu7ScJ25n4fMA6IY84Wr1zQHhKfA5pLRbX1sjCtz91
         x7wvnbSSkNBJK+emjhfobf7CuLCJQidNl+DYwsWfUYiwqK7p8m87JSGUMYp5F7l7Erj2
         bb+qXEeNzuA+9Sjhc0JKGMkAT1/pIeulC1co9HCKHWfo1lzuok0sT3EqGioRHvPh63pA
         /tp8M4in3My1HCLIA3+ixGxzksKHKLTYnz5bDePATg6nraGAcMhwr4FwXhuvSHagdZsX
         PZpA==
X-Gm-Message-State: AOAM5337aBZ7H8rdVbFTTmIRaYPcFbWuYTlw7RDzSPg5mcUgNYUBuRQj
        WiDEW6Q6x+qDCugWXdm6DSycFqFOkno=
X-Google-Smtp-Source: ABdhPJzIg1slQVwWGbXNsGn/iIW/Jo8Ri2O+OYkocHu7aRAWSVbg1N6hanW77pCArB6nbzVf3Peu+sZUvEs=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:fa12:: with SMTP id
 cm18mr4714053pjb.141.1640298223566; Thu, 23 Dec 2021 14:23:43 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 23 Dec 2021 22:22:49 +0000
In-Reply-To: <20211223222318.1039223-1-seanjc@google.com>
Message-Id: <20211223222318.1039223-2-seanjc@google.com>
Mime-Version: 1.0
References: <20211223222318.1039223-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2 01/30] KVM: x86/mmu: Use common TDP MMU zap helper for MMU
 notifier unmap hook
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

Use the common TDP MMU zap helper when handling an MMU notifier unmap
event, the two flows are semantically identical.  Consolidate the code in
preparation for a future bug fix, as both kvm_tdp_mmu_unmap_gfn_range()
and __kvm_tdp_mmu_zap_gfn_range() are guilty of not zapping SPTEs in
invalid roots.

No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7b1bc816b7c3..d320b56d5cd7 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1032,13 +1032,8 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 bool kvm_tdp_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range,
 				 bool flush)
 {
-	struct kvm_mmu_page *root;
-
-	for_each_tdp_mmu_root_yield_safe(kvm, root, range->slot->as_id, false)
-		flush = zap_gfn_range(kvm, root, range->start, range->end,
-				      range->may_block, flush, false);
-
-	return flush;
+	return __kvm_tdp_mmu_zap_gfn_range(kvm, range->slot->as_id, range->start,
+					   range->end, range->may_block, flush);
 }
 
 typedef bool (*tdp_handler_t)(struct kvm *kvm, struct tdp_iter *iter,
-- 
2.34.1.448.ga2b2bfdf31-goog

