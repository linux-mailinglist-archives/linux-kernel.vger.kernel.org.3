Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA984E1E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 01:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbiCUA21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 20:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343901AbiCUA2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 20:28:09 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BCCDE924
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 17:26:45 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x18-20020a170902ea9200b00153e0dbca9bso3395054plb.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 17:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=w72ktL2NVaulWnSOLwhUAw/SEUZ2qLk7Ydqg7suvoo4=;
        b=fx1XCeSYsDcHoKzCEPO5QZTH/7lJHeMLn4C/eT3bSq9992/wm8zBqAZSk2S8ps8OVp
         YVMnCJq6mRf809eIU4L/Cez2s4PciznmUAWKOwgFPAp82mqDTNJnQY4VLW7Odu7kWy5I
         K5X/MNocMz7n6KTZPyq7pkGdo5582uc8RzaV4LVqKe5OYI/C7nLQovCZYIQKKlT0jqGu
         H28bbR4alZOzfpAwlcHASL/0YDA46pxKWiSHQUpbGUQkE5ccSQDXy7tm3II7/dBe9UeA
         BXovdb4Gr/rmvzC405fiMovRJthVWFMRzeRyKDahyKfYQeVZ60hGjjcMbkUQ3fO7ZSE6
         DpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=w72ktL2NVaulWnSOLwhUAw/SEUZ2qLk7Ydqg7suvoo4=;
        b=NqKQS4xpRohqLAhKwx+g8cHt1i6D1WmLD1HeXBC1RtfdNqxkR8DQ7R2oNdROg4uRqC
         NdD2TbOJBmwmgiiCzWbOxaMtwf57CJKAt7r7rL/vkBIDHpaxo/wIyNo1+JQib3CQnKuX
         GxPgVllexKY9pCT4bVXMYFufItmDar+9WsGFfIxkmOtDE51sVMX+nM4xsqQA8c81FCXm
         wNveMRnaDk47lNKP1oNc6jIIxc3MLkbJPUk9f3yQtGvFpbIsRLDyYK7ITU8SI2J9s9Xu
         2ho5382kgHSndtZRQy7a7L1ui/zDGaFuFP9igQTe1Trpaxx+0NPhgm5Og/nQKMgqeVTH
         KN+A==
X-Gm-Message-State: AOAM533vy0Xf4uLgQWo5PO6jNXv6b6bbybHYS7534zgluOIY6EQXbWya
        QUNbWcvynjKl+ME/EWLihFyiPG6ug7Sw
X-Google-Smtp-Source: ABdhPJxbX88VuJKl737VvBq/vCrgo6XQMNEN18CqZbwf3ZJmJ6wNbhkzBo6bEjn+oSxahPeVrtMULAZs1R6L
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:aa7:8432:0:b0:4f6:6dcd:4f19 with SMTP id
 q18-20020aa78432000000b004f66dcd4f19mr21345407pfn.53.1647822405012; Sun, 20
 Mar 2022 17:26:45 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon, 21 Mar 2022 00:26:37 +0000
In-Reply-To: <20220321002638.379672-1-mizhang@google.com>
Message-Id: <20220321002638.379672-4-mizhang@google.com>
Mime-Version: 1.0
References: <20220321002638.379672-1-mizhang@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH 3/4] KVM: x86/mmu: explicitly check nx_hugepage in disallowed_hugepage_adjust()
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Peter Xu <peterx@redhat.com>, Ben Gardon <bgorden@google.com>
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

Add extra check to specify the case of nx hugepage and allow KVM to
reconstruct large mapping after dirty logging is disabled. Existing code
works only for nx hugepage but the condition is too general in that does
not consider other usage case (such as dirty logging). Moreover, existing
code assumes that a present PMD or PUD indicates that there exist 'smaller
SPTEs' under the paging structure. This assumption may no be true if
consider the zapping leafs only behavior in MMU.

Missing the check causes KVM incorrectly regards the faulting page as a NX
huge page and refuse to map it at desired level. And this leads to back
performance in shadow mmu and potentiall TDP mmu.

Fixes: b8e8c8303ff2 ("kvm: mmu: ITLB_MULTIHIT mitigation")
Cc: stable@vger.kernel.org

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5628d0ba637e..4d358c273f6c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2919,6 +2919,16 @@ void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_
 	    cur_level == fault->goal_level &&
 	    is_shadow_present_pte(spte) &&
 	    !is_large_pte(spte)) {
+		struct kvm_mmu_page *sp;
+		u64 page_mask;
+		/*
+		 * When nx hugepage flag is not set, there is no reason to
+		 * go down to another level. This helps demand paging to
+		 * generate large mappings.
+		 */
+		sp = to_shadow_page(spte & PT64_BASE_ADDR_MASK);
+		if (!sp->lpage_disallowed)
+			return;
 		/*
 		 * A small SPTE exists for this pfn, but FNAME(fetch)
 		 * and __direct_map would like to create a large PTE
@@ -2926,8 +2936,8 @@ void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_
 		 * patching back for them into pfn the next 9 bits of
 		 * the address.
 		 */
-		u64 page_mask = KVM_PAGES_PER_HPAGE(cur_level) -
-				KVM_PAGES_PER_HPAGE(cur_level - 1);
+		page_mask = KVM_PAGES_PER_HPAGE(cur_level) -
+			KVM_PAGES_PER_HPAGE(cur_level - 1);
 		fault->pfn |= fault->gfn & page_mask;
 		fault->goal_level--;
 	}
-- 
2.35.1.894.gb6a874cedc-goog

