Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B265697E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbiGGCXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiGGCXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:23:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895622F38D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:22:56 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LdgCd5c3Dz1DDN6;
        Thu,  7 Jul 2022 10:22:05 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Jul 2022 10:22:51 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Jul
 2022 10:22:50 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>
CC:     <chris@zankel.net>, <jcmvbkbc@gmail.com>
Subject: [PATCH -next v2] xtensa: iss: fix handling error cases in iss_net_configure()
Date:   Thu, 7 Jul 2022 10:32:29 +0800
Message-ID: <20220707023229.2580893-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

The 'pdev' and 'netdev' need be release in error cases of iss_net_configure().
In orde to fix this, add two labels for error case to release them.

And Change the return type of iss_net_configure() to void, because it's not used.

Fixes: 7282bee78798 ("[PATCH] xtensa: Architecture support for Tensilica Xtensa Part 8")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v2:
  change return type of iss_net_configure() to void
---
 arch/xtensa/platforms/iss/network.c | 33 ++++++++++++++---------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index fd84d4891758..aeb5828a639c 100644
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
-		return 1;
+		return;
 	}
 
 	/* Initialize private element. */
@@ -509,7 +508,7 @@ static int iss_net_configure(int index, char *init)
 	if (!tuntap_probe(lp, index, init)) {
 		pr_err("%s: invalid arguments. Skipping device!\n",
 		       dev->name);
-		goto errout;
+		goto err_free_netdev;
 	}
 
 	pr_info("Netdevice %d (%pM)\n", index, dev->dev_addr);
@@ -517,7 +516,8 @@ static int iss_net_configure(int index, char *init)
 	/* sysfs register */
 
 	if (!driver_registered) {
-		platform_driver_register(&iss_net_driver);
+		if (platform_driver_register(&iss_net_driver))
+			goto err_free_netdev;
 		driver_registered = 1;
 	}
 
@@ -527,7 +527,8 @@ static int iss_net_configure(int index, char *init)
 
 	lp->pdev.id = index;
 	lp->pdev.name = DRIVER_NAME;
-	platform_device_register(&lp->pdev);
+	if (platform_device_register(&lp->pdev))
+		goto err_free_netdev;
 	SET_NETDEV_DEV(dev, &lp->pdev.dev);
 
 	dev->netdev_ops = &iss_netdev_ops;
@@ -536,23 +537,21 @@ static int iss_net_configure(int index, char *init)
 	dev->irq = -1;
 
 	rtnl_lock();
-	err = register_netdevice(dev);
-	rtnl_unlock();
-
-	if (err) {
+	if (register_netdevice(dev)) {
+		rtnl_unlock();
 		pr_err("%s: error registering net device!\n", dev->name);
-		/* XXX: should we call ->remove() here? */
-		free_netdev(dev);
-		return 1;
+		goto err_unregister_device;
 	}
+	rtnl_unlock();
 
 	timer_setup(&lp->tl, iss_net_user_timer_expire, 0);
 
-	return 0;
+	return;
 
-errout:
-	/* FIXME: unregister; free, etc.. */
-	return -EIO;
+err_unregister_device:
+	platform_device_unregister(&lp->pdev);
+err_free_netdev:
+	free_netdev(dev);
 }
 
 /* ------------------------------------------------------------------------- */
-- 
2.25.1

