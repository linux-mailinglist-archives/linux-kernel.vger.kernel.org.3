Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E364B8730
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiBPL4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:56:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiBPLzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:55:49 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E187226724A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:55:37 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JzGZZ181wz9sgD;
        Wed, 16 Feb 2022 19:53:58 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 19:55:35 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 19:55:35 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.or>, <paulus@samba.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <songyuanzheng@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 1/2] Revert "powerpc: Set max_mapnr correctly"
Date:   Wed, 16 Feb 2022 20:11:07 +0800
Message-ID: <20220216121109.157605-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
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

This reverts commit 602946ec2f90d5bd965857753880db29d2d9a1e9.

If CONFIG_HIGHMEM enabled, highmem will be disappeared with max_mapnr
set to max_low_pfn, see mem_init(), 

  for (pfn = highmem_mapnr; pfn < max_mapnr; ++pfn) {
        ...
	free_highmem_page();
  }

Revert it and will fix virt_addr_valid() check in the next patch.

Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Fixes: 602946ec2f90 ("powerpc: Set max_mapnr correctly")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v4:
- new patch
 arch/powerpc/mm/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 8e301cd8925b..4d221d033804 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -255,7 +255,7 @@ void __init mem_init(void)
 #endif
 
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
-	set_max_mapnr(max_low_pfn);
+	set_max_mapnr(max_pfn);
 
 	kasan_late_init();
 
-- 
2.26.2

