Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130645596FD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiFXJqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFXJqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:46:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8383A792B6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:46:20 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LTscF0KCKzSh2t;
        Fri, 24 Jun 2022 17:42:53 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 24 Jun
 2022 17:46:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <akpm@linux-foundation.org>,
        <pasha.tatashin@soleen.com>, <tongtiangen@huawei.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] riscv/mm: Fix build error while PAGE_TABLE_CHECK enabled without MMU
Date:   Fri, 24 Jun 2022 16:52:36 +0800
Message-ID: <20220624085236.18544-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/page_table_check.c: In function ‘__page_table_check_pte_clear’:
mm/page_table_check.c:148:6: error: implicit declaration of function ‘pte_user_accessible_page’; did you mean ‘user_access_save’? [-Werror=implicit-function-declaration]
  if (pte_user_accessible_page(pte)) {
      ^~~~~~~~~~~~~~~~~~~~~~~~
      user_access_save

ARCH_SUPPORTS_PAGE_TABLE_CHECK should only enabled with MMU.

Fixes: 3fee229a8eb9 ("riscv/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 850f6fbb0b5f..d6a07b9add05 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -38,7 +38,7 @@ config RISCV
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
-	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
+	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
-- 
2.17.1

