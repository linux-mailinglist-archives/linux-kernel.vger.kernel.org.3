Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC305861C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 00:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbiGaWiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 18:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbiGaWiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:38:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB0911C3C;
        Sun, 31 Jul 2022 15:38:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i13so11661108edj.11;
        Sun, 31 Jul 2022 15:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=LwdlcXAAjA7Q0eJQTvmHufANVoOrWU/uoysq72jiMcg=;
        b=YZkuhIZ3+XRvbahfiApHIEBOQJkG/h8hKoY066XMYVHmHmcZ9ZzdH7tnSGbmhcd1bn
         Nf6P2Cnt6s1sgWCFfmlAsNTsntX++yXBLRqeVew3T1GCrVKNIZGkaCGbD3BLxcb3WKAm
         Hz8bCFQCFiJyLaSlTtYnzi3eZQGgCx7OdERuKM+FdDXfWGb8kqjFsZCgOrsOt4pKMtTh
         9B5l1rWYE/J4dsTEM77Qi7T0/cfPizBPvYfBF/bAK1yYWr8AYpSjjeJAdXtOJCGOGo8a
         gv34jkP8YbmpBBZrMqguk5SH6rJqUhgLEJYUrd/fUAbhiWTdZR4Bx76dDIcn9MkRt4N0
         LYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LwdlcXAAjA7Q0eJQTvmHufANVoOrWU/uoysq72jiMcg=;
        b=USzcEufeAS2BsnJnkgl9Tk5TBsOvs7eMwYUh5E3Oekh06SkEocU80yImhQge9a/faI
         vm+FBJjLE8WRsuRhziQ0oPKb6CekJsDqO4T8jf9sWHP1Z8ye2RH3x+NiEuHL9c5r1Dbx
         tr8T+bHfVoqnbWFooSJm3kT/Xp33W/dZaa/B+wmElvOwScS1l3Ipb594Xp/LDvLjkgTe
         sXx7oSiJY5upERH2nVT25cE7uNpGpg02T6nUtBRbORCd44V1qwJpUcCBs06MDLA3hpoy
         N85JAmKCuUJhX5HuwctR01wwMQbQveXpdJ79jnmv4qrJLg090joA/Qlzs/pAejCHDMD9
         UUbw==
X-Gm-Message-State: ACgBeo3p7Um/3kNyrn4O82db8dvvhaRbVcN7+UYcoTFnCb35ATSq+bzq
        M++ZGtfTNX64NP0Affa+XMI=
X-Google-Smtp-Source: AA6agR5ZCAo+V0WePx70+TpfWbpeFeDo5pYrnNo4g1oGcJC8j+J9gF0jz48xlrydrfxmT7XJaxizaA==
X-Received: by 2002:a05:6402:3326:b0:43d:4448:437c with SMTP id e38-20020a056402332600b0043d4448437cmr8842384eda.394.1659307078878;
        Sun, 31 Jul 2022 15:37:58 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id la20-20020a170907781400b0072b7d76211dsm4475487ejc.107.2022.07.31.15.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 15:37:58 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v3 06/13] regulator: qcom_spmi: Add support for HFSMPS regulator type
Date:   Mon,  1 Aug 2022 01:37:29 +0300
Message-Id: <20220731223736.1036286-7-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220731223736.1036286-1-iskren.chernev@gmail.com>
References: <20220731223736.1036286-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is preparation for supporing PM6125.

The HFSMPS is a BUCK type regulator with subtype 0x0a, same as the
existing HFS430 regulator.

Even though the HFSMPS and HFS430 share a register layout, the HFSMPS has
different mode values (BYPASS, RETENTION and LPM are one lower).

I'm expecting future regulators (higher revision) with the same type and
subtype to share mode values of HFSMPS, so revisions 4 (found on pm6125)
and up use the new ops.

The inspiration of this is taken from [1].

[1] https://source.codeaurora.org/quic/la/kernel/msm-5.4/commit/?h=kernel.lnx.5.4.r1-rel&id=d1220daeffaa440ffff0a8c47322eb0033bf54f5

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 50c8ee01e0ad..19af294a6972 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -101,6 +101,7 @@ enum spmi_regulator_logical_type {
 	SPMI_REGULATOR_LOGICAL_TYPE_HFS430,
 	SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS3,
 	SPMI_REGULATOR_LOGICAL_TYPE_LDO_510,
+	SPMI_REGULATOR_LOGICAL_TYPE_HFSMPS,
 };
 
 enum spmi_regulator_type {
@@ -168,6 +169,7 @@ enum spmi_regulator_subtype {
 	SPMI_REGULATOR_SUBTYPE_HFS430		= 0x0a,
 	SPMI_REGULATOR_SUBTYPE_HT_P150		= 0x35,
 	SPMI_REGULATOR_SUBTYPE_HT_P600		= 0x3d,
+	SPMI_REGULATOR_SUBTYPE_HFSMPS_510	= 0x0a,
 	SPMI_REGULATOR_SUBTYPE_FTSMPS_510	= 0x0b,
 	SPMI_REGULATOR_SUBTYPE_LV_P150_510	= 0x71,
 	SPMI_REGULATOR_SUBTYPE_LV_P300_510	= 0x72,
@@ -1567,6 +1569,19 @@ static const struct regulator_ops spmi_ftsmps3_ops = {
 	.set_pull_down		= spmi_regulator_common_set_pull_down,
 };
 
+static const struct regulator_ops spmi_hfsmps_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.set_voltage_sel	= spmi_regulator_ftsmps426_set_voltage,
+	.set_voltage_time_sel	= spmi_regulator_set_voltage_time_sel,
+	.get_voltage_sel	= spmi_regulator_ftsmps426_get_voltage,
+	.map_voltage		= spmi_regulator_single_map_voltage,
+	.list_voltage		= spmi_regulator_common_list_voltage,
+	.set_mode		= spmi_regulator_ftsmps3_set_mode,
+	.get_mode		= spmi_regulator_ftsmps3_get_mode,
+};
+
 /* Maximum possible digital major revision value */
 #define INF 0xFF
 
@@ -1575,7 +1590,8 @@ static const struct spmi_regulator_mapping supported_regulators[] = {
 	SPMI_VREG(LDO,   HT_P600,  0, INF, HFS430, hfs430, ht_p600, 10000),
 	SPMI_VREG(LDO,   HT_P150,  0, INF, HFS430, hfs430, ht_p150, 10000),
 	SPMI_VREG(BUCK,  GP_CTL,   0, INF, SMPS,   smps,   smps,   100000),
-	SPMI_VREG(BUCK,  HFS430,   0, INF, HFS430, hfs430, hfs430,  10000),
+	SPMI_VREG(BUCK,  HFS430,   0,   3, HFS430, hfs430, hfs430,  10000),
+	SPMI_VREG(BUCK,  HFSMPS_510, 4, INF, HFSMPS, hfsmps, hfs430, 100000),
 	SPMI_VREG(LDO,   N300,     0, INF, LDO,    ldo,    nldo1,   10000),
 	SPMI_VREG(LDO,   N600,     0,   0, LDO,    ldo,    nldo2,   10000),
 	SPMI_VREG(LDO,   N1200,    0,   0, LDO,    ldo,    nldo2,   10000),
-- 
2.37.1

