Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FAE52C2B5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbiERSsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241514AbiERSsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:48:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C325229FC4;
        Wed, 18 May 2022 11:48:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id en5so4193211edb.1;
        Wed, 18 May 2022 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIDUTK5KnimKV7JPutWUmQpjQBhC0JH0W89/0KDYnjU=;
        b=J44s1ans0SSy90tmQa/O2rZJUCOaV3aR7DTBt48i4oBraFtDqEIM6wWQ+185s4xqq+
         wmkFHhGkO8t73cYclaynQO5yCUDxNpwP/P/QEVK2HIlHS3V++m9Bh/HyxOEyxUakQQXP
         eGRazUsm1uTXq+8b4E5vuhA5h7jgj+JpncXZ3T6OxU6ZSDTNbxPv1be1DsL0zsgiTYe0
         u2QaBpkEO5jG3Qvsn3yVoVxYf04rmrtb2bRO3g1pJQrMLETa+x00/tCtnuKRKODMqm/e
         oVBvyOWxZ/PUIljiy0Srh5uif1h3AGVS/vbGUppbfduq2VfEr/bvzFbuWzYjLd7eWCXf
         FgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIDUTK5KnimKV7JPutWUmQpjQBhC0JH0W89/0KDYnjU=;
        b=WKNOS8P0RCbfeojR2kntf6gtZC7NHLpxKRi26OEMfW6Ogy9ywTWR93QqMm/HSvvwu1
         FraxPrNobio9D8oggoWXpYZJ5ua7cMcGuD95YkDaW0bl36UIOF9YEP3lVYnx/Jfe0K9X
         fpX+i6HL46ZIuSshPHBlNolnk3FSI21vbWhrpANjf2WyRfyQK9qQCJbAPtHvXutGnzO1
         h3sve0Ai/gXsKh1nB+0APpEvmCFZ3H3s4VgiJ9laTqShwrnV31qnF2MmT6q26I/H4zFs
         8y4QhHoz+9iDJQRPGOZuLcpz6MNLDo2Ut7eYkrioAHktc21ymMizelz1oJZwxjMwQbsV
         i4GQ==
X-Gm-Message-State: AOAM531Edkzw6q4q6VYn/EcbeN7By2XSnGKULM6ks0EQoS181LJHkZFB
        3Ma6c9nzSH4/YJMBG7A0rBw=
X-Google-Smtp-Source: ABdhPJzeaRt3uFy/kPwKyUmUalvnCJE31pbdlROPe9mjOT3ozTY60YHFMprRAACP70010jAyaafTSQ==
X-Received: by 2002:a05:6402:293:b0:42a:aece:5c5c with SMTP id l19-20020a056402029300b0042aaece5c5cmr1287216edv.108.1652899709113;
        Wed, 18 May 2022 11:48:29 -0700 (PDT)
Received: from fedora.robimarko.hr ([188.252.220.143])
        by smtp.googlemail.com with ESMTPSA id q18-20020aa7cc12000000b0042aa40e76cbsm1702662edt.80.2022.05.18.11.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:48:28 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@somainline.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 2/6] regulator: qcom_spmi: add support for HT_P150
Date:   Wed, 18 May 2022 20:48:21 +0200
Message-Id: <20220518184825.1034976-2-robimarko@gmail.com>
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

