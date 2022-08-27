Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1765A3739
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiH0LPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 07:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiH0LPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 07:15:40 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0024213E21
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 04:15:38 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MFDbk2LwPzGpsM;
        Sat, 27 Aug 2022 19:13:54 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 19:15:37 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 19:15:36 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: kill is_memblock_offlined()
Date:   Sat, 27 Aug 2022 19:20:43 +0800
Message-ID: <20220827112043.187028-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly check state of struct memory_block, no need a single function.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/base/memory.c          | 6 ------
 include/linux/memory_hotplug.h | 2 --
 mm/memory_hotplug.c            | 3 +--
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index bc60c9cd3230..9aa0da991cfb 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -869,12 +869,6 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 	}
 }
 
-/* return true if the memory block is offlined, otherwise, return false */
-bool is_memblock_offlined(struct memory_block *mem)
-{
-	return mem->state == MEM_OFFLINE;
-}
-
 static struct attribute *memory_root_attrs[] = {
 #ifdef CONFIG_ARCH_MEMORY_PROBE
 	&dev_attr_probe.attr,
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 409196ef8038..de87545eabe9 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -11,7 +11,6 @@ struct page;
 struct zone;
 struct pglist_data;
 struct mem_section;
-struct memory_block;
 struct memory_group;
 struct resource;
 struct vmem_altmap;
@@ -352,7 +351,6 @@ extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 extern void remove_pfn_range_from_zone(struct zone *zone,
 				       unsigned long start_pfn,
 				       unsigned long nr_pages);
-extern bool is_memblock_offlined(struct memory_block *mem);
 extern int sparse_add_section(int nid, unsigned long pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2fd45ccbce45..9ae1f98548b1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1969,11 +1969,10 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
 {
-	int ret = !is_memblock_offlined(mem);
 	int *nid = arg;
 
 	*nid = mem->nid;
-	if (unlikely(ret)) {
+	if (unlikely(mem->state != MEM_OFFLINE)) {
 		phys_addr_t beginpa, endpa;
 
 		beginpa = PFN_PHYS(section_nr_to_pfn(mem->start_section_nr));
-- 
2.35.3

