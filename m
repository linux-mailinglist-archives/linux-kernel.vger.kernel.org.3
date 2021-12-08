Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421A346D6E1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhLHP0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbhLHP0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:26:39 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ED0C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 07:23:07 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id q7-20020adff507000000b0017d160d35a8so484077wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 07:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r27uQnQQtVbS3yI0XEL7/R9cqNgVk61W5XrAJ0Nw0Ww=;
        b=naFD9LicXyODJErTfR403GKq7ei5lGkVN74aV1AhQuJdG7N+BLYc8N+bJ37PaGYh39
         SdctqEgFuCTMuF5FWpGFNJe/hL1KT7NEPGKmw8HIn2GMoXMiktzuHvhDjfo+P9wZLdDt
         5mw45WlmYwCXT+ULUp/dRM12JoD6391Z4YYbBoWBD6E9W4TdWHwOmw+tuxk8VfsoPUFq
         FlUeaULBj+v/FzA7O1ubmKEHblv0W4KcYDQGhFM7mk6rf2k4sbm5nlj1FelFQx4kRRdl
         NCC26n15GXzmRdPue/vf6hJbdDqylJoqp5mGGTGvvUXzyNqZvoRj2euYDhHpZumkY6tV
         0qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r27uQnQQtVbS3yI0XEL7/R9cqNgVk61W5XrAJ0Nw0Ww=;
        b=EeuynepEY+OIK2f3dNUskNinmUPLof8aZKVWZePWYyjVpZ2fhoe/Lznlkq16XjgBEX
         CRjf8HuEBKBeA3L1PmV5TvmhsVUpr5orOb9SmYw+JH4ClCwVpkwPEZ70j6gMatwk05hp
         qznSlbUfRbjOWWgnhRD5trG1+9oTSKtmdFvkYpYmiZb/dhNRSW2NoPkJCbrrSpN4S3Ve
         5LS5pNntvQ5u6m7oPmcF26fODHrnX1l5gWigxkPKS0sHzgvQmkCx+VQOaJmZyT8cCs/h
         6w1ZyzH4g4wgjFkTcFaUswZXAzu6WHRvjQjC44CVHF2NCJYp+pyI9O3ED3k5gr/ngH45
         1W0Q==
X-Gm-Message-State: AOAM531UXkVsJv4qIXf8ZuavJTcX9HM8ujv9TStPPKpje7zXNiah1jIy
        Mspyw0cMA9mK+y/EfJmyK7hgYYvVwd3j
X-Google-Smtp-Source: ABdhPJyVBhdRR4oxaKYKZEdM1jxQ1KGBiBeRjA9M0nAxRA3k7kRNUlf5UDHP+FOncXY+IqD/xhb12Q9Uy29Q
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:c718:14b8:982a:57d5])
 (user=qperret job=sendgmr) by 2002:a5d:4d8b:: with SMTP id
 b11mr58840186wru.393.1638976985582; Wed, 08 Dec 2021 07:23:05 -0800 (PST)
Date:   Wed,  8 Dec 2021 15:22:54 +0000
In-Reply-To: <20211208152300.2478542-1-qperret@google.com>
Message-Id: <20211208152300.2478542-2-qperret@google.com>
Mime-Version: 1.0
References: <20211208152300.2478542-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 1/6] KVM: arm64: pkvm: Fix hyp_pool max order
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EL2 page allocator in protected mode maintains a per-pool max order
value to optimize allocations when the memory region it covers is small.
However, the max order value is currently under-estimated whenever the
number of pages in the region is a power of two. Fix the estimation.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index 0bd7701ad1df..543cad6c376a 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -241,7 +241,7 @@ int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsigned int nr_pages,
 	int i;
 
 	hyp_spin_lock_init(&pool->lock);
-	pool->max_order = min(MAX_ORDER, get_order(nr_pages << PAGE_SHIFT));
+	pool->max_order = min(MAX_ORDER, get_order((nr_pages + 1) << PAGE_SHIFT));
 	for (i = 0; i < pool->max_order; i++)
 		INIT_LIST_HEAD(&pool->free_area[i]);
 	pool->range_start = phys;
-- 
2.34.1.400.ga245620fadb-goog

