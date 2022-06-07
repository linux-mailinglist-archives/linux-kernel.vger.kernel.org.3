Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4C05404EB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345814AbiFGRTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345616AbiFGRTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:19:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53911053C4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:18:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id me5so36027938ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aW5lcXdvQf4J4PO1iOWHLSignywIfaQQ2Xa3bmmGUpQ=;
        b=wDQRJ3PG91CJhs5zm7ZZd7a/QdHKY9mRqHesbxVn9UT0vYNusmbsF0akWKcQlGJTOJ
         VRKSVpdkBxUEm6ZIieOwi/l3VV24H6PMwwG8+NIHP/Qg2qPRSAC656NRD2fCjLznbzES
         vc8qG+OCYs2RLXWUqg0ljEThJdm+hAMimeGPZiWdvyqwJ/acJhdZI0aA/+ZlEyNBwxR9
         5HELynmcJ4FkinHO5c8UEe6F3/O62nRfqWLY5TQYiJl/O4to3Ezh4m+TrYRktNoVXfIV
         1UXxL5YkeGvBLSfZxXFpOZ5q074T7bdhhV/pM1NDRM4UHJyOTDFcsFzz4B7p5uIHqyHK
         M8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aW5lcXdvQf4J4PO1iOWHLSignywIfaQQ2Xa3bmmGUpQ=;
        b=QELKD/aKW9x6tBjY/B3beSaoG6YSfk3PckBAAJkaLdTvTb59TM3/9lO21T6Zo9d+6B
         1D/PtJUhHFdeRUf+zmwbx1NTodwqsPJYQeGc2LK8Y9B/YiWKRezqtjTuMrJDta0NJb9B
         ZyGdaghPtGyO1vN2pbC87GRQz31yQJxmTd0vaoy/eE1lVjiQDboJI/BWtChAE9sgvLf1
         u/jOKNH+a09QldiMydhBWoaRvUoJDEWg14Q7tUWT34Qx4Y77VbQSpmNqY616DcCcjVIs
         hQbfc635rPvq7ezC3/76X6Hf1tbTXmXjUQq6CCi49YGlTcF5NZ/K0A5tNHsZ7UdAfhtP
         GLzA==
X-Gm-Message-State: AOAM530JdRsWc5wFBkZB+5rMWakabYn7hPBdZMQ2RoPmVH26FEyl/inD
        Y08qlY2a5f8ac8Qb1mLf7qqyKw==
X-Google-Smtp-Source: ABdhPJw5smPtyirsWfiQvZQy4yAwI57DZKC9HbgtyALcAfSOgpc0PkKc2PJJ2d92fnYEGZd8FXWZMw==
X-Received: by 2002:a17:907:7204:b0:6ff:2142:36e0 with SMTP id dr4-20020a170907720400b006ff214236e0mr27102633ejc.739.1654622337372;
        Tue, 07 Jun 2022 10:18:57 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906444700b0070e238ff66fsm5876540ejp.96.2022.06.07.10.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:18:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/14] ARM: dts: qcom: sdx55: add dedicated IMEM and syscon compatibles
Date:   Tue,  7 Jun 2022 19:18:40 +0200
Message-Id: <20220607171848.535128-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
References: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
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

Add proper compatibles to the IMEM device node:
1. syscon to allow accessing memory from other devices,
2. dedicated compatible as required for syscon and simple-mfd nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 710c7f772d42..5a106708a240 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -562,7 +562,7 @@ tlmm: pinctrl@f100000 {
 		};
 
 		sram@1468f000 {
-			compatible = "simple-mfd";
+			compatible = "qcom,sdx55-imem", "syscon", "simple-mfd";
 			reg = <0x1468f000 0x1000>;
 
 			#address-cells = <1>;
-- 
2.34.1

