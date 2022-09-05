Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515545ACADB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiIEG3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiIEG3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:29:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02615BCD;
        Sun,  4 Sep 2022 23:29:37 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MLdn90ZMdzkWx7;
        Mon,  5 Sep 2022 14:25:49 +0800 (CST)
Received: from huawei.com (10.67.174.96) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 5 Sep
 2022 14:29:34 +0800
From:   Zhang Jianhua <chris.zjh@huawei.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <chris.zjh@huawei.com>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v3] rtc: fsl-ftm-alarm: Use module_init and add module_exit
Date:   Mon, 5 Sep 2022 14:26:13 +0800
Message-ID: <20220905062613.1119008-1-chris.zjh@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.96]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
v3:
- add semicolon after module_init and module_exit to keep the format
consistent
v2:
- modify the commit message for more accurate description
---
 drivers/rtc/rtc-fsl-ftm-alarm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-fsl-ftm-alarm.c b/drivers/rtc/rtc-fsl-ftm-alarm.c
index c0df49fb978c..7fabfc098299 100644
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
+module_init(ftm_alarm_init);
+module_exit(ftm_alarm_exit);
 
 MODULE_DESCRIPTION("NXP/Freescale FlexTimer alarm driver");
 MODULE_AUTHOR("Biwen Li <biwen.li@nxp.com>");
-- 
2.31.0

