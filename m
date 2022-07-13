Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D66573EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbiGMVVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbiGMVVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:21:22 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06A165B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:20:45 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w184so156681oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JSNOgX1qh7jhGjLbM6r9/+GLpFmurki5MvpbKU9Prwo=;
        b=kIrg/rcAm+vdfD+EhFDKva6EpHx37lp4NHF7nZi9BLbP1CYmSDXylGAMgWuJyPCbCT
         Ond1Pgk1zTrtci79E1vGQsbtvTYfI7GnGPOtbP7yp1dG0LSWu3m22/VvJf2xKpNKv7M1
         W1/hEue8aOGNG5kaHnoQFVHvh7atVYYY+d4ZaBgKSHOzo0A+SzI8MndlPbQrTpp5cUJt
         lxRgFK+yquXMPSlNtThka1S+JkbdiaexCs3xIZJZwpbXS2+xmNmTA7tTV9Bnky5mI9kP
         sAg+mazG1O4j5vIPMvRcbIRuqh5lITExfkNZTz5RcxUPZ3waRLG6er6vms3Qx8il9ZHk
         N0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JSNOgX1qh7jhGjLbM6r9/+GLpFmurki5MvpbKU9Prwo=;
        b=0Rn57omx7rVxp+qg+5qFK2NCNoeq7Y8nJ1KzkXdjnrwEq6MbnjuC2aKEs7ppA86YZ2
         wLvUgy9jWo+Q/t9J/VATVFTeWDZ/2wFM7LpzrHfePFdb+UX8lj/EYxkiKqficaNg7KHm
         4sBIGczOYTsdDE/MbfPvRVqUmYjLvL9Dp60LYON1asCPH7v3Y68SjMvXiW0WFEZQoXO/
         dk1HBsCShy/LgUm1L3huu4OeNFT9RtJcRPLoyto5vFtEuT8bFOF3Wi2NnL0xSKj3JWWd
         brydldmL6B4O4PjQoZ4073KvTD4mKno7aiZ/1Dd6xN8U+tDo4ChaBImaNrSXPwQ+SzuV
         YD6g==
X-Gm-Message-State: AJIora8lmQhXtquU7r4IscU1vlVjv2mBTkOzX1EUFN0MEoe8a08OaPpk
        U9DYrWVhi5MAUXEytPMUIF/2/7K5Faw+yA==
X-Google-Smtp-Source: AGRyM1t0ddgYG3I3aHAHy2c/m0NTsc9rq+mu62bVMF3BgnQw37sbezrjmiY4Q2bkXlW3w8LElj6RCA==
X-Received: by 2002:a05:6808:4cd:b0:339:fdbe:ea4d with SMTP id a13-20020a05680804cd00b00339fdbeea4dmr2909762oie.229.1657747245190;
        Wed, 13 Jul 2022 14:20:45 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i19-20020a056871029300b0010c17e6c699sm6647897oae.47.2022.07.13.14.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:20:44 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: dts: qcom: Add LPG node to pm8941
Date:   Wed, 13 Jul 2022 14:23:08 -0700
Message-Id: <20220713212309.130230-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713212309.130230-1-bjorn.andersson@linaro.org>
References: <20220713212309.130230-1-bjorn.andersson@linaro.org>
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

The PM8941 contains 8 LPG channels, as well as TRILED and LUT blocks.
Add a node for these.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Added #pwm-cells

 arch/arm/boot/dts/qcom-pm8941.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index a68634397938..59d0cde63251 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -144,6 +144,16 @@ pm8941_1: pm8941@1 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8941_lpg: lpg {
+			compatible = "qcom,pm8941-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+
 		pm8941_wled: wled@d800 {
 			compatible = "qcom,pm8941-wled";
 			reg = <0xd800>;
-- 
2.35.1

