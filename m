Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3307E51A0B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350430AbiEDNXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350390AbiEDNXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:23:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B27C3B007
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:19:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dk23so2833561ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wtiS0vwUpWebphFXLVeTyRDTHsS+dMpyDeFB5sbVoPk=;
        b=WMcDqMBOQTWHQiHzKnK155CAcLbJFQiywJq2+OHBtLh2wtbdrvfmT+eVf/1qGi+8Gs
         VUocQGWrCexi0Npuo1PUCo1ievCEkGHVXhL79bjHLJ4Q9hp8ygEBznhKNqJbHdBeSAJ3
         boomwuB+OytFwgC3kGjWxyI3QKAJtNGcf9hYk2JqJLRvDj6bUMBBNV0VdNmI0r4WL5yf
         dL6OmTB/xuss+0C9ohEnqyT9FwMIy1vdU0SDxKK7iCawXoOVTmrP78pzdiutyXdmJDay
         TZ36Wix0WF1YbdqnBg5mmYnCBlifObmjldYNTL1EqN7lBNlMl1JYnM74RKnwmTpLmuFC
         56+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wtiS0vwUpWebphFXLVeTyRDTHsS+dMpyDeFB5sbVoPk=;
        b=ZJkdp5C+Sq8+CRiUC4V0mifYmBhGy8SAAWv0ISQx1yar44SNH+/kdLfYuXOmAexD1V
         234Orw5N433PXLI+6MebWjEyeGdOXn75SNTXU0grnqM0S+MPmatcdgmqeYHC5NpzJlh4
         M7V1IahAVPewgESXomoPXTmxusQY26TUYdnGcVuZETrppFYZxNeqq+lQGDW6z79WqFCX
         SDF7TkrMzqUw6NdPD7wAiuaKAjqrtgOhHhzIZHHceHBzmjZpKMoMNUMQiUM/BcUfU3Rm
         3fYkvbfZ6wqekkZOLz5RSHHkhzOu/GGLatVkmPRyoSmTZz3kU1QwM9EvyW7UeS3NIC72
         JTgg==
X-Gm-Message-State: AOAM532E1hqeTIae4YuBJkUHPjZCXfPbD/mEEPg4ZN9snoA/WHdCjv7P
        PKPsodZT1LuT/hF5+TtXInHyig==
X-Google-Smtp-Source: ABdhPJxpiNIp7y7Iq7FQeCbjSAWRjH6/GJCoUIDnG3RWGsD6Fl//cWVMX2EAziFaYhRTq1UePB4XLg==
X-Received: by 2002:a17:906:9749:b0:6ef:bc52:1f94 with SMTP id o9-20020a170906974900b006efbc521f94mr19947138ejy.666.1651670370844;
        Wed, 04 May 2022 06:19:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gx3-20020a1709068a4300b006f3ef214dc4sm5660924ejc.42.2022.05.04.06.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 06:19:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/13] dt-bindings: usb: qcom,dwc3: add IPQ8074, MSM8994, QCS404 and SM6125
Date:   Wed,  4 May 2022 15:19:13 +0200
Message-Id: <20220504131923.214367-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
References: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
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

Add compatibles for dedicated USB DWC3 blocks on Qualcomm IPQ8074,
MSM8994, QCS404 and SM6125.  They differ against other variants in clock
and/or interrupts.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index ce252db2aab3..03f93f25cba4 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -16,9 +16,12 @@ properties:
           - qcom,ipq4019-dwc3
           - qcom,ipq6018-dwc3
           - qcom,ipq8064-dwc3
+          - qcom,ipq8074-dwc3
           - qcom,msm8953-dwc3
+          - qcom,msm8994-dwc3
           - qcom,msm8996-dwc3
           - qcom,msm8998-dwc3
+          - qcom,qcs404-dwc3
           - qcom,sc7180-dwc3
           - qcom,sc7280-dwc3
           - qcom,sdm660-dwc3
@@ -26,6 +29,7 @@ properties:
           - qcom,sdx55-dwc3
           - qcom,sm4250-dwc3
           - qcom,sm6115-dwc3
+          - qcom,sm6125-dwc3
           - qcom,sm6350-dwc3
           - qcom,sm8150-dwc3
           - qcom,sm8250-dwc3
-- 
2.32.0

