Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FB34DD577
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiCRHs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiCRHsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:48:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D573E2BA3E7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:47:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so7668073pjp.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NuRXQ/E55v0tYD0et/dnDN8T47JEbNkSk7dguxnQZEo=;
        b=f56NKbZr0fS7dQ3Aad0mMvcBmfIop5dHmXc9y5u9PueUTvDmpaNUdl3yP56cDmqCi5
         bpv8yWaeoMHx2uC7jXuuQFAzjdLIqY+nwy5oE4BmobwP637kHe+q4sWMEJaPaKAPuqUo
         MgTV5yXwMqTYdXeTDikj07OxMWnlP/maWDLeb7ewDwzrluxmUrOTlgFvjf0XTXGKe720
         x+kIdO0LLQb01mRllWxCAeZHD5s7NF98hfhaDWa+3hp/HWQcRuSy5X1f5Fpcg+A8N4oa
         1aT3QUOx2EmEWgIZwZ1a1m0MR6iK8ZKmXXFqk5MD11TVJo2jrxzpXMfJzUqazbiS7TqX
         2r0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NuRXQ/E55v0tYD0et/dnDN8T47JEbNkSk7dguxnQZEo=;
        b=jgBI2yJmbwj9Bcts0jHinlqOZgDwkGeo79PS8KmRRgf+nKNk9M7D3VHr9YZDDamVSF
         B6MFp5kcjlu69WFpXPA/nxt1Yn48xKfFlVPg+j8Vn35vC9hxOknp1cDcWFvMEQ6VIFxf
         NwcvpV7q1771A+y6XPCa0Ii5IiZHasXBt6Vx8/XPWFUZLgk0nSSqUJg0wExczWYLFTMH
         HluTM/st7gNl3iqZY84TEgnPUAhTbwUdU7XeNACOlOsBf2Jkr/bu4tQEP7DWHk6BaYxu
         FXaz78820/DIKTeLUVQf1JkCfBej6bUDpphCECs3fQJN+N5xaTuJUgcyOyre91rP4CYe
         LGSQ==
X-Gm-Message-State: AOAM531hxUSXVQobH8e7EHqO7Y6qi9b4RLzM3i5GCXx5i31uPzvjhqnD
        FTAk/t5SaGnyhcmGeco+gO1Mlw==
X-Google-Smtp-Source: ABdhPJya/68onNzuV2mkq//V4WOdU9M2a18pUc69NLpou9mxKv7f/CTZ8VDDrvE+h2qT4ssg3AnNLQ==
X-Received: by 2002:a17:902:8b87:b0:14b:47b3:c0a2 with SMTP id ay7-20020a1709028b8700b0014b47b3c0a2mr8718964plb.51.1647589656310;
        Fri, 18 Mar 2022 00:47:36 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm8770941pfx.81.2022.03.18.00.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 00:47:36 -0700 (PDT)
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
Subject: [PATCH v5 2/6] dax: fix cache flush on PMD-mapped pages
Date:   Fri, 18 Mar 2022 15:45:25 +0800
Message-Id: <20220318074529.5261-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220318074529.5261-1-songmuchun@bytedance.com>
References: <20220318074529.5261-1-songmuchun@bytedance.com>
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

The flush_cache_page() only remove a PAGE_SIZE sized range from the cache.
However, it does not cover the full pages in a THP except a head page.
Replace it with flush_cache_range() to fix this issue.  This is just a
documentation issue with the respect to properly documenting the expected
usage of cache flushing before modifying the pmd.  However, in practice
this is not a problem due to the fact that DAX is not available on
architectures with virtually indexed caches per:

  commit d92576f1167c ("dax: does not work correctly with virtual aliasing caches")

Fixes: f729c8c9b24f ("dax: wrprotect pmd_t in dax_mapping_entry_mkclean")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
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

