Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427CB58BB73
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiHGO43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbiHGOzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:55:54 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D79B857
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659883987; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1i9W1PSbipFYRxBVR9VHxY/xM8GZD5sSA1L5JLSKCyU=;
        b=xp0VNEp9KHBmmvp5qIXup4UrPSOD3CirgvGCoHKAXpjW4JPjMdYb+aqVQtanNqQiCXKUnX
        cafi14TR8juVdJxGmoKjZei9dky+17jclxWdNNITR69p9tOzP+blc/3ydpfHubahMuydjt
        oseRGMfaP1fvTiWUV3FB73naIDnOKvU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 19/28] mfd: t7l66xb: Remove #ifdef guards for PM related functions
Date:   Sun,  7 Aug 2022 16:52:38 +0200
Message-Id: <20220807145247.46107-20-paul@crapouillou.net>
In-Reply-To: <20220807145247.46107-1-paul@crapouillou.net>
References: <20220807145247.46107-1-paul@crapouillou.net>
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

The advantage is then that these functions are now always compiled
independently of any Kconfig option, and thanks to that bugs and
regressions are easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mfd/t7l66xb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/t7l66xb.c b/drivers/mfd/t7l66xb.c
index 5369c67e3280..74d26dce2003 100644
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
 
@@ -420,8 +415,8 @@ static struct platform_driver t7l66xb_platform_driver = {
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

