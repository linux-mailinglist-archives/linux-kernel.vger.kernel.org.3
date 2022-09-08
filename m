Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5985B166F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiIHIKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiIHIJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:09:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF12222B4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:09:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a8so4846452lff.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=4oSg2P4H0c3IFq2G8ED04hH6+zeZ2P6mr31MJvIHYNs=;
        b=T1l06mWLZUqJLE3OVXfdMXGOvq8MOG76Hh4QSLJCY/9N3H+Sbmagem3UodapG0lh4Q
         HJhfLIavNNO2O0UkT1elao7+jzplKHXlDNKpiM+EEwHkXTAMqimT554LVE4wT9sHQlzF
         fcD/Mi5bAdNbU8/wn/FJVi540pWG7vwZ0hvMaHFQ3Cb4PG1nVMxBIvZ5+mpAYe1bCUgP
         qXX2OZJtjByMx1QXHiLIglkzMUERu6bHXKSmueK+34IrDGXkfY8N7TQ1eZhIOU6Zm09M
         tBlNftb5nmdwMtCvaa1gNAobfEIrdxG8QAae5f9l+/tj3/ubV6qxT5l/HvFWiAPTWqr+
         s40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=4oSg2P4H0c3IFq2G8ED04hH6+zeZ2P6mr31MJvIHYNs=;
        b=gxWgOqfIBYi7oFKuzqi0lY6iO+84cyfUE1JZTcqIyrOuaawonbThzsCOzLvJPGjpnY
         gK+e1EJdnFgfiF6H9M55hq2aZ74J9oadLs5wexhampotw/wjop3hpBekUdS1Vt6/Ypra
         3xRNtjynvR7ciSNbrZnFQlsFJup39qEP48ZaC732Tbo30OSbo5BN8irKey+OaP3ouqrM
         oHD+4/TZqvShfjIe+4YJSZU8txZ9hF82b8zFlDkLvwi95dDgK67P63KKgvUzFjHRuel4
         1E/9GcMaEYmT/Ub74LS2HooJWe8OC8UD/ZJSvVp28aCXmD3LXDjZUjo2e7IVvM1g53+t
         XDDA==
X-Gm-Message-State: ACgBeo1WQ65Y/OV/mvKOQiZRQw5U+FqsMicPvNB8YRIn+EvirY+q3nEu
        FDyZrnmfQjY3NzK+FVMY6e9WYw==
X-Google-Smtp-Source: AA6agR4Rc9zA+nOn3ywxN6oUP3rxoagM0aLcIib1B0Q85tkTyM9ODv8EMKxd2TM/YJS/PeyL4+QmUw==
X-Received: by 2002:ac2:5469:0:b0:497:ed1:97c6 with SMTP id e9-20020ac25469000000b004970ed197c6mr2155024lfn.248.1662624583404;
        Thu, 08 Sep 2022 01:09:43 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e2-20020ac25462000000b004946b7593fesm2930173lfn.198.2022.09.08.01.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:09:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] ARM: dts: qcom: use generic node name "gpio" in SPMI PMIC
Date:   Thu,  8 Sep 2022 10:09:36 +0200
Message-Id: <20220908080938.29199-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

GPIO controller nodes are named by convention just "gpio", not "gpios".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-pm8941.dtsi  | 2 +-
 arch/arm/boot/dts/qcom-pma8084.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index 9cd49deb9fa7..1ac477878c67 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -59,7 +59,7 @@ smbb: charger@1000 {
 			chg_otg: otg-vbus { };
 		};
 
-		pm8941_gpios: gpios@c000 {
+		pm8941_gpios: gpio@c000 {
 			compatible = "qcom,pm8941-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
index e77602e9f95c..0da6c1a5d547 100644
--- a/arch/arm/boot/dts/qcom-pma8084.dtsi
+++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
@@ -27,7 +27,7 @@ pwrkey@800 {
 			bias-pull-up;
 		};
 
-		pma8084_gpios: gpios@c000 {
+		pma8084_gpios: gpio@c000 {
 			compatible = "qcom,pma8084-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
-- 
2.34.1

