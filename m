Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7014D8DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244851AbiCNUD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244694AbiCNUDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:03:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DA73EAA2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:02:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dcd6a5e4b6so141149877b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=fM7xdaekwmagyuKy0kdx3p5v2FfzYu7Y7vGXarjRfKM=;
        b=Jju9oT+vQW6Extb2//d+2hPcrzdqRTRz8LLvYdwkCzvVoHbTYTsLeq6DDN9pwSg4ex
         dJuDeCwtJBErKNwSBqyIMYZ6AFZs+yiF2LMOhtVE+Cb37YqZS3LzXs37tEsjiA8u3Vsn
         RMHL0VeQfR4FN1Xux9ZdmyC65BaUdLmGfAI+3qxiGPwG/xUCjE9QBN701VL5QjJIAUK2
         sZcfFSMlrS9+17Y5ylq6szGPggUXnm/2kkUQ32XTCsVEKMh+gx80kgkhvJ6ikwn8kqNU
         GAoNNxigrbH/N2vf6cWg6NpJhPXDn4FL/pVYIKx5ca8jpSu3DjX0MUTI1xeaBoH/PlkP
         kahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=fM7xdaekwmagyuKy0kdx3p5v2FfzYu7Y7vGXarjRfKM=;
        b=AuMGN82aOHJOhRgjMx0MedjwB20ZICWn8VG6vEz1NGrx1vjRR5ISg6H4675IU/y2pA
         NPRypHu8w2BHhB0mCUiTZRDYe/m/Whs5ebctvyE+AiCXbmfgIA+kHl+pxmx+52DbQrjg
         fpj4qmZa0dCH4amVg1GRK79OPyBuU2kdejoAqjIchak3rfiQ3LCweKc5f1ypM9nQzDRe
         fa3hWnrtcQlJIgsX2SHqRDFH5O4QvFrI0bIjOIba0C6De10j48ox8AJl5vkWhTkwlIui
         JlrHzsCU4F71pbj0E5P+Y7MW5h9VlUwr/RuNw/u89O6zGUsWC2CTnKkoR9Z/hv+zDD0Z
         vTPQ==
X-Gm-Message-State: AOAM531TVA1IdnwgyWT3jg5Vs3BCDB8k2UH2OwXg20b/ebC6qKjp5Pqa
        1rVSO4orY/wh+KbrlGpeckSE7s9fT4/34+sFmA==
X-Google-Smtp-Source: ABdhPJx9FWdZStCzmeuHXnB38FrYj2l6xi5QsttqJvp/Oho17IbEa6feRFDkIv3tMXYmLFL0VOkW/PwFarS6dq/e3Q==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:500a:9ac2:e73e:69e3])
 (user=kaleshsingh job=sendgmr) by 2002:a0d:d546:0:b0:2dc:5667:8642 with SMTP
 id x67-20020a0dd546000000b002dc56678642mr20779116ywd.111.1647288163318; Mon,
 14 Mar 2022 13:02:43 -0700 (PDT)
Date:   Mon, 14 Mar 2022 13:01:10 -0700
In-Reply-To: <20220314200148.2695206-1-kaleshsingh@google.com>
Message-Id: <20220314200148.2695206-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH v6 1/8] KVM: arm64: Introduce hyp_alloc_private_va_range()
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrew Scull <ascull@google.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hyp_alloc_private_va_range() can be used to reserve private VA ranges
in the nVHE hypervisor. Allocations are aligned based on the order of
the requested size.

This will be used to implement stack guard pages for KVM nVHE hypervisor
(nVHE Hyp mode / not pKVM), in a subsequent patch in the series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v6:
  - Update kernel-doc for hyp_alloc_private_va_range()
    and add return description, per Stephen
  - Update hyp_alloc_private_va_range() to return an int error code,
    per Stephen
  - Replace IS_ERR() checks with IS_ERR_VALUE() check, per Stephen
  - Clean up goto, per Stephen

Changes in v5:
  - Align private allocations based on the order of their size, per Marc

Changes in v4:
  - Handle null ptr in hyp_alloc_private_va_range() and replace
    IS_ERR_OR_NULL checks in callers with IS_ERR checks, per Fuad
  - Fix kernel-doc comments format, per Fuad

Changes in v3:
  - Handle null ptr in IS_ERR_OR_NULL checks, per Mark


 arch/arm64/include/asm/kvm_mmu.h |  1 +
 arch/arm64/kvm/mmu.c             | 66 +++++++++++++++++++++-----------
 2 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 81839e9a8a24..3cc9aa25f510 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -153,6 +153,7 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 int kvm_share_hyp(void *from, void *to);
 void kvm_unshare_hyp(void *from, void *to);
 int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
+int hyp_alloc_private_va_range(size_t size, unsigned long *haddr);
 int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 			   void __iomem **kaddr,
 			   void __iomem **haddr);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index bc2aba953299..7326d683c500 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -457,23 +457,22 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 	return 0;
 }
 
-static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
-					unsigned long *haddr,
-					enum kvm_pgtable_prot prot)
+
+/**
+ * hyp_alloc_private_va_range - Allocates a private VA range.
+ * @size:	The size of the VA range to reserve.
+ * @haddr:	The hypervisor virtual start address of the allocation.
+ *
+ * The private virtual address (VA) range is allocated below io_map_base
+ * and aligned based on the order of @size.
+ *
+ * Return: 0 on success or negative error code on failure.
+ */
+int hyp_alloc_private_va_range(size_t size, unsigned long *haddr)
 {
 	unsigned long base;
 	int ret = 0;
 
-	if (!kvm_host_owns_hyp_mappings()) {
-		base = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
-					 phys_addr, size, prot);
-		if (IS_ERR_OR_NULL((void *)base))
-			return PTR_ERR((void *)base);
-		*haddr = base;
-
-		return 0;
-	}
-
 	mutex_lock(&kvm_hyp_pgd_mutex);
 
 	/*
@@ -484,30 +483,53 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
 	 *
 	 * The allocated size is always a multiple of PAGE_SIZE.
 	 */
-	size = PAGE_ALIGN(size + offset_in_page(phys_addr));
-	base = io_map_base - size;
+	base = io_map_base - PAGE_ALIGN(size);
+
+	/* Align the allocation based on the order of its size */
+	base = ALIGN_DOWN(base, PAGE_SIZE << get_order(size));
 
 	/*
 	 * Verify that BIT(VA_BITS - 1) hasn't been flipped by
 	 * allocating the new area, as it would indicate we've
 	 * overflowed the idmap/IO address range.
 	 */
-	if ((base ^ io_map_base) & BIT(VA_BITS - 1))
+	if (!base || (base ^ io_map_base) & BIT(VA_BITS - 1))
 		ret = -ENOMEM;
 	else
-		io_map_base = base;
+		*haddr = io_map_base = base;
 
 	mutex_unlock(&kvm_hyp_pgd_mutex);
 
+	return ret;
+}
+
+static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
+					unsigned long *haddr,
+					enum kvm_pgtable_prot prot)
+{
+	unsigned long addr;
+	int ret = 0;
+
+	if (!kvm_host_owns_hyp_mappings()) {
+		addr = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
+					 phys_addr, size, prot);
+		if (IS_ERR_VALUE(addr))
+			return addr;
+		*haddr = addr;
+
+		return 0;
+	}
+
+	size += offset_in_page(phys_addr);
+	ret = hyp_alloc_private_va_range(size, &addr);
 	if (ret)
-		goto out;
+		return ret;
 
-	ret = __create_hyp_mappings(base, size, phys_addr, prot);
+	ret = __create_hyp_mappings(addr, size, phys_addr, prot);
 	if (ret)
-		goto out;
+		return ret;
 
-	*haddr = base + offset_in_page(phys_addr);
-out:
+	*haddr = addr + offset_in_page(phys_addr);
 	return ret;
 }
 
-- 
2.35.1.723.g4982287a31-goog

