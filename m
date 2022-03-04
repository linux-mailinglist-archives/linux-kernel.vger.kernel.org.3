Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCF14CCCFE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbiCDFVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbiCDFUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:20:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D477182DBB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZsj8wGvJYP0Z35VYck5GXCqHSNO5FmtKWCwc6ZUvEE=;
        b=hLYXAFE7nhtMixtTlijhkixA6p8xjmUAClTwIJcrK/mfQcZQY3cdS3NvYM8Mqi0jH7+to5
        HuMYovYgsKWFnnoUfaVi71FRz6lXseJ3lHy8X0Faj2HmCOUTueUIMr+uT5Ei/esj5o9v3r
        8yIYpFgPt+5Rqq6ofX9sMrxQWBl9W9Q=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-9uWn_ZIGMByvYnbyOl2QTA-1; Fri, 04 Mar 2022 00:20:04 -0500
X-MC-Unique: 9uWn_ZIGMByvYnbyOl2QTA-1
Received: by mail-pg1-f197.google.com with SMTP id v8-20020a654608000000b0037d5ef9cfa0so212301pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZsj8wGvJYP0Z35VYck5GXCqHSNO5FmtKWCwc6ZUvEE=;
        b=dNGtFQZzoLw73uVBae0mydS4Ctl/Zd0xRyKa2ixg11XlDg0LONYizvWbD/6sb/3/vB
         QHS/wPtK43VxNbc0yhznVl5hlnYiFQ+w3VjDhNT2qBCg2HCTLIdq2vnRs/dQhK48D2Pr
         csn2kIJb2yCwH1rgaFO3jxI/oRaeO7tIXXvjlN35p6iCohqniiYUyFojEKWd2JfiZYPx
         hmn9sC+GJd+Ba7j8pfmRU3UXmFRUfJzin80QWzIlAH12X388QNDAt3k5NuoN9UkNsxfA
         jfIaSow6xpVYtDgMSljSDPD6O+xlrr4MXm7olkktT2OQxGtd5KxH/6EWeV0Vwsse2K92
         9YtA==
X-Gm-Message-State: AOAM531+2fm3rO45bBLQBBQNKq5ryr+BvJNGtvjNgUjchqqcHF/FaAT1
        e3psGNp3Tl1HZIMW1huRedckP9maagwuRHKhdnkDy6A4mNkDbbhbHfDRlSI2HV+rFKtsJwNNClF
        yrAtJjKvpveYs4FGNpPhjLmGq
X-Received: by 2002:a17:902:6b47:b0:150:80de:5d49 with SMTP id g7-20020a1709026b4700b0015080de5d49mr34640514plt.77.1646371203263;
        Thu, 03 Mar 2022 21:20:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw05sOycQa3nYtvDYuzzS5+ZO7xhuLtA37+jl2qgXReyHL11C3e1uJ1D5StzvLh4AArL9JTNA==
X-Received: by 2002:a17:902:6b47:b0:150:80de:5d49 with SMTP id g7-20020a1709026b4700b0015080de5d49mr34640498plt.77.1646371203014;
        Thu, 03 Mar 2022 21:20:03 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.19.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:20:02 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 20/23] mm/pagemap: Recognize uffd-wp bit for shmem/hugetlbfs
Date:   Fri,  4 Mar 2022 13:17:05 +0800
Message-Id: <20220304051708.86193-21-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304051708.86193-1-peterx@redhat.com>
References: <20220304051708.86193-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This requires the pagemap code to be able to recognize the newly introduced
swap special pte for uffd-wp, meanwhile the general case for hugetlb that we
recently start to support.  It should make pagemap uffd-wp support complete.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2c48b1eaaa9c..46e5896b82d2 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1421,6 +1421,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		migration = is_migration_entry(entry);
 		if (is_pfn_swap_entry(entry))
 			page = pfn_swap_entry_to_page(entry);
+		if (pte_marker_entry_uffd_wp(entry))
+			flags |= PM_UFFD_WP;
 	}
 
 	if (page && !PageAnon(page))
@@ -1556,10 +1558,15 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 		if (page_mapcount(page) == 1)
 			flags |= PM_MMAP_EXCLUSIVE;
 
+		if (huge_pte_uffd_wp(pte))
+			flags |= PM_UFFD_WP;
+
 		flags |= PM_PRESENT;
 		if (pm->show_pfn)
 			frame = pte_pfn(pte) +
 				((addr & ~hmask) >> PAGE_SHIFT);
+	} else if (pte_swp_uffd_wp_any(pte)) {
+		flags |= PM_UFFD_WP;
 	}
 
 	for (; addr != end; addr += PAGE_SIZE) {
-- 
2.32.0

