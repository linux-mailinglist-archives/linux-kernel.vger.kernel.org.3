Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6573B52C2BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbiERSsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241572AbiERSse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:48:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDF6229FD4;
        Wed, 18 May 2022 11:48:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i27so5501409ejd.9;
        Wed, 18 May 2022 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKTBlcPzeTtNqnyrU1hJ/yZCoy1XKsotOx9CBAENNAA=;
        b=iIP0uqn2s0ThuY226ziAYnGIsVwpL6cgREpDNC5CQzExM6puHKbsdCo74HaFJNwuFa
         VjYmRW8TI9dbThrsSHFEOGFvZShYxjDtzC8VRS6k5MMkrgOsKy2DZnLb3YPExekNvegP
         YXHJUO57XDRHzFOKiW9CM4+wdq2tEEBiJSJ/3EEnjIyAhyHzwjCAeA0TEcIDz05/Qw6n
         ZUgKai/jHlTUtEs5UrOULTk/OMR6VwQGRAiqErUusHbqZEOimeSO8e0a+V0XYTTlm9YE
         X7xV/APeFbG2rk+o5HKNbmpARxYpBTjrBAlFFYhD/Yq93PrDYBlDjV/clKBl7Jk06JTf
         8RzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKTBlcPzeTtNqnyrU1hJ/yZCoy1XKsotOx9CBAENNAA=;
        b=DepugzBiA69fwdG+s9xDUbxlQS18g2tkUX32e95kWv0pCRcMuu8TmxxxE/4q0dSh08
         IhQ0x34loYovyhWKO3VrV52EsSYWz9Cy7HQo/Aw882y4K0iE5tUbc72KR3gamEp9TgXQ
         afTMH7x7m9wqYOaXf0Z61d1HdGZNyt9Enox7gRKlIsovs3ZGuHU73tJZtDY9EuxWFJoR
         wCrekOASG+Lho5LMVzdy6YsYGtgKoumRnPosL5A61w9xg1WQ4gdbIchoK9NQsDgfsyWF
         +5wV4e/HdOnlui2yVTAJrv18LyyZeFBQCCOGbHeUjw11ewTgtcaieRozd7fffGWbWIRi
         /EOQ==
X-Gm-Message-State: AOAM530OThDo0mOZhb+jUFnVHPykxxlmTQ7ZQtyRpKKMD4CS23i5fEE7
        KBcE/UE/lcubrdHiv/zI8lQ=
X-Google-Smtp-Source: ABdhPJwP9I+wn8nO3sNvFtla+4z83/ygzywjtZ7c8sXgW6+brYu+mJlKJqnkP+Eka/jCqaCNKYIBFA==
X-Received: by 2002:a17:907:3e28:b0:6f4:3ba3:504e with SMTP id hp40-20020a1709073e2800b006f43ba3504emr901913ejc.632.1652899710195;
        Wed, 18 May 2022 11:48:30 -0700 (PDT)
Received: from fedora.robimarko.hr ([188.252.220.143])
        by smtp.googlemail.com with ESMTPSA id q18-20020aa7cc12000000b0042aa40e76cbsm1702662edt.80.2022.05.18.11.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:48:29 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@somainline.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 3/6] regulator: qcom_spmi: add support for HT_P600
Date:   Wed, 18 May 2022 20:48:22 +0200
Message-Id: <20220518184825.1034976-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518184825.1034976-1-robimarko@gmail.com>
References: <20220518184825.1034976-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HT_P600 is a LDO PMOS regulator based on LV P600 using HFS430 layout
found in PMP8074 and PMS405 PMIC-s.

Both PMP8074 and PMS405 define the programmable range as 1.704 to 1.896V
but the actual MAX output voltage depends on the exact LDO in each of
the PMIC-s.
Their usual voltage that they are used is 1.8V.

It has a max current of 600mA, voltage step of 8mV.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 38bbc70241ae..ad9ad9f4be8e 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -165,6 +165,7 @@ enum spmi_regulator_subtype {
 	SPMI_REGULATOR_SUBTYPE_ULT_HF_CTL4	= 0x10,
 	SPMI_REGULATOR_SUBTYPE_HFS430		= 0x0a,
 	SPMI_REGULATOR_SUBTYPE_HT_P150		= 0x35,
+	SPMI_REGULATOR_SUBTYPE_HT_P600		= 0x3d,
 };
 
 enum spmi_common_regulator_registers {
@@ -549,6 +550,10 @@ static struct spmi_voltage_range ht_p150_ranges[] = {
 	SPMI_VOLTAGE_RANGE(0, 1616000, 1616000, 3304000, 3304000, 8000),
 };
 
+static struct spmi_voltage_range ht_p600_ranges[] = {
+	SPMI_VOLTAGE_RANGE(0, 1704000, 1704000, 1896000, 1896000, 8000),
+};
+
 static DEFINE_SPMI_SET_POINTS(pldo);
 static DEFINE_SPMI_SET_POINTS(nldo1);
 static DEFINE_SPMI_SET_POINTS(nldo2);
@@ -570,6 +575,7 @@ static DEFINE_SPMI_SET_POINTS(ht_lvpldo);
 static DEFINE_SPMI_SET_POINTS(ht_nldo);
 static DEFINE_SPMI_SET_POINTS(hfs430);
 static DEFINE_SPMI_SET_POINTS(ht_p150);
+static DEFINE_SPMI_SET_POINTS(ht_p600);
 
 static inline int spmi_vreg_read(struct spmi_regulator *vreg, u16 addr, u8 *buf,
 				 int len)
@@ -1464,6 +1470,7 @@ static const struct regulator_ops spmi_hfs430_ops = {
 
 static const struct spmi_regulator_mapping supported_regulators[] = {
 	/*           type subtype dig_min dig_max ltype ops setpoints hpm_min */
+	SPMI_VREG(LDO,   HT_P600,  0, INF, HFS430, hfs430, ht_p600, 10000),
 	SPMI_VREG(LDO,   HT_P150,  0, INF, HFS430, hfs430, ht_p150, 10000),
 	SPMI_VREG(BUCK,  GP_CTL,   0, INF, SMPS,   smps,   smps,   100000),
 	SPMI_VREG(BUCK,  HFS430,   0, INF, HFS430, hfs430, hfs430,  10000),
-- 
2.36.1

