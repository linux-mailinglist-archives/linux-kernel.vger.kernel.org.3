Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE07525402
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357244AbiELRqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357226AbiELRp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:45:57 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A770A11C37
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:45:55 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id bo5so5470264pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MKSf812TTE05BrANtImubNsPtr0MvP/NAKhjTot4IJA=;
        b=T4klzcOxo/2MGKJlZI20mz46CAW/dJSi8WpnD+JfxxXVw2Sm2479kH38VRnPx71CMV
         CbtFS6KSZ13DX7jsgSAVeCts3SAsIPlfPU3hIjWKllG3bpSrTLr2lsAsjO8uMTGlm2wk
         1ZZZFjDxCGeLr4dimsllA/e8y3AoDx9zxFGS84Hj7M9j6TNHfetyNVfpZVC3dGsc9EtT
         Fb8kD8irhbZBbuJKx7Y2pwA9Z6xEDRA4jdtGEvcQnnhaOQ8JjDxXBcFk1dO76iOhYk1o
         XDHyC/GJpI6PbXOi3/jwogaI96tQF7ZA/o2cuxToERseGQIxosM7Mf2VsVipk6ZuLCPV
         IOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MKSf812TTE05BrANtImubNsPtr0MvP/NAKhjTot4IJA=;
        b=VFn8ShvbrFHkFsBfChYD0n3CGS+ZchNMugl/XCvv41I5Ip9wjvRTl3Vp31l3C/Ydm9
         o4HGXDAXECVCY0WqiUHrDq35ka8XZcZXZdOJgxpjzVd6eRrl3DyPCqOKhsLOI/4/uMI6
         0AXlTRSbfLJ8gFF59+DqKWoYJOFM1/u4zrGBqZZX2lHawcMmp5PfrarKQ9Gut3b5Q6sb
         qKnAUNZ28l3IwaN2B/X2h1bKqzR4P1cwgM6+afXo3dcgAz2uA0359gyl+MTxW/Ed+QNp
         M/vcDPr4TCgTLsXGuTo3y1y7ceFXfEvCkGPtGTHgiWMztJSS1boTHejZWajupcunUZsj
         EsXA==
X-Gm-Message-State: AOAM530Fec6z6vO0szHv6S5xewNzx4PQ3iGJ0yMcKP0YpMJlz4khzs+d
        0buSrUxBqPp6qzSRapG0I7s=
X-Google-Smtp-Source: ABdhPJyaxS+JpibF6XGuB3QzwL/WbWlsDrwN5hk4B2HsNo04GTLu6GafE4I8Hu+zLZoU6aKdMDT3bw==
X-Received: by 2002:a63:5746:0:b0:3c2:363b:a88d with SMTP id h6-20020a635746000000b003c2363ba88dmr605892pgm.17.1652377555198;
        Thu, 12 May 2022 10:45:55 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id f123-20020a62db81000000b00512d84548c7sm121950pfg.53.2022.05.12.10.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 10:45:54 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     willy@infradead.org, songmuchun@bytedance.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: pvmw: check possible huge PMD map by transhuge_vma_suitable()
Date:   Thu, 12 May 2022 10:45:51 -0700
Message-Id: <20220512174551.81279-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220512174551.81279-1-shy828301@gmail.com>
References: <20220512174551.81279-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IIUC PVMW checks if the vma is possibly huge PMD mapped by
transparent_hugepage_active() and "pvmw->nr_pages >= HPAGE_PMD_NR".

Actually pvmw->nr_pages is returned by compound_nr() or
folio_nr_pages(), so the page should be THP as long as "pvmw->nr_pages
>= HPAGE_PMD_NR".  And it is guaranteed THP is allocated for valid VMA
in the first place.  But it may be not PMD mapped if the VMA is file
VMA and it is not properly aligned.  The transhuge_vma_suitable()
is used to do such check, so replace transparent_hugepage_active() to
it, which is too heavy and overkilling.

Fixes: 2aff7a4755be ("mm: Convert page_vma_mapped_walk to work on PFNs")
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/page_vma_mapped.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index c10f839fc410..2634565be175 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -237,13 +237,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			spin_unlock(pvmw->ptl);
 			pvmw->ptl = NULL;
 		} else if (!pmd_present(pmde)) {
+			unsigned long haddr = pvmw->address & HPAGE_PMD_MASK;
 			/*
 			 * If PVMW_SYNC, take and drop THP pmd lock so that we
 			 * cannot return prematurely, while zap_huge_pmd() has
 			 * cleared *pmd but not decremented compound_mapcount().
 			 */
 			if ((pvmw->flags & PVMW_SYNC) &&
-			    transparent_hugepage_active(vma) &&
+			    transhuge_vma_suitable(vma, haddr) &&
 			    (pvmw->nr_pages >= HPAGE_PMD_NR)) {
 				spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
 
-- 
2.26.3

