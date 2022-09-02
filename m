Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2651B5AA94A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiIBH7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiIBH6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:58:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3A9BD77B;
        Fri,  2 Sep 2022 00:58:47 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJqvn4Fq5zlWh8;
        Fri,  2 Sep 2022 15:55:17 +0800 (CST)
Received: from huawei.com (10.67.174.96) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 2 Sep
 2022 15:58:44 +0800
From:   Zhang Jianhua <chris.zjh@huawei.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <chris.zjh@huawei.com>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2] rtc: fsl-ftm-alarm: Use module_init and add module_exit
Date:   Fri, 2 Sep 2022 15:55:25 +0800
Message-ID: <20220902075525.379699-1-chris.zjh@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.96]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl-ftm-alarm driver can be built out of tree, so change the
macro device_initcall() to module_init() for standard usage.

fsl-ftm-alarm registers a platform driver in module_init function,
however there is no module_exit function to unregister it, and it will
occur resource leak, so add ftm_alarm_exit() function for module_exit.

Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
---
v2:
- modify the commit message for more accurate description
---
 drivers/rtc/rtc-fsl-ftm-alarm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-fsl-ftm-alarm.c b/drivers/rtc/rtc-fsl-ftm-alarm.c
index c0df49fb978c..28bdc6c97b64 100644
--- a/drivers/rtc/rtc-fsl-ftm-alarm.c
+++ b/drivers/rtc/rtc-fsl-ftm-alarm.c
@@ -332,7 +332,13 @@ static int __init ftm_alarm_init(void)
 	return platform_driver_register(&ftm_rtc_driver);
 }
 
-device_initcall(ftm_alarm_init);
+static void __exit ftm_alarm_exit(void)
+{
+	platform_driver_unregister(&ftm_rtc_driver);
+}
+
+module_init(ftm_alarm_init)
+module_exit(ftm_alarm_exit)
 
 MODULE_DESCRIPTION("NXP/Freescale FlexTimer alarm driver");
 MODULE_AUTHOR("Biwen Li <biwen.li@nxp.com>");
-- 
2.31.0

