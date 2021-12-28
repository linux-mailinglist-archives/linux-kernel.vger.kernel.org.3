Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE9E480B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbhL1Qjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:39:46 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49272
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236167AbhL1Qjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:39:41 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0612A3FFDF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640709580;
        bh=3/vCHuLU2olwZq+6aS9XDTfCwLrWAXWmzqRCmFjm31Q=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=d/itBfyKVw0ns7m3Ormj6ruqSuUrflgdKS7/pbLIOwEtTThftF0EjImBP4OdVe04e
         PTFInNk351DCuxFsXmqY6l/xxD+5KtTmMb2yf1IaT8PRssi+HKfai3hsF2ul3rhKfW
         6MaGLzTA6wYdvQH5AWEwHrL8EFTlY3B7Kj5aNE7nSlBXiC0NM9PCrwSJd+UbB9nwQV
         r2UeOPR+a7lGsp6wZT3OC4w7ALQOLgo3e960d0I/sCczUzvkpVrO9zQz6jvkQ6z2cj
         DsmVqUJurFxDcocE3Q1pd8l0/SFib+Q5sfHItc4LJocXsbvdthPuhfTSLGUwGmQy90
         94JDRmIIVWCJg==
Received: by mail-lj1-f199.google.com with SMTP id bn28-20020a05651c179c00b002222b4cc6d8so6210349ljb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3/vCHuLU2olwZq+6aS9XDTfCwLrWAXWmzqRCmFjm31Q=;
        b=Hux1vDCCpAGD5iIBVxPtTWSwVWfP7CaohHNNjm6daG3pp8PRiwlBLyEl9Zlq+vaino
         nA36kIDEOWlVz7JOj75Ot5aLtHHfz9pl+9dw/D+7tmRI7AL8Ne8eAoH5vjSvmqxltEPw
         OHH8O7BcKtrJsyauenjxZlbSJptloUfQU6epZqE5Ffj/fY2I8uqnCdOrF19ph/GxFCtK
         HvT+1t32dowpu+0O2QBbkR+2GOPJJyM3ymNWs1AWr2isPZKPTu458PRn86iIZMrDo64M
         ISucbr/TnyGDgnSjFJRwfwccdUqGV4WBkDadFss4/IOD7zp16tECY4y8o8WYBW/oTCr/
         s17g==
X-Gm-Message-State: AOAM533x6Kk+lc3eaCJsNCmeEjdBQs34CXZ9j2WLGhb5clnJ0/Lgt9rp
        vVCnAc7UFSMfzPTigU3ikT6kGyCJVdURHBSuntDd4Emx0e0oCfowYpI/OujAMlIPw2n93gp1xcK
        ZX2QGckss95C7Yeuat/GWuA36BV8/LyAFGa9PXh5xvA==
X-Received: by 2002:a05:6512:1286:: with SMTP id u6mr20850786lfs.342.1640709579413;
        Tue, 28 Dec 2021 08:39:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUIm63tQ1i2xPZhWNHW+jQYMkShWkPt/35yD+8djNtjXFgkoaNDLdZbKoC9UYgmfYxQoNdIw==
X-Received: by 2002:a05:6512:1286:: with SMTP id u6mr20850774lfs.342.1640709579251;
        Tue, 28 Dec 2021 08:39:39 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id d3sm1972876lfs.204.2021.12.28.08.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 08:39:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 3/4] regulator: dt-bindings: maxim,max77693: convert to dtschema
Date:   Tue, 28 Dec 2021 17:39:29 +0100
Message-Id: <20211228163930.35524-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211228163930.35524-1-krzysztof.kozlowski@canonical.com>
References: <20211228163930.35524-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the regulator bindings of Maxim MAX77693 MUIC to DT schema format.
The existing bindings were defined in ../bindings/mfd/max77693.txt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/regulator/maxim,max77693.yaml    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77693.yaml

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77693.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77693.yaml
new file mode 100644
index 000000000000..81242c8cd77c
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77693.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/maxim,max77693.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77693 MicroUSB and Companion Power Management IC regulators
+
+maintainers:
+  - Chanwoo Choi <cw00.choi@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77693 MicroUSB Integrated
+  Circuit (MUIC).
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max77693.yaml for
+  additional information and example.
+
+patternProperties:
+  "^ESAFEOUT[12]$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description: |
+      Safeout LDO regulator.
+
+    properties:
+      regulator-min-microvolt: true
+      regulator-max-microvolt: true
+
+    required:
+      - regulator-name
+
+  "^CHARGER$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description: |
+      Current regulator.
+
+    properties:
+      regulator-min-microamp: true
+      regulator-max-microamp: true
+
+    required:
+      - regulator-name
+
+additionalProperties: false
-- 
2.32.0

