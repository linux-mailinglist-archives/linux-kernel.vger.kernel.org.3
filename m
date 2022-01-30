Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8190C4A350C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 09:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbiA3IGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 03:06:45 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:64711 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238784AbiA3IGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 03:06:43 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id E5ENnTKm7uCn2E5EOn1iwB; Sun, 30 Jan 2022 09:06:41 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 30 Jan 2022 09:06:41 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        patches@opensource.cirrus.com, linux-input@vger.kernel.org
Subject: [PATCH] Input: wm97xx: Simplify resource management
Date:   Sun, 30 Jan 2022 09:06:36 +0100
Message-Id: <87dce7e80ea9b191843fa22415ca3aef5f3cc2e6.1643529968.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit in the Fixes tag below, 'wm->input_dev' is a managed
resource that doesn't need to be explicitly unregistered or freed (see
devm_input_allocate_device() documentation)

So, remove some unless line of code to slightly simplify it.

Fixes: c72f61e74073 ("Input: wm97xx: split out touchscreen registering")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/input/touchscreen/wm97xx-core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 78d2ee99f37a..1b58611c8084 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -615,10 +615,9 @@ static int wm97xx_register_touch(struct wm97xx *wm)
 	 * extensions)
 	 */
 	wm->touch_dev = platform_device_alloc("wm97xx-touch", -1);
-	if (!wm->touch_dev) {
-		ret = -ENOMEM;
-		goto touch_err;
-	}
+	if (!wm->touch_dev)
+		return -ENOMEM;
+
 	platform_set_drvdata(wm->touch_dev, wm);
 	wm->touch_dev->dev.parent = wm->dev;
 	wm->touch_dev->dev.platform_data = pdata;
@@ -629,9 +628,6 @@ static int wm97xx_register_touch(struct wm97xx *wm)
 	return 0;
 touch_reg_err:
 	platform_device_put(wm->touch_dev);
-touch_err:
-	input_unregister_device(wm->input_dev);
-	wm->input_dev = NULL;
 
 	return ret;
 }
@@ -639,8 +635,6 @@ static int wm97xx_register_touch(struct wm97xx *wm)
 static void wm97xx_unregister_touch(struct wm97xx *wm)
 {
 	platform_device_unregister(wm->touch_dev);
-	input_unregister_device(wm->input_dev);
-	wm->input_dev = NULL;
 }
 
 static int _wm97xx_probe(struct wm97xx *wm)
-- 
2.32.0

