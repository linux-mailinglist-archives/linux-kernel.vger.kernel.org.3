Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B393548B486
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344803AbiAKRvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:51:13 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54174
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344791AbiAKRvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:51:06 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D2F1F40A54
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923464;
        bh=0lTX/pRjq8fGrSEdb45cqNSVN0bzGZ2/ArUtBalm9jo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=dc8kKipck8+4Ul6U6wHkC5y1YngnUAMAzuqxUNHJkr88ssvS8TpeFOsUfSc1+HQoC
         Tqpr2JIq339rAuFnOnSmKvonVbjbxx4JV4B7nqEIYMimyWThQk6hGhoAmlAbiMlYeN
         q/VZIn+9N5aEG0xnG2O+8UNicHtzpxXNf0J1T/HBnW9uo7M+oKDWT8ugXc4Rkvdeu4
         KvEN2ARS1Vo4qCREwl58wkTEbF5Ge6tyqYv2F4HgybP7G3u3Wuxl55QSbfelytxSGj
         TI3S9hw72VFn8Vt97yaQ8pCUI8/sZZPWH7Sk/2TLnvrf4nX5WmvKVYyUTP3erEX6fM
         /EAyY56Y/j5Wg==
Received: by mail-ed1-f72.google.com with SMTP id z10-20020a05640235ca00b003f8efab3342so14008428edc.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lTX/pRjq8fGrSEdb45cqNSVN0bzGZ2/ArUtBalm9jo=;
        b=c1GVqRbqxtiu7jTnmCToqpuQY1jMCKh6JdXNG23XQP0DMU+rpvp7QY4Lp4Qw1ZBLyG
         BznHWF1IiWZyjnTsjL5MMLYz6s0D1aWya2LOzyd0mKc0NPi1nLPrdUiWAq9rKQLUyngt
         sD8s7RzvlIWChGyu3wSxGEo/Rjf1/WQMR48K7um+6ix1gCyhGc4z7ql2cEHhe0FNk68x
         kXzFdj6/RYUj70ahqTHkjYJ9CDYomKlYzYwgXk4PeZA1SAehh+5QMBcQtnRy+kegdiAD
         IW6E1LU0K/ze8c2GwuLfLntE0Hrb6zaynT5V9RIQhJhqFC1TpmTxup9haU7XQkCueRQf
         TIgQ==
X-Gm-Message-State: AOAM5305sxrnELLUP3Dl/6qozSbkgLS3qeOEkSC7D4kLpPsv0nelQbGW
        fz+cKPNjO4Kv54gAnUGqs59IEP0zOw9dvLNgVs5N/6JsyI1GTMOPI57Dk6ISmJmU4+8B4ziuv9d
        ks5Fouch/d+2y1dx3bBGMIwqINB2YF9dyzx9f2U3Qqg==
X-Received: by 2002:a17:906:7199:: with SMTP id h25mr4637459ejk.734.1641923461940;
        Tue, 11 Jan 2022 09:51:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1N007d3shEa8Ib3SDImdT17QSvZTGxNtwZXkqztluxz5huESUnu16sC4O6EqMG0YJnFlSOQ==
X-Received: by 2002:a17:906:7199:: with SMTP id h25mr4637445ejk.734.1641923461774;
        Tue, 11 Jan 2022 09:51:01 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p25sm5265160edw.75.2022.01.11.09.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:51:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 3/4] regulator: dt-bindings: maxim,max77693: convert to dtschema
Date:   Tue, 11 Jan 2022 18:50:16 +0100
Message-Id: <20220111175017.223966-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the regulator bindings of Maxim MAX77693 MUIC to DT schema format.
The existing bindings were defined in ../bindings/mfd/max77693.txt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/regulator/maxim,max77693.yaml    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77693.yaml

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77693.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77693.yaml
new file mode 100644
index 000000000000..20d8559bdc2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77693.yaml
@@ -0,0 +1,60 @@
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
+properties:
+  CHARGER:
+    type: object
+    $ref: regulator.yaml#
+    additionalProperties: false
+    description: |
+      Current regulator.
+
+    properties:
+      regulator-name: true
+      regulator-always-on: true
+      regulator-boot-on: true
+      regulator-min-microamp:
+        minimum: 60000
+      regulator-max-microamp:
+        maximum: 2580000
+
+    required:
+      - regulator-name
+
+patternProperties:
+  "^ESAFEOUT[12]$":
+    type: object
+    $ref: regulator.yaml#
+    additionalProperties: false
+    description: |
+      Safeout LDO regulator.
+
+    properties:
+      regulator-name: true
+      regulator-always-on: true
+      regulator-boot-on: true
+      regulator-min-microvolt:
+        minimum: 3300000
+      regulator-max-microvolt:
+        maximum: 4950000
+
+    required:
+      - regulator-name
+
+additionalProperties: false
-- 
2.32.0

