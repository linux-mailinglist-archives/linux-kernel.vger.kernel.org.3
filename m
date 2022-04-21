Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AB650A317
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389368AbiDUOty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389625AbiDUOtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:49:50 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4291240A5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:46:58 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.48:52588.517396403
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.38 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id 1C49728009B;
        Thu, 21 Apr 2022 22:46:49 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id 858e0d6bc8d647be9ed84338be167c44 for wim@linux-watchdog.org;
        Thu, 21 Apr 2022 22:46:55 CST
X-Transaction-ID: 858e0d6bc8d647be9ed84338be167c44
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH] Watchdog: Checking timeout invalid if hardware heartbeat range is configured
Date:   Thu, 21 Apr 2022 22:22:18 +0800
Message-Id: <1650550938-24608-1-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timeout should be invalid when it is out of the hardware
timeout range.

ACPI watchdog: Using watchdog_timeout_invalid to check parameter
timeout invalid

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 drivers/watchdog/wdat_wdt.c |  3 +--
 include/linux/watchdog.h    | 17 ++++++++++++-----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index 195c8c004b69..d166d33ce7ae 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -450,8 +450,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 	 * watchdog properly after it has opened the device. In some cases
 	 * the BIOS default is too short and causes immediate reboot.
 	 */
-	if (timeout * 1000 < wdat->wdd.min_hw_heartbeat_ms ||
-	    timeout * 1000 > wdat->wdd.max_hw_heartbeat_ms) {
+	if (watchdog_timeout_invalid(&wdat->wdd, timeout)) {
 		dev_warn(dev, "Invalid timeout %d given, using %d\n",
 			 timeout, WDAT_DEFAULT_TIMEOUT);
 		timeout = WDAT_DEFAULT_TIMEOUT;
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 99660197a36c..e82daeef0b26 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -167,6 +167,15 @@ static inline void watchdog_stop_ping_on_suspend(struct watchdog_device *wdd)
 /* Use the following function to check if a timeout value is invalid */
 static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
 {
+	/*
+	 * If a maximum/minimum hardware timeout is configured,
+	 * the timeout is invalid when it is out of the range.
+	 */
+	if (wdd->max_hw_heartbeat_ms)
+		return t * 1000 > wdd->max_hw_heartbeat_ms;
+	if (wdd->min_hw_heartbeat_ms)
+		return t * 1000 < wdd->min_hw_heartbeat_ms;
+
 	/*
 	 * The timeout is invalid if
 	 * - the requested value is larger than UINT_MAX / 1000
@@ -174,13 +183,11 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
 	 * or
 	 * - the requested value is smaller than the configured minimum timeout,
 	 * or
-	 * - a maximum hardware timeout is not configured, a maximum timeout
-	 *   is configured, and the requested value is larger than the
-	 *   configured maximum timeout.
+	 * - maximum timeout is configured, and the requested value is larger than
+	 * the configured maximum timeout.
 	 */
 	return t > UINT_MAX / 1000 || t < wdd->min_timeout ||
-		(!wdd->max_hw_heartbeat_ms && wdd->max_timeout &&
-		 t > wdd->max_timeout);
+		(wdd->max_timeout && t > wdd->max_timeout);
 }
 
 /* Use the following function to check if a pretimeout value is invalid */
-- 
2.23.0

