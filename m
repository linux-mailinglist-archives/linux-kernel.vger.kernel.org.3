Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580BB53233A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbiEXG2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiEXG2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:28:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843BD72209
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:28:29 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t28so7936705pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VRT3nBeIYnWORjFGgUrNJZAuxlpJgLGLO13gTpDFHrE=;
        b=8PujjlnVeI6J13WyXz+kTgVIeMvRKAqjfBM0f1CZmy36ow271MYI1koRfaVOmeJavo
         Bs6vuCtvQeR3d/rfyKlU46F2aCsbDIA1I/fsRTvx6nYln1rHXcV/5W0D3ELxK6f1Ecf0
         CgSkMRA+a6v523xf+ZMs8mZOboyjugRwM4p+rSQQVV96/4eqCmeA4bx9GC2Ea4nfhfLA
         e4J7q7p8Sh/wemkRgQ8iepBIjupiT6ANaVxSGo8at6IjIg7l5+4pQW/g2oACvZBzt5nh
         mrC6iOGQTKu9NVxBoj3Ly9LRXo42V7ul8yyjUhEsvxaGZug3w3wgm7U09e2lU3e4CB9F
         HFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRT3nBeIYnWORjFGgUrNJZAuxlpJgLGLO13gTpDFHrE=;
        b=7mLoP8YRF349bao/KB6/anyiehm2tTkdshIkpE1KY0AcdHX0nsD1acbIv++ZT/LxRc
         39u0zygJsZkmJW+b1XAG4Af6vTIIOZMTMSH/lBsnE6dBIV9mkkg6gBMBhWm67yvXAq4j
         f75+dAZT2BnUA20DCc1ETsiO9/O1gZqvfaUITFyh1ocfswwZ+NAoSx3RCdegYQUD0a/p
         2JGcRvq3aH8/tj5D6AWYNczvY9s0wAUCXZdlSSheYgnYVNC9aMCh5bBiECWGnGtT+5kF
         CokZ2fDeXPGbNe3T0iGbCmBLPUA03ikG2o5mAbhrJnRteWA1pU//AUh+YJJLHZy2++iX
         VT2A==
X-Gm-Message-State: AOAM532+VBdqQDcoGQmL9W5XQbxIElG7v1XR3u7bsdvamFkvlz4nNCF/
        akE9XnvU7z1W3E/qMWr5PffyA523PN6mtQ==
X-Google-Smtp-Source: ABdhPJw8XdwBF18E1nwEdwHGN4aTYH/lcpJm4fHP7nhdxHq1GZkMUFY/EvBUAVaAVU5iz54VOcQBOQ==
X-Received: by 2002:a63:1d65:0:b0:3fa:7e32:8024 with SMTP id d37-20020a631d65000000b003fa7e328024mr5001251pgm.162.1653373709229;
        Mon, 23 May 2022 23:28:29 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([2408:8207:18da:2310:f940:af17:c2f5:8656])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b0016168e90f2dsm6254455plf.219.2022.05.23.23.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 23:28:29 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 10/11] mm: lru: add VM_BUG_ON_FOLIO to lru maintenance function
Date:   Tue, 24 May 2022 14:05:50 +0800
Message-Id: <20220524060551.80037-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220524060551.80037-1-songmuchun@bytedance.com>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
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

We need to make sure that the page is deleted from or added to the
correct lruvec list. So add a VM_BUG_ON_FOLIO() to catch invalid
users.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm_inline.h | 6 ++++++
 mm/vmscan.c               | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index ac32125745ab..30d2393da613 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -97,6 +97,8 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru = folio_lru_list(folio);
 
+	VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+
 	update_lru_size(lruvec, lru, folio_zonenum(folio),
 			folio_nr_pages(folio));
 	if (lru != LRU_UNEVICTABLE)
@@ -114,6 +116,8 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru = folio_lru_list(folio);
 
+	VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+
 	update_lru_size(lruvec, lru, folio_zonenum(folio),
 			folio_nr_pages(folio));
 	/* This is not expected to be used on LRU_UNEVICTABLE */
@@ -131,6 +135,8 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru = folio_lru_list(folio);
 
+	VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+
 	if (lru != LRU_UNEVICTABLE)
 		list_del(&folio->lru);
 	update_lru_size(lruvec, lru, folio_zonenum(folio),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 761d5e0dd78d..6c9e2eafc8f9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2281,7 +2281,6 @@ static unsigned int move_pages_to_lru(struct list_head *list)
 			continue;
 		}
 
-		VM_BUG_ON_PAGE(!folio_matches_lruvec(folio, lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
-- 
2.11.0

