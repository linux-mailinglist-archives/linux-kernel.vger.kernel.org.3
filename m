Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1D1542C53
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiFHJ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbiFHJ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:58:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60911FA5F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:30:46 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LJ2444JPgzjY8J;
        Wed,  8 Jun 2022 17:29:24 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 17:30:44 +0800
From:   Zhang Wensheng <zhangwensheng5@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <zhangwensheng5@huawei.com>
Subject: [PATCH -next] driver core: fix deadlock in __driver_attach
Date:   Wed, 8 Jun 2022 17:43:55 +0800
Message-ID: <20220608094355.3298420-1-zhangwensheng5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __driver_attach function, There are also potential AA deadlock
problem, like the commit b232b02bf3c2 ("driver core: fix deadlock
in __device_attach").

Fixes: ef0ff68351be ("driver core: Probe devices asynchronously instead of the driver")
Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
---
 drivers/base/dd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 11b0fb6414d3..b766968a873c 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1115,6 +1115,7 @@ static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
 static int __driver_attach(struct device *dev, void *data)
 {
 	struct device_driver *drv = data;
+	bool async = false;
 	int ret;
 
 	/*
@@ -1153,9 +1154,11 @@ static int __driver_attach(struct device *dev, void *data)
 		if (!dev->driver && !dev->p->async_driver) {
 			get_device(dev);
 			dev->p->async_driver = drv;
-			async_schedule_dev(__driver_attach_async_helper, dev);
+			async = true;
 		}
 		device_unlock(dev);
+		if (async)
+			async_schedule_dev(__driver_attach_async_helper, dev);
 		return 0;
 	}
 
-- 
2.31.1

