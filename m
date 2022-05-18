Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC8552C2C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241651AbiERSss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241593AbiERSse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:48:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E13229FE6;
        Wed, 18 May 2022 11:48:33 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m12so4157860edb.6;
        Wed, 18 May 2022 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/bRk6yZ7TTKW63rgTpD/DaAjQq9kemu00moaldOmuwc=;
        b=nGgnjjczvvuA8e3jB4G7lriTeVU7N+Ta7dQfDZgQQzkRz33szMmJ+CbnWtlUj68wgY
         996fw0dwu5f9gERsZwmFGOUhUbFLbIrnZ1bQK4dD2ttcweYFDKglTucDeFPqC5i8j7EL
         Cja8nKKLKM0zed4yIoG5S/vVeHhm/cReAqRkLlTOZQqg7KyzICHSj09jx+MRrLSnHVov
         J3+lExgp5K2paNhMyAilaSN6jchdna4TK624bNQT38S6BAiJiegqG+lo2gBGJrc2H0/i
         3ltr59wwqSEugKM/xZKIh3LT6O1ykpXZclqVqgalE8OUSSiqq3G2wwAExSBmR9ywyK59
         lujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bRk6yZ7TTKW63rgTpD/DaAjQq9kemu00moaldOmuwc=;
        b=owX2cKxiX4SFGwL5arSl8/LpC6QCiZfGDnMz0UT5z9b/VHJ/oC+7VTSkR2gO+7RhR4
         tg2R9YZFLBKJWaop5XCoVMnOhdEIc+l19o7SZAZVc7obV9qaq32eNpNaSFM70IYMe1qD
         Cnrp2LkeWRuzDwqkkbaWB9DoH8/UWquw/8+NiDUL0tVeB43oymCEBe9pWG0A2TVwHcM2
         K4Bg42AGWukKTPyYbrpLKYg0btQKsL6a28mh14WNihY6uEWt3pLsMD0zmnW1yD+KZiWF
         x8YkHx44Le6HgxQhHWCudMXeDN1QrtNf0I5G9DLmRsNxymCFei5MVHaiEg9H0hx/aMEf
         wO8Q==
X-Gm-Message-State: AOAM533TxsQ3AgqNuwPfZAW4s/ONoUl6NvIOkP4IURzvIUypaBThdCLs
        6SWbHAYhHgjWsfw0JaLS5zQ=
X-Google-Smtp-Source: ABdhPJx1a9OjQNYW2XasHF7v4XHYOr1uNMFfsmV/82Z/VJ18lx76+IgoR40xZu9KW9H2kWUqVLYxag==
X-Received: by 2002:a05:6402:5413:b0:42a:adef:b360 with SMTP id ev19-20020a056402541300b0042aadefb360mr1277694edb.122.1652899711495;
        Wed, 18 May 2022 11:48:31 -0700 (PDT)
Received: from fedora.robimarko.hr ([188.252.220.143])
        by smtp.googlemail.com with ESMTPSA id q18-20020aa7cc12000000b0042aa40e76cbsm1702662edt.80.2022.05.18.11.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:48:30 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@somainline.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 4/6] dt-bindings: regulator: qcom,spmi-regulator: add PMP8074 PMIC
Date:   Wed, 18 May 2022 20:48:23 +0200
Message-Id: <20220518184825.1034976-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518184825.1034976-1-robimarko@gmail.com>
References: <20220518184825.1034976-1-robimarko@gmail.com>
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

Document the PMP8074 PMIC compatible.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v4:
* Add remaining supplies

Changes in v3:
* Add supply matching
---
 .../bindings/regulator/qcom,spmi-regulator.yaml  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
index 2ca690e70eb2..81fcaba84fed 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
@@ -23,6 +23,7 @@ properties:
       - qcom,pm8950-regulators
       - qcom,pm8994-regulators
       - qcom,pmi8994-regulators
+      - qcom,pmp8074-regulators
       - qcom,pms405-regulators
 
   qcom,saw-reg:
@@ -276,6 +277,21 @@ allOf:
         vdd_l1-supply: true
       patternProperties:
         "^vdd_s[1-3]-supply$": true
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pmp8074-regulators
+    then:
+      properties:
+        vdd_l10_l11_l12_l13-supply: true
+        vdd_l1_l2-supply: true
+        vdd_l3_l8-supply: true
+        vdd_l5_l6_l15-supply: true
+      patternProperties:
+        "^vdd_l[479]-supply$": true
+        "^vdd_s[1-5]-supply$": true
   - if:
       properties:
         compatible:
-- 
2.36.1

