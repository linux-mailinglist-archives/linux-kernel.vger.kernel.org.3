Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBEA4C9F3C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbiCBIaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240136AbiCBIaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:30:23 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF77B8B43
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:29:38 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso793698pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/myAdjexodhPdxGEM0MHuk2V1UzL2hIaRiiu46o6gA=;
        b=5wCqMdPra7WU6QtB0HKKqpqInbC0mjKYJvNn1TUItnMFQQUxMLnPC8gOImTQQjrUJ6
         lxZPmTjDu1L0Q72qlAPkPaRlENO07rpX9UYXO0FAF59aYEtozl+ZKAWQZ8W3qqRE+ikr
         SlRgQWIHHhcTtdgRhGo4D22XRHAZBBeblqRndIow0K+xwrQOm5CHH/9Z9ixzQe6h7kFE
         zNljQhcoRBU9180TzWuXPS9NCuP82R0Fe0PKzpYQqkyaXnxFW5Nt5cxWBJuTk3L4oHxt
         KISVkpNb+bLAdydzsYyxsQZ+ibl5wXiET/Dx7dQOH8lcVFxHxuZfrkdIRaRw8w+oE5Al
         xSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/myAdjexodhPdxGEM0MHuk2V1UzL2hIaRiiu46o6gA=;
        b=UUp81c4a94j0+vRA5RhX5pE1U2YNe17aGWoYYOKhMlXM6If1pwS42CzkAbVrVy20ED
         vvzlUQbQlNzh+iIUIW4X6htQIqASqGv1vD86FMIxD+j17fBkwa5pLYt9Jp2ecRe4QsZq
         +H6S2m4ZRv+EaX9pdRwHtUduPkpHqe6c25j8yXHMJHWb8o/+0ss8ws/aYdPBxzPBtB6j
         VADcANCxR8XesgQ48MIBoiCYfQB6GctZk4lZH+TIG4NfOAlgaNHgs0oYWDwnsmuadyp8
         aeGRmUyhNvPB6rkVQjK/7QGvIwC3SuJBKRwIYbWykfMlwHm36LeXjuYrVvUh7G+QMhV7
         bsqA==
X-Gm-Message-State: AOAM530mBhZlwjCM1YNTJewMMnio30XJw29RMPA8CdSiRT3eINl3xgK9
        iQb+Zcjy4uw/U89j5kZ2GvJejw==
X-Google-Smtp-Source: ABdhPJzT8ObZdk6+fbYovMIjQEfRPZciRdCbVZminjRSbL7HjS0V45URjs58A3iPwR4mLPclCDR1PA==
X-Received: by 2002:a17:902:e549:b0:150:2412:c94c with SMTP id n9-20020a170902e54900b001502412c94cmr26221501plf.94.1646209777959;
        Wed, 02 Mar 2022 00:29:37 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a000c9400b004f396b965a9sm20922228pfv.49.2022.03.02.00.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:29:37 -0800 (PST)
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
Subject: [PATCH v4 4/6] mm: pvmw: add support for walking devmap pages
Date:   Wed,  2 Mar 2022 16:27:16 +0800
Message-Id: <20220302082718.32268-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220302082718.32268-1-songmuchun@bytedance.com>
References: <20220302082718.32268-1-songmuchun@bytedance.com>
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

The devmap pages can not use page_vma_mapped_walk() to check if a huge
devmap page is mapped into a vma.  Add support for walking huge devmap
pages so that DAX can use it in the next patch.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/page_vma_mapped.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 1187f9c1ec5b..f9ffa84adf4d 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -210,10 +210,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = READ_ONCE(*pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
+		if (pmd_trans_huge(pmde) || pmd_devmap(pmde) ||
+		    is_pmd_migration_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
-			if (likely(pmd_trans_huge(pmde))) {
+			if (likely(pmd_trans_huge(pmde) || pmd_devmap(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
 					return not_found(pvmw);
 				if (!check_pmd(pmd_pfn(pmde), pvmw))
-- 
2.11.0

