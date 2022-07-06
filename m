Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3751567FCF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiGFH1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiGFH1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:27:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46CC22536
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:27:21 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w185so9906741pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 00:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FBNOHK6TrUivbMpa8W7z4583vq/fBAQTSSPZ8CCGyBI=;
        b=OfDJeegyfCM5B9dZJ5bCWM0Tc3QLQ2lqKnE6PKBhG5Y5cggTqLEBN7DSWP67HbUorY
         AICMy9Ani116g+nC2FpMQ7VBQIccJjXNYL41uTJrGFkK1p6Hzqkkvh4Pv0jqxFOTnGRz
         PkdF/+9BDdbHnT0vi0Dk1OPCFO5VJyRvnDy/JVBNNVMW+GodTr5nYw5KI6bpv+FsBPl4
         3iFfNn5qvnF3tPqBE6nVUTAqbFpN83XL2x9gxrT9J461PRifb2OFznrVnJSjiRf3nlsV
         thTgdRROoVs9++K8htSSktO69KYxvx7GbbfB5yLUH2vvHMhtYigl5yWEP/31U6dtaDWN
         XLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FBNOHK6TrUivbMpa8W7z4583vq/fBAQTSSPZ8CCGyBI=;
        b=ZzvS28/S9nbpWoF0U8jQUEx+Ybr9pZ17Rs4Ao7yx1rm1oysl4orapHyILmKCoU38PO
         5pqHd8MnSOsC6Xr5oj6L+pK9mKKrEPkc/v2iwbDvKuRZyQQ+HtvdtBbC3+5fyvB4yNLv
         8Tj4S3V/cbkLYsgk//OyPjHEIUzCwwU7vJEeL4uSNipwB0/dXX0+t88Jeg3SJrhJBvJR
         IgWJnauo/KCOamAVxV1a9V19FBLO1rPWEOEtUwd29jbHKOGcW6kDF+rYNDr7kljSjsH6
         Str/nP3l+SF6IYdPRWHKmhSLnAZKOkLLaoraRNFCGb95QcxcOeyIu9n6mX8ReE6F8CcI
         SEHQ==
X-Gm-Message-State: AJIora8HOUMPozcevRRoujxD0ahvrxAvQiONuXA2bL+M2GnerEAhVsRQ
        gPpMelnpz7bRZ/LGQD9W7eM=
X-Google-Smtp-Source: AGRyM1veHyr9zFdk9VXUSlgyj7GwIwH45xDuWvCAuHe/ns7sMvaysy6L88PpLzZyPk/sM7PQB+Xiqg==
X-Received: by 2002:a05:6a00:278c:b0:525:65c0:6415 with SMTP id bd12-20020a056a00278c00b0052565c06415mr44744290pfb.33.1657092441145;
        Wed, 06 Jul 2022 00:27:21 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz. [47.72.206.164])
        by smtp.gmail.com with ESMTPSA id w190-20020a6262c7000000b00528655cd6a6sm5366352pfb.53.2022.07.06.00.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 00:27:20 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     akpm@linux-foundation.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, steven.price@arm.com, will@kernel.org
Cc:     aarcange@redhat.com, guojian@oppo.com, hanchuanhua@oppo.com,
        hannes@cmpxchg.org, hughd@google.com, linux-kernel@vger.kernel.org,
        minchan@kernel.org, shy828301@gmail.com, v-songbaohua@oppo.com,
        ying.huang@intel.com, zhangshiming@oppo.com
Subject: [PATCH v3] arm64: enable THP_SWAP for arm64
Date:   Wed,  6 Jul 2022 19:27:07 +1200
Message-Id: <20220706072707.114376-1-21cnbao@gmail.com>
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

