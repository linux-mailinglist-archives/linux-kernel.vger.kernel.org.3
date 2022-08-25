Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FAF5A0D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240986AbiHYKLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbiHYKLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:11:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC88A82FB4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:11:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x19so16469140pfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NKL5sVtokizfWAI3mo2jb9YTpdgBm9GDnhWm26Gpw5s=;
        b=Gy1ISArxPeO5t0wyjubpA3M0UwCqZnmexobJgdIoq7tqU9HMbig6Y+7mGWKf54ECC8
         DqQndeO6hmcTQOcP0wGzgvV+4sXY89dYzb7/lyOeA8+OpBHUu8O3rCfoFzhAot3HDtVY
         Ce7vtNvX7ItLbUkB2MFUwWbkWA/FzUlnDgneBXcMJqO+AhBTgppDm+wxJv3E3ETTr4QA
         lFF/lELPdk9gCZYniMOeQsec8xH89bdgarwyYZHV7mZzwiPpvZzq/IjP1XQeYBvqQs7V
         2fftWuXXkPuQNSe0e7Y7HoDIW6QdtAB1sOCVQ3StK0qJInlmGTpxoS+XYQRxpKtzCGj8
         gCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NKL5sVtokizfWAI3mo2jb9YTpdgBm9GDnhWm26Gpw5s=;
        b=yN8t3yxIStOZBFfQMevs6iSdoc777IrXiiAQ8xvS6ZnzyQzhx8uVDf2v7exWdH3uxu
         KiT8B+gk9ceOV9J35i+Ca2nzIXKwENL7a5OmoX9VMcuI6E8hViFcd1duzpj1s/FzR7eb
         6TVW2vZlqLgnM4uMPdJI9fHNk9sD2EZ8tu1kYoURmcasRvYT91wnS3imXM+xqM259HTv
         Az7Hrxk0B6hF16YPArWR0IUXRibok/akXZBTjJmVBuYh9Yfys3aTcUNBnuwGq0CI3r5N
         XzGnQetBHbNE/+dm9foq58riuqEITSJ3V/19hKEQ1rgkZ2Oht0QXo9xYHMFxHMgxiMzL
         5pZQ==
X-Gm-Message-State: ACgBeo3wl9iWDcxEY2Opiwwz7Y1n2UKiqeR9W/dG1c+3hMao2hLsXCaX
        EdQE5Wt0T9nXr3B0Oq6PZrhEPw==
X-Google-Smtp-Source: AA6agR5IcwxykGGpHLVe3CX1H3gs3cvYf5zfNNUsTN/8NtEiGwMN/bJ7KCESq8870YRROxxIqH28lw==
X-Received: by 2002:a05:6a00:e8a:b0:535:cc5c:3d87 with SMTP id bo10-20020a056a000e8a00b00535cc5c3d87mr3497198pfb.24.1661422295360;
        Thu, 25 Aug 2022 03:11:35 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001714c36a6e7sm8477581plh.284.2022.08.25.03.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:11:34 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@redhat.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        jgg@nvidia.com, tglx@linutronix.de, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 1/7] mm: use ptep_clear() in non-present cases
Date:   Thu, 25 Aug 2022 18:10:31 +0800
Message-Id: <20220825101037.96517-2-zhengqi.arch@bytedance.com>
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

After commit 08d5b29eac7d ("mm: ptep_clear() page table helper"),
the ptep_clear() can be used to track the clearing of PTE entries,
but it skips some places since the page table check does not care
about non-present PTE entries.

Subsequent patches need to use ptep_clear() to track all clearing
PTE entries, so this patch makes ptep_clear() used for all cases
including clearing non-present PTE entries.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/pgtable.h | 2 +-
 mm/memory.c             | 2 +-
 mm/mprotect.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 3cdc16cfd867..9745684b0cdb 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -428,7 +428,7 @@ static inline void pte_clear_not_present_full(struct mm_struct *mm,
 					      pte_t *ptep,
 					      int full)
 {
-	pte_clear(mm, address, ptep);
+	ptep_clear(mm, address, ptep);
 }
 #endif
 
diff --git a/mm/memory.c b/mm/memory.c
index 1c6027adc542..207e0ee657e9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3655,7 +3655,7 @@ static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
 	 * none pte.  Otherwise it means the pte could have changed, so retry.
 	 */
 	if (is_pte_marker(*vmf->pte))
-		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
+		ptep_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return 0;
 }
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ba5592655ee3..1a01bd22a4ed 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -201,7 +201,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 				 * fault will trigger without uffd trapping.
 				 */
 				if (uffd_wp_resolve) {
-					pte_clear(vma->vm_mm, addr, pte);
+					ptep_clear(vma->vm_mm, addr, pte);
 					pages++;
 				}
 				continue;
-- 
2.20.1

