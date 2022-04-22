Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0380B50B9F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349639AbiDVOVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448624AbiDVOUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:20:54 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CCE5B3F9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:17:31 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id hu64nHsTWXeonhu64nsPbR; Fri, 22 Apr 2022 16:17:25 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 22 Apr 2022 16:17:25 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Tarun Kanti DebBarma <tarun.kanti@ti.com>,
        Thara Gopinath <thara@ti.com>,
        "Cousson, Benoit" <b-cousson@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: OMAP1: Fix error handling path in omap1_dm_timer_init()
Date:   Fri, 22 Apr 2022 16:17:18 +0200
Message-Id: <89cad160be5b186d8f6fd79bdb6ba3fa5e4bb53b.1650637013.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_device_put() should be called instead of
platform_device_unregister() in the error handling path because, at this
point, no successful platform_device_add() has been called.

While at it, change the goto label if kzalloc() fails. It is harmless to
call 'kfree(NULL)', but it is also pointless.

Fixes: 97933d6ced60 ("ARM: OMAP1: dmtimer: conversion to platform devices")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is a speculative patch, not even compile tested because of lack of
cross-compiler.
So review with care.
---
 arch/arm/mach-omap1/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
index 0411d5508d63..f91ba2353345 100644
--- a/arch/arm/mach-omap1/timer.c
+++ b/arch/arm/mach-omap1/timer.c
@@ -135,7 +135,7 @@ static int __init omap1_dm_timer_init(void)
 		pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
 		if (!pdata) {
 			ret = -ENOMEM;
-			goto err_free_pdata;
+			goto err_free_pdev;
 		}
 
 		pdata->set_timer_src = omap1_dm_timer_set_src;
@@ -165,7 +165,7 @@ static int __init omap1_dm_timer_init(void)
 	kfree(pdata);
 
 err_free_pdev:
-	platform_device_unregister(pdev);
+	platform_device_put(pdev);
 
 	return ret;
 }
-- 
2.32.0

