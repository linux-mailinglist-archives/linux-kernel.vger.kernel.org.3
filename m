Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95525432C8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbiFHOkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbiFHOkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:40:36 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1FE1455B4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:40:31 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LJ8wt6y9Kz1K9sx;
        Wed,  8 Jun 2022 22:38:38 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 22:40:27 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 2/3] mm/swapfile: fix possible data races of inuse_pages
Date:   Wed, 8 Jun 2022 22:40:30 +0800
Message-ID: <20220608144031.829-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220608144031.829-1-linmiaohe@huawei.com>
References: <20220608144031.829-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

si->inuse_pages could still be accessed concurrently now. The plain reads
outside si->lock critical section, i.e. swap_show and si_swapinfo, which
results in data races. But these should be ok because they're just used
for showing swap info.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/swapfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index d2bead7b8b70..3fa26f6971e9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2646,7 +2646,7 @@ static int swap_show(struct seq_file *swap, void *v)
 	}
 
 	bytes = si->pages << (PAGE_SHIFT - 10);
-	inuse = si->inuse_pages << (PAGE_SHIFT - 10);
+	inuse = READ_ONCE(si->inuse_pages) << (PAGE_SHIFT - 10);
 
 	file = si->swap_file;
 	len = seq_file_path(swap, file, " \t\n\\");
@@ -3265,7 +3265,7 @@ void si_swapinfo(struct sysinfo *val)
 		struct swap_info_struct *si = swap_info[type];
 
 		if ((si->flags & SWP_USED) && !(si->flags & SWP_WRITEOK))
-			nr_to_be_unused += si->inuse_pages;
+			nr_to_be_unused += READ_ONCE(si->inuse_pages);
 	}
 	val->freeswap = atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
 	val->totalswap = total_swap_pages + nr_to_be_unused;
-- 
2.23.0

