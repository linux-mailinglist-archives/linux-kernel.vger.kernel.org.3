Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014065A222D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245570AbiHZHpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245588AbiHZHoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:44:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C401AC2EBB;
        Fri, 26 Aug 2022 00:44:40 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MDWwd5bmdzkWYD;
        Fri, 26 Aug 2022 15:41:05 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 15:44:38 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 2/2] gpio: sim: make gpio simulator can be used as interrupt controller
Date:   Fri, 26 Aug 2022 08:02:30 +0000
Message-ID: <20220826080230.1712978-3-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220826080230.1712978-1-weiyongjun1@huawei.com>
References: <20220826080230.1712978-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices using GPIO as interrupt controller, such as mcp2515 CAN
device. To mockup those devices, gpio simulator should extend to be
used as interrupt controller form device tree.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpio/gpio-sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 1020c2feb249..f3cf6cec6207 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -398,7 +398,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (!chip->pull_map)
 		return -ENOMEM;
 
-	chip->irq_sim = devm_irq_domain_create_sim(dev, NULL, num_lines);
+	chip->irq_sim = devm_irq_domain_create_sim(dev, swnode, num_lines);
 	if (IS_ERR(chip->irq_sim))
 		return PTR_ERR(chip->irq_sim);
 
-- 
2.34.1

