Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC55A7214
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiH3X4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiH3Xz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:55:56 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533CE5A167
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:55:48 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id y9-20020a17090322c900b00174c881abaeso4548952plg.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=dW3v8nB6rc55x7pB4U5xsxMaQfNaI01R1eoBhCvYIrI=;
        b=rB5o95pn0R9HwtJdKuLSb27vhuSQuA2+gy5rIyhHwvrMhA+Ny5z+qBQ66sXAbq3w5o
         Rku2zKHhxrQhRsgkvKBzwPbHXYLbI6MSQCk72a/Qm6SYfLdHhdztGeKLowZ4b8cvqgSw
         Bd4fmllHd5n3ayZM5Mq9I9CX9p8B3wD/gac7gbEqU7UrjKg6fnZpxw4NIw7jjC/je+Zq
         irzaINF6nP6JZleLJdYTUvg0NL6LgSTaA9cZ7vV9RoosGLZN0+QeYKOHS0TKCA5H+MVG
         tQD2qDarGnbMtEl2MSORgWmFRMxa6g1vKY6H5LEi2kjlcmncnc8FOrt5w1Q382SqghJQ
         SoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=dW3v8nB6rc55x7pB4U5xsxMaQfNaI01R1eoBhCvYIrI=;
        b=EiFGi0ON4c+gDNmrSmHyMvJSi/oVAHDGwlhf9ZG5pknG11tx7SVExTfT7HmyN/efPf
         ooPzUuugYYrAKoBed3N5XYgEwh2oQu8xUvJhmUZq/X72tzvbyrjqQ+AITUvxT/A0eJZX
         RblpLOprRpZ2QLrCJf6kGVDRClh2+4hhSaDwNgGW+Lljr/K3eAksAtvklrt3CpWXVOcT
         +JnevkddydbZmrBhydDsG6fu5T0k90x5fNLW7419trr8EW72sgN2KaQmQ3ouSAfsfSKP
         shMTwt9++LQOkGLdzre6NBhr4Y7pFvAslboZ8Q1metWeA/UOnRDx1tS6KVYXOz372gcG
         3rBw==
X-Gm-Message-State: ACgBeo2BRXVay48uZqxwN9RiauP9pLmZe9mJXvVAtjMtdYKGRO7TkDWn
        3b8Dg03ZQQgox4s7TjKUmPGZfeDeKbE=
X-Google-Smtp-Source: AA6agR4ROM8mxlz/MLLrkmUlD65Ei6K1cq7X2/ast/Mc3yX2lMU40jjXsqWJkg61bd5HrphHm2EWvxJrK9k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1384:b0:538:73c5:91ff with SMTP id
 t4-20020a056a00138400b0053873c591ffmr7841260pfg.54.1661903746666; Tue, 30 Aug
 2022 16:55:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 30 Aug 2022 23:55:32 +0000
In-Reply-To: <20220830235537.4004585-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220830235537.4004585-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830235537.4004585-5-seanjc@google.com>
Subject: [PATCH v4 4/9] KVM: x86/mmu: Properly account NX huge page workaround
 for nonpaging MMUs
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Ben Gardon <bgardon@google.com>
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

Account and track NX huge pages for nonpaging MMUs so that a future
enhancement to precisely check if a shadow page can't be replaced by a NX
huge page doesn't get false positives.  Without correct tracking, KVM can
get stuck in a loop if an instruction is fetching and writing data on the
same huge page, e.g. KVM installs a small executable page on the fetch
fault, replaces it with an NX huge page on the write fault, and faults
again on the fetch.

Alternatively, and perhaps ideally, KVM would simply not enforce the
workaround for nonpaging MMUs.  The guest has no page tables to abuse
and KVM is guaranteed to switch to a different MMU on CR0.PG being
toggled so there's no security or performance concerns.  However, getting
make_spte() to play nice now and in the future is unnecessarily complex.

In the current code base, make_spte() can enforce the mitigation if TDP
is enabled or the MMU is indirect, but make_spte() may not always have a
vCPU/MMU to work with, e.g. if KVM were to support in-line huge page
promotion when disabling dirty logging.

Without a vCPU/MMU, KVM could either pass in the correct information
and/or derive it from the shadow page, but the former is ugly and the
latter subtly non-trivial due to the possibility of direct shadow pages
in indirect MMUs.  Given that using shadow paging with an unpaged guest
is far from top priority _and_ has been subjected to the workaround since
its inception, keep it simple and just fix the accounting glitch.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/mmu/mmu.c  |  2 +-
 arch/x86/kvm/mmu/spte.c | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a39dc886c5b8..04eb87f5a39d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3135,7 +3135,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 			continue;
 
 		link_shadow_page(vcpu, it.sptep, sp);
-		if (fault->is_tdp && fault->huge_page_disallowed)
+		if (fault->huge_page_disallowed)
 			account_nx_huge_page(vcpu->kvm, sp,
 					     fault->req_level >= it.level);
 	}
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 2e08b2a45361..c0fd7e049b4e 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -161,6 +161,18 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	if (!prefetch)
 		spte |= spte_shadow_accessed_mask(spte);
 
+	/*
+	 * For simplicity, enforce the NX huge page mitigation even if not
+	 * strictly necessary.  KVM could ignore the mitigation if paging is
+	 * disabled in the guest, as the guest doesn't have an page tables to
+	 * abuse.  But to safely ignore the mitigation, KVM would have to
+	 * ensure a new MMU is loaded (or all shadow pages zapped) when CR0.PG
+	 * is toggled on, and that's a net negative for performance when TDP is
+	 * enabled.  When TDP is disabled, KVM will always switch to a new MMU
+	 * when CR0.PG is toggled, but leveraging that to ignore the mitigation
+	 * would tie make_spte() further to vCPU/MMU state, and add complexity
+	 * just to optimize a mode that is anything but performance critical.
+	 */
 	if (level > PG_LEVEL_4K && (pte_access & ACC_EXEC_MASK) &&
 	    is_nx_huge_page_enabled(vcpu->kvm)) {
 		pte_access &= ~ACC_EXEC_MASK;
-- 
2.37.2.672.g94769d06f0-goog

