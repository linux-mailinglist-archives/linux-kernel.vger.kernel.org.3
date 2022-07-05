Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95513566F8B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiGENlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiGENlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:41:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33648330
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:03:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a5so2774392wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C/ZlmWFz9i3Qo4vprUkEd6EoMWUb1pId92ubM9ME5fE=;
        b=zTpHwQDyxrn8OrzKJxFio/2vd2w2+e6JXHyGWMH2pBNSkJKki8Sv6YQHQSG2PW+vfU
         e2GKRmxI0Ja4ld4bhC4Xj2UHJnxZhtVPA6U27zqwwJWnK1hTmmUE/kVqJH9Ln1lqiJbN
         BkA/ZhEsAa6qkgTGHYeq/JskauEaflEdwKqemkPpc4zS/769UZ10sGg63hry29WL2tN3
         wnX1uzpAFs/emzxrZWc2EGNzcaNl7j3exBNBZ06g7N0sVqQOxQve/hhpCRCApoalvRqW
         AGrbEf0lUkoVMY+o5jif+EgW+6EWsknhL7Zo+0K8TMJtV8AIg5MFRfKX0B4+Pbjnegv+
         EY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C/ZlmWFz9i3Qo4vprUkEd6EoMWUb1pId92ubM9ME5fE=;
        b=qQAXJHCfUG/YwyQQO+d2crBJD5Zb/EYTTQc2rmlnYalSA1RUvXsi/t8sBYBX9lMoK8
         gZ6eQ+0XxOFkb8hi0ellWc0FaSnwf/Dyq2Ps8ncYXTMIICpLspZMX8kabzeoDJZMH3GS
         vQfXxBmdBITqRvAKBDDgEfjVnP1Ofzw9VknckqCi+HNOuCk/fzkEBmBmRpLLV/sDDuli
         64vwK6HBtGjHjwGTdxGZ4N4F6SfQhs7TxCBarb6w1Hq1Ku8FXvCPV1kJwR7AWAMT1Eiz
         cnRcpvCHMORWxKTj+t2LfelXc5AdMMGzoybHJhlXjAqVDi0MlMZ4wQoi95BkSO6/bjC8
         WVnw==
X-Gm-Message-State: AJIora//cr67o/lJVPHTaNQOpPkyWYJc+RuX5kebr/V9C37Gm4CDifjj
        dZtvTARKlUZZ/Qvp9X25iriLVQQ+ntH0dQ==
X-Google-Smtp-Source: AGRyM1uuTNusUDkOP9qI8cXC9xgBFXSqRuu/NZTlX0WRK4fhq1GkQCV9Y6hfwW4uSQ7WzAoU4QOHqQ==
X-Received: by 2002:a05:651c:4d1:b0:25b:b6ab:5b56 with SMTP id e17-20020a05651c04d100b0025bb6ab5b56mr20904110lji.84.1657026187691;
        Tue, 05 Jul 2022 06:03:07 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s14-20020a19770e000000b0047f68d77008sm5688086lfc.178.2022.07.05.06.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:03:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 2/3] soc: qcom: socinfo: create soc_id table from bindings
Date:   Tue,  5 Jul 2022 15:02:59 +0200
Message-Id: <20220705130300.100882-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220705130300.100882-1-krzysztof.kozlowski@linaro.org>
References: <20220705130300.100882-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SoC ID values are encoded in few places: DTS files,
Devicetree bindings (both used by some of Qualcomm bootloaders or tools)
and in soc_id table of socinfo driver.  Do not duplicate the actual
values in the last one but use the constants from the bindings.

Tested by comparing output object file (exactly the same).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/socinfo.c | 259 +++++++++++++++++++------------------
 1 file changed, 133 insertions(+), 126 deletions(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index cee579a267a6..d515d3a97f0e 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -12,11 +12,14 @@
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
 #include <linux/string.h>
+#include <linux/stringify.h>
 #include <linux/sys_soc.h>
 #include <linux/types.h>
 
 #include <asm/unaligned.h>
 
+#include <dt-bindings/arm/qcom,ids.h>
+
 /*
  * SoC version type with major number in the upper 16 bits and minor
  * number in the lower 16 bits.
@@ -25,6 +28,10 @@
 #define SOCINFO_MINOR(ver) ((ver) & 0xffff)
 #define SOCINFO_VERSION(maj, min)  ((((maj) & 0xffff) << 16)|((min) & 0xffff))
 
+/* Helper macros to create soc_id table */
+#define qcom_board_id(id) QCOM_ID_ ## id, __stringify(id)
+#define qcom_board_id2(id, name) QCOM_ID_ ## id, (name)
+
 #define SMEM_SOCINFO_BUILD_ID_LENGTH           32
 #define SMEM_SOCINFO_CHIP_ID_LENGTH            32
 
@@ -206,132 +213,132 @@ struct soc_id {
 };
 
 static const struct soc_id soc_id[] = {
-	{ 87, "MSM8960" },
-	{ 109, "APQ8064" },
-	{ 122, "MSM8660A" },
-	{ 123, "MSM8260A" },
-	{ 124, "APQ8060A" },
-	{ 126, "MSM8974" },
-	{ 130, "MPQ8064" },
-	{ 138, "MSM8960AB" },
-	{ 139, "APQ8060AB" },
-	{ 140, "MSM8260AB" },
-	{ 141, "MSM8660AB" },
-	{ 145, "MSM8626" },
-	{ 147, "MSM8610" },
-	{ 153, "APQ8064AB" },
-	{ 158, "MSM8226" },
-	{ 159, "MSM8526" },
-	{ 161, "MSM8110" },
-	{ 162, "MSM8210" },
-	{ 163, "MSM8810" },
-	{ 164, "MSM8212" },
-	{ 165, "MSM8612" },
-	{ 166, "MSM8112" },
-	{ 168, "MSM8225Q" },
-	{ 169, "MSM8625Q" },
-	{ 170, "MSM8125Q" },
-	{ 172, "APQ8064AA" },
-	{ 178, "APQ8084" },
-	{ 184, "APQ8074" },
-	{ 185, "MSM8274" },
-	{ 186, "MSM8674" },
-	{ 194, "MSM8974PRO-AC" },
-	{ 198, "MSM8126" },
-	{ 199, "APQ8026" },
-	{ 200, "MSM8926" },
-	{ 205, "MSM8326" },
-	{ 206, "MSM8916" },
-	{ 207, "MSM8994" },
-	{ 208, "APQ8074PRO-AA" },
-	{ 209, "APQ8074PRO-AB" },
-	{ 210, "APQ8074PRO-AC" },
-	{ 211, "MSM8274PRO-AA" },
-	{ 212, "MSM8274PRO-AB" },
-	{ 213, "MSM8274PRO-AC" },
-	{ 214, "MSM8674PRO-AA" },
-	{ 215, "MSM8674PRO-AB" },
-	{ 216, "MSM8674PRO-AC" },
-	{ 217, "MSM8974PRO-AA" },
-	{ 218, "MSM8974PRO-AB" },
-	{ 219, "APQ8028" },
-	{ 220, "MSM8128" },
-	{ 221, "MSM8228" },
-	{ 222, "MSM8528" },
-	{ 223, "MSM8628" },
-	{ 224, "MSM8928" },
-	{ 225, "MSM8510" },
-	{ 226, "MSM8512" },
-	{ 233, "MSM8936" },
-	{ 239, "MSM8939" },
-	{ 240, "APQ8036" },
-	{ 241, "APQ8039" },
-	{ 246, "MSM8996" },
-	{ 247, "APQ8016" },
-	{ 248, "MSM8216" },
-	{ 249, "MSM8116" },
-	{ 250, "MSM8616" },
-	{ 251, "MSM8992" },
-	{ 253, "APQ8094" },
-	{ 290, "MDM9607" },
-	{ 291, "APQ8096" },
-	{ 292, "MSM8998" },
-	{ 293, "MSM8953" },
-	{ 296, "MDM8207" },
-	{ 297, "MDM9207" },
-	{ 298, "MDM9307" },
-	{ 299, "MDM9628" },
-	{ 304, "APQ8053" },
-	{ 305, "MSM8996SG" },
-	{ 310, "MSM8996AU" },
-	{ 311, "APQ8096AU" },
-	{ 312, "APQ8096SG" },
-	{ 317, "SDM660" },
-	{ 318, "SDM630" },
-	{ 319, "APQ8098" },
-	{ 321, "SDM845" },
-	{ 322, "MDM9206" },
-	{ 323, "IPQ8074" },
-	{ 324, "SDA660" },
-	{ 325, "SDM658" },
-	{ 326, "SDA658" },
-	{ 327, "SDA630" },
-	{ 338, "SDM450" },
-	{ 341, "SDA845" },
-	{ 342, "IPQ8072" },
-	{ 343, "IPQ8076" },
-	{ 344, "IPQ8078" },
-	{ 345, "SDM636" },
-	{ 346, "SDA636" },
-	{ 349, "SDM632" },
-	{ 350, "SDA632" },
-	{ 351, "SDA450" },
-	{ 356, "SM8250" },
-	{ 375, "IPQ8070" },
-	{ 376, "IPQ8071" },
-	{ 389, "IPQ8072A" },
-	{ 390, "IPQ8074A" },
-	{ 391, "IPQ8076A" },
-	{ 392, "IPQ8078A" },
-	{ 394, "SM6125" },
-	{ 395, "IPQ8070A" },
-	{ 396, "IPQ8071A" },
-	{ 402, "IPQ6018" },
-	{ 403, "IPQ6028" },
-	{ 421, "IPQ6000" },
-	{ 422, "IPQ6010" },
-	{ 425, "SC7180" },
-	{ 434, "SM6350" },
-	{ 439, "SM8350" },
-	{ 449, "SC8280XP" },
-	{ 453, "IPQ6005" },
-	{ 455, "QRB5165" },
-	{ 457, "SM8450" },
-	{ 459, "SM7225" },
-	{ 460, "SA8540P" },
-	{ 480, "SM8450" },
-	{ 482, "SM8450" },
-	{ 487, "SC7280" },
+	{ qcom_board_id(MSM8960) },
+	{ qcom_board_id(APQ8064) },
+	{ qcom_board_id(MSM8660A) },
+	{ qcom_board_id(MSM8260A) },
+	{ qcom_board_id(APQ8060A) },
+	{ qcom_board_id(MSM8974) },
+	{ qcom_board_id(MPQ8064) },
+	{ qcom_board_id(MSM8960AB) },
+	{ qcom_board_id(APQ8060AB) },
+	{ qcom_board_id(MSM8260AB) },
+	{ qcom_board_id(MSM8660AB) },
+	{ qcom_board_id(MSM8626) },
+	{ qcom_board_id(MSM8610) },
+	{ qcom_board_id(APQ8064AB) },
+	{ qcom_board_id(MSM8226) },
+	{ qcom_board_id(MSM8526) },
+	{ qcom_board_id(MSM8110) },
+	{ qcom_board_id(MSM8210) },
+	{ qcom_board_id(MSM8810) },
+	{ qcom_board_id(MSM8212) },
+	{ qcom_board_id(MSM8612) },
+	{ qcom_board_id(MSM8112) },
+	{ qcom_board_id(MSM8225Q) },
+	{ qcom_board_id(MSM8625Q) },
+	{ qcom_board_id(MSM8125Q) },
+	{ qcom_board_id(APQ8064AA) },
+	{ qcom_board_id(APQ8084) },
+	{ qcom_board_id(APQ8074) },
+	{ qcom_board_id(MSM8274) },
+	{ qcom_board_id(MSM8674) },
+	{ qcom_board_id2(MSM8974PRO_AC, "MSM8974PRO-AC") },
+	{ qcom_board_id(MSM8126) },
+	{ qcom_board_id(APQ8026) },
+	{ qcom_board_id(MSM8926) },
+	{ qcom_board_id(MSM8326) },
+	{ qcom_board_id(MSM8916) },
+	{ qcom_board_id(MSM8994) },
+	{ qcom_board_id2(APQ8074PRO_AA, "APQ8074PRO-AA") },
+	{ qcom_board_id2(APQ8074PRO_AB, "APQ8074PRO-AB") },
+	{ qcom_board_id2(APQ8074PRO_AC, "APQ8074PRO-AC") },
+	{ qcom_board_id2(MSM8274PRO_AA, "MSM8274PRO-AA") },
+	{ qcom_board_id2(MSM8274PRO_AB, "MSM8274PRO-AB") },
+	{ qcom_board_id2(MSM8274PRO_AC, "MSM8274PRO-AC") },
+	{ qcom_board_id2(MSM8674PRO_AA, "MSM8674PRO-AA") },
+	{ qcom_board_id2(MSM8674PRO_AB, "MSM8674PRO-AB") },
+	{ qcom_board_id2(MSM8674PRO_AC, "MSM8674PRO-AC") },
+	{ qcom_board_id2(MSM8974PRO_AA, "MSM8974PRO-AA") },
+	{ qcom_board_id2(MSM8974PRO_AB, "MSM8974PRO-AB") },
+	{ qcom_board_id(APQ8028) },
+	{ qcom_board_id(MSM8128) },
+	{ qcom_board_id(MSM8228) },
+	{ qcom_board_id(MSM8528) },
+	{ qcom_board_id(MSM8628) },
+	{ qcom_board_id(MSM8928) },
+	{ qcom_board_id(MSM8510) },
+	{ qcom_board_id(MSM8512) },
+	{ qcom_board_id(MSM8936) },
+	{ qcom_board_id(MSM8939) },
+	{ qcom_board_id(APQ8036) },
+	{ qcom_board_id(APQ8039) },
+	{ qcom_board_id(MSM8996) },
+	{ qcom_board_id(APQ8016) },
+	{ qcom_board_id(MSM8216) },
+	{ qcom_board_id(MSM8116) },
+	{ qcom_board_id(MSM8616) },
+	{ qcom_board_id(MSM8992) },
+	{ qcom_board_id(APQ8094) },
+	{ qcom_board_id(MDM9607) },
+	{ qcom_board_id(APQ8096) },
+	{ qcom_board_id(MSM8998) },
+	{ qcom_board_id(MSM8953) },
+	{ qcom_board_id(MDM8207) },
+	{ qcom_board_id(MDM9207) },
+	{ qcom_board_id(MDM9307) },
+	{ qcom_board_id(MDM9628) },
+	{ qcom_board_id(APQ8053) },
+	{ qcom_board_id(MSM8996SG) },
+	{ qcom_board_id(MSM8996AU) },
+	{ qcom_board_id(APQ8096AU) },
+	{ qcom_board_id(APQ8096SG) },
+	{ qcom_board_id(SDM660) },
+	{ qcom_board_id(SDM630) },
+	{ qcom_board_id(APQ8098) },
+	{ qcom_board_id(SDM845) },
+	{ qcom_board_id(MDM9206) },
+	{ qcom_board_id(IPQ8074) },
+	{ qcom_board_id(SDA660) },
+	{ qcom_board_id(SDM658) },
+	{ qcom_board_id(SDA658) },
+	{ qcom_board_id(SDA630) },
+	{ qcom_board_id(SDM450) },
+	{ qcom_board_id(SDA845) },
+	{ qcom_board_id(IPQ8072) },
+	{ qcom_board_id(IPQ8076) },
+	{ qcom_board_id(IPQ8078) },
+	{ qcom_board_id(SDM636) },
+	{ qcom_board_id(SDA636) },
+	{ qcom_board_id(SDM632) },
+	{ qcom_board_id(SDA632) },
+	{ qcom_board_id(SDA450) },
+	{ qcom_board_id(SM8250) },
+	{ qcom_board_id(IPQ8070) },
+	{ qcom_board_id(IPQ8071) },
+	{ qcom_board_id(IPQ8072A) },
+	{ qcom_board_id(IPQ8074A) },
+	{ qcom_board_id(IPQ8076A) },
+	{ qcom_board_id(IPQ8078A) },
+	{ qcom_board_id(SM6125) },
+	{ qcom_board_id(IPQ8070A) },
+	{ qcom_board_id(IPQ8071A) },
+	{ qcom_board_id(IPQ6018) },
+	{ qcom_board_id(IPQ6028) },
+	{ qcom_board_id(IPQ6000) },
+	{ qcom_board_id(IPQ6010) },
+	{ qcom_board_id(SC7180) },
+	{ qcom_board_id(SM6350) },
+	{ qcom_board_id(SM8350) },
+	{ qcom_board_id(SC8280XP) },
+	{ qcom_board_id(IPQ6005) },
+	{ qcom_board_id(QRB5165) },
+	{ qcom_board_id(SM8450) },
+	{ qcom_board_id(SM7225) },
+	{ qcom_board_id(SA8540P) },
+	{ qcom_board_id2(SM8450_2, "SM8450") },
+	{ qcom_board_id2(SM8450_3, "SM8450") },
+	{ qcom_board_id(SC7280) },
 };
 
 static const char *socinfo_machine(struct device *dev, unsigned int id)
-- 
2.34.1

