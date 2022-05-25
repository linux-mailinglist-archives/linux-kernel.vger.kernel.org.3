Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F627533E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiEYOBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244706AbiEYN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:59:33 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85941AEE0A;
        Wed, 25 May 2022 06:58:53 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id m125so2069831oia.6;
        Wed, 25 May 2022 06:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5hp0dbekvuABHpYBUEs96KVN5ghBlLRpdsHmk4A4gsY=;
        b=TwKEsWyvpZ5GlzTloFURMTbxmwYufAFPvBfAvNoLWcwZFhoEHowOPFlxE7iFsANSCf
         P2kkioCKJ6fhEgLydhYgp2Je9alxCdb4kGEREmMhKkPj439cIoyxd+ASO/GwTHYfZHpA
         KUtnLSPrdk6bpgVm4bM9nUgAfm4DejsOVpibG2Jrt7WPdJIQF5SbsIzy5bSVdWup3gVy
         jOgVFgcs7IP9qD4qg3BD1f8FdQdbZaMuvRhqr9cF+6H9Z3bRCCHFF3VxAmO/tRj9zQHh
         Gqej0VZ8qwKXR886642M7jGc4lMbqJVoNA1pnJFQk+eVySCmQiEyhyZXJV9DO0btVecZ
         NJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5hp0dbekvuABHpYBUEs96KVN5ghBlLRpdsHmk4A4gsY=;
        b=R3d3DZJX8J4t88GVlxJ5t1tZ4roYG2cgjfM+uhqxFK5bS5R4nl0b4j9cMvbPLBp2c2
         Ux/TOw5iT3KRrQ239JUpqoweUxurMvkdqE71zR/ONiXme1Q+Dw5XYwnR9TcJvlfiOVUW
         6T/sK+74QtM1v+lr2Pm9CRz8tOQTzEfMLsT0Usb19dJXiuBGIYpamNK8W9jYIMy05Bvu
         +RF2WO4JsjSimC0nyT/JBM/z75YKYwnoFk+ST7DWjq7ZAf8DN8XtL+Z/iLU/4g1WHiEp
         QCAiNWh9xoXyGb9J+VbrNA+tqNQkpMhtAmafsLMe2tUxCPGFH2+th3X+TVyo7tgJdMkx
         cyEg==
X-Gm-Message-State: AOAM530kBuhHE9UNZ6cWMyhXZeNCgt7EiDRytoPZPjVwHyedd24wYG55
        GazBQqK86WLql08oOPcaFao0R40LQTX8qQ==
X-Google-Smtp-Source: ABdhPJw8dxE7PUc0uURtb9tDBlDYEPUcWtaiu1AqQJXisaxmHjzkVz/mgRmstw5u4//tZFyGU70xdQ==
X-Received: by 2002:aca:f1a:0:b0:32a:e909:a490 with SMTP id 26-20020aca0f1a000000b0032ae909a490mr5629095oip.239.1653487132634;
        Wed, 25 May 2022 06:58:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 126-20020a4a0384000000b0035eb4e5a6cdsm6597357ooi.35.2022.05.25.06.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 27/40] hwmon: (lm90) Introduce 16-bit register write function
Date:   Wed, 25 May 2022 06:57:45 -0700
Message-Id: <20220525135758.2944744-28-linux@roeck-us.net>
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

Introduce 16-bit register write function to simplify the code in
some places.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 20208f127508..46837f0bf62e 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -665,6 +665,21 @@ static int lm90_write_reg(struct i2c_client *client, u8 reg, u8 val)
 	return i2c_smbus_write_byte_data(client, lm90_write_reg_addr(reg), val);
 }
 
+/*
+ * Write into 16-bit LM90 register.
+ * Convert register addresses to write address if needed, then execute the
+ * operation.
+ */
+static int lm90_write16(struct i2c_client *client, u8 regh, u8 regl, u16 val)
+{
+	int ret;
+
+	ret = lm90_write_reg(client, regh, val >> 8);
+	if (ret < 0 || !regl)
+		return ret;
+	return lm90_write_reg(client, regl, val & 0xff);
+}
+
 static int lm90_read16(struct i2c_client *client, u8 regh, u8 regl,
 		       bool is_volatile)
 {
@@ -1240,12 +1255,8 @@ static int lm90_set_temp(struct lm90_data *data, int index, int channel, long va
 	if (channel > 1)
 		lm90_select_remote_channel(data, true);
 
-	err = lm90_write_reg(client, regh, data->temp[index] >> 8);
-	if (err < 0)
-		goto deselect;
-	if (regl)
-		err = lm90_write_reg(client, regl, data->temp[index] & 0xff);
-deselect:
+	err = lm90_write16(client, regh, regl, data->temp[index]);
+
 	if (channel > 1)
 		lm90_select_remote_channel(data, false);
 
@@ -1405,14 +1416,8 @@ static int lm90_temp_write(struct device *dev, u32 attr, int channel, long val)
 		val = lm90_temp_to_reg(0, val,
 				       lm90_temp_get_resolution(data, REMOTE_OFFSET));
 		data->temp[REMOTE_OFFSET] = val;
-		err = i2c_smbus_write_byte_data(data->client,
-						LM90_REG_REMOTE_OFFSH,
-						val >> 8);
-		if (err)
-			break;
-		err = i2c_smbus_write_byte_data(data->client,
-						LM90_REG_REMOTE_OFFSL,
-						val & 0xff);
+		err = lm90_write16(data->client, LM90_REG_REMOTE_OFFSH,
+				   LM90_REG_REMOTE_OFFSL, val);
 		break;
 	default:
 		err = -EOPNOTSUPP;
-- 
2.35.1

