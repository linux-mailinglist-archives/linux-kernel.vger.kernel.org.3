Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E934B2AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351755AbiBKQtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:49:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351741AbiBKQtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:49:15 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5FBFD;
        Fri, 11 Feb 2022 08:49:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cf2so17300772edb.9;
        Fri, 11 Feb 2022 08:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yKc5L2zSb0WrgqB8kVdfmUciIdq+he8HTbE3U/mYjn4=;
        b=hSChiH/iP4H8xwp23NPYrL2UsaNNZpwWauF4qk3/AawBghuYAEcNnzwbzWA9H9tJ8t
         0c0Ws1U3ajPjnu2WlRhR7tXLLlFEU3GXFSQZUcaQnqvDpAIwGsDsTfAKTFV3vaUrfvYU
         AXbOr3MidA37HqMfIE5r/czWyrx3MAHN4spUijsyg3PFXx3Tnzdva0jlxNjH5K3gb3r0
         pXY1IUll3XicSFZjlzREWXFFd4pXPW7iZo65m7CitOUpHAnnrpJRpcXvgERFt98pLNvx
         C//Ln8+xIIK0HIFxilUDn44iI3Z8fyOaiFR6Fn9fVxkw/KLraQSOmy5ebMe9HX69GTZa
         KVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yKc5L2zSb0WrgqB8kVdfmUciIdq+he8HTbE3U/mYjn4=;
        b=GjKGm4QtYW1HW5VMevljqAURY2+2ePQE13kFDlyLouTT9b1RRiYkoYdppsTEFtdU4e
         kuwOWpJTEeshI1V4sO2QMSC76XSE34ItA+Lrd1kXjS4s4x8+u9cxOvPq4xjWF5GtjFJt
         h+Kd1uKZ3vKpiAm92C07pb9fzg7V0xByg4ZnBltC8qQL+P6fFwrob5S00XxszP17E46N
         zrzR154OFCj9bNJ8VkbqwwzX0n0mg/o51sJsglqqFT8MDymdRQyH41/Py4JswWytpFS6
         CapUhGRLTCm1kylJAwJYIDgw/e6hKt57ry/++Ekozu/9B/h5fyPT6zHI6zSqBLpl/Zkm
         xElw==
X-Gm-Message-State: AOAM5322J3Ic/cwP6uj+uys3W2bIvQq29DxHCkp5IbCIrw1/GwRu3qLz
        Cq5ZksBK94jQAUGhkTT9UMxpXshRTycJcA==
X-Google-Smtp-Source: ABdhPJyB4fGVN3crLlj1W8jNEd6upE2WjCCWlV3k9GoGSrWz6pFYONLcnMgwExy6aiS8XqMa5SjWFg==
X-Received: by 2002:a05:6402:3590:: with SMTP id y16mr2955433edc.386.1644598152788;
        Fri, 11 Feb 2022 08:49:12 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id x12sm10953972edv.57.2022.02.11.08.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:49:12 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Denis Pauk <pauk.denis@gmail.com>,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (asus-ec-sensors) deduce sensor signedness from its type
Date:   Fri, 11 Feb 2022 17:48:55 +0100
Message-Id: <20220211164855.265698-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211003641.73111-1-eugene.shalygin@gmail.com>
References: <20220211003641.73111-1-eugene.shalygin@gmail.com>
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
unsigned. For the current sensor that was confirmed by a user who showed
high enough current value for overflow.

Thus let's assume that the signedness of the sensors is determined by its
type and that only temperature ones provide signed numbers.

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 40 +++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index bfac08a5dc57..d2b84578d2af 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -266,6 +266,15 @@ static u8 register_index(u16 reg)
 	return reg & 0x00ff;
 }
 
+static bool is_sensor_data_signed(const struct ec_sensor_info *si)
+{
+	/*
+	 * guessed from WMI functions in DSDT code for boards
+	 * of the X470 generation
+	 */
+	return si->type == hwmon_temp;
+}
+
 static const struct ec_sensor_info *
 get_sensor_info(const struct ec_sensors_data *state, int index)
 {
@@ -420,15 +429,28 @@ static int asus_ec_block_read(const struct device *dev,
 
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

