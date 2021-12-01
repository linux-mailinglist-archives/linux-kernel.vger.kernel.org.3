Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255F846539D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244210AbhLARJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243550AbhLARIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:08:31 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C24EC0613D7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:04:47 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id r2-20020adfe682000000b00198af042b0dso4462553wrm.23
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3kGqtrkDX/7YFDJqNxF3cw4ExJXKG5GDRcsjJYQ/JVo=;
        b=TMO4hW6gBvmBsrzVeqH/Hwa2gs9Xbv3N2Qp7sh2MQz/vWRh6mkuEatIkrGrTZf3Z4I
         J4ZT0n9fQuNxYUa41Q/bfrGeXJfXoAxp0fVLJYsUlcz4fJ9elw13634GMg/GtfXBD9gS
         HgsZuqhwLHubwI2YpiTsQ5gPYmF4oiPV0t0LYGbZQsqW5tsVfYeH3pZdLC20OCtG9SBk
         hhssObLi/zjJz/dfhhWUJZkRS15K+o5PXPkzjL6lAnmts21mdTmxYXoGDWcbisE6lvjw
         Zdp4uo94fV72wWfRF6SQkDM9TrvSF/jxNwMbnGAP2S4QVSSagWKieTx6L10xi1OZqvWY
         FH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3kGqtrkDX/7YFDJqNxF3cw4ExJXKG5GDRcsjJYQ/JVo=;
        b=M42I+nhok0eZu/c8ZGwzycwAaxtHGm331W8FYlp95vCGoEDvZrP9IXZGwbUJAkucA2
         bRo7kdNBAf8JODe18yLhe42TddBPEvO4diePmnG+sr6zcyurG5fZ/pcUq3SYJ8tLOFXT
         fbGoQm9FXjCd4ABoHkolahK5DmIi4LlWb19MLJvpl0vcCzOg6CN0ydLzLjVgs7O0HSWI
         fs7TsQtE7L2ZykYgwGTR4IAU1j1v3Xgqn/r5SNMTW8tvUGg3B7bO586/B7Dqmh1eh8Rd
         wuGudxzZ+g0+TEJAbSD8EaXT5jCM7eM8UbTuZZAkhzvPvNS2RtmF4kEMDx831bkCIaVW
         ee9A==
X-Gm-Message-State: AOAM532AXvmCbjQL2fvAnxfIICeu6xgjVozAvQExEFxkxd+pE2bDVevc
        2X8ACePBpO0TEnHnq+BG4EtOxdCHoW1b
X-Google-Smtp-Source: ABdhPJzzYr8OrnKjxfmfCT1wD/gpPb9rlHIvVwT+T1gmq0Ql8fSZ2Xu5j+Ura+iJuS9E70AhlNnb1YCGJ043
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1cab:1a20:2ef1:ddde])
 (user=qperret job=sendgmr) by 2002:a05:600c:4e07:: with SMTP id
 b7mr8305933wmq.16.1638378285742; Wed, 01 Dec 2021 09:04:45 -0800 (PST)
Date:   Wed,  1 Dec 2021 17:04:02 +0000
In-Reply-To: <20211201170411.1561936-1-qperret@google.com>
Message-Id: <20211201170411.1561936-9-qperret@google.com>
Mime-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 08/15] KVM: arm64: pkvm: Refcount the pages shared with EL2
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

In order to simplify the page tracking infrastructure at EL2 in nVHE
protected mode, move the responsibility of refcounting pages that are
shared multiple times on the host. In order to do so, let's create a
red-black tree tracking all the PFNs that have been shared, along with
a refcount.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/mmu.c | 78 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index fd868fb9d922..d72566896755 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -284,23 +284,72 @@ static phys_addr_t kvm_kaddr_to_phys(void *kaddr)
 	}
 }
 
-static int pkvm_share_hyp(phys_addr_t start, phys_addr_t end)
+struct hyp_shared_pfn {
+	u64 pfn;
+	int count;
+	struct rb_node node;
+};
+
+static DEFINE_MUTEX(hyp_shared_pfns_lock);
+static struct rb_root hyp_shared_pfns = RB_ROOT;
+
+static struct hyp_shared_pfn *find_shared_pfn(u64 pfn, struct rb_node ***node,
+					      struct rb_node **parent)
 {
-	phys_addr_t addr;
-	int ret;
+	struct hyp_shared_pfn *this;
+
+	*node = &hyp_shared_pfns.rb_node;
+	*parent = NULL;
+	while (**node) {
+		this = container_of(**node, struct hyp_shared_pfn, node);
+		*parent = **node;
+		if (this->pfn < pfn)
+			*node = &((**node)->rb_left);
+		else if (this->pfn > pfn)
+			*node = &((**node)->rb_right);
+		else
+			return this;
+	}
 
-	for (addr = ALIGN_DOWN(start, PAGE_SIZE); addr < end; addr += PAGE_SIZE) {
-		ret = kvm_call_hyp_nvhe(__pkvm_host_share_hyp,
-					__phys_to_pfn(addr));
-		if (ret)
-			return ret;
+	return NULL;
+}
+
+static int share_pfn_hyp(u64 pfn)
+{
+	struct rb_node **node, *parent;
+	struct hyp_shared_pfn *this;
+	int ret = 0;
+
+	mutex_lock(&hyp_shared_pfns_lock);
+	this = find_shared_pfn(pfn, &node, &parent);
+	if (this) {
+		this->count++;
+		goto unlock;
 	}
 
-	return 0;
+	this = kzalloc(sizeof(*this), GFP_KERNEL);
+	if (!this) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	this->pfn = pfn;
+	this->count = 1;
+	rb_link_node(&this->node, parent, node);
+	rb_insert_color(&this->node, &hyp_shared_pfns);
+	ret = kvm_call_hyp_nvhe(__pkvm_host_share_hyp, pfn, 1);
+unlock:
+	mutex_unlock(&hyp_shared_pfns_lock);
+
+	return ret;
 }
 
 int kvm_share_hyp(void *from, void *to)
 {
+	phys_addr_t start, end, cur;
+	u64 pfn;
+	int ret;
+
 	if (is_kernel_in_hyp_mode())
 		return 0;
 
@@ -315,7 +364,16 @@ int kvm_share_hyp(void *from, void *to)
 	if (kvm_host_owns_hyp_mappings())
 		return create_hyp_mappings(from, to, PAGE_HYP);
 
-	return pkvm_share_hyp(__pa(from), __pa(to));
+	start = ALIGN_DOWN(__pa(from), PAGE_SIZE);
+	end = PAGE_ALIGN(__pa(to));
+	for (cur = start; cur < end; cur += PAGE_SIZE) {
+		pfn = __phys_to_pfn(cur);
+		ret = share_pfn_hyp(pfn);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 /**
-- 
2.34.0.rc2.393.gf8c9666880-goog

