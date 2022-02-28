Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980B44C6312
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiB1Gg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiB1Ggv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:36:51 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA9566F87
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 22:36:11 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z2so9856051plg.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 22:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eiCDiO7SeVqlcAe7b/JTkNhJRMnMslj9oR2/HG6e9n8=;
        b=hNvJJ0ezpU6tq5crtKQjZkvHgC7+HknHsNaTEEdgZR8JxxtwLFGoDAyD7x5IwET35y
         ZPRng5dZP2a5eK9ia13pSI2xguMnF9Za8S99u0xgEEo87HHYB2P4Xej2LVHL7eH+AKct
         xrxdslSfTa0qiPzYYh9Uj7RiCdwmZhmN4QcvdcS4l0U5en87upCMi2dRj4MX+zYpyYdE
         9bx2sftxHiohg9+NFs058WNmeoDpjma0q+zV41eABj5OLtmklp0RsU+byN9O8I5+y/Bh
         tS+HxIBYiIWT8UFKIb4XxBS4fOT1yRMgLmmi9yUSb3Xpk4yxR/XN6G6R+JLCWfBCibNi
         H5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eiCDiO7SeVqlcAe7b/JTkNhJRMnMslj9oR2/HG6e9n8=;
        b=tyV+i7cDcyEdg85Cy6IJy8ePGR+lfJPntqmt1rqA4Y7lUPL3JDU3rLbxHLXgqCdG1g
         lfFXxEZqrQfy5gxN/IlEh36uyKa0iXgc2ORZ9RieKsSAtjsZQJGvxeIEs+F7IF6yqKth
         GxyNwsf3SFprEBmDNhJDkPFqNUfqN4KgqjQRbIRAi1jzGO++um1CeOCljA/o7It3D/Vm
         YVyb5gsILIvYGlSab7TZC7/owI80AtaI0V+36XBCdLj47sJqn0VDX1NxLc+51u0E0J8K
         Nu/k4k3Eib+iwdgZD6n8bp+YHUmnm4XmZzRC7dXvtcWMDkU07jPnFyH3bjU0xk64YJcl
         dPXA==
X-Gm-Message-State: AOAM532xjEaiuvxZHU/sQGtn0CGIaINDdZT87IJI3ZNaKArC/be3OdJ6
        tH9mH8CMPvbOUhOBTvF35+lP6Q==
X-Google-Smtp-Source: ABdhPJzWNg+jqXhXX9lmsTizHuYtvGyPT0fg3+W582PsfWEVtMonxYeOPpLeTi3y6GAcOQpWl4KCZw==
X-Received: by 2002:a17:902:ce8d:b0:150:1d25:694 with SMTP id f13-20020a170902ce8d00b001501d250694mr17105506plg.36.1646030170821;
        Sun, 27 Feb 2022 22:36:10 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b004f13804c100sm11126472pfg.165.2022.02.27.22.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 22:36:10 -0800 (PST)
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
Subject: [PATCH v3 2/6] dax: fix cache flush on PMD-mapped pages
Date:   Mon, 28 Feb 2022 14:35:32 +0800
Message-Id: <20220228063536.24911-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228063536.24911-1-songmuchun@bytedance.com>
References: <20220228063536.24911-1-songmuchun@bytedance.com>
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

The flush_cache_page() only remove a PAGE_SIZE sized range from the cache.
However, it does not cover the full pages in a THP except a head page.
Replace it with flush_cache_range() to fix this issue.

Fixes: f729c8c9b24f ("dax: wrprotect pmd_t in dax_mapping_entry_mkclean")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/dax.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 67a08a32fccb..a372304c9695 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -845,7 +845,8 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 			if (!pmd_dirty(*pmdp) && !pmd_write(*pmdp))
 				goto unlock_pmd;
 
-			flush_cache_page(vma, address, pfn);
+			flush_cache_range(vma, address,
+					  address + HPAGE_PMD_SIZE);
 			pmd = pmdp_invalidate(vma, address, pmdp);
 			pmd = pmd_wrprotect(pmd);
 			pmd = pmd_mkclean(pmd);
-- 
2.11.0

