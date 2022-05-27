Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7623535DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350714AbiE0KBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiE0KBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:01:30 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFA9515BB
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:01:27 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 27 May
 2022 18:01:22 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 27 May
 2022 18:01:19 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] xfs: drop the useless LIST_HEAD in __mtd_del_partition()
Date:   Fri, 27 May 2022 18:01:18 +0800
Message-ID: <1653645678-29049-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop LIST_HEAD where the variable it declares is never used.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/mtd/mtdpart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index d442fa94c872..976e9c30244e 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -326,7 +326,6 @@ static int __mtd_del_partition(struct mtd_info *mtd)
 static int __del_mtd_partitions(struct mtd_info *mtd)
 {
 	struct mtd_info *child, *next;
-	LIST_HEAD(tmp_list);
 	int ret, err = 0;
 
 	list_for_each_entry_safe(child, next, &mtd->partitions, part.node) {
-- 
2.7.4

