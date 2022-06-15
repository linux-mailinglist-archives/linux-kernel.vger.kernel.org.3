Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F8A54D563
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350520AbiFOXek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 19:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbiFOXej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 19:34:39 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2DE192AC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:34:37 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25FNYRy54015276, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25FNYRy54015276
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Jun 2022 07:34:27 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 16 Jun 2022 07:34:26 +0800
Received: from localhost.localdomain (172.21.177.191) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 16 Jun 2022 07:34:25 +0800
From:   Edward Wu <edwardwu@realtek.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <surenb@google.com>, <minchan@google.com>, <edwardwu@realtek.com>
Subject: [PATCH v3] mm: cma: sync everything after EBUSY
Date:   Thu, 16 Jun 2022 07:34:20 +0800
Message-ID: <20220615233420.3783-1-edwardwu@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220615021504.23358-1-edwardwu@realtek.com>
References: <20220615021504.23358-1-edwardwu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.177.191]
X-ClientProxiedBy: RTEXH36504.realtek.com.tw (172.21.6.27) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/15/2022 23:18:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMTUgpFWkyCAxMDowMTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since file-backed memory on CMA area could take long-term pinning.

By Minchan Kim's debug commit 151e084af494 ("mm: page_alloc:
dump migrate-failed pages only at -EBUSY")
We know the pinned page comes from buffer_head, ext4 journal, FS metadata.

Sync everything after EBUSY that can unpin most file-system pages.
And raise the success rate at next time try.

Link: https://lkml.kernel.org/r/20220615021504.23358-1-edwardwu@realtek.com
Signed-off-by: Edward Wu <edwardwu@realtek.com>
---
V3:
- Use non-inline prototype for work function

v2:
- Fix compile warning

 mm/cma.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index eaa4b5c920a2..ddb9f0fbec27 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -31,6 +31,7 @@
 #include <linux/highmem.h>
 #include <linux/io.h>
 #include <linux/kmemleak.h>
+#include <linux/syscalls.h>
 #include <trace/events/cma.h>
 
 #include "cma.h"
@@ -410,6 +411,24 @@ static void cma_debug_show_areas(struct cma *cma)
 static inline void cma_debug_show_areas(struct cma *cma) { }
 #endif
 
+static void cma_sync_work(struct work_struct *work)
+{
+	ksys_sync();
+	kfree(work);
+	pr_debug("%s(): EBUSY Sync complete\n", __func__);
+}
+
+static void cma_ebusy_sync_pinned_pages(void)
+{
+	struct work_struct *work;
+
+	work = kmalloc(sizeof(*work), GFP_ATOMIC);
+	if (work) {
+		INIT_WORK(work, cma_sync_work);
+		schedule_work(work);
+	}
+}
+
 /**
  * cma_alloc() - allocate pages from contiguous area
  * @cma:   Contiguous memory region for which the allocation is performed.
@@ -430,6 +449,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	unsigned long i;
 	struct page *page = NULL;
 	int ret = -ENOMEM;
+	bool sys_synchronized = false;
 
 	if (!cma || !cma->count || !cma->bitmap)
 		goto out;
@@ -480,6 +500,11 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 		if (ret != -EBUSY)
 			break;
 
+		if (!sys_synchronized) {
+			sys_synchronized = true;
+			cma_ebusy_sync_pinned_pages();
+		}
+
 		pr_debug("%s(): memory range at %p is busy, retrying\n",
 			 __func__, pfn_to_page(pfn));
 
-- 
2.17.1

