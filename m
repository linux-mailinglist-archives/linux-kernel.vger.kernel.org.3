Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B0E4B090A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbiBJJAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:00:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238138AbiBJJA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:00:29 -0500
Received: from spam.unicloud.com (eage.unicloud.com [220.194.70.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53621091
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:00:28 -0800 (PST)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 21A8wsoE022471;
        Thu, 10 Feb 2022 16:58:54 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from localhost.localdomain (10.10.1.7) by zgys-ex-mb09.Unicloud.com
 (10.10.0.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2375.17; Thu, 10
 Feb 2022 16:58:54 +0800
From:   luofei <luofei@unicloud.com>
To:     <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        luofei <luofei@unicloud.com>
Subject: [PATCH] mm/hwpoison: In-use hugepage need filter judgement and filter return value should be consistent
Date:   Thu, 10 Feb 2022 03:58:46 -0500
Message-ID: <20220210085846.902394-1-luofei@unicloud.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.10.1.7]
X-ClientProxiedBy: zgys-ex-mb07.Unicloud.com (10.10.0.27) To
 zgys-ex-mb09.Unicloud.com (10.10.0.24)
X-DNSRBL: 
X-MAIL: spam.unicloud.com 21A8wsoE022471
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After successfully obtaining the reference count of the huge
page, it is still necessary to call hwpoison_filter() to make a
filter judgement, otherwise the filter page will be unmaped and
the related process may be killed.

Also when the huge page meets the filter conditions, it should
not be regarded as successful memory_failure() processing, but
should return an error code to inform the caller, otherwise the
caller regards the error page has been identified and isolated,
which may lead to calling set_mce_nospec() to change page attribute.

Meanwhile, when calling hwpoison_filter() to determine that a page
needs to be filtered, it is better to keep the same EBUSY return
value, so that the caller can recognize that memory_failure() did
not successfully process the error page.

Signed-off-by: luofei <luofei@unicloud.com>
---
 mm/hwpoison-inject.c |  2 +-
 mm/memory-failure.c  | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index aff4d27ec235..4ecd77cd1ded 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -44,7 +44,7 @@ static int hwpoison_inject(void *data, u64 val)
 	 */
 	err = hwpoison_filter(hpage);
 	if (err)
-		return 0;
+		return -EBUSY;
 
 inject:
 	pr_info("Injecting memory failure at pfn %#lx\n", pfn);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 97a9ed8f87a9..acf97fb2659a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1526,7 +1526,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 				if (TestClearPageHWPoison(head))
 					num_poisoned_pages_dec();
 				unlock_page(head);
-				return 0;
+				return -EBUSY;
 			}
 			unlock_page(head);
 			res = MF_FAILED;
@@ -1545,6 +1545,13 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	lock_page(head);
 	page_flags = head->flags;
 
+	if (hwpoison_filter(p)) {
+		if (TestClearPageHWPoison(head))
+			num_poisoned_pages_dec();
+		unlock_page(head);
+		res = -EBUSY
+		goto out;
+	}
 	/*
 	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
 	 * simply disable it. In order to make it work properly, we need
@@ -1613,7 +1620,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		goto out;
 
 	if (hwpoison_filter(page)) {
-		rc = 0;
+		rc = -EBUSY;
 		goto unlock;
 	}
 
@@ -1837,6 +1844,7 @@ int memory_failure(unsigned long pfn, int flags)
 			num_poisoned_pages_dec();
 		unlock_page(p);
 		put_page(p);
+		res = -EBUSY;
 		goto unlock_mutex;
 	}
 
-- 
2.27.0

