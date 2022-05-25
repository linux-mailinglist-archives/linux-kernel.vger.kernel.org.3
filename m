Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7C4533E90
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiEYN6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244580AbiEYN6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:19 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0151A76DC;
        Wed, 25 May 2022 06:58:15 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id i66so25074039oia.11;
        Wed, 25 May 2022 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eK4umZIybU4hoc6zeJepRc4ysO3ew/yFehyxz+tBRBs=;
        b=Mt6LVhZWa067WaihuvdQ4qplc5J1/K8/DCJxeQPxVrwf9hYAfP3WKdv/iDO0goZSHi
         AQLxH1g3kDc+cELmJ2WqLDUS9lHoosdsl4p7gYKpcxN8kpLuaFYhSCuZ9Bn6zTygCvaD
         X+DbL+AEObr3+Sl8wXRtH7w8vSqsdTodT1RtnAQ/ZMAOgtnOxHf+otO0cPii+8SKEfyS
         266VU+Z9/DkY/ZejVwHRtXoTd3jeaYeN51K2dpvz5PCpwAAIiht/Sfcwky1K5+zX6+vx
         qPerIw2pNglbVVL2nJ+A23I9NFi7eq2tvURZhq9vqhkzszjxT3UtCkDONkUYnNrYlFIo
         QYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eK4umZIybU4hoc6zeJepRc4ysO3ew/yFehyxz+tBRBs=;
        b=lQusSEryaclnqub/ZZmJ92G8OrnaXD/OU1vL0Q1iapq6h+JL6uZWWmT/pznrBPrYA0
         M/tPxhZeLtA5pNGoDpdgT2cSWoNcu7drX3QIOHx46eBvNjaBTb7y1rA3yXKf5Xo5AsiB
         LAlRSR4pPZ8TA/mw2kUvJP/5PaPydRv5CLH2b6RJQBhmCuqIDsLibzRoEsB++3oDC47U
         SIE158Yid3NLZ7INWcPXDf/HqwP7oCHDr9lMkztn8WNST/U7oyxNI6BDyEK9hR402PwH
         +dYnf9aKKEWcYK9bv9jUBfToVg+ihl6osn/TvbQ3sXUth6p85wN93eElYwsCBH2CCnGt
         x5wA==
X-Gm-Message-State: AOAM530fyOm+jAwpfPcrxaBm8XWgDM17tgdJ0l+t/QyGEAXq5sVRF3CR
        MCydxc23a2FYZxzsxgg4yoYiDIJ0IvtzgQ==
X-Google-Smtp-Source: ABdhPJwELm1eawTi9KnEu8iEsjdduLa9nxMvn5nEvFraMDylctnnmzmB+3CM3T2vnqAm+gS92aPGNg==
X-Received: by 2002:a05:6808:1455:b0:32b:8c0a:6ada with SMTP id x21-20020a056808145500b0032b8c0a6adamr3531690oiv.71.1653487094560;
        Wed, 25 May 2022 06:58:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h6-20020a9d5546000000b0060b088dcbeesm4277267oti.27.2022.05.25.06.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 07/40] hwmon: (lm90) Stop using R_/W_ register prefix
Date:   Wed, 25 May 2022 06:57:25 -0700
Message-Id: <20220525135758.2944744-8-linux@roeck-us.net>
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

The register write address either matches the read address, or it is the
read address plus 6. Simplify the code and resolve the write address
programmatically instead of having two defines for each register.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 234 +++++++++++++++++++++----------------------
 1 file changed, 117 insertions(+), 117 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index cc26dd08fbff..995b27a248e6 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -123,58 +123,42 @@ enum chips { adm1032, adt7461, g781, lm86, lm90, lm99,
  * The LM90 registers
  */
 
-#define LM90_REG_R_MAN_ID		0xFE
-#define LM90_REG_R_CHIP_ID		0xFF
-#define LM90_REG_R_CONFIG1		0x03
-#define LM90_REG_W_CONFIG1		0x09
-#define LM90_REG_R_CONFIG2		0xBF
-#define LM90_REG_W_CONFIG2		0xBF
-#define LM90_REG_R_CONVRATE		0x04
-#define LM90_REG_W_CONVRATE		0x0A
-#define LM90_REG_R_STATUS		0x02
-#define LM90_REG_R_LOCAL_TEMP		0x00
-#define LM90_REG_R_LOCAL_HIGH		0x05
-#define LM90_REG_W_LOCAL_HIGH		0x0B
-#define LM90_REG_R_LOCAL_LOW		0x06
-#define LM90_REG_W_LOCAL_LOW		0x0C
-#define LM90_REG_R_LOCAL_CRIT		0x20
-#define LM90_REG_W_LOCAL_CRIT		0x20
-#define LM90_REG_R_REMOTE_TEMPH		0x01
-#define LM90_REG_R_REMOTE_TEMPL		0x10
-#define LM90_REG_R_REMOTE_OFFSH		0x11
-#define LM90_REG_W_REMOTE_OFFSH		0x11
-#define LM90_REG_R_REMOTE_OFFSL		0x12
-#define LM90_REG_W_REMOTE_OFFSL		0x12
-#define LM90_REG_R_REMOTE_HIGHH		0x07
-#define LM90_REG_W_REMOTE_HIGHH		0x0D
-#define LM90_REG_R_REMOTE_HIGHL		0x13
-#define LM90_REG_W_REMOTE_HIGHL		0x13
-#define LM90_REG_R_REMOTE_LOWH		0x08
-#define LM90_REG_W_REMOTE_LOWH		0x0E
-#define LM90_REG_R_REMOTE_LOWL		0x14
-#define LM90_REG_W_REMOTE_LOWL		0x14
-#define LM90_REG_R_REMOTE_CRIT		0x19
-#define LM90_REG_W_REMOTE_CRIT		0x19
-#define LM90_REG_R_TCRIT_HYST		0x21
-#define LM90_REG_W_TCRIT_HYST		0x21
+#define LM90_REG_MAN_ID			0xFE
+#define LM90_REG_CHIP_ID		0xFF
+#define LM90_REG_CONFIG1		0x03
+#define LM90_REG_CONFIG2		0xBF
+#define LM90_REG_CONVRATE		0x04
+#define LM90_REG_STATUS			0x02
+#define LM90_REG_LOCAL_TEMP		0x00
+#define LM90_REG_LOCAL_HIGH		0x05
+#define LM90_REG_LOCAL_LOW		0x06
+#define LM90_REG_LOCAL_CRIT		0x20
+#define LM90_REG_REMOTE_TEMPH		0x01
+#define LM90_REG_REMOTE_TEMPL		0x10
+#define LM90_REG_REMOTE_OFFSH		0x11
+#define LM90_REG_REMOTE_OFFSL		0x12
+#define LM90_REG_REMOTE_HIGHH		0x07
+#define LM90_REG_REMOTE_HIGHL		0x13
+#define LM90_REG_REMOTE_LOWH		0x08
+#define LM90_REG_REMOTE_LOWL		0x14
+#define LM90_REG_REMOTE_CRIT		0x19
+#define LM90_REG_TCRIT_HYST		0x21
 
 /* MAX6646/6647/6649/6654/6657/6658/6659/6695/6696 registers */
 
-#define MAX6657_REG_R_LOCAL_TEMPL	0x11
-#define MAX6696_REG_R_STATUS2		0x12
-#define MAX6659_REG_R_REMOTE_EMERG	0x16
-#define MAX6659_REG_W_REMOTE_EMERG	0x16
-#define MAX6659_REG_R_LOCAL_EMERG	0x17
-#define MAX6659_REG_W_LOCAL_EMERG	0x17
+#define MAX6657_REG_LOCAL_TEMPL		0x11
+#define MAX6696_REG_STATUS2		0x12
+#define MAX6659_REG_REMOTE_EMERG	0x16
+#define MAX6659_REG_LOCAL_EMERG		0x17
 
 /*  SA56004 registers */
 
-#define SA56004_REG_R_LOCAL_TEMPL 0x22
+#define SA56004_REG_LOCAL_TEMPL		0x22
 
 #define LM90_MAX_CONVRATE_MS	16000	/* Maximum conversion rate in ms */
 
 /* TMP451/TMP461 registers */
-#define TMP451_REG_R_LOCAL_TEMPL	0x15
+#define TMP451_REG_LOCAL_TEMPL		0x15
 #define TMP451_REG_CONALERT		0x22
 
 #define TMP461_REG_CHEN			0x16
@@ -401,25 +385,25 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_CRIT | LM90_HAVE_BROKEN_ALERT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 6,
-		.reg_local_ext = MAX6657_REG_R_LOCAL_TEMPL,
+		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6654] = {
 		.flags = LM90_HAVE_BROKEN_ALERT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
-		.reg_local_ext = MAX6657_REG_R_LOCAL_TEMPL,
+		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6657] = {
 		.flags = LM90_PAUSE_FOR_CONFIG | LM90_HAVE_CRIT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
-		.reg_local_ext = MAX6657_REG_R_LOCAL_TEMPL,
+		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6659] = {
 		.flags = LM90_HAVE_EMERGENCY | LM90_HAVE_CRIT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 8,
-		.reg_local_ext = MAX6657_REG_R_LOCAL_TEMPL,
+		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[max6680] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_CRIT
@@ -432,7 +416,7 @@ static const struct lm90_params lm90_params[] = {
 		  | LM90_HAVE_EMERGENCY_ALARM | LM90_HAVE_TEMP3 | LM90_HAVE_CRIT,
 		.alert_alarms = 0x1c7c,
 		.max_convrate = 6,
-		.reg_local_ext = MAX6657_REG_R_LOCAL_TEMPL,
+		.reg_local_ext = MAX6657_REG_LOCAL_TEMPL,
 	},
 	[w83l771] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT,
@@ -443,21 +427,21 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT | LM90_HAVE_CRIT,
 		.alert_alarms = 0x7b,
 		.max_convrate = 9,
-		.reg_local_ext = SA56004_REG_R_LOCAL_TEMPL,
+		.reg_local_ext = SA56004_REG_LOCAL_TEMPL,
 	},
 	[tmp451] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
-		.reg_local_ext = TMP451_REG_R_LOCAL_TEMPL,
+		.reg_local_ext = TMP451_REG_LOCAL_TEMPL,
 	},
 	[tmp461] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT | LM90_HAVE_EXTENDED_TEMP | LM90_HAVE_CRIT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 9,
-		.reg_local_ext = TMP451_REG_R_LOCAL_TEMPL,
+		.reg_local_ext = TMP451_REG_LOCAL_TEMPL,
 	},
 };
 
@@ -565,6 +549,29 @@ static int lm90_read_reg(struct i2c_client *client, u8 reg)
 	return err;
 }
 
+/*
+ * Return register write address
+ *
+ * The write address for registers 0x03 .. 0x08 is the read address plus 6.
+ * For other registers the write address matches the read address.
+ */
+static u8 lm90_write_reg_addr(u8 reg)
+{
+	if (reg >= LM90_REG_CONFIG1 && reg <= LM90_REG_REMOTE_LOWH)
+		return reg + 6;
+	return reg;
+}
+
+/*
+ * Write into LM90 register.
+ * Convert register address to write address if needed, then execute the
+ * operation.
+ */
+static int lm90_write_reg(struct i2c_client *client, u8 reg, u8 val)
+{
+	return i2c_smbus_write_byte_data(client, lm90_write_reg_addr(reg), val);
+}
+
 static int lm90_read16(struct i2c_client *client, u8 regh, u8 regl)
 {
 	int oldh, newh, l;
@@ -604,9 +611,7 @@ static int lm90_update_confreg(struct lm90_data *data, u8 config)
 	if (data->config != config) {
 		int err;
 
-		err = i2c_smbus_write_byte_data(data->client,
-						LM90_REG_W_CONFIG1,
-						config);
+		err = lm90_write_reg(data->client, LM90_REG_CONFIG1, config);
 		if (err)
 			return err;
 		data->config = config;
@@ -649,7 +654,7 @@ static int lm90_write_convrate(struct lm90_data *data, int val)
 	}
 
 	/* Set conv rate */
-	err = i2c_smbus_write_byte_data(data->client, LM90_REG_W_CONVRATE, val);
+	err = lm90_write_reg(data->client, LM90_REG_CONVRATE, val);
 
 	/* Revert change to config */
 	lm90_update_confreg(data, config);
@@ -689,61 +694,61 @@ static int lm90_update_limits(struct device *dev)
 	int val;
 
 	if (data->flags & LM90_HAVE_CRIT) {
-		val = lm90_read_reg(client, LM90_REG_R_LOCAL_CRIT);
+		val = lm90_read_reg(client, LM90_REG_LOCAL_CRIT);
 		if (val < 0)
 			return val;
 		data->temp8[LOCAL_CRIT] = val;
 
-		val = lm90_read_reg(client, LM90_REG_R_REMOTE_CRIT);
+		val = lm90_read_reg(client, LM90_REG_REMOTE_CRIT);
 		if (val < 0)
 			return val;
 		data->temp8[REMOTE_CRIT] = val;
 
-		val = lm90_read_reg(client, LM90_REG_R_TCRIT_HYST);
+		val = lm90_read_reg(client, LM90_REG_TCRIT_HYST);
 		if (val < 0)
 			return val;
 		data->temp_hyst = val;
 	}
 
-	val = lm90_read_reg(client, LM90_REG_R_REMOTE_LOWH);
+	val = lm90_read_reg(client, LM90_REG_REMOTE_LOWH);
 	if (val < 0)
 		return val;
 	data->temp11[REMOTE_LOW] = val << 8;
 
 	if (data->flags & LM90_HAVE_REM_LIMIT_EXT) {
-		val = lm90_read_reg(client, LM90_REG_R_REMOTE_LOWL);
+		val = lm90_read_reg(client, LM90_REG_REMOTE_LOWL);
 		if (val < 0)
 			return val;
 		data->temp11[REMOTE_LOW] |= val;
 	}
 
-	val = lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHH);
+	val = lm90_read_reg(client, LM90_REG_REMOTE_HIGHH);
 	if (val < 0)
 		return val;
 	data->temp11[REMOTE_HIGH] = val << 8;
 
 	if (data->flags & LM90_HAVE_REM_LIMIT_EXT) {
-		val = lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHL);
+		val = lm90_read_reg(client, LM90_REG_REMOTE_HIGHL);
 		if (val < 0)
 			return val;
 		data->temp11[REMOTE_HIGH] |= val;
 	}
 
 	if (data->flags & LM90_HAVE_OFFSET) {
-		val = lm90_read16(client, LM90_REG_R_REMOTE_OFFSH,
-				  LM90_REG_R_REMOTE_OFFSL);
+		val = lm90_read16(client, LM90_REG_REMOTE_OFFSH,
+				  LM90_REG_REMOTE_OFFSL);
 		if (val < 0)
 			return val;
 		data->temp11[REMOTE_OFFSET] = val;
 	}
 
 	if (data->flags & LM90_HAVE_EMERGENCY) {
-		val = lm90_read_reg(client, MAX6659_REG_R_LOCAL_EMERG);
+		val = lm90_read_reg(client, MAX6659_REG_LOCAL_EMERG);
 		if (val < 0)
 			return val;
 		data->temp8[LOCAL_EMERG] = val;
 
-		val = lm90_read_reg(client, MAX6659_REG_R_REMOTE_EMERG);
+		val = lm90_read_reg(client, MAX6659_REG_REMOTE_EMERG);
 		if (val < 0)
 			return val;
 		data->temp8[REMOTE_EMERG] = val;
@@ -754,22 +759,22 @@ static int lm90_update_limits(struct device *dev)
 		if (val < 0)
 			return val;
 
-		val = lm90_read_reg(client, LM90_REG_R_REMOTE_CRIT);
+		val = lm90_read_reg(client, LM90_REG_REMOTE_CRIT);
 		if (val < 0)
 			return val;
 		data->temp8[REMOTE2_CRIT] = val;
 
-		val = lm90_read_reg(client, MAX6659_REG_R_REMOTE_EMERG);
+		val = lm90_read_reg(client, MAX6659_REG_REMOTE_EMERG);
 		if (val < 0)
 			return val;
 		data->temp8[REMOTE2_EMERG] = val;
 
-		val = lm90_read_reg(client, LM90_REG_R_REMOTE_LOWH);
+		val = lm90_read_reg(client, LM90_REG_REMOTE_LOWH);
 		if (val < 0)
 			return val;
 		data->temp11[REMOTE2_LOW] = val << 8;
 
-		val = lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHH);
+		val = lm90_read_reg(client, LM90_REG_REMOTE_HIGHH);
 		if (val < 0)
 			return val;
 		data->temp11[REMOTE2_HIGH] = val << 8;
@@ -852,13 +857,13 @@ static int lm90_update_alarms_locked(struct lm90_data *data, bool force)
 
 		data->alarms_valid = false;
 
-		val = lm90_read_reg(client, LM90_REG_R_STATUS);
+		val = lm90_read_reg(client, LM90_REG_STATUS);
 		if (val < 0)
 			return val;
 		alarms = val & ~LM90_STATUS_BUSY;
 
 		if (data->kind == max6696) {
-			val = lm90_read_reg(client, MAX6696_REG_R_STATUS2);
+			val = lm90_read_reg(client, MAX6696_REG_STATUS2);
 			if (val < 0)
 				return val;
 			alarms |= val << 8;
@@ -952,30 +957,30 @@ static int lm90_update_device(struct device *dev)
 
 		data->valid = false;
 
-		val = lm90_read_reg(client, LM90_REG_R_LOCAL_LOW);
+		val = lm90_read_reg(client, LM90_REG_LOCAL_LOW);
 		if (val < 0)
 			return val;
 		data->temp8[LOCAL_LOW] = val;
 
-		val = lm90_read_reg(client, LM90_REG_R_LOCAL_HIGH);
+		val = lm90_read_reg(client, LM90_REG_LOCAL_HIGH);
 		if (val < 0)
 			return val;
 		data->temp8[LOCAL_HIGH] = val;
 
 		if (data->reg_local_ext) {
-			val = lm90_read16(client, LM90_REG_R_LOCAL_TEMP,
+			val = lm90_read16(client, LM90_REG_LOCAL_TEMP,
 					  data->reg_local_ext);
 			if (val < 0)
 				return val;
 			data->temp11[LOCAL_TEMP] = val;
 		} else {
-			val = lm90_read_reg(client, LM90_REG_R_LOCAL_TEMP);
+			val = lm90_read_reg(client, LM90_REG_LOCAL_TEMP);
 			if (val < 0)
 				return val;
 			data->temp11[LOCAL_TEMP] = val << 8;
 		}
-		val = lm90_read16(client, LM90_REG_R_REMOTE_TEMPH,
-				  LM90_REG_R_REMOTE_TEMPL);
+		val = lm90_read16(client, LM90_REG_REMOTE_TEMPH,
+				  LM90_REG_REMOTE_TEMPL);
 		if (val < 0)
 			return val;
 		data->temp11[REMOTE_TEMP] = val;
@@ -985,8 +990,8 @@ static int lm90_update_device(struct device *dev)
 			if (val < 0)
 				return val;
 
-			val = lm90_read16(client, LM90_REG_R_REMOTE_TEMPH,
-					  LM90_REG_R_REMOTE_TEMPL);
+			val = lm90_read16(client, LM90_REG_REMOTE_TEMPH,
+					  LM90_REG_REMOTE_TEMPL);
 			if (val < 0) {
 				lm90_select_remote_channel(data, 0);
 				return val;
@@ -1191,11 +1196,11 @@ static int lm90_set_temp11(struct lm90_data *data, int index, long val)
 		u8 high;
 		u8 low;
 	} reg[] = {
-	[REMOTE_LOW] = { LM90_REG_W_REMOTE_LOWH, LM90_REG_W_REMOTE_LOWL },
-	[REMOTE_HIGH] = { LM90_REG_W_REMOTE_HIGHH, LM90_REG_W_REMOTE_HIGHL },
-	[REMOTE_OFFSET] = { LM90_REG_W_REMOTE_OFFSH, LM90_REG_W_REMOTE_OFFSL },
-	[REMOTE2_LOW] = { LM90_REG_W_REMOTE_LOWH, LM90_REG_W_REMOTE_LOWL },
-	[REMOTE2_HIGH] = { LM90_REG_W_REMOTE_HIGHH, LM90_REG_W_REMOTE_HIGHL }
+	[REMOTE_LOW] = { LM90_REG_REMOTE_LOWH, LM90_REG_REMOTE_LOWL },
+	[REMOTE_HIGH] = { LM90_REG_REMOTE_HIGHH, LM90_REG_REMOTE_HIGHL },
+	[REMOTE_OFFSET] = { LM90_REG_REMOTE_OFFSH, LM90_REG_REMOTE_OFFSL },
+	[REMOTE2_LOW] = { LM90_REG_REMOTE_LOWH, LM90_REG_REMOTE_LOWL },
+	[REMOTE2_HIGH] = { LM90_REG_REMOTE_HIGHH, LM90_REG_REMOTE_HIGHL }
 	};
 	struct i2c_client *client = data->client;
 	struct reg *regp = &reg[index];
@@ -1218,13 +1223,12 @@ static int lm90_set_temp11(struct lm90_data *data, int index, long val)
 		data->temp11[index] = temp_to_s8(val) << 8;
 
 	lm90_select_remote_channel(data, index >= 3);
-	err = i2c_smbus_write_byte_data(client, regp->high,
-				  data->temp11[index] >> 8);
+	err = lm90_write_reg(client, regp->high, data->temp11[index] >> 8);
 	if (err < 0)
 		return err;
 	if (data->flags & LM90_HAVE_REM_LIMIT_EXT)
-		err = i2c_smbus_write_byte_data(client, regp->low,
-						data->temp11[index] & 0xff);
+		err = lm90_write_reg(client, regp->low,
+				     data->temp11[index] & 0xff);
 
 	lm90_select_remote_channel(data, 0);
 	return err;
@@ -1252,14 +1256,14 @@ static int lm90_get_temp8(struct lm90_data *data, int index)
 static int lm90_set_temp8(struct lm90_data *data, int index, long val)
 {
 	static const u8 reg[TEMP8_REG_NUM] = {
-		LM90_REG_W_LOCAL_LOW,
-		LM90_REG_W_LOCAL_HIGH,
-		LM90_REG_W_LOCAL_CRIT,
-		LM90_REG_W_REMOTE_CRIT,
-		MAX6659_REG_W_LOCAL_EMERG,
-		MAX6659_REG_W_REMOTE_EMERG,
-		LM90_REG_W_REMOTE_CRIT,
-		MAX6659_REG_W_REMOTE_EMERG,
+		LM90_REG_LOCAL_LOW,
+		LM90_REG_LOCAL_HIGH,
+		LM90_REG_LOCAL_CRIT,
+		LM90_REG_REMOTE_CRIT,
+		MAX6659_REG_LOCAL_EMERG,
+		MAX6659_REG_REMOTE_EMERG,
+		LM90_REG_REMOTE_CRIT,
+		MAX6659_REG_REMOTE_EMERG,
 	};
 	struct i2c_client *client = data->client;
 	int err;
@@ -1279,7 +1283,7 @@ static int lm90_set_temp8(struct lm90_data *data, int index, long val)
 		data->temp8[index] = temp_to_s8(val);
 
 	lm90_select_remote_channel(data, index >= 6);
-	err = i2c_smbus_write_byte_data(client, reg[index], data->temp8[index]);
+	err = lm90_write_reg(client, reg[index], data->temp8[index]);
 	lm90_select_remote_channel(data, 0);
 
 	return err;
@@ -1307,7 +1311,6 @@ static int lm90_set_temphyst(struct lm90_data *data, long val)
 {
 	struct i2c_client *client = data->client;
 	int temp;
-	int err;
 
 	if (data->flags & LM90_HAVE_EXTENDED_TEMP)
 		temp = temp_from_u8_adt7461(data, data->temp8[LOCAL_CRIT]);
@@ -1320,9 +1323,7 @@ static int lm90_set_temphyst(struct lm90_data *data, long val)
 	val = clamp_val(val, -128000l, 255000l);
 
 	data->temp_hyst = hyst_to_reg(temp - val);
-	err = i2c_smbus_write_byte_data(client, LM90_REG_W_TCRIT_HYST,
-					data->temp_hyst);
-	return err;
+	return lm90_write_reg(client, LM90_REG_TCRIT_HYST, data->temp_hyst);
 }
 
 static const u8 lm90_temp_index[3] = {
@@ -1630,15 +1631,15 @@ static int lm90_detect(struct i2c_client *client,
 		return -ENODEV;
 
 	/* detection and identification */
-	man_id = i2c_smbus_read_byte_data(client, LM90_REG_R_MAN_ID);
-	chip_id = i2c_smbus_read_byte_data(client, LM90_REG_R_CHIP_ID);
-	config1 = i2c_smbus_read_byte_data(client, LM90_REG_R_CONFIG1);
-	convrate = i2c_smbus_read_byte_data(client, LM90_REG_R_CONVRATE);
+	man_id = i2c_smbus_read_byte_data(client, LM90_REG_MAN_ID);
+	chip_id = i2c_smbus_read_byte_data(client, LM90_REG_CHIP_ID);
+	config1 = i2c_smbus_read_byte_data(client, LM90_REG_CONFIG1);
+	convrate = i2c_smbus_read_byte_data(client, LM90_REG_CONVRATE);
 	if (man_id < 0 || chip_id < 0 || config1 < 0 || convrate < 0)
 		return -ENODEV;
 
 	if (man_id == 0x01 || man_id == 0x5C || man_id == 0xA1) {
-		config2 = i2c_smbus_read_byte_data(client, LM90_REG_R_CONFIG2);
+		config2 = i2c_smbus_read_byte_data(client, LM90_REG_CONFIG2);
 		if (config2 < 0)
 			return -ENODEV;
 	}
@@ -1697,19 +1698,19 @@ static int lm90_detect(struct i2c_client *client,
 		int emerg, emerg2, status2;
 
 		/*
-		 * We read MAX6659_REG_R_REMOTE_EMERG twice, and re-read
-		 * LM90_REG_R_MAN_ID in between. If MAX6659_REG_R_REMOTE_EMERG
+		 * We read MAX6659_REG_REMOTE_EMERG twice, and re-read
+		 * LM90_REG_MAN_ID in between. If MAX6659_REG_REMOTE_EMERG
 		 * exists, both readings will reflect the same value. Otherwise,
 		 * the readings will be different.
 		 */
 		emerg = i2c_smbus_read_byte_data(client,
-						 MAX6659_REG_R_REMOTE_EMERG);
+						 MAX6659_REG_REMOTE_EMERG);
 		man_id = i2c_smbus_read_byte_data(client,
-						  LM90_REG_R_MAN_ID);
+						  LM90_REG_MAN_ID);
 		emerg2 = i2c_smbus_read_byte_data(client,
-						  MAX6659_REG_R_REMOTE_EMERG);
+						  MAX6659_REG_REMOTE_EMERG);
 		status2 = i2c_smbus_read_byte_data(client,
-						   MAX6696_REG_R_STATUS2);
+						   MAX6696_REG_STATUS2);
 		if (emerg < 0 || man_id < 0 || emerg2 < 0 || status2 < 0)
 			return -ENODEV;
 
@@ -1820,7 +1821,7 @@ static int lm90_detect(struct i2c_client *client,
 		int local_ext, conalert, chen, dfc;
 
 		local_ext = i2c_smbus_read_byte_data(client,
-						     TMP451_REG_R_LOCAL_TEMPL);
+						     TMP451_REG_LOCAL_TEMPL);
 		conalert = i2c_smbus_read_byte_data(client,
 						    TMP451_REG_CONALERT);
 		chen = i2c_smbus_read_byte_data(client, TMP461_REG_CHEN);
@@ -1858,8 +1859,7 @@ static void lm90_restore_conf(void *_data)
 
 	/* Restore initial configuration */
 	lm90_write_convrate(data, data->convrate_orig);
-	i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
-				  data->config_orig);
+	lm90_write_reg(client, LM90_REG_CONFIG1, data->config_orig);
 }
 
 static int lm90_init_client(struct i2c_client *client, struct lm90_data *data)
@@ -1867,7 +1867,7 @@ static int lm90_init_client(struct i2c_client *client, struct lm90_data *data)
 	struct device_node *np = client->dev.of_node;
 	int config, convrate;
 
-	convrate = lm90_read_reg(client, LM90_REG_R_CONVRATE);
+	convrate = lm90_read_reg(client, LM90_REG_CONVRATE);
 	if (convrate < 0)
 		return convrate;
 	data->convrate_orig = convrate;
@@ -1875,7 +1875,7 @@ static int lm90_init_client(struct i2c_client *client, struct lm90_data *data)
 	/*
 	 * Start the conversions.
 	 */
-	config = lm90_read_reg(client, LM90_REG_R_CONFIG1);
+	config = lm90_read_reg(client, LM90_REG_CONFIG1);
 	if (config < 0)
 		return config;
 	data->config_orig = config;
-- 
2.35.1

