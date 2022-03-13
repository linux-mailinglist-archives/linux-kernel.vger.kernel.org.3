Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D254D77DC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiCMTHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiCMTHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:07:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED268E1AE;
        Sun, 13 Mar 2022 12:06:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m12so17004464edc.12;
        Sun, 13 Mar 2022 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=SVeDRTZlPApsEAfDXxDR5Jk81+D0iJD2TyLZwO9wr2U=;
        b=HF9z4rmS65SexmXov8wMy98lKq4GWWePayPR2f4uvUXWZEtrZc7G17Fgl//IYgq9V8
         ce8YkE+nUZpsny6scBl/T7037A9U+e/PpmL0eDK2aimMjdF2uJ+7VL0onqnTU5hNSDTm
         tOX7obYsVf3LU3zoVM7D6xFqluzMSV15yLjfYwBToB9ifsdM4+/yuW5AuKa/8exVQP29
         qrdwAoDE5XoXvvEL11Ufv1zhxRsbcHehLrPXLWHk2YiCFlaMlT48Zn2/rUuItm7WOs5B
         kV8zETbtT8m1NTJF6X564BHh9aW5VIL3VP3m7bFXDXd58WKVqaLAkmyfAFEE0t5pMdrj
         1nrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=SVeDRTZlPApsEAfDXxDR5Jk81+D0iJD2TyLZwO9wr2U=;
        b=O7io/j2I8xdHkOsgeR1mAaGLze2/KeLLJ33XHnIDD33us3LLWgowM/cbyPJyToNYAg
         O+Og+8hrvOJtu/Xt39NhXAn51zmyLYPimiUPVJcMoGbPKIgpH585omW/2s2VrPrI7/T2
         /UwXyQ6Jvj0PWtjj68HXFPBPlMXXnLuqp6TuTHId0ZU+rLUQbGrE/FA46igfIzxCPltw
         PfxvICzhA2RYGONANV3MgEaJgx0mqcmxBX2wJ+gpudfsHtgch0tABLi9jaAsdQNe+BXf
         ir/dvKTt24GC40+AlWaSzSco/fUbKtwviguvcG+l6asODZVpbU7eNffwW9ozQXbrsWT+
         mrDg==
X-Gm-Message-State: AOAM532k/AebwZ8ry83EIf5HzqnXgAP+1SNYs4WOe5L3Idd6v7+e8VZD
        l+Ky/VOybbGrN2JlsWj10NI=
X-Google-Smtp-Source: ABdhPJylUFOrym+Y3jJ9hf4vxXLAQceumEA3mDjbFPcJOcmHSt3JusOMW+Vk3Pdi0wrzUCJ/EllrHg==
X-Received: by 2002:a05:6402:35d0:b0:416:cee9:53d9 with SMTP id z16-20020a05640235d000b00416cee953d9mr12152788edc.82.1647198335358;
        Sun, 13 Mar 2022 12:05:35 -0700 (PDT)
Received: from omen ([188.127.98.149])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006d2a835ac33sm5895333ejc.197.2022.03.13.12.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:34 -0700 (PDT)
Date:   Sun, 13 Mar 2022 20:05:32 +0100
From:   Enver Balalic <balalic.enver@gmail.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        pobrn@protonmail.com
Subject: [PATCH] platform/x86: hp-wmi: support omen thermal profile policy v1
Message-ID: <20220313190532.vpeuytz2ergnfsyt@omen>
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

Signed-off-by: Enver Balalic <balalic.enver@gmail.com>
---
 drivers/platform/x86/hp-wmi.c | 69 +++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 48a46466f086..ed5c729f8da1 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -61,6 +61,14 @@ static const char * const omen_thermal_profile_boards[] = {
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
@@ -115,6 +123,7 @@ enum hp_wmi_gm_commandtype {
 	HPWMI_SET_PERFORMANCE_MODE = 0x1A,
 	HPWMI_FAN_SPEED_MAX_GET_QUERY = 0x26,
 	HPWMI_FAN_SPEED_MAX_SET_QUERY = 0x27,
+	HPWMI_GET_SYSTEM_DESIGN_DATA = 0x28,
 };
 
 enum hp_wmi_command {
@@ -149,6 +158,12 @@ enum hp_wireless2_bits {
 	HPWMI_POWER_FW_OR_HW	= HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
 };
 
+enum hp_thermal_profile_omen_v1 {
+	HP_OMEN_V1_THERMAL_PROFILE_DEFAULT	= 0x30,
+	HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE	= 0x31,
+	HP_OMEN_V1_THERMAL_PROFILE_COOL		= 0x50,
+};
+
 enum hp_thermal_profile_omen {
 	HP_OMEN_THERMAL_PROFILE_DEFAULT     = 0x00,
 	HP_OMEN_THERMAL_PROFILE_PERFORMANCE = 0x01,
@@ -360,9 +375,6 @@ static int omen_thermal_profile_set(int mode)
 	char buffer[2] = {0, mode};
 	int ret;
 
-	if (mode < 0 || mode > 2)
-		return -EINVAL;
-
 	ret = hp_wmi_perform_query(HPWMI_SET_PERFORMANCE_MODE, HPWMI_GM,
 				   &buffer, sizeof(buffer), sizeof(buffer));
 
@@ -384,6 +396,30 @@ static bool is_omen_thermal_profile(void)
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
+			return 1;
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
@@ -1009,12 +1045,15 @@ static int platform_profile_omen_get(struct platform_profile_handler *pprof,
 
 	switch (tp) {
 	case HP_OMEN_THERMAL_PROFILE_PERFORMANCE:
+	case HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE:
 		*profile = PLATFORM_PROFILE_PERFORMANCE;
 		break;
 	case HP_OMEN_THERMAL_PROFILE_DEFAULT:
+	case HP_OMEN_V1_THERMAL_PROFILE_DEFAULT:
 		*profile = PLATFORM_PROFILE_BALANCED;
 		break;
 	case HP_OMEN_THERMAL_PROFILE_COOL:
+	case HP_OMEN_V1_THERMAL_PROFILE_COOL:
 		*profile = PLATFORM_PROFILE_COOL;
 		break;
 	default:
@@ -1027,23 +1066,38 @@ static int platform_profile_omen_get(struct platform_profile_handler *pprof,
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
+			tp = HP_OMEN_THERMAL_PROFILE_PERFORMANCE;
+		else
+			tp = HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE;
 		break;
 	case PLATFORM_PROFILE_BALANCED:
-		tp = HP_OMEN_THERMAL_PROFILE_DEFAULT;
+		if (tp_version == 0)
+			tp = HP_OMEN_THERMAL_PROFILE_DEFAULT;
+		else
+			tp = HP_OMEN_V1_THERMAL_PROFILE_DEFAULT;
 		break;
 	case PLATFORM_PROFILE_COOL:
-		tp = HP_OMEN_THERMAL_PROFILE_COOL;
+		if (tp_version == 0)
+			tp = HP_OMEN_THERMAL_PROFILE_COOL;
+		else
+			tp = HP_OMEN_V1_THERMAL_PROFILE_COOL;
 		break;
 	default:
 		return -EOPNOTSUPP;
 	}
 
 	err = omen_thermal_profile_set(tp);
+
 	if (err < 0)
 		return err;
 
@@ -1128,6 +1182,7 @@ static int thermal_profile_setup(void)
 		 */
 
 		err = omen_thermal_profile_set(tp);
+
 		if (err < 0)
 			return err;
 
-- 
2.35.1

