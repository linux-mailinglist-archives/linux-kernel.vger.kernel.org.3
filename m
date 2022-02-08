Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C70A4AD247
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 08:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348305AbiBHHgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 02:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348287AbiBHHgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:36:38 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05141C0401F6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 23:36:38 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so1330180pja.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 23:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKFpQhrIc0qg1OGn2vjlbFux2cfH4pwiDVgfg/+s2Gk=;
        b=aesHRx4mkuJbzEXODBVC2NuJ3XIEly0uKuZ0fmmOCkbIBaQTKzJFrpHLliZ6LydIDC
         ZC6nmHSeL7VuMK9rDPMrgXApR4hnw1zY9zkx3KRUddNG14JwZrOt0HceyD46+rolqZSx
         5HGsRA4wl3xJql/bNDiaoEcP5SL7tVmEM7fgqxVDJXJ0tBSkiUrnWmm8pAaDWr0inTKH
         A1TNo7Qo7cAjAJwTEXN/9nx4/YP86wP+m5YLCsjmA9PDo8Zwq+CGiG7a8HGwA1yRkFLt
         ziW2W/YhD7crzFt9s/t23pfDkgrlu90mkwCSBpAoO68ukfznQJvW2mLcsjBEhGGXcioK
         9Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKFpQhrIc0qg1OGn2vjlbFux2cfH4pwiDVgfg/+s2Gk=;
        b=0pTnWYbbFWfENbH3YyyoPrdG/274BJko2GRHkMb8igfnW+59a+SFE35nxet6ABp8/l
         LaCFDfOTWVF+kmp15iwM3mhCJmFNWanj22Fx2zUCBp6Eqyr7zkapdGTxegNoJazu7Mhq
         q/EdCFQHAFpNO6q+gQNyb0lqIE8CzepezOzOqFcK7lQB4JnhfiyurD8FP9aBjUwZgB4V
         TaMwOWiqF6tqWY7ZkTDVevuf1umPcUh5jLITFrSPdeRQHDVRUWdO851tFKJ8kQ5s3fp9
         Bm7jJjxN92rlDuiD7A/1ACfqOvVQJT785MRqHvib4fX1kFvHEBWda6k+B5IXzugzYp2r
         npMA==
X-Gm-Message-State: AOAM533RbWlGouCDymYJQN8irSSiOd5jJeTQ1xuhZsvm9ko282QnX7d8
        WrusSnR8am2Naovo2QbgJ9aakg==
X-Google-Smtp-Source: ABdhPJzEt4E48DQEs4fdQH9qP/j0O1H1fFoyW4x9658/zRKEKEvOfX+7jWzf6rShGjw7nmSjy1Bt3w==
X-Received: by 2002:a17:90a:8904:: with SMTP id u4mr2969489pjn.137.1644305797603;
        Mon, 07 Feb 2022 23:36:37 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id gx10sm1621017pjb.7.2022.02.07.23.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 23:36:37 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 1/5] mm: thp: fix wrong cache flush in remove_migration_pmd()
Date:   Tue,  8 Feb 2022 15:36:13 +0800
Message-Id: <20220208073617.70342-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220208073617.70342-1-songmuchun@bytedance.com>
References: <20220208073617.70342-1-songmuchun@bytedance.com>
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

