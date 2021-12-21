Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5083A47BFE5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbhLUMkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbhLUMkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:40:02 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9E3C061747;
        Tue, 21 Dec 2021 04:40:01 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f5so28352980edq.6;
        Tue, 21 Dec 2021 04:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IyNVKXDWR36ykQcClTsSbztRleUEblizENFlHFdt5IA=;
        b=TbmZ3FEnJJhfZTBC2nxDLfieJ/gZf8DFoEe4NTn0luMUu9vG5m9hM4HfxGeRsxn3aL
         hXDAjSQ0HqNZ6r3zuS9FVw8REsS1G/q/Y69ECCD1YXlt5f2e/sDRo8SAvcakw3+iKZFJ
         9zB+Zju2zwnsmp+6G00plfdfyofSmECNX/Vy5crFqOKdiFUuzQP6+3D27Xrb8BTcGQ0L
         o6RQa3kIr/5erkedjn1EooC1rjXaMCmy4BX8/mYBljPvgnBZDHwMS8lpFE2nKlEABGVj
         qjve7xyDXbNH6LeI96F3VCVh4/ghs0C1PkARC+xuXeKhCb5xOBxpCNpHhXTf2SxR4X3+
         jkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IyNVKXDWR36ykQcClTsSbztRleUEblizENFlHFdt5IA=;
        b=ACmnG3nPbPhAxKIMTO9xNjVGcuOoHG7liAK72H6E8cqFx9AfH4ZbbZiqOkeyctQWCY
         us2uDyFqXzEGr2zkb0jXMe2jAGkRAxbqlTQUzIr/xmJ5MHqLwuWBJRcs/7tve25xmqez
         kh5SiDC3tfheAahxgsAsbnA/QcZWFMuBVBMgz3vo5IRGsKje2Q5fxqNm6L9/An78BOU5
         BlFEVOUVGoFDGiUOadsD55yphMwErj2hPZAEsoEU/S+8vOcn7zhPi+p8uF6RTq+3DW1f
         T9nE9TZC24v2bB87FAEk3Htr//JeIgRwpomtmrY+mmcTdWTD93K0BSEwyZM/dCwy6fsB
         I29g==
X-Gm-Message-State: AOAM530vFG/F5BovQyvb6WS1IeNLc7OgKL2Nottws1gl7l9FtF3b+KBq
        q6tgUpH8IAoL9pA5dqD5uAE=
X-Google-Smtp-Source: ABdhPJxDfYl3wI6S0e0cy8glih1BjFWnHK50u77PY7PQxb/u7j+1hcF3tZnMmzLxT5yH3qWzfzR8gg==
X-Received: by 2002:a05:6402:d05:: with SMTP id eb5mr3117833edb.360.1640090400452;
        Tue, 21 Dec 2021 04:40:00 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id bx6sm2849438edb.78.2021.12.21.04.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:40:00 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/10] hwmon: adt7x10: use hwmon_device_register_with_info
Date:   Tue, 21 Dec 2021 14:39:42 +0200
Message-Id: <20211221123944.2683245-8-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221123944.2683245-1-demonsingur@gmail.com>
References: <20211221123944.2683245-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

Describe the only available channel, implement read, write
and is_visible callbacks.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 93 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 2d36088e1a07..dd4901299590 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -297,6 +297,95 @@ static int adt7x10_alarm_read(struct adt7x10_data *data, unsigned int index,
 	return 0;
 }
 
+static umode_t adt7x10_is_visible(const void *data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	umode_t mode = 0444;
+
+	switch (attr) {
+	case hwmon_temp_max:
+	case hwmon_temp_min:
+	case hwmon_temp_crit:
+	case hwmon_temp_max_hyst:
+		mode |= 0200;
+		break;
+	default:
+		break;
+	}
+
+	return mode;
+}
+
+static int adt7x10_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct adt7x10_data *data = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_temp_input:
+		return adt7x10_temp_read(data, 0, val);
+	case hwmon_temp_max:
+		return adt7x10_temp_read(data, 1, val);
+	case hwmon_temp_min:
+		return adt7x10_temp_read(data, 2, val);
+	case hwmon_temp_crit:
+		return adt7x10_temp_read(data, 3, val);
+	case hwmon_temp_max_hyst:
+		return adt7x10_hyst_read(data, 1, val);
+	case hwmon_temp_min_hyst:
+		return adt7x10_hyst_read(data, 2, val);
+	case hwmon_temp_crit_hyst:
+		return adt7x10_hyst_read(data, 3, val);
+	case hwmon_temp_min_alarm:
+		return adt7x10_alarm_read(data, ADT7X10_STAT_T_LOW, val);
+	case hwmon_temp_max_alarm:
+		return adt7x10_alarm_read(data, ADT7X10_STAT_T_HIGH, val);
+	case hwmon_temp_crit_alarm:
+		return adt7x10_alarm_read(data, ADT7X10_STAT_T_CRIT, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int adt7x10_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
+{
+	struct adt7x10_data *data = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_temp_max:
+		return adt7x10_temp_write(data, 1, val);
+	case hwmon_temp_min:
+		return adt7x10_temp_write(data, 2, val);
+	case hwmon_temp_crit:
+		return adt7x10_temp_write(data, 3, val);
+	case hwmon_temp_max_hyst:
+		return adt7x10_hyst_write(data, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_channel_info *adt7x10_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
+			   HWMON_T_CRIT | HWMON_T_MAX_HYST | HWMON_T_MIN_HYST |
+			   HWMON_T_CRIT_HYST | HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM),
+	NULL,
+};
+
+static const struct hwmon_ops adt7x10_hwmon_ops = {
+	.is_visible = adt7x10_is_visible,
+	.read = adt7x10_read,
+	.write = adt7x10_write,
+};
+
+static const struct hwmon_chip_info adt7x10_chip_info = {
+	.ops = &adt7x10_hwmon_ops,
+	.info = adt7x10_info,
+};
+
 int adt7x10_probe(struct device *dev, const char *name, int irq,
 		  const struct adt7x10_ops *ops)
 {
@@ -341,7 +430,9 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 	if (ret)
 		goto exit_restore;
 
-	hdev = hwmon_device_register(dev);
+	hdev = hwmon_device_register_with_info(dev, name, data,
+					       &adt7x10_chip_info, NULL);
+
 	if (IS_ERR(hdev)) {
 		ret = PTR_ERR(hdev);
 		goto exit_restore;
-- 
2.34.1

