Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC64F4A4B39
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380072AbiAaQEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380052AbiAaQEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:04:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DB4C061741
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:04:25 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o16-20020a17090aac1000b001b62f629953so11323274pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gisX+SmHlGPaod6BmlULNl1QqGpeThEpw2gv3Ed6fPs=;
        b=5Kju0dWpSHwXhYEWvUiml8KB/0ZMWI8SxY+Qz6NYPYq89/Rcn6kjtmlsEGtAmVwJoV
         7UHjH692hPcUl3swiilP52F9+cY+ioBqdsilrfv8fyAr3nyRomOfaJ0DgIobtvOYXmHa
         xLVYYwa1pYNhqIDLyrj0GVbQc089q2E3TI/YbhKZr3Nuv66N5mnCSnrH1ZEbKxM/KuF/
         8m3792ODuO8Q2a+VlrTtC4n0FkTsRVP7BJ8Fy1Xj7Z0KimoGrsiJHh9CIAD4fClr/mi0
         a7ZMNNBfQr2jcIC63VZUkaEmE2I8HeG3ec7oLHCYwwu/Srwvs59VWyFub+A/ec54/yny
         4qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gisX+SmHlGPaod6BmlULNl1QqGpeThEpw2gv3Ed6fPs=;
        b=o2bESRfUjcuOoP6CwkbfuIQ0czEQcD2XU4Na0cyAQS/UTkZlM7hlH4ySa1rQCIFwPT
         CvYW1GsIbH0RW6ovyyOTtIVn/MSo8M23ZJZQhf89PgaN9eTXcRLePAeu2Is5vZ3h+khf
         caMDXnieEZ0F4fVm/H0mJ7jsToxjUBjTJywOvOOf6bSrGYZY+2Hnvvc9ygpGKDr7ei3n
         SCJNiWTZPxGhykWE+M5o1V/tYQzNrj+arbcEBf44vKFGYC8B5onBxxPGNznEHMXAHr0J
         OyKuGZdBF6PhDXA1mPd4LEoKopW19/lzX3+WS0k4Am52TiFJ6/km05lJzC1AkT613CM1
         6nIA==
X-Gm-Message-State: AOAM532ClVQ71Pf0LQHtorYoWtiqI9qBNoBl+73TIxQCgk6949GQfhWF
        mGtko9+4O/Pomt9NpTj18NR6aw==
X-Google-Smtp-Source: ABdhPJwnOHSIH/tVeMiDIsL5x0suj1BcB23ljOBPvIUrK1xrla1SShg+QsGbaZcLU6k68TnfcGxnWQ==
X-Received: by 2002:a17:902:d2cf:: with SMTP id n15mr20697725plc.33.1643645065059;
        Mon, 31 Jan 2022 08:04:25 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id n42sm17940716pfv.29.2022.01.31.08.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 08:04:24 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 5/5] mm: replace multiple dcache flush with flush_dcache_folio()
Date:   Tue,  1 Feb 2022 00:02:54 +0800
Message-Id: <20220131160254.43211-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220131160254.43211-1-songmuchun@bytedance.com>
References: <20220131160254.43211-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code by using flush_dcache_folio().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 6 +-----
 mm/migrate.c | 8 ++------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f1f1ab31dc8a..828240aee3f9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5804,8 +5804,6 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			goto out;
 		}
 	} else {
-		int i, nr;
-
 		if (vm_shared &&
 		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
 			put_page(*pagep);
@@ -5821,9 +5819,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			goto out;
 		}
 		folio_copy(page_folio(page), page_folio(*pagep));
-		nr = compound_nr(page);
-		for (i = 0; i < nr; i++)
-			flush_dcache_page(page + i);
+		flush_dcache_folio(page_folio(page));
 		put_page(*pagep);
 		*pagep = NULL;
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index c418e8d92b9c..daf2b3508670 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -933,12 +933,8 @@ static int move_to_new_page(struct page *newpage, struct page *page,
 		if (!PageMappingFlags(page))
 			page->mapping = NULL;
 
-		if (likely(!is_zone_device_page(newpage))) {
-			int i, nr = compound_nr(newpage);
-
-			for (i = 0; i < nr; i++)
-				flush_dcache_page(newpage + i);
-		}
+		if (likely(!is_zone_device_page(newpage)))
+			flush_dcache_folio(page_folio(newpage));
 	}
 out:
 	return rc;
-- 
2.11.0

