Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB12537601
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiE3Hwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiE3HwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:52:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267562CDD5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:51:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x143so9887769pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1uSXYTb359GYZYUL38E0tsCvHSowrqKxSPkaS7BCw0=;
        b=Z+vIgsb9cnaEHIul2toSXUm6rrCc47T9Tan81WiyTc8fO5XEV8I1D0ZFf2vl7MhWLH
         kLBQa8mUAWBL97TrBJ4ySat0p7EVMxZ9DfvEJgOWcsN9kO+4aSfWwa6W1telCGw6aHwN
         3CiTzRdDD3omXqegxcAje7SfZfyHu57wPelMG9sAHBaqD980yvgFNENio5LLl8JPnXRH
         N1LgGOA1LxRBixOD66Ngx0ua5As3E1N3oOgQlrtXJlCbziPvms/69m7Usnjz8Gt5hwDO
         U6mY4k2NR0vVq1xWJaoddNfTFC37xhE8DosrvuxlbyNp2gAbhMr3NkLJlYCrIoKN/fnB
         TAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1uSXYTb359GYZYUL38E0tsCvHSowrqKxSPkaS7BCw0=;
        b=b9vWU0KN5afkydXYyelJBH8rNabYqiwa9YRU2TQFvQksyHKoNTSTuZCMGCKDzO71By
         cfK/ofbkym/S1FtbOhi51Y+YeZNDvdAvG7+i8pYCJ1kycUWjOnN3Y9N63h71U9Au2afh
         JqBN2C3L5k9MIVYttgecDzE1Sd36nkpSYZ75DLJUzwfKP1jbq1a2q5UIYsfPz9CRC5CP
         kp6kM23SVgCwlKflMprO7HggJqxu9N3WiJonw7iABTmFUjjynE1IdvNG76ujLVaBQwXE
         jRuMqVvQnDVRtSG+LcP/GTZOitRu3exFZprOHMftiqItcLujlWhTU16VoEPluRIBarBk
         R0EQ==
X-Gm-Message-State: AOAM531k6uhLDYPcVvleXqcmF1Lq5zkMpKc3Vw9Ur5SO8Iul8mSf+SCF
        umMVjfFpMKpkjhTZqwx6M95zdg==
X-Google-Smtp-Source: ABdhPJxGV5AoXKcyeUU8ZBJd7zKVAHC0obAgkRJffyrhrae0ETdWG8nqs7sScPBo5ThCSl6Lwkx+yg==
X-Received: by 2002:a62:e90e:0:b0:51b:3f85:c97c with SMTP id j14-20020a62e90e000000b0051b3f85c97cmr6834623pfh.86.1653897104942;
        Mon, 30 May 2022 00:51:44 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([2408:8207:18da:2310:2071:e13a:8aa:cacf])
        by smtp.gmail.com with ESMTPSA id a23-20020a170902b59700b001616c3bd5c2sm8421381pls.162.2022.05.30.00.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 00:51:44 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 10/11] mm: lru: add VM_BUG_ON_FOLIO to lru maintenance function
Date:   Mon, 30 May 2022 15:49:18 +0800
Message-Id: <20220530074919.46352-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220530074919.46352-1-songmuchun@bytedance.com>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
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
---
 include/linux/mm_inline.h | 6 ++++++
 mm/vmscan.c               | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index ac32125745ab..e13e56c7fdbd 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -97,6 +97,8 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru = folio_lru_list(folio);
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+
 	update_lru_size(lruvec, lru, folio_zonenum(folio),
 			folio_nr_pages(folio));
 	if (lru != LRU_UNEVICTABLE)
@@ -114,6 +116,8 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru = folio_lru_list(folio);
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+
 	update_lru_size(lruvec, lru, folio_zonenum(folio),
 			folio_nr_pages(folio));
 	/* This is not expected to be used on LRU_UNEVICTABLE */
@@ -131,6 +135,8 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru = folio_lru_list(folio);
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+
 	if (lru != LRU_UNEVICTABLE)
 		list_del(&folio->lru);
 	update_lru_size(lruvec, lru, folio_zonenum(folio),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 67f1462b150d..51853d6df7b4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2277,7 +2277,6 @@ static unsigned int move_pages_to_lru(struct list_head *list)
 			continue;
 		}
 
-		VM_BUG_ON_PAGE(!folio_matches_lruvec(folio, lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
-- 
2.11.0

