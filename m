Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D782533E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244593AbiEYN75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244554AbiEYN6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:34 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2B49D042;
        Wed, 25 May 2022 06:58:31 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id e189so25098442oia.8;
        Wed, 25 May 2022 06:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vBDUJhqebQK0EchuMPSwdV2y1qOo7zyWzmIX6kJac8Y=;
        b=eptICbyyYXguOScjE8EwWPzAFShlsHEfP08jpl9g4zqLSatGXDywl/SyJtEwOFG0v+
         Qp9mHNBDO0jHsDFWL0WBl0oSTv+PwiRMaKbGQH/0vU5pWBqgpbn3W0zDEBVBJfUX0PuJ
         AHrGjVxkdHdF/qE5aq6m6a6ydFqCZ8XDyHyPOVmZLrnQFgEGLYpipifMCn2d6/u56OYY
         aXfW21MkM+u9f0cVtx96XMUbBWBnWOQ+TNNSkfq234pXK+B8gm/FI4rmXsTSN8OQbyVO
         pFw8/KZzF7FlJzZUvLWaHsOd5Usw/xTyjKqAU6I4hCdKLjaDECW7hMIE/aR+96kI0y/z
         LOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vBDUJhqebQK0EchuMPSwdV2y1qOo7zyWzmIX6kJac8Y=;
        b=SZpdb667o5af8clSeJfCL2R8tiM3xI/GQKj9wG5WsTEGXgwnb/0HPoA5UiQWBHeTVa
         nQPI2lKLabpuyIa8L1l/88+k+eBzEgF1rzEn8xFX5AUYOyOiS8tZrdHbv6UiCnYDizQL
         RV+3jpIlQqTBNe+f0VDDhRQgJwaYgjH4DN20yKngDc8sYiZD/U2YXS3XVZoh4iB6zzkV
         GbIH780u3Qu1b949Ym2sYDDrWyiyVUBEhj6fE8qh0qk4RbmNYDkw0iJtHDL16BhQeE9Z
         2xavfRAQcKzBN46kLJjXXXxW9IuZCve69Q0dNm+pNY8CyI8q41oAgHOEKqCz5DQNXZQ2
         8tSg==
X-Gm-Message-State: AOAM5337eefVMOWRPqfXxK1d5p4fSah1kn2uk5SsrwHJgG8APz/rrrsk
        t0p2l4LZYh8ZLzCy9ZarD3HWzJLWBZlJ7Q==
X-Google-Smtp-Source: ABdhPJygAv52/1lhGPe+6Qy1RkcBbElzfsMf6v6VPhLIj3/3oJGZ9/FHK/nu9Vw/mMQdqOhZyZdpHg==
X-Received: by 2002:a05:6808:1b29:b0:32b:6a06:8135 with SMTP id bx41-20020a0568081b2900b0032b6a068135mr5273130oib.220.1653487110528;
        Wed, 25 May 2022 06:58:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b124-20020acab282000000b0032ae369c25esm6409168oif.53.2022.05.25.06.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 15/40] hwmon: (lm90) Rework detect function
Date:   Wed, 25 May 2022 06:57:33 -0700
Message-Id: <20220525135758.2944744-16-linux@roeck-us.net>
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

The detect function is getting larger and larger and difficult to
understand or review. Split it into per-manufacturer detect functions
to improve readability.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 379 +++++++++++++++++++++++++++----------------
 1 file changed, 236 insertions(+), 143 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index a0a91aa66177..f676b809c470 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1498,78 +1498,88 @@ static umode_t lm90_is_visible(const void *data, enum hwmon_sensor_types type,
 	}
 }
 
-/* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm90_detect(struct i2c_client *client,
-		       struct i2c_board_info *info)
+/*
+ * Per-manufacturer chip detect functions.
+ * Functions are expected to return a pointer to the chip name or NULL
+ * if detection was not successful.
+ */
+
+static const char *lm90_detect_national(struct i2c_client *client, int chip_id,
+					int config1, int convrate)
 {
-	struct i2c_adapter *adapter = client->adapter;
+	int config2 = i2c_smbus_read_byte_data(client, LM90_REG_CONFIG2);
 	int address = client->addr;
 	const char *name = NULL;
-	int man_id, chip_id, config1, config2, convrate;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		return -ENODEV;
+	if (config2 < 0)
+		return NULL;
 
-	/* detection and identification */
-	man_id = i2c_smbus_read_byte_data(client, LM90_REG_MAN_ID);
-	chip_id = i2c_smbus_read_byte_data(client, LM90_REG_CHIP_ID);
-	config1 = i2c_smbus_read_byte_data(client, LM90_REG_CONFIG1);
-	convrate = i2c_smbus_read_byte_data(client, LM90_REG_CONVRATE);
-	if (man_id < 0 || chip_id < 0 || config1 < 0 || convrate < 0)
-		return -ENODEV;
+	if ((config1 & 0x2a) || (config2 & 0xf8) || convrate > 0x09)
+		return NULL;
 
-	if (man_id == 0x01 || man_id == 0x5C || man_id == 0xA1) {
-		config2 = i2c_smbus_read_byte_data(client, LM90_REG_CONFIG2);
-		if (config2 < 0)
-			return -ENODEV;
+	if (address != 0x4c && address != 0x4d)
+		return NULL;
+
+	switch (chip_id & 0xf0) {
+	case 0x10:	/* LM86 */
+		if (address == 0x4c)
+			name = "lm86";
+		break;
+	case 0x20:	/* LM90 */
+		if (address == 0x4c)
+			name = "lm90";
+		break;
+	case 0x30:	/* LM89/LM99 */
+		name = "lm99";	/* detect LM89 as LM99 */
+		break;
+	default:
+		break;
 	}
 
-	if ((address == 0x4C || address == 0x4D)
-	 && man_id == 0x01) { /* National Semiconductor */
-		if ((config1 & 0x2A) == 0x00
-		 && (config2 & 0xF8) == 0x00
-		 && convrate <= 0x09) {
-			if (address == 0x4C
-			 && (chip_id & 0xF0) == 0x20) { /* LM90 */
-				name = "lm90";
-			} else
-			if ((chip_id & 0xF0) == 0x30) { /* LM89/LM99 */
-				name = "lm99";
-				dev_info(&adapter->dev,
-					 "Assuming LM99 chip at 0x%02x\n",
-					 address);
-				dev_info(&adapter->dev,
-					 "If it is an LM89, instantiate it "
-					 "with the new_device sysfs "
-					 "interface\n");
-			} else
-			if (address == 0x4C
-			 && (chip_id & 0xF0) == 0x10) { /* LM86 */
-				name = "lm86";
-			}
-		}
-	} else
-	if ((address == 0x4C || address == 0x4D)
-	 && man_id == 0x41) { /* Analog Devices */
-		if ((chip_id & 0xF0) == 0x40 /* ADM1032 */
-		 && (config1 & 0x3F) == 0x00
-		 && convrate <= 0x0A) {
+	return name;
+}
+
+static const char *lm90_detect_analog(struct i2c_client *client, int chip_id,
+				      int config1, int convrate)
+{
+	int address = client->addr;
+	const char *name = NULL;
+
+	switch (chip_id) {
+	case 0x40 ... 0x4f:	/* ADM1032 */
+		if ((address == 0x4c || address == 0x4d) && !(config1 & 0x3f) &&
+		    convrate <= 0x0a)
 			name = "adm1032";
-		} else
-		if (chip_id == 0x51 /* ADT7461 */
-		 && (config1 & 0x1B) == 0x00
-		 && convrate <= 0x0A) {
+		break;
+	case 0x51:	/* ADT7461 */
+		if ((address == 0x4c || address == 0x4d) && !(config1 & 0x1b) &&
+		    convrate <= 0x0a)
 			name = "adt7461";
-		} else
-		if (chip_id == 0x57 /* ADT7461A, NCT1008 */
-		 && (config1 & 0x1B) == 0x00
-		 && convrate <= 0x0A) {
+		break;
+	case 0x57:	/* ADT7461A, NCT1008 */
+		if ((address == 0x4c || address == 0x4d) && !(config1 & 0x1b) &&
+		    convrate <= 0x0a)
 			name = "adt7461a";
-		}
-	} else
-	if (man_id == 0x4D) { /* Maxim */
-		int emerg, emerg2, status2;
+		break;
+	default:
+		break;
+	}
 
+	return name;
+}
+
+static const char *lm90_detect_maxim(struct i2c_client *client, int chip_id,
+				     int config1, int convrate)
+{
+	int man_id, emerg, emerg2, status2;
+	int address = client->addr;
+	const char *name = NULL;
+
+	if ((address >= 0x48 && address <= 0x4b) || address == 0x4f)
+		return NULL;
+
+	switch (chip_id) {
+	case 0x01:
 		/*
 		 * We read MAX6659_REG_REMOTE_EMERG twice, and re-read
 		 * LM90_REG_MAN_ID in between. If MAX6659_REG_REMOTE_EMERG
@@ -1585,30 +1595,8 @@ static int lm90_detect(struct i2c_client *client,
 		status2 = i2c_smbus_read_byte_data(client,
 						   MAX6696_REG_STATUS2);
 		if (emerg < 0 || man_id < 0 || emerg2 < 0 || status2 < 0)
-			return -ENODEV;
+			return NULL;
 
-		/*
-		 * The MAX6657, MAX6658 and MAX6659 do NOT have a chip_id
-		 * register. Reading from that address will return the last
-		 * read value, which in our case is those of the man_id
-		 * register. Likewise, the config1 register seems to lack a
-		 * low nibble, so the value will be those of the previous
-		 * read, so in our case those of the man_id register.
-		 * MAX6659 has a third set of upper temperature limit registers.
-		 * Those registers also return values on MAX6657 and MAX6658,
-		 * thus the only way to detect MAX6659 is by its address.
-		 * For this reason it will be mis-detected as MAX6657 if its
-		 * address is 0x4C.
-		 */
-		if (chip_id == man_id
-		 && (address == 0x4C || address == 0x4D || address == 0x4E)
-		 && (config1 & 0x1F) == (man_id & 0x0F)
-		 && convrate <= 0x09) {
-			if (address == 0x4C)
-				name = "max6657";
-			else
-				name = "max6659";
-		} else
 		/*
 		 * Even though MAX6695 and MAX6696 do not have a chip ID
 		 * register, reading it returns 0x01. Bit 4 of the config1
@@ -1620,77 +1608,137 @@ static int lm90_detect(struct i2c_client *client,
 		 * limit registers. We can detect those chips by checking if
 		 * one of those registers exists.
 		 */
-		if (chip_id == 0x01
-		 && (config1 & 0x10) == 0x00
-		 && (status2 & 0x01) == 0x00
-		 && emerg == emerg2
-		 && convrate <= 0x07) {
+		if (!(config1 & 0x10) && !(status2 & 0x01) && emerg == emerg2 &&
+		    convrate <= 0x07)
 			name = "max6696";
-		} else
 		/*
 		 * The chip_id register of the MAX6680 and MAX6681 holds the
 		 * revision of the chip. The lowest bit of the config1 register
 		 * is unused and should return zero when read, so should the
 		 * second to last bit of config1 (software reset).
 		 */
-		if (chip_id == 0x01
-		 && (config1 & 0x03) == 0x00
-		 && convrate <= 0x07) {
+		else if (!(config1 & 0x03) && convrate <= 0x07)
 			name = "max6680";
-		} else
-		/*
-		 * The chip_id register of the MAX6646/6647/6649 holds the
-		 * revision of the chip. The lowest 6 bits of the config1
-		 * register are unused and should return zero when read.
-		 */
-		if (chip_id == 0x59
-		 && (config1 & 0x3f) == 0x00
-		 && convrate <= 0x07) {
-			name = "max6646";
-		} else
+		break;
+	case 0x08:
 		/*
 		 * The chip_id of the MAX6654 holds the revision of the chip.
 		 * The lowest 3 bits of the config1 register are unused and
 		 * should return zero when read.
 		 */
-		if (chip_id == 0x08
-		 && (config1 & 0x07) == 0x00
-		 && convrate <= 0x07) {
+		if (!(config1 & 0x07) && convrate <= 0x07)
 			name = "max6654";
+		break;
+	case 0x4d:
+		/*
+		 * The MAX6657, MAX6658 and MAX6659 do NOT have a chip_id
+		 * register. Reading from that address will return the last
+		 * read value, which in our case is those of the man_id
+		 * register, or 0x4d. Likewise, the config1 register seems to
+		 * lack a low nibble, so the value will be those of the previous
+		 * read, so in our case again those of the man_id register.
+		 * MAX6659 has a third set of upper temperature limit registers.
+		 * Those registers also return values on MAX6657 and MAX6658,
+		 * thus the only way to detect MAX6659 is by its address.
+		 * For this reason it will be mis-detected as MAX6657 if its
+		 * address is 0x4c.
+		 */
+		if ((address == 0x4c || address == 0x4d || address == 0x4e) &&
+		    (config1 & 0x1f) == 0x0d && convrate <= 0x09) {
+			if (address == 0x4c)
+				name = "max6657";
+			else
+				name = "max6659";
 		}
-	} else
-	if (address == 0x4C
-	 && man_id == 0x5C) { /* Winbond/Nuvoton */
-		if ((config1 & 0x2A) == 0x00
-		 && (config2 & 0xF8) == 0x00) {
-			if (chip_id == 0x01 /* W83L771W/G */
-			 && convrate <= 0x09) {
-				name = "w83l771";
-			} else
-			if ((chip_id & 0xFE) == 0x10 /* W83L771AWG/ASG */
-			 && convrate <= 0x08) {
-				name = "w83l771";
+		break;
+	case 0x59:
+		/*
+		 * The chip_id register of the MAX6646/6647/6649 holds the
+		 * revision of the chip. The lowest 6 bits of the config1
+		 * register are unused and should return zero when read.
+		 */
+		if (!(config1 & 0x3f) && convrate <= 0x07) {
+			switch (address) {
+			case 0x4c:
+				name = "max6649";
+				break;
+			case 0x4d:
+				name = "max6646";
+				break;
+			case 0x4e:
+				name = "max6647";
+				break;
+			default:
+				break;
 			}
 		}
-	} else
-	if (address >= 0x48 && address <= 0x4F
-	 && man_id == 0xA1) { /*  NXP Semiconductor/Philips */
-		if (chip_id == 0x00
-		 && (config1 & 0x2A) == 0x00
-		 && (config2 & 0xFE) == 0x00
-		 && convrate <= 0x09) {
-			name = "sa56004";
+		break;
+	default:
+		break;
+	}
+
+	return name;
+}
+
+static const char *lm90_detect_nuvoton(struct i2c_client *client, int chip_id,
+				       int config1, int convrate)
+{
+	int config2 = i2c_smbus_read_byte_data(client, LM90_REG_CONFIG2);
+	int address = client->addr;
+	const char *name = NULL;
+
+	if (config2 < 0)
+		return ERR_PTR(-ENODEV);
+
+	if (address == 0x4c && !(config1 & 0x2a) && !(config2 & 0xf8)) {
+		if (chip_id == 0x01 && convrate <= 0x09) {
+			/* W83L771W/G */
+			name = "w83l771";
+		} else if ((chip_id & 0xfe) == 0x10 && convrate <= 0x08) {
+			/* W83L771AWG/ASG */
+			name = "w83l771";
 		}
-	} else
-	if ((address == 0x4C || address == 0x4D)
-	 && man_id == 0x47) { /* GMT */
-		if (chip_id == 0x01 /* G781 */
-		 && (config1 & 0x3F) == 0x00
-		 && convrate <= 0x08)
-			name = "g781";
-	} else
-	if (man_id == 0x55 && chip_id == 0x00 &&
-	    (config1 & 0x1B) == 0x00 && convrate <= 0x09) {
+	}
+	return name;
+}
+
+static const char *lm90_detect_nxp(struct i2c_client *client, int chip_id,
+				   int config1, int convrate)
+{
+	int config2 = i2c_smbus_read_byte_data(client, LM90_REG_CONFIG2);
+	int address = client->addr;
+	const char *name = NULL;
+
+	if (config2 < 0)
+		return NULL;
+
+	if (address >= 0x48 && address <= 0x4f && chip_id == 0x00 &&
+	    !(config1 & 0x2a) && !(config2 & 0xfe) && convrate <= 0x09)
+		name = "sa56004";
+
+	return name;
+}
+
+static const char *lm90_detect_gmt(struct i2c_client *client, int chip_id,
+				   int config1, int convrate)
+{
+	int address = client->addr;
+	const char *name = NULL;
+
+	if ((address == 0x4c || address == 0x4d) && chip_id == 0x01 &&
+	    !(config1 & 0x3f) && convrate <= 0x08)
+		name = "g781";
+
+	return name;
+}
+
+static const char *lm90_detect_ti(struct i2c_client *client, int chip_id,
+				  int config1, int convrate)
+{
+	int address = client->addr;
+	const char *name = NULL;
+
+	if (chip_id == 0x00 && !(config1 & 0x1b) && convrate <= 0x09) {
 		int local_ext, conalert, chen, dfc;
 
 		local_ext = i2c_smbus_read_byte_data(client,
@@ -1700,10 +1748,8 @@ static int lm90_detect(struct i2c_client *client,
 		chen = i2c_smbus_read_byte_data(client, TMP461_REG_CHEN);
 		dfc = i2c_smbus_read_byte_data(client, TMP461_REG_DFC);
 
-		if ((local_ext & 0x0F) == 0x00 &&
-		    (conalert & 0xf1) == 0x01 &&
-		    (chen & 0xfc) == 0x00 &&
-		    (dfc & 0xfc) == 0x00) {
+		if (!(local_ext & 0x0f) && (conalert & 0xf1) == 0x01 &&
+		    (chen & 0xfc) == 0x00 && (dfc & 0xfc) == 0x00) {
 			if (address == 0x4c && !(chen & 0x03))
 				name = "tmp451";
 			else if (address >= 0x48 && address <= 0x4f)
@@ -1711,10 +1757,57 @@ static int lm90_detect(struct i2c_client *client,
 		}
 	}
 
-	if (!name) { /* identification failed */
+	return name;
+}
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int lm90_detect(struct i2c_client *client, struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	int man_id, chip_id, config1, convrate;
+	const char *name = NULL;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	/* detection and identification */
+	man_id = i2c_smbus_read_byte_data(client, LM90_REG_MAN_ID);
+	chip_id = i2c_smbus_read_byte_data(client, LM90_REG_CHIP_ID);
+	config1 = i2c_smbus_read_byte_data(client, LM90_REG_CONFIG1);
+	convrate = i2c_smbus_read_byte_data(client, LM90_REG_CONVRATE);
+	if (man_id < 0 || chip_id < 0 || config1 < 0 || convrate < 0)
+		return -ENODEV;
+
+	switch (man_id) {
+	case 0x01:	/* National Semiconductor */
+		name = lm90_detect_national(client, chip_id, config1, convrate);
+		break;
+	case 0x41:	/* Analog Devices */
+		name = lm90_detect_analog(client, chip_id, config1, convrate);
+		break;
+	case 0x47:	/* GMT */
+		name = lm90_detect_gmt(client, chip_id, config1, convrate);
+		break;
+	case 0x4d:	/* Maxim Integrated */
+		name = lm90_detect_maxim(client, chip_id, config1, convrate);
+		break;
+	case 0x55:	/* TI */
+		name = lm90_detect_ti(client, chip_id, config1, convrate);
+		break;
+	case 0x5c:	/* Winbond/Nuvoton */
+		name = lm90_detect_nuvoton(client, chip_id, config1, convrate);
+		break;
+	case 0xa1:	/*  NXP Semiconductor/Philips */
+		name = lm90_detect_nxp(client, chip_id, config1, convrate);
+		break;
+	default:
+		break;
+	}
+
+	if (!name) {	/* identification failed */
 		dev_dbg(&adapter->dev,
-			"Unsupported chip at 0x%02x (man_id=0x%02X, "
-			"chip_id=0x%02X)\n", address, man_id, chip_id);
+			"Unsupported chip at 0x%02x (man_id=0x%02X, chip_id=0x%02X)\n",
+			client->addr, man_id, chip_id);
 		return -ENODEV;
 	}
 
-- 
2.35.1

