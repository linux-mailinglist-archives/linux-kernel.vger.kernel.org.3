Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452DA520130
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbiEIPib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238435AbiEIPi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:38:29 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8780D236773
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:34:35 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q4so11305355plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 08:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DE1jmNjs85V5CTa5WQUk35TCdHBAzNHaFi6DV+lnzC8=;
        b=kuUed4ZDtei1sNHuLqnP2mbZbAQhfBoTdrhujD92pkb0wYj2OL/SkTq1zv1rBtNVTw
         uqGNSSDpIOFBO3AuPkHYieUnhJNi60k1aUAX4NM6ayj/W+3F7q3H+8kPsNbJrvWkpqOT
         AII1JLFRr1fZSZa1aq4hAxEXhHI1VI7nAoxGMEWdffCccp5GDKEZa3vA9vlU+bjqDlpV
         k3+8exwx7C2CpDs55FlCG2qEfo+pc1iNRpLIO4BxK0yCAQA166p4TPWUlZW2+lBzD7KK
         xHt1+7lKHrIRZyrYY54C24s+yIrr0DLl6XV7P5m7ZUAP+Afr62xju6q6I2k+5zPTZ+Zq
         ZeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=DE1jmNjs85V5CTa5WQUk35TCdHBAzNHaFi6DV+lnzC8=;
        b=PfkkadX0bJb3NkLmg+LOCl8Gl1nS87fssiM+mXi/QKWtsa0tMKlIg0MMi9uaNP5qjJ
         +PzFZP9ZgYwHD1ZtutA8WSQXSOUZfWauqLb4pLut8BuGg0AYi/iYVgVUi2yRXzeXsFAn
         nidZTBNHuH7xEKTbL1LlWMUeIVyK3SnPhXQd+RUptSgnT3JXQixnM4lQQIuCjfDOUXn2
         3mYgDv89SKUsmB6a7DkUlq/PQcos6N7LXgWEZEjssugzfu2AxTH3S4iWW0OihHcMjPBD
         bQVouudtHrzFLPTxpPj+dn1ks6Zu7inWRIIa2AkQAe3zrjxTyvC2qesgs598sG3M+Q+J
         yrYg==
X-Gm-Message-State: AOAM532BV4GP8/RUBdq4S1U6ONEERrHoFDP0SRlGNiBDSFuABHh503Bo
        jucbbSXLMxFp4f5aP+3D8iY=
X-Google-Smtp-Source: ABdhPJxpN71sFFNooVDNrb89u73puoo/Wz+fiBc52qR64aQ13OIKDZt8zPKAyDB1tLJnxRMqR2XD3w==
X-Received: by 2002:a17:902:f652:b0:156:701b:9a2a with SMTP id m18-20020a170902f65200b00156701b9a2amr16633471plg.14.1652110474859;
        Mon, 09 May 2022 08:34:34 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:3704:694b:acc0:e064])
        by smtp.gmail.com with ESMTPSA id t14-20020a17090a5d8e00b001cd4989fee6sm12592035pji.50.2022.05.09.08.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:34:34 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v3] mm: fix is_pinnable_page against on cma page
Date:   Mon,  9 May 2022 08:34:30 -0700
Message-Id: <20220509153430.4125710-1-minchan@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages on CMA area could have MIGRATE_ISOLATE as well as MIGRATE_CMA
so current is_pinnable_page could miss CMA pages which has MIGRATE_
ISOLATE. It ends up putting CMA pages longterm pinning possible on
pin_user_pages APIs so CMA allocation fails.

The CMA allocation path protects the migration type change race
using zone->lock but what GUP path need to know is just whether the
page is on CMA area or not rather than exact type. Thus, we don't
need zone->lock but just checks the migratype in either of
(MIGRATE_ISOLATE and MIGRATE_CMA).

Adding the MIGRATE_ISOLATE check in is_pinnable_page could cause
rejecting of pinning the page on MIGRATE_ISOLATE pageblock even
thouth it's neither CMA nor movable zone if the page is temporarily
unmovable. However, the migration failure is general issue, not
only come from MIGRATE_ISOLATE and the MIGRATE_ISOLATE is also
transient state like other temporal refcount holding of pages.

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* from v2 - https://lore.kernel.org/all/20220505064429.2818496-1-minchan@kernel.org/
  * Use __READ_ONCE instead of volatile - akpm

* from v1 - https://lore.kernel.org/all/20220502173558.2510641-1-minchan@kernel.org/
  * fix build warning - lkp
  * fix refetching issue of migration type
  * add side effect on !ZONE_MOVABLE and !MIGRATE_CMA in description - david

 include/linux/mm.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6acca5cecbc5..cbf79eb790e0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1625,8 +1625,19 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 #ifdef CONFIG_MIGRATION
 static inline bool is_pinnable_page(struct page *page)
 {
-	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
-		is_zero_pfn(page_to_pfn(page));
+#ifdef CONFIG_CMA
+	/*
+	 * use volatile to use local variable mt instead of
+	 * refetching mt value.
+	 */
+	int __mt = get_pageblock_migratetype(page);
+	int mt = __READ_ONCE(__mt);
+
+	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
+		return false;
+#endif
+
+	return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));
 }
 #else
 static inline bool is_pinnable_page(struct page *page)
-- 
2.36.0.512.ge40c2bad7a-goog

