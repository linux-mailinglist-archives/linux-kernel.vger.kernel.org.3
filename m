Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E393F52CE2E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbiESISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiESIRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:17:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2386543C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:17:07 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3jNG6CD7zcbCK;
        Thu, 19 May 2022 16:15:42 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 16:17:05 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 16:17:05 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>,
        <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 3/6] mm: ioremap: Setup phys_addr of struct vm_struct
Date:   Thu, 19 May 2022 16:25:49 +0800
Message-ID: <20220519082552.117736-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
References: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Show physical address of each ioremap in /proc/vmallocinfo.

Acked-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/ioremap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/ioremap.c b/mm/ioremap.c
index 1f9597fbcc07..7cb9996b0c12 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -32,6 +32,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long pro
 	if (!area)
 		return NULL;
 	vaddr = (unsigned long)area->addr;
+	area->phys_addr = phys_addr;
 
 	if (ioremap_page_range(vaddr, vaddr + size, phys_addr, __pgprot(prot))) {
 		free_vm_area(area);
-- 
2.35.3

