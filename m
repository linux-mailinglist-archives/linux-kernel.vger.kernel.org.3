Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B703533E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiEYN7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244579AbiEYN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:29 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9311AB0D0;
        Wed, 25 May 2022 06:58:25 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id k186so4103819oia.2;
        Wed, 25 May 2022 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sEoneCER2gkh7aAYelCHIFcKt4065TAfR6A11z1fOZY=;
        b=f5Bf66TNq0tqV0D9ItlE8rbuFAA1WHB9gwMLrWpe4hfki554ITD0TXus9l51zp3Eb0
         KYosySMBL5yzDB5F0g6iT/ja6MNY5HfdQ8meFl3raNwz6YoxDZXX9rYXrgwG9ulmUqAP
         XWBUiN4OBQmDVR1SoqaT8wRkWlWywl9sweoBXYGbFNznSOiI/jBp8Yx6Zu6trVeKamG+
         ZiYpsNAbScLqUvdf17RfHhRy4hpD2+3rBS9v3TUdBXItDL9fQQGjxSGdRydncBcSPFxk
         gm9p5/3K1xJ1FEh4TRoUlchxAWlBCkwiRBFygeP2N64f064qxq7fkSWIAutsxsDaI6cr
         YUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sEoneCER2gkh7aAYelCHIFcKt4065TAfR6A11z1fOZY=;
        b=pS4Hqc8/mz7A+ge+okmJFYbojBLDzMvziUzI+CPvqYUW7odk+3bmgcp89IyztliyTp
         /6Ei3HUHdrjDMfItzWj2xgiOvVMCYOCRlRKKgus8+OW1XjX991cAYaV2AgmOTlNhVjD0
         ocICKNTFO4WFN9/eqlXef9Zn6uTBrp3VsFqoLJio2EyvjW72erVJL2qQxMgv2i5tmKzp
         x6quOAGcHTZAq2gnsPGOzwzPogNO2JAT7f8q71XsKuovNapcOMyqj/mDFW1ilj2l7ir2
         /LKoALnsMd+kmc2hScC7daJCR1uG26rZim2edFcKJN8Nt6CqVfIGOiCuwbzXEY3SIcF/
         YJTw==
X-Gm-Message-State: AOAM530vMhAYF55C4XHK1Ws39vC1bA9CeJ5dCKi//NAiUyh4KdBsuZXA
        pvZgGI4nkU7LbGhwzyUAvw8x2oee4yCujA==
X-Google-Smtp-Source: ABdhPJxDWfM8H/m+Vc2abEf6cYyK5ZkuFsj4wPsynE7ce0klL4/0lDW/+CPNMnSd8xPJEtrW7pykpg==
X-Received: by 2002:aca:f306:0:b0:32b:4753:db60 with SMTP id r6-20020acaf306000000b0032b4753db60mr5209323oih.157.1653487104970;
        Wed, 25 May 2022 06:58:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t17-20020a056870601100b000f2ba94877esm895753oaa.44.2022.05.25.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 12/40] hwmon: (lm90) Only re-read registers if volatile
Date:   Wed, 25 May 2022 06:57:30 -0700
Message-Id: <20220525135758.2944744-13-linux@roeck-us.net>
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

When reading 16-bit volatile registers, the code uses a trick to
determine if a temperature is consistent: It reads the high part
of the register twice. If the values are the same, the code assumes
that the reading is consistent. If the value differs, the code
re-reads the second register as well and assumes that it now has
correct values.

This is only necessary for volatile registers. Add a parameter to
lm90_read16() to indicate if the register is volatile to avoid the
extra overhead for non-volatile registers.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index acb9ca3b99b0..b20be0cb28b5 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -602,29 +602,34 @@ static int lm90_write_reg(struct i2c_client *client, u8 reg, u8 val)
 	return i2c_smbus_write_byte_data(client, lm90_write_reg_addr(reg), val);
 }
 
-static int lm90_read16(struct i2c_client *client, u8 regh, u8 regl)
+static int lm90_read16(struct i2c_client *client, u8 regh, u8 regl,
+		       bool is_volatile)
 {
 	int oldh, newh, l;
 
-	/*
-	 * There is a trick here. We have to read two registers to have the
-	 * sensor temperature, but we have to beware a conversion could occur
-	 * between the readings. The datasheet says we should either use
-	 * the one-shot conversion register, which we don't want to do
-	 * (disables hardware monitoring) or monitor the busy bit, which is
-	 * impossible (we can't read the values and monitor that bit at the
-	 * exact same time). So the solution used here is to read the high
-	 * byte once, then the low byte, then the high byte again. If the new
-	 * high byte matches the old one, then we have a valid reading. Else
-	 * we have to read the low byte again, and now we believe we have a
-	 * correct reading.
-	 */
 	oldh = lm90_read_reg(client, regh);
 	if (oldh < 0)
 		return oldh;
 	l = lm90_read_reg(client, regl);
 	if (l < 0)
 		return l;
+
+	if (!is_volatile)
+		return (oldh << 8) | l;
+
+	/*
+	 * For volatile registers we have to use a trick.
+	 * We have to read two registers to have the sensor temperature,
+	 * but we have to beware a conversion could occur between the
+	 * readings. The datasheet says we should either use
+	 * the one-shot conversion register, which we don't want to do
+	 * (disables hardware monitoring) or monitor the busy bit, which is
+	 * impossible (we can't read the values and monitor that bit at the
+	 * exact same time). So the solution used here is to read the high
+	 * the high byte again. If the new high byte matches the old one,
+	 * then we have a valid reading. Otherwise we have to read the low
+	 * byte again, and now we believe we have a correct reading.
+	 */
 	newh = lm90_read_reg(client, regh);
 	if (newh < 0)
 		return newh;
@@ -766,7 +771,7 @@ static int lm90_update_limits(struct device *dev)
 
 	if (data->flags & LM90_HAVE_OFFSET) {
 		val = lm90_read16(client, LM90_REG_REMOTE_OFFSH,
-				  LM90_REG_REMOTE_OFFSL);
+				  LM90_REG_REMOTE_OFFSL, false);
 		if (val < 0)
 			return val;
 		data->temp11[REMOTE_OFFSET] = val;
@@ -999,7 +1004,7 @@ static int lm90_update_device(struct device *dev)
 
 		if (data->reg_local_ext) {
 			val = lm90_read16(client, LM90_REG_LOCAL_TEMP,
-					  data->reg_local_ext);
+					  data->reg_local_ext, true);
 			if (val < 0)
 				return val;
 			data->temp11[LOCAL_TEMP] = val;
@@ -1010,7 +1015,7 @@ static int lm90_update_device(struct device *dev)
 			data->temp11[LOCAL_TEMP] = val << 8;
 		}
 		val = lm90_read16(client, LM90_REG_REMOTE_TEMPH,
-				  LM90_REG_REMOTE_TEMPL);
+				  LM90_REG_REMOTE_TEMPL, true);
 		if (val < 0)
 			return val;
 		data->temp11[REMOTE_TEMP] = val;
@@ -1021,7 +1026,7 @@ static int lm90_update_device(struct device *dev)
 				return val;
 
 			val = lm90_read16(client, LM90_REG_REMOTE_TEMPH,
-					  LM90_REG_REMOTE_TEMPL);
+					  LM90_REG_REMOTE_TEMPL, true);
 			if (val < 0) {
 				lm90_select_remote_channel(data, 0);
 				return val;
-- 
2.35.1

