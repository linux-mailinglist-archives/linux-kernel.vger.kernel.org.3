Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBCB465391
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351718AbhLARIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351710AbhLARHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:07:53 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288ABC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:04:31 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so4466814wrd.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9uBUypl+EXPtiyqLggdiPCeBqKTFxHsKtVyJKG8pgmY=;
        b=Vv1c7CHoktHXpAkMllAbrV9Qh8WJZnyTA3AZU15KbH4HMkRzFi9p8jcrrt9SYvw/vm
         XiJfozl/oFlTHNfLRWY3HBA3gFa9GG27TT0SAeeuzCVqz8nF3/MFgRTE1JTlFJUP24Ec
         BzDBGevNwW/zf0YB+zazdFhJ4kiNaPq5iHmleo2R5XUDtGWhB+8awKuhqPooz9Z/mSNG
         gs4ndbhCyBpRHS3gb21jCowKbTdnE1ozwPsjKll5mD7/DVNd1EvOyQ72bfzphCiSXYhN
         gFAldNGJnBPpUdYyDkMsuJXxN+63Mq6uHhqZqhCmWw9MzrD9lAxNSXUtKzeOMkHVbfX8
         pvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9uBUypl+EXPtiyqLggdiPCeBqKTFxHsKtVyJKG8pgmY=;
        b=vBJCkKrRDBQOevm9cwBchatgbUGPkOjCxDg5WfhmpTaKe1Pn7kligncJaql7YEOL/K
         cQiz5iDfk5V8VvlfNk9RJMF67wTDYBiwXKbk3w9WCvEwBVMkQEYaQtf8E2+YO05mQMuw
         YlnoYHBNOEf3zFWcyWF0UBUMtlj61w0KMlnc+DRO2aRxPs6/0bFY/rFKPez8C++U0IDC
         ADZMja+zpkFz6vvdxn8oXcHI8DmWO5dQ3q5uVVEk6K1lp+iMIGf5t5bldkU+Nq52eWoc
         XNx0Mv338sNyg+q81FZRDuMPIsxM9A4qdjXnMkJbvAc13e2T80XHEn/0peufspKOr9Jd
         0pVw==
X-Gm-Message-State: AOAM530nor2eavXbVxKitikCae5/gjHizzj73Vqg5B6mhilKHaBZzjuw
        VxPUpnB49hXVRsnvsBm1ck7c9Vx5AL9G
X-Google-Smtp-Source: ABdhPJynMlhVluzA+1W+geGVMD660u2IXflLbXQYLj5MfYI1LEe60lA76lE/vavpHK8Z8gHIBVjRNs1KfRK+
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1cab:1a20:2ef1:ddde])
 (user=qperret job=sendgmr) by 2002:a05:600c:1d1b:: with SMTP id
 l27mr113174wms.1.1638378269441; Wed, 01 Dec 2021 09:04:29 -0800 (PST)
Date:   Wed,  1 Dec 2021 17:03:58 +0000
In-Reply-To: <20211201170411.1561936-1-qperret@google.com>
Message-Id: <20211201170411.1561936-5-qperret@google.com>
Mime-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 04/15] KVM: arm64: Fixup hyp stage-1 refcount
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nVHE-protected mode, the hyp stage-1 page-table refcount is broken
due to the lack of refcount support in the early allocator. Fix-up the
refcount in the finalize walker, once the 'hyp_vmemmap' is up and running.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 578f71798c2e..875b5174342f 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -165,6 +165,7 @@ static int finalize_host_mappings_walker(u64 addr, u64 end, u32 level,
 					 enum kvm_pgtable_walk_flags flag,
 					 void * const arg)
 {
+	struct kvm_pgtable_mm_ops *mm_ops = arg;
 	enum kvm_pgtable_prot prot;
 	enum pkvm_page_state state;
 	kvm_pte_t pte = *ptep;
@@ -173,6 +174,15 @@ static int finalize_host_mappings_walker(u64 addr, u64 end, u32 level,
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
 
@@ -205,7 +215,8 @@ static int finalize_host_mappings(void)
 {
 	struct kvm_pgtable_walker walker = {
 		.cb	= finalize_host_mappings_walker,
-		.flags	= KVM_PGTABLE_WALK_LEAF,
+		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
+		.arg	= pkvm_pgtable.mm_ops,
 	};
 	int i, ret;
 
@@ -240,10 +251,6 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
-	ret = finalize_host_mappings();
-	if (ret)
-		goto out;
-
 	pkvm_pgtable_mm_ops = (struct kvm_pgtable_mm_ops) {
 		.zalloc_page = hyp_zalloc_hyp_page,
 		.phys_to_virt = hyp_phys_to_virt,
@@ -253,6 +260,10 @@ void __noreturn __pkvm_init_finalise(void)
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
2.34.0.rc2.393.gf8c9666880-goog

