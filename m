Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D09F50FACF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349007AbiDZKdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349010AbiDZKbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:31:18 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10A5110FF1C;
        Tue, 26 Apr 2022 03:09:37 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.48:40704.1059882310
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.39 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id 154EA2800BE;
        Tue, 26 Apr 2022 18:09:34 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id 4399d0aaa93b405483a4175b0f9751c5 for wim@linux-watchdog.org;
        Tue, 26 Apr 2022 18:09:37 CST
X-Transaction-ID: 4399d0aaa93b405483a4175b0f9751c5
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net, tzungbi@kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v7 2/3] watchdog: wdat_wdt: Stop watchdog when rebooting the system
Date:   Tue, 26 Apr 2022 18:09:21 +0800
Message-Id: <1650967762-3122-3-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650967762-3122-1-git-send-email-liuxp11@chinatelecom.cn>
References: <1650967762-3122-1-git-send-email-liuxp11@chinatelecom.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Executing reboot command several times on the machine "Dell
PowerEdge R740", UEFI security detection stopped machine
with the following prompt:

UEFI0082: The system was reset due to a timeout from the watchdog
timer. Check the System Event Log (SEL) or crash dumps from
Operating Sysstem to identify the source that triggered the
watchdog timer reset. Update the firmware or driver for the
identified device.

iDRAC has warning event: "The watchdog timer reset the system".

This patch fixes this issue by adding the reboot notifier.

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 drivers/watchdog/wdat_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index 9db01d165310..0ef2b918364a 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -463,6 +463,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 		return ret;
 
 	watchdog_set_nowayout(&wdat->wdd, nowayout);
+	watchdog_stop_on_reboot(&wdat->wdd);
 	return devm_watchdog_register_device(dev, &wdat->wdd);
 }
 
-- 
2.23.0

