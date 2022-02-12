Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7D44B3295
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 03:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiBLCLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 21:11:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBLCLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 21:11:08 -0500
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4E5D5C;
        Fri, 11 Feb 2022 18:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1644631867; x=1676167867;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ZdFF+bThzOqaGF0GLmUjP5ltWoniFt4/T378NNzf4jM=;
  b=iuuBa1ZhGTT2DeRh+R4KxB7pQ/Jz6fZaSweb2uqaNBr7Xp1ud1F7wwD9
   vUAPYdljRuikmb2SM8NWN6Do6w0bNUP5OcHucr0KSaWmliFKgheaCfEZv
   ezCrcGzstBael94K0GSG+eYsizDok3AH/Jhlpiv5/pvnzrOXdYsCiLi8F
   A=;
X-IronPort-AV: E=Sophos;i="5.88,361,1635206400"; 
   d="scan'208";a="175587638"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-a264e6fe.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 12 Feb 2022 02:11:05 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-a264e6fe.us-west-2.amazon.com (Postfix) with ESMTPS id 4957D419DC;
        Sat, 12 Feb 2022 02:11:04 +0000 (UTC)
Received: from EX13D05UWB001.ant.amazon.com (10.43.161.181) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Sat, 12 Feb 2022 02:11:04 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D05UWB001.ant.amazon.com (10.43.161.181) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Sat, 12 Feb 2022 02:11:03 +0000
Received: from localhost (10.106.101.26) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.28 via Frontend
 Transport; Sat, 12 Feb 2022 02:11:03 +0000
From:   Eduardo Valentin <eduval@amazon.com>
To:     <eduval@amazon.com>, Wim Van Sebroeck <wim@linux-watchdog.org>,
        "Guenter Roeck" <linux@roeck-us.net>
CC:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Eduardo Valentin" <evalenti@kernel.org>
Subject: [PATCH 1/1] watchdog: aspeed: add nowayout support
Date:   Fri, 11 Feb 2022 18:10:33 -0800
Message-ID: <20220212021033.2344-1-eduval@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for not stopping the watchdog
when the userspace application quits. At
closing of the device, the driver cannot
determine if this was a graceful closure
or if the app crashed. If the support
of nowayout on this driver, the system integrator
can select the behaviour by setting the kernel
config and enabling it.

Cc: Wim Van Sebroeck <wim@linux-watchdog.org> (maintainer:WATCHDOG DEVICE DRIVERS)
Cc: Guenter Roeck <linux@roeck-us.net> (maintainer:WATCHDOG DEVICE DRIVERS)
Cc: Joel Stanley <joel@jms.id.au> (supporter:ARM/ASPEED MACHINE SUPPORT)
Cc: Andrew Jeffery <andrew@aj.id.au> (reviewer:ARM/ASPEED MACHINE SUPPORT)
Cc: linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS)
Cc: linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE SUPPORT)
Cc: linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE SUPPORT)
Cc: linux-kernel@vger.kernel.org (open list)
Signed-off-by: Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Eduardo Valentin <evalenti@kernel.org>
---
 drivers/watchdog/aspeed_wdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 436571b6fc79..bd06622813eb 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -13,6 +13,11 @@
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
 struct aspeed_wdt {
 	struct watchdog_device	wdd;
 	void __iomem		*base;
@@ -266,6 +271,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.timeout = WDT_DEFAULT_TIMEOUT;
 	watchdog_init_timeout(&wdt->wdd, 0, dev);
 
+	watchdog_set_nowayout(&wdt->wdd, nowayout);
+
 	np = dev->of_node;
 
 	ofdid = of_match_node(aspeed_wdt_of_table, np);
-- 
2.17.1

