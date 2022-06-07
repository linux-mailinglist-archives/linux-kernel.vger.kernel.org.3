Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82B453FB60
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbiFGKeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241020AbiFGKd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:33:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5339660A9B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:33:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x5so17302469edi.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5684ZCuFKjUZf1A0V/l4v3S11bpO074EtOPdjGOIeIQ=;
        b=dqGPKn8pGEPvS5tOITYYmKsDfhlYWPf4Q+JzZxWkTVwa5a4XbcSgAz97lWJA0VKfDY
         gMsjn6pqWR+bcidwu3mbXMMo9CKClceT952dLUpVRWkrGaBKDJ1J52cOVDrI6Oh+0rPr
         cnpqpND4O7SwKeBH8HW5sneHsnEjodUsHAKWAZnOzyJ9AAUEsdAubRjRDOTTTQYzvRB1
         rK+TW7+k4Nl4E0oAGV90yz/rV2zEWmXO+7OvgXFu44TPLSjMT4naW/2FTDD1zf/ZquC9
         c7oECNbwKIYeS/0uiXt/FeYjBhUGhYb8PY+Mef6C1x/81IwGiM/Tek3P+HSATTU1tlfG
         bdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5684ZCuFKjUZf1A0V/l4v3S11bpO074EtOPdjGOIeIQ=;
        b=FtwQgIIrnZ8VPPH+TbLB6b4B0JF5kew31CUJa7R5ljaAOp1PU4xNK76TvVHGmwWiFE
         YSo2MTpH4S6JxfChG1fDuZ4IR/XOw7qESpleLTZX9QWMDGRcT2gt0RGjhOr1lN7R5Wlo
         GdktLsK8qgRZiS2F9ZvTfsWTnbirR59TD5pHb3jdN2gAmFrAXneM0K587wq9S+61yIru
         efp81qhL5OBloh1QKvLTiYWm2XICaZQ0hsKvLIW6nhflNNNiGermxYdm5IQ9vk2CkANj
         i66sQq2sY5ZIvrI8JojBjk8bhHu+/Yq1ngBpNY+T1DHqBfzOMuGaxb7KXf9TjAmC/Fe9
         /ytw==
X-Gm-Message-State: AOAM531tF0fJqPDG3/eX57zz9RjAeviiJixDOWHKpOfyCuINEU+iQo23
        XI38SU9N5LG55L8J1Cd6zoaZjQ==
X-Google-Smtp-Source: ABdhPJwSCDkpVwfygk6b6aG2ZX5Sr+tvZ+h7UtxCxDpPZ4x8PsNV2K7qP41tKSLqSb3NBhgg52tkDA==
X-Received: by 2002:a05:6402:1e93:b0:42d:d71d:cb60 with SMTP id f19-20020a0564021e9300b0042dd71dcb60mr33160867edf.399.1654598034841;
        Tue, 07 Jun 2022 03:33:54 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709065ac400b00704fa2748ffsm7505359ejs.99.2022.06.07.03.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 03:33:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 05/10] ARM: dts: qcom: ipq8064: add function to LED nodes
Date:   Tue,  7 Jun 2022 12:29:26 +0200
Message-Id: <20220607102931.102805-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607102931.102805-1-krzysztof.kozlowski@linaro.org>
References: <20220607102931.102805-1-krzysztof.kozlowski@linaro.org>
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

Add common LED property - the function - to LED nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
index 5c802b99e15f..7a28a0bfc4ee 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "qcom-ipq8064.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ8064-v1.0";
@@ -107,6 +108,7 @@ led@8 {
 
 			led@9 {
 				label = "status_led_fail";
+				function = LED_FUNCTION_STATUS;
 				gpios = <&qcom_pinmux 9 GPIO_ACTIVE_HIGH>;
 				default-state = "off";
 			};
@@ -119,6 +121,7 @@ led@26 {
 
 			led@53 {
 				label = "status_led_pass";
+				function = LED_FUNCTION_STATUS;
 				gpios = <&qcom_pinmux 53 GPIO_ACTIVE_HIGH>;
 				default-state = "off";
 			};
-- 
2.34.1

