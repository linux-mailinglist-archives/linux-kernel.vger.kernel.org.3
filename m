Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF566577E33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiGRJB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiGRJBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:01:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218D69594
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:01:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so11944135pjl.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FBNOHK6TrUivbMpa8W7z4583vq/fBAQTSSPZ8CCGyBI=;
        b=IfSuY4Q7WSHNUGWWbfgnGSZ78tMxg18N8pNM5tk+rChm1EHP4NmEI4a9rAxl2+OebI
         Rs8tbPHUfz8pRk2bWdj9sEiKwe+Y1ppMZWql4VEKgKHS32eS40quCgd81ddYCFupwCMf
         ds8jf4TeqxEv/TuRTBxAYEB2SbaOLP3iOwrMWVhq8EljOMiXb6QLAmH4fI3oNMYl3NNb
         JADbGabjS1e4fTnBYqMMTk8k3slV1tdkjbFHj+WR1Vtl0dSuddCNpCdFaZU+xgwYX2Fz
         POLZECcUWgPGYjwRSN1mZAYcgNmdaMz6N2O3q36d4QqDfjHmKMlBc6SYb4H7VaU2/yVE
         JGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FBNOHK6TrUivbMpa8W7z4583vq/fBAQTSSPZ8CCGyBI=;
        b=ViQxfb4/DWYx9q+BEmWbPYOR/opAL8TG7eS8UO8dfC2O0DvxdiK2Dg5SnbiFL0i1or
         66AT2ZvUZBgPnXEohhuzv1RQLIj9azUI9DmArtzLmJ6uEgSjR3Dj3ANVxUi6P7Ep1Iw0
         Psj//4FN6C3Tvnro/r4tb+FGNhRbdTlBkIyapw62FyhVVn+4tQJBbH6FEEYmy1XRwHwZ
         6j/01d6w3qQ7X5IYIG5N6RCT5Ms7X27xUAS1VlokuHYhROmOO/g0Tci91WABtbkw+XgJ
         n8KRcWFxZA3GGH7pPzZCa3VS/G/zJSEI/XKtzfaYVMP0DV7onhKcxWFope0XthBBbtmz
         nyag==
X-Gm-Message-State: AJIora9SBQzqBcZ9XEiA0gCHKCZp2yBQwR1x7u4Q5e1Zuxa6GwhO2dId
        mpQFfhxQDgtzHFLbn8FF1Q8=
X-Google-Smtp-Source: AGRyM1u6qJVvDRHYc6nRxMF7cFc+EiWIMQyUF443MB5tyA81TER+ZrQttZvSd3UpqOUkw03+BwDfSw==
X-Received: by 2002:a17:90b:3b4d:b0:1f0:4547:8a31 with SMTP id ot13-20020a17090b3b4d00b001f045478a31mr31445247pjb.129.1658134884535;
        Mon, 18 Jul 2022 02:01:24 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz. [47.72.206.164])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b0016b9b6d67a2sm8909831plh.155.2022.07.18.02.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 02:01:23 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     akpm@linux-foundation.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, steven.price@arm.com, will@kernel.org
Cc:     aarcange@redhat.com, guojian@oppo.com, hanchuanhua@oppo.com,
        hannes@cmpxchg.org, hughd@google.com, linux-kernel@vger.kernel.org,
        minchan@kernel.org, shy828301@gmail.com, v-songbaohua@oppo.com,
        ying.huang@intel.com, zhangshiming@oppo.com
Subject: [RESEND PATCH v3] arm64: enable THP_SWAP for arm64
Date:   Mon, 18 Jul 2022 21:00:50 +1200
Message-Id: <20220718090050.2261-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Song <v-songbaohua@oppo.com>

THP_SWAP has been proven to improve the swap throughput significantly
on x86_64 according to commit bd4c82c22c367e ("mm, THP, swap: delay
splitting THP after swapped out").
As long as arm64 uses 4K page size, it is quite similar with x86_64
by having 2MB PMD THP. THP_SWAP is architecture-independent, thus,
enabling it on arm64 will benefit arm64 as well.
A corner case is that MTE has an assumption that only base pages
can be swapped. We won't enable THP_SWAP for ARM64 hardware with
MTE support until MTE is reworked to coexist with THP_SWAP.

A micro-benchmark is written to measure thp swapout throughput as
below,

 unsigned long long tv_to_ms(struct timeval tv)
 {
 	return tv.tv_sec * 1000 + tv.tv_usec / 1000;
 }

 main()
 {
 	struct timeval tv_b, tv_e;;
 #define SIZE 400*1024*1024
 	volatile void *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
 				MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if (!p) {
 		perror("fail to get memory");
 		exit(-1);
 	}

 	madvise(p, SIZE, MADV_HUGEPAGE);
 	memset(p, 0x11, SIZE); /* write to get mem */

 	gettimeofday(&tv_b, NULL);
 	madvise(p, SIZE, MADV_PAGEOUT);
 	gettimeofday(&tv_e, NULL);

 	printf("swp out bandwidth: %ld bytes/ms\n",
 			SIZE/(tv_to_ms(tv_e) - tv_to_ms(tv_b)));
 }

Testing is done on rk3568 64bit quad core processor Quad Core
Cortex-A55 platform - ROCK 3A.
thp swp throughput w/o patch: 2734bytes/ms (mean of 10 tests)
thp swp throughput w/  patch: 3331bytes/ms (mean of 10 tests)

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
 -v3: 
 * refine the commit log;
 * add a benchmark result;
 * refine the macro of arch_thp_swp_supported
 Thanks to the comments of Anshuman, Andrew, Steven

 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/pgtable.h |  6 ++++++
 include/linux/huge_mm.h          | 12 ++++++++++++
 mm/swap_slots.c                  |  2 +-
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1652a9800ebe..e1c540e80eec 100644
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
index 0b6632f18364..78d6f6014bfb 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -45,6 +45,12 @@
 	__flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+static inline bool arch_thp_swp_supported(void)
+{
+	return !system_supports_mte();
+}
+#define arch_thp_swp_supported arch_thp_swp_supported
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

