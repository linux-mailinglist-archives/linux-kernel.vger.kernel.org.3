Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70A65813C3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbiGZNEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiGZNEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:04:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D053015FF7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:04:44 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LscTr5tmpzWfVM;
        Tue, 26 Jul 2022 21:00:48 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 21:04:42 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 21:04:41 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: use is_zone_movable_page() helper
Date:   Tue, 26 Jul 2022 21:11:35 +0800
Message-ID: <20220726131135.146912-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_zone_movable_page() helper to simplify code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/virtio/virtio_mem.c | 6 ++----
 mm/memory_hotplug.c         | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index e07486f01999..0c2892ec6817 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -862,8 +862,7 @@ static void virtio_mem_sbm_notify_online(struct virtio_mem *vm,
 					 unsigned long mb_id,
 					 unsigned long start_pfn)
 {
-	const bool is_movable = page_zonenum(pfn_to_page(start_pfn)) ==
-				ZONE_MOVABLE;
+	const bool is_movable = is_zone_movable_page(pfn_to_page(start_pfn));
 	int new_state;
 
 	switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
@@ -1158,8 +1157,7 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
  */
 static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
 {
-	const bool is_movable = page_zonenum(pfn_to_page(pfn)) ==
-				ZONE_MOVABLE;
+	const bool is_movable = is_zone_movable_page(pfn_to_page(pfn));
 	int rc, retry_count;
 
 	/*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1213d0c67a53..0f5914964a32 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -936,7 +936,7 @@ static struct zone *auto_movable_zone_for_pfn(int nid,
 			if (!page)
 				continue;
 			/* If anything is !MOVABLE online the rest !MOVABLE. */
-			if (page_zonenum(page) != ZONE_MOVABLE)
+			if (!is_zone_movable_page(page))
 				goto kernel_zone;
 			online_pages += PAGES_PER_SECTION;
 		}
-- 
2.35.3

