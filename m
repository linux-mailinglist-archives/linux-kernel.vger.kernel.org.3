Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F19C5B132D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 06:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIHEMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 00:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIHEMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 00:12:38 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1582952085
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 21:12:36 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662610354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zwoG+2A1DN6DhncHURTf/vjvqKNs3W4Fx+gG9cqxMPk=;
        b=A7GwQ/Ajj9bHP0svWliAGuGUePBOMb64r707Tp5vlSTdrsJmZTgQPuScjqWudkJLh4qqWa
        17h/ZbQmIyWrdOnnSKEanHP3cz04vi8Y/2JWEvBn7DrJsh+phenHD6h+SzGvaEh18t94iR
        8NtWpBUq5P4esfn8vgvaHzPmZMUxzls=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/huge_memory: use pfn_to_online_page() in split_huge_pages_all()
Date:   Thu,  8 Sep 2022 13:11:50 +0900
Message-Id: <20220908041150.3430269-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

NULL pointer dereference is triggered when calling thp split via debugfs
on the system with offlined memory blocks.  With debug option enabled,
the following kernel messages are printed out:

  page:00000000467f4890 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x121c000
  flags: 0x17fffc00000000(node=0|zone=2|lastcpupid=0x1ffff)
  raw: 0017fffc00000000 0000000000000000 dead000000000122 0000000000000000
  raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
  page dumped because: unmovable page
  page:000000007d7ab72e is uninitialized and poisoned
  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
  ------------[ cut here ]------------
  kernel BUG at include/linux/mm.h:1248!
  invalid opcode: 0000 [#1] PREEMPT SMP PTI
  CPU: 16 PID: 20964 Comm: bash Tainted: G          I        6.0.0-rc3-foll-numa+ #41
  ...
  RIP: 0010:split_huge_pages_write+0xcf4/0xe30

This shows that page_to_nid() in page_zone() is unexpectedly called for an
offlined memmap.

Use pfn_to_online_page() to get struct page in PFN walker.

Fixes: 49071d436b51 ("thp: add debugfs handle to split all huge pages")
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Co-developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org> # 5.10+
---
 mm/huge_memory.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5fa2ba86dae4..730eb6d6836b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2894,11 +2894,9 @@ static void split_huge_pages_all(void)
 		max_zone_pfn = zone_end_pfn(zone);
 		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
 			int nr_pages;
-			if (!pfn_valid(pfn))
-				continue;
 
-			page = pfn_to_page(pfn);
-			if (!get_page_unless_zero(page))
+			page = pfn_to_online_page(pfn);
+			if (!page || !get_page_unless_zero(page))
 				continue;
 
 			if (zone != page_zone(page))
-- 
2.25.1

