Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6159456A2E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiGGMxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiGGMx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:53:28 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158DFCF9;
        Thu,  7 Jul 2022 05:53:27 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e132so18341270pgc.5;
        Thu, 07 Jul 2022 05:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hOJXYJTQiFMMMc5LL8OXOjbAEOIGj7/DEojQqeqmtE=;
        b=nrNTLh5dPkoPJJ27EI8PkJlZZO7GsFZx7opX0T8UvM1J5eA0J0eT4vHf2MUS3ewfAl
         FYh/eMc6wEExO54NSw9YKO2kSHlBcinWZodF+x+U+oz7JI2X9cWHBmNGhFnlaRTQ70UD
         s765zJKqYUav6EwIEKQDKDpYCQ/4ZssXZLVwEesK4tDLlbrZTltsTvnGvPSgv55r0xuM
         bnGzeo+AVVRMW57URUjGLslcMHanIz5/piUmtJrCgf/QqZQwLbfdac8WuAmbUGFQt4qa
         44J7UJkocdhXL3nGxV56UBmrUwnDVBBXswUTlKxuI/JvxncWSZZBW0tYexzHGBHQ5FnU
         F4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hOJXYJTQiFMMMc5LL8OXOjbAEOIGj7/DEojQqeqmtE=;
        b=NLN51DIyhvFKsRz+kIptZVMzYpXAnkjUrml2TjzxwvFOT2uByfqG2uBYN/3PTQqsBM
         LwBLSNHTcCxwhz6ZAtfTQUtn90Bg6C1gWZzRDi5fg+kL887bbYVkpmNc0KAFKUejoaau
         WphYXSe++QvKFmiTGHbXdXnwKTFDxgfOtHNrtIv327Ky3J8O+j/Le8uKTzOofKKcLqRI
         5bB7UTaKV1FY+ujHoiI0JonLWnhfo8RBTC2HVG922sVSz3syPD4DrbMjqdRYjNSRmzpq
         DNcYq9G0YDS4xlnLF0ZKgUOcXDuFoLXp9ZTF4itt/xAL/6xDXjaWeZwYoSWgr9uZW9v3
         sjYg==
X-Gm-Message-State: AJIora/F0GKizgB447R2G99p082eIxIrCr2i3wuHcNXjW/C/+0ywlwiL
        6IzB8raNwcO+lYTSQiXXXRc=
X-Google-Smtp-Source: AGRyM1uZgm8qesTiPzIyn0Fdt/bFOX8tuNIMzYZlDgO6uvwzSy88a4q5p6lNgoDbQtEcMDOvySQXvg==
X-Received: by 2002:a63:2115:0:b0:412:b292:1870 with SMTP id h21-20020a632115000000b00412b2921870mr4253648pgh.176.1657198406594;
        Thu, 07 Jul 2022 05:53:26 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz. [47.72.206.164])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709027e4b00b0016a3b5a46f0sm27907831pln.241.2022.07.07.05.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:53:26 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, arnd@arndb.de, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, yangyicong@hisilicon.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com,
        Barry Song <v-songbaohua@oppo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH 3/4] mm: rmap: Extend tlbbatch APIs to fit new platforms
Date:   Fri,  8 Jul 2022 00:52:41 +1200
Message-Id: <20220707125242.425242-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707125242.425242-1-21cnbao@gmail.com>
References: <20220707125242.425242-1-21cnbao@gmail.com>
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

Add vma and uaddr to tlbbatch APIs so that platforms like ARM64
are able to apply these two parameters on their specific hard-
ware features. For ARM64, this could be sending tlbi into hard-
ware queues without waiting for its completion.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Mel Gorman <mgorman@suse.de>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/x86/include/asm/tlbflush.h |  4 +++-
 mm/rmap.c                       | 12 ++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 4af5579c7ef7..9fc48c103b31 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -251,7 +251,9 @@ static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
 }
 
 static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
-					struct mm_struct *mm)
+					struct mm_struct *mm,
+					struct vm_area_struct *vma,
+					unsigned long uaddr)
 {
 	inc_mm_tlb_gen(mm);
 	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
diff --git a/mm/rmap.c b/mm/rmap.c
index d320c29a4ad8..2b5b740d0001 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -642,12 +642,14 @@ void try_to_unmap_flush_dirty(void)
 #define TLB_FLUSH_BATCH_PENDING_LARGE			\
 	(TLB_FLUSH_BATCH_PENDING_MASK / 2)
 
-static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
+static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable,
+				      struct vm_area_struct *vma,
+				      unsigned long uaddr)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
 	int batch, nbatch;
 
-	arch_tlbbatch_add_mm(&tlb_ubc->arch, mm);
+	arch_tlbbatch_add_mm(&tlb_ubc->arch, mm, vma, uaddr);
 	tlb_ubc->flush_required = true;
 
 	/*
@@ -737,7 +739,9 @@ void flush_tlb_batched_pending(struct mm_struct *mm)
 	}
 }
 #else
-static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
+static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable,
+				      struct vm_area_struct *vma,
+				      unsigned long uaddr)
 {
 }
 
@@ -1600,7 +1604,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
 
-				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
+				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval), vma, address);
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
-- 
2.25.1

