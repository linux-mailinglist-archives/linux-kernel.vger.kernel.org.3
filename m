Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176AF56D233
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 02:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiGKAa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 20:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiGKAax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 20:30:53 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6B27662;
        Sun, 10 Jul 2022 17:30:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m14so3144251plg.5;
        Sun, 10 Jul 2022 17:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m4SI/cpdnIFnD5cNCv6yLmE3xJclWoDJfmD/84NFECg=;
        b=QQmGKbrWIGCgbC990jRLFIhBANNyWD62aPqRrC3txmoayUQVt7oYPUZj6QISfQ/LEC
         50kHaKa6+2g+qMkZ9iWmuynFGoJQBcIE7knuCv9nkCSnaGMrdbe9FjC/bEWoqqsYsOiY
         DWhX3aMUNV29w/eidIxH0kxjMmVbjAUqORPEmLjs8xFzemaJHVGIUm4CMg5YBxK8TLcn
         TnaDgAy13co3Z4x2dd6sAThR13ZstkZRd6h7l2YlxNyHBwReq66XjoK7GDOBPbCIcGZ3
         giRRyBw2rPvZ9uaAGJ17xc4YjqePQ2YPclWzNWDxVy7VWACoRoxSvD15hL5b5vPBqGLH
         USVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4SI/cpdnIFnD5cNCv6yLmE3xJclWoDJfmD/84NFECg=;
        b=fyjTY0hcrsyHLCfEbP0aI/8/vZql6pO2q74B1MmnsNp88VyF1wpq3Q39yx0SVgbdBt
         kf2DTxF7S+0HMiGjBV232wweo0WOoFG7WraAc0vgFI6O67Fijp4VemisU+4OtyQ+IekB
         zdiZSTJ2MjOEbx1N1iIuBkxI3wZ5mdwKJAxsdgcyrlnYx5j3jpiwmWCx1kb7oHZr6lkn
         ysFz01A7ZSc9jJeHeBRBj08KdTZ7WeSMLCNJzimIIM44T4+sOj6pGOOUw4UTECRVQ8yk
         UlWKK96mn4idXQiIf90PagqX7TIew3+u0GChzQ98cmRnsCyKmEjdLOfbStgSC4TEFJH1
         NKwA==
X-Gm-Message-State: AJIora+1D69BSY9VRrrI10vkiTkWTYZWALqG7JXsNyuP5VbUpdupmnB9
        MKbeLvQ5G6BLEg+knIzVDHE=
X-Google-Smtp-Source: AGRyM1tctGCGbnQcs4zYfIUKncEUZ3/P3GwlsTm7lgCGQXSarpJy4IsjYWHdt4xd+XqBUbhWJ5dvZw==
X-Received: by 2002:a17:90b:3d84:b0:1ef:9049:9f43 with SMTP id pq4-20020a17090b3d8400b001ef90499f43mr14712779pjb.45.1657499452148;
        Sun, 10 Jul 2022 17:30:52 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz. [47.72.206.164])
        by smtp.gmail.com with ESMTPSA id d78-20020a621d51000000b00528c149fe97sm3408686pfd.89.2022.07.10.17.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 17:30:51 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     peterz@infradead.org
Cc:     21cnbao@gmail.com, akpm@linux-foundation.org, arnd@arndb.de,
        catalin.marinas@arm.com, corbet@lwn.net,
        darren@os.amperecomputing.com, guojian@oppo.com,
        huzhanyuan@oppo.com, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lipeifeng@oppo.com, mgorman@suse.de,
        namit@vmware.com, realmz6@gmail.com, v-songbaohua@oppo.com,
        will@kernel.org, x86@kernel.org, yangyicong@hisilicon.com,
        zhangshiming@oppo.com
Subject: Re: [PATCH 2/4] mm: rmap: Allow platforms without mm_cpumask to defer TLB flush
Date:   Mon, 11 Jul 2022 12:30:28 +1200
Message-Id: <20220711003028.3042-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YsfqjsntneiX0xYE@hirez.programming.kicks-ass.net>
References: <YsfqjsntneiX0xYE@hirez.programming.kicks-ass.net>
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

On Fri, Jul 8, 2022 at 8:28 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 08, 2022 at 08:08:45AM +0000, Nadav Amit wrote:
>
> > Is it really only x86 that has mm_cpumask()?
>
> Unlikely, everybody who needs to IPI (eg. doesn't have broadcast
> invalidate) has benefit to track this mask more accurately.
>
> The below greps for clearing CPUs in the mask and ought to be a fair
> indicator:
>
> $ git grep -l "cpumask_clear_cpu.*mm_cpumask" arch/
> arch/arm/include/asm/mmu_context.h
> arch/loongarch/include/asm/mmu_context.h
> arch/loongarch/mm/tlb.c
> arch/mips/include/asm/mmu_context.h
> arch/openrisc/mm/tlb.c
> arch/powerpc/include/asm/book3s/64/mmu.h
> arch/powerpc/mm/book3s64/radix_tlb.c
> arch/riscv/mm/context.c
> arch/s390/kernel/smp.c
> arch/um/include/asm/mmu_context.h
> arch/x86/mm/tlb.c

so i suppose we need the below at this moment. i am not able to
test all of them. but since only x86 has already got tlbbatch
and arm64 is the second one to have tlbbatch now, i suppose the
below changes won't break those archs without tlbbatch. i would
expect people bringing up tlbbatch in those platforms to test
them later,

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7630ba9cb6cc..25c42747f488 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -13,6 +13,7 @@ config ARM
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
+	select ARCH_HAS_MM_CPUMASK
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
 	select ARCH_HAS_PHYS_TO_DMA
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 1920d52653b4..4b737c0d17a2 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -7,6 +7,7 @@ config LOONGARCH
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+	select ARCH_HAS_MM_CPUMASK
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index db09d45d59ec..1b196acdeca3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -9,6 +9,7 @@ config MIPS
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE if !EVA
+	select ARCH_HAS_MM_CPUMASK
 	select ARCH_HAS_PTE_SPECIAL if !(32BIT && CPU_HAS_RIXI)
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index e814df4c483c..82483b192f4a 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -9,6 +9,7 @@ config OPENRISC
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_DMA_CLEAR_UNCACHED
+	select ARCH_HAS_MM_CPUMASK
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select COMMON_CLK
 	select OF
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c2ce2e60c8f0..19061ffe73a0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -127,6 +127,7 @@ config PPC
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MEMREMAP_COMPAT_ALIGN	if PPC_64S_HASH_MMU
 	select ARCH_HAS_MMIOWB			if PPC64
+	select ARCH_HAS_MM_CPUMASK
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PMEM_API
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c22f58155948..7570c95a9cc8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -25,6 +25,7 @@ config RISCV
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MMIOWB
+	select ARCH_HAS_MM_CPUMASK
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 91c0b80a8bf0..48d91fa05bab 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -73,6 +73,7 @@ config S390
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEM_ENCRYPT
+	select ARCH_HAS_MM_CPUMASK
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SCALED_CPUTIME
 	select ARCH_HAS_SET_MEMORY
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 4ec22e156a2e..df29c729267b 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -8,6 +8,7 @@ config UML
 	select ARCH_EPHEMERAL_INODES
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_MM_CPUMASK
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
 	select ARCH_NO_PREEMPT
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be0b95e51df6..a91d73866238 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -81,6 +81,7 @@ config X86
 	select ARCH_HAS_KCOV			if X86_64
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
+	select ARCH_HAS_MM_CPUMASK
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
diff --git a/mm/Kconfig b/mm/Kconfig
index 169e64192e48..7bf54f57ca01 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -951,6 +951,9 @@ config ARCH_HAS_CURRENT_STACK_POINTER
 	  register alias named "current_stack_pointer", this config can be
 	  selected.

+config ARCH_HAS_MM_CPUMASK
+	bool
+
 config ARCH_HAS_VM_GET_PAGE_PROT
 	bool

diff --git a/mm/rmap.c b/mm/rmap.c
index 5bcb334cd6f2..13d4f9a1d4f1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -692,6 +692,10 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
 	if (!(flags & TTU_BATCH_FLUSH))
 		return false;

+#ifndef CONFIG_ARCH_HAS_MM_CPUMASK
+	return true;
+#endif
+
 	/* If remote CPUs need to be flushed then defer batch the flush */
 	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
 		should_defer = true;

Thanks
Barry

