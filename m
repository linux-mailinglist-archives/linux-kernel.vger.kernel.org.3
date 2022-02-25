Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576F24C3C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiBYDj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbiBYDj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:39:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509251F76B2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:39:26 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b64-20020a256743000000b0061e169a5f19so2005545ybc.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=3z7umWzjiaBi0H0VxEKou4UGWFcI8zJgOh8cZtYt5r8=;
        b=cSis1zFbDzg8HujAEb1ym/V6ME+YJ6BjUBqNYot/d81BO3h6D3Zk4WnTOTGc+6rl/a
         A1zpsu/lBasqxVBWEud7ld822jEooEBgrJsZMHuRMEVpfetkVIKN1s3ZYYpUx9+5/prc
         mBkto3DjqaO5JCwqXh801epJZthVVkZyzdjfKtgf6mptDewViPTKTLabmUOSYyPXrDQv
         cRZxkoyy97EAVUdmXTOT7ZsGdSwEwW2Kj8uqeQJUPxPMBB2z1yhVoKxwAqNUN6Inq610
         wbd175TAvAMgG+YXzuUlp1+rLhkDzzcYQgJ93AXxefT4SUK0W9EQew3+ipLub9HkmUPL
         XFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=3z7umWzjiaBi0H0VxEKou4UGWFcI8zJgOh8cZtYt5r8=;
        b=xvjb0/f8oNaRYlmZ8aZYZfUt8QFD4DLLvfpwUgJe9wr9TbaUQIa27bbFuBypNAYlNh
         SVZeq9iTSlC6jN7+m/LOpPx0xLQZNYmGL26uv54Cui2QYIKmv62mbzpMrFKh85K7h3m1
         Uy/2ht13OjIt7/BYtCWQIvy5Cm2UgTzu5b1zHjy4Dg/Aii83XTT5QDDELrQPhChg2vmb
         bDBBN3+t6cEEn3MCBLKJywtl2GnvIc3o5HlF8q5a2q7Tn/jjRbZLlvYHgPhurp4jlYQM
         9X+Ee5nx77QFGqvHAJA/Aot7uaYfo/bRooyrodYAzWoim59fzrt6lIZCeJs5loUvWivn
         A3/g==
X-Gm-Message-State: AOAM531aMxY6PNOfrLsXGU5i4u6gyLvYlblD1r3T+cFwCHHmIA6e+YIv
        97ZQKLVSUAjoVJPF/DMdmj5Tl9FiaRpuq3FLHw==
X-Google-Smtp-Source: ABdhPJzpCeaHUbNSr0tCnAVkQAGHMc2xtowI3g9fyEbYLjuQ5ZyqNkyEST6Fzl5lL9PO8MaOgXM5S0SNbU3r/dG5Dg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:3a50:90b2:e6a2:9060])
 (user=kaleshsingh job=sendgmr) by 2002:a25:13c6:0:b0:61e:105e:d291 with SMTP
 id 189-20020a2513c6000000b0061e105ed291mr5499552ybt.104.1645760365539; Thu,
 24 Feb 2022 19:39:25 -0800 (PST)
Date:   Thu, 24 Feb 2022 19:34:46 -0800
In-Reply-To: <20220225033548.1912117-1-kaleshsingh@google.com>
Message-Id: <20220225033548.1912117-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220225033548.1912117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v4 1/8] KVM: arm64: Introduce hyp_alloc_private_va_range()
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
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
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
in the nVHE hypervisor. Also update  __create_hyp_private_mapping()
to allow specifying an alignment for the private VA mapping.

These will be used to implement stack guard pages for KVM nVHE hypervisor
(nVHE Hyp mode / not pKVM), in a subsequent patch in the series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v4:
  - Handle null ptr in hyp_alloc_private_va_range() and replace
    IS_ERR_OR_NULL checks in callers with IS_ERR checks, per Fuad
  - Fix kernel-doc comments format, per Fuad

Changes in v3:
  - Handle null ptr in IS_ERR_OR_NULL checks, per Mark

 arch/arm64/include/asm/kvm_mmu.h |  4 ++
 arch/arm64/kvm/mmu.c             | 65 ++++++++++++++++++++------------
 2 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 81839e9a8a24..0b0c71302b92 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -153,6 +153,10 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 int kvm_share_hyp(void *from, void *to);
 void kvm_unshare_hyp(void *from, void *to);
 int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
+unsigned long hyp_alloc_private_va_range(size_t size, size_t align);
+int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
+				size_t align, unsigned long *haddr,
+				enum kvm_pgtable_prot prot);
 int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 			   void __iomem **kaddr,
 			   void __iomem **haddr);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index bc2aba953299..a4868a6fa1c3 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -457,22 +457,17 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 	return 0;
 }
 
-static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
-					unsigned long *haddr,
-					enum kvm_pgtable_prot prot)
+
+/**
+ * hyp_alloc_private_va_range - Allocates a private VA range.
+ * @size:	The size of the VA range to reserve.
+ * @align:	The required alignment for the allocation.
+ *
+ * The private VA range is allocated below io_map_base.
+ */
+unsigned long hyp_alloc_private_va_range(size_t size, size_t align)
 {
 	unsigned long base;
-	int ret = 0;
-
-	if (!kvm_host_owns_hyp_mappings()) {
-		base = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
-					 phys_addr, size, prot);
-		if (IS_ERR_OR_NULL((void *)base))
-			return PTR_ERR((void *)base);
-		*haddr = base;
-
-		return 0;
-	}
 
 	mutex_lock(&kvm_hyp_pgd_mutex);
 
@@ -484,29 +479,51 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
 	 *
 	 * The allocated size is always a multiple of PAGE_SIZE.
 	 */
-	size = PAGE_ALIGN(size + offset_in_page(phys_addr));
-	base = io_map_base - size;
+	base = io_map_base - PAGE_ALIGN(size);
+	base = ALIGN_DOWN(base, align);
 
 	/*
 	 * Verify that BIT(VA_BITS - 1) hasn't been flipped by
 	 * allocating the new area, as it would indicate we've
 	 * overflowed the idmap/IO address range.
 	 */
-	if ((base ^ io_map_base) & BIT(VA_BITS - 1))
-		ret = -ENOMEM;
+	if (!base || (base ^ io_map_base) & BIT(VA_BITS - 1))
+		base = (unsigned long)ERR_PTR(-ENOMEM);
 	else
 		io_map_base = base;
 
 	mutex_unlock(&kvm_hyp_pgd_mutex);
 
-	if (ret)
-		goto out;
+	return base;
+}
+
+int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
+				size_t align, unsigned long *haddr,
+				enum kvm_pgtable_prot prot)
+{
+	unsigned long addr;
+	int ret = 0;
+
+	if (!kvm_host_owns_hyp_mappings()) {
+		addr = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
+					 phys_addr, size, prot);
+		if (IS_ERR((void *)addr))
+			return PTR_ERR((void *)addr);
+		*haddr = addr;
+
+		return 0;
+	}
+
+	size += offset_in_page(phys_addr);
+	addr = hyp_alloc_private_va_range(size, align);
+	if (IS_ERR((void *)addr))
+		return PTR_ERR((void *)addr);
 
-	ret = __create_hyp_mappings(base, size, phys_addr, prot);
+	ret = __create_hyp_mappings(addr, size, phys_addr, prot);
 	if (ret)
 		goto out;
 
-	*haddr = base + offset_in_page(phys_addr);
+	*haddr = addr + offset_in_page(phys_addr);
 out:
 	return ret;
 }
@@ -537,7 +554,7 @@ int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 		return 0;
 	}
 
-	ret = __create_hyp_private_mapping(phys_addr, size,
+	ret = __create_hyp_private_mapping(phys_addr, size, PAGE_SIZE,
 					   &addr, PAGE_HYP_DEVICE);
 	if (ret) {
 		iounmap(*kaddr);
@@ -564,7 +581,7 @@ int create_hyp_exec_mappings(phys_addr_t phys_addr, size_t size,
 
 	BUG_ON(is_kernel_in_hyp_mode());
 
-	ret = __create_hyp_private_mapping(phys_addr, size,
+	ret = __create_hyp_private_mapping(phys_addr, size, PAGE_SIZE,
 					   &addr, PAGE_HYP_EXEC);
 	if (ret) {
 		*haddr = NULL;
-- 
2.35.1.574.g5d30c73bfb-goog

