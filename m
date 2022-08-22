Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC8659B829
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 05:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiHVDwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 23:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiHVDwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 23:52:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4860520F70;
        Sun, 21 Aug 2022 20:52:29 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M9yyh20Q2zkWVZ;
        Mon, 22 Aug 2022 11:49:00 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 22 Aug
 2022 11:52:26 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] gpio: mockup: remove gpio debugfs when remove device
Date:   Mon, 22 Aug 2022 04:10:25 +0000
Message-ID: <20220822041025.3221406-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.34.1
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

GPIO mockup debugfs is created in gpio_mockup_probe() but
forgot to remove when remove device. This patch add a devm
managed callback for removing them.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
v1 -> v2: return from devm_add_xx directly as Bartosz's suggestion
---
 drivers/gpio/gpio-mockup.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 8943cea92764..a2e505a7545c 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -373,6 +373,13 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 	}
 }
 
+static void gpio_mockup_debugfs_cleanup(void *data)
+{
+	struct gpio_mockup_chip *chip = data;
+
+	debugfs_remove_recursive(chip->dbg_dir);
+}
+
 static void gpio_mockup_dispose_mappings(void *data)
 {
 	struct gpio_mockup_chip *chip = data;
@@ -455,7 +462,7 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 
 	gpio_mockup_debugfs_setup(dev, chip);
 
-	return 0;
+	return devm_add_action_or_reset(dev, gpio_mockup_debugfs_cleanup, chip);
 }
 
 static const struct of_device_id gpio_mockup_of_match[] = {
-- 
2.34.1

