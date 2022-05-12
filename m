Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD6D5243EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346225AbiELEMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346049AbiELEMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:12:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA631C12EC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:12:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n8so3770805plh.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODWBdYqZzg8lChYiYiJ2sSIUo4NFfWVrgG6YTxSVP1A=;
        b=Ngz3D77zs/xp/vA5hFw2cdVMSnC9oUL2wHY3z6LuPl03ViyKz1AScEySaj0q61TiCz
         uqU+p3NVdxinAmmFIiVPWACAd+D+OJwT1pvROHz93ukkMBxzYHMMa6HJk/5MSUOc3/q7
         r8xUk0sBKeepaJ9/TLXUsvd1YXF0Jsibof8Jm94zf08p1DtPfr0PQ2WHxpGNFi1S/YtB
         BxbHoPbBz7VPBLD68majR/kPzuxNmP/5/jHY/ak5hJlBKrZCq+ww6hGUEzGSVKkG7zVd
         UBkf5XzMz8oeuQvEO0yB1EP0sLz6A2aB+VfK/cUX/E50kYCTLfk7rnXyoOjuvhBkA9JD
         xvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODWBdYqZzg8lChYiYiJ2sSIUo4NFfWVrgG6YTxSVP1A=;
        b=c5zBfP31zzCDT4kElwvL2Ic78Ym6Du0MK8JHOjCbUHdGTEYWNo2eR0qkkk2yE8c9O7
         Zc8HbuavQkNZRfdKuNV+TSaDKDijBis/DdeoXOLOFaSnPGVOf+CTRXSybOQz2e+lhpQ7
         uvQw19314cPy0UEWRrzzsjDID9/X47YY0bUwiU/pm8+oRuFP4pAQ/srDv+6xW3MiVgk/
         Pl7nBrpc9EPbOF6Lh/Uhk9X+0ODZAGTLVJa3ieFdCtrZ0zLYlta/CGV4Bc6ZApcBZW+0
         INK0EDNlAq1AdU+xCPlf4I2hc79Cy0SsnJHhfySZg9J2Nj43UMOAYYOHVHz1vtf/xcTe
         I/3A==
X-Gm-Message-State: AOAM533bbp44em/XBHOrTTWiHf6rQ6cqoExaIIMEapg68cuXBNiGalI2
        5emFk83NAxDzUKwgjQlWQNuomA==
X-Google-Smtp-Source: ABdhPJwqaLJm3UoDc04JP46WrAIcZihbJfdbwPqN7BfOz3+DV9hE3OQoNbHhMpW+tWmXbzr/1bgWNA==
X-Received: by 2002:a17:90b:4b84:b0:1dc:93c0:ba01 with SMTP id lr4-20020a17090b4b8400b001dc93c0ba01mr8869867pjb.70.1652328735414;
        Wed, 11 May 2022 21:12:15 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902edcd00b0015e8d4eb2dcsm2695161plk.294.2022.05.11.21.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 21:12:15 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v11 1/4] mm: hugetlb_vmemmap: disable hugetlb_optimize_vmemmap when struct page crosses page boundaries
Date:   Thu, 12 May 2022 12:11:39 +0800
Message-Id: <20220512041142.39501-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220512041142.39501-1-songmuchun@bytedance.com>
References: <20220512041142.39501-1-songmuchun@bytedance.com>
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

