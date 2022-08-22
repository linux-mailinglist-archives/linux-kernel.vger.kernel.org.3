Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9970D59BB8B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiHVI03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiHVI0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:26:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9062F5AC;
        Mon, 22 Aug 2022 01:25:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r16so12213609wrm.6;
        Mon, 22 Aug 2022 01:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZQMxC8SQcK7D46DZF5jtDRzGw0Z16LiNuM+Bzk2aJSo=;
        b=OLNL7exAXaIJduiNgoQCsJ6rZMgitXCim/HKlxMgBRRUMCxtAAGNXtBtdJheaqg3pC
         TliuMGd3pDcTM0WkGacO/UZyKRKECjlG9Ivq6S5pkWzazG/SiSWx1c22mT9jRaFgdULc
         uKtdOp8YucD7O/pNet+Y6K5EyTp5iQwS1AqbAP1Jmkl4bXT2K8HjhmnI5SUL5R3SjuSV
         wFYxO3P1vtwx1gJuNwHXyzk0gGnBpf1Wqs4fFBhoAFAonxxG3aOXc7mMbBu4OlCxcg0S
         PALZyKiXSsboDOgNWyC5yTxYoPEifsTcDhQb6avJ9/RCrwlMmkA/31s2jiE6pkks3ayk
         gPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZQMxC8SQcK7D46DZF5jtDRzGw0Z16LiNuM+Bzk2aJSo=;
        b=Glvm8QKUGiM7TKktdBRNHxHYf2+XDoOCD3uIr0XU0L4UVB5WrowodhssPRaTrqgz59
         nTtMBv/gP//2rh1D5GMw3a2LqSXHCGNxri0W7IiFLJHz+fNaMHYirFuUQIpplsn01sUL
         XuuLbnT/PPzW/aLgno9cB3fZnzknc37rz4VyaaEmOeZObHsII9izn61k9RNOro0Dqbd3
         Kef4k1vPoLRRt2PVzXWgIHQFqfAYKZUlo36WK+sYrfc2hxRQFyj4nSJPYB2LeIC3vsDQ
         zNoXH84xi0KMRIQ7s3BGCkjvnYaAIhByj/o0bZQh9AwWRwXmouhKTn6/CD4wURLrD0XP
         +d2w==
X-Gm-Message-State: ACgBeo0Zyr/WQuV48BHx/jYuOHb4RMLkP64f36+GlZ2+xM36Wovs2B81
        SM9llkChCdiDFjwqfNbidvqMVxTS0Wg=
X-Google-Smtp-Source: AA6agR7sv04KNDMmxFOJpvl9C2FbEVaKWNy3FaYLC+PE0f+To+BYbZRu8vRj6lpsja472y0AXYkGnw==
X-Received: by 2002:a5d:47c9:0:b0:225:5a4f:8f82 with SMTP id o9-20020a5d47c9000000b002255a4f8f82mr1877881wrc.0.1661156751316;
        Mon, 22 Aug 2022 01:25:51 -0700 (PDT)
Received: from felia.fritz.box (200116b826f28600ec06010f612e4c3e.dip.versatel-1u1.de. [2001:16b8:26f2:8600:ec06:10f:612e:4c3e])
        by smtp.gmail.com with ESMTPSA id m30-20020a05600c3b1e00b003a6077384ecsm17912800wms.31.2022.08.22.01.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 01:25:50 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] mm/hugetlb: remove unused local variable dst_entry in copy_hugetlb_page_range()
Date:   Mon, 22 Aug 2022 10:25:25 +0200
Message-Id: <20220822082525.26071-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a0e4f7b82610 ("mm/hugetlb: make detecting shared pte more reliable")
modifies copy_hugetlb_page_range() such that huge_ptep_get(dst_pte) and the
local variable dst_entry is not used explicitly in this function.

Remove this unused local variable dst_entry in copy_hugetlb_page_range().
No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 mm/hugetlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9a72499486c1..6c00ba1dde32 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4763,7 +4763,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			    struct vm_area_struct *dst_vma,
 			    struct vm_area_struct *src_vma)
 {
-	pte_t *src_pte, *dst_pte, entry, dst_entry;
+	pte_t *src_pte, *dst_pte, entry;
 	struct page *ptepage;
 	unsigned long addr;
 	bool cow = is_cow_mapping(src_vma->vm_flags);
@@ -4823,7 +4823,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		src_ptl = huge_pte_lockptr(h, src, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		entry = huge_ptep_get(src_pte);
-		dst_entry = huge_ptep_get(dst_pte);
 again:
 		if (huge_pte_none(entry)) {
 			/*
@@ -4906,7 +4905,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					restore_reserve_on_error(h, dst_vma, addr,
 								new);
 					put_page(new);
-					/* dst_entry won't change as in child */
+					/* huge_ptep of dst_pte won't change as in child */
 					goto again;
 				}
 				hugetlb_install_page(dst_vma, dst_pte, addr, new);
-- 
2.17.1

