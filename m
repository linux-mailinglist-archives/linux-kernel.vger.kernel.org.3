Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752334AD24A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 08:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbiBHHgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 02:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348336AbiBHHgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:36:48 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D318C0401F5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 23:36:47 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso1433514pjg.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 23:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cll0HiNGaOM9yDWI60AkgZZ8Vcgf+tRA3oZc4UBL7nk=;
        b=y0jpOk6gAkKem1qpuxCydTJQeI0RYuJhd3oYTOoGI39XA5VyoB+ep0jJ6o+P/dV+6o
         mlwuzoo+SR5YLg3y2a/BC+MJRoaSWHaJ+qAJZb5Y5tHw3Dvyj2R7bsDTORVKf+0aoy9q
         Jn9P8oSuy9WMEeo5jqDcltiB2MAuJdmewps+UxFLCGBfsHbB4Nz8BgoO7bfS4ookfhRt
         fJVNLLDP8w7JHk+3AsBSjsnnR7LoF4EmZz1NN9NARpNJUzV4ELzDvSQGQOwb5dl3rKMT
         pSdNUaU72b0vAJoGUIJ5R22jT7AVOdSonWMx6C0mW3i1zT2otqX9O90SuABNbMer7Tl8
         XOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cll0HiNGaOM9yDWI60AkgZZ8Vcgf+tRA3oZc4UBL7nk=;
        b=EMmI4hSeQhgLS7yHQ54ESa4ENYmPL7+a5J4MtxJ/fQuud9JqVB5Fk83djHQH9QQe7s
         GET8/cRI3GT26AkNLOASyn/89Eu5C7WkDqRUA3G/mnRybrU1dOZJRofT5myZAM5ihu5X
         S83VEyPWp0Juv6NpI5XvFd8t4Fyw7tgZ3O4068unHtsCZfUWQthpHURFoxyesmgEz2Bt
         k0doIYWh5T4t+Sdh5NCSJ+3gFWbmffg2dJtMdJuAQXwvJXgecGf2X77hO6qa2Wnsav5G
         IOGI20a3E77hWRRERcBdU0OWE2h8JxNNFN0IUBYqsmn0LhhqrjA8Ic0XVy3kiiKrOZyl
         Y9bQ==
X-Gm-Message-State: AOAM5322HnN/PRPhHTRr89E87sYTunpOzOjuy9+TmPURLNOnYJpFCsj8
        u1UV6y2kAtKmjmTUhnHie5h5dA==
X-Google-Smtp-Source: ABdhPJzvsh4kBT5/wdRGyGAAQcGNW7TSFAisLlWR6Pe1OtowTbWhv0vQtaLjIv9HxR4IbxCYWBl48w==
X-Received: by 2002:a17:902:b90a:: with SMTP id bf10mr3230897plb.36.1644305806765;
        Mon, 07 Feb 2022 23:36:46 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id gx10sm1621017pjb.7.2022.02.07.23.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 23:36:46 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 3/5] mm: hugetlb: fix missing cache flush in copy_huge_page_from_user()
Date:   Tue,  8 Feb 2022 15:36:15 +0800
Message-Id: <20220208073617.70342-4-songmuchun@bytedance.com>
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

The userfaultfd calls copy_huge_page_from_user() which does not do
any cache flushing for the target page.  Then the target page will
be mapped to the user space with a different address (user address),
which might have an alias issue with the kernel address used to copy
the data from the user to.  Fix this issue by flushing dcache in
copy_huge_page_from_user().

Fixes: fa4d75c1de13 ("userfaultfd: hugetlbfs: add copy_huge_page_from_user for hugetlb userfaultfd support")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index e8ce066be5f2..eb027da68aa7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5405,6 +5405,8 @@ long copy_huge_page_from_user(struct page *dst_page,
 		if (rc)
 			break;
 
+		flush_dcache_page(subpage);
+
 		cond_resched();
 	}
 	return ret_val;
-- 
2.11.0

