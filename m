Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2E04B39FA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 08:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiBMHlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 02:41:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbiBMHlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 02:41:51 -0500
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6613033B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 23:41:44 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id J9VsnUjWKSDrIJ9VtnIP2o; Sun, 13 Feb 2022 08:41:42 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 13 Feb 2022 08:41:42 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] backlight: backlight: Slighly simplify devm_of_find_backlight()
Date:   Sun, 13 Feb 2022 08:41:39 +0100
Message-Id: <f998a4291d865273afa0d1f85764a9ac7fbc1b64.1644738084.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_add_action_or_reset() instead of devm_add_action()+hand writing
what is done in the release function, should an error occur.

This is more straightforward and saves a few lines of code.

While at it, remove a useless test in devm_backlight_release(). 'data' is
known to be not NULL when this function is called.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/backlight/backlight.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 4ae6fae94ac2..b788ff3d0f45 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -710,8 +710,7 @@ static void devm_backlight_release(void *data)
 {
 	struct backlight_device *bd = data;
 
-	if (bd)
-		put_device(&bd->dev);
+	put_device(&bd->dev);
 }
 
 /**
@@ -737,11 +736,10 @@ struct backlight_device *devm_of_find_backlight(struct device *dev)
 	bd = of_find_backlight(dev);
 	if (IS_ERR_OR_NULL(bd))
 		return bd;
-	ret = devm_add_action(dev, devm_backlight_release, bd);
-	if (ret) {
-		put_device(&bd->dev);
+	ret = devm_add_action_or_reset(dev, devm_backlight_release, bd);
+	if (ret)
 		return ERR_PTR(ret);
-	}
+
 	return bd;
 }
 EXPORT_SYMBOL(devm_of_find_backlight);
-- 
2.32.0

