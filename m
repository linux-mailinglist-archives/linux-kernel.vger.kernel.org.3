Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C76B523631
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbiEKOva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241548AbiEKOv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:51:28 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97F5C5D91
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:51:27 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id b184-20020a62cfc1000000b0050d209cb8dcso1265075pfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=h9AY4Q2GsOxacDvqFN4YTojc7TEqJHbfnq0d8zy0AUI=;
        b=hWZVPP8lhK4N0Mg6bmSbEhxF+gTB9MnL6ots52Urd2t0/BbHCNlxwcd2S2G9HVpmZq
         WmD2LolLlgxmVrCerQpCgU2RyoXFU1cnXXKL1/ze0GW3SwsPVU9p4BMCz9YZjRPSu1Gq
         LpZPXrCle99UgoCrYsg8ziEgsdZG3s9z6BCs0zXngM96DOAUY1OfwxQcnMOUAy3je8Ng
         Hn9U7LT6RXjR/aL9JuxTmTHHaUX8k3W8UFszC98BIPak2Mf3ZIHsM90lozNIQG8dqZeM
         QNUJGagLQlGtMLj4FUewa4YXht/Q+BRa1AC0fHSf1jil2ipAA9/lI2RIT/goUp2fIwl4
         niJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=h9AY4Q2GsOxacDvqFN4YTojc7TEqJHbfnq0d8zy0AUI=;
        b=ae29ZKgWwe2BH8502EYr0ag+JiSwc5oDz1aNBzJ220tpFUbZx4zzsRJPMgAIwK67nb
         tJWBRZHrIaBQn2cqmTSp38mfnwjNEMWsjLWK/8LFhO0CwRXZydkPZ1/lTcMzG6rUeXBK
         scH9CQhj5ZfGwRqXljNv3R6n0jmo6YbdFshpjkc6sh7lkUla9sqE8MZk7FxX9AxFedw8
         XQRYU+EGOON4A6BQL20lRER2GAhZu+M5PUDd+bV5mZf9PN0No6LsQVB/l9qgrWpT1NjS
         H56Y+pCL2NS02MwbHn1BJ4++ew3fJe+fRKJ6mDbvGO3Qi6jPBywnHoQ/4EVx9OpU47cg
         O3ag==
X-Gm-Message-State: AOAM532XvoaVfTiPvOokvUHyrF86gvDnvYafhBMYQAlmY3siOaD05WUT
        YjkJZFiwTO/V4at4Cey9peMQ/fiIvyY=
X-Google-Smtp-Source: ABdhPJz0W4ie8Ct1S+dUr/07VAZls1XaOK8YaewpQK6DMZLh8ZJFn1XA7xpKaUkkvdiTRxdXAG4dIYHi6l4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:5752:0:b0:3c2:1c59:666f with SMTP id
 h18-20020a635752000000b003c21c59666fmr20961499pgm.59.1652280687130; Wed, 11
 May 2022 07:51:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 11 May 2022 14:51:22 +0000
Message-Id: <20220511145122.3133334-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v3] KVM: x86/mmu: Update number of zapped pages even if page
 list is stable
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
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

When zapping obsolete pages, update the running count of zapped pages
regardless of whether or not the list has become unstable due to zapping
a shadow page with its own child shadow pages.  If the VM is backed by
mostly 4kb pages, KVM can zap an absurd number of SPTEs without bumping
the batch count and thus without yielding.  In the worst case scenario,
this can cause a soft lokcup.

 watchdog: BUG: soft lockup - CPU#12 stuck for 22s! [dirty_log_perf_:13020]
   RIP: 0010:workingset_activation+0x19/0x130
   mark_page_accessed+0x266/0x2e0
   kvm_set_pfn_accessed+0x31/0x40
   mmu_spte_clear_track_bits+0x136/0x1c0
   drop_spte+0x1a/0xc0
   mmu_page_zap_pte+0xef/0x120
   __kvm_mmu_prepare_zap_page+0x205/0x5e0
   kvm_mmu_zap_all_fast+0xd7/0x190
   kvm_mmu_invalidate_zap_pages_in_memslot+0xe/0x10
   kvm_page_track_flush_slot+0x5c/0x80
   kvm_arch_flush_shadow_memslot+0xe/0x10
   kvm_set_memslot+0x1a8/0x5d0
   __kvm_set_memory_region+0x337/0x590
   kvm_vm_ioctl+0xb08/0x1040

Fixes: fbb158cb88b6 ("KVM: x86/mmu: Revert "Revert "KVM: MMU: zap pages in batch""")
Reported-by: David Matlack <dmatlack@google.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v3:
 - Collect David's review.
 - "Rebase".  The v2 patch still applies cleanly, but Paolo apparently has
   a filter configured to ignore all emails related to the v2 submission.

v2:
 - https://lore.kernel.org/all/20211129235233.1277558-1-seanjc@google.com
 - Rebase to kvm/master, commit 30d7c5d60a88 ("KVM: SEV: expose...")
 - Collect Ben's review, modulo bad splat.
 - Copy+paste the correct splat and symptom. [David].

 arch/x86/kvm/mmu/mmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 909372762363..7429ae1784af 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5665,6 +5665,7 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 {
 	struct kvm_mmu_page *sp, *node;
 	int nr_zapped, batch = 0;
+	bool unstable;
 
 restart:
 	list_for_each_entry_safe_reverse(sp, node,
@@ -5696,11 +5697,12 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 			goto restart;
 		}
 
-		if (__kvm_mmu_prepare_zap_page(kvm, sp,
-				&kvm->arch.zapped_obsolete_pages, &nr_zapped)) {
-			batch += nr_zapped;
+		unstable = __kvm_mmu_prepare_zap_page(kvm, sp,
+				&kvm->arch.zapped_obsolete_pages, &nr_zapped);
+		batch += nr_zapped;
+
+		if (unstable)
 			goto restart;
-		}
 	}
 
 	/*

base-commit: 2764011106d0436cb44702cfb0981339d68c3509
-- 
2.36.0.512.ge40c2bad7a-goog

