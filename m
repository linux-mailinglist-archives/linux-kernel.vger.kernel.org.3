Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C7C5387BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 21:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242979AbiE3TZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 15:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbiE3TZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 15:25:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1902AF0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 12:25:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvl0i-0002B8-4P; Mon, 30 May 2022 21:25:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvl0i-005Vcu-Of; Mon, 30 May 2022 21:25:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvl0g-00D9s2-DX; Mon, 30 May 2022 21:25:02 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] mfd: tc6393xb: Make disable callback return void
Date:   Mon, 30 May 2022 21:24:30 +0200
Message-Id: <20220530192430.2108217-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530192430.2108217-1-u.kleine-koenig@pengutronix.de>
References: <20220530192430.2108217-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2970; h=from:subject; bh=f/Kbd6S1TkQ8db5BjGINURGo9N9WQ2gxpBhEfpvdF2A=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBilRnj8N5AiR1ecmr6JmPbpwgdH//GPbgtCPqHxS0E 1m0q2+2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYpUZ4wAKCRDB/BR4rcrsCfm2B/ 9QvlkDId2uuzHUmtJZOesyOeUguhTboadbdEaMSkTQq3o0LNcPfE4tZhFKvavlYewNqgGBdO4ybNfm P04ccvy+RWljfOFnJs9szpLsLghOE6JNkj8ao0FyqVMToL6qpu9mVD51pu/gOVNk6X+dZuoCbl/iaB ZtJ5b/MDKqxx/AOBDawaUq/5w/lbsINhZbIcl7Lm3R/nXUH2LLD8ALZU5DxsD2tuaVELkybV7wjPXg pFovyBRqja0C660rBDde8QqJRBSDl+3rBqJLoRAJQMmZS6M30c3Z8TU5H7DeHKak5aaQiCaABz/4yh qqh5VwYqm90YhlV42C85xpA5l75C/Q
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All implementations return 0, so simplify accordingly.

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-pxa/eseries.c  | 3 +--
 arch/arm/mach-pxa/tosa.c     | 4 +---
 drivers/mfd/tc6393xb.c       | 5 ++---
 include/linux/mfd/tc6393xb.h | 2 +-
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index cb7bf6294e12..c0b496300e3f 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -85,11 +85,10 @@ int eseries_tmio_enable(struct platform_device *dev)
 	return 0;
 }
 
-int eseries_tmio_disable(struct platform_device *dev)
+void eseries_tmio_disable(struct platform_device *dev)
 {
 	gpio_set_value(GPIO_ESERIES_TMIO_SUSPEND, 0);
 	gpio_set_value(GPIO_ESERIES_TMIO_PCLR, 0);
-	return 0;
 }
 
 int eseries_tmio_suspend(struct platform_device *dev)
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 431709725d02..8d97c0d74e8f 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -662,13 +662,11 @@ static int tosa_tc6393xb_enable(struct platform_device *dev)
 	return rc;
 }
 
-static int tosa_tc6393xb_disable(struct platform_device *dev)
+static void tosa_tc6393xb_disable(struct platform_device *dev)
 {
 	gpio_free(TOSA_GPIO_TC6393XB_L3V_ON);
 	gpio_free(TOSA_GPIO_TC6393XB_SUSPEND);
 	gpio_free(TOSA_GPIO_TC6393XB_REST_IN);
-
-	return 0;
 }
 
 static int tosa_tc6393xb_resume(struct platform_device *dev)
diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index 3d5b14c60e20..7de210f143de 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -734,7 +734,6 @@ static int tc6393xb_remove(struct platform_device *dev)
 {
 	struct tc6393xb_platform_data *tcpd = dev_get_platdata(&dev->dev);
 	struct tc6393xb *tc6393xb = platform_get_drvdata(dev);
-	int ret;
 
 	mfd_remove_devices(&dev->dev);
 
@@ -746,14 +745,14 @@ static int tc6393xb_remove(struct platform_device *dev)
 	if (tc6393xb->gpio.base != -1)
 		gpiochip_remove(&tc6393xb->gpio);
 
-	ret = tcpd->disable(dev);
+	tcpd->disable(dev);
 	clk_disable_unprepare(tc6393xb->clk);
 	iounmap(tc6393xb->scr);
 	release_resource(&tc6393xb->rscr);
 	clk_put(tc6393xb->clk);
 	kfree(tc6393xb);
 
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_PM
diff --git a/include/linux/mfd/tc6393xb.h b/include/linux/mfd/tc6393xb.h
index fcc8e74f0e8d..602b391ed13a 100644
--- a/include/linux/mfd/tc6393xb.h
+++ b/include/linux/mfd/tc6393xb.h
@@ -22,7 +22,7 @@ struct tc6393xb_platform_data {
 	u16	scr_gper;	/* GP Enable */
 
 	int	(*enable)(struct platform_device *dev);
-	int	(*disable)(struct platform_device *dev);
+	void	(*disable)(struct platform_device *dev);
 	int	(*suspend)(struct platform_device *dev);
 	int	(*resume)(struct platform_device *dev);
 
-- 
2.36.1

