Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F2352D40D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbiESNag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238805AbiESNa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:30:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B012CEB84;
        Thu, 19 May 2022 06:30:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c10so7031588edr.2;
        Thu, 19 May 2022 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKTBlcPzeTtNqnyrU1hJ/yZCoy1XKsotOx9CBAENNAA=;
        b=QCi6YON6kzfb3U3uFpAY8u8lhl24QKwzJZB/r53yn0ficXSR4n+xwJnhPIo/4MEMd7
         T3rkObYkXwuC53cq0v+G+ZbdezpnIRVGYhy2brp+8WLTHkCWkKyL6YDYz452Pv047nM6
         AU/LAhBZBOsRt0LWWwSwPx7syUco01YaczcaF3+wsZZayRf4u+CH19F7cvKelYEW0Ds+
         R7clIRQPRXl6AuTdVMX5o1kL0dow4A2TeDjhfWEIjzJjNdWfhyY9Jrhkh1bdwul9DEPX
         la6YjFvxDKQCnC2V3a86imqltxrXseqJTgOUzELFths07jy6M3wOvTsPofiZOQ8Pr+w1
         +qog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKTBlcPzeTtNqnyrU1hJ/yZCoy1XKsotOx9CBAENNAA=;
        b=Auc8bvaK6k10OKVsmewScLc7Y6BGcR8kDtT+J7s40pEdZFKSiA84WlZX6Cs6lh6ksi
         jtdiMWhZdoFXYKmZ/2P5ETB5O8yOCKvfs6Oh9MRPYVOhs4eCjVk2vLs/V4ePIz8nosEZ
         6TbRwVMC5P27VprY8gponNjLRaiErYROiVt5k1B68+ORoBIsJAOK0XuD6nGRvq7k2Ikj
         1Tn1YHR4gNpBks7Q3Fr24EceEH1/ZQw/7y/9qSXrOMhP1uGlA/IJG3C/lf8yy4QB/X5q
         ozu0PsNKPZxFcGeNWFbJ+czzvgg79W/TuQ+PEawn207XcBcJZRpz5+5XPY1gbidx4dRO
         rq1g==
X-Gm-Message-State: AOAM53304Zr5XxDaaRis33rdO8rbDhf5Z20AlR4Fv1nl5MlUAFD88HvR
        bnDROcASdDali09vt7SkH/c=
X-Google-Smtp-Source: ABdhPJxHjNP/S/MOxe5q4RtJB6YJ8H3gwUuHiOWKT0YyD88HGluJqGkl4sgll/cnl4ntqmdN3iPLeQ==
X-Received: by 2002:a05:6402:5244:b0:427:b24c:a799 with SMTP id t4-20020a056402524400b00427b24ca799mr5275051edd.291.1652967021699;
        Thu, 19 May 2022 06:30:21 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-71.zg.cable.xnet.hr. [94.253.165.71])
        by smtp.googlemail.com with ESMTPSA id y17-20020a17090614d100b006f3ef214dd4sm2120383ejc.58.2022.05.19.06.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:30:21 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@somainline.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 3/7] regulator: qcom_spmi: add support for HT_P600
Date:   Thu, 19 May 2022 15:30:11 +0200
Message-Id: <20220519133015.484639-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519133015.484639-1-robimarko@gmail.com>
References: <20220519133015.484639-1-robimarko@gmail.com>
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

