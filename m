Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FD4544B46
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243818AbiFIMGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiFIMGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:06:30 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFF325BF99;
        Thu,  9 Jun 2022 05:06:23 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LJjSb52jyz1GCVm;
        Thu,  9 Jun 2022 20:04:31 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 20:06:21 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 9 Jun
 2022 20:06:21 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>, <dev_public@wujek.eu>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH v2 -next] hwmon: (pmbus) fix build error unused-function
Date:   Thu, 9 Jun 2022 20:04:48 +0800
Message-ID: <20220609120448.139907-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PMBUS is y and CONFIG_DEBUG_FS is not set.

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-, will be failed, like this:
drivers/hwmon/pmbus/pmbus_core.c:593:13: error: ‘pmbus_check_block_register’ defined but not used [-Werror=unused-function]
 static bool pmbus_check_block_register(struct i2c_client *client, int page,
             ^~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [drivers/hwmon/pmbus/pmbus_core.o] Error 1
make[2]: *** [drivers/hwmon/pmbus] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [drivers/hwmon] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2

To fix building warning, use __maybe_unused to attach this func.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: c3ffc3a1ff83("hwmon: (pmbus) add a function to check the presence of a block register")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
v2: use __maybe_unused to attach this function, which Guenter suggested.
---
 drivers/hwmon/pmbus/pmbus_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 809e666cb52b..e6d3a1118453 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -590,7 +590,7 @@ bool pmbus_check_word_register(struct i2c_client *client, int page, int reg)
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_check_word_register, PMBUS);
 
-static bool pmbus_check_block_register(struct i2c_client *client, int page,
+static bool __maybe_unused pmbus_check_block_register(struct i2c_client *client, int page,
 				       int reg)
 {
 	int rv;
-- 
2.17.1

