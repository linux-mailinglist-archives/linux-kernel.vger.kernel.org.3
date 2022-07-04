Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC8B565F0C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiGDVY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiGDVYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:24:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA40010FEB;
        Mon,  4 Jul 2022 14:24:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id fd6so13038412edb.5;
        Mon, 04 Jul 2022 14:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKTBlcPzeTtNqnyrU1hJ/yZCoy1XKsotOx9CBAENNAA=;
        b=cx7knMNy/RTcqIAtDpMWLflHmEGfcfVOfufxQctKFPmCR3991aoNB9HbBOCPDAWNa3
         y1Tn1NdUC/SCguxO6t4C+2Atwz3I2IoJzDLM42vtNIWusLZdDmnBoqW59b1MfGcrPgrE
         KcbL5r2yjIpBs7DrJTv6sPDWRtDnpGmZ0/Ii3uPIqfoJ1i/eydJim3dk7ZLhXZ42qRXm
         MSwKOtxxq4TlGcgBUtgCDdQQGFEe2JilaG0a9fkuh/gLCeWWHgychsFqjQTg5PIeWmbC
         /YJg977Bw1b1wKMvHJS88a1MXnRvr7yC5ppT1Qew82fRLLxbXuWjqEYr/EepLJSMMJjq
         OoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKTBlcPzeTtNqnyrU1hJ/yZCoy1XKsotOx9CBAENNAA=;
        b=dw/YogmJByqsDsgRO8zBGB1wZWLp9Yktp1iXaRHXnLHYr2gkB79sIXhnmfanhY459z
         rMcDOaAALOOtQz0KcWfPRqWjRPzST7rIh3YRKhjusM1ZwXhKCmufiBm/0gVTPrN7/cBi
         uexhr0Xogu1gIZbePl6kPD1IVPdgihe15jXEMWyu2a1Hfd2S7yfE692GVo+I1yvuwlEv
         NIO6VPXciRE3eoN7qwNa1kGERH8G467z0kEw7NuKGfYKbmSU3YvBFoI+UWt0bbeh60OH
         EE1znJuPjkAUw8K7Cm2E3fmNmqOw99iuTaATM/XmmHKiZdcEJYzxRZGTMtVWibQeLbpz
         3/OA==
X-Gm-Message-State: AJIora/BrMH+CX0iKjfIeTqR5fwqXOGHjkFcB3megkfmue/coeyPZSBx
        iYGo7w9JajmOhsLOKDMGxHQ=
X-Google-Smtp-Source: AGRyM1udASbZPCvFns16TjCXoQo78F7gpfERpvzJDxsCQszQMX8GH//fAXtr/TymJn+nTVchALHHtA==
X-Received: by 2002:a05:6402:2985:b0:439:651b:c1f4 with SMTP id eq5-20020a056402298500b00439651bc1f4mr30559264edb.276.1656969850307;
        Mon, 04 Jul 2022 14:24:10 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id k18-20020a056402049200b0042dcbc3f302sm20131117edv.36.2022.07.04.14.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 14:24:10 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jic23@kernel.org, lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 05/12] regulator: qcom_spmi: add support for HT_P600
Date:   Mon,  4 Jul 2022 23:23:55 +0200
Message-Id: <20220704212402.1715182-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704212402.1715182-1-robimarko@gmail.com>
References: <20220704212402.1715182-1-robimarko@gmail.com>
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

