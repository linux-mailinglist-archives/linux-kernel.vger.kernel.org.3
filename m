Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F6B475D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbhLOQNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244659AbhLOQN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:13:28 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B39C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:13:28 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id n22-20020adf8b16000000b001a22f61b29cso647930wra.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1Uv+uSK+k6gp/yCPD9bTsZMOeiUHXNuD9f7KA3qC+RU=;
        b=KHgYwK5BuPaiya24VhTskfkiHXY2KhERyO0Ns6i1bSlMuj6flpuQDquCIk2QoDFenC
         qTmtKo85C3U8k5CIbTtsPzVuIsDG0EzIcMAMs8xXZutQe60JwvibzIwGDQfXZrKXe9ip
         QOIdy2AkmCY6IoD11KQzFsIEcK0g0LRW1VCgr3FiPgyv3tZrI0lLtvljJpAS5pUS5VFe
         TjWXW9mB7oo0J5n+gli4u5slLrAbdAL3Hq+LMILIxsmiEb3tiuUplb0yyuM9saLdY1cd
         fAAII2+k49Xx7Lf+1kcWMi+20d3kSa1LrMGGBC90mBWw4Va6TToTO8C4rtUgIHTVn8ac
         MZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1Uv+uSK+k6gp/yCPD9bTsZMOeiUHXNuD9f7KA3qC+RU=;
        b=5g5t3BxjiRzasMILbLcE0fzs619is6gipYD2LD1+89z0REaw/xi+zcG+eJcSnvkXEo
         K/ssCJOVUtHEec4OkC+/H6rVswgp+i1OsJzVM+O+QBwUJF/nYgRX5XdM42KgpnBT9Jin
         AAoPO4F5I0N/n9IkyjoEZia0/7NdS9OHOQ5n8XRGmH5ll8KfY3MIrKjAaWWcWvlT/Pqp
         maASQrvpaOY7i/O5xV3p6C0puAiMa+6ma2h1x7JXiQN4PKQgYODgpDkXOaqcpMyopY+Q
         ZvK6sd7ihzCCizb2R10Uglyj9F1U1KURJfyrg58KLfGU0lzy7HXzUuK2ZE0iP8niUnpS
         HJSw==
X-Gm-Message-State: AOAM533rx45e0l4o1u73qx/8ZsUAxL9KzQollwIPfCqBAx2p898RHiy1
        Rtgv+HEyVmf/WmTgg9vpKnyJZkDx/xBy
X-Google-Smtp-Source: ABdhPJzmVQ2X/pz8yOEnI/iDk9eDx3O/fvoBqSDacRJg+34A6UuREUZ3WUgDTLdGeCW+BXycOlr3EccUsebH
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:fc03:4f5b:4e9b:3ec1])
 (user=qperret job=sendgmr) by 2002:a05:600c:4104:: with SMTP id
 j4mr540003wmi.178.1639584806973; Wed, 15 Dec 2021 08:13:26 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:12:29 +0000
In-Reply-To: <20211215161232.1480836-1-qperret@google.com>
Message-Id: <20211215161232.1480836-13-qperret@google.com>
Mime-Version: 1.0
References: <20211215161232.1480836-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 12/14] KVM: arm64: Implement do_unshare() helper for
 unsharing memory
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

Tearing down a previously shared memory region results in the borrower
losing access to the underlying pages and returning them to the "owned"
state in the owner.

Implement a do_unshare() helper, along the same lines as do_share(), to
provide this functionality for the host-to-hyp case.

Reviewed-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 115 ++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 14823e318585..2b23b2db8d4a 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -486,6 +486,16 @@ static int host_request_owned_transition(u64 *completer_addr,
 	return __host_check_page_state_range(addr, size, PKVM_PAGE_OWNED);
 }
 
+static int host_request_unshare(u64 *completer_addr,
+				const struct pkvm_mem_transition *tx)
+{
+	u64 size = tx->nr_pages * PAGE_SIZE;
+	u64 addr = tx->initiator.addr;
+
+	*completer_addr = tx->initiator.host.completer_addr;
+	return __host_check_page_state_range(addr, size, PKVM_PAGE_SHARED_OWNED);
+}
+
 static int host_initiate_share(u64 *completer_addr,
 			       const struct pkvm_mem_transition *tx)
 {
@@ -496,6 +506,16 @@ static int host_initiate_share(u64 *completer_addr,
 	return __host_set_page_state_range(addr, size, PKVM_PAGE_SHARED_OWNED);
 }
 
+static int host_initiate_unshare(u64 *completer_addr,
+				 const struct pkvm_mem_transition *tx)
+{
+	u64 size = tx->nr_pages * PAGE_SIZE;
+	u64 addr = tx->initiator.addr;
+
+	*completer_addr = tx->initiator.host.completer_addr;
+	return __host_set_page_state_range(addr, size, PKVM_PAGE_OWNED);
+}
+
 static enum pkvm_page_state hyp_get_page_state(kvm_pte_t pte)
 {
 	if (!kvm_pte_valid(pte))
@@ -536,6 +556,17 @@ static int hyp_ack_share(u64 addr, const struct pkvm_mem_transition *tx,
 	return __hyp_check_page_state_range(addr, size, PKVM_NOPAGE);
 }
 
+static int hyp_ack_unshare(u64 addr, const struct pkvm_mem_transition *tx)
+{
+	u64 size = tx->nr_pages * PAGE_SIZE;
+
+	if (__hyp_ack_skip_pgtable_check(tx))
+		return 0;
+
+	return __hyp_check_page_state_range(addr, size,
+					    PKVM_PAGE_SHARED_BORROWED);
+}
+
 static int hyp_complete_share(u64 addr, const struct pkvm_mem_transition *tx,
 			      enum kvm_pgtable_prot perms)
 {
@@ -546,6 +577,14 @@ static int hyp_complete_share(u64 addr, const struct pkvm_mem_transition *tx,
 	return pkvm_create_mappings_locked(start, end, prot);
 }
 
+static int hyp_complete_unshare(u64 addr, const struct pkvm_mem_transition *tx)
+{
+	u64 size = tx->nr_pages * PAGE_SIZE;
+	int ret = kvm_pgtable_hyp_unmap(&pkvm_pgtable, addr, size);
+
+	return (ret != size) ? -EFAULT : 0;
+}
+
 static int check_share(struct pkvm_mem_share *share)
 {
 	const struct pkvm_mem_transition *tx = &share->tx;
@@ -622,6 +661,82 @@ static int do_share(struct pkvm_mem_share *share)
 	return WARN_ON(__do_share(share));
 }
 
+static int check_unshare(struct pkvm_mem_share *share)
+{
+	const struct pkvm_mem_transition *tx = &share->tx;
+	u64 completer_addr;
+	int ret;
+
+	switch (tx->initiator.id) {
+	case PKVM_ID_HOST:
+		ret = host_request_unshare(&completer_addr, tx);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	switch (tx->completer.id) {
+	case PKVM_ID_HYP:
+		ret = hyp_ack_unshare(completer_addr, tx);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int __do_unshare(struct pkvm_mem_share *share)
+{
+	const struct pkvm_mem_transition *tx = &share->tx;
+	u64 completer_addr;
+	int ret;
+
+	switch (tx->initiator.id) {
+	case PKVM_ID_HOST:
+		ret = host_initiate_unshare(&completer_addr, tx);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	switch (tx->completer.id) {
+	case PKVM_ID_HYP:
+		ret = hyp_complete_unshare(completer_addr, tx);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/*
+ * do_unshare():
+ *
+ * The page owner revokes access from another component for a range of
+ * pages which were previously shared using do_share().
+ *
+ * Initiator: SHARED_OWNED	=> OWNED
+ * Completer: SHARED_BORROWED	=> NOPAGE
+ */
+static int do_unshare(struct pkvm_mem_share *share)
+{
+	int ret;
+
+	ret = check_unshare(share);
+	if (ret)
+		return ret;
+
+	return WARN_ON(__do_unshare(share));
+}
+
 int __pkvm_host_share_hyp(u64 pfn)
 {
 	int ret;
-- 
2.34.1.173.g76aa8bc2d0-goog

