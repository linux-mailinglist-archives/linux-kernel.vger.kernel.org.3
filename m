Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400F44D849B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbiCNM1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242905AbiCNMTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:19:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8BD51331;
        Mon, 14 Mar 2022 05:14:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r29so10364928edc.0;
        Mon, 14 Mar 2022 05:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=3WC+TD4FBHpBLqCHsa4MOv+icPwxDrsEqLNk4zGZrRE=;
        b=b0sbcvpSyTk6Yd7RLbcN4nLTjeM47lwPzKWkkHaJJV0XubYWPjOeiV1JdQU/gFcglg
         P3Gy9eEo5MEZz7betclE3Bl/8UxBgJkXURcQmlAuE3JWfh4X70uBPLP2WJp+8MwO0qhZ
         s9H3cvPK/f46gOW5El0ShWW2Ud5ak1/rEubv0WYMrEFlXhyihdD9rowTP0d2/480Zhxg
         ocDa1yncQU8iCRXcXRCDCozZYm8RC5BED/s5WPkJ2zzrKeOEJqbjmB2gcO7+kf6Ogr7a
         CJPI2qq9HpFvKMQKz9q65VPuY8/kX4w+Oiz0zSfLUBGL89wo4Un20PCeHRyPJ6DZBQ2I
         K5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=3WC+TD4FBHpBLqCHsa4MOv+icPwxDrsEqLNk4zGZrRE=;
        b=CJseypwH9uza4+0kh1/Lq05E9Aj7EUIRjqwkruQo/IiLp3qXFcc1+dromXF/2yyLnV
         3bBW7YSWV2UoEx2hDG61I+KDEMfiZvcpAj2/8W9L49fRPoiqudJo1M2UrokZl0JiPANm
         B8Psx545m38MYPMe+d7jsivpWHrwcdYYX7q/5YlqH1JLKCkWG2o8Qfguk6yvnqUYwm7Z
         PK7BjvXirMt1qflwZXeMrNYqHjo/r6iB9M1IB4phLdDUiHC1TwoPWqfbpyicmYo1k234
         EhQ82PnqOShazWi+PjmRd4nYH5PCh9oVQTTnPr0UV055GmnvF4lSHwRT1jRGXHW6JfMA
         ou7w==
X-Gm-Message-State: AOAM532icsLZcyJe/BHI78HiYbLuTUmnrPGGvldlxh/Mb6SgkUTdEKtl
        YgkoA8BdlSE3X2SshU/wKmA=
X-Google-Smtp-Source: ABdhPJygdbGsXpWU4NE9iSyaPTriEuM8Fw8twEq7ip4rW4QKiKvgjy5ItZGSlfW9vb+avg8C6oAsSA==
X-Received: by 2002:a05:6402:27ce:b0:416:9d78:9f1f with SMTP id c14-20020a05640227ce00b004169d789f1fmr20157095ede.356.1647260096658;
        Mon, 14 Mar 2022 05:14:56 -0700 (PDT)
Received: from omen ([188.127.98.149])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006d229436793sm6710852ejp.223.2022.03.14.05.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 05:14:55 -0700 (PDT)
Date:   Mon, 14 Mar 2022 13:14:53 +0100
From:   Enver Balalic <balalic.enver@gmail.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        pobrn@protonmail.com
Subject: [PATCH v2] platform/x86: hp-wmi: support omen thermal profile policy
 v1
Message-ID: <20220314121453.kjszdciymtg6ctbq@omen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it turns out, these laptops have 2 thermal profile versions.
A previous patch added support for v0, this patch adds support
for v1 thermal policies that are in use on some devices.
We obtain the thermal policy version by querying the get system
design data WMI call and looking at the fourth byte it returns,
except if the system board DMI Board ID is in a specific array
that the windows command center app overrides to thermal policy
v0 for some reason.

- V1
  Initial Patch
- V2
  Rename V0 thermal policy values to HP_OMEN_V0_THERMAL_PROFILE_
  for consistency with the V1 thermal policy values.
  Fix issue where instead of forcing certain boards to V0, they
  were being forced to V1.
  Drop unnecessary newline additions.

Signed-off-by: Enver Balalic <balalic.enver@gmail.com>
---
 drivers/platform/x86/hp-wmi.c | 81 +++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index c56c8864961d..0109ddc84be7 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -57,6 +57,14 @@ static const char * const omen_thermal_profile_boards[] = {
 	"8917", "8918", "8949", "894A", "89EB"
 };
 
+/* DMI Board names of Omen laptops that are specifically set to be thermal
+ * profile version 0 by the Omen Command Center app, regardless of what
+ * the get system design information WMI call returns
+ */
+static const char *const omen_thermal_profile_force_v0_boards[] = {
+	"8607", "8746", "8747", "8749", "874A", "8748"
+};
+
 enum hp_wmi_radio {
 	HPWMI_WIFI	= 0x0,
 	HPWMI_BLUETOOTH	= 0x1,
@@ -117,6 +125,7 @@ enum hp_wmi_gm_commandtype {
 	HPWMI_SET_PERFORMANCE_MODE = 0x1A,
 	HPWMI_FAN_SPEED_MAX_GET_QUERY = 0x26,
 	HPWMI_FAN_SPEED_MAX_SET_QUERY = 0x27,
+	HPWMI_GET_SYSTEM_DESIGN_DATA = 0x28,
 };
 
 enum hp_wmi_command {
@@ -151,10 +160,16 @@ enum hp_wireless2_bits {
 	HPWMI_POWER_FW_OR_HW	= HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
 };
 
-enum hp_thermal_profile_omen {
-	HP_OMEN_THERMAL_PROFILE_DEFAULT     = 0x00,
-	HP_OMEN_THERMAL_PROFILE_PERFORMANCE = 0x01,
-	HP_OMEN_THERMAL_PROFILE_COOL        = 0x02,
+enum hp_thermal_profile_omen_v1 {
+	HP_OMEN_V1_THERMAL_PROFILE_DEFAULT	= 0x30,
+	HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE	= 0x31,
+	HP_OMEN_V1_THERMAL_PROFILE_COOL		= 0x50,
+};
+
+enum hp_thermal_profile_omen_v0 {
+	HP_OMEN_V0_THERMAL_PROFILE_DEFAULT     = 0x00,
+	HP_OMEN_V0_THERMAL_PROFILE_PERFORMANCE = 0x01,
+	HP_OMEN_V0_THERMAL_PROFILE_COOL        = 0x02,
 };
 
 enum hp_thermal_profile {
@@ -407,9 +422,6 @@ static int omen_thermal_profile_set(int mode)
 	char buffer[2] = {0, mode};
 	int ret;
 
-	if (mode < 0 || mode > 2)
-		return -EINVAL;
-
 	ret = hp_wmi_perform_query(HPWMI_SET_PERFORMANCE_MODE, HPWMI_GM,
 				   &buffer, sizeof(buffer), 0);
 
@@ -431,6 +443,30 @@ static bool is_omen_thermal_profile(void)
 			    board_name) >= 0;
 }
 
+static int omen_get_thermal_policy_version(void)
+{
+	unsigned char buffer[8] = { 0 };
+	int ret;
+
+	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
+
+	if (board_name) {
+		int matches = match_string(omen_thermal_profile_force_v0_boards,
+			ARRAY_SIZE(omen_thermal_profile_force_v0_boards),
+			board_name);
+		if (matches >= 0)
+			return 0;
+	}
+
+	ret = hp_wmi_perform_query(HPWMI_GET_SYSTEM_DESIGN_DATA, HPWMI_GM,
+				   &buffer, sizeof(buffer), sizeof(buffer));
+
+	if (ret)
+		return ret < 0 ? ret : -EINVAL;
+
+	return buffer[3];
+}
+
 static int omen_thermal_profile_get(void)
 {
 	u8 data;
@@ -1053,13 +1089,16 @@ static int platform_profile_omen_get(struct platform_profile_handler *pprof,
 		return tp;
 
 	switch (tp) {
-	case HP_OMEN_THERMAL_PROFILE_PERFORMANCE:
+	case HP_OMEN_V0_THERMAL_PROFILE_PERFORMANCE:
+	case HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE:
 		*profile = PLATFORM_PROFILE_PERFORMANCE;
 		break;
-	case HP_OMEN_THERMAL_PROFILE_DEFAULT:
+	case HP_OMEN_V0_THERMAL_PROFILE_DEFAULT:
+	case HP_OMEN_V1_THERMAL_PROFILE_DEFAULT:
 		*profile = PLATFORM_PROFILE_BALANCED;
 		break;
-	case HP_OMEN_THERMAL_PROFILE_COOL:
+	case HP_OMEN_V0_THERMAL_PROFILE_COOL:
+	case HP_OMEN_V1_THERMAL_PROFILE_COOL:
 		*profile = PLATFORM_PROFILE_COOL;
 		break;
 	default:
@@ -1072,17 +1111,31 @@ static int platform_profile_omen_get(struct platform_profile_handler *pprof,
 static int platform_profile_omen_set(struct platform_profile_handler *pprof,
 				     enum platform_profile_option profile)
 {
-	int err, tp;
+	int err, tp, tp_version;
+
+	tp_version = omen_get_thermal_policy_version();
+
+	if (tp_version < 0 || tp_version > 1)
+		return -EOPNOTSUPP;
 
 	switch (profile) {
 	case PLATFORM_PROFILE_PERFORMANCE:
-		tp = HP_OMEN_THERMAL_PROFILE_PERFORMANCE;
+		if (tp_version == 0)
+			tp = HP_OMEN_V0_THERMAL_PROFILE_PERFORMANCE;
+		else
+			tp = HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE;
 		break;
 	case PLATFORM_PROFILE_BALANCED:
-		tp = HP_OMEN_THERMAL_PROFILE_DEFAULT;
+		if (tp_version == 0)
+			tp = HP_OMEN_V0_THERMAL_PROFILE_DEFAULT;
+		else
+			tp = HP_OMEN_V1_THERMAL_PROFILE_DEFAULT;
 		break;
 	case PLATFORM_PROFILE_COOL:
-		tp = HP_OMEN_THERMAL_PROFILE_COOL;
+		if (tp_version == 0)
+			tp = HP_OMEN_V0_THERMAL_PROFILE_COOL;
+		else
+			tp = HP_OMEN_V1_THERMAL_PROFILE_COOL;
 		break;
 	default:
 		return -EOPNOTSUPP;
-- 
2.35.1

