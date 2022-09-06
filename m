Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD425AE1AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbiIFH4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbiIFH4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:56:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E426C766
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:56:39 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MMHfJ2dTVzZcl3;
        Tue,  6 Sep 2022 15:52:08 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 15:56:37 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mm/rodata_test: use PAGE_ALIGNED() helper
Date:   Tue, 6 Sep 2022 15:53:12 +0800
Message-ID: <20220906075312.166595-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PAGE_ALIGNED() helper instead of open-coding operation,
no functional changes here.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 mm/rodata_test.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/rodata_test.c b/mm/rodata_test.c
index 2613371945b7..6d783436951f 100644
--- a/mm/rodata_test.c
+++ b/mm/rodata_test.c
@@ -9,13 +9,13 @@
 
 #include <linux/rodata_test.h>
 #include <linux/uaccess.h>
+#include <linux/mm.h>
 #include <asm/sections.h>
 
 static const int rodata_test_data = 0xC3;
 
 void rodata_test(void)
 {
-	unsigned long start, end;
 	int zero = 0;
 
 	/* test 1: read the value */
@@ -39,13 +39,11 @@ void rodata_test(void)
 	}
 
 	/* test 4: check if the rodata section is PAGE_SIZE aligned */
-	start = (unsigned long)__start_rodata;
-	end = (unsigned long)__end_rodata;
-	if (start & (PAGE_SIZE - 1)) {
+	if (!PAGE_ALIGNED(__start_rodata)) {
 		pr_err("start of .rodata is not page size aligned\n");
 		return;
 	}
-	if (end & (PAGE_SIZE - 1)) {
+	if (!PAGE_ALIGNED(__end_rodata)) {
 		pr_err("end of .rodata is not page size aligned\n");
 		return;
 	}
-- 
2.17.1

