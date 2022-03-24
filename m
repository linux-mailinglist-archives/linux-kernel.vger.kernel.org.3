Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C70D4E61D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349550AbiCXKgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiCXKgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:36:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA4D6E286;
        Thu, 24 Mar 2022 03:35:12 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KPM4P1P9Cz6H7KZ;
        Thu, 24 Mar 2022 18:32:53 +0800 (CST)
Received: from lhreml751-chm.china.huawei.com (10.201.108.201) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 24 Mar 2022 11:35:09 +0100
Received: from O84201547D.china.huawei.com (10.122.247.218) by
 lhreml751-chm.china.huawei.com (10.201.108.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 10:35:09 +0000
From:   Hesham Almatary <hesham.almatary@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <paul@crapouillou.net>, <rafael@kernel.org>, <amitk@kernel.org>,
        <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>
Subject: [PATCH] thermal:hisi_termal: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date:   Thu, 24 Mar 2022 10:34:43 +0000
Message-ID: <20220324103443.4563-1-hesham.almatary@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.218]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml751-chm.china.huawei.com (10.201.108.201)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaning up the driver to use pm_sleep_ptr() macro instead of #ifdef
guards is simpler and allows the compiler to remove those functions
if built without CONFIG_PM_SLEEP support.

Signed-off-by: Hesham Almatary <hesham.almatary@huawei.com>
---
 drivers/thermal/hisi_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 9a21ac0ceb11..b29ab09040d5 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -629,7 +629,6 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int hisi_thermal_suspend(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
@@ -651,15 +650,14 @@ static int hisi_thermal_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(hisi_thermal_pm_ops,
+static DEFINE_SIMPLE_DEV_PM_OPS(hisi_thermal_pm_ops,
 			 hisi_thermal_suspend, hisi_thermal_resume);
 
 static struct platform_driver hisi_thermal_driver = {
 	.driver = {
 		.name		= "hisi_thermal",
-		.pm		= &hisi_thermal_pm_ops,
+		.pm		= pm_sleep_ptr(&hisi_thermal_pm_ops),
 		.of_match_table = of_hisi_thermal_match,
 	},
 	.probe	= hisi_thermal_probe,
-- 
2.25.1

