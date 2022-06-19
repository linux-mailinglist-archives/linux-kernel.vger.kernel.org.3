Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163E555095C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 10:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbiFSI1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 04:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbiFSI1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 04:27:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F12101D5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 01:27:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2qGq-0000vI-27; Sun, 19 Jun 2022 10:27:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2qGm-001Pei-Pj; Sun, 19 Jun 2022 10:26:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2qGn-00HL5i-CB; Sun, 19 Jun 2022 10:26:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2] mfd: tc6393xb: Make disable callback return void
Date:   Sun, 19 Jun 2022 10:26:55 +0200
Message-Id: <20220619082655.53728-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3352; h=from:subject; bh=QcG/lGXnOjIWCwX7NwPpX+wFhZqNqAPKZqwjF3eG2jg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBirt3MF4sDfnzfsCZA316+4ajoIIYxY1O0vKvMFgj0 MyCYCUqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYq7dzAAKCRDB/BR4rcrsCSizB/ 0eGA2TFnxdfWkGCNuM85iSHuCz0/26gTA+ST7wYmGmCZRKxx1xPgpDAyz+h2jVLm2pBRFu/q1P+Txk 7i+094Em9VyITMTUdvf6sn0AChu5nj4WUlRYxFP6Xd6n/Fd7RjfUQZk32rQnhLXQ5amTQ7hIN1TuHl eV4GTp1MyoKgy2tu4xI3Mk/urdos/TPqrQn+ZFtIBYUOFtr4Re/gs/vKTs8xZ3+SVxGxdpUPgCG40j 720VKHwH72gkc+ZQWwmXdgdaxO15Gtzey4tKDIA5XZCd5Gmh15KvyWNeC4wFq24pxz9UjMvDyfN8PU 0w2qdrlAr5niNF22Icpbq7uig6BDlq
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
Hello,

compared to (implicit) v1
(https://lore.kernel.org/r/20220530192430.2108217-5-u.kleine-koenig@pengutronix.de)
this is rebased to v5.19-rc1. Up to now there is only a single patch in
next (next-20220617) since -rc1 touching one of the files:

	0fdebc5ec2ca ("treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_56.RULE (part 1)")

I don't expect any conflicts that need manual intervention.

Best regards
Uwe

 arch/arm/mach-pxa/eseries.c  | 3 +--
 arch/arm/mach-pxa/tosa.c     | 4 +---
 drivers/mfd/tc6393xb.c       | 5 ++---
 include/linux/mfd/tc6393xb.h | 2 +-
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index 08f8737aa8fd..114f0baf087f 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -86,11 +86,10 @@ int eseries_tmio_enable(struct platform_device *dev)
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
index 6af8bc404825..d41641d6cfcd 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -678,13 +678,11 @@ static int tosa_tc6393xb_enable(struct platform_device *dev)
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
index 0be5731685b4..aa903a31dd43 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -798,20 +798,19 @@ static int tc6393xb_remove(struct platform_device *dev)
 {
 	struct tc6393xb_platform_data *tcpd = dev_get_platdata(&dev->dev);
 	struct tc6393xb *tc6393xb = platform_get_drvdata(dev);
-	int ret;
 
 	mfd_remove_devices(&dev->dev);
 
 	tc6393xb_detach_irq(dev);
 
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
index d336c541b7df..d17807f2d0c9 100644
--- a/include/linux/mfd/tc6393xb.h
+++ b/include/linux/mfd/tc6393xb.h
@@ -22,7 +22,7 @@ struct tc6393xb_platform_data {
 	u16	scr_gper;	/* GP Enable */
 
 	int	(*enable)(struct platform_device *dev);
-	int	(*disable)(struct platform_device *dev);
+	void	(*disable)(struct platform_device *dev);
 	int	(*suspend)(struct platform_device *dev);
 	int	(*resume)(struct platform_device *dev);
 

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

