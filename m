Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F1D533EAD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244579AbiEYOCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244867AbiEYOAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:00:14 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E46BAFAEC;
        Wed, 25 May 2022 06:59:18 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g13-20020a9d6b0d000000b0060b13026e0dso6243419otp.8;
        Wed, 25 May 2022 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHo5aNcjBFOylKfLF/i7SZ5SjyU4FPNuOc7pFz/KTSA=;
        b=ZIJt16xRlWplJ1vkCiiJasxlOqksgMX3tZLt3PAnxVh1KkokcdDEvKRrGmX84B0SEg
         eoE8rotlBqGFtMxN+fnvXh+JtxqCQAN0SE9w8Dnx54rIVeHr3Q153suORWP+QPHUuDct
         nq+JIU5SqeqqOLFyC2eYZ4J43mg3MotFylZ3SNLt16/hfbHqmUpOsF6l9ZHw3low3/4u
         Hx1/Q5e/71f+AXH+wVdJMI+bTckNnYEGYfRO09YIVElHa0wv9aM35c8aMEh0EI4ptNMA
         vNj6OtBT1dcA+fWO7RpJgCKfAZWeD8Ag2trzkytC3g+9C5oi+BdlXmmKrEBliZL05YqX
         F6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RHo5aNcjBFOylKfLF/i7SZ5SjyU4FPNuOc7pFz/KTSA=;
        b=B/VvYdgFNGhumS1E+idrarz0t/cElzSeTfCuFFFcyxnwfIEBt6Lzd07TKdYVuY7Rr8
         IVEcnZCLf4EwpAi1q17onds0454u4PFDeGwgJTT622Sp6+3pmlI0N4VQZ5O/HM2EoLmh
         aIcUa3nq81V0QZZ1QJ90cG1ZQM1NdlFz5xxtswVaV13al3SG0VgWSZNko9UOvup/tkyH
         9QNCne2yN2+4c/OPNEN3G+GCVGi9u1dK74GGlt8ZS8Rqy8g9nd4eIMLTGq4jfQ6Pu/PT
         A/hQN/gyju+bku2U/P4RomGIwuV014wXyR4nfoHMHdo0QASM2DuocCCYObzyC/bzDYiC
         qJ0g==
X-Gm-Message-State: AOAM530eoKtk4YtI6icfdAhlcJ2qoh4uGVCoqXqj+fTzjMjTbKpOlYgx
        SVAyj54CAav/p7clssDuGoe5LT0P7dMMYg==
X-Google-Smtp-Source: ABdhPJwMAikwQMwoxdDhtfzad2odxt1592BuTPWzUDRyQAl8RUdqN3/FYrb+v3KBSiYWdnRScmGaWA==
X-Received: by 2002:a9d:7294:0:b0:60a:fff3:77a7 with SMTP id t20-20020a9d7294000000b0060afff377a7mr8202636otj.6.1653487156749;
        Wed, 25 May 2022 06:59:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n65-20020aca4044000000b0032af3cffac7sm6282245oia.2.2022.05.25.06.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:59:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 40/40] hwmon: (lm90) Support temp_samples attribute
Date:   Wed, 25 May 2022 06:57:58 -0700
Message-Id: <20220525135758.2944744-41-linux@roeck-us.net>
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

Several of the chips supported by this driver support configuring the
number of samples (or the fault queue depth) necessary before a fault
or alarm is reported. This is done either with a bit in the configuration
register or with a separate "consecutive alert" register. Support this
functionality with the temp_samples attribute.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 105 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 91 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 7f8397c362e8..4c25c9ffdfe9 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -206,6 +206,7 @@ enum chips { adm1023, adm1032, adt7461, adt7461a, adt7481,
 #define LM90_HAVE_LOW		BIT(15)	/* low limits			*/
 #define LM90_HAVE_CONVRATE	BIT(16)	/* conversion rate		*/
 #define LM90_HAVE_REMOTE_EXT	BIT(17)	/* extended remote temperature	*/
+#define LM90_HAVE_FAULTQUEUE	BIT(18)	/* configurable samples count	*/
 
 /* LM90 status */
 #define LM90_STATUS_LTHRM	BIT(0)	/* local THERM limit tripped */
@@ -404,6 +405,8 @@ struct lm90_params {
 	u8 resolution;		/* 16-bit resolution (default 11 bit) */
 	u8 reg_status2;		/* 2nd status register (optional) */
 	u8 reg_local_ext;	/* Extended local temp register (optional) */
+	u8 faultqueue_mask;	/* fault queue bit mask */
+	u8 faultqueue_depth;	/* fault queue depth if mask is used */
 };
 
 static const struct lm90_params lm90_params[] = {
@@ -419,7 +422,8 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT
 		  | LM90_HAVE_PARTIAL_PEC | LM90_HAVE_ALARMS
-		  | LM90_HAVE_LOW | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
+		  | LM90_HAVE_LOW | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT
+		  | LM90_HAVE_FAULTQUEUE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
@@ -433,7 +437,7 @@ static const struct lm90_params lm90_params[] = {
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
 		  | LM90_HAVE_CRIT | LM90_HAVE_PARTIAL_PEC
 		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
-		  | LM90_HAVE_REMOTE_EXT,
+		  | LM90_HAVE_REMOTE_EXT | LM90_HAVE_FAULTQUEUE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 		.resolution = 10,
@@ -442,7 +446,8 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
 		  | LM90_HAVE_CRIT | LM90_HAVE_PEC | LM90_HAVE_ALARMS
-		  | LM90_HAVE_LOW | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
+		  | LM90_HAVE_LOW | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT
+		  | LM90_HAVE_FAULTQUEUE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 	},
@@ -451,7 +456,8 @@ static const struct lm90_params lm90_params[] = {
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
 		  | LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_PEC
 		  | LM90_HAVE_TEMP3 | LM90_HAVE_CRIT | LM90_HAVE_LOW
-		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
+		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT
+		  | LM90_HAVE_FAULTQUEUE,
 		.alert_alarms = 0x1c7c,
 		.max_convrate = 11,
 		.resolution = 10,
@@ -461,7 +467,7 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_CRIT
 		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
-		  | LM90_HAVE_REMOTE_EXT,
+		  | LM90_HAVE_REMOTE_EXT | LM90_HAVE_FAULTQUEUE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
 	},
@@ -472,16 +478,22 @@ static const struct lm90_params lm90_params[] = {
 	[lm90] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW
-		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
+		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT
+		  | LM90_HAVE_FAULTQUEUE,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
+		.faultqueue_mask = BIT(0),
+		.faultqueue_depth = 3,
 	},
 	[lm99] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_CRIT | LM90_HAVE_ALARMS | LM90_HAVE_LOW
-		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
+		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT
+		  | LM90_HAVE_FAULTQUEUE,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
+		.faultqueue_mask = BIT(0),
+		.faultqueue_depth = 3,
 	},
 	[max1617] = {
 		.flags = LM90_HAVE_CONVRATE | LM90_HAVE_BROKEN_ALERT |
@@ -492,10 +504,12 @@ static const struct lm90_params lm90_params[] = {
 	},
 	[max6642] = {
 		.flags = LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXT_UNSIGNED
-		  | LM90_HAVE_REMOTE_EXT,
+		  | LM90_HAVE_REMOTE_EXT | LM90_HAVE_FAULTQUEUE,
 		.alert_alarms = 0x50,
 		.resolution = 10,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
+		.faultqueue_mask = BIT(4),
+		.faultqueue_depth = 2,
 	},
 	[max6646] = {
 		.flags = LM90_HAVE_CRIT | LM90_HAVE_BROKEN_ALERT
@@ -553,17 +567,20 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_EMERGENCY
 		  | LM90_HAVE_EMERGENCY_ALARM | LM90_HAVE_TEMP3 | LM90_HAVE_CRIT
 		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
-		  | LM90_HAVE_REMOTE_EXT,
+		  | LM90_HAVE_REMOTE_EXT | LM90_HAVE_FAULTQUEUE,
 		.alert_alarms = 0x1c7c,
 		.max_convrate = 6,
 		.reg_status2 = MAX6696_REG_STATUS2,
 		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
+		.faultqueue_mask = BIT(5),
+		.faultqueue_depth = 4,
 	},
 	[nct72] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP
 		  | LM90_HAVE_CRIT | LM90_HAVE_PEC | LM90_HAVE_UNSIGNED_TEMP
-		  | LM90_HAVE_LOW | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
+		  | LM90_HAVE_LOW | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT
+		  | LM90_HAVE_FAULTQUEUE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 10,
 		.resolution = 10,
@@ -598,16 +615,18 @@ static const struct lm90_params lm90_params[] = {
 		 */
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT
 		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
-		  | LM90_HAVE_REMOTE_EXT,
+		  | LM90_HAVE_REMOTE_EXT | LM90_HAVE_FAULTQUEUE,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
 		.reg_local_ext = SA56004_REG_LOCAL_TEMPL,
+		.faultqueue_mask = BIT(0),
+		.faultqueue_depth = 3,
 	},
 	[tmp451] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT
 		  | LM90_HAVE_UNSIGNED_TEMP | LM90_HAVE_ALARMS | LM90_HAVE_LOW
-		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT,
+		  | LM90_HAVE_CONVRATE | LM90_HAVE_REMOTE_EXT | LM90_HAVE_FAULTQUEUE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
 		.resolution = 12,
@@ -617,7 +636,7 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT
 		  | LM90_HAVE_ALARMS | LM90_HAVE_LOW | LM90_HAVE_CONVRATE
-		  | LM90_HAVE_REMOTE_EXT,
+		  | LM90_HAVE_REMOTE_EXT | LM90_HAVE_FAULTQUEUE,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
 		.resolution = 12,
@@ -684,10 +703,13 @@ struct lm90_data {
 	u8 reg_status2;		/* 2nd status register (optional) */
 	u8 reg_local_ext;	/* local extension register offset */
 	u8 reg_remote_ext;	/* remote temperature low byte */
+	u8 faultqueue_mask;	/* fault queue mask */
+	u8 faultqueue_depth;	/* fault queue mask */
 
 	/* registers values */
 	u16 temp[TEMP_REG_NUM];
 	u8 temp_hyst;
+	u8 conalert;
 	u16 reported_alarms;	/* alarms reported as sysfs/udev events */
 	u16 current_alarms;	/* current alarms, reported by chip */
 	u16 alarms;		/* alarms not yet reported to user */
@@ -888,6 +910,26 @@ static int lm90_set_convrate(struct i2c_client *client, struct lm90_data *data,
 	return err;
 }
 
+static int lm90_set_faultqueue(struct i2c_client *client,
+			       struct lm90_data *data, int val)
+{
+	int err;
+
+	if (data->faultqueue_mask) {
+		err = lm90_update_confreg(data, val <= data->faultqueue_depth / 2 ?
+					  data->config & ~data->faultqueue_mask :
+					  data->config | data->faultqueue_mask);
+	} else {
+		static const u8 values[4] = {0, 2, 6, 0x0e};
+
+		data->conalert = (data->conalert & 0xf1) | values[val - 1];
+		err = lm90_write_reg(data->client, TMP451_REG_CONALERT,
+				     data->conalert);
+	}
+
+	return err;
+}
+
 static int lm90_update_limits(struct device *dev)
 {
 	struct lm90_data *data = dev_get_drvdata(dev);
@@ -910,6 +952,12 @@ static int lm90_update_limits(struct device *dev)
 			return val;
 		data->temp_hyst = val;
 	}
+	if ((data->flags & LM90_HAVE_FAULTQUEUE) && !data->faultqueue_mask) {
+		val = lm90_read_reg(client, TMP451_REG_CONALERT);
+		if (val < 0)
+			return val;
+		data->conalert = val;
+	}
 
 	val = lm90_read16(client, LM90_REG_REMOTE_LOWH,
 			  (data->flags & LM90_HAVE_REM_LIMIT_EXT) ? LM90_REG_REMOTE_LOWL : 0,
@@ -1564,6 +1612,28 @@ static int lm90_chip_read(struct device *dev, u32 attr, int channel, long *val)
 	case hwmon_chip_alarms:
 		*val = data->alarms;
 		break;
+	case hwmon_chip_temp_samples:
+		if (data->faultqueue_mask) {
+			*val = (data->config & data->faultqueue_mask) ?
+				data->faultqueue_depth : 1;
+		} else {
+			switch (data->conalert & 0x0e) {
+			case 0x0:
+			default:
+				*val = 1;
+				break;
+			case 0x2:
+				*val = 2;
+				break;
+			case 0x6:
+				*val = 3;
+				break;
+			case 0xe:
+				*val = 4;
+				break;
+			}
+		}
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1588,6 +1658,9 @@ static int lm90_chip_write(struct device *dev, u32 attr, int channel, long val)
 		err = lm90_set_convrate(client, data,
 					clamp_val(val, 0, 100000));
 		break;
+	case hwmon_chip_temp_samples:
+		err = lm90_set_faultqueue(client, data, clamp_val(val, 1, 4));
+		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
@@ -1602,6 +1675,7 @@ static umode_t lm90_chip_is_visible(const void *data, u32 attr, int channel)
 {
 	switch (attr) {
 	case hwmon_chip_update_interval:
+	case hwmon_chip_temp_samples:
 		return 0644;
 	case hwmon_chip_alarms:
 		return 0444;
@@ -2605,7 +2679,8 @@ static int lm90_probe(struct i2c_client *client)
 		data->chip_config[0] |= HWMON_C_ALARMS;
 	if (data->flags & LM90_HAVE_CONVRATE)
 		data->chip_config[0] |= HWMON_C_UPDATE_INTERVAL;
-
+	if (data->flags & LM90_HAVE_FAULTQUEUE)
+		data->chip_config[0] |= HWMON_C_TEMP_SAMPLES;
 	data->info[1] = &data->temp_info;
 
 	info = &data->temp_info;
@@ -2656,6 +2731,8 @@ static int lm90_probe(struct i2c_client *client)
 			data->channel_config[2] |= HWMON_T_EMERGENCY_ALARM;
 	}
 
+	data->faultqueue_mask = lm90_params[data->kind].faultqueue_mask;
+	data->faultqueue_depth = lm90_params[data->kind].faultqueue_depth;
 	data->reg_local_ext = lm90_params[data->kind].reg_local_ext;
 	if (data->flags & LM90_HAVE_REMOTE_EXT)
 		data->reg_remote_ext = LM90_REG_REMOTE_TEMPL;
-- 
2.35.1

