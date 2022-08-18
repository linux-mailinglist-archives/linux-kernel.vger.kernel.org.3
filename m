Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27EC5983A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbiHRNA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244407AbiHRNAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:00:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B3461DA7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:00:44 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M7lKD4xMjz1N7Mc;
        Thu, 18 Aug 2022 20:57:20 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 18 Aug
 2022 21:00:42 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 4/6] mm, hwpoison: fix possible use-after-free in mf_dax_kill_procs()
Date:   Thu, 18 Aug 2022 21:00:14 +0800
Message-ID: <20220818130016.45313-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220818130016.45313-1-linmiaohe@huawei.com>
References: <20220818130016.45313-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

After kill_procs(), tk will be freed without being removed from the to_kill
list. In the next iteration, the freed list entry in the to_kill list will
be accessed, thus leading to use-after-free issue. Fix it by reinitializing
the to_kill list after unmap_and_kill().

Fixes: c36e20249571 ("mm: introduce mf_dax_kill_procs() for fsdax case")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7023c3d81273..a2f4e8b00a26 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1658,6 +1658,8 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 		collect_procs_fsdax(page, mapping, index, &to_kill);
 		unmap_and_kill(&to_kill, page_to_pfn(page), mapping,
 				index, mf_flags);
+		/* Reinitialize to_kill list for later resuing. */
+		INIT_LIST_HEAD(&to_kill);
 unlock:
 		dax_unlock_mapping_entry(mapping, index, cookie);
 	}
-- 
2.23.0

