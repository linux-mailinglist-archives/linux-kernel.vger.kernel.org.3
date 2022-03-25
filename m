Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BD44E7D04
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiCYWXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 18:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiCYWXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 18:23:17 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C691A6E5B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:21:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id o8so7503761pgf.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3vmRl4RTZA1ebOc11ScV2HKDdeAKGMAJ/daw+x2KcQ=;
        b=zyvnDzNTGsjNjDOGddOUemBAo57KB2BS3T2ndrRhYN8eyQHwnq8JtL4uAQ28EBRATO
         KT6EwXHstLLWKSCYzy9AcSC9oNcrycpEONic/V1UeWXUk47mSURrI4kJhmv/CdVqi9vd
         LKlUkuV+lQULgZLl0/fRScY0obxSvaDPWKJyUFJuy7aB0QrX4hCsW6k5gRd0DCbienty
         IYzsGZ2yV5tqvlB9mx2itTqqoocNxq9kWe7AXxUe8zWGCKQj7mzxSHsbUKy7sVoGu69n
         MIAnvVl9xQ2HvwBWJJU0AaPURPgqhbcyPsdXHU4NYl4co/11wi96J25jZglmoCPgxMt/
         wk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3vmRl4RTZA1ebOc11ScV2HKDdeAKGMAJ/daw+x2KcQ=;
        b=J0lF48HZBlrCEJP+u2mrfK6QPiHIy3lJfocU+Xgn0C4LItiOnfwSnHi4N2Z0lIsj7C
         DQSDDWzODNoI2oH8QNtP2fa+jluc9sUjBMoIKZGCFMRu2O7Lx9ue1/YaK+8LGVwW4DOW
         p3o+qQcWhHHfhJhvZ1X6MhFkYTg0w/2s6paKWZu2eRUQIPMaRWBu8jYtgFsSZBhyZojW
         yWvrjqlKZkBnLjV3N8dCmEem/XRX+vMslZahmbHirF6YdDEi4OnumZQlpQMVmsrGFTwE
         UCp2czOTDQJS2pXqQCV8jtvFvZtJMNRUs15vGxy+wA1gjEkMdjMTNkWO3wKC35Sb8nfm
         E1Zg==
X-Gm-Message-State: AOAM532lTU7MbvFXpyFN+OEa1eNvZOA48Pn2HqSqpmjNI1fGcyrsC3Ys
        5bDaHgybll6VEbgSMck9UVkPDg==
X-Google-Smtp-Source: ABdhPJxupFWl3MwZ4NIjmAJD+vUgamnuHCiKYIaWNfeO9RTGcJSm3+BBrsxvmpsxnEAZu6r9toV8Fg==
X-Received: by 2002:a05:6a00:14d5:b0:4fb:2adf:dcdd with SMTP id w21-20020a056a0014d500b004fb2adfdcddmr829804pfu.72.1648246901516;
        Fri, 25 Mar 2022 15:21:41 -0700 (PDT)
Received: from localhost.localdomain ([223.233.78.42])
        by smtp.gmail.com with ESMTPSA id x16-20020a637c10000000b00380b351aaacsm6006490pgc.16.2022.03.25.15.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 15:21:41 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-phy@lists.infradead.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, bjorn.andersson@linaro.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: phy: qcom,qmp: Add SM8150 PCIe PHY bindings
Date:   Sat, 26 Mar 2022 03:51:29 +0530
Message-Id: <20220325222130.1783242-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325222130.1783242-1-bhupesh.sharma@linaro.org>
References: <20220325222130.1783242-1-bhupesh.sharma@linaro.org>
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

Add the following two PCIe PHYs found on SM8150, to the QMP binding:

QMP GEN3x1 PHY - 1 lane
QMP GEN3x2 PHY - 2 lanes

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index e20d9b087bb8..1e08acb8a59a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -39,6 +39,8 @@ properties:
       - qcom,sdm845-qmp-usb3-phy
       - qcom,sdm845-qmp-usb3-uni-phy
       - qcom,sm6115-qmp-ufs-phy
+      - qcom,sm8150-qmp-gen3x1-pcie-phy
+      - qcom,sm8150-qmp-gen3x2-pcie-phy
       - qcom,sm8150-qmp-ufs-phy
       - qcom,sm8150-qmp-usb3-phy
       - qcom,sm8150-qmp-usb3-uni-phy
@@ -336,6 +338,8 @@ allOf:
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

