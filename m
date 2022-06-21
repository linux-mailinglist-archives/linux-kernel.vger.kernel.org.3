Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523F75532B6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351121AbiFUM7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351135AbiFUM6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:58:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7136D300
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:58:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i64so13030649pfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=shtH7PIMf3J8dcya3xtagcl4W8V8R+/sKr+kfrLIY6Y=;
        b=pKDiUQIgj4YaZxnL6yCeczDMoqlNkY/fF9chdQFzHfGrTICA/YrcbElxeDDgKm++4f
         6Cxu565+659Mbpd+/mE7x+gUVXxoISE/HC0AN/7bQGI7T2zC2G+4yGW6GKGsgGLiNSbf
         y7UEpRzdy/p0Tq93+aIN9Ik2CU7UNoB3XcKtE1bfePMgY7rTkTwwqscPFdMO3RNmhIfY
         9QxdQEr3AcmrE33LiJxuDqt+aW0wit9ADGaAiEt4Kw2pPCT1u6q7cr38r7hY7aybgITy
         DvosnAH5V/sCJGZMM25qDYSkhP3+ATsBrPLgsuH6JxtYlZNQUeAcXTsUPlnNGDexLJCF
         QdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=shtH7PIMf3J8dcya3xtagcl4W8V8R+/sKr+kfrLIY6Y=;
        b=zfUpzKThLnsDsgO1wy2a1KN3h87RW3WRG+6sYPSajgvSgZxS35lxPikVA0Eh1V9Gd0
         EvXJBN3BVnib/WjZtlfQrHTv2eUlw3rfsaISdwIRisVhWIr/ru1etx2+rGbExTA4vTGR
         KpXs3yJYPLFzLY8PieUhK/34E343QEynWD/byl13/oR5syOFyQht/T1AikJEmFoZ0HPY
         V6YvacVSt2CnFytjBwSvPSbsL4JjgvYQdgHyr8gfOPcN7KXHLWNDZ/pemRJ6045VUm0T
         IPLeucwJF2x0hA6lYV0oMYdWKkT4c7YWRol4AUCHlCC0ChWzJ/Er3JK4HDZBvKE/lU0i
         j4Iw==
X-Gm-Message-State: AJIora9K9ltdAtvP9tNMc/xov4Kb6/I61cNPYOSrsI8O0UvLPIBhGFBi
        JI5CimH0g4U84go8H8iaL/PIOw==
X-Google-Smtp-Source: AGRyM1u8ksQyZcIYOxcN0FytSUT2CO9PHE09w2KWxt2Sj0ZFsOL55NgBQbL9f4jw1sdjQKIB9ybP3Q==
X-Received: by 2002:a05:6a00:430e:b0:525:26c1:973e with SMTP id cb14-20020a056a00430e00b0052526c1973emr9219577pfb.52.1655816311195;
        Tue, 21 Jun 2022 05:58:31 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id e3-20020a170903240300b0015ea3a491a1sm10643134plo.191.2022.06.21.05.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:58:30 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, longman@redhat.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com
Cc:     cgroups@vger.kernel.org, duanxiongchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 10/11] mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance function
Date:   Tue, 21 Jun 2022 20:56:57 +0800
Message-Id: <20220621125658.64935-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220621125658.64935-1-songmuchun@bytedance.com>
References: <20220621125658.64935-1-songmuchun@bytedance.com>
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

We need to make sure that the page is deleted from or added to the
correct lruvec list. So add a VM_WARN_ON_ONCE_FOLIO() to catch
invalid users.  Then the VM_BUG_ON_PAGE() in move_pages_to_lru()
could be removed since add_page_to_lru_list() will check that.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/mm_inline.h | 6 ++++++
 mm/vmscan.c               | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 7b25b53c474a..6585198b19e2 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -99,6 +99,8 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru = folio_lru_list(folio);
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+
 	update_lru_size(lruvec, lru, folio_zonenum(folio),
 			folio_nr_pages(folio));
 	if (lru != LRU_UNEVICTABLE)
@@ -116,6 +118,8 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru = folio_lru_list(folio);
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+
 	update_lru_size(lruvec, lru, folio_zonenum(folio),
 			folio_nr_pages(folio));
 	/* This is not expected to be used on LRU_UNEVICTABLE */
@@ -133,6 +137,8 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru = folio_lru_list(folio);
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+
 	if (lru != LRU_UNEVICTABLE)
 		list_del(&folio->lru);
 	update_lru_size(lruvec, lru, folio_zonenum(folio),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 697656151431..51b1607c81e4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2361,7 +2361,6 @@ static unsigned int move_pages_to_lru(struct list_head *list)
 			continue;
 		}
 
-		VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
 		lruvec_add_folio(lruvec, folio);
 		nr_pages = folio_nr_pages(folio);
 		nr_moved += nr_pages;
-- 
2.11.0

