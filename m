Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1725AEF32
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiIFPpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiIFPop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:44:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3BB7DF47;
        Tue,  6 Sep 2022 07:55:06 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MMSTd0nGMz1P6lL;
        Tue,  6 Sep 2022 22:30:13 +0800 (CST)
Received: from huawei.com (10.67.174.96) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 6 Sep
 2022 22:34:00 +0800
From:   Zhang Jianhua <chris.zjh@huawei.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <rasmus.villemoes@prevas.dk>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] rtc: fsl-ftm-alarm: Use module_platform_driver replace device_initcall
Date:   Tue, 6 Sep 2022 22:30:37 +0800
Message-ID: <20220906143037.1455317-1-chris.zjh@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.96]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

The ftm_rtc_driver has been registered while module init, however there
is not unregister step for module exit, now use the macro
module_platform_driver replace device_initcall, which can register and
unregister platform driver automatically.

Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
---
 drivers/rtc/rtc-fsl-ftm-alarm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-fsl-ftm-alarm.c b/drivers/rtc/rtc-fsl-ftm-alarm.c
index c0df49fb978c..3d7c4077fe1c 100644
--- a/drivers/rtc/rtc-fsl-ftm-alarm.c
+++ b/drivers/rtc/rtc-fsl-ftm-alarm.c
@@ -327,12 +327,7 @@ static struct platform_driver ftm_rtc_driver = {
 	},
 };
 
-static int __init ftm_alarm_init(void)
-{
-	return platform_driver_register(&ftm_rtc_driver);
-}
-
-device_initcall(ftm_alarm_init);
+module_platform_driver(ftm_rtc_driver);
 
 MODULE_DESCRIPTION("NXP/Freescale FlexTimer alarm driver");
 MODULE_AUTHOR("Biwen Li <biwen.li@nxp.com>");
-- 
2.31.0

