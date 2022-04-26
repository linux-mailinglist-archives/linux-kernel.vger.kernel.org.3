Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F1350F1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbiDZHOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343743AbiDZHOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:14:07 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E36E115707;
        Tue, 26 Apr 2022 00:10:59 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.188:50678.1670155976
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.39 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id 1F5612800A8;
        Tue, 26 Apr 2022 15:10:57 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.188])
        by app0023 with ESMTP id 6ede1721cee149c184a5e8ab7176a99e for wim@linux-watchdog.org;
        Tue, 26 Apr 2022 15:10:59 CST
X-Transaction-ID: 6ede1721cee149c184a5e8ab7176a99e
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.188
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net, tzungbi@kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v4 3/4] watchdog: wdat_wdg: Stop watchdog when uninstalling module
Date:   Tue, 26 Apr 2022 15:10:28 +0800
Message-Id: <1650957029-910-4-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650957029-910-1-git-send-email-liuxp11@chinatelecom.cn>
References: <1650957029-910-1-git-send-email-liuxp11@chinatelecom.cn>
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
index 0ef2b918364a..6732d7fc4f94 100644
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

