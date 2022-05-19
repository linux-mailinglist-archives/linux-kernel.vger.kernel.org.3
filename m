Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C6052D40A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiESNac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbiESNa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:30:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04040CC15A;
        Thu, 19 May 2022 06:30:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g12so7002563edq.4;
        Thu, 19 May 2022 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIDUTK5KnimKV7JPutWUmQpjQBhC0JH0W89/0KDYnjU=;
        b=m8yheAljXGiSAp7sTPLVn41jM1DI7C22S/YSgdPtAZsrFfwp5W60wjaH6T8uKfZ29x
         f9PXETDthGEDSE+UHlxIeFv5wmnFoE0oVdgQ8Ua7l0P59/lKyMC3NZjIMhr25GJ2e2hb
         Zc9VrHmJFNlBJOd85ajBr7jRPy7CAdr1I5p2vIcB/P7ZPjLVZhj5EroI5+A413Li9tQw
         5xCooyoqMpYcscAyAd0c6IRTkF8jAGCRIwWN1laA4sXtwfa0gAyQTtSa3U1zpUHW0JI2
         HhhK2ooy15oQH9sq1UA+T86CutFLBIyxcCwkZcgXhtWbVAUO5lJIdsZxF6xVG7xLS9OK
         F/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIDUTK5KnimKV7JPutWUmQpjQBhC0JH0W89/0KDYnjU=;
        b=G95fBi+vrlRuI82VUvTpnb8BRivcuET+LbeYK+YPl9t7CYnxejEb302QM4BNgqHrO8
         0sP7eBxFqnSS2We1k0bEo7vFWSCMTBkr7LmMWKt0OzxFKq005ncS9ocxvUsTlyGOJcvi
         y3Y23/iB5yAGqYcN40jTHTj4a8FusWPYM1pGy9amfVNl61J2pwKuDBElQ5MBzHbDiCI6
         /Jou2f6UYLXghpFsoKHan3VcXB4EZz7M/5U6Jz3G37e7Kh4Sh0skXxrbUtXk9/HpQB+W
         5oAhJct7S/a8krqEAffrOIEhOcDJ5zvbGMIdESbMJH4OLFCiFXOcKATUQXeRbLQwVeXF
         4THg==
X-Gm-Message-State: AOAM533yBzI8XvH6IL57BuB8oyWNa8spC44TeHqSFE0KG+AEt5NB+UHG
        JwL4pwrNJg70GoP6myiraGc=
X-Google-Smtp-Source: ABdhPJxD/2CT/MGULbnCUrsZ1tb3g+UHs+Pb3kiiCQsEmpZ/ClE/+navdTOKiRkrNOfL7dKcy8qNqQ==
X-Received: by 2002:a05:6402:3301:b0:42a:ee56:310b with SMTP id e1-20020a056402330100b0042aee56310bmr5309547eda.69.1652967020604;
        Thu, 19 May 2022 06:30:20 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-71.zg.cable.xnet.hr. [94.253.165.71])
        by smtp.googlemail.com with ESMTPSA id y17-20020a17090614d100b006f3ef214dd4sm2120383ejc.58.2022.05.19.06.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:30:20 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@somainline.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 2/7] regulator: qcom_spmi: add support for HT_P150
Date:   Thu, 19 May 2022 15:30:10 +0200
Message-Id: <20220519133015.484639-2-robimarko@gmail.com>
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

HT_P150 is a LDO PMOS regulator based on LV P150 using HFS430 layout
found in PMP8074 and PMS405 PMIC-s.

Both PMP8074 and PMS405 define the programmable range as 1.616V to 3.304V
but the actual MAX output voltage depends on the exact LDO in each of
the PMIC-s.

It has a max current of 150mA, voltage step of 8mV.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 02bfce981150..38bbc70241ae 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -164,6 +164,7 @@ enum spmi_regulator_subtype {
 	SPMI_REGULATOR_SUBTYPE_ULT_HF_CTL3	= 0x0f,
 	SPMI_REGULATOR_SUBTYPE_ULT_HF_CTL4	= 0x10,
 	SPMI_REGULATOR_SUBTYPE_HFS430		= 0x0a,
+	SPMI_REGULATOR_SUBTYPE_HT_P150		= 0x35,
 };
 
 enum spmi_common_regulator_registers {
@@ -544,6 +545,10 @@ static struct spmi_voltage_range hfs430_ranges[] = {
 	SPMI_VOLTAGE_RANGE(0, 320000, 320000, 2040000, 2040000, 8000),
 };
 
+static struct spmi_voltage_range ht_p150_ranges[] = {
+	SPMI_VOLTAGE_RANGE(0, 1616000, 1616000, 3304000, 3304000, 8000),
+};
+
 static DEFINE_SPMI_SET_POINTS(pldo);
 static DEFINE_SPMI_SET_POINTS(nldo1);
 static DEFINE_SPMI_SET_POINTS(nldo2);
@@ -564,6 +569,7 @@ static DEFINE_SPMI_SET_POINTS(nldo660);
 static DEFINE_SPMI_SET_POINTS(ht_lvpldo);
 static DEFINE_SPMI_SET_POINTS(ht_nldo);
 static DEFINE_SPMI_SET_POINTS(hfs430);
+static DEFINE_SPMI_SET_POINTS(ht_p150);
 
 static inline int spmi_vreg_read(struct spmi_regulator *vreg, u16 addr, u8 *buf,
 				 int len)
@@ -1458,6 +1464,7 @@ static const struct regulator_ops spmi_hfs430_ops = {
 
 static const struct spmi_regulator_mapping supported_regulators[] = {
 	/*           type subtype dig_min dig_max ltype ops setpoints hpm_min */
+	SPMI_VREG(LDO,   HT_P150,  0, INF, HFS430, hfs430, ht_p150, 10000),
 	SPMI_VREG(BUCK,  GP_CTL,   0, INF, SMPS,   smps,   smps,   100000),
 	SPMI_VREG(BUCK,  HFS430,   0, INF, HFS430, hfs430, hfs430,  10000),
 	SPMI_VREG(LDO,   N300,     0, INF, LDO,    ldo,    nldo1,   10000),
-- 
2.36.1

