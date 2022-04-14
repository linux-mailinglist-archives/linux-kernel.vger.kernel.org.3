Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E73150086C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbiDNIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiDNIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:34:14 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724D162BC7;
        Thu, 14 Apr 2022 01:31:50 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23E8VgfR045981;
        Thu, 14 Apr 2022 03:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649925102;
        bh=fRUF0LmPzEq7B63eyHtG91nstfOlpLaJqL90GK1pl0Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=i3jutaT9CxToz77KJ9K4efBxo1obAXAi0chdR5uOlEv1ym0qzrHFtuALFLnLjEU48
         TYFJZXCQlnKByYaSNVzhQi75I9dRlexyB4VYQD94Zgr23WlUrdgFOdPoJKBaeDBQlN
         lgo4grQKNg4dSHig3Lc4wL8Zztmx74G4uZJc38ag=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23E8VgJR070232
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Apr 2022 03:31:42 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 14
 Apr 2022 03:31:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 14 Apr 2022 03:31:41 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23E8VLNo025547;
        Thu, 14 Apr 2022 03:31:37 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Jens Axboe <axboe@kernel.dk>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] usb: typec: tipd: Add support for polling interrupts status when interrupt line is not connected
Date:   Thu, 14 Apr 2022 14:01:18 +0530
Message-ID: <20220414083120.22535-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220414083120.22535-1-a-govindraju@ti.com>
References: <20220414083120.22535-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases the interrupt line from the pd controller may not be
connected. In these cases, poll the status of various events.

Suggested-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/usb/typec/tipd/core.c | 99 +++++++++++++++++++++++++++++++----
 1 file changed, 88 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 16b4560216ba..72fd586ac080 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -15,6 +15,8 @@
 #include <linux/interrupt.h>
 #include <linux/usb/typec.h>
 #include <linux/usb/role.h>
+#include <linux/workqueue.h>
+#include <linux/devm-helpers.h>
 
 #include "tps6598x.h"
 #include "trace.h"
@@ -93,6 +95,8 @@ struct tps6598x {
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
 	enum power_supply_usb_type usb_type;
+
+	struct delayed_work wq_poll;
 };
 
 static enum power_supply_property tps6598x_psy_props[] = {
@@ -473,9 +477,8 @@ static void tps6598x_handle_plug_event(struct tps6598x *tps, u32 status)
 	}
 }
 
-static irqreturn_t cd321x_interrupt(int irq, void *data)
+static int cd321x_handle_interrupt_status(struct tps6598x *tps)
 {
-	struct tps6598x *tps = data;
 	u64 event;
 	u32 status;
 	int ret;
@@ -513,14 +516,45 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
 err_unlock:
 	mutex_unlock(&tps->lock);
 
+	if (ret)
+		return ret;
+
 	if (event)
-		return IRQ_HANDLED;
-	return IRQ_NONE;
+		return 0;
+	return 1;
 }
 
-static irqreturn_t tps6598x_interrupt(int irq, void *data)
+static irqreturn_t cd321x_interrupt(int irq, void *data)
 {
 	struct tps6598x *tps = data;
+	int ret;
+
+	ret = cd321x_handle_interrupt_status(tps);
+	if (ret)
+		return IRQ_NONE;
+	return IRQ_HANDLED;
+}
+
+/* Time interval for Polling */
+#define POLL_INTERVAL   500 /* msecs */
+static void cd321x_poll_work(struct work_struct *work)
+{
+	struct tps6598x *tps = container_of(to_delayed_work(work),
+					    struct tps6598x, wq_poll);
+	int ret;
+
+	ret = cd321x_handle_interrupt_status(tps);
+	/*
+	 * If there is an error while reading the interrupt registers
+	 * then stop polling else, schedule another poll work item
+	 */
+	if (!(ret < 0))
+		queue_delayed_work(system_power_efficient_wq,
+				   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
+}
+
+static int tps6598x_handle_interrupt_status(struct tps6598x *tps)
+{
 	u64 event1;
 	u64 event2;
 	u32 status;
@@ -561,9 +595,39 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 err_unlock:
 	mutex_unlock(&tps->lock);
 
+	if (ret)
+		return ret;
+
 	if (event1 | event2)
-		return IRQ_HANDLED;
-	return IRQ_NONE;
+		return 0;
+	return 1;
+}
+
+static irqreturn_t tps6598x_interrupt(int irq, void *data)
+{
+	struct tps6598x *tps = data;
+	int ret;
+
+	ret = tps6598x_handle_interrupt_status(tps);
+	if (ret)
+		return IRQ_NONE;
+	return IRQ_HANDLED;
+}
+
+static void tps6598x_poll_work(struct work_struct *work)
+{
+	struct tps6598x *tps = container_of(to_delayed_work(work),
+					    struct tps6598x, wq_poll);
+	int ret;
+
+	ret = tps6598x_handle_interrupt_status(tps);
+	/*
+	 * If there is an error while reading the interrupt registers
+	 * then stop polling else, schedule another poll work item
+	 */
+	if (!(ret < 0))
+		queue_delayed_work(system_power_efficient_wq,
+				   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
 }
 
 static int tps6598x_check_mode(struct tps6598x *tps)
@@ -704,6 +768,7 @@ static int devm_tps6598_psy_register(struct tps6598x *tps)
 static int tps6598x_probe(struct i2c_client *client)
 {
 	irq_handler_t irq_handler = tps6598x_interrupt;
+	work_func_t work_poll_handler = tps6598x_poll_work;
 	struct device_node *np = client->dev.of_node;
 	struct typec_capability typec_cap = { };
 	struct tps6598x *tps;
@@ -748,6 +813,7 @@ static int tps6598x_probe(struct i2c_client *client)
 			APPLE_CD_REG_INT_PLUG_EVENT;
 
 		irq_handler = cd321x_interrupt;
+		work_poll_handler = cd321x_poll_work;
 	} else {
 		/* Enable power status, data status and plug event interrupts */
 		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
@@ -842,10 +908,21 @@ static int tps6598x_probe(struct i2c_client *client)
 			dev_err(&client->dev, "failed to register partner\n");
 	}
 
-	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-					irq_handler,
-					IRQF_SHARED | IRQF_ONESHOT,
-					dev_name(&client->dev), tps);
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+						irq_handler,
+						IRQF_SHARED | IRQF_ONESHOT,
+						dev_name(&client->dev), tps);
+	} else {
+		dev_warn(&client->dev, "Unable to find the interrupt, switching to polling\n");
+		ret = devm_delayed_work_autocancel(tps->dev, &tps->wq_poll, work_poll_handler);
+		if (ret)
+			dev_err(&client->dev, "error while initializing workqueue\n");
+		else
+			queue_delayed_work(system_power_efficient_wq, &tps->wq_poll,
+					   msecs_to_jiffies(POLL_INTERVAL));
+	}
+
 	if (ret) {
 		tps6598x_disconnect(tps, 0);
 		typec_unregister_port(tps->port);
-- 
2.17.1

