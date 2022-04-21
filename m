Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6CE509715
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384628AbiDUGAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbiDUGAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:00:43 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796B612ADD;
        Wed, 20 Apr 2022 22:57:54 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KkRdG3fCrz1J9vy;
        Thu, 21 Apr 2022 13:57:06 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500023.china.huawei.com
 (7.185.36.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 13:57:52 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <j.neuschaefer@gmx.net>, <linus.walleij@linaro.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wupeng58@huawei.com>,
        <liwei391@huawei.com>
Subject: [PATCH] pinctrl: nuvoton: Add missing fwnode_handle_put in wpcm450_gpio_register
Date:   Thu, 21 Apr 2022 05:53:56 +0000
Message-ID: <20220421055356.8163-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In one of the error paths of the device_for_each_child_node() loop
in wpcm450_gpio_register, add missing call to fwnode_handle_put.

Signed-off-by: Peng Wu <wupeng58@huawei.com>
---
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
index 0dbeb91f0bf2..de4388b512d7 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
@@ -1038,15 +1038,19 @@ static int wpcm450_gpio_register(struct platform_device *pdev,
 			continue;
 
 		ret = fwnode_property_read_u32(child, "reg", &reg);
-		if (ret < 0)
+		if (ret < 0) {
+			fwnode_handle_put(child);
 			return ret;
+		}
 
 		gpio = &pctrl->gpio_bank[reg];
 		gpio->pctrl = pctrl;
 
-		if (reg >= WPCM450_NUM_BANKS)
+		if (reg >= WPCM450_NUM_BANKS) {
+			fwnode_handle_put(child);
 			return dev_err_probe(dev, -EINVAL,
-					     "GPIO index %d out of range!\n", reg);
+					"GPIO index %d out of range!\n", reg);
+		}
 
 		bank = &wpcm450_banks[reg];
 		gpio->bank = bank;
@@ -1060,8 +1064,10 @@ static int wpcm450_gpio_register(struct platform_device *pdev,
 		}
 		ret = bgpio_init(&gpio->gc, dev, 4,
 				 dat, set, NULL, dirout, NULL, flags);
-		if (ret < 0)
+		if (ret < 0) {
+			fwnode_handle_put(child);
 			return dev_err_probe(dev, ret, "GPIO initialization failed\n");
+		}
 
 		gpio->gc.ngpio = bank->length;
 		gpio->gc.set_config = wpcm450_gpio_set_config;
@@ -1074,8 +1080,11 @@ static int wpcm450_gpio_register(struct platform_device *pdev,
 		girq->parent_handler = wpcm450_gpio_irqhandler;
 		girq->parents = devm_kcalloc(dev, WPCM450_NUM_GPIO_IRQS,
 					     sizeof(*girq->parents), GFP_KERNEL);
-		if (!girq->parents)
+		if (!girq->parents) {
+			fwnode_handle_put(child);
 			return -ENOMEM;
+		}
+
 		girq->default_type = IRQ_TYPE_NONE;
 		girq->handler = handle_bad_irq;
 
@@ -1091,8 +1100,10 @@ static int wpcm450_gpio_register(struct platform_device *pdev,
 		}
 
 		ret = devm_gpiochip_add_data(dev, &gpio->gc, gpio);
-		if (ret)
+		if (ret) {
+			fwnode_handle_put(child);
 			return dev_err_probe(dev, ret, "Failed to add GPIO chip\n");
+		}
 	}
 
 	return 0;
-- 
2.17.1

