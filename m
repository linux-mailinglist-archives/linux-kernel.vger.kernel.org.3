Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92BD52995D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbiEQGNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbiEQGNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:13:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F44443D4;
        Mon, 16 May 2022 23:13:02 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L2QhG5mv0zGpQh;
        Tue, 17 May 2022 14:10:06 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 14:13:00 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 14:12:59 +0800
From:   keliu <liuke94@huawei.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH 1/2] hwmon: Directly use ida_alloc()/free()
Date:   Tue, 17 May 2022 06:31:25 +0000
Message-ID: <20220517063126.2142637-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/hwmon/hwmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 22de7a9e7ba7..2e2cd79d89eb 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -764,7 +764,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 			 "hwmon: '%s' is not a valid name attribute, please fix\n",
 			 name);
 
-	id = ida_simple_get(&hwmon_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&hwmon_ida, GFP_KERNEL);
 	if (id < 0)
 		return ERR_PTR(id);
 
@@ -856,7 +856,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 free_hwmon:
 	hwmon_dev_release(hdev);
 ida_remove:
-	ida_simple_remove(&hwmon_ida, id);
+	ida_free(&hwmon_ida, id);
 	return ERR_PTR(err);
 }
 
@@ -968,7 +968,7 @@ void hwmon_device_unregister(struct device *dev)
 
 	if (likely(sscanf(dev_name(dev), HWMON_ID_FORMAT, &id) == 1)) {
 		device_unregister(dev);
-		ida_simple_remove(&hwmon_ida, id);
+		ida_free(&hwmon_ida, id);
 	} else
 		dev_dbg(dev->parent,
 			"hwmon_device_unregister() failed: bad class ID!\n");
-- 
2.25.1

