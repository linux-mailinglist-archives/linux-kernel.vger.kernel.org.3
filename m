Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69050F991
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348303AbiDZKG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348453AbiDZKFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:05:49 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95FD8D8903;
        Tue, 26 Apr 2022 02:27:18 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.48:52296.987177822
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.39 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id 870172800D6;
        Tue, 26 Apr 2022 17:27:15 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id 7663d7eee3b34c73b957a6bd3c735649 for wim@linux-watchdog.org;
        Tue, 26 Apr 2022 17:27:17 CST
X-Transaction-ID: 7663d7eee3b34c73b957a6bd3c735649
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net, tzungbi@kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v6 1/3] watchdog: wdat_wdg: Using the existing function to check parameter timeout
Date:   Tue, 26 Apr 2022 17:26:59 +0800
Message-Id: <1650965221-2533-2-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650965221-2533-1-git-send-email-liuxp11@chinatelecom.cn>
References: <1650965221-2533-1-git-send-email-liuxp11@chinatelecom.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If max_hw_heartbeat_ms is provided, the configured maximum timeout is not
limited by it. The limit check in this driver therefore doesn't make much
sense. Similar, the watchdog core ensures that minimum timeout limits are
met if min_hw_heartbeat_ms is set. Using watchdog_timeout_invalid() makes
more sense because it takes this into account.

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 drivers/watchdog/wdat_wdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index 195c8c004b69..9db01d165310 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -55,6 +55,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
 #define WDAT_DEFAULT_TIMEOUT	30
+#define WDAT_MIN_TIMEOUT     1
 
 static int timeout = WDAT_DEFAULT_TIMEOUT;
 module_param(timeout, int, 0);
@@ -344,6 +345,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 	wdat->period = tbl->timer_period;
 	wdat->wdd.min_hw_heartbeat_ms = wdat->period * tbl->min_count;
 	wdat->wdd.max_hw_heartbeat_ms = wdat->period * tbl->max_count;
+	wdat->wdd.min_timeout = WDAT_MIN_TIMEOUT;
 	wdat->stopped_in_sleep = tbl->flags & ACPI_WDAT_STOPPED;
 	wdat->wdd.info = &wdat_wdt_info;
 	wdat->wdd.ops = &wdat_wdt_ops;
@@ -450,8 +452,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 	 * watchdog properly after it has opened the device. In some cases
 	 * the BIOS default is too short and causes immediate reboot.
 	 */
-	if (timeout * 1000 < wdat->wdd.min_hw_heartbeat_ms ||
-	    timeout * 1000 > wdat->wdd.max_hw_heartbeat_ms) {
+	if (watchdog_timeout_invalid(&wdat->wdd, timeout)) {
 		dev_warn(dev, "Invalid timeout %d given, using %d\n",
 			 timeout, WDAT_DEFAULT_TIMEOUT);
 		timeout = WDAT_DEFAULT_TIMEOUT;
-- 
2.23.0

