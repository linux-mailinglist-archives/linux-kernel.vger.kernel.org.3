Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D0055FC25
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiF2Jgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiF2Jgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:36:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384033B3E5;
        Wed, 29 Jun 2022 02:36:44 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LXxB96jkyz1L8dX;
        Wed, 29 Jun 2022 17:34:25 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 17:36:42 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 17:36:41 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
CC:     <a-govindraju@ti.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: [PATCH -next] usb: dwc3-am62: remove unnecesary clk_put()
Date:   Wed, 29 Jun 2022 17:46:35 +0800
Message-ID: <20220629094635.3116961-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

The clk get by devm_clk_get() will be released in devres_release_all(),
so there is no need explicitly call clk_put(), or it will cause UAF.

Fixes: e8784c0aec03 ("drivers: usb: dwc3: Add AM62 USB wrapper driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/usb/dwc3/dwc3-am62.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index fea7aca35dc8..173cf3579c55 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -195,8 +195,7 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 
 	if (i == ARRAY_SIZE(dwc3_ti_rate_table)) {
 		dev_err(dev, "unsupported usb2_refclk rate: %lu KHz\n", rate);
-		ret = -EINVAL;
-		goto err_clk_disable;
+		return -EINVAL;
 	}
 
 	data->rate_code = i;
@@ -204,7 +203,7 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	/* Read the syscon property and set the rate code */
 	ret = phy_syscon_pll_refclk(data);
 	if (ret)
-		goto err_clk_disable;
+		return ret;
 
 	/* VBUS divider select */
 	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
@@ -245,8 +244,6 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	clk_disable_unprepare(data->usb2_refclk);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-err_clk_disable:
-	clk_put(data->usb2_refclk);
 	return ret;
 }
 
@@ -276,7 +273,6 @@ static int dwc3_ti_remove(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 
-	clk_put(data->usb2_refclk);
 	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
-- 
2.25.1

