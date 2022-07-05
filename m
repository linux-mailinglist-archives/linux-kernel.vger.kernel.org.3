Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3612C566FBB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiGENq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiGENqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:46:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC05D20F7F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:10:57 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lcjd402LCzTgDp;
        Tue,  5 Jul 2022 21:07:20 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 21:10:55 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Jul
 2022 21:10:55 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>
CC:     <chris@zankel.net>, <jcmvbkbc@gmail.com>
Subject: [PATCH -next 2/2] xtensa: iss: change the return type of iss_net_configure() to void
Date:   Tue, 5 Jul 2022 21:20:32 +0800
Message-ID: <20220705132032.702972-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705132032.702972-1-yangyingliang@huawei.com>
References: <20220705132032.702972-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the return type of iss_net_configure() to void, because it's not used.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/xtensa/platforms/iss/network.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 5e475f7472e4..e38ff51ce833 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -472,16 +472,15 @@ static const struct net_device_ops iss_netdev_ops = {
 	.ndo_set_rx_mode	= iss_net_set_multicast_list,
 };
 
-static int iss_net_configure(int index, char *init)
+static void iss_net_configure(int index, char *init)
 {
 	struct net_device *dev;
 	struct iss_net_private *lp;
-	int err;
 
 	dev = alloc_etherdev(sizeof(*lp));
 	if (dev == NULL) {
 		pr_err("eth_configure: failed to allocate device\n");
-		return -ENOMEM;
+		return;
 	}
 
 	/* Initialize private element. */
@@ -509,7 +508,6 @@ static int iss_net_configure(int index, char *init)
 	if (!tuntap_probe(lp, index, init)) {
 		pr_err("%s: invalid arguments. Skipping device!\n",
 		       dev->name);
-		err = -EINVAL;
 		goto err_free_netdev;
 	}
 
@@ -518,8 +516,7 @@ static int iss_net_configure(int index, char *init)
 	/* sysfs register */
 
 	if (!driver_registered) {
-		err = platform_driver_register(&iss_net_driver);
-		if (err)
+		if (platform_driver_register(&iss_net_driver))
 			goto err_free_netdev;
 		driver_registered = 1;
 	}
@@ -530,8 +527,7 @@ static int iss_net_configure(int index, char *init)
 
 	lp->pdev.id = index;
 	lp->pdev.name = DRIVER_NAME;
-	err = platform_device_register(&lp->pdev);
-	if (err)
+	if (platform_device_register(&lp->pdev))
 		goto err_free_netdev;
 	SET_NETDEV_DEV(dev, &lp->pdev.dev);
 
@@ -541,23 +537,22 @@ static int iss_net_configure(int index, char *init)
 	dev->irq = -1;
 
 	rtnl_lock();
-	err = register_netdevice(dev);
-	rtnl_unlock();
-
-	if (err) {
+	if (register_netdevice(dev)) {
+		rtnl_unlock();
 		pr_err("%s: error registering net device!\n", dev->name);
 		goto err_unregister_device;
 	}
+	rtnl_unlock();
 
 	timer_setup(&lp->tl, iss_net_user_timer_expire, 0);
 
-	return 0;
+	return;
 
 err_unregister_device:
 	platform_device_unregister(&lp->pdev);
 err_free_netdev:
 	free_netdev(dev);
-	return err;
+	return;
 }
 
 /* ------------------------------------------------------------------------- */
-- 
2.25.1

