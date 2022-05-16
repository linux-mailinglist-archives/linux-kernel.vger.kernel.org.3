Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F145281E5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242581AbiEPKXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242559AbiEPKXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:23:18 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891AAE085
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:23:08 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id x12so13659136pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1HA7mTkokdfUBOTOx/UT/zRHvpwkRZMgaF2tqkC7Lc=;
        b=I0/JeIClQwBorAMPSgPnbRPgkEOQC7Mr3Pms0T10DCu0fw6VhfTLuxj7jOtLphdp95
         2qMARSAiX5pBAbL4qdkFvFE3g3Mx2OLrOD61gNNw6loxErIQzZWg3y9F4UGd6h2GccgH
         BmINNSNVBA9veX8ta2i94KfzCly2VD/huBZRwQEtAveOHwDk4R3SeBoO2NUUarW9PqKG
         EEf5fPmZDyWYHJBD4VCbMznNow+dRJL5kc9OAiFvqAIbycA0Tf2lPHNw0UPuCPu0GVmJ
         zX33ayCnncNEV7Zu+mW3ITLLR9kOnBrXxJNprV2Oqql25YtAlOAzqgZqziQwIrhRKC3s
         Ke7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1HA7mTkokdfUBOTOx/UT/zRHvpwkRZMgaF2tqkC7Lc=;
        b=uwDU4IhcYAZU83x4xkG3AQKjIlSXLDT8cGJBk79rF0FfA93OzL5A5sFy2PpyXPeQc4
         tIHCb8EiH5+pAKBvOB9XUP/hfYi63c2Z6X+rXD2wDc1MpPOuTuovo2UsvMsb7apWjvbp
         3OLi/r0CffkYmBORhfmSLG+HiFShOrCPb4Kf8mXbIcfD/2j0COG5QefVO4rg2LivNz/3
         NJjM9PWE19V8RnR7D9Qlta4PG97/DgNFTUtR5AkuJBR/P+7HzQIQNqEYUIwdsmpR37KI
         9xS13S04/ExQzGvDEghy1vjVYOewED65lknMunNCgap84rS/RkSXP9rK4Yn4AuUPfHC2
         uXcA==
X-Gm-Message-State: AOAM532iGQRJR+zL6GggHvV96V9SPi9CFry8/wbQZru+mRP3bStewog/
        21qMiN+9xwyLD6KI9GT+dxJGJA==
X-Google-Smtp-Source: ABdhPJx+le9SIrFuAU5RA8TqPnUWh9duy4U2Dkz5aeGmIOp6I4BVYjVIVE/iqBYV3UcV8r9rt34QsA==
X-Received: by 2002:a05:6a00:1492:b0:50e:11ae:f62f with SMTP id v18-20020a056a00149200b0050e11aef62fmr17044341pfu.43.1652696588092;
        Mon, 16 May 2022 03:23:08 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id i9-20020aa79089000000b0050dc76281e4sm6472731pfa.190.2022.05.16.03.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 03:23:07 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v12 1/7] mm: hugetlb_vmemmap: disable hugetlb_optimize_vmemmap when struct page crosses page boundaries
Date:   Mon, 16 May 2022 18:22:05 +0800
Message-Id: <20220516102211.41557-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220516102211.41557-1-songmuchun@bytedance.com>
References: <20220516102211.41557-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the size of "struct page" is not the power of two but with the feature
of minimizing overhead of struct page associated with each HugeTLB is
enabled, then the vmemmap pages of HugeTLB will be corrupted after
remapping (panic is about to happen in theory).  But this only exists when
!CONFIG_MEMCG && !CONFIG_SLUB on x86_64.  However, it is not a conventional
configuration nowadays.  So it is not a real word issue, just the result
of a code review.

But we cannot prevent anyone from configuring that combined configure.
This hugetlb_optimize_vmemmap should be disable in this case to fix this
issue.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb_vmemmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 29554c6ef2ae..6254bb2d4ae5 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -28,12 +28,6 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 
 static int __init hugetlb_vmemmap_early_param(char *buf)
 {
-	/* We cannot optimize if a "struct page" crosses page boundaries. */
-	if (!is_power_of_2(sizeof(struct page))) {
-		pr_warn("cannot free vmemmap pages because \"struct page\" crosses page boundaries\n");
-		return 0;
-	}
-
 	if (!buf)
 		return -EINVAL;
 
@@ -119,6 +113,12 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	if (!hugetlb_optimize_vmemmap_enabled())
 		return;
 
+	if (!is_power_of_2(sizeof(struct page))) {
+		pr_warn_once("cannot optimize vmemmap pages because \"struct page\" crosses page boundaries\n");
+		static_branch_disable(&hugetlb_optimize_vmemmap_key);
+		return;
+	}
+
 	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
 	/*
 	 * The head page is not to be freed to buddy allocator, the other tail
-- 
2.11.0

