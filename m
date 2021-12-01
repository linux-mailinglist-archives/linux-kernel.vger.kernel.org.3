Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202C446538E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351733AbhLARIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351703AbhLARHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:07:48 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F66BC061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:04:27 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id v62-20020a1cac41000000b0033719a1a714so12561010wme.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A7hr35xG6SzEHwDet74XtvHzJsI/X+Zg/yL5/WYnOz0=;
        b=ah12j+uUrkgUrk9b1HPkNYJu1wVkvH0SX1GjxWlFdsGE3bEQ46fAXvn0aJfcBwEo+8
         6LrYpwJQVU32AtFiqZZFehFhMRCpiksII11x5No7K2l4MzTVhOGCcKSwW4VsaKYB/KwZ
         STISVRv3cmicA+IFYacwY4r+EdcvE6uDIJ6X9F/HMudy2oqDeRgFfx9EYMTh5ZhcNkDE
         y+NXXLWJwOH5boJw7lqmcJwIiiAh7SITqADYhwT/9haBjdb8CHxhJXGD/TIgVldyEoGn
         uw+wuq1gmGXOB6VUh00f2IDCloa5CVB3P1CMZ5640YlWHcMYBtJVsIffUl4qaumK2x0t
         XUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A7hr35xG6SzEHwDet74XtvHzJsI/X+Zg/yL5/WYnOz0=;
        b=imOQkmP40CBljB90VdeWcN/1pf71WEjC7Sd5PirwDAvVhdcq+q1hhHAUO0P66zlYSN
         LDuU03Yb/fzXx97hQHloOO4w81/PZq704IIG4QpZUyrRf6lsQOybPbdI638e2F5M4tSY
         H/inXtA/OECAbIDUjAnLC0LSiVrRzSbcafEt+JJ5KoOgKnjzPP/2L0N5XTBg7swH4DD9
         35onqCUYdXnFV6PQMKrHsYbQj7PrFsV+CYD+Vi/iJ9aDs+1AIjqeLvtMA51rVc9zXtvh
         qidEhXpqlCOmleWdSY6fkiBDOta0QjTWRwBzdiK4yi8WJQ1xwRFJtISVBKEld6IkBVlT
         D6gQ==
X-Gm-Message-State: AOAM5302gHLJ/4wSSLbgBDnJnxIRuYnpcwrki03sSs7Dd8Fryqv6nFX1
        JoEYFL2Puz4blE/uUV6owU+a/9+ENqrU
X-Google-Smtp-Source: ABdhPJxp5L6PtF860OZ96JvJzz+R53mWZq1H92zAhum23/hQpBFE1gQt/KAt2QyLRQi8U4J5dXjZ/F1KEhLb
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1cab:1a20:2ef1:ddde])
 (user=qperret job=sendgmr) by 2002:a5d:40cf:: with SMTP id
 b15mr8314262wrq.161.1638378265569; Wed, 01 Dec 2021 09:04:25 -0800 (PST)
Date:   Wed,  1 Dec 2021 17:03:57 +0000
In-Reply-To: <20211201170411.1561936-1-qperret@google.com>
Message-Id: <20211201170411.1561936-4-qperret@google.com>
Mime-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 03/15] KVM: arm64: Refcount hyp stage-1 pgtable pages
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

To prepare the ground for allowing hyp stage-1 mappings to be removed at
run-time, update the KVM page-table code to maintain a correct refcount
using the ->{get,put}_page() function callbacks.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index f8ceebe4982e..768a58835153 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -408,8 +408,10 @@ static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 		return false;
 
 	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
-	if (hyp_pte_needs_update(old, new))
+	if (hyp_pte_needs_update(old, new)) {
 		smp_store_release(ptep, new);
+		data->mm_ops->get_page(ptep);
+	}
 
 	data->phys += granule;
 	return true;
@@ -433,6 +435,7 @@ static int hyp_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 		return -ENOMEM;
 
 	kvm_set_table_pte(ptep, childp, mm_ops);
+	mm_ops->get_page(ptep);
 	return 0;
 }
 
@@ -482,8 +485,16 @@ static int hyp_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
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
 
@@ -491,7 +502,7 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt)
 {
 	struct kvm_pgtable_walker walker = {
 		.cb	= hyp_free_walker,
-		.flags	= KVM_PGTABLE_WALK_TABLE_POST,
+		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
 		.arg	= pgt->mm_ops,
 	};
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

