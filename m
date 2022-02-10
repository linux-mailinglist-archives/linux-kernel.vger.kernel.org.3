Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A4B4B0DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbiBJMhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:37:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbiBJMhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:37:37 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6515AB3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:39 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w1so1700268plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kILCWGYQN4aCmOVzGkGgpbDqf3vflThkp2WsD9ah7ls=;
        b=fG95xjXcp5pb/4AZm3qvm7w7s5VMHbtcG0Lx0tYYXqTPxFq3Uc9uBYT7LAv2r+KKbS
         O4ERCsf/+TVyMN0TI/YJ5AQEXti7JI7zzwU0mLvt4C3cBqleBqOzGfuRZcC1OF+y8qK2
         vSoUE7Hf9EA/yx8S3k+43lmfcwEiQw/pT+Qqytcy93VzMeV9T5V1d8vGtrZWnnkTZ83m
         gsLyBS9KN5r5acorSo3QXiEsgVjacHClEVUDMD4sG3kLdlBslDcPD75Vy3XQBiXZPJMa
         t7zXdHWqMkokITwK0wwNIOyWHuSRyTfwh6IqmbAlxzQ9Gwc1zYBjlhUYgd302H5unjo9
         UwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kILCWGYQN4aCmOVzGkGgpbDqf3vflThkp2WsD9ah7ls=;
        b=MC//iyPS0roU4ey1pYO5Kx16K/VhM8qesCrTtuy+4Nq8faQ27LBtOgFuUPAYzvoqLI
         hbA1XLFFo66i1jatXnV+jU6BC6BN73+ITOMn7MeU7CfaIVLrYLnQ1BQcweRg8Zs6PzLI
         WlYHFN44M0FPYTqsSa1VOOzthwak0b3uQQA1dHIZvChf1kuw3rx4ici6Etf3gwDIEvG6
         FARajU9RPGDmmJgv7kisPhusRoJ7ZYYxFw+6vL+Zzo8pG4DBBldSC6MVFPgAYVWDgXpM
         TfRMVJ+etTRHLVXaruLe9jsApRbI1VpJgjxkZUxEYQjz9vkSJxGEImdkLLrMRKpkEafm
         JCsQ==
X-Gm-Message-State: AOAM5337Do5IJc5Xx6KnjqyJH9H/IJ+f7QRzb9G8ciyPhcyC3SBToh7j
        DdOsqXt0A5Fn9DoNqCVxu8KEA7MPztMoJWQP
X-Google-Smtp-Source: ABdhPJxXO3PdREGl7iYGtPoZwu9ZnEuV9DWQ2+VdIf1bDfCvRiQrzRC1gMtC9rR0cVrUjm5h5t4w8g==
X-Received: by 2002:a17:903:1211:: with SMTP id l17mr7635562plh.11.1644496658991;
        Thu, 10 Feb 2022 04:37:38 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id i8sm11767812pgf.94.2022.02.10.04.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 04:37:38 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 4/7] mm: hugetlb: fix missing cache flush in hugetlb_mcopy_atomic_pte()
Date:   Thu, 10 Feb 2022 20:30:55 +0800
Message-Id: <20220210123058.79206-5-songmuchun@bytedance.com>
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

folio_copy() will copy the data from one page to the target page, then
the target page will be mapped to the user space address, which might
have an alias issue with the kernel address used to copy the data from
the page to.  There are 2 ways to fix this issue.

 1) insert flush_dcache_page() after folio_copy().
 2) replace folio_copy() with copy_user_huge_page() which already
    considers the cache maintenance.

We chose 2) way to fix the issue since architectures can optimize this
situation.  It is also make backports easier.

Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a1baa198519a..eba7681d15d0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5818,7 +5818,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			*pagep = NULL;
 			goto out;
 		}
-		folio_copy(page_folio(page), page_folio(*pagep));
+		copy_user_huge_page(page, *pagep, dst_addr, dst_vma,
+				    pages_per_huge_page(h));
 		put_page(*pagep);
 		*pagep = NULL;
 	}
-- 
2.11.0

