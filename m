Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C48596B43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiHQISO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbiHQISG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:18:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F036AA06
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:18:02 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M715W64QtzkWRY;
        Wed, 17 Aug 2022 16:14:39 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 16:18:00 +0800
Received: from huawei.com (10.67.174.169) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 17 Aug
 2022 16:18:00 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kbuild-all@lists.01.org>
CC:     <chenlifu@huawei.com>
Subject: [PATCH -next] ARM: mmp: Make some symbols static
Date:   Wed, 17 Aug 2022 16:14:20 +0800
Message-ID: <20220817081420.2106248-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These symbols pxa168_usb_phy_resources, pxa168_u2o_resources,
pxa168_u2oehci_resources and pxa168_u2ootg_resources are not used
outside of arch/arm/mach-mmp/devices.c, so mark them static.

Fixes the following sparse warning:

arch/arm/mach-mmp/devices.c:241:17: warning: symbol 'pxa168_usb_phy_resources' was not declared. Should it be static?
arch/arm/mach-mmp/devices.c:262:17: warning: symbol 'pxa168_u2o_resources' was not declared. Should it be static?
arch/arm/mach-mmp/devices.c:297:17: warning: symbol 'pxa168_u2oehci_resources' was not declared. Should it be static?
arch/arm/mach-mmp/devices.c:324:17: warning: symbol 'pxa168_u2ootg_resources' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 arch/arm/mach-mmp/devices.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index 79f4a2aa5475..9968239d8041 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -236,11 +236,11 @@ void pxa_usb_phy_deinit(void __iomem *phy_reg)
 
 #if IS_ENABLED(CONFIG_USB_SUPPORT)
 static u64 __maybe_unused usb_dma_mask = ~(u32)0;
 
 #if IS_ENABLED(CONFIG_PHY_PXA_USB)
-struct resource pxa168_usb_phy_resources[] = {
+static struct resource pxa168_usb_phy_resources[] = {
 	[0] = {
 		.start	= PXA168_U2O_PHYBASE,
 		.end	= PXA168_U2O_PHYBASE + USB_PHY_RANGE,
 		.flags	= IORESOURCE_MEM,
 	},
@@ -257,11 +257,11 @@ struct platform_device pxa168_device_usb_phy = {
 	}
 };
 #endif /* CONFIG_PHY_PXA_USB */
 
 #if IS_ENABLED(CONFIG_USB_MV_UDC)
-struct resource pxa168_u2o_resources[] = {
+static struct resource pxa168_u2o_resources[] = {
 	/* regbase */
 	[0] = {
 		.start	= PXA168_U2O_REGBASE + U2x_CAPREGS_OFFSET,
 		.end	= PXA168_U2O_REGBASE + USB_REG_RANGE,
 		.flags	= IORESOURCE_MEM,
@@ -292,11 +292,11 @@ struct platform_device pxa168_device_u2o = {
 	}
 };
 #endif /* CONFIG_USB_MV_UDC */
 
 #if IS_ENABLED(CONFIG_USB_EHCI_MV_U2O)
-struct resource pxa168_u2oehci_resources[] = {
+static struct resource pxa168_u2oehci_resources[] = {
 	[0] = {
 		.start	= PXA168_U2O_REGBASE,
 		.end	= PXA168_U2O_REGBASE + USB_REG_RANGE,
 		.flags	= IORESOURCE_MEM,
 	},
@@ -319,11 +319,11 @@ struct platform_device pxa168_device_u2oehci = {
 	.resource	= pxa168_u2oehci_resources,
 };
 #endif
 
 #if IS_ENABLED(CONFIG_USB_MV_OTG)
-struct resource pxa168_u2ootg_resources[] = {
+static struct resource pxa168_u2ootg_resources[] = {
 	/* regbase */
 	[0] = {
 		.start	= PXA168_U2O_REGBASE + U2x_CAPREGS_OFFSET,
 		.end	= PXA168_U2O_REGBASE + USB_REG_RANGE,
 		.flags	= IORESOURCE_MEM,
-- 
2.37.1

