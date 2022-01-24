Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B02497851
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 06:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiAXFSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 00:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiAXFSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 00:18:04 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC2EC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 21:18:04 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id j10so2183978pgc.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 21:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zP36aX2d/bL6wS6rcbFJKrOBtz963Nu2Kl7o23XZalE=;
        b=u53kMVT1HAOzyAHD6LkcLXv4YmcYTS+naIZ3o73dHyAi/6jxb7xkkx8srkEdgI6wuC
         5wqEUbd98o2kB8drLXvSSDVix9X3EGBdn6pvaTxT7RNdEpj645jfE4qxAwASiVAvDXjM
         ARH8ayPrDE+L+VJvOdCFEy1sDgaNA8hDRliKjCWmZHrR4+w64uAMmPbxQSHSEhdB+REO
         EytluLz/hkxH9jTtJGnz2GTlGJgren6/ISKvLuDi/HBw464+4Fuw25N1n46hjoT4BG18
         LWJkecKpssASBvS1OOY3HltjsmttZchousDfKh2nxLBOfqhseBn3SgMHn4HwaRRPYU7a
         UNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zP36aX2d/bL6wS6rcbFJKrOBtz963Nu2Kl7o23XZalE=;
        b=oqBTG/eE05/Vl0Abp2s5XslUAqlr/D/bPh4GgGRuHb0PlvTxczUYSkdlsl0qbVayV0
         0T+/GCkJWg1B6rXlep9Wuyv0KWg8xaKTvCdFA4rS+jUcQFk/T9Ob4L4gk4Ozvt5g4WYi
         oEVfu0qsZyZcVNH7yQ3t7FrTNRTHGNVsayEN86fN6eqjd2UYhJ4bkEZ5/WnullXGTpNU
         IpDYXPIP5GxUZ21kY9WON7UpwQuL/8SIcAWvpttH8bjgAYl+sm0dGvaqaX44wxtZbHet
         5Yyci3bCarpFrqkg7t126+AQbxva0SGVtIQKhLBJkRMZ9u96eya1v2t7XJoK60CX46Yz
         CjHw==
X-Gm-Message-State: AOAM530+lwQ1h6jdSs1AJpvaudC1eUQhoGt4Uld55982DeUX/IbKSRM2
        ppAZA/IB95+D/BQD71Vw+W7VqA==
X-Google-Smtp-Source: ABdhPJy5c5N5VaAzxWc2RK+1xQ2ug8lRSvUjdW/Kex0OEX3SffhRhUWLglgrGGuU4rdCqCEVt41/tQ==
X-Received: by 2002:a63:8c59:: with SMTP id q25mr10494273pgn.13.1643001483990;
        Sun, 23 Jan 2022 21:18:03 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id l21sm14263018pfu.120.2022.01.23.21.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 21:18:03 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 1/2] mm: thp: fix wrong cache flush in remove_migration_pmd()
Date:   Mon, 24 Jan 2022 13:17:51 +0800
Message-Id: <20220124051752.83281-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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
Changes in v2:
 - Collect Reviewed-by tag. Thanks Zi.

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

