Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BFB533E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241258AbiEYN7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244626AbiEYN6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:32 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D74DAB0FC;
        Wed, 25 May 2022 06:58:29 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id r3-20020a9d5cc3000000b0060ae1789875so12003207oti.13;
        Wed, 25 May 2022 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i26/JCkysf9GDfl6ljkBEdIPEPYakKxwIC/n6VFnoCw=;
        b=i036EpaKoeLbMcvL5tu+2JGtgzrYIty8FqztTyFkjy/HYq474kSEcHcpO5WgkgOlbB
         wUfbObh3ms72byJZhtgxpnoIhPtlwqNukVn6guG4I/aotHGwN+kfvkXHt59uVRtd0/os
         Y3K4Rim6TMGjzw31oyNnmpe8nTj3bid9GUocbm0zKCvx2PHDGcKLpgb33N/BTJfwCKHI
         2ozEybJzpG8YmnRYk7d2ILTklmg74CHcptAyQJp0nXbVt1e1nkYZNDUHBcJNxRtz0jLJ
         hQzvzI3Rulntk8uZBXG5XPlHduBON/jc0saYJSaMtOy/RFo0/3UiDsf1QkUWTM905Zb3
         YuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=i26/JCkysf9GDfl6ljkBEdIPEPYakKxwIC/n6VFnoCw=;
        b=ED9f9LPLGJrPILqcy6caL8otNJONbpiLG+7m5gDm4eVkqtA6UOk7HkfAjqY1k1Osni
         EusBwrc3+rfltsdKIDDwRH8JJmJfUVR6t6AkK0jYlcrAj4fPMvU6uP9s8YLaDC15xi6c
         WDAJ9lTouT+g3qk0o92vz1+9kXvb4eA7IQa+TWT8G+mADPYMdxA/bOEwGe//ouszl4tJ
         3Or4jDBezgWiGWyO204+BqGcPpud6yJGcTzZe6nfNkXTUMPQYnnfDLWInecuDnjBADWE
         waZZbj9nbQWorbgFN79iBGPiBhlAvt5z7DVgeXQBy5+VftN+dfpHNTVLIPrqqCjAYTi3
         ONkA==
X-Gm-Message-State: AOAM532l0k+STqP0UtDYMXiv3Ne/Bm90VScFf/TLw54iHpUvQOHKEmBV
        YUo7HGz/3HqZoknTbNlKvX8zQ8cB8I7Deg==
X-Google-Smtp-Source: ABdhPJwmDVWPx2V8Ue8nx9v2U0S2F5zPeiW12rWzYoRYQJjWEwVn+7P3gJ/uPfvDXi2OrlnrScUqbw==
X-Received: by 2002:a9d:1b68:0:b0:606:ae01:ce2e with SMTP id l95-20020a9d1b68000000b00606ae01ce2emr12762044otl.121.1653487108637;
        Wed, 25 May 2022 06:58:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e125-20020aca3783000000b0032b7788af61sm2273372oia.41.2022.05.25.06.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 14/40] hwmon: (lm90) Use single flag to indicate extended temperature support
Date:   Wed, 25 May 2022 06:57:32 -0700
Message-Id: <20220525135758.2944744-15-linux@roeck-us.net>
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

Since temperature conversion functions are now unified, there is no need
to keep "the chip supports a configurable extended temperature range" and
"the chip has extended temperature range enabled" flags separate.
Use a single flag instead to reflect both.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 8e5f791aca07..a0a91aa66177 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -164,11 +164,8 @@ enum chips { adm1032, adt7461, adt7461a, g781, lm86, lm90, lm99,
 #define TMP461_REG_CHEN			0x16
 #define TMP461_REG_DFC			0x24
 
-/*
- * Device flags
- */
-#define LM90_FLAG_ADT7461_EXT	BIT(0)	/* ADT7461 extended mode	*/
 /* Device features */
+#define LM90_HAVE_EXTENDED_TEMP	BIT(0)	/* extended temperature support	*/
 #define LM90_HAVE_OFFSET	BIT(1)	/* temperature offset register	*/
 #define LM90_HAVE_UNSIGNED_TEMP	BIT(2)	/* temperatures are unsigned	*/
 #define LM90_HAVE_REM_LIMIT_EXT	BIT(3)	/* extended remote limit	*/
@@ -176,12 +173,11 @@ enum chips { adm1032, adt7461, adt7461a, g781, lm86, lm90, lm99,
 #define LM90_HAVE_EMERGENCY_ALARM BIT(5)/* emergency alarm		*/
 #define LM90_HAVE_TEMP3		BIT(6)	/* 3rd temperature sensor	*/
 #define LM90_HAVE_BROKEN_ALERT	BIT(7)	/* Broken alert			*/
-#define LM90_HAVE_EXTENDED_TEMP	BIT(8)	/* extended temperature support	*/
-#define LM90_PAUSE_FOR_CONFIG	BIT(9)	/* Pause conversion for config	*/
-#define LM90_HAVE_CRIT		BIT(10)	/* Chip supports CRIT/OVERT register	*/
-#define LM90_HAVE_CRIT_ALRM_SWP	BIT(11)	/* critical alarm bits swapped	*/
-#define LM90_HAVE_PEC		BIT(12)	/* Chip supports PEC		*/
-#define LM90_HAVE_PARTIAL_PEC	BIT(13)	/* Partial PEC support (adm1032)*/
+#define LM90_PAUSE_FOR_CONFIG	BIT(8)	/* Pause conversion for config	*/
+#define LM90_HAVE_CRIT		BIT(9)	/* Chip supports CRIT/OVERT register	*/
+#define LM90_HAVE_CRIT_ALRM_SWP	BIT(10)	/* critical alarm bits swapped	*/
+#define LM90_HAVE_PEC		BIT(11)	/* Chip supports PEC		*/
+#define LM90_HAVE_PARTIAL_PEC	BIT(12)	/* Partial PEC support (adm1032)*/
 
 /* LM90 status */
 #define LM90_STATUS_LTHRM	BIT(0)	/* local THERM limit tripped */
@@ -1109,7 +1105,7 @@ static int lm90_temp_from_reg(u32 flags, u16 regval, u8 resolution)
 {
 	int val;
 
-	if (flags & LM90_FLAG_ADT7461_EXT)
+	if (flags & LM90_HAVE_EXTENDED_TEMP)
 		val = regval - 0x4000;
 	else if (flags & LM90_HAVE_UNSIGNED_TEMP)
 		val = regval;
@@ -1136,7 +1132,7 @@ static u16 lm90_temp_to_reg(u32 flags, long val, u8 resolution)
 	int fraction = resolution > 8 ?
 			1000 - DIV_ROUND_CLOSEST(1000, BIT(resolution - 8)) : 0;
 
-	if (flags & LM90_FLAG_ADT7461_EXT) {
+	if (flags & LM90_HAVE_EXTENDED_TEMP) {
 		val = clamp_val(val, -64000, 191000 + fraction);
 		val += 64000;
 	} else if (flags & LM90_HAVE_UNSIGNED_TEMP) {
@@ -1764,9 +1760,8 @@ static int lm90_init_client(struct i2c_client *client, struct lm90_data *data)
 	if (data->flags & LM90_HAVE_EXTENDED_TEMP) {
 		if (of_property_read_bool(np, "ti,extended-range-enable"))
 			config |= 0x04;
-
-		if (config & 0x04)
-			data->flags |= LM90_FLAG_ADT7461_EXT;
+		if (!(config & 0x04))
+			data->flags &= ~LM90_HAVE_EXTENDED_TEMP;
 	}
 
 	/*
-- 
2.35.1

