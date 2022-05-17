Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96C65297C4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiEQDQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiEQDQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:16:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58736248F1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:16:42 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L2Lpc5dzXzcbVg;
        Tue, 17 May 2022 11:15:20 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 11:16:40 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <clement.leger@bootlin.com>, <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ARM: at91: pm: Fix rand build error
Date:   Tue, 17 May 2022 11:16:06 +0800
Message-ID: <20220517031606.11628-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ATMEL_PM is y but PM is n, build fails:

arch/arm/mach-at91/pm.c:1435:13: error: redefinition of ‘at91rm9200_pm_init’
 void __init at91rm9200_pm_init(void)
             ^~~~~~~~~~~~~~~~~~
In file included from arch/arm/mach-at91/pm.c:29:0:
arch/arm/mach-at91/generic.h:19:27: note: previous definition of ‘at91rm9200_pm_init’ was here
 static inline void __init at91rm9200_pm_init(void) { }
                           ^~~~~~~~~~~~~~~~~~

ATMEL_PM should not be enabled independently, it is only selected by Soc.

Fixes: f2f5cf78a333 ("ARM: at91: pm: add support for sama5d2 secure suspend")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/arm/mach-at91/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 3d7e66976206..3dd9e718661b 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -219,7 +219,7 @@ config SOC_SAMA5
 	select SRAM if PM
 
 config ATMEL_PM
-	bool "Atmel PM support"
+	bool
 
 config ATMEL_SECURE_PM
 	bool "Atmel Secure PM support"
-- 
2.17.1

