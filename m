Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8026D4B1A81
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346402AbiBKAg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:36:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245125AbiBKAgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:36:55 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1445F6E;
        Thu, 10 Feb 2022 16:36:55 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id e7so15144274ejn.13;
        Thu, 10 Feb 2022 16:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kv1dGBIwMVSJth+1nhxNVUaq58J6hWvLjV/FKpV6bvk=;
        b=hKdQIt2Icq2rygEQgAcjwPGIcbFKLqUWrpVWZxyNuRgaaPyfPzC6hvDWrJxqSdsOcp
         g3yBzhvdrb1bQGsL6aastzuiGIYSdhAvWksalNLMsXLwZ/pH+t9Kf+ZhWi37udgsSEyu
         yQerh6SzoKALw/rOOIGB9efBWoOHM08towXDWmCLQd3z4yD3aMB1CLSQ1munvUqUVuJg
         3GqRnmVDjO5Oa9uXaljqS2OZ7wZxfCgvGismqKldHpnLjpmVoKfdAqMG74SNePHsFbCS
         DBlWkSG8eIxZyucowmiaK2Wch7MOQLJkQlrS7VeHQ5QmVLm+y9/yMciZPW3TVYh4zjJh
         4KvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kv1dGBIwMVSJth+1nhxNVUaq58J6hWvLjV/FKpV6bvk=;
        b=bCL7lM5xoTnhAQH8A6Sl3UW+j0RtLQ17YRxYu/Oxmkzd3uQJHSzCYIOh0wFuxUQ+E+
         y5eENTi/hfuj8K2cJp2bgOGdTH7wc+qCs+odJaFG8RHfi76mSDobrRiKGMFA2cp22tml
         NkKGMpVniYcybzDS4FYkvXRo8/Qh5cG079ldWhDqsEnaBvgO6x2BSoAENMe4dvWpZkfx
         nhQqHY5OgkZnkilehULpcV92e3EYY5CJiiQ8qQyriaFpYIWC4EhOigIWD7NE9KdzxpM6
         GZhxcjYq03rR6QZ0TRU0VCbW+qFda5FUhmlsq39CrL7UJL/zzm5eIaFvydeuwOUXWWxB
         s3jA==
X-Gm-Message-State: AOAM530mALdqZTdRNzSkoMafxxmz4FR1PPzyl3d0DJIP3yhQZeLqN+Xu
        kVqy26Q/9vZm7A0JstbR3dQ=
X-Google-Smtp-Source: ABdhPJxM21xH/Q7n+t6LRSsdxbriX78/1XN92rY3TSvcB2vZPFGnsm6nRin0+jpifM5TlUVusYN8dw==
X-Received: by 2002:a17:906:738f:: with SMTP id f15mr8174635ejl.121.1644539813679;
        Thu, 10 Feb 2022 16:36:53 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id s1sm10493527edt.49.2022.02.10.16.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:36:52 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Denis Pauk <pauk.denis@gmail.com>,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) deduce sensor signess from its type
Date:   Fri, 11 Feb 2022 01:36:39 +0100
Message-Id: <20220211003641.73111-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading DSDT code for ASUS X470-based boards (the ones served by the
asus_wmi_Sensors driver), where ASUS put hardware monitoring functions
into the WMI code, reveals that fan and current sensors data is
unsigned. For the current sensor that was cofirmed by a user who showed
high enough current value for overflow.

Thus let's assume that the signess of the sensors is determined by its
type and that only temperature ones provide signed numbers.

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 38 +++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index bfac08a5dc57..a1b13fe149ac 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -266,6 +266,13 @@ static u8 register_index(u16 reg)
 	return reg & 0x00ff;
 }
 
+static bool is_sensor_data_signed(const struct ec_sensor_info *si)
+{
+	// guessed from WMI functions in DSDT code for boards
+	// of the X470 generation
+	return si->type == hwmon_temp;
+}
+
 static const struct ec_sensor_info *
 get_sensor_info(const struct ec_sensors_data *state, int index)
 {
@@ -420,15 +427,28 @@ static int asus_ec_block_read(const struct device *dev,
 
 static inline s32 get_sensor_value(const struct ec_sensor_info *si, u8 *data)
 {
-	switch (si->addr.components.size) {
-	case 1:
-		return (s8)*data;
-	case 2:
-		return (s16)get_unaligned_be16(data);
-	case 4:
-		return (s32)get_unaligned_be32(data);
-	default:
-		return 0;
+	if (is_sensor_data_signed(si)) {
+		switch (si->addr.components.size) {
+		case 1:
+			return (s8)*data;
+		case 2:
+			return (s16)get_unaligned_be16(data);
+		case 4:
+			return (s32)get_unaligned_be32(data);
+		default:
+			return 0;
+		}
+	} else {
+		switch (si->addr.components.size) {
+		case 1:
+			return *data;
+		case 2:
+			return get_unaligned_be16(data);
+		case 4:
+			return get_unaligned_be32(data);
+		default:
+			return 0;
+		}
 	}
 }
 
-- 
2.35.1

