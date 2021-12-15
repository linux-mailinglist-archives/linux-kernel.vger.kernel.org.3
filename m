Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02AD475D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244652AbhLOQN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244650AbhLOQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:13:24 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BABBC061747
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:13:24 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id q17-20020adfcd91000000b0017bcb12ad4fso6020212wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ErGzTwKr89qCblkEgesDiph0ZVTf33f4xYZuAhHXENo=;
        b=JFzGOoe7wEIoa7ofiFvx0O7xEqSKLffHVZviv3KfL412p5TVg7xXbsMbn7Je0BWo9K
         PhGl5H8niWw/tqDTqt0RDVmbeQ5eY1PlR9UuS84KW2LXaTmcqJebfzFl9dB5r6MAh/5N
         WYWfBHi+J3oeh0tYpMpfIv3YPvy4/GjffQkj0aYXtHhXPbPNwNU4hm9pxRRBGA2400Ok
         jv7an2mOQNTzGdBN7GUyO2FBJiPjYcs9u7/OGLrTS5Awu+Tr3Q1gchAAy1nOor9HR1Fp
         RpjlqoMwcigzlQc8H/lk/NpZtcgCP3jRVBSWBUezGG3LVh3cRj6FqblplmUoQOdNbNyH
         d+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ErGzTwKr89qCblkEgesDiph0ZVTf33f4xYZuAhHXENo=;
        b=5HmbzjR4GarsynR3MR+WJz01XfVRO4aAbMzlwCrzzPbgxhwwoFnT1mcM4pcLZlRQlx
         TtGmLfxCJIkBtPuVcFCxqF4eYmt00xRFpgyfzzPozyeHWKQ6DJGMQRbFNdUiD4jrv0Wi
         Y/ZMfRfJa2QEGut+BUGOs5dSStKtPCcaiEJif87NIGiOJILQ1Wle4uFvjEbuQ7MbvkYo
         UEwkJAzedHsMwRkWVQgsznW90flwHYKuf4XFa9LeOr2xvWpZDr5Ts25t8lLA9lBfwvTT
         HV0kd3iPPfRxvc5yJLGR/LNNSFkgyE5uFZ6qts7N73vP7bON62Ya920GggW36lOL583X
         5/pQ==
X-Gm-Message-State: AOAM530/JS1JfpTkYreqyt5wfpLOz+k60vZMuIZKfUBJvXKHisSPjId2
        c4Un/Yui1/5K2K7yD5c0hF/7m3Xh+V2E
X-Google-Smtp-Source: ABdhPJxh3qMrXIlyGH9SPFTDjo5KI6Z/OkMgigR3F7/zugDE3oqFZbPM/YJocdTgQ4kL8ntr51hKN49uIWyO
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:fc03:4f5b:4e9b:3ec1])
 (user=qperret job=sendgmr) by 2002:a05:600c:1c8d:: with SMTP id
 k13mr93836wms.0.1639584802523; Wed, 15 Dec 2021 08:13:22 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:12:28 +0000
In-Reply-To: <20211215161232.1480836-1-qperret@google.com>
Message-Id: <20211215161232.1480836-12-qperret@google.com>
Mime-Version: 1.0
References: <20211215161232.1480836-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 11/14] KVM: arm64: Implement __pkvm_host_share_hyp() using do_share()
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

From: Will Deacon <will@kernel.org>

__pkvm_host_share_hyp() shares memory between the host and the
hypervisor so implement it as an invocation of the new do_share()
mechanism.

Note that double-sharing is no longer permitted (as this allows us to
reduce the number of page-table walks significantly), but is thankfully
no longer relied upon by the host.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 121 +++++++-------------------
 1 file changed, 33 insertions(+), 88 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 666278632fed..14823e318585 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -371,94 +371,6 @@ static int host_stage2_idmap(u64 addr)
 	return ret;
 }
 
-static inline bool check_prot(enum kvm_pgtable_prot prot,
-			      enum kvm_pgtable_prot required,
-			      enum kvm_pgtable_prot denied)
-{
-	return (prot & (required | denied)) == required;
-}
-
-int __pkvm_host_share_hyp(u64 pfn)
-{
-	phys_addr_t addr = hyp_pfn_to_phys(pfn);
-	enum kvm_pgtable_prot prot, cur;
-	void *virt = __hyp_va(addr);
-	enum pkvm_page_state state;
-	kvm_pte_t pte;
-	int ret;
-
-	if (!addr_is_memory(addr))
-		return -EINVAL;
-
-	host_lock_component();
-	hyp_lock_component();
-
-	ret = kvm_pgtable_get_leaf(&host_kvm.pgt, addr, &pte, NULL);
-	if (ret)
-		goto unlock;
-	if (!pte)
-		goto map_shared;
-
-	/*
-	 * Check attributes in the host stage-2 PTE. We need the page to be:
-	 *  - mapped RWX as we're sharing memory;
-	 *  - not borrowed, as that implies absence of ownership.
-	 * Otherwise, we can't let it got through
-	 */
-	cur = kvm_pgtable_stage2_pte_prot(pte);
-	prot = pkvm_mkstate(0, PKVM_PAGE_SHARED_BORROWED);
-	if (!check_prot(cur, PKVM_HOST_MEM_PROT, prot)) {
-		ret = -EPERM;
-		goto unlock;
-	}
-
-	state = pkvm_getstate(cur);
-	if (state == PKVM_PAGE_OWNED)
-		goto map_shared;
-
-	/*
-	 * Tolerate double-sharing the same page, but this requires
-	 * cross-checking the hypervisor stage-1.
-	 */
-	if (state != PKVM_PAGE_SHARED_OWNED) {
-		ret = -EPERM;
-		goto unlock;
-	}
-
-	ret = kvm_pgtable_get_leaf(&pkvm_pgtable, (u64)virt, &pte, NULL);
-	if (ret)
-		goto unlock;
-
-	/*
-	 * If the page has been shared with the hypervisor, it must be
-	 * already mapped as SHARED_BORROWED in its stage-1.
-	 */
-	cur = kvm_pgtable_hyp_pte_prot(pte);
-	prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_SHARED_BORROWED);
-	if (!check_prot(cur, prot, ~prot))
-		ret = -EPERM;
-	goto unlock;
-
-map_shared:
-	/*
-	 * If the page is not yet shared, adjust mappings in both page-tables
-	 * while both locks are held.
-	 */
-	prot = pkvm_mkstate(PAGE_HYP, PKVM_PAGE_SHARED_BORROWED);
-	ret = pkvm_create_mappings_locked(virt, virt + PAGE_SIZE, prot);
-	BUG_ON(ret);
-
-	prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, PKVM_PAGE_SHARED_OWNED);
-	ret = host_stage2_idmap_locked(addr, PAGE_SIZE, prot);
-	BUG_ON(ret);
-
-unlock:
-	hyp_unlock_component();
-	host_unlock_component();
-
-	return ret;
-}
-
 void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
 {
 	struct kvm_vcpu_fault_info fault;
@@ -709,3 +621,36 @@ static int do_share(struct pkvm_mem_share *share)
 
 	return WARN_ON(__do_share(share));
 }
+
+int __pkvm_host_share_hyp(u64 pfn)
+{
+	int ret;
+	u64 host_addr = hyp_pfn_to_phys(pfn);
+	u64 hyp_addr = (u64)__hyp_va(host_addr);
+	struct pkvm_mem_share share = {
+		.tx	= {
+			.nr_pages	= 1,
+			.initiator	= {
+				.id	= PKVM_ID_HOST,
+				.addr	= host_addr,
+				.host	= {
+					.completer_addr = hyp_addr,
+				},
+			},
+			.completer	= {
+				.id	= PKVM_ID_HYP,
+			},
+		},
+		.completer_prot	= PAGE_HYP,
+	};
+
+	host_lock_component();
+	hyp_lock_component();
+
+	ret = do_share(&share);
+
+	hyp_unlock_component();
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.34.1.173.g76aa8bc2d0-goog

