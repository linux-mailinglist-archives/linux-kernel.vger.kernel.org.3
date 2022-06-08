Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5F9542B85
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbiFHJ0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbiFHJZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:25:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EC6A1BC;
        Wed,  8 Jun 2022 01:51:16 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LJ18L2DV9zRj2b;
        Wed,  8 Jun 2022 16:48:02 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 16:51:14 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 16:51:14 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>, <dev_public@wujek.eu>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] hwmon: (pmbus) fix build error unused-function
Date:   Wed, 8 Jun 2022 16:49:38 +0800
Message-ID: <20220608084938.173071-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

To fix building warning, wrap all related code with CONFIG_DEBUG_F.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: c3ffc3a1ff83("hwmon: (pmbus) add a function to check the presence of a block register")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 56 ++++++++++++++++----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 809e666cb52b..2c68ab1fe697 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -441,18 +441,6 @@ int pmbus_update_byte_data(struct i2c_client *client, int page, u8 reg,
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_update_byte_data, PMBUS);
 
-static int pmbus_read_block_data(struct i2c_client *client, int page, u8 reg,
-				 char *data_buf)
-{
-	int rv;
-
-	rv = pmbus_set_page(client, page, 0xff);
-	if (rv < 0)
-		return rv;
-
-	return i2c_smbus_read_block_data(client, reg, data_buf);
-}
-
 static struct pmbus_sensor *pmbus_find_sensor(struct pmbus_data *data, int page,
 					      int reg)
 {
@@ -590,22 +578,6 @@ bool pmbus_check_word_register(struct i2c_client *client, int page, int reg)
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_check_word_register, PMBUS);
 
-static bool pmbus_check_block_register(struct i2c_client *client, int page,
-				       int reg)
-{
-	int rv;
-	struct pmbus_data *data = i2c_get_clientdata(client);
-	char data_buf[I2C_SMBUS_BLOCK_MAX + 2];
-
-	rv = pmbus_read_block_data(client, page, reg, data_buf);
-	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
-		rv = pmbus_check_status_cml(client);
-	if (rv < 0 && (data->flags & PMBUS_READ_STATUS_AFTER_FAILED_CHECK))
-		data->read_status(client, -1);
-	pmbus_clear_fault_page(client, -1);
-	return rv >= 0;
-}
-
 const struct pmbus_driver_info *pmbus_get_driver_info(struct i2c_client *client)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
@@ -2961,6 +2933,34 @@ static int pmbus_regulator_register(struct pmbus_data *data)
 static struct dentry *pmbus_debugfs_dir;	/* pmbus debugfs directory */
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
+static int pmbus_read_block_data(struct i2c_client *client, int page, u8 reg,
+				 char *data_buf)
+{
+	int rv;
+
+	rv = pmbus_set_page(client, page, 0xff);
+	if (rv < 0)
+		return rv;
+
+	return i2c_smbus_read_block_data(client, reg, data_buf);
+}
+
+static bool pmbus_check_block_register(struct i2c_client *client, int page,
+				       int reg)
+{
+	int rv;
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	char data_buf[I2C_SMBUS_BLOCK_MAX + 2];
+
+	rv = pmbus_read_block_data(client, page, reg, data_buf);
+	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
+		rv = pmbus_check_status_cml(client);
+	if (rv < 0 && (data->flags & PMBUS_READ_STATUS_AFTER_FAILED_CHECK))
+		data->read_status(client, -1);
+	pmbus_clear_fault_page(client, -1);
+	return rv >= 0;
+}
+
 static int pmbus_debugfs_get(void *data, u64 *val)
 {
 	int rc;
-- 
2.17.1

