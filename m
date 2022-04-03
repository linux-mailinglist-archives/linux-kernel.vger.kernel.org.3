Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54E34F07DA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 07:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbiDCFnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 01:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbiDCFnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 01:43:32 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144E7340F5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 22:41:39 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 125so528000pgc.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 22:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P/G4cY6LA4u6yV/b8BGhElOxrEr7wa4Csrvtb+Y6qso=;
        b=7jSVQ79b+01y0a3OIt4mIy3OD3Bmy88FmGcA/qn97f2Sw2HTM5zHt5Z3vf6eSa05O5
         8KATfUa7aPdV9idYkmMFpQa7avLXAeGK7o21AsI+a/FVKxiqlZmHorgTTju6bnHLfHt6
         oWLIAHsD4cxl82X558HPB6VNb45Uomwcmk9+JIZ0QfXDwex0bJnDmMai6OsLpPpHWteC
         2QezqEXHY1peozS+If4seb5mEfpnvno/EA2OzdmWprY8lmLKDdKzXeOOvxPeQCKg3YuH
         Z4f9zEjIPoK+mkeSx70BhARKhSvGBE+qygkzwVs/Nr7nirXqN0f33JPXiYNKA5gZjZdA
         LCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P/G4cY6LA4u6yV/b8BGhElOxrEr7wa4Csrvtb+Y6qso=;
        b=O8JYF4AByFQBM4puCXxaDWp7VX8Txiz+H7nmR8qZ0qgCcpOPNy9NPFbuDxpGudUe2G
         Nv5PkMD36Om3A9Pa5QQlVpcYtkp7ETOvpkLxeKhJc3T2K121ER1LBTdrsIPsNNQcSgp+
         k8wB27iWBIlLFfBu0UCFZTUDzG9gSh/UYoqAksYHXOsfC4igN0EG7XGBeZT++NrICxhc
         FNNl8S2wFdqoKQFUHvVk7mwsYU127/97c5cwC28yWXCnYHGi7qKH9n4RhBaEdJLROHzd
         UiJktC8icg00Luzbr+8G+fsbKs6wlYlydn5xL0KRyqmqZ+Tv770J5YLcUgmWAa4CUpUm
         3j/Q==
X-Gm-Message-State: AOAM533iVrvI3kBC8udhZnKBJbTPfwRkJzq1Ne119l9yt3goVukxViF4
        WVwKUbii73Euoru8tPbhvi4AMQ==
X-Google-Smtp-Source: ABdhPJxGOROIqTOKId5F4JMIrbX834xDIMvBWzvSxSoC7uaCqPhyXCkc5AknFgZY3po9EwZFzgLsfQ==
X-Received: by 2002:a65:6e82:0:b0:381:71c9:9856 with SMTP id bm2-20020a656e82000000b0038171c99856mr21437599pgb.316.1648964498579;
        Sat, 02 Apr 2022 22:41:38 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm8262479pfx.34.2022.04.02.22.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 22:41:38 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 4/6] mm: pvmw: add support for walking devmap pages
Date:   Sun,  3 Apr 2022 13:39:55 +0800
Message-Id: <20220403053957.10770-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220403053957.10770-1-songmuchun@bytedance.com>
References: <20220403053957.10770-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devmap pages can not use page_vma_mapped_walk() to check if a huge
devmap page is mapped into a vma.  Add support for walking huge devmap
pages so that DAX can use it in the next patch.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/page_vma_mapped.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 1187f9c1ec5b..3da82bf65de8 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -210,16 +210,10 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = READ_ONCE(*pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
+		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde) ||
+		    (pmd_present(pmde) && pmd_devmap(pmde))) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
-			if (likely(pmd_trans_huge(pmde))) {
-				if (pvmw->flags & PVMW_MIGRATION)
-					return not_found(pvmw);
-				if (!check_pmd(pmd_pfn(pmde), pvmw))
-					return not_found(pvmw);
-				return true;
-			}
 			if (!pmd_present(pmde)) {
 				swp_entry_t entry;
 
@@ -232,6 +226,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					return not_found(pvmw);
 				return true;
 			}
+			if (likely(pmd_trans_huge(pmde) || pmd_devmap(pmde))) {
+				if (pvmw->flags & PVMW_MIGRATION)
+					return not_found(pvmw);
+				if (!check_pmd(pmd_pfn(pmde), pvmw))
+					return not_found(pvmw);
+				return true;
+			}
 			/* THP pmd was split under us: handle on pte level */
 			spin_unlock(pvmw->ptl);
 			pvmw->ptl = NULL;
-- 
2.11.0

