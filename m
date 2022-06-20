Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02A9551307
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbiFTIkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbiFTIkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:40:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846F412AC8;
        Mon, 20 Jun 2022 01:40:45 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LRNLT1l8Sz9226;
        Mon, 20 Jun 2022 16:37:21 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 16:40:10 +0800
Received: from huawei.com (10.175.112.208) by dggpemm500019.china.huawei.com
 (7.185.36.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 20 Jun
 2022 16:40:10 +0800
From:   Jian Zhang <zhangjian210@huawei.com>
To:     <mirela.rabulea@nxp.com>, <mchehab@kernel.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <xuqiang36@huawei.com>
Subject: [-next] driver/nxp/imx-jpeg: fix a unexpected return value problem
Date:   Mon, 20 Jun 2022 08:34:23 +0000
Message-ID: <20220620083423.35794-1-zhangjian210@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function mxc_jpeg_probe(), when devm_clk_get() fail, the return value
will be unexpected, and it should be the devm_clk_get's error code.

Fixes: 4c2e5156d9fa6 ("media: imx-jpeg: Add pm-runtime support for imx-jpeg")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jian Zhang <zhangjian210@huawei.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 965021d3c7ef..cad6bf03236f 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -2211,12 +2211,14 @@ static int mxc_jpeg_probe(struct platform_device *pdev)
 	jpeg->clk_ipg = devm_clk_get(dev, "ipg");
 	if (IS_ERR(jpeg->clk_ipg)) {
 		dev_err(dev, "failed to get clock: ipg\n");
+		ret = PTR_ERR(jpeg->clk_ipg);
 		goto err_clk;
 	}
 
 	jpeg->clk_per = devm_clk_get(dev, "per");
 	if (IS_ERR(jpeg->clk_per)) {
 		dev_err(dev, "failed to get clock: per\n");
+		ret = PTR_ERR(jpeg->clk_per);
 		goto err_clk;
 	}
 
-- 
2.17.1

