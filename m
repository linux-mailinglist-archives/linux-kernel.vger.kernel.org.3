Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4024A351B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 09:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354354AbiA3IOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 03:14:15 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:52358 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245345AbiA3IOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 03:14:11 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id E5LenTNY7uCn2E5Len1jfK; Sun, 30 Jan 2022 09:14:10 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 30 Jan 2022 09:14:10 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sachin Kamat <sachin.kamat@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-input@vger.kernel.org
Subject: [PATCH] Input: samsung-keypad - Simplify resource management
Date:   Sun, 30 Jan 2022 09:14:08 +0100
Message-Id: <8877b9db412fbeb3b43ba4a3ff6c4b39a5440c70.1643530436.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit in the Fixes tag below, 'keypad->input_dev' is a managed
resource that doesn't need to be explicitly unregistered or freed (see
devm_input_allocate_device() documentation)

So, remove some unless line of code to slightly simplify it.

Fixes: a57da3479545 ("Input: samsung-keypad - switch to using managed resources")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/input/keyboard/samsung-keypad.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index df0258dcf89e..b6c3c6399b2e 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -451,8 +451,6 @@ static int samsung_keypad_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	input_unregister_device(keypad->input_dev);
-
 	clk_unprepare(keypad->clk);
 
 	return 0;
-- 
2.32.0

