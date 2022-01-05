Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70287485889
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243189AbiAESfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243015AbiAESeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:34:22 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58983C034002
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:34:21 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i22so84839629wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 10:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TbWlOa+hsmRbWWmesGbsstTW9dDTf4G9JG7ns6wKhLk=;
        b=p0se18mtV7Mr5KDg7WK7Co1vcQJUcS5OtLxHI9M9Txb0BIQ+ohVqE1HKn0fjb1fOz9
         dx2QJFYuo9+VASFRaMHoOz5WGaufcSsKYIKN8tW4AA1NJnS9rghL1Kzcu4QAfF2n2UO5
         cU6I0DLEd3En34OKH4TfwvZXA5BOLwQ5E25BTFf+Clib33f4BnRmSNB5q+0tKB44ZAce
         +OTXpA6hr5Tc7TlFz9cnWmZMtDUdJv4GjNh5ei67ryewYPeAfL5EsPd+oC2LRk0MHgpc
         v25Iek7GleTdgXphuW8LbdYh1Ewec6Hz77cXp+fYQ9OSdfNpL77DYqJQXwI/uK0wdQjO
         Hm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TbWlOa+hsmRbWWmesGbsstTW9dDTf4G9JG7ns6wKhLk=;
        b=5U1WmC2bxceXJwT8vGrHFe9HsMdyRwfOSfkN43b2YaN62qhLtdkh7zgb80kGOZS75q
         FKu1L2ZV+rHsgBxCeuD4DaYnqitt/6Unn+MPMCOLHZOgHpHYoJj4oCvWip1Ye91sKFQ8
         URCpdv/T8JUIyNZBfV4X4f0rBV2NrtpHHaHy32un2WQy/HP1SZTIdSVNaQ1kicuFe5Cc
         Q4f5bv3LBiEF/JqhjHpBcfM/1+nQFuo/p8YesyjLiK3G2ESBuSNIhdf3QstqWeSMJ6DA
         AGN5kFfDoMdb6wrYjSYE44+yUoXnTGE/3PxTLhwQIp505VZ/DJmH4rvE7xWjlIbNdOPd
         OPfg==
X-Gm-Message-State: AOAM532H0xGBtE9CyFfLY4umzndDYeo9V27LobiOZBoaNibAbHAVDUHz
        zNNoQW+vxB01JVfM/CVOchTOzw==
X-Google-Smtp-Source: ABdhPJxaXNmlPYPn7S3hoajQ5/O0EpkJSI/Js/N+6OqhGYgX4a0CCiaQc+FDNgI0qsGS37n1IFK7ug==
X-Received: by 2002:adf:bb89:: with SMTP id q9mr49213578wrg.337.1641407659946;
        Wed, 05 Jan 2022 10:34:19 -0800 (PST)
Received: from localhost.localdomain ([81.178.195.252])
        by smtp.gmail.com with ESMTPSA id o1sm3272215wmc.38.2022.01.05.10.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 10:34:19 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/7] dt-bindings: iio: adc: document qcom-spmi-rradc
Date:   Wed,  5 Jan 2022 18:33:48 +0000
Message-Id: <20220105183353.2505744-3-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105183353.2505744-1-caleb.connolly@linaro.org>
References: <20220105183353.2505744-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding docs for the Qualcomm SPMI RRADC found in PMICs like
PMI8998 and PMI8994

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/adc/qcom,spmi-rradc.yaml     | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
new file mode 100644
index 000000000000..11d47c46a48d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
@@ -0,0 +1,54 @@
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
+  The Qualcomm SPMI Round Robin ADC (RRADC) provides interface to clients to read the
+  voltage, current and temperature for supported peripherals such as the battery thermistor
+  die temperature, charger temperature, USB and DC input voltage / current and battery ID
+  resistor.
+
+properties:
+  compatible:
+    enum:
+      - qcom,pmi8998-rradc
+      - qcom,pm660-rradc
+
+  reg:
+    description: rradc base address and length in the SPMI PMIC register map
+    maxItems: 1
+
+  qcom,batt-id-delay-ms:
+    description:
+      Sets the hardware settling time for the battery ID resistor.
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
+...
-- 
2.34.1

