Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C2A504DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiDRI2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiDRI2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:28:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B87193C8;
        Mon, 18 Apr 2022 01:25:38 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Khg1802pbzFq2d;
        Mon, 18 Apr 2022 16:23:08 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 16:25:37 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 16:25:36 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <cy_huang@richtek.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] usb: typec: rt1719: Fix build error without CONFIG_POWER_SUPPLY 
Date:   Mon, 18 Apr 2022 16:24:25 +0800
Message-ID: <20220418082425.41566-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building without CONFIG_POWER_SUPPLY will fail:

drivers/usb/typec/rt1719.o: In function `rt1719_psy_set_property':
rt1719.c:(.text+0x10a): undefined reference to `power_supply_get_drvdata'
drivers/usb/typec/rt1719.o: In function `rt1719_psy_get_property':
rt1719.c:(.text+0x2c8): undefined reference to `power_supply_get_drvdata'
drivers/usb/typec/rt1719.o: In function `devm_rt1719_psy_register':
rt1719.c:(.text+0x3e9): undefined reference to `devm_power_supply_register'
drivers/usb/typec/rt1719.o: In function `rt1719_irq_handler':
rt1719.c:(.text+0xf9f): undefined reference to `power_supply_changed'
drivers/usb/typec/rt1719.o: In function `rt1719_update_pwr_opmode.part.9':
rt1719.c:(.text+0x657): undefined reference to `power_supply_changed'
drivers/usb/typec/rt1719.o: In function `rt1719_attach':
rt1719.c:(.text+0x83e): undefined reference to `power_supply_changed'

Add POWER_SUPPLY dependency to Kconfig.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 25d29b980912 ("usb: typec: rt1719: Add support for Richtek RT1719")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/usb/typec/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index 8f921213b17d..ba24847fb245 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -56,6 +56,7 @@ config TYPEC_RT1719
 	tristate "Richtek RT1719 Sink Only Type-C controller driver"
 	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
 	depends on I2C
+	depends on POWER_SUPPLY
 	select REGMAP_I2C
 	help
 	  Say Y or M here if your system has Richtek RT1719 sink only
-- 
2.17.1

