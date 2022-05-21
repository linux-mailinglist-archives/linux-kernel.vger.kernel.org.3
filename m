Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0548952FE44
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349280AbiEUQqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355447AbiEUQqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:46:05 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC940DF9A
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:04 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u7so11950657ljd.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1CNzdj/syMEdOL6sFg1I8zFQMw1U0E7UM4zdtExgB4s=;
        b=elXP+yONQhW2Vfrcz/thcfYRN2plOGYWsXeGKE62nLVqmPxaZumOyPkkUj4VpCUW9f
         SXJoDd1fx+iT6tilmZL1w8JPOM/wwTwfbawTCJasdIfpfcWSWtX/K6jlLVwbDbWBGTW5
         h3167hKlBsNz+8d0yFVSKZY4VAg2tnPbJZS0pif4HShGmECwmVSU6XEnMXlTXXgogvxj
         CqKiX1Bpqt5eerYIX9/AUYLe4QE8LUMn+Dd7P+wecWC8IBvtvYLtXAhlz7GHblsqJLrD
         xcuAKFYYAQUItevQtXHdxxJ/K2UZHFFkNnzxLh6Ih2zKcvDwFXBJOZSWI8D7RsYwDEL1
         VIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1CNzdj/syMEdOL6sFg1I8zFQMw1U0E7UM4zdtExgB4s=;
        b=Wf+DmZAMSPzZfDiLKJTOqkL2ar5iwAkskzXE+CNu+oODP+/IhYU1CesyslMQAR4vf7
         aA7w/4SCBF1tQ+gtPVyezGquYJuk7ZFfRy1vFlXTTiPOPY1TpRpKgymwIJB+apHN/8zj
         DcvCrlyeitdIithG82VrFJuXFCJvTAe/zrqsXpmcByffiRvz+QGz6zhlmzKaTwKZ8LZd
         2RWkAXvwn5os7jXvXH9MddcDWB26sG8L/05x2NkNDAZNuyrspFvFYsZsZf2rFRzeTGGU
         W4ahFZQqX8EeV/yFtPBVwDZjOoXiq2/0zikvgyFLWiUJo9acD7AfWQ3bkjwd+S0k88NJ
         r2Hw==
X-Gm-Message-State: AOAM530cHQyq+fWboQ25f3pcVBJv9NmCFjh2/Ko2eXgMbrOEUIJPbcDo
        Iy96DXJoUGcs1RUB4+Wf49k+pA==
X-Google-Smtp-Source: ABdhPJzD2T3UaTWLdGznbdjSeezNWL3JILTrWVBx+t3eTuKGIGlzgSM/MCD+tz6R62EhUUc2kze+Lg==
X-Received: by 2002:a2e:a90d:0:b0:250:8444:2681 with SMTP id j13-20020a2ea90d000000b0025084442681mr8694441ljq.342.1653151564347;
        Sat, 21 May 2022 09:46:04 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f26-20020a19ae1a000000b0047255d211cesm1114282lfc.253.2022.05.21.09.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 09:46:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/12] ARM: dts: qcom: ipq4019: fix Micron SPI NOR compatible
Date:   Sat, 21 May 2022 18:45:48 +0200
Message-Id: <20220521164550.91115-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
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

The proper compatible for Micron n25q128a11 SPI NOR flash should include
vendor-prefix and use jedec,spi-nor fallback.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi   | 2 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
index faeaa6bf0def..44a9597d8bfd 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
@@ -93,7 +93,7 @@ flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0>;
-				compatible = "n25q128a11";
+				compatible = "micron,n25q128a11", "jedec,spi-nor";
 				spi-max-frequency = <24000000>;
 			};
 		};
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
index d596dd1180ae..c7a6e77da272 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
@@ -56,7 +56,7 @@ flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0>;
-				compatible = "n25q128a11";
+				compatible = "micron,n25q128a11", "jedec,spi-nor";
 				spi-max-frequency = <24000000>;
 			};
 		};
-- 
2.32.0

