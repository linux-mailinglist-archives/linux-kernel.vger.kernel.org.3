Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440B6533E63
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbiEYN6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiEYN6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:08 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB8C941A0;
        Wed, 25 May 2022 06:58:06 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id x28-20020a4a621c000000b0040e85d338f2so1718844ooc.5;
        Wed, 25 May 2022 06:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xLlFec5N8qrCBt/iBc/xnPVxAShfXkm+TdYxUalLIOY=;
        b=A3gSbXeYcmleVu0APARKNmEvxlcfA6JFGhdOPtrojODqLGfusp94onMMlmmNrpD97w
         Kt40ICKT86sWpz1Lfaf89aXNCXidO91qaGWoit9rbh37NLmQNL9TS4uG6iMUZdBwKmcW
         VlLHOu6MCMjaQ2cWtaCqQe6vvf4Mx1X2i6xEeXU9OLVuHL+OwTf1PIs12KEIdcD4M3dE
         cSJiJk8U94BF+J7bc12lIKxODWFtaI6Dp1N0OK+2Y8qIdu7mSA8e1HpvWMY2Yj7//hWw
         uZbD7lzgl3hqUvBJEGndM4Wa1sHZtRwwwk55MLZWP3r84eCIk8x3aQfyby8HYrQnxHtH
         ZhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xLlFec5N8qrCBt/iBc/xnPVxAShfXkm+TdYxUalLIOY=;
        b=lsdwRzSNe5mnCOuGB2QgF7pBho8IBJ3LDmaJGRotkWhkDhFU0x3kKkvCAxNjNLROTb
         rsoe4Tl6aJgH5gSAwr9285gyY9Y/Ro7m7uIJzxRAnrjypi+4NbZ2SddEoP07DHk+pZAA
         IZXGdbzfq2A5EDG89Erhv7C3NrVngQyLyJ/5m89eQ05QV8sgwYiaUBxrYuNy/f3a59gQ
         +0cnlyNU8EFG7iR544xKc771gDL0yh1EUKOiSixpIn0EkmFA9fcvLhQM2kDjc2ouCv9z
         VWiChXspmZV8gq26iZEw6PAqR1OKCuzYH6/itujlCS+0By2TA7LtuVwMVbn/BEDEbPvF
         /qjA==
X-Gm-Message-State: AOAM532xIfwOoIroAC/lOCVQfZgoFc4Nox21alzBPejwvzdrQpckRR3q
        T6f4uehX5jXLEussKpQn9Kfn+bRfSyX9ag==
X-Google-Smtp-Source: ABdhPJwMZYSunFxmnkeN6oe6Pu9Yff2KrSKIRlZpoScjpXN8apmYuVdYCOrG7pLx86iC/vKioFYg6A==
X-Received: by 2002:a4a:ba81:0:b0:40e:7cd9:afa1 with SMTP id d1-20020a4aba81000000b0040e7cd9afa1mr7470057oop.22.1653487085275;
        Wed, 25 May 2022 06:58:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y11-20020a4a624b000000b0035e9f149b90sm6862085oog.3.2022.05.25.06.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 02/40] hwmon: (lm90) Rework alarm/status handling
Date:   Wed, 25 May 2022 06:57:20 -0700
Message-Id: <20220525135758.2944744-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525135758.2944744-1-linux@roeck-us.net>
References: <20220525135758.2944744-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many chips supported by this driver clear status registers after it
is read and update it in the next measurement cycle. Normally this falls
under the radar because all registers are only read once per measurement
cycle. However, there is an exception: Status registers are always read
during interrupt and laert handling. This can result in invalid status
reports if userspace reads an alarm attribute immediately afterwards.

Rework alarm/status handling by keeping a shadow register with 'current'
alarms, and by ensuring that the register is either only updated once per
measurement cycle or not cleared.

A second problem is related to alert handling: Alert handling is disabled
for chips with broken alert after an alert was reported, but only
re-enabled if attributes are read by the user. This means that alert
conditions may appear and disappear unnoticed. Remedy the situation
by introducing a worker to periodically read the status register(s) while
alert handling is disabled, and re-enable alerts after the alert condition
clears.

Yet another problem is that sysfs and udev events are currently only
reported to userspace if an alarm is raised, but not if an alarm condition
clears. Use the new worker to detect that situation and also generate
sysfs and udev events in that case.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 314 +++++++++++++++++++++++++++----------------
 1 file changed, 199 insertions(+), 115 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 83d027c134be..63ada2d0d839 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -92,6 +92,7 @@
 #include <linux/sysfs.h>
 #include <linux/interrupt.h>
 #include <linux/regulator/consumer.h>
+#include <linux/workqueue.h>
 
 /*
  * Addresses to scan
@@ -499,8 +500,11 @@ struct lm90_data {
 	const struct hwmon_channel_info *info[3];
 	struct hwmon_chip_info chip;
 	struct mutex update_lock;
+	struct delayed_work alert_work;
 	bool valid;		/* true if register values are valid */
+	bool alarms_valid;	/* true if status register values are valid */
 	unsigned long last_updated; /* in jiffies */
+	unsigned long alarms_updated; /* in jiffies */
 	int kind;
 	u32 flags;
 
@@ -518,7 +522,9 @@ struct lm90_data {
 	s8 temp8[TEMP8_REG_NUM];
 	s16 temp11[TEMP11_REG_NUM];
 	u8 temp_hyst;
-	u16 alarms; /* bitvector (upper 8 bits for max6695/96) */
+	u16 reported_alarms;	/* alarms reported as sysfs/udev events */
+	u16 current_alarms;	/* current alarms, reported by chip */
+	u16 alarms;		/* alarms not yet reported to user */
 };
 
 /*
@@ -771,6 +777,158 @@ static int lm90_update_limits(struct device *dev)
 	return 0;
 }
 
+static void lm90_report_alarms(struct device *dev, struct lm90_data *data)
+{
+	u16 cleared_alarms = data->reported_alarms & ~data->current_alarms;
+	u16 new_alarms = data->current_alarms & ~data->reported_alarms;
+	struct device *hwmon_dev = data->hwmon_dev;
+	int st, st2;
+
+	if (!cleared_alarms && !new_alarms)
+		return;
+
+	st = new_alarms & 0xff;
+	st2 = new_alarms >> 8;
+
+	if ((st & (LM90_STATUS_LLOW | LM90_STATUS_LHIGH | LM90_STATUS_LTHRM)) ||
+	    (st2 & MAX6696_STATUS2_LOT2))
+		dev_dbg(dev, "temp%d out of range, please check!\n", 1);
+	if ((st & (LM90_STATUS_RLOW | LM90_STATUS_RHIGH | LM90_STATUS_RTHRM)) ||
+	    (st2 & MAX6696_STATUS2_ROT2))
+		dev_dbg(dev, "temp%d out of range, please check!\n", 2);
+	if (st & LM90_STATUS_ROPEN)
+		dev_dbg(dev, "temp%d diode open, please check!\n", 2);
+	if (st2 & (MAX6696_STATUS2_R2LOW | MAX6696_STATUS2_R2HIGH |
+		   MAX6696_STATUS2_R2THRM | MAX6696_STATUS2_R2OT2))
+		dev_dbg(dev, "temp%d out of range, please check!\n", 3);
+	if (st2 & MAX6696_STATUS2_R2OPEN)
+		dev_dbg(dev, "temp%d diode open, please check!\n", 3);
+
+	st |= cleared_alarms & 0xff;
+	st2 |= cleared_alarms >> 8;
+
+	if (st & LM90_STATUS_LLOW)
+		hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_min_alarm, 0);
+	if (st & LM90_STATUS_RLOW)
+		hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_min_alarm, 1);
+	if (st2 & MAX6696_STATUS2_R2LOW)
+		hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_min_alarm, 2);
+
+	if (st & LM90_STATUS_LHIGH)
+		hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_max_alarm, 0);
+	if (st & LM90_STATUS_RHIGH)
+		hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_max_alarm, 1);
+	if (st2 & MAX6696_STATUS2_R2HIGH)
+		hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_max_alarm, 2);
+
+	if (st & LM90_STATUS_LTHRM)
+		hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_crit_alarm, 0);
+	if (st & LM90_STATUS_RTHRM)
+		hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_crit_alarm, 1);
+	if (st2 & MAX6696_STATUS2_R2THRM)
+		hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_crit_alarm, 2);
+
+	if (st2 & MAX6696_STATUS2_LOT2)
+		hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_emergency_alarm, 0);
+	if (st2 & MAX6696_STATUS2_ROT2)
+		hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_emergency_alarm, 1);
+	if (st2 & MAX6696_STATUS2_R2OT2)
+		hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_emergency_alarm, 2);
+
+	data->reported_alarms = data->current_alarms;
+}
+
+static int lm90_update_alarms_locked(struct lm90_data *data, bool force)
+{
+	if (force || !data->alarms_valid ||
+	    time_after(jiffies, data->alarms_updated + msecs_to_jiffies(data->update_interval))) {
+		struct i2c_client *client = data->client;
+		bool check_enable;
+		u16 alarms;
+		int val;
+
+		data->alarms_valid = false;
+
+		val = lm90_read_reg(client, LM90_REG_R_STATUS);
+		if (val < 0)
+			return val;
+		alarms = val & ~LM90_STATUS_BUSY;
+
+		if (data->kind == max6696) {
+			val = lm90_read_reg(client, MAX6696_REG_R_STATUS2);
+			if (val < 0)
+				return val;
+			alarms |= val << 8;
+		}
+		/*
+		 * If the update is forced (called from interrupt or alert
+		 * handler) and alarm data is valid, the alarms may have been
+		 * updated after the last update interval, and the status
+		 * register may still be cleared. Only add additional alarms
+		 * in this case. Alarms will be cleared later if appropriate.
+		 */
+		if (force && data->alarms_valid)
+			data->current_alarms |= alarms;
+		else
+			data->current_alarms = alarms;
+		data->alarms |= alarms;
+
+		check_enable = (client->irq || !(data->config_orig & 0x80)) &&
+			(data->config & 0x80);
+
+		if (force || check_enable)
+			lm90_report_alarms(&client->dev, data);
+
+		/*
+		 * Re-enable ALERT# output if it was originally enabled, relevant
+		 * alarms are all clear, and alerts are currently disabled.
+		 * Otherwise (re)schedule worker if needed.
+		 */
+		if (check_enable) {
+			if (!(data->current_alarms & data->alert_alarms)) {
+				dev_dbg(&client->dev, "Re-enabling ALERT#\n");
+				lm90_update_confreg(data, data->config & ~0x80);
+				/*
+				 * We may have been called from the update handler.
+				 * If so, the worker, if scheduled, is no longer
+				 * needed. Cancel it. Don't synchronize because
+				 * it may already be running.
+				 */
+				cancel_delayed_work(&data->alert_work);
+			} else {
+				schedule_delayed_work(&data->alert_work,
+					max_t(int, HZ, msecs_to_jiffies(data->update_interval)));
+			}
+		}
+		data->alarms_updated = jiffies;
+		data->alarms_valid = true;
+	}
+	return 0;
+}
+
+static int lm90_update_alarms(struct lm90_data *data, bool force)
+{
+	int err;
+
+	mutex_lock(&data->update_lock);
+	err = lm90_update_alarms_locked(data, force);
+	mutex_unlock(&data->update_lock);
+
+	return err;
+}
+
+static void lm90_alert_work(struct work_struct *__work)
+{
+	struct delayed_work *delayed_work = container_of(__work, struct delayed_work, work);
+	struct lm90_data *data = container_of(delayed_work, struct lm90_data, alert_work);
+
+	/* Nothing to do if alerts are enabled */
+	if (!(data->config & 0x80))
+		return;
+
+	lm90_update_alarms(data, true);
+}
+
 static int lm90_update_device(struct device *dev)
 {
 	struct lm90_data *data = dev_get_drvdata(dev);
@@ -819,11 +977,6 @@ static int lm90_update_device(struct device *dev)
 			return val;
 		data->temp11[REMOTE_TEMP] = val;
 
-		val = lm90_read_reg(client, LM90_REG_R_STATUS);
-		if (val < 0)
-			return val;
-		data->alarms = val & ~LM90_STATUS_BUSY;
-
 		if (data->kind == max6696) {
 			val = lm90_select_remote_channel(data, 1);
 			if (val < 0)
@@ -838,24 +991,11 @@ static int lm90_update_device(struct device *dev)
 			data->temp11[REMOTE2_TEMP] = val;
 
 			lm90_select_remote_channel(data, 0);
-
-			val = lm90_read_reg(client, MAX6696_REG_R_STATUS2);
-			if (val < 0)
-				return val;
-			data->alarms |= val << 8;
 		}
 
-		/*
-		 * Re-enable ALERT# output if it was originally enabled and
-		 * relevant alarms are all clear
-		 */
-		if ((client->irq || !(data->config_orig & 0x80)) &&
-		    !(data->alarms & data->alert_alarms)) {
-			if (data->config & 0x80) {
-				dev_dbg(&client->dev, "Re-enabling ALERT#\n");
-				lm90_update_confreg(data, data->config & ~0x80);
-			}
-		}
+		val = lm90_update_alarms_locked(data, false);
+		if (val < 0)
+			return val;
 
 		data->last_updated = jiffies;
 		data->valid = true;
@@ -1212,7 +1352,7 @@ static const u8 lm90_fault_bits[3] = { 0, 2, 10 };
 static int lm90_temp_read(struct device *dev, u32 attr, int channel, long *val)
 {
 	struct lm90_data *data = dev_get_drvdata(dev);
-	int err;
+	int err, bit;
 
 	mutex_lock(&data->update_lock);
 	err = lm90_update_device(dev);
@@ -1225,22 +1365,33 @@ static int lm90_temp_read(struct device *dev, u32 attr, int channel, long *val)
 		*val = lm90_get_temp11(data, lm90_temp_index[channel]);
 		break;
 	case hwmon_temp_min_alarm:
-		*val = (data->alarms >> lm90_min_alarm_bits[channel]) & 1;
-		break;
 	case hwmon_temp_max_alarm:
-		*val = (data->alarms >> lm90_max_alarm_bits[channel]) & 1;
-		break;
 	case hwmon_temp_crit_alarm:
-		if (data->flags & LM90_HAVE_CRIT_ALRM_SWP)
-			*val = (data->alarms >> lm90_crit_alarm_bits_swapped[channel]) & 1;
-		else
-			*val = (data->alarms >> lm90_crit_alarm_bits[channel]) & 1;
-		break;
 	case hwmon_temp_emergency_alarm:
-		*val = (data->alarms >> lm90_emergency_alarm_bits[channel]) & 1;
-		break;
 	case hwmon_temp_fault:
-		*val = (data->alarms >> lm90_fault_bits[channel]) & 1;
+		switch (attr) {
+		case hwmon_temp_min_alarm:
+			bit = BIT(lm90_min_alarm_bits[channel]);
+			break;
+		case hwmon_temp_max_alarm:
+			bit = BIT(lm90_max_alarm_bits[channel]);
+			break;
+		case hwmon_temp_crit_alarm:
+			if (data->flags & LM90_HAVE_CRIT_ALRM_SWP)
+				bit = BIT(lm90_crit_alarm_bits_swapped[channel]);
+			else
+				bit = BIT(lm90_crit_alarm_bits[channel]);
+			break;
+		case hwmon_temp_emergency_alarm:
+			bit = BIT(lm90_emergency_alarm_bits[channel]);
+			break;
+		case hwmon_temp_fault:
+			bit = BIT(lm90_fault_bits[channel]);
+			break;
+		}
+		*val = !!(data->alarms & bit);
+		data->alarms &= ~bit;
+		data->alarms |= data->current_alarms;
 		break;
 	case hwmon_temp_min:
 		if (channel == 0)
@@ -1699,6 +1850,8 @@ static void lm90_restore_conf(void *_data)
 	struct lm90_data *data = _data;
 	struct i2c_client *client = data->client;
 
+	cancel_delayed_work_sync(&data->alert_work);
+
 	/* Restore initial configuration */
 	lm90_write_convrate(data, data->convrate_orig);
 	i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
@@ -1771,93 +1924,23 @@ static int lm90_init_client(struct i2c_client *client, struct lm90_data *data)
 	return devm_add_action_or_reset(&client->dev, lm90_restore_conf, data);
 }
 
-static bool lm90_is_tripped(struct i2c_client *client, u16 *status)
+static bool lm90_is_tripped(struct i2c_client *client)
 {
 	struct lm90_data *data = i2c_get_clientdata(client);
-	int st, st2 = 0;
-
-	st = lm90_read_reg(client, LM90_REG_R_STATUS);
-	if (st < 0)
-		return false;
-
-	if (data->kind == max6696) {
-		st2 = lm90_read_reg(client, MAX6696_REG_R_STATUS2);
-		if (st2 < 0)
-			return false;
-	}
-
-	*status = st | (st2 << 8);
+	int ret;
 
-	if ((st & 0x7f) == 0 && (st2 & 0xfe) == 0)
+	ret = lm90_update_alarms(data, true);
+	if (ret < 0)
 		return false;
 
-	if ((st & (LM90_STATUS_LLOW | LM90_STATUS_LHIGH | LM90_STATUS_LTHRM)) ||
-	    (st2 & MAX6696_STATUS2_LOT2))
-		dev_dbg(&client->dev,
-			"temp%d out of range, please check!\n", 1);
-	if ((st & (LM90_STATUS_RLOW | LM90_STATUS_RHIGH | LM90_STATUS_RTHRM)) ||
-	    (st2 & MAX6696_STATUS2_ROT2))
-		dev_dbg(&client->dev,
-			"temp%d out of range, please check!\n", 2);
-	if (st & LM90_STATUS_ROPEN)
-		dev_dbg(&client->dev,
-			"temp%d diode open, please check!\n", 2);
-	if (st2 & (MAX6696_STATUS2_R2LOW | MAX6696_STATUS2_R2HIGH |
-		   MAX6696_STATUS2_R2THRM | MAX6696_STATUS2_R2OT2))
-		dev_dbg(&client->dev,
-			"temp%d out of range, please check!\n", 3);
-	if (st2 & MAX6696_STATUS2_R2OPEN)
-		dev_dbg(&client->dev,
-			"temp%d diode open, please check!\n", 3);
-
-	if (st & LM90_STATUS_LLOW)
-		hwmon_notify_event(data->hwmon_dev, hwmon_temp,
-				   hwmon_temp_min_alarm, 0);
-	if (st & LM90_STATUS_RLOW)
-		hwmon_notify_event(data->hwmon_dev, hwmon_temp,
-				   hwmon_temp_min_alarm, 1);
-	if (st2 & MAX6696_STATUS2_R2LOW)
-		hwmon_notify_event(data->hwmon_dev, hwmon_temp,
-				   hwmon_temp_min_alarm, 2);
-	if (st & LM90_STATUS_LHIGH)
-		hwmon_notify_event(data->hwmon_dev, hwmon_temp,
-				   hwmon_temp_max_alarm, 0);
-	if (st & LM90_STATUS_RHIGH)
-		hwmon_notify_event(data->hwmon_dev, hwmon_temp,
-				   hwmon_temp_max_alarm, 1);
-	if (st2 & MAX6696_STATUS2_R2HIGH)
-		hwmon_notify_event(data->hwmon_dev, hwmon_temp,
-				   hwmon_temp_max_alarm, 2);
-
-	if (st & LM90_STATUS_LTHRM)
-		hwmon_notify_event(hwmon_dev, hwmon_temp,
-				   hwmon_temp_crit_alarm, 0);
-	if (st & LM90_STATUS_RTHRM)
-		hwmon_notify_event(hwmon_dev, hwmon_temp,
-				   hwmon_temp_crit_alarm, 1);
-	if (st2 & MAX6696_STATUS2_R2THRM)
-		hwmon_notify_event(hwmon_dev, hwmon_temp,
-				   hwmon_temp_crit_alarm, 2);
-
-	if (st2 & MAX6696_STATUS2_LOT2)
-		hwmon_notify_event(hwmon_dev, hwmon_temp,
-				   hwmon_temp_emergency_alarm, 0);
-	if (st2 & MAX6696_STATUS2_ROT2)
-		hwmon_notify_event(hwmon_dev, hwmon_temp,
-				   hwmon_temp_emergency_alarm, 1);
-	if (st2 & MAX6696_STATUS2_R2OT2)
-		hwmon_notify_event(hwmon_dev, hwmon_temp,
-				   hwmon_temp_emergency_alarm, 2);
-
-	return true;
+	return !!data->current_alarms;
 }
 
 static irqreturn_t lm90_irq_thread(int irq, void *dev_id)
 {
 	struct i2c_client *client = dev_id;
-	u16 status;
 
-	if (lm90_is_tripped(client, &status))
+	if (lm90_is_tripped(client))
 		return IRQ_HANDLED;
 	else
 		return IRQ_NONE;
@@ -1911,6 +1994,7 @@ static int lm90_probe(struct i2c_client *client)
 	data->client = client;
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
+	INIT_DELAYED_WORK(&data->alert_work, lm90_alert_work);
 
 	/* Set the device type */
 	if (client->dev.of_node)
@@ -2027,12 +2111,10 @@ static int lm90_probe(struct i2c_client *client)
 static void lm90_alert(struct i2c_client *client, enum i2c_alert_protocol type,
 		       unsigned int flag)
 {
-	u16 alarms;
-
 	if (type != I2C_PROTOCOL_SMBUS_ALERT)
 		return;
 
-	if (lm90_is_tripped(client, &alarms)) {
+	if (lm90_is_tripped(client)) {
 		/*
 		 * Disable ALERT# output, because these chips don't implement
 		 * SMBus alert correctly; they should only hold the alert line
@@ -2041,9 +2123,11 @@ static void lm90_alert(struct i2c_client *client, enum i2c_alert_protocol type,
 		struct lm90_data *data = i2c_get_clientdata(client);
 
 		if ((data->flags & LM90_HAVE_BROKEN_ALERT) &&
-		    (alarms & data->alert_alarms)) {
+		    (data->current_alarms & data->alert_alarms)) {
 			dev_dbg(&client->dev, "Disabling ALERT#\n");
 			lm90_update_confreg(data, data->config | 0x80);
+			schedule_delayed_work(&data->alert_work,
+				max_t(int, HZ, msecs_to_jiffies(data->update_interval)));
 		}
 	} else {
 		dev_dbg(&client->dev, "Everything OK\n");
-- 
2.35.1

