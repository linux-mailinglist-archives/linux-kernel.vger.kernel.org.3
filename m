Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372D95A5533
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiH2UAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiH2T7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:59:48 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8B495E7B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:59:42 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 36-20020a17090a0fa700b001fd64c962afso3715232pjz.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=vqgsnxf5rjaff8S5+BsqzjPD4LssFKq1fOgYeO/ES2A=;
        b=aqxmgWD7054exX/C6tlPQGRlTYmM2uK1B0DjlSN6g8lAcZYwM9Y5r2O8io5iY1ZQ0W
         NwX+X0Xga8McV6zvgCscpQE26jF3wZr0STuMHAi+pI6iZNAC6WMLoBwr8QmIyQVm9t3i
         tRP6/hRWWL6WO0f7qhatKJ8ZsXqsqJ3HNDN+iRlmjZzfH2RhR+1gG0WQnM591otm31Jt
         xqW7bpinWebERskF4v1XPVbTECKXhm9Vx5qtc66VjL6uiVamBMUuXOkmI8eB41adsy1S
         pmHsThL4VikcOOm/8A6NHBqWd9IyORkNqFGDEP314Mte3feKFuRS8dYtGiQrlOAmJ7hQ
         y/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=vqgsnxf5rjaff8S5+BsqzjPD4LssFKq1fOgYeO/ES2A=;
        b=fkHIxlg1Ugg6wyS2i/PiOn/DxVfnhQxPFRWINZBAktJNgBW01w+fK/YwKBhbY0vjmQ
         ETFUQVA5RVRCeQuJtrLQCKXt9+QOKzcpSCz7OGCXemp9A2oWc9MBslkeSjkCPLUQLY6N
         BzVu97zJB9yPFE1juZA1MVnvNoHN64ceTAka6o0eVJpG2tOuxq0DytLPaP4p26/PKj6N
         2q166uNVNo2dS/NxQcWKBVx/lNbejo1l2h8MUUEom8eDO0rnIMVYyHXKIClMZIrMcDwI
         SVWjy382B8aZNIxp1cmEPgBm5G1xz8W6N+czuNRVDEIAiWCy+2uzX7M3eVQkk1U/YDkG
         pgYw==
X-Gm-Message-State: ACgBeo16EETQ09MWBV43iY0OZyv0VW1whOCUENRuhCz5kH8bMjScawg1
        NHieTsMrSE6fVql4xFUR8bW/2b9dpVY+Tm9TaYDv
X-Google-Smtp-Source: AA6agR7x1hGMKZjsW+y0p/M6G/93jpT9sDIIcESmhPUqFUY7m85UM2ybuRl+MK22hdOXk9v2mQ/zzfP4dkbD8Ca9ZuQ7
X-Received: from jsl.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cdb])
 (user=justinledford job=sendgmr) by 2002:a05:6a00:10c2:b0:4f7:5af4:47b6 with
 SMTP id d2-20020a056a0010c200b004f75af447b6mr18200289pfu.6.1661803182076;
 Mon, 29 Aug 2022 12:59:42 -0700 (PDT)
Date:   Mon, 29 Aug 2022 19:59:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829195930.2521755-1-justinledford@google.com>
Subject: [PATCH v2] hwmon: (max31790) add fanN_enable
From:   Justin Ledford <justinledford@google.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Justin Ledford <justinledford@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX31790 has a tach input enable bit in each fan's configuration
register. This is only enabled by the driver if RPM mode is selected,
but the driver doesn't provide a way to independently enable tachometer
input regardless of the regulator mode.

By adding the fanN_enable sysfs files, we can decouple the tach input
from the regulator mode. Also update the documentation.

Signed-off-by: Justin Ledford <justinledford@google.com>
---
Changes in v2:
- Removed updating fan_config during max31790_update_device
---
 Documentation/hwmon/max31790.rst |  1 +
 drivers/hwmon/max31790.c         | 38 ++++++++++++++++++++++++++------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
index 7b097c3b9b90..33c5c7330efc 100644
--- a/Documentation/hwmon/max31790.rst
+++ b/Documentation/hwmon/max31790.rst
@@ -38,6 +38,7 @@ Sysfs entries
 fan[1-12]_input    RO  fan tachometer speed in RPM
 fan[1-12]_fault    RO  fan experienced fault
 fan[1-6]_target    RW  desired fan speed in RPM
+fan[1-6]_enable    RW  enable or disable the tachometer input
 pwm[1-6]_enable    RW  regulator mode, 0=disabled (duty cycle=0%), 1=manual mode, 2=rpm mode
 pwm[1-6]           RW  read: current pwm duty cycle,
                        write: target pwm duty cycle (0-255)
diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 7e9362f6dc29..20bf5ffadefe 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -202,6 +202,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
 		}
 		mutex_unlock(&data->update_lock);
 		return 0;
+	case hwmon_fan_enable:
+		*val = !!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -214,7 +217,7 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 	struct i2c_client *client = data->client;
 	int target_count;
 	int err = 0;
-	u8 bits;
+	u8 bits, fan_config;
 	int sr;
 
 	mutex_lock(&data->update_lock);
@@ -243,6 +246,23 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
 					MAX31790_REG_TARGET_COUNT(channel),
 					data->target_count[channel]);
 		break;
+	case hwmon_fan_enable:
+		fan_config = data->fan_config[channel];
+		if (val == 0) {
+			fan_config &= ~MAX31790_FAN_CFG_TACH_INPUT_EN;
+		} else if (val == 1) {
+			fan_config |= MAX31790_FAN_CFG_TACH_INPUT_EN;
+		} else {
+			err = -EINVAL;
+			break;
+		}
+		if (fan_config != data->fan_config[channel]) {
+			err = i2c_smbus_write_byte_data(client, MAX31790_REG_FAN_CONFIG(channel),
+							fan_config);
+			if (!err)
+				data->fan_config[channel] = fan_config;
+		}
+		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
@@ -270,6 +290,10 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
 		    !(fan_config & MAX31790_FAN_CFG_TACH_INPUT))
 			return 0644;
 		return 0;
+	case hwmon_fan_enable:
+		if (channel < NR_CHANNEL)
+			return 0644;
+		return 0;
 	default:
 		return 0;
 	}
@@ -423,12 +447,12 @@ static umode_t max31790_is_visible(const void *data,
 
 static const struct hwmon_channel_info *max31790_info[] = {
 	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
+			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
+			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
+			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
+			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
+			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
 			   HWMON_F_INPUT | HWMON_F_FAULT,
 			   HWMON_F_INPUT | HWMON_F_FAULT,
 			   HWMON_F_INPUT | HWMON_F_FAULT,
-- 
2.37.2.672.g94769d06f0-goog

