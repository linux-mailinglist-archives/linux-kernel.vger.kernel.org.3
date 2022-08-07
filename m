Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B286C58BB6D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiHGOzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiHGOy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:54:59 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0A7B1FA
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659883985; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FK51yenZc/JKwR0w5a5iJeX2DvPOzWAPhfYWX6WSnq4=;
        b=bhMzruMTitPzWbryuc6eRMLJUyUvQ1Fb6Q6So+TJNJvu2c5gc5bO/TzwAVuDhTHgoBZliL
        e/1xMWyU4GdRZ8QmoXUcAiry8UCDaTdYap9xW61NYjB65kaDCTcvkPqlnAgAuA6x1imTRs
        6y9nMzpXvTJGJ8xAAlIJyjMNAD8HjUc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 14/28] mfd: sm501: Remove #ifdef guards for PM related functions
Date:   Sun,  7 Aug 2022 16:52:33 +0200
Message-Id: <20220807145247.46107-15-paul@crapouillou.net>
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
 drivers/mfd/sm501.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index bc0a2c38653e..81e15e646e77 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1432,8 +1432,6 @@ static int sm501_plat_probe(struct platform_device *dev)
 
 }
 
-#ifdef CONFIG_PM
-
 /* power management support */
 
 static void sm501_set_power(struct sm501_devdata *sm, int on)
@@ -1509,10 +1507,6 @@ static int sm501_plat_resume(struct platform_device *pdev)
 
 	return 0;
 }
-#else
-#define sm501_plat_suspend NULL
-#define sm501_plat_resume NULL
-#endif
 
 /* Initialisation data for PCI devices */
 
@@ -1714,8 +1708,8 @@ static struct platform_driver sm501_plat_driver = {
 	},
 	.probe		= sm501_plat_probe,
 	.remove		= sm501_plat_remove,
-	.suspend	= sm501_plat_suspend,
-	.resume		= sm501_plat_resume,
+	.suspend	= pm_sleep_ptr(sm501_plat_suspend),
+	.resume		= pm_sleep_ptr(sm501_plat_resume),
 };
 
 static int __init sm501_base_init(void)
-- 
2.35.1

