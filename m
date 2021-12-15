Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97CC475D13
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244599AbhLOQMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhLOQMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:12:50 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D10C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:12:49 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id p17-20020adff211000000b0017b902a7701so6028169wro.19
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0T7H/Y38j6+Gwobm57eeLVycbzCrTBaKznUeZZoLnRY=;
        b=BJgpzkCwe1j3WJWKVWNOBVvJCvYLLVWrwYVZlEgV11DB1tQCznJlUwNpFmhV4nNJoe
         x4rhNTLCG8yYgsw9qn3v98zaLBUf6DRqrpAxVZbBAjhXEVgrI+0cEITsahoz+mFGbZDN
         Bp1fk3yZMsNpaQ/kcxbipbrFTeC4FKeQzjHWuTODjU6dTmT/KxlZ4zLtMB3B6sO8lBac
         aiE3ccRuO3vXHCM3Hg3g4J+Vl6C6MJQg8BNnXZo8Z3UDpyroafFj247opJNvQJOLHj8k
         4RoVVrI1fiVAJ51smFgIMMfMRq9NWs8SnpWjMzKbPiX2hUX7nBHyLwXOKfUlvLf6MO9S
         RKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0T7H/Y38j6+Gwobm57eeLVycbzCrTBaKznUeZZoLnRY=;
        b=hKfS4KJfuK1pAQNF7rgivrTA34KLphI3ZtLd1jKLLtMX8T7exW8fBzyGzC56eUQT/J
         +h41Z8Ez7Ih0dT/1XQTllPQnMvTZcfCjXSti9y+sOkn6uFZNaUM4q3aNRq6yxQoVYEYJ
         kvFCxZBYAS6WnUMTMFntA7GvenOI8cGcDqDQwje0+Mp0U74gKJx6ssHf4HJB+wVAZXoB
         cR9/2/8yeZGU3bsx6M47xsIXHMp61M7Bzs5jwszsX4tNolBQP1OS02dDMl3efZI565fP
         EjSpUdV7otIyGBPzk7G+T9TOpD5Xmm0MYbdGokSo2FSTzr2CHlW6byrn3XGUZQJTw58Z
         qUAw==
X-Gm-Message-State: AOAM532QZlJcZZpNUgwAbdpwfCEt0d+T3zNb6aDu9kAZRHtdOinVaV18
        n17Jr2sKoZGe2M8uI+97/tdy1XugZxE2
X-Google-Smtp-Source: ABdhPJxs0xcgsWgPokAD4PgxH1YFZ/1fp7HGONpVZTXN+N1q3NOGytELjmmCe6UxqHhDjxU63cTx8+yucVmW
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:fc03:4f5b:4e9b:3ec1])
 (user=qperret job=sendgmr) by 2002:a05:600c:3ac3:: with SMTP id
 d3mr527291wms.174.1639584768216; Wed, 15 Dec 2021 08:12:48 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:12:20 +0000
In-Reply-To: <20211215161232.1480836-1-qperret@google.com>
Message-Id: <20211215161232.1480836-4-qperret@google.com>
Mime-Version: 1.0
References: <20211215161232.1480836-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 03/14] KVM: arm64: Fixup hyp stage-1 refcount
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

In nVHE-protected mode, the hyp stage-1 page-table refcount is broken
due to the lack of refcount support in the early allocator. Fix-up the
refcount in the finalize walker, once the 'hyp_vmemmap' is up and running.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index e31149965204..ab44e004e6d3 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -166,6 +166,7 @@ static int finalize_host_mappings_walker(u64 addr, u64 end, u32 level,
 					 enum kvm_pgtable_walk_flags flag,
 					 void * const arg)
 {
+	struct kvm_pgtable_mm_ops *mm_ops = arg;
 	enum kvm_pgtable_prot prot;
 	enum pkvm_page_state state;
 	kvm_pte_t pte = *ptep;
@@ -174,6 +175,15 @@ static int finalize_host_mappings_walker(u64 addr, u64 end, u32 level,
 	if (!kvm_pte_valid(pte))
 		return 0;
 
+	/*
+	 * Fix-up the refcount for the page-table pages as the early allocator
+	 * was unable to access the hyp_vmemmap and so the buddy allocator has
+	 * initialised the refcount to '1'.
+	 */
+	mm_ops->get_page(ptep);
+	if (flag != KVM_PGTABLE_WALK_LEAF)
+		return 0;
+
 	if (level != (KVM_PGTABLE_MAX_LEVELS - 1))
 		return -EINVAL;
 
@@ -206,7 +216,8 @@ static int finalize_host_mappings(void)
 {
 	struct kvm_pgtable_walker walker = {
 		.cb	= finalize_host_mappings_walker,
-		.flags	= KVM_PGTABLE_WALK_LEAF,
+		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
+		.arg	= pkvm_pgtable.mm_ops,
 	};
 	int i, ret;
 
@@ -241,10 +252,6 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
-	ret = finalize_host_mappings();
-	if (ret)
-		goto out;
-
 	pkvm_pgtable_mm_ops = (struct kvm_pgtable_mm_ops) {
 		.zalloc_page = hyp_zalloc_hyp_page,
 		.phys_to_virt = hyp_phys_to_virt,
@@ -254,6 +261,10 @@ void __noreturn __pkvm_init_finalise(void)
 	};
 	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
 
+	ret = finalize_host_mappings();
+	if (ret)
+		goto out;
+
 out:
 	/*
 	 * We tail-called to here from handle___pkvm_init() and will not return,
-- 
2.34.1.173.g76aa8bc2d0-goog

