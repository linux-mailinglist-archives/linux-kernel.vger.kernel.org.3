Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379F950B395
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445831AbiDVJE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445727AbiDVJDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:03:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BB95370A;
        Fri, 22 Apr 2022 02:00:13 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kl7dv2GNRzhY1b;
        Fri, 22 Apr 2022 17:00:03 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 17:00:07 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 17:00:07 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC:     <linux@roeck-us.net>, <jdelvare@suse.com>
Subject: [PATCH 11/20] hwmon: (sch5636) check return value after calling platform_get_resource()
Date:   Fri, 22 Apr 2022 17:11:58 +0800
Message-ID: <20220422091207.4034406-12-yangyingliang@huawei.com>
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

Fixes: 0772a6407939 ("hwmon: New driver sch5636")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/hwmon/sch5636.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/sch5636.c b/drivers/hwmon/sch5636.c
index 269757bc3a9e..6fc471168af8 100644
--- a/drivers/hwmon/sch5636.c
+++ b/drivers/hwmon/sch5636.c
@@ -394,13 +394,17 @@ static int sch5636_probe(struct platform_device *pdev)
 	struct sch5636_data *data;
 	int i, err, val, revision[2];
 	char id[4];
+	struct resource *res;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(struct sch5636_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->addr = platform_get_resource(pdev, IORESOURCE_IO, 0)->start;
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!res)
+		return -EINVAL;
+	data->addr = res->start;
 	mutex_init(&data->update_lock);
 	platform_set_drvdata(pdev, data);
 
-- 
2.25.1

