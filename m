Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C291576A0E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiGOWmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 18:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiGOWme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:42:34 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640873AE69
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:42:34 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q8-20020a17090a304800b001ef82a71a9eso3596738pjl.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=2EOUrVvpusq8aFHkobTg35RLb5YlrRiK5e+AovV9uRY=;
        b=DBMG2tVVToR634Cbm4cNiOI6RU44rkVrgJxbcFv0PwLbVI1V3+1tGvicUjzL5Zi/eS
         2nXnHlOlqe0d89jIh/5QfTzmrqtZvNGk27YJ/rAalpWjPbPrdO2ZsIUqeLnSJ+A5wMHw
         Cw5bBWdEhgL0EiDyUjdi1BDU8IsaYuHRLM5PUn0KCuibnE822twZo7rkattUNb2f1C6P
         1EDOT2L31E98uxBAOZOWYhM2i5KHz1uzHI/wrmf54s98ypmO01s8N1uyczz3r+qlivgk
         yeOdbay6Fcv38i7DVmsB01j1KPF3OvwE6KVy/4NHWdfjs0kScJI+DMl0wOTR+7rH6xYe
         xeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=2EOUrVvpusq8aFHkobTg35RLb5YlrRiK5e+AovV9uRY=;
        b=G7LcVAPLSbWXBU68KzbM7k0G3LNLcFftRiq5Aujbp1zgF9DIPmn7x4ojV24T/wVzAS
         Q6rWGvdOlix24BA0dMRQN9cQ2A/IIOdH0J/Y9B+uO7XWGd+eBC7rPLmm8/iJFnUPb/px
         NwHAa4MODL80t08hh0TicSsD2NAeorE4wuapdnppuDCfphOiMotnCd/iU+fSr5tL+InH
         s/Qt49bF2SYd2qwk68LUVRi0yDdbsOEhMZR8UkMt6Gi038OnzJxC8OkdoQp8PujJJ9L8
         fq767gXNOFCcxQt/zuzF+vLzk7EgDM/AsYsLuiGf8VS5KqrC//RceZ12PagocAaskZ4J
         iuxw==
X-Gm-Message-State: AJIora/cyZJIYiX/FAaep76HH2n/vppTNz5qDN2ANl9MXB6YwnQYl6SI
        MAxKcQaBLq45BTw6DfwmoATt/WNlDCM=
X-Google-Smtp-Source: AGRyM1ul1DgpT0D5GgbHAeklVzBIohIF0xi85u1+B9OZlhGe27Pg6wzpDLguO/kSiMYVx7aaNQ5sM8aYzd0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr912649pje.0.1657924953367; Fri, 15 Jul
 2022 15:42:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Jul 2022 22:42:20 +0000
In-Reply-To: <20220715224226.3749507-1-seanjc@google.com>
Message-Id: <20220715224226.3749507-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220715224226.3749507-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v2 1/7] KVM: x86/mmu: Return a u64 (the old SPTE) from mmu_spte_clear_track_bits()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return a u64, not an int, from mmu_spte_clear_track_bits().  The return
value is the old SPTE value, which is very much a 64-bit value.  The sole
caller that consumes the return value, drop_spte(), already uses a u64.
The only reason that truncating the SPTE value is not problematic is
because drop_spte() only queries the shadow-present bit, which is in the
lower 32 bits.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 52664c3caaab..b2379ede2ed6 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -529,7 +529,7 @@ static bool mmu_spte_update(u64 *sptep, u64 new_spte)
  * state bits, it is used to clear the last level sptep.
  * Returns the old PTE.
  */
-static int mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
+static u64 mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
 {
 	kvm_pfn_t pfn;
 	u64 old_spte = *sptep;
-- 
2.37.0.170.g444d1eabd0-goog

