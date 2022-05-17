Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB8252A106
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345967AbiEQMBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345698AbiEQMAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:00:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DC14C438;
        Tue, 17 May 2022 05:00:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p26so5860196eds.5;
        Tue, 17 May 2022 05:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIDUTK5KnimKV7JPutWUmQpjQBhC0JH0W89/0KDYnjU=;
        b=RQCz9EbIFBKO/NOfhXlfo4Q7TvDzKZ7H7v4R/cNmC+z4puIALw2lhYHwQBhoLjnLbR
         Ndjq20lDO3NwP0RwxjtLVogUH7KFgcARDSxN3iBtameSx2RZi0Wh1aq6RKtnkq/Spl06
         XE5sRBl3nq8pdk9PfdoML96Nprl3ww+pEW478UnctxZ3U1v2Ae5xzJJxVGdqg15cTJdP
         29Zpcwb9feZFy+NXvVZr7nD2KPzOPYE4GqYPPkLG+cb5FX3i1VyXUvSenrsnQzBoGBlA
         16CxSVZfQyf4c18zjoT3KmfFZUrhRHNyhTgdlLGZUHbTtSZVdiW5YG+pLnXxRjJ2dd76
         IIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIDUTK5KnimKV7JPutWUmQpjQBhC0JH0W89/0KDYnjU=;
        b=JdsqUrz7+PFK9S6/jk91HEu+cK1hn1bNaX/mliBpNyz60/t/3UMeACfaWgqcsF5wmA
         kBFivN5aVGG6s65dB7PdzeHG0oBReJYLpaJiXR8irKMpVvnZaQwZ6kIKUiG1TyuonTrF
         2/s7iBBpKWF+6jwLnrOtWw9t8MX6k0TPktI9OeBL0i7t1t/b5nzNXwPZNrvKUq8PY3ko
         F4oKwyHiXWDXh3egGexuOR8hqbmXGQmoeLWzb5HrEYHmQfxti6Hy10OV9Zs24iGAgfwk
         bUQyiiOyZK4TvflSfDRui3I7qvX4vK1DvJx/Kph9yyO0gNxhrSAzRyyBzG2Vctrkmq0C
         sfJA==
X-Gm-Message-State: AOAM532545Ibidlg8V8ZplKA79ewSm8MN/Z4qEIt0PPy7lri46kYWTMr
        fLjcINlInpF8dPWcyAIfCrM=
X-Google-Smtp-Source: ABdhPJyDRt/3ywLm3HpJw0qfsNJeUCoRwrcCtPK6mz7pj68/AwsGEti4Otcb/RnNx7gSnhGljzOwBw==
X-Received: by 2002:a50:ed8b:0:b0:42a:a7e0:f889 with SMTP id h11-20020a50ed8b000000b0042aa7e0f889mr13997868edr.79.1652788804933;
        Tue, 17 May 2022 05:00:04 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id hg16-20020a1709072cd000b006f3ef214e20sm948793ejc.134.2022.05.17.05.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:00:04 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 2/6] regulator: qcom_spmi: add support for HT_P150
Date:   Tue, 17 May 2022 13:59:56 +0200
Message-Id: <20220517120000.71048-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517120000.71048-1-robimarko@gmail.com>
References: <20220517120000.71048-1-robimarko@gmail.com>
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

