Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD10452D411
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbiESNbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbiESNa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:30:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5174CCEB8E;
        Thu, 19 May 2022 06:30:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eg11so6962673edb.11;
        Thu, 19 May 2022 06:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/bRk6yZ7TTKW63rgTpD/DaAjQq9kemu00moaldOmuwc=;
        b=XA6xTI5UWS5vhdJucLz3PGDo0x45WMIRi34jEDkUUoP0YrA4NchIbPf8EOZvSOO7fv
         PY+XOj+bT+wnFJULrBZ3UWCGpP3pBf/4wgRIXHFtR3xIPUZYQL5k1BpKd6a2doNTqNPh
         acSnonwQiL6utF6ZyOQUL8q7YZljps3gPpIMKvXAAlr6j2WmbxoUwynu3H6l00W1LefX
         Iw+w9bMoqjU7JbBCDPDgC87AKQzpyMBnJsuCkUB+FMpLrdbES+sFpCspaQ0NsXZAu8/p
         +XqpYDHYnCDud4ZO9fvp4nl/crQBkFZ/RmWp90BGmpNVjGFGRDjCCszPKyWcXAkL7eLr
         QWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bRk6yZ7TTKW63rgTpD/DaAjQq9kemu00moaldOmuwc=;
        b=Fu2jl2Zei0G39GPu7DvtI78JFdVARSrvwSsqwmu7ZHdp6IpclSTQG2z1I64lipCPee
         4y5ERMV6YQRLOxJg/zZyNbd0sfGYpdcrv8ElgaF17096Of15pC+khGIqeABJRwwmwgMZ
         od/mQhwmqRmTfsCWI+dNrncYnlVTfouFXZJD2M1ZCJM9xALR4eeqDtp76MZ2GpnDKEq+
         mwgVPxs+7rbFvEij6i/SloYTm0uSg+lrYwIIX4MNOn6jA3B01DcLkuWmbIaj+yqWOTDS
         YHresXZma57WG6huH5Fdigo5UsMK/iR5ThGjThldPogQIfnVMox5VmwRFU8HLBLwfJjS
         qFng==
X-Gm-Message-State: AOAM531uWteVRTY3/AOMvyFJcLINhbvpFA4v2yzfkQS/FPY2i14mugqi
        8RdaLv5l4NcmY05YHGYdcvg=
X-Google-Smtp-Source: ABdhPJytXn5jJz5AQCCCEZHkuqml5Wgst+DGSC6vNFOMIaIf5EALlJ1bJEywQoHcag67szesg58YLA==
X-Received: by 2002:a05:6402:174c:b0:42a:b4df:3aa7 with SMTP id v12-20020a056402174c00b0042ab4df3aa7mr5291386edx.263.1652967022809;
        Thu, 19 May 2022 06:30:22 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-71.zg.cable.xnet.hr. [94.253.165.71])
        by smtp.googlemail.com with ESMTPSA id y17-20020a17090614d100b006f3ef214dd4sm2120383ejc.58.2022.05.19.06.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:30:22 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@somainline.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 4/7] dt-bindings: regulator: qcom,spmi-regulator: add PMP8074 PMIC
Date:   Thu, 19 May 2022 15:30:12 +0200
Message-Id: <20220519133015.484639-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519133015.484639-1-robimarko@gmail.com>
References: <20220519133015.484639-1-robimarko@gmail.com>
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

