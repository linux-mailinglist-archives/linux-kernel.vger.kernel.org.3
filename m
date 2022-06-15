Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90E154BF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbiFOCPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiFOCPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:15:51 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D966748E6F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:15:41 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25F2FBDr8007761, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25F2FBDr8007761
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Jun 2022 10:15:11 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 15 Jun 2022 10:15:11 +0800
Received: from localhost.localdomain (172.21.177.191) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 15 Jun 2022 10:15:11 +0800
From:   Edward Wu <edwardwu@realtek.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <surenb@google.com>, <minchan@google.com>, <edwardwu@realtek.com>
Subject: [PATCH] mm: cma: sync everything after EBUSY
Date:   Wed, 15 Jun 2022 10:15:04 +0800
Message-ID: <20220615021504.23358-1-edwardwu@realtek.com>
X-Mailer: git-send-email 2.17.1
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
X-KSE-Antiphishing-Bases: 06/15/2022 01:58:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMTQgpFWkyCAxMDowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
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

Signed-off-by: Edward Wu <edwardwu@realtek.com>
---
 mm/cma.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index eaa4b5c920a2..eefd725064e1 100644
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
 
+void cma_sync_work(struct work_struct *work)
+{
+	ksys_sync();
+	kfree(work);
+	pr_debug("%s(): EBUSY Sync complete\n", __func__);
+}
+
+void cma_ebusy_sync_pinned_pages(void)
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

