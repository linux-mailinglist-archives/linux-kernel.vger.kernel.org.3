Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBD15130A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiD1KGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiD1KGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:06:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C446739B9B;
        Thu, 28 Apr 2022 02:52:30 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KprVY5CL1zfb99;
        Thu, 28 Apr 2022 17:51:33 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 17:52:29 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 17:52:28 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
CC:     <pavel@ucw.cz>
Subject: [PATCH] leds: netxbig: add missing of_node_put() in netxbig_leds_get_of_pdata()
Date:   Thu, 28 Apr 2022 18:04:19 +0800
Message-ID: <20220428100419.543937-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing of_node_put() in error path in netxbig_leds_get_of_pdata().

Fixes: 9af512e81964 ("leds: netxbig: Convert to use GPIO descriptors")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/leds/leds-netxbig.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
index 77213b79f84d..6692de0af68f 100644
--- a/drivers/leds/leds-netxbig.c
+++ b/drivers/leds/leds-netxbig.c
@@ -440,6 +440,7 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 	}
 	gpio_ext_pdev = of_find_device_by_node(gpio_ext_np);
 	if (!gpio_ext_pdev) {
+		of_node_put(gpio_ext_np);
 		dev_err(dev, "Failed to find platform device for gpio-ext\n");
 		return -ENODEV;
 	}
-- 
2.25.1

