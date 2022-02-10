Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192624B18AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345150AbiBJWoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:44:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbiBJWoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:44:02 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5855F4D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:44:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t8-20020a259ac8000000b00619a3b5977fso15158602ybo.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=FWvONc6PPT7SOgcpYOOzYgnlsLgy4lIL2CKlJJtukzs=;
        b=mBuynU6nVtUUhgSN/Mzp+TKEbV4pFhe3dtKgEyVMOiwApKF6+HLlSY4gE57X5hOP70
         rAAiYgmNoRwzjL9PRCjeUoKyBvbWi9KRQIFADz3Q6trpDjsIh8e/dl0J/VD9kGCwAI+J
         BESFy4HJ4E6dX5+yow+EWQQLwzm01n1PyiQJhfT9IrZs+BepkmJI7SxxevOSmOe5Zkde
         eBCAolmAIMIZry/9HLPgsUjMn0zqebgFcw0PnbcfnYgLHiakd0mei8onuiCvnJNdqIbB
         Mix+BHSyf/9IvbRtthvYA/aAELP0sccVnHZzFmlpWyLkFP2bSNkbmY8rnK0kh6Acc1Vw
         G2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=FWvONc6PPT7SOgcpYOOzYgnlsLgy4lIL2CKlJJtukzs=;
        b=iaEe7fllx18D6SsvevV8FQe2VJUuln+vs7lv5w+VnivAaH4T56Z4c2ixlbKoDZAJRR
         c2WlApvlwRNEHEPf7y0LwW4ezjtSkMq1xq5YepSav5lNidmcogxRq6siFvnFUJJAG++b
         z8cJ/ZGCO0NvyQ92IySjDQDSxv7yZYjEnRtmZoRyDS4uGWRH2nmoQCh8EMBNmWh6RYkG
         /llMhAtXmiO2pNKOWlJDBigdHr1MXJ12hTZRD3IkX0o5ZjJn3x309Odgf1gMO7MzzOFh
         carpCRTUdceEuFROkL/rgkYCCv9y/HPVti+rS3OD38ME/f8/hvU0uKMzifYu7lsjV68w
         QYuw==
X-Gm-Message-State: AOAM5313PReSKviB2wmbzSMYEWRVxJfwlSftXhWkuGKsz74b7w6OE53c
        IS8fBEwg7kPNt4uf4mc6ru7GvFwNPdGD1r/iKg==
X-Google-Smtp-Source: ABdhPJxZHBnjRsaIEqwkHqdAbXT7GDJWvj+cAd1UkPLHhqa+mVsLffzcbYP42soJ9363QIkLwEeaj1E/kFGFAp78sg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:8f02:232:ad86:2ab2])
 (user=kaleshsingh job=sendgmr) by 2002:a25:6f08:: with SMTP id
 k8mr8699054ybc.469.1644533041615; Thu, 10 Feb 2022 14:44:01 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:41:43 -0800
In-Reply-To: <20220210224220.4076151-1-kaleshsingh@google.com>
Message-Id: <20220210224220.4076151-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220210224220.4076151-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 2/7] KVM: arm64: Factor out private range VA allocation
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Perret <qperret@google.com>

__pkvm_create_private_mapping() is currently responsible for allocating
VA space in the hypervisor's "private" range and creating stage-1
mappings. In order to allow reusing the VA space allocation logic from
other places, let's factor it out in a standalone function. This is will
be used to allocate private VA ranges for hypervisor stack guard pages
in a subsequent patch in this series.

Signed-off-by: Quentin Perret <qperret@google.com>
[Kalesh - Resolve conflicts and make hyp_alloc_private_va_range
          available outside nvhe/mm.c, update commit message]
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mm.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mm.c         | 28 +++++++++++++++++++---------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index 2d08510c6cc1..f53fb0e406db 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -21,6 +21,7 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
 int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
 unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
 					    enum kvm_pgtable_prot prot);
+unsigned long hyp_alloc_private_va_range(size_t size);
 
 static inline void hyp_vmemmap_range(phys_addr_t phys, unsigned long size,
 				     unsigned long *start, unsigned long *end)
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index 526a7d6fa86f..e196441e072f 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -37,6 +37,22 @@ static int __pkvm_create_mappings(unsigned long start, unsigned long size,
 	return err;
 }
 
+unsigned long hyp_alloc_private_va_range(size_t size)
+{
+	unsigned long addr = __io_map_base;
+
+	hyp_assert_lock_held(&pkvm_pgd_lock);
+	__io_map_base += PAGE_ALIGN(size);
+
+	/* Are we overflowing on the vmemmap ? */
+	if (__io_map_base > __hyp_vmemmap) {
+		__io_map_base = addr;
+		addr = (unsigned long)ERR_PTR(-ENOMEM);
+	}
+
+	return addr;
+}
+
 unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
 					    enum kvm_pgtable_prot prot)
 {
@@ -45,16 +61,10 @@ unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
 
 	hyp_spin_lock(&pkvm_pgd_lock);
 
-	size = PAGE_ALIGN(size + offset_in_page(phys));
-	addr = __io_map_base;
-	__io_map_base += size;
-
-	/* Are we overflowing on the vmemmap ? */
-	if (__io_map_base > __hyp_vmemmap) {
-		__io_map_base -= size;
-		addr = (unsigned long)ERR_PTR(-ENOMEM);
+	size = size + offset_in_page(phys);
+	addr = hyp_alloc_private_va_range(size);
+	if (IS_ERR((void *)addr))
 		goto out;
-	}
 
 	err = kvm_pgtable_hyp_map(&pkvm_pgtable, addr, size, phys, prot);
 	if (err) {
-- 
2.35.1.265.g69c8d7142f-goog

