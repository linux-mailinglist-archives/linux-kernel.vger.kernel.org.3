Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67755441B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353343AbiFVHap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352669AbiFVHam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:30:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D49737024
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:30:40 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LSZk60kGMzhXZ7;
        Wed, 22 Jun 2022 15:28:30 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 15:30:36 +0800
From:   Zhang Wensheng <zhangwensheng5@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <zhangwensheng5@huawei.com>
Subject: [PATCH -next v2] driver core: fix deadlock in __driver_attach
Date:   Wed, 22 Jun 2022 15:43:27 +0800
Message-ID: <20220622074327.497102-1-zhangwensheng5@huawei.com>
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

In __driver_attach function, There are also AA deadlock problem,
like the commit b232b02bf3c2 ("driver core: fix deadlock in
__device_attach").

stack like commit b232b02bf3c2 ("driver core: fix deadlock in
__device_attach").
list below:
    In __driver_attach function, The lock holding logic is as follows:
    ...
    __driver_attach
    if (driver_allows_async_probing(drv))
      device_lock(dev)      // get lock dev
        async_schedule_dev(__driver_attach_async_helper, dev); // func
          async_schedule_node
            async_schedule_node_domain(func)
              entry = kzalloc(sizeof(struct async_entry), GFP_ATOMIC);
              /* when fail or work limit, sync to execute func, but
                 __driver_attach_async_helper will get lock dev as
                 will, which will lead to A-A deadlock.  */
              if (!entry || atomic_read(&entry_count) > MAX_WORK) {
                func;
              else
                queue_work_node(node, system_unbound_wq, &entry->work)
      device_unlock(dev)

    As above show, when it is allowed to do async probes, because of
    out of memory or work limit, async work is not be allowed, to do
    sync execute instead. it will lead to A-A deadlock because of
    __driver_attach_async_helper getting lock dev.

Reproduce:
and it can be reproduce by make the condition
(if (!entry || atomic_read(&entry_count) > MAX_WORK)) untenable, like
below:

[  370.785650] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[  370.787154] task:swapper/0       state:D stack:    0 pid:    1 ppid:
0 flags:0x00004000
[  370.788865] Call Trace:
[  370.789374]  <TASK>
[  370.789841]  __schedule+0x482/0x1050
[  370.790613]  schedule+0x92/0x1a0
[  370.791290]  schedule_preempt_disabled+0x2c/0x50
[  370.792256]  __mutex_lock.isra.0+0x757/0xec0
[  370.793158]  __mutex_lock_slowpath+0x1f/0x30
[  370.794079]  mutex_lock+0x50/0x60
[  370.794795]  __device_driver_lock+0x2f/0x70
[  370.795677]  ? driver_probe_device+0xd0/0xd0
[  370.796576]  __driver_attach_async_helper+0x1d/0xd0
[  370.797318]  ? driver_probe_device+0xd0/0xd0
[  370.797957]  async_schedule_node_domain+0xa5/0xc0
[  370.798652]  async_schedule_node+0x19/0x30
[  370.799243]  __driver_attach+0x246/0x290
[  370.799828]  ? driver_allows_async_probing+0xa0/0xa0
[  370.800548]  bus_for_each_dev+0x9d/0x130
[  370.801132]  driver_attach+0x22/0x30
[  370.801666]  bus_add_driver+0x290/0x340
[  370.802246]  driver_register+0x88/0x140
[  370.802817]  ? virtio_scsi_init+0x116/0x116
[  370.803425]  scsi_register_driver+0x1a/0x30
[  370.804057]  init_sd+0x184/0x226
[  370.804533]  do_one_initcall+0x71/0x3a0
[  370.805107]  kernel_init_freeable+0x39a/0x43a
[  370.805759]  ? rest_init+0x150/0x150
[  370.806283]  kernel_init+0x26/0x230
[  370.806799]  ret_from_fork+0x1f/0x30

To fix the deadlock, move the async_schedule_dev outside device_lock,
as we can see, in async_schedule_node_domain, the parameter of
queue_work_node is system_unbound_wq, so it can accept concurrent
operations. which will also not change the code logic, and will
not lead to deadlock.

Fixes: ef0ff68351be ("driver core: Probe devices asynchronously instead of the driver")
Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
---
v2: add patch description
v1: https://lore.kernel.org/lkml/YqNL6NPgP+cLOy%2FI@kroah.com/t/
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

