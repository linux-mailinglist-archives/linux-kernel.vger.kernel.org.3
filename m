Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3586550B364
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445754AbiDVJDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445688AbiDVJDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:03:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948B143EF3;
        Fri, 22 Apr 2022 02:00:07 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kl7d231jhz1J9wc;
        Fri, 22 Apr 2022 16:59:18 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 17:00:04 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 17:00:04 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC:     <linux@roeck-us.net>, <jdelvare@suse.com>
Subject: [PATCH 02/20] hwmon: (abituguru3) check return value after calling platform_get_resource()
Date:   Fri, 22 Apr 2022 17:11:49 +0800
Message-ID: <20220422091207.4034406-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422091207.4034406-1-yangyingliang@huawei.com>
References: <20220422091207.4034406-1-yangyingliang@huawei.com>
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

It will cause null-ptr-deref if platform_get_resource() returns NULL,
we need check the return value.

Fixes: 3faa1ffb4f4b ("hwmon: Add support for newer uGuru's")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/hwmon/abituguru3.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index 8229ad30c909..7abce72f3b48 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -964,13 +964,17 @@ static int abituguru3_probe(struct platform_device *pdev)
 	char *sysfs_filename;
 	u8 buf[2];
 	u16 id;
+	struct resource *r;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(struct abituguru3_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->addr = platform_get_resource(pdev, IORESOURCE_IO, 0)->start;
+	r =  platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!r)
+		return -EINVAL;
+	data->addr = r->start;
 	mutex_init(&data->update_lock);
 	platform_set_drvdata(pdev, data);
 
-- 
2.25.1

