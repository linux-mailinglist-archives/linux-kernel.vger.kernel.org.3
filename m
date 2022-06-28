Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FE255E939
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346360AbiF1OYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345863AbiF1OY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:24:27 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BF22DA8D;
        Tue, 28 Jun 2022 07:24:25 -0700 (PDT)
Received: from localhost.localdomain (abxi223.neoplus.adsl.tpnet.pl [83.9.2.223])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 91FF63F6B1;
        Tue, 28 Jun 2022 16:24:23 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] thermal: qcom: tsens-v1: Use GENMASK macro for bitmasks
Date:   Tue, 28 Jun 2022 16:23:58 +0200
Message-Id: <20220628142359.93100-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628142359.93100-1-konrad.dybcio@somainline.org>
References: <20220628142359.93100-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the masks to use GENMASK. Tested by objdumping and making sure
the output is identical pre- and post this patch.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
Changes since v3:
* Add this patch

 drivers/thermal/qcom/tsens-v1.c | 107 ++++++++++++++++----------------
 1 file changed, 54 insertions(+), 53 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 573e261ccca7..d6f0dec4bfa1 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2019, Linaro Limited
  */
 
+#include <linux/bits.h>
 #include <linux/bitops.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
@@ -22,34 +23,34 @@
 #define TM_HIGH_LOW_Sn_INT_THRESHOLD_OFF	0x0090
 
 /* eeprom layout data for msm8956/76 (v1) */
-#define MSM8976_BASE0_MASK	0xff
-#define MSM8976_BASE1_MASK	0xff
+#define MSM8976_BASE0_MASK	GENMASK(7, 0)
+#define MSM8976_BASE1_MASK	GENMASK(7, 0)
 #define MSM8976_BASE1_SHIFT	8
 
-#define MSM8976_S0_P1_MASK	0x3f00
-#define MSM8976_S1_P1_MASK	0x3f00000
-#define MSM8976_S2_P1_MASK	0x3f
-#define MSM8976_S3_P1_MASK	0x3f000
-#define MSM8976_S4_P1_MASK	0x3f00
-#define MSM8976_S5_P1_MASK	0x3f00000
-#define MSM8976_S6_P1_MASK	0x3f
-#define MSM8976_S7_P1_MASK	0x3f000
-#define MSM8976_S8_P1_MASK	0x1f8
-#define MSM8976_S9_P1_MASK	0x1f8000
-#define MSM8976_S10_P1_MASK	0xf8000000
-#define MSM8976_S10_P1_MASK_1	0x1
-
-#define MSM8976_S0_P2_MASK	0xfc000
-#define MSM8976_S1_P2_MASK	0xfc000000
-#define MSM8976_S2_P2_MASK	0xfc0
-#define MSM8976_S3_P2_MASK	0xfc0000
-#define MSM8976_S4_P2_MASK	0xfc000
-#define MSM8976_S5_P2_MASK	0xfc000000
-#define MSM8976_S6_P2_MASK	0xfc0
-#define MSM8976_S7_P2_MASK	0xfc0000
-#define MSM8976_S8_P2_MASK	0x7e00
-#define MSM8976_S9_P2_MASK	0x7e00000
-#define MSM8976_S10_P2_MASK	0x7e
+#define MSM8976_S0_P1_MASK	GENMASK(13, 8)
+#define MSM8976_S1_P1_MASK	GENMASK(25, 20)
+#define MSM8976_S2_P1_MASK	GENMASK(5, 0)
+#define MSM8976_S3_P1_MASK	GENMASK(17, 12)
+#define MSM8976_S4_P1_MASK	GENMASK(13, 8)
+#define MSM8976_S5_P1_MASK	GENMASK(25, 20)
+#define MSM8976_S6_P1_MASK	GENMASK(5, 0)
+#define MSM8976_S7_P1_MASK	GENMASK(17, 12)
+#define MSM8976_S8_P1_MASK	GENMASK(8, 3)
+#define MSM8976_S9_P1_MASK	GENMASK(20, 15)
+#define MSM8976_S10_P1_MASK	GENMASK(31, 27)
+#define MSM8976_S10_P1_MASK_1	GENMASK(0, 0)
+
+#define MSM8976_S0_P2_MASK	GENMASK(19, 14)
+#define MSM8976_S1_P2_MASK	GENMASK(31, 26)
+#define MSM8976_S2_P2_MASK	GENMASK(11, 6)
+#define MSM8976_S3_P2_MASK	GENMASK(23, 18)
+#define MSM8976_S4_P2_MASK	GENMASK(19, 14)
+#define MSM8976_S5_P2_MASK	GENMASK(31, 26)
+#define MSM8976_S6_P2_MASK	GENMASK(11, 6)
+#define MSM8976_S7_P2_MASK	GENMASK(23, 18)
+#define MSM8976_S8_P2_MASK	GENMASK(14, 9)
+#define MSM8976_S9_P2_MASK	GENMASK(26, 21)
+#define MSM8976_S10_P2_MASK	GENMASK(6, 1)
 
 #define MSM8976_S0_P1_SHIFT	8
 #define MSM8976_S1_P1_SHIFT	20
@@ -76,7 +77,7 @@
 #define MSM8976_S9_P2_SHIFT	21
 #define MSM8976_S10_P2_SHIFT	1
 
-#define MSM8976_CAL_SEL_MASK	0x3
+#define MSM8976_CAL_SEL_MASK	GENMASK(1, 0)
 
 #define MSM8976_CAL_DEGC_PT1	30
 #define MSM8976_CAL_DEGC_PT2	120
@@ -84,34 +85,34 @@
 #define MSM8976_SLOPE_DEFAULT	3200
 
 /* eeprom layout data for qcs404/405 (v1) */
-#define BASE0_MASK	0x000007f8
-#define BASE1_MASK	0x0007f800
+#define BASE0_MASK	GENMASK(10, 3)
+#define BASE1_MASK	GENMASK(18, 11)
 #define BASE0_SHIFT	3
 #define BASE1_SHIFT	11
 
-#define S0_P1_MASK	0x0000003f
-#define S1_P1_MASK	0x0003f000
-#define S2_P1_MASK	0x3f000000
-#define S3_P1_MASK	0x000003f0
-#define S4_P1_MASK	0x003f0000
-#define S5_P1_MASK	0x0000003f
-#define S6_P1_MASK	0x0003f000
-#define S7_P1_MASK	0x3f000000
-#define S8_P1_MASK	0x000003f0
-#define S9_P1_MASK	0x003f0000
-
-#define S0_P2_MASK	0x00000fc0
-#define S1_P2_MASK	0x00fc0000
-#define S2_P2_MASK_1_0	0xc0000000
-#define S2_P2_MASK_5_2	0x0000000f
-#define S3_P2_MASK	0x0000fc00
-#define S4_P2_MASK	0x0fc00000
-#define S5_P2_MASK	0x00000fc0
-#define S6_P2_MASK	0x00fc0000
-#define S7_P2_MASK_1_0	0xc0000000
-#define S7_P2_MASK_5_2	0x0000000f
-#define S8_P2_MASK	0x0000fc00
-#define S9_P2_MASK	0x0fc00000
+#define S0_P1_MASK	GENMASK(5, 0)
+#define S1_P1_MASK	GENMASK(17, 12)
+#define S2_P1_MASK	GENMASK(29, 24)
+#define S3_P1_MASK	GENMASK(9, 4)
+#define S4_P1_MASK	GENMASK(21, 16)
+#define S5_P1_MASK	GENMASK(5, 0)
+#define S6_P1_MASK	GENMASK(17, 12)
+#define S7_P1_MASK	GENMASK(29, 24)
+#define S8_P1_MASK	GENMASK(9, 4)
+#define S9_P1_MASK	GENMASK(21, 16)
+
+#define S0_P2_MASK	GENMASK(11, 6)
+#define S1_P2_MASK	GENMASK(23, 18)
+#define S2_P2_MASK_1_0	GENMASK(31, 30)
+#define S2_P2_MASK_5_2	GENMASK(3, 0)
+#define S3_P2_MASK	GENMASK(15, 10)
+#define S4_P2_MASK	GENMASK(27, 22)
+#define S5_P2_MASK	GENMASK(11, 6)
+#define S6_P2_MASK	GENMASK(23, 18)
+#define S7_P2_MASK_1_0	GENMASK(31, 30)
+#define S7_P2_MASK_5_2	GENMASK(3, 0)
+#define S8_P2_MASK	GENMASK(15, 10)
+#define S9_P2_MASK	GENMASK(27, 22)
 
 #define S0_P1_SHIFT	0
 #define S0_P2_SHIFT	6
@@ -139,7 +140,7 @@
 #define S9_P1_SHIFT	16
 #define S9_P2_SHIFT	22
 
-#define CAL_SEL_MASK	7
+#define CAL_SEL_MASK	GENMASK(2, 0)
 #define CAL_SEL_SHIFT	0
 
 static void compute_intercept_slope_8976(struct tsens_priv *priv,
-- 
2.36.1

