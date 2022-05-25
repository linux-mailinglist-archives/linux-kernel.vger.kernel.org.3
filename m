Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035B6533E97
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbiEYOAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244705AbiEYN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:59:33 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8E2AEE02;
        Wed, 25 May 2022 06:58:52 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-f16a3e0529so26141705fac.2;
        Wed, 25 May 2022 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rfimkIqOgYUSdM58+MOpjLqPVMTPdRcPwPDc3SlvEGE=;
        b=mcC5Ljh4yeQh5uYZZ/q3MGkQkK6v0yBvz7iL9/sWNwqnA+iqqJ2IN9xYqLXr+enjwh
         8dMYKqPMDkZSA1MEnSeU0/MlcWI9jSmmuAH16dfs0Y+HB6+DSTjrxzDaW87uNIrgarB5
         ImaSlhlU70FLHuU94qqqI0qInHKjt3u8zvAccmqmOfxytoQ9+XnaUdjQSboqzolXUoGW
         trOIkrnUezDinzvne8oj4W/uUXXs8IZzgmZrpMwIgtmhYfHFi6N+DOvBEOvK/sHpeOdk
         gGWjbwDV0QMo0bU9Tg/vjTK5/4fPX2z1qlgDgbeqTQlW7PoF90ZLyKbPrKsQORXPR13e
         v8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rfimkIqOgYUSdM58+MOpjLqPVMTPdRcPwPDc3SlvEGE=;
        b=G4dZ+cOUMDlPZ4qsTebkRllEVicibPmen5PmiUDbmn0HSkoVuU2y7NTKpAVD9WrGb0
         Rg+LW8R15XYudZ5jPPvTBm8e5kYp58UbW1mXVoiWKfSJWTaDrZYqrKahZ23j80mH35FV
         6Jtkv5YmEK3O/tqUX5FixvUh+KD0vH7wJZoLuxEa2Tmdn6v9kZ2J9cv23GmcAI9A/+y+
         6jgeZggHQLaJ48H+ctLvv2jewkI+eHoN2TpDGgz+8ifPlN4rokLfP+onS+LMEXDMfZhp
         8FcnG6RjOyjZhM/udGoXZHKLkszWEp52Uum+h9vt9bOJ+rCJa8Ulq6OZb6xHSDKuJi0T
         WYPA==
X-Gm-Message-State: AOAM531aUNTsf2EtG+YwtWCSAhkf/8dMPbjaHkAxahfZti3K3NHrK1Xv
        dvtUiZTEsofhRvD1D8Dv0DpF3g1Q/xlaLg==
X-Google-Smtp-Source: ABdhPJyhcuxUCBgJlUi4UQtHRe0p97WKU2y7IQxEEQUnm6fMqM+ucUXr/ZYvB0IrR3drG4L3DcNC6Q==
X-Received: by 2002:a05:6870:350:b0:e2:6f65:b91f with SMTP id n16-20020a056870035000b000e26f65b91fmr5964257oaf.192.1653487130883;
        Wed, 25 May 2022 06:58:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h3-20020a056830164300b006061debeed4sm6094444otr.69.2022.05.25.06.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 26/40] hwmon: (lm90) Let lm90_read16() handle 8-bit read operations
Date:   Wed, 25 May 2022 06:57:44 -0700
Message-Id: <20220525135758.2944744-27-linux@roeck-us.net>
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

Simplify the code a bit by handling single-register read operations
in lm90_read16(). All we need to do is to skip the low-byte read
operation if the register address is 0.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 47 ++++++++++++++++----------------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 78eda648d960..20208f127508 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -673,6 +673,10 @@ static int lm90_read16(struct i2c_client *client, u8 regh, u8 regl,
 	oldh = lm90_read_reg(client, regh);
 	if (oldh < 0)
 		return oldh;
+
+	if (!regl)
+		return oldh << 8;
+
 	l = lm90_read_reg(client, regl);
 	if (l < 0)
 		return l;
@@ -804,29 +808,19 @@ static int lm90_update_limits(struct device *dev)
 		data->temp_hyst = val;
 	}
 
-	val = lm90_read_reg(client, LM90_REG_REMOTE_LOWH);
+	val = lm90_read16(client, LM90_REG_REMOTE_LOWH,
+			  (data->flags & LM90_HAVE_REM_LIMIT_EXT) ? LM90_REG_REMOTE_LOWL : 0,
+			  false);
 	if (val < 0)
 		return val;
-	data->temp[REMOTE_LOW] = val << 8;
+	data->temp[REMOTE_LOW] = val;
 
-	if (data->flags & LM90_HAVE_REM_LIMIT_EXT) {
-		val = lm90_read_reg(client, LM90_REG_REMOTE_LOWL);
-		if (val < 0)
-			return val;
-		data->temp[REMOTE_LOW] |= val;
-	}
-
-	val = lm90_read_reg(client, LM90_REG_REMOTE_HIGHH);
+	val = lm90_read16(client, LM90_REG_REMOTE_HIGHH,
+			  (data->flags & LM90_HAVE_REM_LIMIT_EXT) ? LM90_REG_REMOTE_HIGHL : 0,
+			  false);
 	if (val < 0)
 		return val;
-	data->temp[REMOTE_HIGH] = val << 8;
-
-	if (data->flags & LM90_HAVE_REM_LIMIT_EXT) {
-		val = lm90_read_reg(client, LM90_REG_REMOTE_HIGHL);
-		if (val < 0)
-			return val;
-		data->temp[REMOTE_HIGH] |= val;
-	}
+	data->temp[REMOTE_HIGH] = val;
 
 	if (data->flags & LM90_HAVE_OFFSET) {
 		val = lm90_read16(client, LM90_REG_REMOTE_OFFSH,
@@ -1063,18 +1057,11 @@ static int lm90_update_device(struct device *dev)
 			return val;
 		data->temp[LOCAL_HIGH] = val << 8;
 
-		if (data->reg_local_ext) {
-			val = lm90_read16(client, LM90_REG_LOCAL_TEMP,
-					  data->reg_local_ext, true);
-			if (val < 0)
-				return val;
-			data->temp[LOCAL_TEMP] = val;
-		} else {
-			val = lm90_read_reg(client, LM90_REG_LOCAL_TEMP);
-			if (val < 0)
-				return val;
-			data->temp[LOCAL_TEMP] = val << 8;
-		}
+		val = lm90_read16(client, LM90_REG_LOCAL_TEMP,
+				  data->reg_local_ext, true);
+		if (val < 0)
+			return val;
+		data->temp[LOCAL_TEMP] = val;
 		val = lm90_read16(client, LM90_REG_REMOTE_TEMPH,
 				  LM90_REG_REMOTE_TEMPL, true);
 		if (val < 0)
-- 
2.35.1

