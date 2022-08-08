Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E2358CD02
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244062AbiHHRsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244194AbiHHRpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:45:25 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F04C1838E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980505; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=br301fRK+XR8bCfkYexTo4vtYjSJhFPTzOjfRomSgPs=;
        b=p7yh+9eWJI7UY0EejzzKj7HkZluuYh9ATcRoH3ynVJfGPt8Ove9/e6jmWHVvyZ8IpSKQA9
        jW2iETCu8sjeWELpz1ErTGDPBFUm+rjbajCYgvbKpFu2akbJiH35Sw0cZ7lhCAgW690uYz
        DjGxzv0FPZ7wUCKj488Xy+0vWq7KdoQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 20/30] mfd: t7l66xb: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:40:57 +0200
Message-Id: <20220808174107.38676-21-paul@crapouillou.net>
In-Reply-To: <20220808174107.38676-1-paul@crapouillou.net>
References: <20220808174107.38676-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new pm_sleep_ptr() macro to handle the .suspend/.resume
callbacks.

This macro allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mfd/t7l66xb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/t7l66xb.c b/drivers/mfd/t7l66xb.c
index 663ffd4b8570..1d9d1d38d068 100644
--- a/drivers/mfd/t7l66xb.c
+++ b/drivers/mfd/t7l66xb.c
@@ -257,7 +257,6 @@ static void t7l66xb_detach_irq(struct platform_device *dev)
 
 /*--------------------------------------------------------------------------*/
 
-#ifdef CONFIG_PM
 static int t7l66xb_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct t7l66xb *t7l66xb = platform_get_drvdata(dev);
@@ -288,10 +287,6 @@ static int t7l66xb_resume(struct platform_device *dev)
 
 	return 0;
 }
-#else
-#define t7l66xb_suspend NULL
-#define t7l66xb_resume	NULL
-#endif
 
 /*--------------------------------------------------------------------------*/
 
@@ -416,8 +411,8 @@ static struct platform_driver t7l66xb_platform_driver = {
 	.driver = {
 		.name	= "t7l66xb",
 	},
-	.suspend	= t7l66xb_suspend,
-	.resume		= t7l66xb_resume,
+	.suspend	= pm_sleep_ptr(t7l66xb_suspend),
+	.resume		= pm_sleep_ptr(t7l66xb_resume),
 	.probe		= t7l66xb_probe,
 	.remove		= t7l66xb_remove,
 };
-- 
2.35.1

