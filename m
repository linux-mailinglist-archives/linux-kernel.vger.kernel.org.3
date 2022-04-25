Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A7450DB11
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiDYI1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbiDYI0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:26:55 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 795B11CB28;
        Mon, 25 Apr 2022 01:23:24 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.48:45926.704897365
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.38 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id 1ED742800D4;
        Mon, 25 Apr 2022 16:22:47 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id e3378ec917c74581bc92bedef25e1586 for wim@linux-watchdog.org;
        Mon, 25 Apr 2022 16:23:15 CST
X-Transaction-ID: e3378ec917c74581bc92bedef25e1586
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v2 3/3] watchdog: wdat_wdg: Stop watchdog when uninstalling module
Date:   Mon, 25 Apr 2022 16:22:12 +0800
Message-Id: <1650874932-18407-4-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650874932-18407-1-git-send-email-liuxp11@chinatelecom.cn>
References: <1650874932-18407-1-git-send-email-liuxp11@chinatelecom.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test shows that wachdog still reboots machine after the module
is removed. Use watchdog_stop_on_unregister to stop the watchdog
on removing.

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 drivers/watchdog/wdat_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index 609922ed4744..502da41ac0b2 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -464,6 +464,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(&wdat->wdd, nowayout);
 	watchdog_stop_on_reboot(&wdat->wdd);
+	watchdog_stop_on_unregister(&wdat->wdd);
 	return devm_watchdog_register_device(dev, &wdat->wdd);
 }
 
-- 
2.23.0

