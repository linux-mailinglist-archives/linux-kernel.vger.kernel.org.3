Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2394A4B37
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380008AbiAaQEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380010AbiAaQEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:04:20 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E65C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:04:20 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so12959735pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pht+u875/nHbiyfmnh2sHRDlYx7sxAKFTWEwLAeL/xQ=;
        b=asLzFLOtnhAt1wJ9MkFxljPA6I+O9Q3lLsoNk3YTh57vC01yj731U/WEvoQVHChNPv
         YmPjjWrQVJpd+K5pDqdHk7/Ga+moURiIO0F5YaZp2iEYDbWl0QhBcftDlCDJhERdof//
         PW6WNKKdyMCNG87pMWXQV+Aj5f9tKti/Uvg/D9Wcjem4fI1UyGOCMPBdSppQhkr2Ans4
         8DD/GaoXJkl+gHf4awk75ojdsvXeezRplz7byycXAAk4SvhrjmCccOlB4PEkINoxtgCS
         pcbaOJ6CDCAdwhYM/2vh/kAdKvw3Di51GKUxoUc0E6zOEe5QRkyjCHdmC4Ro5wuy+yXh
         4Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pht+u875/nHbiyfmnh2sHRDlYx7sxAKFTWEwLAeL/xQ=;
        b=xvlrhjE2LSNMUwi20triwBDxotMT9CJ920lPMiMz3XCGvUNHFwk0vv/La54xwP5Skm
         YTJRuF7UuVmxRFZzPGibuUFCqz/heFzTFHC6UiUZlL0jQD0LMmJcp1/0Epu7R7YNjT5z
         zZamfk3Z2zGoVlqpZKjgig2SoQHTa3qHcXETUfCrrFH7pAfCdvCqRE93/82kfQ+1Dtlp
         sJ2VsRc4O1MX6xFOHyU+3DQuBJXRXw0bElMoP2IzcfkUdaSYBzBB3vKxAsf9aqlUCcuk
         PPIWFR/IFDiEJxZmwNCHxfcU7LX4Rt33CN8qRJD61C44ecwA7o1cGWgE2PpILmwqjaXa
         n5/Q==
X-Gm-Message-State: AOAM533SMAHjrywNVzEIjyEOQHUYJnMakBkNomO2zeY0ec7IjRTHGPsK
        W3+TsEzNmYEznvqG7jQzEhwJyg==
X-Google-Smtp-Source: ABdhPJxtq4AiRBDI6E+iaufhjEeklExYl8CNg78gPPyn/nVhJ3VlwPpiHVau25255hprz6v62IPy1w==
X-Received: by 2002:a17:902:8213:: with SMTP id x19mr18163640pln.150.1643645060156;
        Mon, 31 Jan 2022 08:04:20 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id n42sm17940716pfv.29.2022.01.31.08.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 08:04:19 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 4/5] mm: hugetlb: fix missing cache flush in hugetlb_mcopy_atomic_pte()
Date:   Tue,  1 Feb 2022 00:02:53 +0800
Message-Id: <20220131160254.43211-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220131160254.43211-1-songmuchun@bytedance.com>
References: <20220131160254.43211-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

folio_copy() will copy the data from one page to the target page, then
the target page will be mapped to the user space address, which might
have an alias issue with the kernel address used to copy the data from
the page to.  Fix this issue by flushing dcache but not use
flush_dcache_folio() since it is not backportable.

Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a1baa198519a..f1f1ab31dc8a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5804,6 +5804,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			goto out;
 		}
 	} else {
+		int i, nr;
+
 		if (vm_shared &&
 		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
 			put_page(*pagep);
@@ -5819,6 +5821,9 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			goto out;
 		}
 		folio_copy(page_folio(page), page_folio(*pagep));
+		nr = compound_nr(page);
+		for (i = 0; i < nr; i++)
+			flush_dcache_page(page + i);
 		put_page(*pagep);
 		*pagep = NULL;
 	}
-- 
2.11.0

