Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6732F4956DF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378192AbiATXUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378159AbiATXUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:20:37 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263ABC061574;
        Thu, 20 Jan 2022 15:20:37 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so17649823wms.3;
        Thu, 20 Jan 2022 15:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NqCTa9NPeJIZj8OJYmPeW7U5uohmgzf9QA184JG+m+o=;
        b=T7QgcwUm37r+BBCTIeRiF/awvjrCNxtIFhO6n6kcA2xo1onnJpTrWswW5v3Z+d3nvH
         rlCHwVkBZXQuRJKJRpzt+4y2dXsbaljqtC8GxxevPb+4lo0VE7rrHVOaCLwSF4ljpQE9
         EdbUlLwWkxAAKPymhiVd89cTZ3T7KTRJ0844hbHCUxQeRVTLVnD6qcqdgPijluVXi10Z
         N9IhBgMI+4BfAcuP6w/67mhKEtQ4bl5dXRzEBi8jBAhqWRRHYS6UuxhZ+ZKuTS4Ca+qA
         NSBeDnj2r8UW4RU4FGtW8SSZRWw+S3I0AHSJ0deX/SjcApne1daU3WQxCDu6Qx8t57YB
         Y43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqCTa9NPeJIZj8OJYmPeW7U5uohmgzf9QA184JG+m+o=;
        b=16SuuxQMm7I6Zn9Qz1MSNQbANdtfw3NOru0IYm3hk+70qKEeP83Paz6lLrTpVoNp7p
         KQmKuztWKR9NakhCV0lZxQ3axzgV4fyot7hzgHofLQpzcsHFrUm3jPswPvz+mzOrjRo0
         iH001RQukNXLr/kyD0/V9nYgiwpPpb5nEKn5r+jTMFo4BZi7L74ILFk3s0YvFc1XYecd
         tPvZUpOjdidN1bY+0kBu/3DUlVfJ3RiLh16GpsU39v63JfR6YLujo7FOQrHU2nrxSKNS
         5XLsRXT2A8H/mQmWilIQvkHfMM+x1borEzihomDMy+Xlm/ym4lDXRlpV+3gZkBSKaPHc
         03qg==
X-Gm-Message-State: AOAM530fze6cA2upJbfqhkAtEtRurVzZu8/9Dt9XFMDiCKuLnp8HTmzW
        LKrRha8Oks3h+yFvctTU9bo=
X-Google-Smtp-Source: ABdhPJy31IV3HCJP3tN1S1eF6mObbX7TSSd8e9QxOK89J11YROL/Jt1/8KYCtTOerGEo5V0cc5pJpA==
X-Received: by 2002:a5d:4742:: with SMTP id o2mr1244653wrs.346.1642720835621;
        Thu, 20 Jan 2022 15:20:35 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id a9sm3939283wmm.32.2022.01.20.15.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:20:35 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/15] dt-bindings: clock: Document qcom,gcc-ipq8064 binding
Date:   Fri, 21 Jan 2022 00:20:16 +0100
Message-Id: <20220120232028.6738-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120232028.6738-1-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document qcom,gcc-ipq8064 binding needed to declare pxo and cxo source
clocks. The gcc node is also used by the tsens driver, already documented,
to get the calib nvmem cells and the base reg from gcc.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/clock/qcom,gcc-ipq8064.yaml      | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
new file mode 100644
index 000000000000..abc76a46b2ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-ipq8064.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller Binding for IPQ8064
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  Qualcomm global clock control module which supports the clocks, resets and
+  power domains on IPQ8064.
+
+  See also:
+  - dt-bindings/clock/qcom,gcc-ipq806x.h
+  - dt-bindings/reset/qcom,gcc-ipq806x.h
+
+properties:
+  clocks:
+    items:
+      - description: PXO source
+      - description: CXO source
+
+  clock-names:
+    items:
+      - const: pxo
+      - const: cxo
+
+  thermal-sensor:
+    type: object
+
+    allOf:
+      - $ref: /schemas/thermal/qcom-tsens.yaml#
+
+required:
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gcc: clock-controller@900000 {
+      compatible = "qcom,gcc-ipq8064", "syscon";
+      reg = <0x00900000 0x4000>;
+      clocks = <&pxo_board>, <&cxo_board>;
+      clock-names = "pxo", "cxo";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+
+      tsens: thermal-sensor {
+        compatible = "qcom,ipq8064-tsens";
+
+        nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
+        nvmem-cell-names = "calib", "calib_backup";
+        interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "uplow";
+
+        #qcom,sensors = <11>;
+        #thermal-sensor-cells = <1>;
+      };
+    };
-- 
2.33.1

