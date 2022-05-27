Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1DA535DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350804AbiE0KHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350831AbiE0KHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:07:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679208FD41
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:07:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso3972301pjg.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oq3zK8XqR9nMwWZwXePmBSIgomGYIVajuwM2hdD7Hjo=;
        b=K/zdyJneFK1xeK2FB1J37H0n37VhRUlG64dLbnJeI/um5dho1xi/cHqIe/2fKLKEVM
         QIC3W9YGc31R+RuGJ/MJ960dYEsi2Rr8McFBSvovtcKWlVpn+I8IjyNJEkfYjxIs3P/l
         Z4uKwckiFEsrS7KAP7o6HpwX5Lg2CLkgrUHlouJeWDkLsDS9pNyN4Px4ZICdd/nahFFu
         LWCkC6k1gbtfU8WZL/3DMCGLeC8gXymf7bVA9dIGDnWLAh6XfnreH+moluFWWYf4CRWO
         zlm86sDREegQYFNsZiIRMp7uB7+N6/OgeBq1UjYxOpby0pGmNsZF8hEVVuwyJ5S+WHD+
         vzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oq3zK8XqR9nMwWZwXePmBSIgomGYIVajuwM2hdD7Hjo=;
        b=HZU4KtKb9ySTHXA0fVQa2G+TiLul2N5c5v67JWOTJVxgAX8pc1fYwUWHDQHatvQw5F
         t2ag2UbCiv+fNQXIDpwLcvF3vLOdCBAa7IN71/33WtrUCD2L7GFal3tXnAw/hPOuXdBN
         DO5kkTYqaa1jkcpcjp/N/2dwaP/6cm8RqdGU+2R8ev/mqwUqVGu7u1tQy717PflRMNNW
         IS2pi7yc+r+FWhlFapWiJqpHq34Kj7EdEqRSiHlT9Erhr+Vlr9Ct9l824w3NcGGYq2MX
         q5HbJzk3F3jUy03NziXCHxLNG6IkkOWOwmjE+3aG3rqcgOXU/ziybM9JD5L6zEdRF9X4
         W9zg==
X-Gm-Message-State: AOAM533dUClccWAiX5SPZnPh1tXQrpZE0G6OSAtFZNk/bqtHOp/bUnck
        0Xhyf3Se8xiZKjBID0ye+rM=
X-Google-Smtp-Source: ABdhPJwNM81uvxUW12Ps2OhrOu0tnOnxN00PMC2hAqI2+tTt8+glgHOcyWMuMVFXvCdlRDOg5DwAmQ==
X-Received: by 2002:a17:902:d549:b0:163:7f27:f748 with SMTP id z9-20020a170902d54900b001637f27f748mr6584533plf.116.1653646019672;
        Fri, 27 May 2022 03:06:59 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz. [47.72.206.164])
        by smtp.gmail.com with ESMTPSA id z187-20020a6233c4000000b0050dc76281aesm3078104pfz.136.2022.05.27.03.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:06:59 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, linux-mm@kvack.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangshiming@oppo.com, guojian@oppo.com, hanchuanhua@oppo.com,
        Barry Song <v-songbaohua@oppo.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Steven Price <steven.price@arm.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH v2] arm64: enable THP_SWAP for arm64
Date:   Fri, 27 May 2022 22:06:44 +1200
Message-Id: <20220527100644.293717-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Song <v-songbaohua@oppo.com>

THP_SWAP has been proved to improve the swap throughput significantly
on x86_64 according to commit bd4c82c22c367e ("mm, THP, swap: delay
splitting THP after swapped out").
As long as arm64 uses 4K page size, it is quite similar with x86_64
by having 2MB PMD THP. So we are going to get similar improvement.
For other page sizes such as 16KB and 64KB, PMD might be too large.
Negative side effects such as IO latency might be a problem. Thus,
we can only safely enable the counterpart of X86_64.
A corner case is that MTE has an assumption that only base pages
can be swapped. We won't enable THP_SWP for ARM64 hardware with
MTE support until MTE is re-arched.

Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Yang Shi <shy828301@gmail.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/pgtable.h |  2 ++
 include/linux/huge_mm.h          | 12 ++++++++++++
 mm/swap_slots.c                  |  2 +-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4968845e67f..5306009df2dc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -101,6 +101,7 @@ config ARM64
 	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_NO_INSTR
+	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b6632f18364..06076139c72c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -45,6 +45,8 @@
 	__flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+#define arch_thp_swp_supported !system_supports_mte
+
 /*
  * Outside of a few very special situations (e.g. hibernation), we always
  * use broadcast TLB invalidation instructions, therefore a spurious page
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index de29821231c9..4ddaf6ad73ef 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -461,4 +461,16 @@ static inline int split_folio_to_list(struct folio *folio,
 	return split_huge_page_to_list(&folio->page, list);
 }
 
+/*
+ * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
+ * limitations in the implementation like arm64 MTE can override this to
+ * false
+ */
+#ifndef arch_thp_swp_supported
+static inline bool arch_thp_swp_supported(void)
+{
+	return true;
+}
+#endif
+
 #endif /* _LINUX_HUGE_MM_H */
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 2a65a89b5b4d..10b94d64cc25 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -307,7 +307,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 	entry.val = 0;
 
 	if (folio_test_large(folio)) {
-		if (IS_ENABLED(CONFIG_THP_SWAP))
+		if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
 			get_swap_pages(1, &entry, folio_nr_pages(folio));
 		goto out;
 	}
-- 
2.25.1

