Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7808450F1F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343733AbiDZHQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241770AbiDZHQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:16:21 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13A039812
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:13:13 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KnXzX45Q5zCsR4;
        Tue, 26 Apr 2022 15:08:40 +0800 (CST)
Received: from linux-suspe12sp5.huawei.com (10.67.133.42) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 15:13:11 +0800
From:   liusongtang <liusongtang@huawei.com>
To:     <akpm@linux-foundation.org>, <anshuman.khandual@arm.com>
CC:     <liusongtang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <nixiaoming@huawei.com>,
        <young.liuyang@huawei.com>, <trivial@kernel.org>,
        <wangkefeng@huawei.com>
Subject: [PATCH v2] mm/memory_hotplug: use pgprot_val to get value of pgprot
Date:   Tue, 26 Apr 2022 15:13:02 +0800
Message-ID: <20220426071302.220646-1-liusongtang@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.42]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pgprot.pgprot is a non-portable code, it should be replaced by
portable macro pgprot_val.

Signed-off-by: liusongtang <liusongtang@huawei.com>

---
v2: add 'memory_hotplug' in the subject line
v1: https://lore.kernel.org/all/a5b58a66-bdc3-94df-6af5-c647da888c17@huawei.com/
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 416b38c..bf7d181 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -303,7 +303,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 	int err;
 	struct vmem_altmap *altmap = params->altmap;
 
-	if (WARN_ON_ONCE(!params->pgprot.pgprot))
+	if (WARN_ON_ONCE(!pgprot_val(params->pgprot)))
 		return -EINVAL;
 
 	VM_BUG_ON(!mhp_range_allowed(PFN_PHYS(pfn), nr_pages * PAGE_SIZE, false));
-- 
2.12.3

