Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB2B506426
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348758AbiDSGH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiDSGH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:07:57 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4348060F3;
        Mon, 18 Apr 2022 23:05:14 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 19 Apr
 2022 14:05:13 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 19 Apr
 2022 14:05:11 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <svens@linux.ibm.com>
CC:     <agordeev@linux.ibm.com>, <baihaowen@meizu.com>,
        <borntraeger@linux.ibm.com>, <gor@linux.ibm.com>,
        <hca@linux.ibm.com>, <hoeppner@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <sth@linux.ibm.com>
Subject: [PATCH V2] s390/dasd: Use kzalloc instead of kmalloc/memset
Date:   Tue, 19 Apr 2022 14:05:10 +0800
Message-ID: <1650348310-18553-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <yt9dilr539wq.fsf@linux.ibm.com>
References: <yt9dilr539wq.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzalloc rather than duplicating its implementation, which
makes code simple and easy to understand.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: also remove the isglobal assigment above, so the whole else block
could go away

 drivers/s390/block/dasd_eckd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 8410a25a65c1..6b70f9dfff02 100644
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
@@ -1488,9 +1488,6 @@ static int dasd_eckd_pe_handler(struct dasd_device *device,
 		} else {
 			return -ENOMEM;
 		}
-	} else {
-		memset(data, 0, sizeof(*data));
-		data->isglobal = 0;
 	}
 	INIT_WORK(&data->worker, do_pe_handler_work);
 	dasd_get_device(device);
-- 
2.7.4

