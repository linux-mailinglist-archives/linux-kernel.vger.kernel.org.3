Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8336B558BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiFWXxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiFWXwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:52:54 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E18360C5D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:50 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p14so1046258pfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pQfND038h5QWcn78qM/I1ai1qmbxoygS2JmZLRC1mQ=;
        b=iXRbqsMPfof+NUltQHH89pGwAzb42H/dstNMxQgGGt6Yt//W8LgTGOTG0OaoSTeNRz
         dZWUB59vT4SDDN3iALIsxg16784gK20+rZPhBd+mZNDSqMB9O7U2WxsqjohKmBB6pXUG
         nibweuhhc5VKaNupCNP0N0YPwZxrsIyX/Bb9vW1e68rAyv5FmPBsYHd9kQFfKyW1Ez5f
         w5un26afpOlcnOq5acBDDRhfwfXCkdcFPIehGQOKnQhnUuw02P3Yd7V2Oqo0X9yKyjgn
         RWPTgZnrtjJ7VlJaB/hzIuIdKb1hqY3+8AgAQyB9hZ3NMamUhCbmytLPWpfDRAdW+V2/
         eftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5pQfND038h5QWcn78qM/I1ai1qmbxoygS2JmZLRC1mQ=;
        b=4EYLeTeKHX/bMD540LzGlXEce64YbqkipMphbczigDOH9F/OMTR/iYdsR2sdu/6tfJ
         RFd9VWkXjUhR1vtQkEvIJJbdCHYPgu+mZvysBpnFn9dCbyaJuoTo9NS/ata5TfPNoMW/
         CFxZTn+A7BQoyy3aLL2rfsXX+WwYv9Uozp+QzSAoMEsXvPRlmBZJBrXhI9eSFp7geoSH
         yOluR7paWeZ/KgQOkIdCKjRjy0z/61m7vWL7/wsKzhCshBZbQ0QMe3Kve0FjMdPapnIE
         T8/UDWbkFfCJrgOHNvMA2S5ElDJva/U61/gibWJNho6lbHZRybopPdfqtW52uVztju2q
         zwZA==
X-Gm-Message-State: AJIora9HVy/1vaCLTdcbAZin1JnFzcngNK8ZkHzVU5sdABqkLtLKMQLE
        pPIyrMF4Vf1i66wUMI3DIA==
X-Google-Smtp-Source: AGRyM1s96G2FFH66JXa8bc7eH4qd+fIDxeMhCkK8flgwP1JhK2XMzt6hxEJTmkotzQNPWlNmHQYnig==
X-Received: by 2002:a63:7b5c:0:b0:40d:684:b760 with SMTP id k28-20020a637b5c000000b0040d0684b760mr9535270pgn.323.1656028369640;
        Thu, 23 Jun 2022 16:52:49 -0700 (PDT)
Received: from ik1-406-35019.vs.sakura.ne.jp (ik1-406-35019.vs.sakura.ne.jp. [153.127.16.23])
        by smtp.gmail.com with ESMTPSA id r10-20020a170903020a00b00168eab11f67sm362571plh.94.2022.06.23.16.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:52:49 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
X-Google-Original-From: Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] mm, hwpoison: make __page_handle_poison returns int
Date:   Fri, 24 Jun 2022 08:51:51 +0900
Message-Id: <20220623235153.2623702-8-naoya.horiguchi@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

__page_handle_poison() returns bool that shows whether
take_page_off_buddy() has passed or not now.  But we will want to
distinguish another case of "dissolve has passed but taking off failed"
by its return value. So change the type of the return value.
No functional change.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ce045d0d6115..db85f644a1e3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -71,7 +71,13 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
 static bool hw_memory_failure __read_mostly = false;
 
-static bool __page_handle_poison(struct page *page)
+/*
+ * Return values:
+ *   1:   the page is dissolved (if needed) and taken off from buddy,
+ *   0:   the page is dissolved (if needed) and not taken off from buddy,
+ *   < 0: failed to dissolve.
+ */
+static int __page_handle_poison(struct page *page)
 {
 	int ret;
 
@@ -81,7 +87,7 @@ static bool __page_handle_poison(struct page *page)
 		ret = take_page_off_buddy(page);
 	zone_pcp_enable(page_zone(page));
 
-	return ret > 0;
+	return ret;
 }
 
 static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
@@ -91,7 +97,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
 		 * Doing this check for free pages is also fine since dissolve_free_huge_page
 		 * returns 0 for non-hugetlb pages as well.
 		 */
-		if (!__page_handle_poison(page))
+		if (__page_handle_poison(page) <= 0)
 			/*
 			 * We could fail to take off the target page from buddy
 			 * for example due to racy page allocation, but that's
@@ -1048,7 +1054,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 		 * subpages.
 		 */
 		put_page(hpage);
-		if (__page_handle_poison(p)) {
+		if (__page_handle_poison(p) > 0) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
 		}
@@ -1698,8 +1704,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	 */
 	if (res == 0) {
 		unlock_page(head);
-		res = MF_FAILED;
-		if (__page_handle_poison(p)) {
+		if (__page_handle_poison(p) > 0) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
 		}
-- 
2.25.1

