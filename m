Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC9A566F91
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiGENlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiGENlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:41:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C302AC64
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:03:10 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u14so14449701ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 06:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PVF1kQELJGnzeWwHQpr93Ja3CpfIbtJSBiq/WRe2Aqw=;
        b=IsE2R2K7pFxOzFhzYXiZ2d6hcHBUMDwm5H0XblmvYebWGQc+P4TXFmO+hEhLQ10N8Z
         aFgq4iThu7N5I9X6F8r73UQw1JZYWElnvR1livfY9kyaWb56ewjnIBN4Ed2NzdcJYcaK
         sPs/55QkAj4yBm5qZgLnywgsHH/7j6usARuGMYG2eozQNZ7DSStNac5M/MUeXNWTwrv8
         /o9u2MN7UjqOTK5hokkOTCDOcsvyQyXG96LJlTcn+bZ2fZpCxTSe1a6jDK7duQl+/9o7
         oTrvyj73UrGArE5v4J6fHf8r1bb5ZR9sRfByLOFSEv9jCd07S8HunzA6FrFmiSw2o5rk
         AxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PVF1kQELJGnzeWwHQpr93Ja3CpfIbtJSBiq/WRe2Aqw=;
        b=qONv/HSOPmkrs2geM8s9EMSeD+hrFVQ1tfea32btvoBd3mH2o77hpbdQNWo0F4k1Zt
         uwQkA1HCY36O0UxS2BiTA3/OAvtZEBtq4b848R6M2EtJOHHl2sVa1cncwOCO7DUxP8jm
         v3fxyJpxmTsC+J+lPVBjT8R30+m8kRxNmdHh4O+NvGokvbMs0d4ZyfiM39ZPdbOEVhEN
         mKh9HnOp2LyXcokmHfX1orrhCqoZmxTAU+lG3GIlme1aNZ+2aS2JAIGvMjB7LGTSj+Kt
         uLqLObnhWbC3T6CDeiK/VifoE0w0ccVPTuV3ZMctUu8ULZFk4Fh3P6QA9N51vYVy9OvH
         tcCQ==
X-Gm-Message-State: AJIora8jBsfTN/hsrOLAWjOZTedIesAzDLD+9cr43UMjKguDkfW3ctGD
        Ojfg2GIgxr2FI/GQfiDsQN7bZg==
X-Google-Smtp-Source: AGRyM1v3ZHOg/Sr69DG/sQb32TgYKDnDwYDYrKmzsBfUajC+Gvs79KoMCL0ND712yBNWq1x+YN++kw==
X-Received: by 2002:a2e:b048:0:b0:25a:6dc9:dcd0 with SMTP id d8-20020a2eb048000000b0025a6dc9dcd0mr19951258ljl.402.1657026188757;
        Tue, 05 Jul 2022 06:03:08 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s14-20020a19770e000000b0047f68d77008sm5688086lfc.178.2022.07.05.06.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:03:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v6 3/3] arm64: dts: qcom: msm8992-xiaomi-libra: split qcom,msm-id into tuples
Date:   Tue,  5 Jul 2022 15:03:00 +0200
Message-Id: <20220705130300.100882-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220705130300.100882-1-krzysztof.kozlowski@linaro.org>
References: <20220705130300.100882-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qcom,msm-id is an uint32 matrix, so a list of tuples.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
index 7748b745a5df..15467b697e94 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
@@ -17,7 +17,7 @@ / {
 	chassis-type = "handset";
 
 	/* required for bootloader to select correct board */
-	qcom,msm-id = <251 0 252 0>;
+	qcom,msm-id = <251 0>, <252 0>;
 	qcom,pmic-id = <65545 65546 0 0>;
 	qcom,board-id = <12 0>;
 
-- 
2.34.1

