Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7B05A7212
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiH3X4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiH3Xz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:55:57 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F95EDF3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:55:48 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id m15-20020a170902db0f00b001753b1c5adeso882663plx.18
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=v857NRLjw5TFD2WSt6Gh77XixyhkWGhFH1qnXRfNvO0=;
        b=Ht0kj4DaKZUo79Gx4BG8GR/PjYLs3Jk6L9GjvPJG5Sdq2eH/e5vwZ/R6es9s67pS+U
         7C+y8M2Z7VR9/PF0b/FZC2fmUdBNOFN/dUZFF4ZAlRUQ91gIqMV27868w+3gwM/GUpqQ
         BsXRXxjYxqjWz3wLcpfz4yXkdSxfse4bBtT7sRuRvjzdHJdgt+vEPc3DSCc4Yxzd/t7c
         TcMje/OrZEBbSk1RMoTMrDIE6t8wR8YtJ97ADIfABiuWU8pV45jH8gWeLyjV4kvuGIJR
         XFD5KjiXAjkS0yKaD274f8XwWWtgPpzXNzg4IB4GDxc80vNZxo37u9HKA5XiAyXjdlCv
         teWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=v857NRLjw5TFD2WSt6Gh77XixyhkWGhFH1qnXRfNvO0=;
        b=nRSHlCsdOFkzi9ipMKDrnLtZhC3k6UEwzkTFEFCVfB+Gki0EsGEz0jfrlTamQKiELD
         9581RCnQRf+KXo/AFK7nSyfbloCmHqJ5POqrMvD7fFJYnIQnrrIFQalMyblzvsv226db
         Uq8c4porUXzWr7qleX/uW3lx28Tr5dGGROYpu6JnmVBdKFtFVHDAhot5IDgLCJ6LECdY
         l/wms3kA9iobZeMsy+R+/wkz6YXqWka2u92Dw1obQW9kD1yM5WDnId292K2xCl+mi5Gl
         wpz9DC5tEn3zrB9lJ/2B9tj9YZtznl4Q04lZ5alq77fa8Veb1NGQSlU6rGlFSh24roGu
         SUJA==
X-Gm-Message-State: ACgBeo1gLG6NPGl8JieR79uf3tavMv3q5VKJ9F3eeFPqzDmG9CDMAMp1
        JUBS1Q3jabe91wgprw3/w74NMtV7vrY=
X-Google-Smtp-Source: AA6agR5KBvD4D+PkeJubo5qFF3e8xWagdr5p4yv2rT/E/1JwS0ifyDhBReFnG8D03QxuKQ4W24Yh6SJPgEU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ced0:b0:172:e189:f709 with SMTP id
 d16-20020a170902ced000b00172e189f709mr23008852plg.63.1661903748416; Tue, 30
 Aug 2022 16:55:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 30 Aug 2022 23:55:33 +0000
In-Reply-To: <20220830235537.4004585-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220830235537.4004585-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830235537.4004585-6-seanjc@google.com>
Subject: [PATCH v4 5/9] KVM: x86/mmu: Document implicit barriers/ordering in
 TDP MMU shared mode
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

Add comments to the tdp_mmu_set_spte_atomic() and kvm_tdp_mmu_read_spte()
provide ordering guarantees to ensure that any changes made to a child
shadow page are guaranteed to be visible before a SPTE is marked present,
e.g. that there's no risk of concurrent readers observing a stale PFN for
a shadow-present SPTE.

No functional change intended.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_iter.h | 6 ++++++
 arch/x86/kvm/mmu/tdp_mmu.c  | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index f0af385c56e0..9d982ccf4567 100644
--- a/arch/x86/kvm/mmu/tdp_iter.h
+++ b/arch/x86/kvm/mmu/tdp_iter.h
@@ -13,6 +13,12 @@
  * to be zapped while holding mmu_lock for read, and to allow TLB flushes to be
  * batched without having to collect the list of zapped SPs.  Flows that can
  * remove SPs must service pending TLB flushes prior to dropping RCU protection.
+ *
+ * The READ_ONCE() ensures that, if the SPTE points at a child shadow page, all
+ * fields in struct kvm_mmu_page will be read after the caller observes the
+ * present SPTE (KVM must check that the SPTE is present before following the
+ * SPTE's pfn to its associated shadow page).  Pairs with the implicit memory
+ * barrier in tdp_mmu_set_spte_atomic().
  */
 static inline u64 kvm_tdp_mmu_read_spte(tdp_ptep_t sptep)
 {
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 73eb28ed1f03..d1079fabe14c 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -658,6 +658,11 @@ static inline int tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	lockdep_assert_held_read(&kvm->mmu_lock);
 
 	/*
+	 * The atomic CMPXCHG64 provides an implicit memory barrier and ensures
+	 * that, if the SPTE points at a shadow page, all struct kvm_mmu_page
+	 * fields are visible to readers before the SPTE is marked present.
+	 * Pairs with ordering guarantees provided by kvm_tdp_mmu_read_spte().
+	 *
 	 * Note, fast_pf_fix_direct_spte() can also modify TDP MMU SPTEs and
 	 * does not hold the mmu_lock.
 	 */
-- 
2.37.2.672.g94769d06f0-goog

