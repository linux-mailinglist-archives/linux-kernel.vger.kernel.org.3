Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DED509247
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382628AbiDTVqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbiDTVqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:46:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DDC43ACE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:43:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d129-20020a254f87000000b006411bf3f331so2675651ybb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=H7kRCZxE86B6SWxgyz7zRi2sY2pDlR4nBd1oa6QSQkw=;
        b=TTCcYduxyz27rtHm5u8I3DjglQhoNrJAIrlsxPZQiM0yBCqC2X5vG08pfDUgqS5D0S
         Yf4klwHp1Cy05ZRUNct7mdNPz79qITMOuOjzm0ybp9e0/UBjYQ3bHarl6JZ/Ptu4oYtY
         6Y5jEHrpZWlVlPdYJwDQaNeQ4HtOsTFcxhAe0wopXwYBpn1Y05w+YZjqLYYF46/VaXyz
         soQ9gF1dGxoFiuKfBj2BRiJn3wt+MB3i7grEPI+CfFL/jqj80d9HsC3ZpHP4a3w0JFQb
         5f965Ek9CQ9Htes05RLyI06DePLAEwRayeGgzF1B1W24ekpfCAiGI+u1OxGp/l4WZcpT
         Zq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=H7kRCZxE86B6SWxgyz7zRi2sY2pDlR4nBd1oa6QSQkw=;
        b=anS517A345FxLyJfiil6hs4/I2gwIueo0c/u9wjCSe0aaDho/rc7+iUHgxJNXKaowl
         SsLmZfA8eYldKITek6vj3s0h2TKwHB2NmihL8ZEgTznsUo7SpMPGJXEqrMIGT/EMaBY3
         EfZ7Z/R4mvNUfrYLkWmv2enim1jeGEbaMjxqAKXJYN8iWhdYf4FutZSfGf87WPMlSM1e
         USaEg+4G/GM/aBGanD867ern6H/p+5ydA/vo6lAByicx27AAJHEHiSfnDEzJ5E0k3v4D
         Y4xvk8UK/asYw+WRBpTIjLQEaf31F5Q8p4mbg6Dwq1RKZ3L2irFbyZiE9hGrXnyfllFn
         ghxA==
X-Gm-Message-State: AOAM531ZM34GzbSUAd8waJThfL03vs5XkqMqyJjxR22HpaE1MevxnnC4
        pCsJuVOiaXsNSjGrryx/pxt9za9DWe6OMfAbFQ==
X-Google-Smtp-Source: ABdhPJwbrLaihFbnA+0JkLe58ng3Jvdp2cEtJqbHJL4+AURy/vsesCBbc478unv4e+ALPKEGCZgQvP8Tw7XdAJ7X2A==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:2a20:cec4:8f41:cd6f])
 (user=kaleshsingh job=sendgmr) by 2002:a81:1557:0:b0:2f4:d3eb:6428 with SMTP
 id 84-20020a811557000000b002f4d3eb6428mr863893ywv.234.1650491036209; Wed, 20
 Apr 2022 14:43:56 -0700 (PDT)
Date:   Wed, 20 Apr 2022 14:42:52 -0700
In-Reply-To: <20220420214317.3303360-1-kaleshsingh@google.com>
Message-Id: <20220420214317.3303360-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220420214317.3303360-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v8 1/6] KVM: arm64: Introduce hyp_alloc_private_va_range()
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
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
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
---

Changes in v8
  - Remove !base check in hyp_alloc_private_va_range(), per Marc
  - PAGE_ALIGN the size in __create_hyp_private_mapping(), per Marc

Changes in v7:
  - Add Fuad's Reviewed-by and Tested-by tags.

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
 arch/arm64/kvm/mmu.c             | 64 +++++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 74735a864eee..a50cbb5ba402 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -154,6 +154,7 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 int kvm_share_hyp(void *from, void *to);
 void kvm_unshare_hyp(void *from, void *to);
 int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
+int hyp_alloc_private_va_range(size_t size, unsigned long *haddr);
 int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 			   void __iomem **kaddr,
 			   void __iomem **haddr);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 53ae2c0640bc..7de1e02ebfd1 100644
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
@@ -484,8 +483,10 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
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
@@ -495,19 +496,40 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
 	if ((base ^ io_map_base) & BIT(VA_BITS - 1))
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
+	size = PAGE_ALIGN(size + offset_in_page(phys_addr));
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
2.36.0.rc0.470.gd361397f0d-goog

