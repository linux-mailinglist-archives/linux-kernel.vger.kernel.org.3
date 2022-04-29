Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E1451581B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381362AbiD2WOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381365AbiD2WOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:14:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9679DCAA0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:11:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i5so12396524wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRvilvsMfYvzpgGyfnoWMji/FPTMosi+scCQBMvKmKE=;
        b=Bp09vc+lV8lUlvx0t4x1ZrCkcIeuFr5yleGjki0T5oIU2pItAW+8klYJwc9jYTuw5Q
         Mi7keXncbKKC/Q+pri7q9S5PEFWaKGWYnvcgkDQg0BS9K0Xc7ENe/PSMFknZ3+upUuVA
         NvctBi5P0ql9ffA6dvJnLIoZv9lVYQHRd2ctc8tKeeytcUIm/LsLGU5BoEgVh4ANgddJ
         iFbdYxF8cVIlluQkrPHZXzY8SFGWiePDu799WNBga0KvKPgrhVgoLC6L95eGwOwIII5x
         ZpLzLS5eIzHF/EgeZx9d9CSpxhzlBure6+39AOqFhhf0MxBT+4AWWVs8e4UdlQ4pWiGL
         oEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRvilvsMfYvzpgGyfnoWMji/FPTMosi+scCQBMvKmKE=;
        b=QF1Xn6llUabYpRRgldQLEJHbnK/bIKvZW8L/ga4P0pDG1QAj1Ks3FpquYNi+hj01yN
         Ra0TXGhaAzFSp8EGi60k6MvDZBprCJujjja09JktWiZahc/kEkRSIuXm7lBZuoVKpfCG
         AKhpMGgmMCUfJMheMpIublihh2D9Zn+IrVDJbSy3fSWhVPoqf0MkQUIFfYQKwLCUERVn
         FcoBUBp8DN7StXPjBeBZdaAdg7K8xYV0kKqezY48Bg04E19X2WbiPD6nyyOuaUK0Ge3k
         hNQ1mQBwSp6drb9V+7MkzDaDtMgjROl1sdL9NKlY6DMoWW2j9sfpmFr9bEeKgZrOGltM
         SPFw==
X-Gm-Message-State: AOAM5326s6+E9E6QhAyw2irqyaIOGLibvPold6ojWLiqEv8Fy0kGmvg0
        JXpS3nMt9zlTflyloqLrA+No+w==
X-Google-Smtp-Source: ABdhPJweCqiNSw8Vt+uZEnwgsH8w/AUxA6FecDr+zNvsHWQDe6YNHkp10ItpOBBuqsIJysmoB7ShBw==
X-Received: by 2002:a05:6000:1e16:b0:20c:5059:8dcb with SMTP id bj22-20020a0560001e1600b0020c50598dcbmr792824wrb.653.1651270259353;
        Fri, 29 Apr 2022 15:10:59 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a1cf307000000b003942a244ebfsm291985wmq.4.2022.04.29.15.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:10:58 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v14 04/10] dt-bindings: iio: adc: document qcom-spmi-rradc
Date:   Fri, 29 Apr 2022 23:08:59 +0100
Message-Id: <20220429220904.137297-5-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220429220904.137297-1-caleb.connolly@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding docs for the Qualcomm SPMI RRADC found in PMICs like
PMI8998 and PMI8994

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 .../bindings/iio/adc/qcom,spmi-rradc.yaml     | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
new file mode 100644
index 000000000000..c8cbfd3444be
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-rradc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's SPMI PMIC Round Robin ADC
+
+maintainers:
+  - Caleb Connolly <caleb.connolly@linaro.org>
+
+description: |
+  The Qualcomm SPMI Round Robin ADC (RRADC) provides interface to clients to
+  read the voltage, current and temperature for supported peripherals such as
+  the battery thermistor die temperature, charger temperature, USB and DC input
+  voltage / current and battery ID resistor.
+
+properties:
+  compatible:
+    enum:
+      - qcom,pmi8998-rradc
+      - qcom,pm660-rradc
+
+  reg:
+    maxItems: 1
+
+  qcom,batt-id-delay-ms:
+    description: Sets the hardware settling time for the battery ID resistor.
+    enum: [0, 1, 4, 12, 20, 40, 60, 80]
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic_rradc: adc@4500 {
+          compatible = "qcom,pmi8998-rradc";
+          reg = <0x4500>;
+          #io-channel-cells  = <1>;
+      };
+    };
-- 
2.36.0

