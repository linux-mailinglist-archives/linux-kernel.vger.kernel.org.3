Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC3F4A9CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376590AbiBDQbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 11:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239260AbiBDQbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:31:03 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E62C061714;
        Fri,  4 Feb 2022 08:31:03 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id p12so14216191edq.9;
        Fri, 04 Feb 2022 08:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V7y7UvDThZqE9ABD6sPcRiftcOsF+0/rjlQVw86foiA=;
        b=q5y0XjOB8ZUQ0d5M6GMB6FgbnQsza9GiZCyt9hJ7Gaa1PHjNyCHETl/Fg+MoxEkCpL
         ttQbUcJOJnE/bF2fFXs62LMCg3/ZkHLgaHl3+TpTrJ74HIfoIgn9XVbQ7zSDIYYS8WxS
         tVy1z/GUCZDj0Nv3ZVIIbsxVTJowVusiMFQUiQAT/65o2+y8KKSDYgO12Y8PouZcL3HG
         gSKssFDIOiDV8ybRVlM9T9AbSRyThixpbjB7B2P1Il0Qoi+iiPSZr2rzJQOqF+nxlyfr
         Wc5xNseL8euwRjlt0iKubTax3oQKCoXSHFUDyxfdruUDR+D6vGLlToushpdGUSk2if1V
         xiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V7y7UvDThZqE9ABD6sPcRiftcOsF+0/rjlQVw86foiA=;
        b=V6wspIWn3Tfs/iUDnHQIq/R+S23tcmwd8r5MzuXpz6IsTjCwdDzbgzOj6iBp2HDfSk
         hXp+HfjhcYwvnVm2iPdKFrxpdZ15WktQArDhFW3yGas75vIvPC7fLn8MR9e61nfcpqey
         k6C1c7qiUJDBxXWRxyGJP8yd27icq8HdF2KvR0qXYS9inxqqVvSsxsFrpWZanUMa93b/
         qXyfWUy0+CqN8fGzU+OttS/g7UqPtA9rJOO4VEthN7YTMOoh36q3SpDJkHYzizt2/FSM
         vKsTzIH1k6VqjzqJJC2NeaIBoIlt97d+1n8WC0wXpIjIQ8Ej8mY67BBHfIAtTo+apne1
         5o5A==
X-Gm-Message-State: AOAM5329ccvEriJyKGyepdvn5NwT4siqTzFsKt37I1D7LVjaSqmk2zwh
        0aqSpN8EQU6q6wFUWTcq/tA=
X-Google-Smtp-Source: ABdhPJyqDTlGFj1/81likfeAtFfM+w/saUkneHzuKnI25nekRGoT53ju4Gyhbd1RvzXXQ/2UdShMiA==
X-Received: by 2002:a50:ab10:: with SMTP id s16mr3863526edc.382.1643992261596;
        Fri, 04 Feb 2022 08:31:01 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id d16sm819383eje.131.2022.02.04.08.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 08:31:01 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) read sensors as signed ints
Date:   Fri,  4 Feb 2022 17:30:45 +0100
Message-Id: <20220204163045.576903-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Temperature sensor readings are signed, which is hinted by their blank
value (oxd8, 216 as unsigned and -40 as signed). T_Sensor, Crosshair
VIII Hero, and a freezer were used to confirm that.

Here we read fan sensors as signed too, because with their typical
values and 2-byte width, I can't tell a difference between signed and
unsigned, as I don't have a high speed chipset fan.

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 05244209c0c6..8a04c76527a4 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -221,7 +221,7 @@ static const struct dmi_system_id asus_ec_dmi_table[] __initconst = {
 
 struct ec_sensor {
 	unsigned int info_index;
-	u32 cached_value;
+	s32 cached_value;
 };
 
 struct ec_sensors_data {
@@ -408,15 +408,15 @@ static int asus_ec_block_read(const struct device *dev,
 	return status;
 }
 
-static inline u32 get_sensor_value(const struct ec_sensor_info *si, u8 *data)
+static inline s32 get_sensor_value(const struct ec_sensor_info *si, u8 *data)
 {
 	switch (si->addr.components.size) {
 	case 1:
-		return *data;
+		return (s8)*data;
 	case 2:
-		return get_unaligned_be16(data);
+		return (s16)get_unaligned_be16(data);
 	case 4:
-		return get_unaligned_be32(data);
+		return (s32)get_unaligned_be32(data);
 	default:
 		return 0;
 	}
@@ -462,7 +462,7 @@ static int update_ec_sensors(const struct device *dev,
 	return status;
 }
 
-static int scale_sensor_value(u32 value, int data_type)
+static long scale_sensor_value(s32 value, int data_type)
 {
 	switch (data_type) {
 	case hwmon_curr:
@@ -476,7 +476,7 @@ static int scale_sensor_value(u32 value, int data_type)
 
 static int get_cached_value_or_update(const struct device *dev,
 				      int sensor_index,
-				      struct ec_sensors_data *state, u32 *value)
+				      struct ec_sensors_data *state, s32 *value)
 {
 	if (time_after(jiffies, state->last_updated + HZ)) {
 		if (update_ec_sensors(dev, state)) {
@@ -499,7 +499,7 @@ static int asus_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			      u32 attr, int channel, long *val)
 {
 	int ret;
-	u32 value = 0;
+	s32 value = 0;
 
 	struct ec_sensors_data *state = dev_get_drvdata(dev);
 	int sidx = find_ec_sensor_index(state, type, channel);
-- 
2.35.1

