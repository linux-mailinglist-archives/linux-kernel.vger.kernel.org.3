Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F35B4F07CA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 07:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiDCF04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 01:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDCF0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 01:26:55 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E252FFC9;
        Sat,  2 Apr 2022 22:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1648963502; x=1680499502;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wVMh7tSi6gT+Vt5r8ezb44wyB4qunOjWSvYnQ5DFeVE=;
  b=WmQ9VYqAIiNfcsmcvuKid0Wpz+yUH7yXFYFgs9ZKXGl4/xxlcCZ2C47G
   FgVhhklByIN4vzQj3TQimlVzOfcM4uwdqy53br7MaWkf/IoPmYooSMoGV
   sLvWj0POsCUeHHZl+tMgv4rmmF2GCnqjSYYagAS+K1Tjx15lsxnaPM29G
   w=;
X-IronPort-AV: E=Sophos;i="5.90,231,1643673600"; 
   d="scan'208";a="186714655"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 03 Apr 2022 05:24:51 +0000
Received: from EX13MTAUEE002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com (Postfix) with ESMTPS id 3ABF82005AB;
        Sun,  3 Apr 2022 05:24:49 +0000 (UTC)
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sun, 3 Apr 2022 05:24:49 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D08UEE001.ant.amazon.com (10.43.62.126) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sun, 3 Apr 2022 05:24:49 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Sun, 3 Apr 2022 05:24:49 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 36EE71687; Sun,  3 Apr 2022 05:24:49 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ronenk@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <farbere@amazon.com>,
        <dwmw@amazon.co.uk>
Subject: [PATCH] watchdog: sp805: add support for irq
Date:   Sun, 3 Apr 2022 05:24:49 +0000
Message-ID: <20220403052449.1986-1-farbere@amazon.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds registration to IRQ for the sp805 watchdog.
Before this change there was no notification for watchdog
barking and the only thing that the HW watchdog did was to
directly restart the CPU.

With this change, upon IRQ the driver will call panic() which
in turn might initiate kdump (in case configured). In case the
dying process (like kdump collection) will hang, the hardware
watchdog will still directly restart the CPU on a second timeout.

The driver used to cut the specified timeout in half when setting
the watchdog timeout, since it was ignoring the IRQ that occurred
the first time the timeout expired. We now use the timeout as is
since the watchdog IRQ will go off after the configured interval.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/watchdog/sp805_wdt.c | 102 +++++++++++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index d8876fba686d..09223aed87e3 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -17,6 +17,7 @@
 #include <linux/amba/bus.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
@@ -78,6 +79,11 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		"Set to 1 to keep watchdog running after device release");
 
+static bool skip_panic_skip_reset_on_timeout;
+module_param(skip_panic_skip_reset_on_timeout, bool, 0600);
+MODULE_PARM_DESC(skip_panic_skip_reset_on_timeout,
+		 "For skipping panic and skipping reset on timeout, set this to Y/1");
+
 /* returns true if wdt is running; otherwise returns false */
 static bool wdt_is_running(struct watchdog_device *wdd)
 {
@@ -87,7 +93,14 @@ static bool wdt_is_running(struct watchdog_device *wdd)
 	return (wdtcontrol & ENABLE_MASK) == ENABLE_MASK;
 }
 
-/* This routine finds load value that will reset system in required timout */
+/*
+ * This routine finds load value that will reset or panic the system in the
+ * required timeout.
+ * It also calculates the actual timeout, which can differ from the input
+ * timeout if load value is not in the range of LOAD_MIN and LOAD_MAX.
+ * When panic is enabled it calculates the timeout till the panic, and when it
+ * is disabled it calculates the timeout till the reset.
+ */
 static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 {
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
@@ -98,10 +111,21 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 	/*
 	 * sp805 runs counter with given value twice, after the end of first
 	 * counter it gives an interrupt and then starts counter again. If
-	 * interrupt already occurred then it resets the system. This is why
-	 * load is half of what should be required.
+	 * interrupt already occurred then it resets the system.
 	 */
-	load = div_u64(rate, 2) * timeout - 1;
+	if (wdt->adev->irq[0]) {
+		/*
+		 * Set load value based on a single timeout until we handle
+		 * the interrupt.
+		 */
+		load = rate * timeout - 1;
+	} else {
+		/*
+		 * Set load value to half the timeout, since the interrupt is
+		 * ignored and counter must expire twice before CPU is reset.
+		 */
+		load = div_u64(rate, 2) * timeout - 1;
+	}
 
 	load = (load > LOAD_MAX) ? LOAD_MAX : load;
 	load = (load < LOAD_MIN) ? LOAD_MIN : load;
@@ -109,13 +133,19 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 	spin_lock(&wdt->lock);
 	wdt->load_val = load;
 	/* roundup timeout to closest positive integer value */
-	wdd->timeout = div_u64((load + 1) * 2 + (rate / 2), rate);
+	if (wdt->adev->irq[0])
+		wdd->timeout = div_u64((load + 1) + (rate / 2), rate);
+	else
+		wdd->timeout = div_u64((load + 1) * 2 + (rate / 2), rate);
 	spin_unlock(&wdt->lock);
 
 	return 0;
 }
 
-/* returns number of seconds left for reset to occur */
+/*
+ * returns number of seconds left for reset to occur, or returns number of
+ * seconds left for panic to occur when enabled.
+ */
 static unsigned int wdt_timeleft(struct watchdog_device *wdd)
 {
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
@@ -124,9 +154,18 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
 	spin_lock(&wdt->lock);
 	load = readl_relaxed(wdt->base + WDTVALUE);
 
-	/*If the interrupt is inactive then time left is WDTValue + WDTLoad. */
-	if (!(readl_relaxed(wdt->base + WDTRIS) & INT_MASK))
-		load += wdt->load_val + 1;
+	/*
+	 * When panic is enabled, it occurs after the first time that sp805
+	 * runs the counter with the given load value.
+	 * Otherwise, reset happens after sp805 runs the counter with given
+	 * value twice (once before the interrupt and second after the
+	 * interrupt), so if the interrupt is inactive (first count) then time
+	 * left is WDTValue + WDTLoad.
+	 */
+	if (!wdt->adev->irq[0])
+		if (!(readl_relaxed(wdt->base + WDTRIS) & INT_MASK))
+			load += wdt->load_val + 1;
+
 	spin_unlock(&wdt->lock);
 
 	return div_u64(load, wdt->rate);
@@ -227,6 +266,29 @@ static const struct watchdog_ops wdt_ops = {
 	.restart	= wdt_restart,
 };
 
+static irqreturn_t wdt_irq_handler(int irq, void *dev_id)
+{
+	struct device *dev = dev_id;
+	struct sp805_wdt *wdt = dev_get_drvdata(dev);
+
+	/*
+	 * Reset the watchdog timeout to maximize time available to the panic
+	 * handler before the watchdog induces a CPU reset.  Without resetting
+	 * the watchdog here, it would have a single timeout remaining between
+	 * interrupt and hardware reset. By resetting the timeout, the panic
+	 * handler can run with interrupts disabled for two watchdog timeouts,
+	 * ignoring the interrupt that would occur after the first timeout.
+	 */
+	wdt_config(&wdt->wdd, true);
+
+	if (skip_panic_skip_reset_on_timeout)
+		dev_warn(dev, "watchdog timeout expired\n");
+	else
+		panic("watchdog timeout expired");
+
+	return IRQ_HANDLED;
+}
+
 static int
 sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 {
@@ -299,9 +361,28 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 	amba_set_drvdata(adev, wdt);
 
+	if (adev->irq[0]) {
+		ret = devm_request_irq(&adev->dev,
+				       adev->irq[0],
+				       wdt_irq_handler,
+				       0,
+				       MODULE_NAME,
+				       adev);
+		if (ret) {
+			dev_err(&adev->dev,
+				"watchdog irq request failed: %d\n",
+				ret);
+			goto err_request_irq;
+		}
+	} else {
+		dev_warn(&adev->dev, "no irq exists for watchdog\n");
+	}
+
 	dev_info(&adev->dev, "registration successful\n");
 	return 0;
 
+err_request_irq:
+	watchdog_unregister_device(&wdt->wdd);
 err:
 	dev_err(&adev->dev, "Probe Failed!!!\n");
 	return ret;
@@ -311,6 +392,9 @@ static int sp805_wdt_remove(struct amba_device *adev)
 {
 	struct sp805_wdt *wdt = amba_get_drvdata(adev);
 
+	if (adev->irq[0])
+		devm_free_irq(&adev->dev, adev->irq[0], adev);
+
 	watchdog_unregister_device(&wdt->wdd);
 	watchdog_set_drvdata(&wdt->wdd, NULL);
 
-- 
2.32.0

