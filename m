Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467D44A4B32
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379995AbiAaQEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379998AbiAaQEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:04:06 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600ABC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:04:06 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h12so14432566pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3P2GhQ/A4jZ2vY4MofmwB/at+DQmKpJSp18e9dRfwe4=;
        b=5URQXSWgeqQ7mckfU4C9lY/dFwxZNhRwVpHK8PF66Zds0N3U5nsrMNbagre+kYdnct
         +7o8S/vRwiYT6Zw3piBgSLEXOeagAuCSSDt5bYZ8PiiQ1WiJOzuLDBf9kGZ2xrU0DFCI
         Bj4Qz09SgZvWc8iA9F5vFDGmETHPkYnDxkCsLa8nhEgbbBi5icdAE1eLXYLBh8ZXnLJ1
         MjO8vyzTyf6I6AAfmVEXkPHMyN5hET/0/8R3vtzopEPjnTYAD6MjTm+ZVCnuHucvkzT9
         R2JPwM4NUEFLkb5Pavb8ubGKAM7YnFbERMPEt5PE/HE28UvrKKlT8px8uUdqmOm8J+sK
         zXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3P2GhQ/A4jZ2vY4MofmwB/at+DQmKpJSp18e9dRfwe4=;
        b=bTsy8EGok8mo+EWYw1qsDBl26IQqjl1NPgJQ+LaoRs2j5omTD+MTpT0xhXXtqlsqF4
         4jqW/BuMclquTGAoIuSuCl9rPnTbkyWLvzkPcUYCrKI9DVmnrrGQAi5Ji5NLE1Y29NXT
         2b6A0YCV0O7+/GbZ5k/fO053zu2m7DSutjUP/4gUnd7I2BAD3i2v7q+/Wmx1PaNJndGu
         y2rL/U44Kzu4Y6pOmbsGL1PQtLmNa5B4Jn5c/XNH5zbY2CXguIL5brUW8+FS91npI4OU
         DLrHBjAPo+W1LG19BpZxOSKk4jKXPviUGQpzpYMmRQXUyogMhfjU0pJYbaLDbaqDWVgw
         Be7w==
X-Gm-Message-State: AOAM531WtnAm4bNHecTCFrx9/fQmEHzUPVYosPT0b8rlvm1yTCyzcoao
        tIJVF9cctK19I8qOnpCACPUCUQ==
X-Google-Smtp-Source: ABdhPJx+s3Ymv7b02lJg4vX/CGJvKlKxbU1nqbdkqUMa4X7q/ZoBsG0DOzq5OgBQhaDtJj5SKTVUgQ==
X-Received: by 2002:a17:902:ea06:: with SMTP id s6mr20895751plg.161.1643645045966;
        Mon, 31 Jan 2022 08:04:05 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id n42sm17940716pfv.29.2022.01.31.08.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 08:04:05 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH v3 1/5] mm: thp: fix wrong cache flush in remove_migration_pmd()
Date:   Tue,  1 Feb 2022 00:02:50 +0800
Message-Id: <20220131160254.43211-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220131160254.43211-1-songmuchun@bytedance.com>
References: <20220131160254.43211-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flush_cache_page() is supposed to be justified only if the page
is already placed in process page table, and that is done right after
flush_cache_page(). So using this interface is wrong. And there is
no need to invalite cache since it was non-present before in
remove_migration_pmd(). So just to remove it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f58524394dc1..45ede45b11f5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3207,7 +3207,6 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	if (pmd_swp_uffd_wp(*pvmw->pmd))
 		pmde = pmd_wrprotect(pmd_mkuffd_wp(pmde));
 
-	flush_cache_range(vma, mmun_start, mmun_start + HPAGE_PMD_SIZE);
 	if (PageAnon(new))
 		page_add_anon_rmap(new, vma, mmun_start, true);
 	else
@@ -3215,6 +3214,8 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
 	if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
 		mlock_vma_page(new);
+
+	/* No need to invalidate - it was non-present before */
 	update_mmu_cache_pmd(vma, address, pvmw->pmd);
 }
 #endif
-- 
2.11.0

