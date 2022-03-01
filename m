Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B19D4C84FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiCAH00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiCAH0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:26:23 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5D37B558
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:25:40 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e13so12781959plh.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fof9CkST4Iez9KEZB3PYpToF0QIXsHNFmiNSAPmb4CE=;
        b=mS35quprXRkh3xYjAL9vHqcV+okVffowXCO7eIPZmmO8mjlTW9z4+UmHrXfb/88P6K
         eBV8WpjN/FKiz4UG3GthRrs5B5HWV+y46hjCKsmRfEV3w4+pj57JiDizjkSvq5MvCEdf
         y75x0qtUPc1hMp/+XZd/k5g0MaFaryzgaYqfeMnHM+4UVvgaLm89nfd7O5HkKBh7i2EI
         dkY7o/YCYFzLFLOgNDYr7sN9DCmw4+VxLesy8rBqnSom+K+oZhenB17nGLjv0wO4tJM0
         A3MvntKeydzDghlin+Zbt4QOoCD1S5vCuWJ+SLyLQHxImpewVndRsNNHwiakUlw23FRC
         eRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fof9CkST4Iez9KEZB3PYpToF0QIXsHNFmiNSAPmb4CE=;
        b=S/UJsxTik+dKfPwrokM9FVNgvr4XsvfIgIschmvGWt1HhVWPXFcTrBEZ22YpJVCDUZ
         XKpUG2/bLKWum4Asdl/Np/h8MD14ZR4TxpGb7u05wsNHZCp/vegOvINdfLwkFVeW5rx6
         NdP94tOKgwBIvMUeo5X2knoC4/yTE+zrowHQtIPpmPyfynG4MJzsbcFwIleJ7IP296qp
         6y6yUKc+ggNtPysdVnK5Nf2iM3S8PE3oI7xJGkGEQC0vB6jBaYn3o//nHejsJjzoGkT1
         bR6eNe4X6JDo+I+89LD6HyeiROVbs3yNo6QFW6/Ul5MxQVNTERy1RsGG9QxeBm/vKvFp
         l6Uw==
X-Gm-Message-State: AOAM53039KQf86GnSLh+HKI9xqV7gA6xnRmUANxPt4vdB1SbJlw1T/cl
        uGf+gmJ6mLiEkReilSw+ZcaY8A==
X-Google-Smtp-Source: ABdhPJz1k9zK//3L9NGXiXfzcJBZURlbeiRKF63jElIF2McavU/S1ImRohMnyQ6DtjmNrAbrUUErMQ==
X-Received: by 2002:a17:903:1cf:b0:14f:ea85:4be7 with SMTP id e15-20020a17090301cf00b0014fea854be7mr24268797plh.10.1646119540016;
        Mon, 28 Feb 2022 23:25:40 -0800 (PST)
Received: from localhost.localdomain ([223.179.136.225])
        by smtp.gmail.com with ESMTPSA id m6-20020a62f206000000b004e152bc0527sm15680445pfh.153.2022.02.28.23.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:25:39 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/7] dt-bindings: phy: qcom,qmp: Add SM8150 PCIe PHY bindings
Date:   Tue,  1 Mar 2022 12:55:06 +0530
Message-Id: <20220301072511.117818-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
References: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
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

Add the following two PCIe PHYs found on SM8150, to the QMP binding:

QMP GEN3x1 PHY - 1 lane
QMP GEN3x2 PHY - 2 lanes

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index e417cd667997..9e0f60e682c4 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -38,6 +38,8 @@ properties:
       - qcom,sdm845-qmp-usb3-phy
       - qcom,sdm845-qmp-usb3-uni-phy
       - qcom,sm6115-qmp-ufs-phy
+      - qcom,sm8150-qmp-gen3x1-pcie-phy
+      - qcom,sm8150-qmp-gen3x2-pcie-phy
       - qcom,sm8150-qmp-ufs-phy
       - qcom,sm8150-qmp-usb3-phy
       - qcom,sm8150-qmp-usb3-uni-phy
@@ -333,6 +335,8 @@ allOf:
               - qcom,sdm845-qhp-pcie-phy
               - qcom,sdm845-qmp-pcie-phy
               - qcom,sdx55-qmp-pcie-phy
+              - qcom,sm8150-qmp-gen3x1-pcie-phy
+              - qcom,sm8150-qmp-gen3x2-pcie-phy
               - qcom,sm8250-qmp-gen3x1-pcie-phy
               - qcom,sm8250-qmp-gen3x2-pcie-phy
               - qcom,sm8250-qmp-modem-pcie-phy
-- 
2.35.1

