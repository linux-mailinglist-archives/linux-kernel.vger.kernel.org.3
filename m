Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674A9475D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244640AbhLOQNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244650AbhLOQNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:13:19 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D10C061401
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:13:19 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id p13-20020a05600c1d8d00b0034565e7e5c6so1373898wms.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1o38A9BI+r7dP43P34m5TydxbsI3e27ltr6SQ6Ewz8I=;
        b=LaRj4F6ubxri/nlRyOjmvFbJagUzE92BIeQpC1eoyaT3+xNdixw079Me2l0RqYwdcI
         ghIhCMB7riltQWtza9GFejvZkbIAdwfVrvueb+g3z8FbLOVTbpCKBM1ZNm+CzLgBezK+
         Dm7bzPezMnOIZf0/AR/fuRnZbQnqWspwV0E+NMDqr+7AhRiWgvwmWQcVn3yIPrwW2r7I
         Qf6ZXukeGvQBE1FjTbgq+aXE+wm9yj2kwRYhLcethvspojRXPHYKmyvzfPM+7swsr155
         YggJMLubJqB5VN8HsWDEVO06HqDr0pC/RS5V063AaaXhCenlLuBmv1uCtNTI0gRMcLgr
         2ikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1o38A9BI+r7dP43P34m5TydxbsI3e27ltr6SQ6Ewz8I=;
        b=cTCwFocL+0jxlw4C9UcDczLToNNli1r43ulkjGuEqGO+7NcRKp3XgbRnRs13WOh3rm
         h2tAlQEIBJGlLix2bXpj711qbj6PNix7xrFmF/ShHGkVwlANofCC8fO+o9nkze+u57Oc
         SWxSXi6KNypMwlx3E98PQ6oJ1P59mGeYkNur5DS2ApPpNHDGRZMi/fJ/jA3lMYKFvXjJ
         27lu4ZLNapTRbr7NFNHDI1U/HpXM0TZ3EREeBQknOnya5rJNAdwKMcy2LVDnnakeCqGI
         woBrsH5DfyB4ZnIldXwEU7t/bTfqq09wNilXVfRSvIN/Cb+O7Nwv6m5qej8qufRtNiXY
         Korg==
X-Gm-Message-State: AOAM531FOIlZUm2IoAgKk2s0DiV8Yqd7uKiX30q8NJE20dWQzOAUzUEy
        tBVFjKLkQT1neZ3bDPrp5JH7lzoABDd9
X-Google-Smtp-Source: ABdhPJyxyB2n1To7SK89h+iSB1x6MuCPpXPoIrkqY5mnsl1QjaBX/fM+8EPHUY/eGgqVXdsENZ37hD09emLN
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:fc03:4f5b:4e9b:3ec1])
 (user=qperret job=sendgmr) by 2002:adf:ee42:: with SMTP id
 w2mr4964964wro.7.1639584798107; Wed, 15 Dec 2021 08:13:18 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:12:27 +0000
In-Reply-To: <20211215161232.1480836-1-qperret@google.com>
Message-Id: <20211215161232.1480836-11-qperret@google.com>
Mime-Version: 1.0
References: <20211215161232.1480836-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 10/14] KVM: arm64: Implement do_share() helper for sharing memory
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

By default, protected KVM isolates memory pages so that they are
accessible only to their owner: be it the host kernel, the hypervisor
at EL2 or (in future) the guest. Establishing shared-memory regions
between these components therefore involves a transition for each page
so that the owner can share memory with a borrower under a certain set
of permissions.

Introduce a do_share() helper for safely sharing a memory region between
two components. Currently, only host-to-hyp sharing is implemented, but
the code is easily extended to handle other combinations and the
permission checks for each component are reusable.

Reviewed-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 237 ++++++++++++++++++++++++++
 1 file changed, 237 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 907d3cbf1809..666278632fed 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -472,3 +472,240 @@ void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
 	ret = host_stage2_idmap(addr);
 	BUG_ON(ret && ret != -EAGAIN);
 }
+
+/* This corresponds to locking order */
+enum pkvm_component_id {
+	PKVM_ID_HOST,
+	PKVM_ID_HYP,
+};
+
+struct pkvm_mem_transition {
+	u64				nr_pages;
+
+	struct {
+		enum pkvm_component_id	id;
+		/* Address in the initiator's address space */
+		u64			addr;
+
+		union {
+			struct {
+				/* Address in the completer's address space */
+				u64	completer_addr;
+			} host;
+		};
+	} initiator;
+
+	struct {
+		enum pkvm_component_id	id;
+	} completer;
+};
+
+struct pkvm_mem_share {
+	const struct pkvm_mem_transition	tx;
+	const enum kvm_pgtable_prot		completer_prot;
+};
+
+struct check_walk_data {
+	enum pkvm_page_state	desired;
+	enum pkvm_page_state	(*get_page_state)(kvm_pte_t pte);
+};
+
+static int __check_page_state_visitor(u64 addr, u64 end, u32 level,
+				      kvm_pte_t *ptep,
+				      enum kvm_pgtable_walk_flags flag,
+				      void * const arg)
+{
+	struct check_walk_data *d = arg;
+	kvm_pte_t pte = *ptep;
+
+	if (kvm_pte_valid(pte) && !addr_is_memory(kvm_pte_to_phys(pte)))
+		return -EINVAL;
+
+	return d->get_page_state(pte) == d->desired ? 0 : -EPERM;
+}
+
+static int check_page_state_range(struct kvm_pgtable *pgt, u64 addr, u64 size,
+				  struct check_walk_data *data)
+{
+	struct kvm_pgtable_walker walker = {
+		.cb	= __check_page_state_visitor,
+		.arg	= data,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
+	};
+
+	return kvm_pgtable_walk(pgt, addr, size, &walker);
+}
+
+static enum pkvm_page_state host_get_page_state(kvm_pte_t pte)
+{
+	if (!kvm_pte_valid(pte) && pte)
+		return PKVM_NOPAGE;
+
+	return pkvm_getstate(kvm_pgtable_stage2_pte_prot(pte));
+}
+
+static int __host_check_page_state_range(u64 addr, u64 size,
+					 enum pkvm_page_state state)
+{
+	struct check_walk_data d = {
+		.desired	= state,
+		.get_page_state	= host_get_page_state,
+	};
+
+	hyp_assert_lock_held(&host_kvm.lock);
+	return check_page_state_range(&host_kvm.pgt, addr, size, &d);
+}
+
+static int __host_set_page_state_range(u64 addr, u64 size,
+				       enum pkvm_page_state state)
+{
+	enum kvm_pgtable_prot prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, state);
+
+	return host_stage2_idmap_locked(addr, size, prot);
+}
+
+static int host_request_owned_transition(u64 *completer_addr,
+					 const struct pkvm_mem_transition *tx)
+{
+	u64 size = tx->nr_pages * PAGE_SIZE;
+	u64 addr = tx->initiator.addr;
+
+	*completer_addr = tx->initiator.host.completer_addr;
+	return __host_check_page_state_range(addr, size, PKVM_PAGE_OWNED);
+}
+
+static int host_initiate_share(u64 *completer_addr,
+			       const struct pkvm_mem_transition *tx)
+{
+	u64 size = tx->nr_pages * PAGE_SIZE;
+	u64 addr = tx->initiator.addr;
+
+	*completer_addr = tx->initiator.host.completer_addr;
+	return __host_set_page_state_range(addr, size, PKVM_PAGE_SHARED_OWNED);
+}
+
+static enum pkvm_page_state hyp_get_page_state(kvm_pte_t pte)
+{
+	if (!kvm_pte_valid(pte))
+		return PKVM_NOPAGE;
+
+	return pkvm_getstate(kvm_pgtable_stage2_pte_prot(pte));
+}
+
+static int __hyp_check_page_state_range(u64 addr, u64 size,
+					enum pkvm_page_state state)
+{
+	struct check_walk_data d = {
+		.desired	= state,
+		.get_page_state	= hyp_get_page_state,
+	};
+
+	hyp_assert_lock_held(&pkvm_pgd_lock);
+	return check_page_state_range(&pkvm_pgtable, addr, size, &d);
+}
+
+static bool __hyp_ack_skip_pgtable_check(const struct pkvm_mem_transition *tx)
+{
+	return !(IS_ENABLED(CONFIG_NVHE_EL2_DEBUG) ||
+		 tx->initiator.id != PKVM_ID_HOST);
+}
+
+static int hyp_ack_share(u64 addr, const struct pkvm_mem_transition *tx,
+			 enum kvm_pgtable_prot perms)
+{
+	u64 size = tx->nr_pages * PAGE_SIZE;
+
+	if (perms != PAGE_HYP)
+		return -EPERM;
+
+	if (__hyp_ack_skip_pgtable_check(tx))
+		return 0;
+
+	return __hyp_check_page_state_range(addr, size, PKVM_NOPAGE);
+}
+
+static int hyp_complete_share(u64 addr, const struct pkvm_mem_transition *tx,
+			      enum kvm_pgtable_prot perms)
+{
+	void *start = (void *)addr, *end = start + (tx->nr_pages * PAGE_SIZE);
+	enum kvm_pgtable_prot prot;
+
+	prot = pkvm_mkstate(perms, PKVM_PAGE_SHARED_BORROWED);
+	return pkvm_create_mappings_locked(start, end, prot);
+}
+
+static int check_share(struct pkvm_mem_share *share)
+{
+	const struct pkvm_mem_transition *tx = &share->tx;
+	u64 completer_addr;
+	int ret;
+
+	switch (tx->initiator.id) {
+	case PKVM_ID_HOST:
+		ret = host_request_owned_transition(&completer_addr, tx);
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
+		ret = hyp_ack_share(completer_addr, tx, share->completer_prot);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int __do_share(struct pkvm_mem_share *share)
+{
+	const struct pkvm_mem_transition *tx = &share->tx;
+	u64 completer_addr;
+	int ret;
+
+	switch (tx->initiator.id) {
+	case PKVM_ID_HOST:
+		ret = host_initiate_share(&completer_addr, tx);
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
+		ret = hyp_complete_share(completer_addr, tx, share->completer_prot);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/*
+ * do_share():
+ *
+ * The page owner grants access to another component with a given set
+ * of permissions.
+ *
+ * Initiator: OWNED	=> SHARED_OWNED
+ * Completer: NOPAGE	=> SHARED_BORROWED
+ */
+static int do_share(struct pkvm_mem_share *share)
+{
+	int ret;
+
+	ret = check_share(share);
+	if (ret)
+		return ret;
+
+	return WARN_ON(__do_share(share));
+}
-- 
2.34.1.173.g76aa8bc2d0-goog

