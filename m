Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B2A5A0D95
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241182AbiHYKMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241029AbiHYKMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:12:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBDCA7A82
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:12:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id jm11so18083870plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=N/hACB6DJOnbW9YdcxCL4bYdw5iH8tr2HnsmRUbA/2k=;
        b=QK9DEIvE1XdTmyK0lBvfluXy8RYM/LAWM6lwGwePhGiIuALjqlWe153rtG2hWbimgP
         tADUbPJWllZwAGBl6q1qMoG7GiVV4Zxg5mCWYr5gpaptx+0cYenTa8MYu8BxylD1BYIR
         MuGpFgTWwlSreVJQ1YFHSoT6iayMMrkysAJwtTyc5sV4ffpifFreiRkvBdACM872Q6tU
         dkOoQSesVJHmEDw19sbAyC6q21uVp3rx9VXqWv5ZjPzjubyss70MeyGWM9AFYgnuU659
         NiJrSv8GF1blOGvs/AogG2NrOnNaFsFxF+R6PRJfQ+I+YGspLrVxAViyyr0Bm4Nd080+
         d75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=N/hACB6DJOnbW9YdcxCL4bYdw5iH8tr2HnsmRUbA/2k=;
        b=fn/bJzgZgUcoKyIuOCNZ/krMIdaXpng9nAH/L0WHLjKdNa8a13Q6jYEK6lWTXqIyBF
         GXmMNKfOrnBInBMcuqI+Nbxb0qQH0aRwfckQ56nhaKrLEm0kUzW3u/qjqLqFlLAbvjHn
         B83VqWwSCtBqcftHy0NkRE5k/OAVs7NUjvK/ExAraAH+aBSkGga564Bdy2CZKE5BWkvO
         Xv0ZTlFlX45lTWrb7SEi7De549O/KjD22uiblGC8Nqn0qhL0GTpqlAy5FXmqXS0rbfGz
         yPVxQ1FvjATZLkmNrATXZTF10aPTCQR0FtDw4ZZC+h1wCvTixHiNftqt+4gSo+/4Freq
         S8jA==
X-Gm-Message-State: ACgBeo2VQlBP1V+wT81kDBzfRn88Tx3hdkBbNU80JyuHLlScqP4tL/Aj
        8hZCDsvJ+KRKjVGnwfsBctk3Kg==
X-Google-Smtp-Source: AA6agR5cOXU69J240S/HoYf6HtB5GQPmumANKU1IMKISK6IYS4mPO26cn0vvNtm0snnl5pnh+tc46Q==
X-Received: by 2002:a17:90b:2496:b0:1ef:a94:7048 with SMTP id nt22-20020a17090b249600b001ef0a947048mr3877401pjb.244.1661422326951;
        Thu, 25 Aug 2022 03:12:06 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001714c36a6e7sm8477581plh.284.2022.08.25.03.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:12:06 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@redhat.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        jgg@nvidia.com, tglx@linutronix.de, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 6/7] x86/mm: add x86_64 support for pte_ref
Date:   Thu, 25 Aug 2022 18:10:36 +0800
Message-Id: <20220825101037.96517-7-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
References: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/include/asm/pgtable.h | 4 ++++
 include/linux/pgtable.h        | 1 +
 3 files changed, 6 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 52a7f91527fe..50215b05723e 100644
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
index 44e2d6f1dbaa..cbfcfa497fb9 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -23,6 +23,7 @@
 #include <asm/coco.h>
 #include <asm-generic/pgtable_uffd.h>
 #include <linux/page_table_check.h>
+#include <linux/pte_ref.h>
 
 extern pgd_t early_top_pgt[PTRS_PER_PGD];
 bool __init __early_make_pgtable(unsigned long address, pmdval_t pmd);
@@ -1005,6 +1006,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
 	page_table_check_pte_set(mm, addr, ptep, pte);
+	track_pte_set(mm, addr, ptep, pte);
 	set_pte(ptep, pte);
 }
 
@@ -1050,6 +1052,7 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 {
 	pte_t pte = native_ptep_get_and_clear(ptep);
 	page_table_check_pte_clear(mm, addr, pte);
+	track_pte_clear(mm, addr, ptep, pte);
 	return pte;
 }
 
@@ -1066,6 +1069,7 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 		 */
 		pte = native_local_ptep_get_and_clear(ptep);
 		page_table_check_pte_clear(mm, addr, pte);
+		track_pte_clear(mm, addr, ptep, pte);
 	} else {
 		pte = ptep_get_and_clear(mm, addr, ptep);
 	}
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c4a6bda6e965..908636f48c95 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -276,6 +276,7 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 	pte_t pte = *ptep;
 	pte_clear(mm, address, ptep);
 	page_table_check_pte_clear(mm, address, pte);
+	track_pte_clear(mm, address, ptep, pte);
 	return pte;
 }
 #endif
-- 
2.20.1

