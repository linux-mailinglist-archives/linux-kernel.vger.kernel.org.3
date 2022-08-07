Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D667E58B9D6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 08:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiHGGni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 02:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiHGGnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 02:43:35 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E44B10548
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 23:43:34 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Ka0YohQK6gtndKa0ZoYPTF; Sun, 07 Aug 2022 08:43:32 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 07 Aug 2022 08:43:32 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: ov8865: Fix an error handling path in ov8865_probe()
Date:   Sun,  7 Aug 2022 08:43:29 +0200
Message-Id: <5f84057db4f6a0d0fc50176a0ea5bf6c8a067cf0.1659854576.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit in Fixes also introduced some new error handling which should
goto the existing error handling path.
Otherwise some resources leak.

Fixes: 73dcffeb2ff9 ("media: i2c: Support 19.2MHz input clock in ov8865")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/i2c/ov8865.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov8865.c b/drivers/media/i2c/ov8865.c
index b8f4f0d3e33d..15d0f79231dd 100644
--- a/drivers/media/i2c/ov8865.c
+++ b/drivers/media/i2c/ov8865.c
@@ -3034,11 +3034,13 @@ static int ov8865_probe(struct i2c_client *client)
 				       &rate);
 	if (!ret && sensor->extclk) {
 		ret = clk_set_rate(sensor->extclk, rate);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "failed to set clock rate\n");
+		if (ret) {
+			dev_err_probe(dev, ret, "failed to set clock rate\n");
+			goto error_endpoint;
+		}
 	} else if (ret && !sensor->extclk) {
-		return dev_err_probe(dev, ret, "invalid clock config\n");
+		dev_err_probe(dev, ret, "invalid clock config\n");
+		goto error_endpoint;
 	}
 
 	sensor->extclk_rate = rate ? rate : clk_get_rate(sensor->extclk);
-- 
2.34.1

