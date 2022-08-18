Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E799B59906A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbiHRWSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346149AbiHRWS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:18:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A82D1E1;
        Thu, 18 Aug 2022 15:18:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i14so5715647ejg.6;
        Thu, 18 Aug 2022 15:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zgCw3mKNf4aTWBiNXJ2c1smABguVN3Ohi5HNGBK9C8Y=;
        b=glfrKr6hJcuMhL5NoNE/J8v5XoYm0swZWQKzvokqRhlfQ91oGUUD/P/Ti+CHCeb523
         iaEBFn+1DWlNyy5cLfyXPm+dPL1w/OD5lpyafSzZSpUciZVvUUdttERzGCY9qQYLauzF
         XEVCcjIhweq1tXUev8J6lTUTyDwEAsQ0yCeFN2Safwq88baUHUlMerubjhnjb5v4vyBs
         /5O///u0JdNVSKrzITmMNhJkg2PxTRg30rOcnla5ySrY4aPfZqzk9sQNJYEJv8zp8ozR
         Tw7gLzRNvQbAaagCIihrKOB9qi8INCJflpMv7L7xmd5TJobEKcXEzmDOVW2dt3+qvaF9
         VP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zgCw3mKNf4aTWBiNXJ2c1smABguVN3Ohi5HNGBK9C8Y=;
        b=33kpBS8JfFllnSYmfovwCJc5+UI8w1XR620AdvXjKVrGLcSInUiwj5G99L6ODTC15g
         QuJrCGS+wq+uGcZFOrH5fFifFMGraZZ9JqqNmySpSw6+6T0xi5YZV/Tl3dHo6JSBIIC2
         KwGVGWUd55CR0vnPUH1JGXXXyEp6ak7cKdkQr118mvY+i/cd0gWa1VBEywYkgtg5H9yA
         cxZ2XDAG21wT0hOI5e2rIdbuQ+ZsHAC3qE3lQOTX8fcwI18P9JyGpyjjScmkdXkVAnuc
         tfccsuOzBXl8WUg0y1GqCQiTXPaNXiSbD0HnGpdpr8lAh0aEEdihY5Ml0Sg6QSdJvo1e
         I8eQ==
X-Gm-Message-State: ACgBeo0qRy+IY1y3LZ3QBZUqopp+i7Piha8xwdX4mrxI822oq48NHCR5
        UZf+DubejKYaKIbeIsMItjkU1+jMnxE=
X-Google-Smtp-Source: AA6agR5p978Qsjc8SGa18Fvi4tsfZqp5hptsT0eVUbtV812S+4dOCZSEE002GYtT/9kquLLVGI2BRw==
X-Received: by 2002:a17:907:8a1a:b0:731:6475:68f7 with SMTP id sc26-20020a1709078a1a00b00731647568f7mr3000313ejc.359.1660861102953;
        Thu, 18 Aug 2022 15:18:22 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id t19-20020a1709060c5300b00731747c3107sm1378315ejf.73.2022.08.18.15.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:18:22 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v8 5/5] arm64: dts: qcom: ipq8074-hk01: add VQMMC supply
Date:   Fri, 19 Aug 2022 00:18:15 +0200
Message-Id: <20220818221815.346233-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818221815.346233-1-robimarko@gmail.com>
References: <20220818221815.346233-1-robimarko@gmail.com>
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

Since now we have control over the PMP8074 PMIC providing various system
voltages including L11 which provides the SDIO/eMMC I/O voltage set it as
the SDHCI VQMMC supply.

This allows SDHCI controller to switch to 1.8V I/O mode and support high
speed modes like HS200 and HS400.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
index 81dc3a0bcd7d..b788e1605476 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
@@ -3,6 +3,7 @@
 /* Copyright (c) 2017, The Linux Foundation. All rights reserved.
  */
 #include "ipq8074.dtsi"
+#include "pmp8074.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ8074-HK01";
@@ -84,6 +85,7 @@ nand@0 {
 
 &sdhc_1 {
 	status = "okay";
+	vqmmc-supply = <&l11>;
 };
 
 &qusb_phy_0 {
-- 
2.37.2

