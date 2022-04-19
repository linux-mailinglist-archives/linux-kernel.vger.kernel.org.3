Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CAC5061C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343605AbiDSBqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343603AbiDSBqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:46:07 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50DE27FE9;
        Mon, 18 Apr 2022 18:43:23 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 19 Apr
 2022 09:43:23 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 19 Apr
 2022 09:43:21 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] s390/dasd: Use kzalloc instead of kmalloc/memset
Date:   Tue, 19 Apr 2022 09:43:20 +0800
Message-ID: <1650332600-5307-1-git-send-email-baihaowen@meizu.com>
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

Use kzalloc rather than duplicating its implementation, which
makes code simple and easy to understand.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/s390/block/dasd_eckd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 8410a25a65c1..74a035c56c3e 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1480,7 +1480,7 @@ static int dasd_eckd_pe_handler(struct dasd_device *device,
 {
 	struct pe_handler_work_data *data;
 
-	data = kmalloc(sizeof(*data), GFP_ATOMIC | GFP_DMA);
+	data = kzalloc(sizeof(*data), GFP_ATOMIC | GFP_DMA);
 	if (!data) {
 		if (mutex_trylock(&dasd_pe_handler_mutex)) {
 			data = pe_handler_worker;
@@ -1489,7 +1489,6 @@ static int dasd_eckd_pe_handler(struct dasd_device *device,
 			return -ENOMEM;
 		}
 	} else {
-		memset(data, 0, sizeof(*data));
 		data->isglobal = 0;
 	}
 	INIT_WORK(&data->worker, do_pe_handler_work);
-- 
2.7.4

