Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38272527A45
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 23:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbiEOVBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 17:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiEOVBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 17:01:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93F1B4B1;
        Sun, 15 May 2022 14:00:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dk23so25243590ejb.8;
        Sun, 15 May 2022 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aCoys9+EB+DWbQTKp/pC9Oi+8WUMKWGset+R0a+3uFo=;
        b=gd1q++gP/CRc0Zv0w048Y9BeScIVKinFxwEfKHyqQpvQtZbygqNKvKxVVCSA/7wy7O
         E6k5miFxkbdBwbClJ2IAeZzamTkPe2AqKXFsuDiUli5WDVQWIufA69d0uCNwHHKqDdFt
         limgyj+ay3reYIgKIczIXlmg58NjXTzpEqJVVRVnq2er8cmuuXFUSEiPsl3QiyZMoDZz
         rLb1Tj8BVfR8SX0wct2NsImgP2bkGvBTsPUhVG4JuIoe+3Bd7Spa6ldDFuKHu4MDqy17
         mRPogKJ9yXWOduYU2TXXYVMqGVDr+U37fyO/s0Z1h6IARRmLVk+vMh66gg3ipC935pa1
         a2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCoys9+EB+DWbQTKp/pC9Oi+8WUMKWGset+R0a+3uFo=;
        b=12FqP5bgM3j48RW0kDKJ8kYNCdPJlM5bCdhztXteuPC+T7vyuHO5J7Z0H+lQ0iHzHo
         iIw+P6ydK6FPB5FGpOZpX6uMsUBJNOV8ZtGExBCI1TQ0DiRgXZXSoPhAE6uEKYx5J+do
         aCEh0I/HZpj/P2JMvq732CKExfvwczss3jHwnIi+Yu5GeSnWlsfG+AQHbhvB1vEB1VBy
         xWo7tAfdKi4Q+lMOv3lBQ6EOA6/3ge4G/RXM4ikC7hswzbGtHnN4NVTsvlkHKPMvg16t
         3kCJR2Qv+X2sAizZTBeP633d4E/vBmWP5wWF+h5tg1A6RCiZLi90kIA7m2VdyMVXfd2h
         NX3g==
X-Gm-Message-State: AOAM530A1azCe5GbHVzQAwGjH50biBWNAU5XtzdE0QQpjWq87IbXHMnC
        jxPFQEQvowXYAsdCa15rIus=
X-Google-Smtp-Source: ABdhPJzu8JgZy5rVo3d4JNcjwzDEPyAsKWr6dlSm03VSiAqXpD8zJfvcL0Lf6r29qLyRAHkL0e8Grw==
X-Received: by 2002:a17:906:f88f:b0:6f3:eaed:c143 with SMTP id lg15-20020a170906f88f00b006f3eaedc143mr12338224ejb.311.1652648458543;
        Sun, 15 May 2022 14:00:58 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id w12-20020aa7da4c000000b0042ab649183asm28917eds.35.2022.05.15.14.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 14:00:58 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 07/11] dt-bindings: clocks: qcom,gcc-ipq8074: support power domains
Date:   Sun, 15 May 2022 23:00:44 +0200
Message-Id: <20220515210048.483898-7-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515210048.483898-1-robimarko@gmail.com>
References: <20220515210048.483898-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC inside of IPQ8074 also provides power management via built-in GDSCs.
In order to do so, '#power-domain-cells' must be set to 1.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v4:
* Alphabetically sort the cells properties
---
 .../devicetree/bindings/clock/qcom,gcc-ipq8074.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
index 98572b4a9b60..21470f52ce36 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
@@ -24,6 +24,9 @@ properties:
   '#clock-cells':
     const: 1
 
+  '#power-domain-cells':
+    const: 1
+
   '#reset-cells':
     const: 1
 
@@ -38,6 +41,7 @@ required:
   - compatible
   - reg
   - '#clock-cells'
+  - '#power-domain-cells'
   - '#reset-cells'
 
 additionalProperties: false
@@ -48,6 +52,7 @@ examples:
       compatible = "qcom,gcc-ipq8074";
       reg = <0x01800000 0x80000>;
       #clock-cells = <1>;
+      #power-domain-cells = <1>;
       #reset-cells = <1>;
     };
 ...
-- 
2.36.1

