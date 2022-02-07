Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4667F4AB3F2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351138AbiBGFw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbiBGEXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:23:16 -0500
X-Greylist: delayed 1181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 20:23:14 PST
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C29C061A73;
        Sun,  6 Feb 2022 20:23:14 -0800 (PST)
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JsXT60sCSz1FCvB;
        Mon,  7 Feb 2022 11:59:22 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.21; Mon, 7
 Feb 2022 12:03:31 +0800
From:   Zhipeng Xie <xiezhipeng1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xiezhipeng1@huawei.com>
Subject: [PATCH] Fix perf_mmap fail when CONFIG_PERF_USE_VMALLOC enabled
Date:   Mon, 7 Feb 2022 12:02:59 -0500
Message-ID: <20220207170259.2566-1-xiezhipeng1@huawei.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when CONFIG_PERF_USE_VMALLOC is enabled, rb->nr_pages is always
equal to 1 in rb_alloc, causing perf_mmap return -EINVAL when mmap.
Fix this problem using data_page_nr.

Signed-off-by: Zhipeng Xie <xiezhipeng1@huawei.com>
---
 kernel/events/core.c        | 2 +-
 kernel/events/internal.h    | 5 +++++
 kernel/events/ring_buffer.c | 5 -----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 57c7197838db..370292effd32 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6352,7 +6352,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 again:
 	mutex_lock(&event->mmap_mutex);
 	if (event->rb) {
-		if (event->rb->nr_pages != nr_pages) {
+		if (data_page_nr(event->rb) != nr_pages) {
 			ret = -EINVAL;
 			goto unlock;
 		}
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 082832738c8f..5816c0719dbf 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -116,6 +116,11 @@ static inline int page_order(struct perf_buffer *rb)
 }
 #endif
 
+static int data_page_nr(struct perf_buffer *rb)
+{
+	return rb->nr_pages << page_order(rb);
+}
+
 static inline unsigned long perf_data_size(struct perf_buffer *rb)
 {
 	return rb->nr_pages << (PAGE_SHIFT + page_order(rb));
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 52868716ec35..fb35b926024c 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -859,11 +859,6 @@ void rb_free(struct perf_buffer *rb)
 }
 
 #else
-static int data_page_nr(struct perf_buffer *rb)
-{
-	return rb->nr_pages << page_order(rb);
-}
-
 static struct page *
 __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
 {
-- 
2.18.1

