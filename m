Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E585541C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356902AbiFVEcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356131AbiFVEcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:32:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5E435276;
        Tue, 21 Jun 2022 21:32:44 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LSVlK6RjVzSgyD;
        Wed, 22 Jun 2022 12:29:17 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 12:32:41 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 22 Jun
 2022 12:32:41 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
CC:     <mchehab@kernel.org>, <djrscally@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <sakari.ailus@linux.intel.com>
Subject: [PATCH -next v2] media: ov7251: add missing disable functions on error in ov7251_set_power_on()
Date:   Wed, 22 Jun 2022 12:42:43 +0800
Message-ID: <20220622044243.2900783-1-yangyingliang@huawei.com>
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

Add the missing gpiod_set_value_cansleep() and clk_disable_unprepare()
before return from ov7251_set_power_on() in the error handling case.

Fixes: 9e1d3012cc10 ("media: i2c: Remove .s_power() from ov7251")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v2:
  - add gpiod_set_value_cansleep()
  - also change the patch title and commit message
---
 drivers/media/i2c/ov7251.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
index 0e7be15bc20a..ad9689820ecc 100644
--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -934,6 +934,8 @@ static int ov7251_set_power_on(struct device *dev)
 					ARRAY_SIZE(ov7251_global_init_setting));
 	if (ret < 0) {
 		dev_err(ov7251->dev, "error during global init\n");
+		gpiod_set_value_cansleep(ov7251->enable_gpio, 0);
+		clk_disable_unprepare(ov7251->xclk);
 		ov7251_regulators_disable(ov7251);
 		return ret;
 	}
-- 
2.25.1

