Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFE14F8223
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbiDGOvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344270AbiDGOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:51:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CF51C7E97
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:49:42 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KZ43V1YqLzFpZj;
        Thu,  7 Apr 2022 22:47:18 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 22:49:38 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 22:49:37 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/2] amba: Add amba_read_periphid() helper
Date:   Thu, 7 Apr 2022 23:02:39 +0800
Message-ID: <20220407150240.151166-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new amba_read_periphid() helper to simplify error handling.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/amba/bus.c | 133 +++++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 71 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index d3bd14aaabf6..0073d8ba0353 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -395,107 +395,98 @@ static void amba_device_release(struct device *dev)
 	kfree(d);
 }
 
-static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
+static int amba_read_periphid(struct amba_device *dev)
 {
-	u32 size;
+	struct reset_control *rstc;
+	u32 size, pid, cid;
 	void __iomem *tmp;
 	int i, ret;
 
-	ret = request_resource(parent, &dev->res);
+	ret = dev_pm_domain_attach(&dev->dev, true);
 	if (ret)
 		goto err_out;
 
-	/* Hard-coded primecell ID instead of plug-n-play */
-	if (dev->periphid != 0)
-		goto skip_probe;
+	ret = amba_get_enable_pclk(dev);
+	if (ret)
+		goto err_pm;
 
 	/*
-	 * Dynamically calculate the size of the resource
-	 * and use this for iomap
+	 * Find reset control(s) of the amba bus and de-assert them.
 	 */
+	rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
+	if (IS_ERR(rstc)) {
+		ret = PTR_ERR(rstc);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&dev->dev, "can't get reset: %d\n", ret);
+		goto err_clk;
+	}
+	reset_control_deassert(rstc);
+	reset_control_put(rstc);
+
 	size = resource_size(&dev->res);
 	tmp = ioremap(dev->res.start, size);
 	if (!tmp) {
 		ret = -ENOMEM;
-		goto err_release;
+		goto err_clk;
 	}
 
-	ret = dev_pm_domain_attach(&dev->dev, true);
-	if (ret) {
-		iounmap(tmp);
-		goto err_release;
-	}
-
-	ret = amba_get_enable_pclk(dev);
-	if (ret == 0) {
-		u32 pid, cid;
-		struct reset_control *rstc;
-
-		/*
-		 * Find reset control(s) of the amba bus and de-assert them.
-		 */
-		rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
-		if (IS_ERR(rstc)) {
-			ret = PTR_ERR(rstc);
-			if (ret != -EPROBE_DEFER)
-				dev_err(&dev->dev, "can't get reset: %d\n",
-					ret);
-			goto err_reset;
-		}
-		reset_control_deassert(rstc);
-		reset_control_put(rstc);
-
-		/*
-		 * Read pid and cid based on size of resource
-		 * they are located at end of region
-		 */
-		for (pid = 0, i = 0; i < 4; i++)
-			pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) <<
-				(i * 8);
-		for (cid = 0, i = 0; i < 4; i++)
-			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
-				(i * 8);
-
-		if (cid == CORESIGHT_CID) {
-			/* set the base to the start of the last 4k block */
-			void __iomem *csbase = tmp + size - 4096;
-
-			dev->uci.devarch =
-				readl(csbase + UCI_REG_DEVARCH_OFFSET);
-			dev->uci.devtype =
-				readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
-		}
+	/*
+	 * Read pid and cid based on size of resource
+	 * they are located at end of region
+	 */
+	for (pid = 0, i = 0; i < 4; i++)
+		pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) << (i * 8);
+	for (cid = 0, i = 0; i < 4; i++)
+		cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) << (i * 8);
 
-		amba_put_disable_pclk(dev);
+	if (cid == CORESIGHT_CID) {
+		/* set the base to the start of the last 4k block */
+		void __iomem *csbase = tmp + size - 4096;
 
-		if (cid == AMBA_CID || cid == CORESIGHT_CID) {
-			dev->periphid = pid;
-			dev->cid = cid;
-		}
+		dev->uci.devarch = readl(csbase + UCI_REG_DEVARCH_OFFSET);
+		dev->uci.devtype = readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
+	}
 
-		if (!dev->periphid)
-			ret = -ENODEV;
+	if (cid == AMBA_CID || cid == CORESIGHT_CID) {
+		dev->periphid = pid;
+		dev->cid = cid;
 	}
 
+	if (!dev->periphid)
+		ret = -ENODEV;
+
 	iounmap(tmp);
+
+err_clk:
+	amba_put_disable_pclk(dev);
+err_pm:
 	dev_pm_domain_detach(&dev->dev, true);
+err_out:
+	return ret;
+}
 
+static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
+{
+	int ret;
+
+	ret = request_resource(parent, &dev->res);
 	if (ret)
-		goto err_release;
+		goto err_out;
+
+	/* Hard-coded primecell ID instead of plug-n-play */
+	if (dev->periphid != 0)
+		goto skip_probe;
 
- skip_probe:
+	ret = amba_read_periphid(dev);
+	if (ret)
+		goto err_release;
+skip_probe:
 	ret = device_add(&dev->dev);
- err_release:
+err_release:
 	if (ret)
 		release_resource(&dev->res);
- err_out:
+err_out:
 	return ret;
-
- err_reset:
-	amba_put_disable_pclk(dev);
-	iounmap(tmp);
-	dev_pm_domain_detach(&dev->dev, true);
-	goto err_release;
 }
 
 /*
-- 
2.26.2

