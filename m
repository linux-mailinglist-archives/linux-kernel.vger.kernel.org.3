Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0D54B0DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbiBJMh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:37:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241599AbiBJMhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:37:24 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CEF260D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:25 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso5460819pjg.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKFpQhrIc0qg1OGn2vjlbFux2cfH4pwiDVgfg/+s2Gk=;
        b=JjFFmiBFFspTkoWluz4Y/2OhOC+2cDtbHwUi6Z8G3s5O6jLaI4K+hCvdUcs90RTnTb
         VZzbBD0KpisBRj8k0XTR/DImFMEN6lbYnM9WDekRGuOQXnKm5v/KFFCA1wP7yp5PeI0v
         C+DYAamNxNXL8z4lSF6NDBsFbDFTsDn5cWDibf8rPJgyTMdpR/aegPTr3LScOIw320ZH
         sqJSZSjApl195zpCodCKCZUZ3KK2Il7lDKn9IX13DkmKxsDDQPAnQ+a9yOjE2qFn5wCo
         RCS7uBuIFUpHMKaPGF2+nbn7Z+voZtzaqSo80Xtu69Fr9csc3qXRTPKMyfc2amzuhODn
         LyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKFpQhrIc0qg1OGn2vjlbFux2cfH4pwiDVgfg/+s2Gk=;
        b=VgbKy9RE6zJRDYTJjchwnV4jGV1Uu2W6/VHQY4+KZH4bbX60qYl0IhdycO18fgu7Rl
         tbWNDi4Og/vpkPbv9w/2da4lHB3kSdqnacW/I1RjSctisq0ByFvQ3syR2D9RDToBdJRd
         /2XgxVG6SSggZ19NKpI47LRiROxI/lMp8A+M6vU2k+L0aXEpa8NYi+FI6dDBcGIW6Wtd
         gXcevSa/RRb1bxQKtPaHHFZxDJRelqX2piRoKQeXz5RM698uqTAQ9mUB9XIpgWTeAovq
         oyCeGLUI1qzoxb/X8SfO313+wqBSPZI5C0p9WaQYJzelz83vgHbwafScyPSDVvpnrYWt
         M80A==
X-Gm-Message-State: AOAM533vdMEO1OSAA76D3gKHSgkBlOyF8rmrQGAltg5V+Wobj9OOEuo2
        SMngJao4vTwirNLo8zWL5infYw==
X-Google-Smtp-Source: ABdhPJzv8qdSlKpXUXZEnltPAAV/8T3YIxP2tHLDjv5DmIpbC3EC8oCGfwcWkp6oBYuakLpHJH3riQ==
X-Received: by 2002:a17:902:cf0c:: with SMTP id i12mr7387028plg.64.1644496645014;
        Thu, 10 Feb 2022 04:37:25 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id i8sm11767812pgf.94.2022.02.10.04.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 04:37:24 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 1/7] mm: thp: fix wrong cache flush in remove_migration_pmd()
Date:   Thu, 10 Feb 2022 20:30:52 +0800
Message-Id: <20220210123058.79206-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220210123058.79206-1-songmuchun@bytedance.com>
References: <20220210123058.79206-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flush_cache_range() is supposed to be justified only if the page
is already placed in process page table, and that is done right after
flush_cache_range(). So using this interface is wrong. And there is
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

