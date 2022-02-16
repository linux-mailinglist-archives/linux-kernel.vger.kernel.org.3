Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239C24B872A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiBPLxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:53:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiBPLxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:53:24 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D848F2599E7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:53:08 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w20so1804436plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hb4Gc01XylgUCngtxENOJFpbWICvKI3FBnXtbBe6mQw=;
        b=Hv/yV6E/bbCMqR7MM5iHb7bJyd4OPBm0sjIJ3Agnh7p/RUA72ZSwnSAYh6ui3TwcUb
         FyU50MF38ZlbkCpNny0kgYoGRV0KOuhYait9vzWyUZr7CRuPa6MgqauOfkcV7/tYZ0pU
         KL39IVOcG7nWuUyj2AXQjciC6hGq/Opoy8kqlQQQNGut9FKkUhMITh7zSDosRc3yLOsu
         klrE8gpCZ6vATDgd6TC+mpJgnN+XJ/HXQzrOknh73rDR5fVyse2le763zkJXHp599GVG
         gmy4vKNyMGXp4GqgaslCshQs1MFD3lOHii364ySCYulCbkvKHu7EzK86WBprQsgNKyhD
         7u2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hb4Gc01XylgUCngtxENOJFpbWICvKI3FBnXtbBe6mQw=;
        b=YwA24lRntTc/NPWwlYYjBqIVkhm1ntPpDx7b61Uq3D0cVuIIG9OLWWPsPDdtBjjREi
         V3Rj/8r5kipKJ5NM6J00PWJMrGCwR7/7qRl2DGwBEoP4DLZNXd+DNVKSJ9Tr8MQO+uz0
         OUK6ArmGEv5PYveTqa6OiB95AuIptLWlKAvPBuV6Mnrm50J5Fu+3Ze97F5B14JB/4TI2
         fRimWDBMLiNA8pQgqt0xJMbk0/JM6w7IQfl8ayJc72XpQFwYKJxJg9zF81344Qx+bJxm
         JuzUXFRZj1inq6DGttnx+9PXCp/IyY4GcVUnREA/iTvXPJeAyfQE68IxJJIiqDrcNwuC
         MFoQ==
X-Gm-Message-State: AOAM531nKL+oX49hoapf40hxqGa2qAJSkT5glYVi2MQDlbyjKW+F96G0
        5jOjtgWbaz7zSIK35XE+oTSiTg==
X-Google-Smtp-Source: ABdhPJyXZS3mMwShvFS3X7uagm3iGHbU4H2oEm2bloQpabZs8Juq19OdY6sNgEvStD7wOLFso2+Zdg==
X-Received: by 2002:a17:90b:3607:b0:1b8:efe5:9008 with SMTP id ml7-20020a17090b360700b001b8efe59008mr1272889pjb.163.1645012388467;
        Wed, 16 Feb 2022 03:53:08 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id m16sm14790221pfc.156.2022.02.16.03.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:53:08 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 11/12] mm: lru: add VM_BUG_ON_FOLIO to lru maintenance function
Date:   Wed, 16 Feb 2022 19:51:31 +0800
Message-Id: <20220216115132.52602-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220216115132.52602-1-songmuchun@bytedance.com>
References: <20220216115132.52602-1-songmuchun@bytedance.com>
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

We need to make sure that the page is deleted from or added to the
correct lruvec list. So add a VM_BUG_ON_FOLIO() to catch invalid
users.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm_inline.h | 15 ++++++++++++---
 mm/vmscan.c               |  1 -
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index b725839dfe71..8cc134fd3f0b 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -105,7 +105,10 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 static __always_inline void add_page_to_lru_list(struct page *page,
 				struct lruvec *lruvec)
 {
-	lruvec_add_folio(lruvec, page_folio(page));
+	struct folio *folio = page_folio(page);
+
+	VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+	lruvec_add_folio(lruvec, folio);
 }
 
 static __always_inline
@@ -121,7 +124,10 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
 static __always_inline void add_page_to_lru_list_tail(struct page *page,
 				struct lruvec *lruvec)
 {
-	lruvec_add_folio_tail(lruvec, page_folio(page));
+	struct folio *folio = page_folio(page);
+
+	VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+	lruvec_add_folio_tail(lruvec, folio);
 }
 
 static __always_inline
@@ -135,7 +141,10 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 static __always_inline void del_page_from_lru_list(struct page *page,
 				struct lruvec *lruvec)
 {
-	lruvec_del_folio(lruvec, page_folio(page));
+	struct folio *folio = page_folio(page);
+
+	VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+	lruvec_del_folio(lruvec, folio);
 }
 
 #ifdef CONFIG_ANON_VMA_NAME
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7beed9041e0a..00207553c419 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2356,7 +2356,6 @@ static unsigned int move_pages_to_lru(struct list_head *list)
 			continue;
 		}
 
-		VM_BUG_ON_PAGE(!folio_matches_lruvec(folio, lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
-- 
2.11.0

