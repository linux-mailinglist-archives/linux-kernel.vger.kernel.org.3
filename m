Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5948E4DCA6D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiCQPuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiCQPuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:50:02 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C787A7B574;
        Thu, 17 Mar 2022 08:48:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 2BE54E014D;
        Thu, 17 Mar 2022 08:48:08 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oXZf-2y21f8e; Thu, 17 Mar 2022 08:48:07 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Angus Ainslie <angus@akkea.ca>,
        Hector Martin <marcan@marcan.st>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Subject: [PATCH 4/7] usb: typec: tipd: Provide POWER_SUPPLY_PROP_{CURRENT,VOLTAGE}_MAX
Date:   Thu, 17 Mar 2022 16:45:15 +0100
Message-Id: <20220317154518.4082046-5-sebastian.krzyszkowiak@puri.sm>
In-Reply-To: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
References: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angus Ainslie <angus@akkea.ca>

This helps downstream supplies to adjust their input limits.

Signed-off-by: Angus Ainslie <angus@akkea.ca>
Signed-off-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/usb/typec/tipd/core.c | 76 ++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 80b4a9870caf..f3e8f1183f5b 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -39,6 +39,11 @@
 #define TPS_REG_RX_IDENTITY_SOP		0x48
 #define TPS_REG_DATA_STATUS		0x5f
 
+#define TPS_USB_500mA	  500000
+#define TPS_TYPEC_1500mA 1500000
+#define TPS_TYPEC_3000mA 3000000
+#define TPS_USB_5V	 5000000
+
 /* TPS_REG_SYSTEM_CONF bits */
 #define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
 
@@ -103,6 +108,8 @@ struct tps6598x {
 static enum power_supply_property tps6598x_psy_props[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
 };
 
 static enum power_supply_usb_type tps6598x_psy_usb_types[] = {
@@ -294,6 +301,8 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
 	typec_set_orientation(tps->port, TYPEC_ORIENTATION_NONE);
 	tps6598x_set_data_role(tps, TPS_STATUS_TO_TYPEC_DATAROLE(status), false);
 
+	memset(&tps->terms, 0, sizeof(struct tps6598x_pdo));
+
 	power_supply_changed(tps->psy);
 }
 
@@ -577,6 +586,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	u64 event1;
 	u64 event2;
 	u32 status;
+	bool psy_changed = false;
 	int ret;
 
 	mutex_lock(&tps->lock);
@@ -595,10 +605,13 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
+	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE) {
 		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
 
+		psy_changed = true;
+	}
+
 	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE) {
 		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
@@ -612,12 +625,18 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 			dev_err(tps->dev, "failed to read pd contract: %d\n", ret);
 			goto err_clear_ints;
 		}
+		psy_changed = true;
 	}
 
 	/* Handle plug insert or removal */
 	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
 		tps6598x_handle_plug_event(tps, status);
 
+	if ((event1 | event2) & TPS_REG_INT_HARD_RESET) {
+		memset(&tps->terms, 0, sizeof(struct tps6598x_pdo));
+		psy_changed = true;
+	}
+
 err_clear_ints:
 	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
 	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
@@ -625,6 +644,9 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 err_unlock:
 	mutex_unlock(&tps->lock);
 
+	if (psy_changed)
+		power_supply_changed(tps->psy);
+
 	if (event1 | event2)
 		return IRQ_HANDLED;
 	return IRQ_NONE;
@@ -671,6 +693,49 @@ static int tps6598x_psy_get_online(struct tps6598x *tps,
 	} else {
 		val->intval = 0;
 	}
+
+	return 0;
+}
+
+static int tps6598x_psy_get_max_current(struct tps6598x *tps,
+					union power_supply_propval *val)
+{
+	enum typec_pwr_opmode mode;
+
+	mode = TPS_POWER_STATUS_PWROPMODE(tps->pwr_status);
+	switch (mode) {
+	case TYPEC_PWR_MODE_1_5A:
+		val->intval = TPS_TYPEC_1500mA;
+		break;
+	case TYPEC_PWR_MODE_3_0A:
+		val->intval = TPS_TYPEC_3000mA;
+		break;
+	case TYPEC_PWR_MODE_PD:
+		val->intval = tps->terms.max_current ?: TPS_USB_500mA;
+		break;
+	default:
+	case TYPEC_PWR_MODE_USB:
+		val->intval = TPS_USB_500mA;
+	}
+	return 0;
+}
+
+static int tps6598x_psy_get_max_voltage(struct tps6598x *tps,
+					union power_supply_propval *val)
+{
+	enum typec_pwr_opmode mode;
+
+	mode = TPS_POWER_STATUS_PWROPMODE(tps->pwr_status);
+	switch (mode) {
+	case TYPEC_PWR_MODE_PD:
+		val->intval = tps->terms.max_voltage ?: TPS_USB_5V;
+		break;
+	default:
+	case TYPEC_PWR_MODE_1_5A:
+	case TYPEC_PWR_MODE_3_0A:
+	case TYPEC_PWR_MODE_USB:
+		val->intval = TPS_USB_5V;
+	}
 	return 0;
 }
 
@@ -691,6 +756,12 @@ static int tps6598x_psy_get_prop(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		ret = tps6598x_psy_get_online(tps, val);
 		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		ret = tps6598x_psy_get_max_current(tps, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		ret = tps6598x_psy_get_max_voltage(tps, val);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -806,7 +877,8 @@ static int tps6598x_probe(struct i2c_client *client)
 		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
 			TPS_REG_INT_DATA_STATUS_UPDATE |
 			TPS_REG_INT_PLUG_EVENT |
-			TPS_REG_INT_NEW_CONTRACT_AS_CONSUMER;
+			TPS_REG_INT_NEW_CONTRACT_AS_CONSUMER |
+			TPS_REG_INT_HARD_RESET;
 	}
 
 	/* Make sure the controller has application firmware running */
-- 
2.35.1

