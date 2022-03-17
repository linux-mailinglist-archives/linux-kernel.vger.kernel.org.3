Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4134DCA65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiCQPtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236121AbiCQPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:49:27 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074D026C2;
        Thu, 17 Mar 2022 08:48:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 899DBE013D;
        Thu, 17 Mar 2022 08:48:02 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FVmjhwqjJUqz; Thu, 17 Mar 2022 08:48:01 -0700 (PDT)
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
Subject: [PATCH 3/7] usb: typec: tipd: Add trace event for SINK PD contract
Date:   Thu, 17 Mar 2022 16:45:14 +0100
Message-Id: <20220317154518.4082046-4-sebastian.krzyszkowiak@puri.sm>
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

This allows to trace the negotiated contract as sink. It's
only updated when the contract is actually established.

Co-developed-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Angus Ainslie <angus@akkea.ca>
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/usb/typec/tipd/core.c     | 63 ++++++++++++++++++++++++++++++-
 drivers/usb/typec/tipd/tps6598x.h | 30 +++++++++++++++
 drivers/usb/typec/tipd/trace.h    | 38 +++++++++++++++++++
 3 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index f387786ff95e..80b4a9870caf 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -34,6 +34,7 @@
 #define TPS_REG_STATUS			0x1a
 #define TPS_REG_SYSTEM_CONF		0x28
 #define TPS_REG_CTRL_CONF		0x29
+#define TPS_REG_ACTIVE_CONTRACT		0x34
 #define TPS_REG_POWER_STATUS		0x3f
 #define TPS_REG_RX_IDENTITY_SOP		0x48
 #define TPS_REG_DATA_STATUS		0x5f
@@ -93,6 +94,7 @@ struct tps6598x {
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
 	enum power_supply_usb_type usb_type;
+	struct tps6598x_pdo terms;
 
 	u32 data_status;
 	u16 pwr_status;
@@ -528,6 +530,47 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
 	return IRQ_NONE;
 }
 
+static int tps6598x_get_active_pd_contract(struct tps6598x *tps)
+{
+	u64 contract;
+	int type;
+	int max_power;
+	int ret = 0;
+
+	ret = tps6598x_block_read(tps, TPS_REG_ACTIVE_CONTRACT, &contract, 6);
+	if (ret)
+		return ret;
+
+	contract &= 0xFFFFFFFFFFFF;
+	type = TPS_PDO_CONTRACT_TYPE(contract);
+	memset(&tps->terms, 0, sizeof(struct tps6598x_pdo));
+
+	/* If there's no PD it decodes to all 0 */
+	switch (type) {
+	case TPS_PDO_CONTRACT_FIXED:
+		tps->terms.max_voltage = TPS_PDO_FIXED_CONTRACT_VOLTAGE(contract);
+		tps->terms.max_current = TPS_PDO_FIXED_CONTRACT_MAX_CURRENT(contract);
+		break;
+	case TPS_PDO_CONTRACT_BATTERY:
+		tps->terms.max_voltage = TPS_PDO_BAT_CONTRACT_MAX_VOLTAGE(contract);
+		max_power = TPS_PDO_BAT_CONTRACT_MAX_POWER(contract);
+		tps->terms.max_current = 1000 * 1000 * max_power / tps->terms.max_voltage;
+		break;
+	case TPS_PDO_CONTRACT_VARIABLE:
+		tps->terms.max_voltage = TPS_PDO_VAR_CONTRACT_MAX_VOLTAGE(contract);
+		tps->terms.max_current = TPS_PDO_VAR_CONTRACT_MAX_CURRENT(contract);
+		break;
+	default:
+		dev_warn(tps->dev, "Unknown contract type: %d\n", type);
+		return -EINVAL;
+	}
+
+	tps->terms.pdo = contract;
+	trace_tps6598x_pdo(&tps->terms);
+
+	return 0;
+}
+
 static irqreturn_t tps6598x_interrupt(int irq, void *data)
 {
 	struct tps6598x *tps = data;
@@ -563,6 +606,14 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 		tps6598x_update_data_status(tps, status);
 	}
 
+	if ((event1 | event2) & TPS_REG_INT_NEW_CONTRACT_AS_CONSUMER) {
+		ret = tps6598x_get_active_pd_contract(tps);
+		if (ret) {
+			dev_err(tps->dev, "failed to read pd contract: %d\n", ret);
+			goto err_clear_ints;
+		}
+	}
+
 	/* Handle plug insert or removal */
 	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
 		tps6598x_handle_plug_event(tps, status);
@@ -751,10 +802,11 @@ static int tps6598x_probe(struct i2c_client *client)
 
 		irq_handler = cd321x_interrupt;
 	} else {
-		/* Enable power status, data status and plug event interrupts */
+		/* Enable interrupts used by this driver */
 		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
 			TPS_REG_INT_DATA_STATUS_UPDATE |
-			TPS_REG_INT_PLUG_EVENT;
+			TPS_REG_INT_PLUG_EVENT |
+			TPS_REG_INT_NEW_CONTRACT_AS_CONSUMER;
 	}
 
 	/* Make sure the controller has application firmware running */
@@ -847,6 +899,13 @@ static int tps6598x_probe(struct i2c_client *client)
 		ret = tps6598x_connect(tps, status);
 		if (ret)
 			dev_err(&client->dev, "failed to register partner\n");
+
+		if ((TPS_POWER_STATUS_PWROPMODE(tps->pwr_status) == TYPEC_PWR_MODE_PD) &&
+		    (!(status & TPS_STATUS_PORTROLE))) {
+			ret = tps6598x_get_active_pd_contract(tps);
+			if (ret)
+				dev_err(tps->dev, "failed to read pd contract: %d\n", ret);
+		}
 	}
 
 	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 527857549d69..546cd4881f1f 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -199,4 +199,34 @@
 #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_A    BIT(2)
 #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_B    (BIT(2) | BIT(1))
 
+
+/* PDO decoding as in https://www.ti.com/lit/an/slva842/slva842.pdf */
+#define TPS_PDO_CONTRACT_TYPE(x)	FIELD_GET(GENMASK(31, 30), x)
+#define TPS_PDO_CONTRACT_FIXED	0
+#define TPS_PDO_CONTRACT_BATTERY	1
+#define TPS_PDO_CONTRACT_VARIABLE	2
+
+#define TPS_PDO_FIXED_CONTRACT_DETAILS		GENMASK(29, 25)
+#define TPS_PDO_FIXED_CONTRACT_DR_POWER		BIT(29)
+#define TPS_PDO_FIXED_CONTRACT_USB_SUSPEND	BIT(28)
+#define TPS_PDO_FIXED_CONTRACT_EXTERNAL_PWR	BIT(27)
+#define TPS_PDO_FIXED_CONTRACT_USB_COMMS	BIT(26)
+#define TPS_PDO_FIXED_CONTRACT_DR_DATA		BIT(25)
+
+#define TPS_PDO_FIXED_CONTRACT_VOLTAGE(x)	(FIELD_GET(GENMASK(19, 10), x) * 50000)
+#define TPS_PDO_FIXED_CONTRACT_MAX_CURRENT(x)	(FIELD_GET(GENMASK(9, 0), x) * 10000)
+#define TPS_PDO_VAR_CONTRACT_MAX_VOLTAGE(x)	(FIELD_GET(GENMASK(29, 20), x) * 50000)
+#define TPS_PDO_VAR_CONTRACT_MIN_VOLTAGE(x)	(FIELD_GET(GENMASK(19, 10), x) * 50000)
+#define TPS_PDO_VAR_CONTRACT_MAX_CURRENT(x)	(FIELD_GET(GENMASK(9, 0), x) * 10000)
+#define TPS_PDO_BAT_CONTRACT_MAX_VOLTAGE(x)	(FIELD_GET(GENMASK(29, 20), x) * 50000)
+#define TPS_PDO_BAT_CONTRACT_MIN_VOLTAGE(x)	(FIELD_GET(GENMASK(19, 10), x) * 50000)
+#define TPS_PDO_BAT_CONTRACT_MAX_POWER(x)	(FIELD_GET(GENMASK(9, 0), x) * 250000)
+
+struct tps6598x_pdo {
+	u32 pdo;
+	int max_voltage; /* uV */
+	int max_current; /* uA */
+	int max_power;   /* uW */
+};
+
 #endif /* __TPS6598X_H__ */
diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
index 12cad1bde7cc..148e2ef3157b 100644
--- a/drivers/usb/typec/tipd/trace.h
+++ b/drivers/usb/typec/tipd/trace.h
@@ -194,6 +194,20 @@
 	(data_status & TPS_DATA_STATUS_DP_CONNECTION ? \
 	 show_data_status_dp_pin_assignment(data_status) : "")
 
+#define show_pdo_contract_type(pdo) \
+	__print_symbolic(TPS_PDO_CONTRACT_TYPE(pdo), \
+		{ TPS_PDO_CONTRACT_FIXED, "fixed" }, \
+		{ TPS_PDO_CONTRACT_BATTERY, "battery" }, \
+		{ TPS_PDO_CONTRACT_VARIABLE, "variable" })
+
+#define show_pdo_contract_details(pdo) \
+	__print_flags(pdo & TPS_PDO_FIXED_CONTRACT_DETAILS, "|", \
+		{ TPS_PDO_FIXED_CONTRACT_DR_POWER, "dr-power" }, \
+		{ TPS_PDO_FIXED_CONTRACT_USB_SUSPEND, "usb-suspend" }, \
+		{ TPS_PDO_FIXED_CONTRACT_EXTERNAL_PWR, "ext-power" }, \
+		{ TPS_PDO_FIXED_CONTRACT_USB_COMMS, "usb-comms" }, \
+		{ TPS_PDO_FIXED_CONTRACT_DR_DATA, "dr-data" })
+
 TRACE_EVENT(tps6598x_irq,
 	    TP_PROTO(u64 event1,
 		     u64 event2),
@@ -296,6 +310,30 @@ TRACE_EVENT(tps6598x_data_status,
 		    )
 );
 
+TRACE_EVENT(tps6598x_pdo,
+	    TP_PROTO(struct tps6598x_pdo *pdo),
+	    TP_ARGS(pdo),
+
+	    TP_STRUCT__entry(
+			     __field(u32, pdo)
+			     __field(int, max_current)
+			     __field(int, max_voltage)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->pdo = pdo->pdo;
+			   __entry->max_current = pdo->max_current;
+			   __entry->max_voltage = pdo->max_voltage;
+			   ),
+
+	    TP_printk("%s supply, max %duA, %duV, details: %s",
+		      show_pdo_contract_type(__entry->pdo),
+		      __entry->max_current,
+		      __entry->max_voltage,
+		      show_pdo_contract_details(__entry->pdo)
+		    )
+);
+
 #endif /* _TPS6598X_TRACE_H_ */
 
 /* This part must be outside protection */
-- 
2.35.1

