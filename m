Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEE3514AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359872AbiD2Nlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376308AbiD2NlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:41:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E53BCC53C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:37:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i1so1025123plg.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PDb352oR+7/T20U1mOURtFBi5DeN+iddATN1VUBhapY=;
        b=M4jKPxmu6lHLcuN2g3BJoI5FkuKhJPRPks8ERBsNxVTHX3vhgtEMdYENdfW7JcqHwT
         yIH289VoRZXsV1Haj1Czsaw7RvMgfpNlIK48fcm+b7NNl/oeI7592UtbcrVGAto3j8qC
         VAobCLwT2x5h91yk+I7lMpecP96Ie33InH4JS0EJJehK9pIzs5ACN6H54/tw0aIyHkt/
         wfJfNrXbInpX6Uxy8tB2TVaoW38mmPPuQ4fg2KMeUpipyE6IjHJ7eHpciSWTRoh6yjhe
         peT1zi4IDbHb6FzrmQ0mld9hn0zaB46duAeGKxPzmtH5lzBQefASzBL34t5JOt4uPvRq
         1WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PDb352oR+7/T20U1mOURtFBi5DeN+iddATN1VUBhapY=;
        b=im3Nm0zm/t0IOOcAjoO4mdR1rqBKAN8gTZftNH/Zv8Eu86OUg+WwV3RzwnmTPf0ZiP
         t1GhcHY2nU4399nKIB4Z6v3ARrXLab2QG9FWwoHIRbRnwk2Nc2XQBaa+oL5RtxoX1A7b
         nkY6b5zVusFFW+6mrirAtBl4ApM0szujVo1Lwh5rYid071EfU52D6rARzwlRvOzLDfV/
         MVCHP1uNtC1Id7QlAkWjHw+Kn6fHm2NOREM+g4IJcaUjOe1jHVnwHVF5CqMdZZ7qZwGN
         /0sI3mFRpX9EgxNJ7DjxUFHtt1m1xiRExIxHBVTNSf47Fug60qQGmenNLDdXs397YnEd
         UkDg==
X-Gm-Message-State: AOAM533891h5BfUZ6kAHJyo5vQr9GT6BtrRlF6pvIlR0g2rSKEpyFayM
        1brVf7GWOugegJnxMxCBHLp0hQ==
X-Google-Smtp-Source: ABdhPJxuA4t7O9ORj9b40GN2GlWOmbbs1FpQC2BMOlij9ue4QgL40/Ximfv1xZWE9b9PeECFx/EvXA==
X-Received: by 2002:a17:90a:e510:b0:1d8:39b3:280b with SMTP id t16-20020a17090ae51000b001d839b3280bmr4062679pjy.142.1651239474777;
        Fri, 29 Apr 2022 06:37:54 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a414800b001d81a30c437sm10681977pjg.50.2022.04.29.06.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:37:54 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 17/18] x86/mm: add x86_64 support for pte_ref
Date:   Fri, 29 Apr 2022 21:35:51 +0800
Message-Id: <20220429133552.33768-18-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pte_ref hooks into routines that modify user PTE page tables,
and select ARCH_SUPPORTS_FREE_USER_PTE, so that the pte_ref code
can be compiled and worked on this architecture.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/Kconfig               | 1 +
 arch/x86/include/asm/pgtable.h | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0142e01002e..c1046fc15882 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -34,6 +34,7 @@ config X86_64
 	select SWIOTLB
 	select ARCH_HAS_ELFCORE_COMPAT
 	select ZONE_DMA32
+	select ARCH_SUPPORTS_FREE_USER_PTE
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 62ab07e24aef..08d0aa5ce8d4 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -23,6 +23,7 @@
 #include <asm/coco.h>
 #include <asm-generic/pgtable_uffd.h>
 #include <linux/page_table_check.h>
+#include <linux/pte_ref.h>
 
 extern pgd_t early_top_pgt[PTRS_PER_PGD];
 bool __init __early_make_pgtable(unsigned long address, pmdval_t pmd);
@@ -1010,6 +1011,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
 	page_table_check_pte_set(mm, addr, ptep, pte);
+	track_pte_set(mm, addr, ptep, pte);
 	set_pte(ptep, pte);
 }
 
@@ -1055,6 +1057,7 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 {
 	pte_t pte = native_ptep_get_and_clear(ptep);
 	page_table_check_pte_clear(mm, addr, pte);
+	track_pte_clear(mm, addr, ptep, pte);
 	return pte;
 }
 
@@ -1071,6 +1074,7 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 		 */
 		pte = native_local_ptep_get_and_clear(ptep);
 		page_table_check_pte_clear(mm, addr, pte);
+		track_pte_clear(mm, addr, ptep, pte);
 	} else {
 		pte = ptep_get_and_clear(mm, addr, ptep);
 	}
@@ -1081,7 +1085,8 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep)
 {
-	if (IS_ENABLED(CONFIG_PAGE_TABLE_CHECK))
+	if (IS_ENABLED(CONFIG_PAGE_TABLE_CHECK)
+	    || IS_ENABLED(CONFIG_FREE_USER_PTE))
 		ptep_get_and_clear(mm, addr, ptep);
 	else
 		pte_clear(mm, addr, ptep);
-- 
2.20.1

