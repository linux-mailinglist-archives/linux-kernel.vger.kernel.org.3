Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910E1475D12
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244583AbhLOQMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhLOQMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:12:46 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8032C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:12:45 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id y17-20020a056402271100b003f7ef5ca612so1341212edd.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9UncJz09b52+rulxMEJfzwQAU0lESQ6s/aE8Lup77NM=;
        b=IoTXNcUh80VkspkGKEhVZPGmIgfwuEX2hfWC85I6z4BP91X7qiSyJSelcdBwSw1+z/
         ENHIv3PJ0avwndy5ipE//qEnaQSgTyXUbFnvdFYPJ9WV487qISa/CYlxv4wvG7jxgNnE
         uklhvdl0bjLKzKwujXWYoEg5w88I7O1+ks77TzECjDlQ/E56agN6hwB7e7EumJx7le6e
         IkHpzTlXUq/uxD56jvtOXsS+joBN2L8q4BTBmur++c6puzfe6OlwiQeG1wD2kPS6Abtc
         277ohHjDPdJuIij7EWGEkECn+V/zDZqYSe3KMBnaE+mIXvhyAxJf4mZl27WNdzb0jUEC
         03xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9UncJz09b52+rulxMEJfzwQAU0lESQ6s/aE8Lup77NM=;
        b=HQUDSqLwxcdeNAxImw3ZF1QT2f39lubDDWSubxCe2BFYx330FE0EvUiknoaCoBoWPC
         M1gg45xMAlxLPqu80PwcUIwA0PeFgVSrm5Ym5RzaYhFnogl1QHPudWcX1JMSg7L59djN
         hLKPYuG+s4e8DVSIfD+4A9oATTS/6PrHMrHrJGcsp5zzlkfkBhmiXWVmeJtYBoePWRWa
         c6kCoqNc32wx+D+R8imVnVrUOVOJBme6QbuyQgfiUK0F4lb3s9OfXl5vy7SBhEZyrsQ6
         TN1qGTjMuSFaw8zR81C7FiefbgAJc6ik3lX4Lila7/YpPOc6sPAnuQAwNj1Qj0UJG2s3
         uzog==
X-Gm-Message-State: AOAM5309PGmfy/+z6XFcyzH0kEKtv4Nkxizoia50kUyPeinLfNGFMwZp
        /ObVp3hVfPoSzxl3s5JZh8ntQ/bx2J9s
X-Google-Smtp-Source: ABdhPJwCHc7fxmz5DGHLcuofkXghjPhU8hYkQXG2pB5/De5FAlnDqDB9RnWoWN1bvIdS4I1Eas5U47PGeAb+
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:fc03:4f5b:4e9b:3ec1])
 (user=qperret job=sendgmr) by 2002:a17:906:4fc4:: with SMTP id
 i4mr11224234ejw.81.1639584764044; Wed, 15 Dec 2021 08:12:44 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:12:19 +0000
In-Reply-To: <20211215161232.1480836-1-qperret@google.com>
Message-Id: <20211215161232.1480836-3-qperret@google.com>
Mime-Version: 1.0
References: <20211215161232.1480836-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 02/14] KVM: arm64: Refcount hyp stage-1 pgtable pages
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     qperret@google.com, qwandor@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare the ground for allowing hyp stage-1 mappings to be removed at
run-time, update the KVM page-table code to maintain a correct refcount
using the ->{get,put}_page() function callbacks.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 39 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index f8ceebe4982e..e50e9158fc56 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -383,21 +383,6 @@ enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte)
 	return prot;
 }
 
-static bool hyp_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
-{
-	/*
-	 * Tolerate KVM recreating the exact same mapping, or changing software
-	 * bits if the existing mapping was valid.
-	 */
-	if (old == new)
-		return false;
-
-	if (!kvm_pte_valid(old))
-		return true;
-
-	return !WARN_ON((old ^ new) & ~KVM_PTE_LEAF_ATTR_HI_SW);
-}
-
 static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 				    kvm_pte_t *ptep, struct hyp_map_data *data)
 {
@@ -407,11 +392,16 @@ static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 	if (!kvm_block_mapping_supported(addr, end, phys, level))
 		return false;
 
+	data->phys += granule;
 	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
-	if (hyp_pte_needs_update(old, new))
-		smp_store_release(ptep, new);
+	if (old == new)
+		return true;
+	if (!kvm_pte_valid(old))
+		data->mm_ops->get_page(ptep);
+	else if (WARN_ON((old ^ new) & ~KVM_PTE_LEAF_ATTR_HI_SW))
+		return false;
 
-	data->phys += granule;
+	smp_store_release(ptep, new);
 	return true;
 }
 
@@ -433,6 +423,7 @@ static int hyp_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 		return -ENOMEM;
 
 	kvm_set_table_pte(ptep, childp, mm_ops);
+	mm_ops->get_page(ptep);
 	return 0;
 }
 
@@ -482,8 +473,16 @@ static int hyp_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 			   enum kvm_pgtable_walk_flags flag, void * const arg)
 {
 	struct kvm_pgtable_mm_ops *mm_ops = arg;
+	kvm_pte_t pte = *ptep;
+
+	if (!kvm_pte_valid(pte))
+		return 0;
+
+	mm_ops->put_page(ptep);
+
+	if (kvm_pte_table(pte, level))
+		mm_ops->put_page(kvm_pte_follow(pte, mm_ops));
 
-	mm_ops->put_page((void *)kvm_pte_follow(*ptep, mm_ops));
 	return 0;
 }
 
@@ -491,7 +490,7 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt)
 {
 	struct kvm_pgtable_walker walker = {
 		.cb	= hyp_free_walker,
-		.flags	= KVM_PGTABLE_WALK_TABLE_POST,
+		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
 		.arg	= pgt->mm_ops,
 	};
 
-- 
2.34.1.173.g76aa8bc2d0-goog

