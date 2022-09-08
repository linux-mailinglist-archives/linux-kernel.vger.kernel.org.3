Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369265B1683
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiIHILv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiIHIL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:11:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E82BD99F7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:10:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q7so26463498lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=2nFGr7k9DwUv67DCXwyHIh7iOrFysefykil+1Bjeu4Q=;
        b=QI00Ut4LNoGRP2si81Gt7ZrmZ0y3PMzWlkBGW8eLfinFPRGYcqg93wIXUuHqAyHcYF
         WgHxr4f3ynQQgbwnUhJ0L881yWxacwW/maGqhtsrDzwjt+uWyIPUVbAT+4tmMjnL7s4u
         zrk1gNoxF/MgA76ey8VbqWp9cIpd/i43/9Jsuf0TFzzCIX7ip8mTResbLDghCBciG1+s
         sI+2CoiI9vw66Cz52Ip49R3X/3MffkonjSx1lYBXVAHlsD+wrrXT1KiNuwpLH0Kw8k2V
         3GX1+swaIt8wPfhEMiF6HJxVAzSciqLAWDSg247gLjvGWGduLYOVHKg09BQoS4+rws4n
         uM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2nFGr7k9DwUv67DCXwyHIh7iOrFysefykil+1Bjeu4Q=;
        b=z4oo/ne753HFqtf7FzdZn8lN6FUcE0b2pk3x4ZJGRfBQs250NX6qMVTKb2ZLsY35S6
         cYPg/pNtqo9z3CwHTt55GZbRaqG83yRI535bs8bQ837ff/Z9kC4NM/GUjzhv7ksZ493Q
         JN36hzsETADbUSaHHicHf0sVSsf/Y8pKB4uUGyqp7zxuqPCIE4l8jCQaGg/yWnEIwv0/
         BCET8MEMLhEh2HZxUtW9Y9Rsz3/MNWM3DU/ifGOjX91+AwCVSTHqQYtpkVzjNzAdoTND
         /0crZ5eyfCSgElrRChdgx8OyNeONQxPeVDNV7soUeN1gHU0whX3IwEJ9E9eqPiO8ttlA
         ZSiQ==
X-Gm-Message-State: ACgBeo0v+4nLivigPwX0EVMg947G8f6TbaDF24j6N+tzzoIL4S6tj8MO
        xFCFChlxR/TVQlUFW1g6LxAuaHqr0BVzTw==
X-Google-Smtp-Source: AA6agR68K7dmUGNxIEWv3RFYEt5/3kxurlRNx9y2sEnt8wkQMSUuZy+PKbQsP/XYLWMKO/P8N24nnQ==
X-Received: by 2002:a05:6512:b1c:b0:492:8835:1e4c with SMTP id w28-20020a0565120b1c00b0049288351e4cmr2169794lfu.442.1662624654049;
        Thu, 08 Sep 2022 01:10:54 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u18-20020a05651c131200b00261e7e7b698sm3075777lja.123.2022.09.08.01.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:10:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/5] arm64: dts: qcom: pmi8994: add missing MPP compatible fallback
Date:   Thu,  8 Sep 2022 10:10:46 +0200
Message-Id: <20220908081050.29751-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Bindings require usage of generic MPP fallback in compatible:

  qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb: pmic@2: mpps@a000:compatible: ['qcom,pmi8994-mpp'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmi8994.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
index 92a139ca4482..a0af91698d49 100644
--- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
@@ -21,7 +21,7 @@ pmi8994_gpios: gpio@c000 {
 		};
 
 		pmi8994_mpps: mpps@a000 {
-			compatible = "qcom,pmi8994-mpp";
+			compatible = "qcom,pmi8994-mpp", "qcom,spmi-mpp";
 			reg = <0xa000>;
 			gpio-controller;
 			gpio-ranges = <&pmi8994_mpps 0 0 4>;
-- 
2.34.1

