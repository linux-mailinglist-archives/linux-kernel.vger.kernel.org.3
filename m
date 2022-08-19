Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E84959993F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348214AbiHSJuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347904AbiHSJuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:50:09 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B449663F1B;
        Fri, 19 Aug 2022 02:50:00 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 27J9UF08093759;
        Fri, 19 Aug 2022 17:30:15 +0800 (GMT-8)
        (envelope-from chin-ting_kuo@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 19 Aug
 2022 17:49:11 +0800
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <BMC-SW@aspeedtech.com>,
        <linux-watchdog@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        <Bonnie_Lo@wiwynn.com>
Subject: [PATCH] watchdog: aspeed_wdt: Reorder output signal register configuration
Date:   Fri, 19 Aug 2022 17:49:05 +0800
Message-ID: <20220819094905.1962513-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 27J9UF08093759
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the output driving type is push-pull mode, the output
polarity should be selected in advance. Otherwise, an unexpected
value will be output at the moment of changing to push-pull mode.
Thus, output polarity, WDT18[31], must be configured before
changing driving type, WDT18[30].

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/watchdog/aspeed_wdt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 436571b6fc79..a03e4ff812a2 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -325,18 +325,18 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
 
 		reg &= config->ext_pulse_width_mask;
-		if (of_property_read_bool(np, "aspeed,ext-push-pull"))
-			reg |= WDT_PUSH_PULL_MAGIC;
+		if (of_property_read_bool(np, "aspeed,ext-active-high"))
+			reg |= WDT_ACTIVE_HIGH_MAGIC;
 		else
-			reg |= WDT_OPEN_DRAIN_MAGIC;
+			reg |= WDT_ACTIVE_LOW_MAGIC;
 
 		writel(reg, wdt->base + WDT_RESET_WIDTH);
 
 		reg &= config->ext_pulse_width_mask;
-		if (of_property_read_bool(np, "aspeed,ext-active-high"))
-			reg |= WDT_ACTIVE_HIGH_MAGIC;
+		if (of_property_read_bool(np, "aspeed,ext-push-pull"))
+			reg |= WDT_PUSH_PULL_MAGIC;
 		else
-			reg |= WDT_ACTIVE_LOW_MAGIC;
+			reg |= WDT_OPEN_DRAIN_MAGIC;
 
 		writel(reg, wdt->base + WDT_RESET_WIDTH);
 	}
-- 
2.25.1

