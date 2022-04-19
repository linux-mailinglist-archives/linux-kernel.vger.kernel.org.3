Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F5D507598
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351608AbiDSQvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354693AbiDSQpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:45:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C0F36152;
        Tue, 19 Apr 2022 09:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59CF9B81BBC;
        Tue, 19 Apr 2022 16:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB59C385AE;
        Tue, 19 Apr 2022 16:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386567;
        bh=XRVRts6/PmPxgnBeeTopOk8hsXuEnYK24eY44iFBTjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SrYcNU0XHeFfz9FFmwRnhtwk5VI3KPUyVVYDZ1vZsf/9ibd4zLruL0iYjAxUyiwgp
         zmOuXhLr4WTdOB1309oLHotg6wtk/R/duI+zVweeCWm3uDXswBZIZxB7bVKunqu/CC
         EdMhLyLGmp315u6yW24LoEVof2mtuD5mi09URRw/1IqaKVlqShBeopuwMcloOvibS8
         PU5fwThkpiXRfLrjJtNm+iH3D7eSCFQGuRvIg5P1RDAEYLIRMmxDeXbThxhNRZi323
         coE08BVk9QZsh8XR9qGt6reyxhJbZKJAWfaiL1ui30TgqLeVpFNIO7Y6/vA2Fm0la6
         XCHr2bVGVwWJA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 30/48] Input: wm97xx - get rid of irq_enable method in wm97xx_mach_ops
Date:   Tue, 19 Apr 2022 18:37:52 +0200
Message-Id: <20220419163810.2118169-31-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220419163810.2118169-1-arnd@kernel.org>
References: <20220419163810.2118169-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Now that we are using oneshot threaded IRQ this method is not used anymore.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[arnd: add the db1300 change as well]
Cc: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/alchemy/devboards/db1300.c         | 9 ---------
 drivers/input/touchscreen/mainstone-wm97xx.c | 9 ---------
 drivers/input/touchscreen/zylonite-wm97xx.c  | 9 ---------
 include/linux/wm97xx.h                       | 3 ---
 4 files changed, 30 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index cd72eaa1168f..e70e529ddd91 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -732,16 +732,7 @@ static struct platform_device db1300_lcd_dev = {
 /**********************************************************************/
 
 #if IS_ENABLED(CONFIG_TOUCHSCREEN_WM97XX)
-static void db1300_wm97xx_irqen(struct wm97xx *wm, int enable)
-{
-	if (enable)
-		enable_irq(DB1300_AC97_PEN_INT);
-	else
-		disable_irq_nosync(DB1300_AC97_PEN_INT);
-}
-
 static struct wm97xx_mach_ops db1300_wm97xx_ops = {
-	.irq_enable	= db1300_wm97xx_irqen,
 	.irq_gpio	= WM97XX_GPIO_3,
 };
 
diff --git a/drivers/input/touchscreen/mainstone-wm97xx.c b/drivers/input/touchscreen/mainstone-wm97xx.c
index 8f6fe68f1f99..c39f49720fe4 100644
--- a/drivers/input/touchscreen/mainstone-wm97xx.c
+++ b/drivers/input/touchscreen/mainstone-wm97xx.c
@@ -246,21 +246,12 @@ static void wm97xx_acc_shutdown(struct wm97xx *wm)
 	}
 }
 
-static void wm97xx_irq_enable(struct wm97xx *wm, int enable)
-{
-	if (enable)
-		enable_irq(wm->pen_irq);
-	else
-		disable_irq_nosync(wm->pen_irq);
-}
-
 static struct wm97xx_mach_ops mainstone_mach_ops = {
 	.acc_enabled	= 1,
 	.acc_pen_up	= wm97xx_acc_pen_up,
 	.acc_pen_down	= wm97xx_acc_pen_down,
 	.acc_startup	= wm97xx_acc_startup,
 	.acc_shutdown	= wm97xx_acc_shutdown,
-	.irq_enable	= wm97xx_irq_enable,
 	.irq_gpio	= WM97XX_GPIO_2,
 };
 
diff --git a/drivers/input/touchscreen/zylonite-wm97xx.c b/drivers/input/touchscreen/zylonite-wm97xx.c
index ed7eae638713..a70fe4abe520 100644
--- a/drivers/input/touchscreen/zylonite-wm97xx.c
+++ b/drivers/input/touchscreen/zylonite-wm97xx.c
@@ -160,20 +160,11 @@ static int wm97xx_acc_startup(struct wm97xx *wm)
 	return 0;
 }
 
-static void wm97xx_irq_enable(struct wm97xx *wm, int enable)
-{
-	if (enable)
-		enable_irq(wm->pen_irq);
-	else
-		disable_irq_nosync(wm->pen_irq);
-}
-
 static struct wm97xx_mach_ops zylonite_mach_ops = {
 	.acc_enabled	= 1,
 	.acc_pen_up	= wm97xx_acc_pen_up,
 	.acc_pen_down	= wm97xx_acc_pen_down,
 	.acc_startup	= wm97xx_acc_startup,
-	.irq_enable	= wm97xx_irq_enable,
 	.irq_gpio	= WM97XX_GPIO_2,
 };
 
diff --git a/include/linux/wm97xx.h b/include/linux/wm97xx.h
index 85bd8dd3caea..332d2b0f29b9 100644
--- a/include/linux/wm97xx.h
+++ b/include/linux/wm97xx.h
@@ -254,9 +254,6 @@ struct wm97xx_mach_ops {
 	int (*acc_startup) (struct wm97xx *);
 	void (*acc_shutdown) (struct wm97xx *);
 
-	/* interrupt mask control - required for accelerated operation */
-	void (*irq_enable) (struct wm97xx *, int enable);
-
 	/* GPIO pin used for accelerated operation */
 	int irq_gpio;
 
-- 
2.29.2

