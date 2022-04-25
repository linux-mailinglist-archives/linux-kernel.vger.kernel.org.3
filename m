Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA6D50DB10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbiDYI0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbiDYIZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:25:52 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E93C9DF07;
        Mon, 25 Apr 2022 01:22:46 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.48:45926.704897365
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.38 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id A86722800B4;
        Mon, 25 Apr 2022 16:22:43 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id f677bf24781f42cb959f822e59be0ced for wim@linux-watchdog.org;
        Mon, 25 Apr 2022 16:22:45 CST
X-Transaction-ID: f677bf24781f42cb959f822e59be0ced
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v2 1/3] watchdog: wdat_wdg: Using the existed function to check parameter timeout
Date:   Mon, 25 Apr 2022 16:22:10 +0800
Message-Id: <1650874932-18407-2-git-send-email-liuxp11@chinatelecom.cn>
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

Setting up min_timeout, and determine if a timeout value is
invalid using watchdog_timeout_invalid.

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 drivers/watchdog/wdat_wdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index 195c8c004b69..3040a0554055 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -14,6 +14,7 @@
 #include <linux/watchdog.h>
 
 #define MAX_WDAT_ACTIONS ACPI_WDAT_ACTION_RESERVED
+#define WDAT_TIMEOUT_MIN     1
 
 /**
  * struct wdat_instruction - Single ACPI WDAT instruction
@@ -344,6 +345,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 	wdat->period = tbl->timer_period;
 	wdat->wdd.min_hw_heartbeat_ms = wdat->period * tbl->min_count;
 	wdat->wdd.max_hw_heartbeat_ms = wdat->period * tbl->max_count;
+	wdat->wdd.min_timeout = WDAT_TIMEOUT_MIN;
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

