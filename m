Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C23050B609
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447057AbiDVLU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446968AbiDVLU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:20:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04205522E;
        Fri, 22 Apr 2022 04:18:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so5191585wmn.1;
        Fri, 22 Apr 2022 04:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E3YdBQ9ZpUopjYmYV/AL6HV3xZl2rS2yg2Mb52GJV7Q=;
        b=nkyNKt4eBIl//eJdsh1820+smxOo7ndBFZWYoUO4KpZxHQUFjPq7Y9M+qy1cgXn4EX
         MSJTY2PyuuV86lP6b9oeziMOg8qgbFvVDApu/wgt+FdQDrFypLh2/y8BsGqzuuRGOOFz
         rsESX5ni0wfbDYJfYQw5+HycoWtTQHiiBTp35+9ha4HZoIO+rXwQeTze1i2kLw8lpOpJ
         EXnRQfoj5ZL4lwmTXb+qaNQ/+39Aljtl+WTqGJ1gtBjSlBkYUH5RW3vfnBSvAvN1SfBi
         0yy3ywXYMDReJs6e7Zw8Eta841YHry42TnFNUKeKVZiTtWNiNXinXz1FcxPeAcA3oDHw
         acUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E3YdBQ9ZpUopjYmYV/AL6HV3xZl2rS2yg2Mb52GJV7Q=;
        b=VoWj16L54R2r5nWNpAHofgRwQ1GlJDAEnILKlF+P6JMdC0auODYhiwBoDXFOGUx+Sv
         f5kwL7JAtX3XdohCE9GifZCQJkaZf6sufdaBpw+4mLlGNu+vKfwHe3rKFKfYfwEZpMQY
         aO4Ur3QYtVkTpVdE+dNgF3ILQaq4amMwvliCA4f5Hmwv4NdxcYxzFhU78FnLnlVjWdWa
         Ha6J98FVE11qvvNAOw9lIFGNDwb8Uz/E0nwJoqvZZjk8mQ8QH382213/A2LgSqbVBM6y
         tmpTkz40AlJlMkW33TFoJ+pUCG7S9Q1R3rgpmSsUtpOZBFaO7sK755gmi+l3gPbIOExa
         lIYQ==
X-Gm-Message-State: AOAM530YD3X8yGCop0+RabHxegDge5K0J/1/wGFafpDZkymNjvhuLMvO
        r0S5iPbxmicr7URzNBmgSiijeDgsVFX9lJQ+R2M=
X-Google-Smtp-Source: ABdhPJz1e2qfHdhk5/SVdMNtSCPg/MNFaNzWF7/TZN+8XPF1HwnfVx+2826zT6EJr/A/ZG7UUFM+TQ==
X-Received: by 2002:a05:600c:2306:b0:38e:bf1a:a669 with SMTP id 6-20020a05600c230600b0038ebf1aa669mr12696223wmo.11.1650626282193;
        Fri, 22 Apr 2022 04:18:02 -0700 (PDT)
Received: from tiger.museclub.art (p200300cf9f2ead004e4488e67f4bd086.dip0.t-ipconnect.de. [2003:cf:9f2e:ad00:4e44:88e6:7f4b:d086])
        by smtp.googlemail.com with ESMTPSA id u4-20020a5d6da4000000b0020a8c8d3e00sm1513328wrs.73.2022.04.22.04.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 04:18:01 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add ProArt X570 Creator WIFI board
Date:   Fri, 22 Apr 2022 13:17:37 +0200
Message-Id: <20220422111737.1352610-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basing on information and testing provided by users [1] add support for
another board, ASUS ProArt X570 Creator WiFi.

[1] https://github.com/zeule/asus-ec-sensors/issues/17

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst | 1 +
 drivers/hwmon/asus-ec-sensors.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index e7e8f1640f45..b3469851ab9a 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -6,6 +6,7 @@ Kernel driver asus_ec_sensors
 Supported boards:
  * PRIME X570-PRO,
  * Pro WS X570-ACE,
+ * ProArt X570-CREATOR WIFI
  * ROG CROSSHAIR VIII DARK HERO,
  * ROG CROSSHAIR VIII HERO (WI-FI)
  * ROG CROSSHAIR VIII FORMULA,
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 3ad8eadea68f..e3d794fb0534 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -176,6 +176,11 @@ static const struct dmi_system_id asus_ec_dmi_table[] __initconst = {
 	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "PRIME X570-PRO",
 		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
 		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET),
+	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
+			      "ProArt X570-CREATOR WIFI",
+		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CPU_OPT |
+		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
 	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "Pro WS X570-ACE",
 		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
 		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET |
-- 
2.35.1

