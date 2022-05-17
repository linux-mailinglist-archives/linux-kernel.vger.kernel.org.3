Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F4A52995F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbiEQGNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiEQGNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:13:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544C843EFD;
        Mon, 16 May 2022 23:13:10 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L2Ql461qjzhZH2;
        Tue, 17 May 2022 14:12:32 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 14:13:07 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 14:13:06 +0800
From:   keliu <liuke94@huawei.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH 2/2] hwmon: Directly use ida_alloc()/free()
Date:   Tue, 17 May 2022 06:31:26 +0000
Message-ID: <20220517063126.2142637-2-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517063126.2142637-1-liuke94@huawei.com>
References: <20220517063126.2142637-1-liuke94@huawei.com>
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
 drivers/hwmon/ibmaem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index de6baf6ca3d1..5c4cf742f5ae 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -482,7 +482,7 @@ static void aem_delete(struct aem_data *data)
 	ipmi_destroy_user(data->ipmi.user);
 	platform_set_drvdata(data->pdev, NULL);
 	platform_device_unregister(data->pdev);
-	ida_simple_remove(&aem_ida, data->id);
+	ida_free(&aem_ida, data->id);
 	kfree(data);
 }
 
@@ -539,7 +539,7 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
 		data->power_period[i] = AEM_DEFAULT_POWER_INTERVAL;
 
 	/* Create sub-device for this fw instance */
-	data->id = ida_simple_get(&aem_ida, 0, 0, GFP_KERNEL);
+	data->id = ida_alloc(&aem_ida, GFP_KERNEL);
 	if (data->id < 0)
 		goto id_err;
 
@@ -600,7 +600,7 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
 	platform_set_drvdata(data->pdev, NULL);
 	platform_device_unregister(data->pdev);
 dev_err:
-	ida_simple_remove(&aem_ida, data->id);
+	ida_free(&aem_ida, data->id);
 id_err:
 	kfree(data);
 
@@ -679,7 +679,7 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
 		data->power_period[i] = AEM_DEFAULT_POWER_INTERVAL;
 
 	/* Create sub-device for this fw instance */
-	data->id = ida_simple_get(&aem_ida, 0, 0, GFP_KERNEL);
+	data->id = ida_alloc(&aem_ida, GFP_KERNEL);
 	if (data->id < 0)
 		goto id_err;
 
@@ -740,7 +740,7 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
 	platform_set_drvdata(data->pdev, NULL);
 	platform_device_unregister(data->pdev);
 dev_err:
-	ida_simple_remove(&aem_ida, data->id);
+	ida_free(&aem_ida, data->id);
 id_err:
 	kfree(data);
 
-- 
2.25.1

