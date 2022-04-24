Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0FD50CE54
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiDXCIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbiDXCIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:08:47 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC93F6469
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:05:47 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sun, 24 Apr
 2022 10:05:47 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Sun, 24 Apr
 2022 10:05:45 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] soc: ti: use IS_ERR insead of IS_ERR_OR_NULL when checking knav_queue_open() result
Date:   Sun, 24 Apr 2022 10:05:43 +0800
Message-ID: <1650765944-20170-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the usage of knav_queue_open():

* Returns a handle to the open hardware queue if successful. Use IS_ERR()
* to check the returned value for error codes.

It will only return error codes, not null.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 4dbaa8c3636c..24334ebb7cd7 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -789,7 +789,7 @@ void *knav_pool_create(const char *name,
 	}
 
 	pool->queue = knav_queue_open(name, KNAV_QUEUE_GP, 0);
-	if (IS_ERR_OR_NULL(pool->queue)) {
+	if (IS_ERR(pool->queue)) {
 		dev_err(kdev->dev,
 			"failed to open queue for pool(%s), error %ld\n",
 			name, PTR_ERR(pool->queue));
-- 
2.7.4

