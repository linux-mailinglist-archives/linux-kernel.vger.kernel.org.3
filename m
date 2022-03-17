Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7DE4DCA56
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiCQPtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiCQPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:49:10 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E9713EB7;
        Thu, 17 Mar 2022 08:47:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id DD5ACE0139;
        Thu, 17 Mar 2022 08:47:52 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T1hfA1Qg9heb; Thu, 17 Mar 2022 08:47:52 -0700 (PDT)
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
Subject: [PATCH 1/7] usb: typec: tipd: Only update power status on IRQ
Date:   Thu, 17 Mar 2022 16:45:12 +0100
Message-Id: <20220317154518.4082046-2-sebastian.krzyszkowiak@puri.sm>
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

From: Guido Günther <agx@sigxcpu.org>

Instead of refetching power status cache it and only update it when a
change is signalled via irq. This simplifies tracing and adding more
supply properties in follow up patches.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/usb/typec/tipd/core.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 16b4560216ba..dfbba5ae9487 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -93,6 +93,8 @@ struct tps6598x {
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
 	enum power_supply_usb_type usb_type;
+
+	u16 pwr_status;
 };
 
 static enum power_supply_property tps6598x_psy_props[] = {
@@ -230,17 +232,12 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
 {
 	struct typec_partner_desc desc;
 	enum typec_pwr_opmode mode;
-	u16 pwr_status;
 	int ret;
 
 	if (tps->partner)
 		return 0;
 
-	ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
-	if (ret < 0)
-		return ret;
-
-	mode = TPS_POWER_STATUS_PWROPMODE(pwr_status);
+	mode = TPS_POWER_STATUS_PWROPMODE(tps->pwr_status);
 
 	desc.usb_pd = mode == TYPEC_PWR_MODE_PD;
 	desc.accessory = TYPEC_ACCESSORY_NONE; /* XXX: handle accessories */
@@ -455,6 +452,7 @@ static bool tps6598x_read_power_status(struct tps6598x *tps)
 		dev_err(tps->dev, "failed to read power status: %d\n", ret);
 		return false;
 	}
+	tps->pwr_status = pwr_status;
 	trace_tps6598x_power_status(pwr_status);
 
 	return true;
@@ -601,15 +599,8 @@ static const struct regmap_config tps6598x_regmap_config = {
 static int tps6598x_psy_get_online(struct tps6598x *tps,
 				   union power_supply_propval *val)
 {
-	int ret;
-	u16 pwr_status;
-
-	ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
-	if (ret < 0)
-		return ret;
-
-	if (TPS_POWER_STATUS_CONNECTION(pwr_status) &&
-	    TPS_POWER_STATUS_SOURCESINK(pwr_status)) {
+	if (TPS_POWER_STATUS_CONNECTION(tps->pwr_status) &&
+	    TPS_POWER_STATUS_SOURCESINK(tps->pwr_status)) {
 		val->intval = 1;
 	} else {
 		val->intval = 0;
@@ -622,15 +613,11 @@ static int tps6598x_psy_get_prop(struct power_supply *psy,
 				 union power_supply_propval *val)
 {
 	struct tps6598x *tps = power_supply_get_drvdata(psy);
-	u16 pwr_status;
 	int ret = 0;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_USB_TYPE:
-		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
-		if (ret < 0)
-			return ret;
-		if (TPS_POWER_STATUS_PWROPMODE(pwr_status) == TYPEC_PWR_MODE_PD)
+		if (TPS_POWER_STATUS_PWROPMODE(tps->pwr_status) == TYPEC_PWR_MODE_PD)
 			val->intval = POWER_SUPPLY_USB_TYPE_PD;
 		else
 			val->intval = POWER_SUPPLY_USB_TYPE_C;
@@ -837,6 +824,11 @@ static int tps6598x_probe(struct i2c_client *client)
 	fwnode_handle_put(fwnode);
 
 	if (status & TPS_STATUS_PLUG_PRESENT) {
+		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &tps->pwr_status);
+		if (ret < 0) {
+			dev_err(tps->dev, "failed to read power status: %d\n", ret);
+			goto err_role_put;
+		}
 		ret = tps6598x_connect(tps, status);
 		if (ret)
 			dev_err(&client->dev, "failed to register partner\n");
-- 
2.35.1

