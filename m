Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C80D4DCA61
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiCQPtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiCQPtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:49:17 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CD639BA2;
        Thu, 17 Mar 2022 08:47:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id A71A4E013C;
        Thu, 17 Mar 2022 08:47:57 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JcpyOJZtPPGy; Thu, 17 Mar 2022 08:47:57 -0700 (PDT)
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
Subject: [PATCH 2/7] usb: typec: tipd: set the data role on tps IRQ
Date:   Thu, 17 Mar 2022 16:45:13 +0100
Message-Id: <20220317154518.4082046-3-sebastian.krzyszkowiak@puri.sm>
In-Reply-To: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
References: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
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

Don't immediately set the data role, only set it in response to the
negotiated value notification from the tps6589x. Otherwise data role
switch fails for DRP.

We only use values cached from the IRQ instead of poking I2C all
the time.

The update is moved in a function that will become more useful in later
commits.

Fixes: 18a6c866bb19 ("usb: typec: tps6598x: Add USB role switching logic")
Signed-off-by: Angus Ainslie <angus@akkea.ca>
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/usb/typec/tipd/core.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index dfbba5ae9487..f387786ff95e 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -94,6 +94,7 @@ struct tps6598x {
 	struct power_supply_desc psy_desc;
 	enum power_supply_usb_type usb_type;
 
+	u32 data_status;
 	u16 pwr_status;
 };
 
@@ -271,6 +272,15 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
 	return 0;
 }
 
+static int
+tps6598x_update_data_status(struct tps6598x *tps, u32 status)
+{
+	tps6598x_set_data_role(tps, TPS_STATUS_TO_TYPEC_DATAROLE(status),
+			       !!(tps->data_status & TPS_DATA_STATUS_DATA_CONNECTION));
+	trace_tps6598x_data_status(tps->data_status);
+	return 0;
+}
+
 static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
 {
 	if (!IS_ERR(tps->partner))
@@ -370,8 +380,6 @@ static int tps6598x_dr_set(struct typec_port *port, enum typec_data_role role)
 		goto out_unlock;
 	}
 
-	tps6598x_set_data_role(tps, role, true);
-
 out_unlock:
 	mutex_unlock(&tps->lock);
 
@@ -437,6 +445,7 @@ static bool tps6598x_read_data_status(struct tps6598x *tps)
 		dev_err(tps->dev, "failed to read data status: %d\n", ret);
 		return false;
 	}
+	tps->data_status = data_status;
 	trace_tps6598x_data_status(data_status);
 
 	return true;
@@ -497,10 +506,13 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
 		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
 
-	if (event & APPLE_CD_REG_INT_DATA_STATUS_UPDATE)
+	if (event & APPLE_CD_REG_INT_DATA_STATUS_UPDATE) {
 		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
 
+		tps6598x_update_data_status(tps, status);
+	}
+
 	/* Handle plug insert or removal */
 	if (event & APPLE_CD_REG_INT_PLUG_EVENT)
 		tps6598x_handle_plug_event(tps, status);
@@ -544,10 +556,13 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
+	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE) {
 		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
 
+		tps6598x_update_data_status(tps, status);
+	}
+
 	/* Handle plug insert or removal */
 	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
 		tps6598x_handle_plug_event(tps, status);
-- 
2.35.1

