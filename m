Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A2C55D984
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344215AbiF1JZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344257AbiF1JYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:24:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07BD22B03
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:24:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 128so11443052pfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HfUjscIbkwVw1h7ZbqwVjjayoThyClFWWQF+WJosK0o=;
        b=EGLNwsQDxvaVFN8CeCrbJ+70RIMc1tVatGf97UIdEN2EjTlJem9LBckUcEMvfqNlNn
         QGlqj+u8qVtZY5bvtBdftuNbfM+nkNAiZ+z63aQLD1IPYmC7kZjnEx6Y96sBnJQTqgfE
         aDqtY2LDm5s0vnLK8DhThwZa+wTWmEeXEARzvdSaqFMJuZOTHDxOpuoomdW+9+Y05jFP
         pDgrstcy/ouAFxG6blugqbvAgAlXSMCogjLDL6nCoX+je4tqT0xKRdBeC3SiiE/52zZO
         sJRGwT+879wpDjsISVao7aJixX0Tq3Aqa7e5AQY/zx/IxtCOaa9vVafDm45setubdPOx
         0MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfUjscIbkwVw1h7ZbqwVjjayoThyClFWWQF+WJosK0o=;
        b=6SmJ1wiEkybeQK3xoHNFnAp1/6ImjirskbsP2Hedf1z9IBdGvwiokj9Yc1Dtxk8NDD
         hzMxv/A1kd+4Xts0/BzTBjzg6iR8X3BAv6QDhifowvoQE/J7UHtoJobAVVQjwttEaGzb
         fucPnaM1PgHqvwjYkXyHdJTSDKmcaVtgrHdJfC1djBxJ261GTHvf/5YQaiV8+H7ULudw
         zqvIm49WMy+y4gVhigriyCaQ6hWi6T6iiKNTF5g6a7CcWw3FfIgirWfvOk2efJztNAI9
         3fa9HfpLsYct1iz1cW494bSFE1jyEJcPbzxM3JreA/m7II2fD6uRo7YSard6YCN4hrgj
         D4mQ==
X-Gm-Message-State: AJIora8xp1cMGN9Wzn17b8JA+/agOfAEAaknz3vbZ7rY2WEQNWdmlXS8
        4Nq3NCHCWPU5qhG6BCYYAGRJA3mMerW+EM9f
X-Google-Smtp-Source: AGRyM1t2iPDeZtckQmi9/trLyiw6ixc7ucyEJw2PH0844IZPGmE/175fmI1VMaPArEBzl2GddFK1xg==
X-Received: by 2002:a63:6a85:0:b0:3fa:722a:fbdc with SMTP id f127-20020a636a85000000b003fa722afbdcmr17032017pgc.174.1656408262357;
        Tue, 28 Jun 2022 02:24:22 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id mm9-20020a17090b358900b001ec729d4f08sm8780463pjb.54.2022.06.28.02.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:24:22 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 8/8] mm: hugetlb_vmemmap: use PTRS_PER_PTE instead of PMD_SIZE / PAGE_SIZE
Date:   Tue, 28 Jun 2022 17:22:35 +0800
Message-Id: <20220628092235.91270-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220628092235.91270-1-songmuchun@bytedance.com>
References: <20220628092235.91270-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already a macro PTRS_PER_PTE to represent the number of page table
entries, just use it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 6bbc445b1a66..65b527e1799c 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -48,7 +48,7 @@ static int __split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 
 	pmd_populate_kernel(&init_mm, &__pmd, pgtable);
 
-	for (i = 0; i < PMD_SIZE / PAGE_SIZE; i++, addr += PAGE_SIZE) {
+	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
 		pte_t entry, *pte;
 		pgprot_t pgprot = PAGE_KERNEL;
 
-- 
2.11.0

