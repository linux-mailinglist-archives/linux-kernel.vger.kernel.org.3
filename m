Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1C954238E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381708AbiFHAyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573472AbiFGXYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:24:07 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A70E3F5750
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:33:24 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id r14-20020a056830418e00b0060b8da9ff75so13781280otu.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 14:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c2pa9kTVClc9GM8SEP2eSVvEOfAh+uMGKJQT+mQ7f18=;
        b=P0JgSEX0aExjuD8JjXiylIViwyIE/q4VOGoZopmsGvjgaY0FH93cr7mW8sgEycBrtJ
         KEKnZtAL+Y79VkrRteiMCsC7o/hOhruN1ZpNhcDJIC8CP1UdTAA8xff2VQK1Vquto43m
         bv+5gpxQwFCoLUsoNZ5eIGRLOGl3GY2EVZZKv73tJI+Sp02467MzWfIuv7iKUEVhoMmt
         W8H0oaIo06PD++ATGNUS4N1zBQ5vMUZ7tXDHXj5v/gyRU9lcXzP/VQMXPZN+r5WDw4a0
         DybuGLdDDS/aIynWicn8VlrFnEKL68ct4vtnCsZ4QCGU1Q9wgjPpiOhQpC713pnAQH16
         4yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c2pa9kTVClc9GM8SEP2eSVvEOfAh+uMGKJQT+mQ7f18=;
        b=mEissoSksQiWZTPnKGrtPkP3HjbDL7yhh7/BbbMuR4482/qnY7lX1IUvu8XOxRzVs6
         7vbrDbu1zV9MN5kTewLBLb4Jxkq1LykNj2Co146sEyJV6YuHY/J6IBQD1m/8gv7c1z6Y
         3l5rgJ6TWhU3i/44vkZ6oCq/BuKzdN9zFejUsCvDnsaowd13h8wWGXG1SkGPkNKXqx/g
         RZc5zNRLIMEZNW/2ppsTVEbSQ31RG5U4k9xVNbwDVbvbcX3sfDbKPJMTxRafo1RxzYvi
         wZDMwS8HjGeKuqq9hVPDKh3E4gD6QLlkw8Rj7zxeqRoLZ+LPuTNVLA0BJESR8Dat7lKv
         oj/g==
X-Gm-Message-State: AOAM533DvMl20gjGLGVdgIHATpSqjJD7hqQAXUUwyb+W2CECrSppEFSg
        xUW6+FhRyweTolm0FYbr538XPg==
X-Google-Smtp-Source: ABdhPJwGGcqLNy/9H+HREP58pP7FwsnXmAgOi+oNaKxrQ7DtNcQQylItoluRT6B2fVQsmNe73HfJPA==
X-Received: by 2002:a05:6830:2aa1:b0:60b:ec44:c579 with SMTP id s33-20020a0568302aa100b0060bec44c579mr7983799otu.9.1654637600882;
        Tue, 07 Jun 2022 14:33:20 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id cd24-20020a056808319800b0032e7205619asm4966031oib.15.2022.06.07.14.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 14:33:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: phy: qcom,qmp: Add compatible for SC8280XP USB phys
Date:   Tue,  7 Jun 2022 14:35:39 -0700
Message-Id: <20220607213543.4057620-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220607213543.4057620-1-bjorn.andersson@linaro.org>
References: <20220607213543.4057620-1-bjorn.andersson@linaro.org>
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

The SC8280XP platform has a pair of 5nm USB3 UNI phys and a pair of
5nm USB4/3/DP combo PHYs, add a compatible for these.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Added compatible for selection of properties for the uni phy
- Added combo phy in the same patch

 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml         | 2 ++
 Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 8b850c5ab116..777bc1a48aa8 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -33,6 +33,7 @@ properties:
       - qcom,sc8180x-qmp-ufs-phy
       - qcom,sc8180x-qmp-usb3-phy
       - qcom,sc8280xp-qmp-ufs-phy
+      - qcom,sc8280xp-qmp-usb3-uni-phy
       - qcom,sdm845-qhp-pcie-phy
       - qcom,sdm845-qmp-pcie-phy
       - qcom,sdm845-qmp-ufs-phy
@@ -377,6 +378,7 @@ allOf:
               - qcom,sm8150-qmp-usb3-uni-phy
               - qcom,sm8250-qmp-usb3-uni-phy
               - qcom,sm8350-qmp-usb3-uni-phy
+              - qcom,sc8280xp-qmp-usb3-uni-phy
     then:
       properties:
         clocks:
diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
index 60dc27834e1d..32b1e5b67275 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
@@ -16,6 +16,7 @@ properties:
       - qcom,sc7180-qmp-usb3-dp-phy
       - qcom,sc7280-qmp-usb3-dp-phy
       - qcom,sc8180x-qmp-usb3-dp-phy
+      - qcom,sc8280xp-qmp-usb43dp-phy
       - qcom,sdm845-qmp-usb3-dp-phy
       - qcom,sm8250-qmp-usb3-dp-phy
   reg:
-- 
2.35.1

