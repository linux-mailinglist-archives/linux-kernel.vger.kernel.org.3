Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D9F4AC00B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbiBGNum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387674AbiBGNiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:38:02 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFFEC0401D6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:37:25 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JsnDP0m57zdZRb;
        Mon,  7 Feb 2022 21:34:13 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Feb
 2022 21:37:22 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/4] mm/memory_hotplug: clean up try_offline_node
Date:   Mon, 7 Feb 2022 21:36:42 +0800
Message-ID: <20220207133643.23427-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220207133643.23427-1-linmiaohe@huawei.com>
References: <20220207133643.23427-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use helper macro node_spanned_pages to check whether node spans
pages. And we can change the parameter of check_cpu_on_node to nid as
that's what it really cares. Thus we can further get rid of the local
variable pgdat and improve the readability a bit.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory_hotplug.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 140809e60e9a..4b9eef861ee4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2008,12 +2008,12 @@ static int get_nr_vmemmap_pages_cb(struct memory_block *mem, void *arg)
 	return mem->nr_vmemmap_pages;
 }
 
-static int check_cpu_on_node(pg_data_t *pgdat)
+static int check_cpu_on_node(int nid)
 {
 	int cpu;
 
 	for_each_present_cpu(cpu) {
-		if (cpu_to_node(cpu) == pgdat->node_id)
+		if (cpu_to_node(cpu) == nid)
 			/*
 			 * the cpu on this node isn't removed, and we can't
 			 * offline this node.
@@ -2047,7 +2047,6 @@ static int check_no_memblock_for_node_cb(struct memory_block *mem, void *arg)
  */
 void try_offline_node(int nid)
 {
-	pg_data_t *pgdat = NODE_DATA(nid);
 	int rc;
 
 	/*
@@ -2055,7 +2054,7 @@ void try_offline_node(int nid)
 	 * offline it. A node spans memory after move_pfn_range_to_zone(),
 	 * e.g., after the memory block was onlined.
 	 */
-	if (pgdat->node_spanned_pages)
+	if (node_spanned_pages(nid))
 		return;
 
 	/*
@@ -2067,7 +2066,7 @@ void try_offline_node(int nid)
 	if (rc)
 		return;
 
-	if (check_cpu_on_node(pgdat))
+	if (check_cpu_on_node(nid))
 		return;
 
 	/*
-- 
2.23.0

