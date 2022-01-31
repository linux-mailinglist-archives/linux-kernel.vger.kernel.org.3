Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A852E4A4B33
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380006AbiAaQEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380002AbiAaQEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:04:11 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD61C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:04:11 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so12959145pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iQH5onptg6s877J45y8Fks8F6bmcOMzezi8xj98jFE4=;
        b=EastST5ZIcLSESMsp5gzxuTqcCSNgh5+VOlWEXH6hIDH/Y+6Yi35lcJ+cnIcbEKd7m
         ys4Lc9gV7R1lfGNhqxJc+0ZWjEjrfRAh03XbwNQJ53zVIlzmP/zQztsQ3zILrR4XJDYD
         rdDAzYkP/5wsiH5bx7EUldm57nS/S/pVfNhfrTxu0WxmmGgw9Ah3xuHFcL6fj+0NqSGV
         ZkvPlQ/0AC4dX++DpJqmn/6luHcfdGPKTHwysX/OSTavRqfsce1g9gsT8z2fFQGeXmvM
         CrHvh4ovORh0oE2mshQS/a7a4kDp+bt1wsKPtyuevVZy/noM5LRw2Sk8WpFt2yMPhny8
         JFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQH5onptg6s877J45y8Fks8F6bmcOMzezi8xj98jFE4=;
        b=5nBzFdGIklv+1uAaoEpDMPP452gIdO5lWOunxh5G7SajaHj0/qnSh5nL7HTfgkROOo
         L+SiTYCug7suo/Dh3ysEErUo6b5CxCXcWqNPN2EcgRIKCSy9la8vg1k8k21mwT6jJlt+
         jCZUZnrlbo5AtpuPOPspEKHw7RGoVzSxtSa+w9nIF6IEHLaTyuBlr3d5fD2o4eeY1ekY
         uSUKm84ziV+waqluvk8iqQBX4OPTra3eLm0uJ9p3yGgn6R+UfpD6rRwDkN825UFjK5c4
         B+R6RMG70C0DNxMlSvlu4ELqwWRNIqoup0uPiORTO8edTYBb5J+FteXb0/u6zR6BYGuD
         ul6g==
X-Gm-Message-State: AOAM530nGiVnlu5GkQBURvNlLd/nHn0iLHwwtQaJYDx789Jac4LqzmwG
        7s6wN6EagPratD33YNVuaD+NOg==
X-Google-Smtp-Source: ABdhPJyKqjzk6JU+7cZI+lIZKz8qJV0tOrsdnXMJaAquGWsMKIiUnglaRbBHuWSf5yL2XPDGOcbabQ==
X-Received: by 2002:a17:90b:1952:: with SMTP id nk18mr34913304pjb.101.1643645051035;
        Mon, 31 Jan 2022 08:04:11 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id n42sm17940716pfv.29.2022.01.31.08.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 08:04:10 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH v3 2/5] mm: fix missing cache flush for all tail pages of compound page
Date:   Tue,  1 Feb 2022 00:02:51 +0800
Message-Id: <20220131160254.43211-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220131160254.43211-1-songmuchun@bytedance.com>
References: <20220131160254.43211-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The D-cache maintenance inside move_to_new_page() only consider one page,
there is still D-cache maintenance issue for tail pages of compound page
(e.g. THP or HugeTLB).  THP migration is only enabled on x86_64, ARM64
and powerpc, while powerpc and arm64 need to maintain the consistency
between I-Cache and D-Cache, which depends on flush_dcache_page() to
maintain the consistency between I-Cache and D-Cache.  In theory, the
issue can be found on arm64 and powerpc.  HugeTLB migration is enabled
on arm, arm64, mips, parisc, powerpc, riscv, s390 and sh, while arm
has handled the compound page cache flush in flush_dcache_page(), but
most others do not.  In theory, the issue exists on many architectures.
Fix this by not using flush_dcache_folio() since it is not backportable.

Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c9296d63878d..c418e8d92b9c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -933,9 +933,12 @@ static int move_to_new_page(struct page *newpage, struct page *page,
 		if (!PageMappingFlags(page))
 			page->mapping = NULL;
 
-		if (likely(!is_zone_device_page(newpage)))
-			flush_dcache_page(newpage);
+		if (likely(!is_zone_device_page(newpage))) {
+			int i, nr = compound_nr(newpage);
 
+			for (i = 0; i < nr; i++)
+				flush_dcache_page(newpage + i);
+		}
 	}
 out:
 	return rc;
-- 
2.11.0

