Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980264F205A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiDDXoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiDDXoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:44:13 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE48E66AF5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:42:05 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q7-20020a17090a7a8700b001ca823ceb16so2893960pjf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zGPia6Y75PegYdtijlGH8Rirg8fMk3EtyUzE3+aq8gA=;
        b=oxrndx4rUGCxdYTcZSFyDdbsgSWZ+IkShvkWvLxweXOH/Ob2dyRylsH1lB4NocUiFn
         Ga3YaLjAzq/XYcDDRp/LAbFX0Bq3Py2YIszyVtaU65PLg8YY3y1iRhqzHzA7pSa1L8wN
         zzkWhWnl4shoUlPtJ0P5N04UDJZ9SJMrJFzvzbOXNaFuGQGh0UooJMEpodaPKh3POKNu
         cSktEFN3eQRN1BMcgpKy+u74uXUsXA+ApOG6dvll62pFH/J+Tnswch0wxoTS0vs+pPwX
         gUsV2HmYBM0X0ssLZZA+729NPsfL4HVgO2kiynY66hWh/lV/B7V2jGjnJzj9HIz1py08
         MrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zGPia6Y75PegYdtijlGH8Rirg8fMk3EtyUzE3+aq8gA=;
        b=wNspqFmRS0o9SOIdWHuojCLtwwGYVavkBZ+ELgleISXlfGog+xUCEwSKeCOcTIThlI
         j8MK1VOxD2X1gaa2X6ZKpEQQkcNJCqRhdC1ot/N2XXqmHbRXjA0D5y+GJS6Qz8G0wLzo
         j2ehvIMj+M2gVOQYza4Wd4rugcotxJv0eQidXTnjdqV55GXuSs+VwzSlwTRSg8h/yO4N
         Xw9RNp/lUSv/VZ4fwamENTJGhYgDMtgOe2AJBFrS3m1rNEmPwpHrW3ooM8idnuGImUw7
         v1n/bYr/Dr7A9ineXHgKI9RMwSQtSjEvQ7KL36f8tOT7nLHJr2dzyAgV4mtER9YpBIoq
         71fA==
X-Gm-Message-State: AOAM5322vN4ehE+pIjpsVo3eD5P2ys3LxfpiWmxoF7A7w+pqBqMJwI27
        HIv9RR+2OxVlUmvJXWbQFLP2i8qV8eD/mmYK
X-Google-Smtp-Source: ABdhPJzD1f0Jx7sGhlZtl856UUxIwCksK4t+nrYVjP8gP5u+t88ub1/JzUx63f9lr8FQjeB9VSzhzIkW2iQctlIT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:903:2488:b0:156:1e8d:a82 with SMTP
 id p8-20020a170903248800b001561e8d0a82mr506452plw.51.1649115724990; Mon, 04
 Apr 2022 16:42:04 -0700 (PDT)
Date:   Mon,  4 Apr 2022 23:41:51 +0000
In-Reply-To: <20220404234154.1251388-1-yosryahmed@google.com>
Message-Id: <20220404234154.1251388-3-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220404234154.1251388-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v2 2/5] KVM: x86: mm: count KVM page table pages in pagetable stats
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     mizhang@google.com, David Matlack <dmatlack@google.com>,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>
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

Count the pages used by KVM in x86 for page tables in pagetable stats.

For legacy code, accounting pagetable stats is combined KVM's
existing for mmu pages in newly introduced kvm_[un]account_mmu_page()
helpers.

For tdp mmu, introduce new tdp_[un]account_mmu_page() helpers. That
combines accounting pagetable stats with the tdp_mmu_pages counter
accounting.

tdp_mmu_pages counter introduced in this series [1]. This patch was
rebased on top of the first two patches in that series.

[1]https://lore.kernel.org/lkml/20220401063636.2414200-1-mizhang@google.com/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/kvm/mmu/mmu.c     | 16 ++++++++++++++--
 arch/x86/kvm/mmu/tdp_mmu.c | 16 ++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f4020837fb48..28579b96a483 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1671,6 +1671,18 @@ static inline void kvm_mod_used_mmu_pages(struct kvm *kvm, long nr)
 	percpu_counter_add(&kvm_total_used_mmu_pages, nr);
 }
 
+static void kvm_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	kvm_mod_used_mmu_pages(kvm, +1);
+	kvm_account_pgtable_pages((void *)sp->spt, +1);
+}
+
+static void kvm_unaccount_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	kvm_mod_used_mmu_pages(kvm, -1);
+	kvm_account_pgtable_pages((void *)sp->spt, -1);
+}
+
 static void kvm_mmu_free_page(struct kvm_mmu_page *sp)
 {
 	MMU_WARN_ON(!is_empty_shadow_page(sp->spt));
@@ -1726,7 +1738,7 @@ static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, int direct
 	 */
 	sp->mmu_valid_gen = vcpu->kvm->arch.mmu_valid_gen;
 	list_add(&sp->link, &vcpu->kvm->arch.active_mmu_pages);
-	kvm_mod_used_mmu_pages(vcpu->kvm, +1);
+	kvm_account_mmu_page(vcpu->kvm, sp);
 	return sp;
 }
 
@@ -2342,7 +2354,7 @@ static bool __kvm_mmu_prepare_zap_page(struct kvm *kvm,
 			list_add(&sp->link, invalid_list);
 		else
 			list_move(&sp->link, invalid_list);
-		kvm_mod_used_mmu_pages(kvm, -1);
+		kvm_unaccount_mmu_page(kvm, sp);
 	} else {
 		/*
 		 * Remove the active root from the active page list, the root
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index ed34f3f75f18..12bfcfc610c5 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -371,6 +371,18 @@ static void handle_changed_spte_dirty_log(struct kvm *kvm, int as_id, gfn_t gfn,
 	}
 }
 
+static void tdp_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	atomic64_inc(&kvm->arch.tdp_mmu_pages);
+	kvm_account_pgtable_pages((void *)sp->spt, +1);
+}
+
+static void tdp_unaccount_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	atomic64_dec(&kvm->arch.tdp_mmu_pages);
+	kvm_account_pgtable_pages((void *)sp->spt, -1);
+}
+
 /**
  * tdp_mmu_unlink_sp() - Remove a shadow page from the list of used pages
  *
@@ -383,7 +395,7 @@ static void handle_changed_spte_dirty_log(struct kvm *kvm, int as_id, gfn_t gfn,
 static void tdp_mmu_unlink_sp(struct kvm *kvm, struct kvm_mmu_page *sp,
 			      bool shared)
 {
-	atomic64_dec(&kvm->arch.tdp_mmu_pages);
+	tdp_unaccount_mmu_page(kvm, sp);
 
 	if (!sp->lpage_disallowed)
 		return;
@@ -1121,7 +1133,7 @@ static int tdp_mmu_link_sp(struct kvm *kvm, struct tdp_iter *iter,
 		tdp_mmu_set_spte(kvm, iter, spte);
 	}
 
-	atomic64_inc(&kvm->arch.tdp_mmu_pages);
+	tdp_account_mmu_page(kvm, sp);
 
 	return 0;
 }
-- 
2.35.1.1094.g7c7d902a7c-goog

