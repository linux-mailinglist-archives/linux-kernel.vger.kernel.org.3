Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469725387B9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 21:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242305AbiE3TZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 15:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiE3TZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 15:25:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F2128E2F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 12:25:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvl0h-0002B5-TP; Mon, 30 May 2022 21:25:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvl0i-005Vco-I4; Mon, 30 May 2022 21:25:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvl0g-00D9rz-6q; Mon, 30 May 2022 21:25:02 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] mfd: tc6387xb: Drop disable callback that is never called
Date:   Mon, 30 May 2022 21:24:29 +0200
Message-Id: <20220530192430.2108217-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530192430.2108217-1-u.kleine-koenig@pengutronix.de>
References: <20220530192430.2108217-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; h=from:subject; bh=Xo82Zuy1oWrg9pa7SyqpFYQImVx3xnjtayADlWISXvI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBilRnaA70RpnGj5h60z0rwBwnCgtq/CvJUQD39bKTK 3hSUgcOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYpUZ2gAKCRDB/BR4rcrsCak0B/ 9pfaZ9CtRwVuS+vbTh+M9/0auq4zmf/TThyx9MXZZ7NmEukkJgdpPWgiSWlT6A8kJuVMXxahvUmQrk vctYRw8PzzMXoqzziOos/bqAPYgg6kyaWy97EXUrhjCXK65SLHx2cT9G84gh5VDV7G+pZpyLU5pmS+ 9OosuHxduqWgFNV2lPdTAbJOYMQTdhqHU1FMM3m7e00LT6HYonOvbmM2DWoR4cEuf8it1cQdlqNN94 26gt38s7Oklp+Mt4IlzpYCIWX92oKeFGuijukU63rs5qRnWyOCbpsT+SiVclqOZMGYi1pAKrUAO0AI AC9PLbReEkONyA90bm4ZfZYGF/USN6
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

The driver never calls the disable callback, so drop the member from
the platform struct and all callbacks from the actual platform datas.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-pxa/eseries.c  | 1 -
 include/linux/mfd/tc6387xb.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index f37c44b6139d..cb7bf6294e12 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -138,7 +138,6 @@ static void __init __maybe_unused eseries_register_clks(void)
 
 static struct tc6387xb_platform_data e330_tc6387xb_info = {
 	.enable   = &eseries_tmio_enable,
-	.disable  = &eseries_tmio_disable,
 	.suspend  = &eseries_tmio_suspend,
 	.resume   = &eseries_tmio_resume,
 };
diff --git a/include/linux/mfd/tc6387xb.h b/include/linux/mfd/tc6387xb.h
index b4888209494a..aacf1dcc86b9 100644
--- a/include/linux/mfd/tc6387xb.h
+++ b/include/linux/mfd/tc6387xb.h
@@ -12,7 +12,6 @@
 
 struct tc6387xb_platform_data {
 	int (*enable)(struct platform_device *dev);
-	int (*disable)(struct platform_device *dev);
 	int (*suspend)(struct platform_device *dev);
 	int (*resume)(struct platform_device *dev);
 };
-- 
2.36.1

