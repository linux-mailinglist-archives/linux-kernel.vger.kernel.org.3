Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7394653A1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351787AbhLARJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351735AbhLARIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:08:43 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA5CC0613F1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:05:07 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id q5-20020a5d5745000000b00178abb72486so4461724wrw.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q/onK/NKlbcaX4KhfxRAjbAZkoN+SiOcre92D8hLf9o=;
        b=aul30UamSYt4Ckyai5kRTFmEJuXbGut32orKNWwnc9AayiXqn+TxLOd7v1BpFQ1BkV
         GbCmN3XKpHNrtpSiY4CcZt0+PMOPn9pIlCl5IYKNx/AzLVDxuTWDGyHkUEIHTm4F+7cP
         cfs5tvOShjkY1ghkmPC8ee+EsApXcRTCfMeKKWXX/PXQg+tWXSxLdryzJzl8FhLuN8Hk
         y6S4a8zmzBAclLt3d+Vt4GfxGLQIz3KoJinZGxhw7iraE71AsYv3QtwpJOmgwWU/nFDT
         kk6AcCiotX0F6MR0Ngy6Cts7whuy5SakHBFyAf4/uFCGznBRUGtBNTXqhMkf8eot6Ri6
         r4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q/onK/NKlbcaX4KhfxRAjbAZkoN+SiOcre92D8hLf9o=;
        b=6TfEJycb1ua/E6NoP7TRKhTKq0Z71Cj6/Yb6JULqThct0Cw4ODGAkZ77TqHiHjwCH8
         Hipl0ksVAa236o///eWxqnSj+0q9LO73/AhbvkmqrOJpi7sOPRag2ch+eNXFM5cWwDPU
         bC2FLhYZyGbuiXau6ik2FwQ5CmQEaf4zH4tqoEyMUVNjQ/62pwWqQQ3a5XOtA4cRlVf0
         CVcqqDm8crp8rd1rVBcJchBxW8NovA+QOC95/oo3CwWih0ZBZlux1rg3vbCswtAg+evv
         +uaOUHJMjBj+dNW8njmLu00JoeTHy8dPJyMW2+rnguINL9SkykkucXvmuKZnHoY9LRmg
         tmZQ==
X-Gm-Message-State: AOAM530nbRR6LfY96KH9Z5PQ/ohCvQh0ICnkGHyXWpCenOqvEntDNGiq
        QK9UY9Nm9yS5KSR52mUygjv7EL8rhjtH
X-Google-Smtp-Source: ABdhPJy8c9GuXRQczl6Iol0RhaVFPr754ddoPaIqPgP6tAiFNldL0Xn8h+g/trLyF7Bg2zGWhojVvIGkL+73
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1cab:1a20:2ef1:ddde])
 (user=qperret job=sendgmr) by 2002:a05:600c:500a:: with SMTP id
 n10mr9113665wmr.136.1638378305616; Wed, 01 Dec 2021 09:05:05 -0800 (PST)
Date:   Wed,  1 Dec 2021 17:04:07 +0000
In-Reply-To: <20211201170411.1561936-1-qperret@google.com>
Message-Id: <20211201170411.1561936-14-qperret@google.com>
Mime-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 13/15] KVM: arm64: Implement do_unshare() helper for
 unsharing memory
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

From: Will Deacon <will@kernel.org>

Tearing down a previously shared memory region results in the borrower
losing access to the underlying pages and returning them to the "owned"
state in the owner.

Implement a do_unshare() helper, along the same lines as do_share(), to
provide this functionality for the host-to-hyp case.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 115 ++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 1282cbd6b9b3..43b25e2de780 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -485,6 +485,16 @@ static int host_request_owned_transition(u64 *completer_addr,
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
@@ -495,6 +505,16 @@ static int host_initiate_share(u64 *completer_addr,
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
@@ -535,6 +555,17 @@ static int hyp_ack_share(u64 addr, const struct pkvm_mem_transition *tx,
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
@@ -545,6 +576,14 @@ static int hyp_complete_share(u64 addr, const struct pkvm_mem_transition *tx,
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
@@ -621,6 +660,82 @@ static int do_share(struct pkvm_mem_share *share)
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
2.34.0.rc2.393.gf8c9666880-goog

