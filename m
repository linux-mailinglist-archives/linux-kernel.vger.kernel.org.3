Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B675A5883EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiHBWMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbiHBWLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:11:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF864F696;
        Tue,  2 Aug 2022 15:11:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb36so2727374ejc.10;
        Tue, 02 Aug 2022 15:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=093z4OeDV4xKRmAmWYmEeta8tBKE3TYxd2SssrFD6Qk=;
        b=Dt2MmD71ezgyFBd/QssLkzzEKj2AcwTIXk2Y0DZUzJtll3ymB5Za0KDZ57pHQR93Po
         MKyPmJtmsL5cCaCx5w75QePN1Vu/ARBBpNE1EgVdXnu77gch5EWaciR9p5ObUvFx007t
         QAvjbm7jwELhMcVd3bIV/W+YVE2duRW5UdyPN2MDzw9x2Av9JVvcUrLGKR2d9dj3Y94k
         3Zw5D6oCDl7OIxYaczzf3yi+L8C9PqBuVaL+rSpy7MaYHM3Hh+eTvpQeN207T/t9Z1NP
         X/VIVaAH9FUXNRo5sOHc67EMkjGtBTBPAKwFL6ZFS/cauBizBMlSw9k+PIoLr46EHfXz
         4c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=093z4OeDV4xKRmAmWYmEeta8tBKE3TYxd2SssrFD6Qk=;
        b=DDZMNa9vyJIVpbaRd4M+tXLx8fzNoobdfX6PMQ+kL7kaJOs9X9vkZW52OgVzT7pAzv
         LisjvJ3QhCVIE9FUA20SKXiHTCYN5H2YeiWgWDMJ6FjnzY9opRIQmGyVGxEFHvEAP3E3
         /mMKCiEj2kbw1XQGjPXiyh7YGqMX31B1nagsRijGj+L1aao9J9aLdFdDzhBdqJwyxIhy
         h6Ies4opQCEBFYDl4mXCFrTC6RKU9AfBVtguLfVP71DBIJnZ/LQ4CXKVkjE3LgVcf0LL
         aZr3OHZfVKikYJNE9c/kiZWlXzrfCfnW/CoFLCPRyMIcnbFtFWegc9pF94WIPNu/gilV
         f3Tg==
X-Gm-Message-State: ACgBeo0KS5H98TxGt6kK0Z+ndaJo81m7N4pLHcUg21/8JdoXQ4D8P+ae
        jtbQZPoqtDkBKtxd/1BGhKk=
X-Google-Smtp-Source: AA6agR498M/nc8KnbMWjb5fbfZ/jut+OnC6h6S8+fF8t5h1xSdbsQN+6dg8jS6+4oUKbccfKjqtqjw==
X-Received: by 2002:a17:906:6a2a:b0:730:a3f1:aee with SMTP id qw42-20020a1709066a2a00b00730a3f10aeemr3174420ejc.387.1659478303407;
        Tue, 02 Aug 2022 15:11:43 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906211100b0072af2460cd6sm6634139ejt.30.2022.08.02.15.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:43 -0700 (PDT)
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
        Iskren Chernev <iskren.chernev@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>
Subject: [PATCH v4 06/13] regulator: qcom_spmi: Add support for LDO_510 and FTSMPS
Date:   Wed,  3 Aug 2022 01:11:05 +0300
Message-Id: <20220802221112.2280686-7-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220802221112.2280686-1-iskren.chernev@gmail.com>
References: <20220802221112.2280686-1-iskren.chernev@gmail.com>
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

Add support for LDO_510 and FTSMPS3 regulators, all belonging to register
layout HFSMPS. This is done in preparation for adding support for the
PM6125 PMIC.

For FTSMPS3 and LDO_510, only IDLE and NORMAL modes are selectable (no
FAST).

The inspiration for the magic constants was taken from [1]

[1]: https://source.codeaurora.org/quic/la/kernel/msm-5.4/commit/?h=kernel.lnx.5.4.r1-rel&id=d1220daeffaa440ffff0a8c47322eb0033bf54f5

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 38 ++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 04e9845a9300..0763a5b7a2ce 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -99,6 +99,8 @@ enum spmi_regulator_logical_type {
 	SPMI_REGULATOR_LOGICAL_TYPE_ULT_LDO,
 	SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS426,
 	SPMI_REGULATOR_LOGICAL_TYPE_HFS430,
+	SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS3,
+	SPMI_REGULATOR_LOGICAL_TYPE_LDO_510,
 	SPMI_REGULATOR_LOGICAL_TYPE_HFSMPS,
 };
 
@@ -168,6 +170,16 @@ enum spmi_regulator_subtype {
 	SPMI_REGULATOR_SUBTYPE_HT_P150		= 0x35,
 	SPMI_REGULATOR_SUBTYPE_HT_P600		= 0x3d,
 	SPMI_REGULATOR_SUBTYPE_HFSMPS_510	= 0x0a,
+	SPMI_REGULATOR_SUBTYPE_FTSMPS_510	= 0x0b,
+	SPMI_REGULATOR_SUBTYPE_LV_P150_510	= 0x71,
+	SPMI_REGULATOR_SUBTYPE_LV_P300_510	= 0x72,
+	SPMI_REGULATOR_SUBTYPE_LV_P600_510	= 0x73,
+	SPMI_REGULATOR_SUBTYPE_N300_510		= 0x6a,
+	SPMI_REGULATOR_SUBTYPE_N600_510		= 0x6b,
+	SPMI_REGULATOR_SUBTYPE_N1200_510	= 0x6c,
+	SPMI_REGULATOR_SUBTYPE_MV_P50_510	= 0x7a,
+	SPMI_REGULATOR_SUBTYPE_MV_P150_510	= 0x7b,
+	SPMI_REGULATOR_SUBTYPE_MV_P600_510	= 0x7d,
 };
 
 enum spmi_common_regulator_registers {
@@ -576,6 +588,14 @@ static struct spmi_voltage_range ht_p600_ranges[] = {
 	SPMI_VOLTAGE_RANGE(0, 1704000, 1704000, 1896000, 1896000, 8000),
 };
 
+static struct spmi_voltage_range nldo_510_ranges[] = {
+	SPMI_VOLTAGE_RANGE(0, 320000, 320000, 1304000, 1304000, 8000),
+};
+
+static struct spmi_voltage_range ftsmps510_ranges[] = {
+	SPMI_VOLTAGE_RANGE(0, 300000, 300000, 1372000, 1372000, 4000),
+};
+
 static DEFINE_SPMI_SET_POINTS(pldo);
 static DEFINE_SPMI_SET_POINTS(nldo1);
 static DEFINE_SPMI_SET_POINTS(nldo2);
@@ -598,6 +618,8 @@ static DEFINE_SPMI_SET_POINTS(ht_nldo);
 static DEFINE_SPMI_SET_POINTS(hfs430);
 static DEFINE_SPMI_SET_POINTS(ht_p150);
 static DEFINE_SPMI_SET_POINTS(ht_p600);
+static DEFINE_SPMI_SET_POINTS(nldo_510);
+static DEFINE_SPMI_SET_POINTS(ftsmps510);
 
 static inline int spmi_vreg_read(struct spmi_regulator *vreg, u16 addr, u8 *buf,
 				 int len)
@@ -1162,7 +1184,10 @@ spmi_regulator_hfsmps_set_mode(struct regulator_dev *rdev, unsigned int mode)
 		val = SPMI_HFSMPS_MODE_AUTO_MASK;
 		break;
 	case REGULATOR_MODE_IDLE:
-		val = SPMI_HFSMPS_MODE_LPM_MASK;
+		val = vreg->logical_type ==
+				SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS3 ?
+			SPMI_HFSMPS_MODE_RETENTION_MASK :
+			SPMI_HFSMPS_MODE_LPM_MASK;
 		break;
 	default:
 		return -EINVAL;
@@ -1637,6 +1662,16 @@ static const struct spmi_regulator_mapping supported_regulators[] = {
 	SPMI_VREG(ULT_LDO, P300,     0, INF, ULT_LDO, ult_ldo, ult_pldo, 10000),
 	SPMI_VREG(ULT_LDO, P150,     0, INF, ULT_LDO, ult_ldo, ult_pldo, 10000),
 	SPMI_VREG(ULT_LDO, P50,     0, INF, ULT_LDO, ult_ldo, ult_pldo, 5000),
+	SPMI_VREG(LDO, LV_P150_510, 0, INF, LDO_510, hfsmps, ht_lvpldo, 10000),
+	SPMI_VREG(LDO, LV_P300_510, 0, INF, LDO_510, hfsmps, ht_lvpldo, 10000),
+	SPMI_VREG(LDO, LV_P600_510, 0, INF, LDO_510, hfsmps, ht_lvpldo, 10000),
+	SPMI_VREG(LDO, MV_P50_510,  0, INF, LDO_510, hfsmps, pldo660, 10000),
+	SPMI_VREG(LDO, MV_P150_510, 0, INF, LDO_510, hfsmps, pldo660, 10000),
+	SPMI_VREG(LDO, MV_P600_510, 0, INF, LDO_510, hfsmps, pldo660, 10000),
+	SPMI_VREG(LDO, N300_510,    0, INF, LDO_510, hfsmps, nldo_510, 10000),
+	SPMI_VREG(LDO, N600_510,    0, INF, LDO_510, hfsmps, nldo_510, 10000),
+	SPMI_VREG(LDO, N1200_510,   0, INF, LDO_510, hfsmps, nldo_510, 10000),
+	SPMI_VREG(FTS, FTSMPS_510,  0, INF, FTSMPS3, hfsmps, ftsmps510, 100000),
 };
 
 static void spmi_calculate_num_voltages(struct spmi_voltage_set_points *points)
@@ -1955,6 +1990,7 @@ static int spmi_regulator_of_parse(struct device_node *node,
 			return ret;
 		break;
 	case SPMI_REGULATOR_LOGICAL_TYPE_HFSMPS:
+	case SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS3:
 		ret = spmi_regulator_init_slew_rate_hfsmps(vreg);
 		if (ret)
 			return ret;
-- 
2.37.1

