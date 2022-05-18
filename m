Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF97F52B39B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiERHbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiERHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:31:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64FF286D6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:31:39 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L34QJ4WkLzgYNL;
        Wed, 18 May 2022 15:30:16 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 15:31:36 +0800
From:   Zhang Wensheng <zhangwensheng5@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>
Subject: [PATCH -next] driver core: fix deadlock in __device_attach
Date:   Wed, 18 May 2022 15:45:16 +0800
Message-ID: <20220518074516.1225580-1-zhangwensheng5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

In __device_attach function, The lock holding logic is as follows:
...
__device_attach
device_lock(dev)      // get lock dev
  async_schedule_dev(__device_attach_async_helper, dev); // func
    async_schedule_node
      async_schedule_node_domain(func)
        entry = kzalloc(sizeof(struct async_entry), GFP_ATOMIC);
	/* when fail or work limit, sync to execute func, but
	   __device_attach_async_helper will get lock dev as
	   well, which will lead to A-A deadlock.  */
	if (!entry || atomic_read(&entry_count) > MAX_WORK) {
	  func;
	else
	  queue_work_node(node, system_unbound_wq, &entry->work)
  device_unlock(dev)

As shown above, when it is allowed to do async probes, because of
out of memory or work limit, async work is not allowed, to do
sync execute instead. it will lead to A-A deadlock because of
__device_attach_async_helper getting lock dev.

To fix the deadlock, move the async_schedule_dev outside device_lock,
as we can see, in async_schedule_node_domain, the parameter of
queue_work_node is system_unbound_wq, so it can accept concurrent
operations. which will also not change the code logic, and will
not lead to deadlock.

Fixes: 765230b5f084 ("driver-core: add asynchronous probing support for drivers")
Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
---
 drivers/base/dd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 3fc3b5940bb3..ed02a529a896 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -941,6 +941,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 static int __device_attach(struct device *dev, bool allow_async)
 {
 	int ret = 0;
+	bool async = false;
 
 	device_lock(dev);
 	if (dev->p->dead) {
@@ -979,7 +980,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			 */
 			dev_dbg(dev, "scheduling asynchronous probe\n");
 			get_device(dev);
-			async_schedule_dev(__device_attach_async_helper, dev);
+			async = true;
 		} else {
 			pm_request_idle(dev);
 		}
@@ -989,6 +990,8 @@ static int __device_attach(struct device *dev, bool allow_async)
 	}
 out_unlock:
 	device_unlock(dev);
+	if (async)
+		async_schedule_dev(__device_attach_async_helper, dev);
 	return ret;
 }
 
-- 
2.31.1

