Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC105993C8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 05:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345742AbiHSD4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 23:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiHSD4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:56:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F318D6B8B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:56:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso3704737pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=lsYH3OgGm+oHq1p9PQ/FH9m10DPJDbLS51J0/xysfI4=;
        b=xyWUxCnCtiRVks8bx4WTVcTP79R4XwxodGozr2BfuWMYL2wMiy9QNiUXrDQBOtYoHZ
         G6rhUiXlwXfcFEn82tlDfnoPcHgyk8tYiRnfcdNTkE9hb2pOUfkLy739UAWc4Ybzq1IP
         t4z1nTW/72bSvA9ufhs4aCHBc7FrSBrqLzACp6Uwph6Sk7cp5bJXw6yO6tXVZU8xD1vs
         S/TgEWWQUTLT9J9JG7BguW90TplbaneAfs5Qsj74KZsBEsEptyZ3ycslrBMJhbxpttN9
         TgXC/OKQQzEML4fThs4yLu8lULhwr7HztYj9An9076t+IwP/f4sKT/eeXlo+J3D+J3Id
         32+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=lsYH3OgGm+oHq1p9PQ/FH9m10DPJDbLS51J0/xysfI4=;
        b=TqYAKvRpNEi5xZlixEqINsYoJOyc/Mc7RYwAaVWx6AVgOrWe/1ZmMLY1YcjFCHVW+f
         Y/MbzftlhU/hLMhLwyn+c7BEnsHsS37f4WXrGR2yQZPEpLETKIiHb83vjZ1XKECAle+u
         oMqDRvBG0BhiIyUzmU8YV9iGV/Ems9V19hJnOoaxTjZeSQ1KIDEbB7olzlYb63F3XSiw
         PIjfFGU7xpypiN413MQ8DmoZZhkv0YR/WpSx74P9fdwVg/rfx6trGCy+8/tuGwjYzfba
         otSQZD82c1Xz8vdhq0oTJzrrys8VnC+FMmtQGJ3N0UmfHBvC7ILQF8g0A6hY3uofdNH2
         Srgw==
X-Gm-Message-State: ACgBeo00jfn2cjGxYfrBWSkHjM1dL76zalLJjwp6IGqVvLNhUa4wdNq8
        scT64prOFmk4h14h/1B8H6qxatc0iOH+QaK7
X-Google-Smtp-Source: AA6agR4krcZ/z93g7PMR3mck31vUbIjZaXp5iOunh1k+/Ram3cJcq8i0hwITMlmHMSQ5BcoAUilh9w==
X-Received: by 2002:a17:902:f688:b0:16f:4b4:fc18 with SMTP id l8-20020a170902f68800b0016f04b4fc18mr5531691plg.49.1660881371716;
        Thu, 18 Aug 2022 20:56:11 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id w27-20020aa79a1b000000b00525442ac579sm2391456pfj.212.2022.08.18.20.56.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Aug 2022 20:56:11 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        muchun.song@linux.dev
Subject: [PATCH] mm: hugetlb_vmemmap: simplify reset_struct_pages()
Date:   Fri, 19 Aug 2022 11:55:32 +0800
Message-Id: <20220819035532.6189-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
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

We can choose to copy three contiguous tail pages' content to the first three pages
instead of copying one by one to simplify the code and reduce code size from 229 bytes
to 63 bytes. The BUILD_BUG_ON() aims to avoid out-of-bounds accesses.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 76b2d03a0d8d..ba2a2596fb4e 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -265,11 +265,10 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 
 static inline void reset_struct_pages(struct page *start)
 {
-	int i;
 	struct page *from = start + NR_RESET_STRUCT_PAGE;
 
-	for (i = 0; i < NR_RESET_STRUCT_PAGE; i++)
-		memcpy(start + i, from, sizeof(*from));
+	BUILD_BUG_ON(NR_RESET_STRUCT_PAGE * 2 > PAGE_SIZE / sizeof(struct page));
+	memcpy(start, from, sizeof(*from) * NR_RESET_STRUCT_PAGE);
 }
 
 static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
-- 
2.11.0

